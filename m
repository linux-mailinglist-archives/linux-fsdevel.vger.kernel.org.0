Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85EC4206
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJAUwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 16:52:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJAUwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:52:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91KmdUj026721;
        Tue, 1 Oct 2019 20:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=LSuVeD78YGQTVaM+QiDXfwCHERay2Z2fUzD7YJHLx24=;
 b=BKq6QhZEx+qWDpDJxOdPnDvNAQpsdJuV16ntvPqhTOzZH3URn9hS5KvTEwENjNydbtDF
 nvta0ioJhJ+206FjROnZFZzS36j8Ne8OLxHNhCuhP1mYohZd2Tn+XmS1HXeEdOk4/fCB
 mmG26frLdp9pfnXd39VJz2RzZ7AYwt0ibwixUMgSyzmJAV1BXpY3Qke+g44SNso3oKtv
 Oi8KNjPNxInSaIPQaedQJL93kSWgrvX1IVp1VT5Iz9Y6ALIvYndLToUNROuzZl+vnYkA
 CMqFMP0MgLSoujh0sT3o1WLqTrJOo4TNyu80fkWSaRhOEA/p7aSseeXIow/CeDETR4oi ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v9yfq8xkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 20:52:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91KnIiv084672;
        Tue, 1 Oct 2019 20:52:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vbqd1gwtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 20:52:29 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91KqPPP031464;
        Tue, 1 Oct 2019 20:52:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 13:52:25 -0700
Date:   Tue, 1 Oct 2019 13:52:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191001205224.GG13108@magnolia>
References: <20191001071152.24403-1-hch@lst.de>
 <20191001071152.24403-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001071152.24403-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010172
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:11:42AM +0200, Christoph Hellwig wrote:
> Lift the xfs code for tracing address space operations to the iomap
> layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c       |  7 +++++++
>  include/trace/events/iomap.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/trace/events/iomap.h
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..099daf0c09b8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -19,6 +19,9 @@
>  
>  #include "../internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/iomap.h>
> +

/me wonders if we really ought to be creating the tracepoints in
buffered-io.c, though I guess it does seem a little silly to have a
fs/iomap/trace.c just for these two lines...

--D

>  static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
> @@ -293,6 +296,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  	unsigned poff;
>  	loff_t ret;
>  
> +	trace_iomap_readpage(page->mapping->host, 1);
> +
>  	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
>  		ret = iomap_apply(inode, page_offset(page) + poff,
>  				PAGE_SIZE - poff, 0, ops, &ctx,
> @@ -389,6 +394,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
>  	loff_t length = last - pos + PAGE_SIZE, ret = 0;
>  
> +	trace_iomap_readpages(mapping->host, nr_pages);
> +
>  	while (length > 0) {
>  		ret = iomap_apply(mapping->host, pos, length, 0, ops,
>  				&ctx, iomap_readpages_actor);
> diff --git a/include/trace/events/iomap.h b/include/trace/events/iomap.h
> new file mode 100644
> index 000000000000..7d2fe2c773f3
> --- /dev/null
> +++ b/include/trace/events/iomap.h
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2009-2019, Christoph Hellwig
> + * All Rights Reserved.
> + *
> + * NOTE: none of these tracepoints shall be consider a stable kernel ABI
> + * as they can change at any time.
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM iomap
> +
> +#if !defined(_TRACE_IOMAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_IOMAP_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define DEFINE_READPAGE_EVENT(name)		\
> +DEFINE_EVENT(iomap_readpage_class, name,	\
> +	TP_PROTO(struct inode *inode, int nr_pages), \
> +	TP_ARGS(inode, nr_pages))
> +DEFINE_READPAGE_EVENT(iomap_readpage);
> +DEFINE_READPAGE_EVENT(iomap_readpages);
> +
> +#endif /* _TRACE_IOMAP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.20.1
> 
