Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB03CE715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbhGSQUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352822AbhGSQPV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F46960E0C;
        Mon, 19 Jul 2021 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626713760;
        bh=DfRnT5y0id7pZf/hBiHUkDnGPfAQFz+iA7+ps6oy2S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmiVc0VAZw52T6x8VpkCMLVF0xHnmv3PHwKyjOG7A2Cgh5KDQz94QAU+7wN6FBg37
         zG0lUvKGIn5lNTyi44buzs2ubLuX3EDwZVeb1R6kYBwYmxOirWm2DRM8eyBukW5HSV
         D2evYICHVJqZWHgFK5A6EBIWlJHmYC9zdCF0eal2Y23IHhECSQ9oglx2y9PVr7GOBf
         TOL/donlPB7qMYh9GFDeaJ8mkkdNTQV3i8cW2IaJ4oBSFZTA+atPVqpiazVJrEI0jT
         HdKA5HNnxAFnKNpQKv7bbMZzt9IWotptqQgYtpkOp2MGY/2LArhQbPRdRTDiH/TqaU
         aXk8SmIaJY8Uw==
Date:   Mon, 19 Jul 2021 09:56:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 08/27] iomap: add the new iomap_iter model
Message-ID: <20210719165600.GG23236@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:01PM +0200, Christoph Hellwig wrote:
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
>  fs/iomap/iter.c       | 74 +++++++++++++++++++++++++++++++++++++++++++
>  fs/iomap/trace.h      | 37 +++++++++++++++++++++-
>  include/linux/iomap.h | 56 ++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 fs/iomap/iter.c
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index eef2722d93a183..85034deb5a2f19 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
>  iomap-y				+= trace.o \
>  				   apply.o \
> +				   iter.o \
>  				   buffered-io.o \
>  				   direct-io.o \
>  				   fiemap.o \
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> new file mode 100644
> index 00000000000000..b21e2489700b7c
> --- /dev/null
> +++ b/fs/iomap/iter.c
> @@ -0,0 +1,74 @@
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

Hmm, converting ssize_t to int here... I suppose that's fine since we're
merely returning "the usual negative errno code", but read on.

> +		WARN_ON_ONCE(iter->processed > iomap_length(iter));
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
> + * Iterate over file system provided contiguous ranges of blocks with the same
> + * state.  Should be called in a loop that continues as long as this function
> + * returns a positive value.  If 0 or a negative value is returned the caller
> + * should break out of the loop - a negative value is an error either from the
> + * file system or from the last iteration stored in @iter.copied.
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

<snip out macro hell>

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f9c36df6a3061b..a9f3f736017989 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -143,6 +143,62 @@ struct iomap_ops {
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
> +	ssize_t processed;

I looked a the SEEK_HOLE/SEEK_DATA conversion a few patches ahead, and
noticed that it does things like:

	iter.processed = iomap_seek_hole_iter(&iter, &offset);

where iomap_seek_hole_iter returns a loff_t.  This will not do the right
thing handling large extents on 32-bit architectures because ssize_t
will a 32-bit signed int whereas loff_t is always a 64-bit signed int.

Linus previously complained to me about filesystem code (especially
iomap since it was "newer") (ab)using loff_t variables to store the
lengths of byte ranges.  It was "loff_t length;" (or so willy
recollects) that tripped him up.

ISTR he also said we should use size_t for all lengths because nobody
should do operations larger than ~2G, but I reject that because iomap
has users that iterate large ranges of data without generating any IO
(e.g. fiemap, seek, swapfile activation).

So... rather than confusing things even more by mixing u64 and ssize_t
for lengths, can we introduce a new 64-bit length typedef for iomap?
Last summer, Dave suggested[1] something like:

	typedef long long lsize_t;

That would enable cleanup of all the count/size/length parameters in
fs/remap_range.c and fs/xfs/xfs_reflink.c to use the new 64-bit length
type, since those operations have never been limited to 32-bit sizes.

--D

[1] https://lore.kernel.org/linux-xfs/20200825042711.GL12131@dread.disaster.area/

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
