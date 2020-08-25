Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA96252227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYUsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 16:48:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:48:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKiciB156095;
        Tue, 25 Aug 2020 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cxlyUwt13zo7dYYZPBBHib691Icpcqbd97TLEtnQSm0=;
 b=b1DOERxbKhp7D/quegWiCdYCHOVZteyvBuLWE5fzf7gAcqS/VAQWMVOumrHcQHfdFDw4
 8T3gqWcOAJo3DdSi6Wa6qRnJoykAW1xxvMr/drTuusErp5CgHtGj25mn2UNom2CyPdrd
 5vqhXqj+iJmYvHf6JFAcKSnUhQw54BQOVPr6OuengTRTax++/gncr2ahKqzseP4MMM+1
 Ul3NG/ADRMCSuTmpRUI8U0VmmwQNpo8GNio/SC1RgzTKtoXZMRB8GO/A9da/QgJP5Lby
 RIjxoqz30aVJQuZx0BZFkLHpXwb6uY40lytfzQXiA3sLoWkW2Vlai+VYzA/ZSPZJvHck WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333csj4wtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 20:47:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKjJH4034335;
        Tue, 25 Aug 2020 20:47:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9k240j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 20:47:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PKlt9I005311;
        Tue, 25 Aug 2020 20:47:55 GMT
Received: from localhost (/10.159.234.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 13:47:54 -0700
Date:   Tue, 25 Aug 2020 13:47:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iomap: Fix misplaced page flushing
Message-ID: <20200825204753.GF6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-2-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:02PM +0100, Matthew Wilcox (Oracle) wrote:
> If iomap_unshare_actor() unshares to an inline iomap, the page was
> not being flushed.  block_write_end() and __iomap_write_end() already
> contain flushes, so adding it to iomap_write_end_inline() seems like
> the best place.  That means we can remove it from iomap_write_actor().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems reasonable to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..cffd575e57b6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -715,6 +715,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  {
>  	void *addr;
>  
> +	flush_dcache_page(page);
>  	WARN_ON_ONCE(!PageUptodate(page));
>  	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
> @@ -811,8 +812,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
>  
> -		flush_dcache_page(page);
> -
>  		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
>  				srcmap);
>  		if (unlikely(status < 0))
> -- 
> 2.28.0
> 
