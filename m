Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2223E8743
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhHKAbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 20:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhHKAbl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D366860EB9;
        Wed, 11 Aug 2021 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628641878;
        bh=gBI34d3C+kxYXbvJ/grq+YaqzvQXqhA5HY0T+jbkLgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKze7mBDFVcCSar0LHAm8ewmyshJaDLeBhF8/Ch7M1p2CiB5A86HFpOKW7lMfCCtS
         qbqdyDNoVm2l2MyhtFhuFTpa8lLdHU2XUPJZWL3YlI18vxr9dMB7Nxk+BGhN2ZqFRl
         x+Ev9SNarHvCGvuMpffGjjDo7TsCzN3cdPieEzfUgtrQRfbQCNA1jrO8vvvsFvUyMu
         i0pqXLZfDUmAYCUo2NWe1qNhTJWnoxXGUwLUUjxytKPrtoPDZEt8mjlKfNIWI321AF
         66F+4eFE9SivNFNmWthiaeVBFu9FNOJog8hRII4rQuxemw2km1vFjX0tGySEVss+lX
         TAHBnfJeaAF2A==
Date:   Tue, 10 Aug 2021 17:31:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 11/30] iomap: add the new iomap_iter model
Message-ID: <20210811003118.GT3601466@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:25AM +0200, Christoph Hellwig wrote:
> The iomap_iter struct provides a convenient way to package up and
> maintain all the arguments to the various mapping and operation
> functions.  It is operated on using the iomap_iter() function that
> is called in loop until the whole range has been processed.  Compared
> to the existing iomap_apply() function this avoid an indirect call
> for each iteration.
> 
> For now iomap_iter() calls back into the existing ->iomap_begin and
> ->iomap_end methods, but in the future this could be further optimized
> to avoid indirect calls entirely.
> 
> Based on an earlier patch from Matthew Wilcox <willy@infradead.org>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/Makefile     |  1 +
>  fs/iomap/core.c       | 79 +++++++++++++++++++++++++++++++++++++++++++
>  fs/iomap/trace.h      | 37 +++++++++++++++++++-
>  include/linux/iomap.h | 56 ++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 fs/iomap/core.c
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index eef2722d93a183..6b56b10ded347a 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
>  iomap-y				+= trace.o \
>  				   apply.o \
> +				   core.o \
>  				   buffered-io.o \
>  				   direct-io.o \
>  				   fiemap.o \
> diff --git a/fs/iomap/core.c b/fs/iomap/core.c
> new file mode 100644
> index 00000000000000..89a87a1654e8e6
> --- /dev/null
> +++ b/fs/iomap/core.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Christoph Hellwig.
> + */
> +#include <linux/fs.h>
> +#include <linux/iomap.h>
> +#include "trace.h"
> +
> +static inline int iomap_iter_advance(struct iomap_iter *iter)
> +{
> +	/* handle the previous iteration (if any) */
> +	if (iter->iomap.length) {
> +		if (iter->processed <= 0)
> +			return iter->processed;
> +		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
> +			return -EIO;
> +		iter->pos += iter->processed;
> +		iter->len -= iter->processed;
> +		if (!iter->len)
> +			return 0;
> +	}
> +
> +	/* clear the state for the next iteration */
> +	iter->processed = 0;
> +	memset(&iter->iomap, 0, sizeof(iter->iomap));
> +	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> +	return 1;
> +}
> +
> +static inline void iomap_iter_done(struct iomap_iter *iter)

I wonder why this is a separate function, since it only has debugging
warnings and tracepoints?

> +{
> +	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> +	WARN_ON_ONCE(iter->iomap.length == 0);
> +	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
> +
> +	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
> +	if (iter->srcmap.type != IOMAP_HOLE)
> +		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
> +}
> +
> +/**
> + * iomap_iter - iterate over a ranges in a file
> + * @iter: iteration structue
> + * @ops: iomap ops provided by the file system
> + *
> + * Iterate over filesystem-provided space mappings for the provided file range.
> + *
> + * This function handles cleanup of resources acquired for iteration when the
> + * filesystem indicates there are no more space mappings, which means that this
> + * function must be called in a loop that continues as long it returns a
> + * positive value.  If 0 or a negative value is returned, the caller must not
> + * return to the loop body.  Within a loop body, there are two ways to break out
> + * of the loop body:  leave @iter.processed unchanged, or set it to a negative
> + * errno.

Thanks for improving the documentation.

Modulo the question about iomap_iter_done, I guess this looks all right
to me.  As far as apply.c vs. core.c, I'm not wildly passionate about
either naming choice (I would have called it iter.c) but ... fmeh.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> + */
> +int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> +{
> +	int ret;
> +
> +	if (iter->iomap.length && ops->iomap_end) {
> +		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
> +				iter->processed > 0 ? iter->processed : 0,
> +				iter->flags, &iter->iomap);
> +		if (ret < 0 && !iter->processed)
> +			return ret;
> +	}
> +
> +	trace_iomap_iter(iter, ops, _RET_IP_);
> +	ret = iomap_iter_advance(iter);
> +	if (ret <= 0)
> +		return ret;
> +
> +	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
> +			       &iter->iomap, &iter->srcmap);
> +	if (ret < 0)
> +		return ret;
> +	iomap_iter_done(iter);
> +	return 1;
> +}
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index e9cd5cc0d6ba40..1012d7af6b689b 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (c) 2009-2019 Christoph Hellwig
> + * Copyright (c) 2009-2021 Christoph Hellwig
>   *
>   * NOTE: none of these tracepoints shall be considered a stable kernel ABI
>   * as they can change at any time.
> @@ -140,6 +140,8 @@ DEFINE_EVENT(iomap_class, name,	\
>  	TP_ARGS(inode, iomap))
>  DEFINE_IOMAP_EVENT(iomap_apply_dstmap);
>  DEFINE_IOMAP_EVENT(iomap_apply_srcmap);
> +DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
> +DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
>  
>  TRACE_EVENT(iomap_apply,
>  	TP_PROTO(struct inode *inode, loff_t pos, loff_t length,
> @@ -179,6 +181,39 @@ TRACE_EVENT(iomap_apply,
>  		   __entry->actor)
>  );
>  
> +TRACE_EVENT(iomap_iter,
> +	TP_PROTO(struct iomap_iter *iter, const void *ops,
> +		 unsigned long caller),
> +	TP_ARGS(iter, ops, caller),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(u64, ino)
> +		__field(loff_t, pos)
> +		__field(loff_t, length)
> +		__field(unsigned int, flags)
> +		__field(const void *, ops)
> +		__field(unsigned long, caller)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = iter->inode->i_sb->s_dev;
> +		__entry->ino = iter->inode->i_ino;
> +		__entry->pos = iter->pos;
> +		__entry->length = iomap_length(iter);
> +		__entry->flags = iter->flags;
> +		__entry->ops = ops;
> +		__entry->caller = caller;
> +	),
> +	TP_printk("dev %d:%d ino 0x%llx pos %lld length %lld flags %s (0x%x) ops %ps caller %pS",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		   __entry->ino,
> +		   __entry->pos,
> +		   __entry->length,
> +		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
> +		   __entry->flags,
> +		   __entry->ops,
> +		   (void *)__entry->caller)
> +);
> +
>  #endif /* _IOMAP_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 76bfc5d16ef49d..aac4176ea16439 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -161,6 +161,62 @@ struct iomap_ops {
>  			ssize_t written, unsigned flags, struct iomap *iomap);
>  };
>  
> +/**
> + * struct iomap_iter - Iterate through a range of a file
> + * @inode: Set at the start of the iteration and should not change.
> + * @pos: The current file position we are operating on.  It is updated by
> + *	calls to iomap_iter().  Treat as read-only in the body.
> + * @len: The remaining length of the file segment we're operating on.
> + *	It is updated at the same time as @pos.
> + * @processed: The number of bytes processed by the body in the most recent
> + *	iteration, or a negative errno. 0 causes the iteration to stop.
> + * @flags: Zero or more of the iomap_begin flags above.
> + * @iomap: Map describing the I/O iteration
> + * @srcmap: Source map for COW operations
> + */
> +struct iomap_iter {
> +	struct inode *inode;
> +	loff_t pos;
> +	u64 len;
> +	s64 processed;
> +	unsigned flags;
> +	struct iomap iomap;
> +	struct iomap srcmap;
> +};
> +
> +int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> +
> +/**
> + * iomap_length - length of the current iomap iteration
> + * @iter: iteration structure
> + *
> + * Returns the length that the operation applies to for the current iteration.
> + */
> +static inline u64 iomap_length(const struct iomap_iter *iter)
> +{
> +	u64 end = iter->iomap.offset + iter->iomap.length;
> +
> +	if (iter->srcmap.type != IOMAP_HOLE)
> +		end = min(end, iter->srcmap.offset + iter->srcmap.length);
> +	return min(iter->len, end - iter->pos);
> +}
> +
> +/**
> + * iomap_iter_srcmap - return the source map for the current iomap iteration
> + * @i: iteration structure
> + *
> + * Write operations on file systems with reflink support might require a
> + * source and a destination map.  This function retourns the source map
> + * for a given operation, which may or may no be identical to the destination
> + * map in &i->iomap.
> + */
> +static inline struct iomap *iomap_iter_srcmap(struct iomap_iter *i)
> +{
> +	if (i->srcmap.type != IOMAP_HOLE)
> +		return &i->srcmap;
> +	return &i->iomap;
> +}
> +
>  /*
>   * Main iomap iterator function.
>   */
> -- 
> 2.30.2
> 
