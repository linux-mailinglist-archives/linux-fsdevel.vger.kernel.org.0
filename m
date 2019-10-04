Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA4CC6AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfJDXta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:49:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJDXt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:49:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x94NnDxe082716;
        Fri, 4 Oct 2019 23:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IcxXMeovERE0d70ewlhS0me9elSk50c+EiDcdQEsB8E=;
 b=UFDvUKKRkuhWrJdCMXE0opaFFhYzsoakE15EWja2D7rQaVjQXzMn3TgStnG3gs5yupVZ
 V+ptuBGlfiSba0HxNW9BovLKZTHMQHQ5svqgLONpiwR843K+geAOhfGswFDsGHJPO6tW
 X9u3KAjXx6ERJ63i5TXS0ISm4FpDTamtbN6YeMtgpITvApxBrSNPRT+Z7+ZLBgscfDUn
 wSBlAAKKHa6mXCnyo/JgF9V5TwaKTQ8Xw0+VDbV1v/fmO0lbjrPsVJHeoE/EQPNmpO2D
 dKlGsBnEO8tTDR4tTeJNcDckdd2WrSucc+1LRpQizQ+n3EHGqjUohTbQJGryv5+J3grf Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2va05sebfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 23:49:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x94Nm7JA158232;
        Fri, 4 Oct 2019 23:49:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vef24kaxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 23:49:09 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x94Nn2TR008367;
        Fri, 4 Oct 2019 23:49:02 GMT
Received: from localhost (/10.159.134.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 16:49:02 -0700
Date:   Fri, 4 Oct 2019 16:49:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191004234901.GP13108@magnolia>
References: <20191001071152.24403-1-hch@lst.de>
 <20191001071152.24403-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001071152.24403-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040201
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

...and I guess while we're bikeshedding over tracepoints, why not put
this in fs/iomap/trace.h ?  Do you anticipate anyone outside of iomap
needing to access the tracepoint declarations?

--D

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
