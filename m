Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF8D7E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbfJOSIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:08:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:08:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmZVC085408;
        Tue, 15 Oct 2019 18:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tffcv5R344QUSZsjEYxRMACURvQ25ud8isc745HmEUk=;
 b=iJuUfJFpOQECw4zViTjMbajpDf5ldW/jOzmcLO1jrmGIPHTWWbK+KGMhziBz4uKZ6gy+
 yvZqLwmHZKuqpwi6ZbHjSJX/hE+rlmHptl466dumCsG1FTvbkPW6+0Tsu/iIYdGlZmNl
 BOImKgTO7gBhHf9vnPRZ82zKGJ6zu3yqg69MvZEV6omibatSWf4BliU5bLZLxntjMl9Y
 JpY0CuPvAoGGnqldnOttqdxEcnifGJHHKkjWh7QYfdGJKQqU2R3+yQRwBf8/y6nnOn5+
 mL/cLSbCibRBIVNh/RdlKzkQToob79LHjTSwfVj7hLw3+tetKwn2fUOysIXImoeU56/D 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vk7fr9qjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:08:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmLp8059866;
        Tue, 15 Oct 2019 18:06:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vnb0fm8uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:06:17 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FI6Fbc024969;
        Tue, 15 Oct 2019 18:06:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 11:06:15 -0700
Date:   Tue, 15 Oct 2019 11:06:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iomap: lift the xfs readpage / readpages tracing
 to iomap
Message-ID: <20191015180613.GT13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-9-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:41PM +0200, Christoph Hellwig wrote:
> Lift the xfs code for tracing address space operations to the iomap
> layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/Makefile      | 16 ++++++++------
>  fs/iomap/buffered-io.c |  5 +++++
>  fs/iomap/trace.c       | 12 +++++++++++
>  fs/iomap/trace.h       | 49 ++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_aops.c      |  2 --
>  fs/xfs/xfs_trace.h     | 26 ----------------------
>  6 files changed, 75 insertions(+), 35 deletions(-)
>  create mode 100644 fs/iomap/trace.c
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
> index 181ee8477aad..d1620c3f2a4c 100644
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
> @@ -301,6 +302,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  	unsigned poff;
>  	loff_t ret;
>  
> +	trace_iomap_readpage(page->mapping->host, 1);
> +
>  	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
>  		ret = iomap_apply(inode, page_offset(page) + poff,
>  				PAGE_SIZE - poff, 0, ops, &ctx,
> @@ -397,6 +400,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
>  	loff_t length = last - pos + PAGE_SIZE, ret = 0;
>  
> +	trace_iomap_readpages(mapping->host, nr_pages);
> +
>  	while (length > 0) {
>  		ret = iomap_apply(mapping->host, pos, length, 0, ops,
>  				&ctx, iomap_readpages_actor);
> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
> new file mode 100644
> index 000000000000..63ce9f0ce4dc
> --- /dev/null
> +++ b/fs/iomap/trace.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Christoph Hellwig
> + */
> +#include <linux/iomap.h>
> +
> +/*
> + * We include this last to have the helpers above available for the trace
> + * event implementations.
> + */
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> new file mode 100644
> index 000000000000..3900de1d871d
> --- /dev/null
> +++ b/fs/iomap/trace.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
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
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 00fe40b35f72..e2033b070f4a 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1184,7 +1184,6 @@ xfs_vm_readpage(
>  	struct file		*unused,
>  	struct page		*page)
>  {
> -	trace_xfs_vm_readpage(page->mapping->host, 1);
>  	return iomap_readpage(page, &xfs_iomap_ops);
>  }
>  
> @@ -1195,7 +1194,6 @@ xfs_vm_readpages(
>  	struct list_head	*pages,
>  	unsigned		nr_pages)
>  {
> -	trace_xfs_vm_readpages(mapping->host, nr_pages);
>  	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index eaae275ed430..eae4b29c174e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1197,32 +1197,6 @@ DEFINE_PAGE_EVENT(xfs_writepage);
>  DEFINE_PAGE_EVENT(xfs_releasepage);
>  DEFINE_PAGE_EVENT(xfs_invalidatepage);
>  
> -DECLARE_EVENT_CLASS(xfs_readpage_class,
> -	TP_PROTO(struct inode *inode, int nr_pages),
> -	TP_ARGS(inode, nr_pages),
> -	TP_STRUCT__entry(
> -		__field(dev_t, dev)
> -		__field(xfs_ino_t, ino)
> -		__field(int, nr_pages)
> -	),
> -	TP_fast_assign(
> -		__entry->dev = inode->i_sb->s_dev;
> -		__entry->ino = inode->i_ino;
> -		__entry->nr_pages = nr_pages;
> -	),
> -	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->ino,
> -		  __entry->nr_pages)
> -)
> -
> -#define DEFINE_READPAGE_EVENT(name)		\
> -DEFINE_EVENT(xfs_readpage_class, name,	\
> -	TP_PROTO(struct inode *inode, int nr_pages), \
> -	TP_ARGS(inode, nr_pages))
> -DEFINE_READPAGE_EVENT(xfs_vm_readpage);
> -DEFINE_READPAGE_EVENT(xfs_vm_readpages);
> -
>  DECLARE_EVENT_CLASS(xfs_imap_class,
>  	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
>  		 int whichfork, struct xfs_bmbt_irec *irec),
> -- 
> 2.20.1
> 
