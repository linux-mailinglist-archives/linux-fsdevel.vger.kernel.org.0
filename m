Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA9CD98A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 00:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJFWnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 18:43:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50526 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJFWnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:43:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96Merul167330;
        Sun, 6 Oct 2019 22:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bGddxjEib4KbJcsUY126kbXQ6TkNosjdGAqOwH5tyhQ=;
 b=oRgtsZvuPebpPpdDNGQMJTZfX741ICk0s8Ab0kHmamkCd6YPcrtqXqqHdSZoHsbEJbn9
 4Uij0v4u288cMhsQxNPcE0HmIEPEdbUuzSKkDV4XJDe0s/65f8QtDNzeVMP/dhLxDvmp
 5tboPWC2JKxHsCkaUPoFT36e0oj2o8HoOhBfLK1JC0Faglb3WNkWUjrn9zIgLJa7cYqc
 VX3NRFd3mkajL+h0qG/kXNFwo3hL9DohxlneDqDke0p7JPSOf2LDEYqqWokieMn+6ClP
 JFHfpaYQNlCTKMV1810tOjmni3W3ZhgYG0hn03WcH7FQpBX1t/H/SNX3Mydll+shzWHz DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4q3wft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 22:43:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x96MhdHq114933;
        Sun, 6 Oct 2019 22:43:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vf5b04vj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Oct 2019 22:43:41 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x96MhNPH010160;
        Sun, 6 Oct 2019 22:43:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Oct 2019 15:43:22 -0700
Date:   Sun, 6 Oct 2019 15:43:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191006224324.GR13108@magnolia>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006154608.24738-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910060234
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910060233
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

I think this patch is missing fs/iomap/trace.c ?

--D

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
