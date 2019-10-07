Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8ECE277
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJGNAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 09:00:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfJGNAF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:00:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CA1318C8911;
        Mon,  7 Oct 2019 13:00:04 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CBF55D9CC;
        Mon,  7 Oct 2019 13:00:02 +0000 (UTC)
Date:   Mon, 7 Oct 2019 09:00:00 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191007130000.GG22140@bfoster>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006154608.24738-2-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Mon, 07 Oct 2019 13:00:04 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 05:45:58PM +0200, Christoph Hellwig wrote:
> Lift the xfs code for tracing address space operations to the iomap
> layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

For the v7 version:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/Makefile      | 16 ++++++++------
>  fs/iomap/buffered-io.c |  5 +++++
>  fs/iomap/trace.h       | 49 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 7 deletions(-)
>  create mode 100644 fs/iomap/trace.h
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index 93cd11938bf5..eef2722d93a1 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -3,13 +3,15 @@
>  # Copyright (c) 2019 Oracle.
>  # All Rights Reserved.
>  #
> -obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
> -iomap-y				+= \
> -					apply.o \
> -					buffered-io.o \
> -					direct-io.o \
> -					fiemap.o \
> -					seek.o
> +ccflags-y += -I $(srctree)/$(src)		# needed for trace events
> +
> +obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
> +iomap-y				+= trace.o \
> +				   apply.o \
> +				   buffered-io.o \
> +				   direct-io.o \
> +				   fiemap.o \
> +				   seek.o
>  iomap-$(CONFIG_SWAP)		+= swapfile.o
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..fb209272765c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -16,6 +16,7 @@
>  #include <linux/bio.h>
>  #include <linux/sched/signal.h>
>  #include <linux/migrate.h>
> +#include "trace.h"
>  
>  #include "../internal.h"
>  
> @@ -293,6 +294,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  	unsigned poff;
>  	loff_t ret;
>  
> +	trace_iomap_readpage(page->mapping->host, 1);
> +
>  	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
>  		ret = iomap_apply(inode, page_offset(page) + poff,
>  				PAGE_SIZE - poff, 0, ops, &ctx,
> @@ -389,6 +392,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
>  	loff_t length = last - pos + PAGE_SIZE, ret = 0;
>  
> +	trace_iomap_readpages(mapping->host, nr_pages);
> +
>  	while (length > 0) {
>  		ret = iomap_apply(mapping->host, pos, length, 0, ops,
>  				&ctx, iomap_readpages_actor);
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> new file mode 100644
> index 000000000000..7798aeda7fb9
> --- /dev/null
> +++ b/fs/iomap/trace.h
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2009-2019, Christoph Hellwig
> + *
> + * NOTE: none of these tracepoints shall be consider a stable kernel ABI
> + * as they can change at any time.
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM iomap
> +
> +#if !defined(_IOMAP_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _IOMAP_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct inode;
> +
> +DECLARE_EVENT_CLASS(iomap_readpage_class,
> +	TP_PROTO(struct inode *inode, int nr_pages),
> +	TP_ARGS(inode, nr_pages),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(u64, ino)
> +		__field(int, nr_pages)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->ino = inode->i_ino;
> +		__entry->nr_pages = nr_pages;
> +	),
> +	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino,
> +		  __entry->nr_pages)
> +)
> +
> +#define DEFINE_READPAGE_EVENT(name)		\
> +DEFINE_EVENT(iomap_readpage_class, name,	\
> +	TP_PROTO(struct inode *inode, int nr_pages), \
> +	TP_ARGS(inode, nr_pages))
> +DEFINE_READPAGE_EVENT(iomap_readpage);
> +DEFINE_READPAGE_EVENT(iomap_readpages);
> +
> +#endif /* _IOMAP_TRACE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE trace
> +#include <trace/define_trace.h>
> -- 
> 2.20.1
> 
