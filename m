Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD780370
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbfHCAXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 20:23:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389626AbfHCAXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:23:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730Ib7G185832;
        Sat, 3 Aug 2019 00:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jUEfS3Y2aED73kER4y4Icb2lAt17M5pybbKfP163b4g=;
 b=xAk4GtdWsl0DUmwnZpXlNWaiSERbIw6aVUNMRlfBBhqRjzMFglkaUXdSHGhp6P6yTt0M
 4m+tn4tnXtoirVbzkK18qnSg9QfqK7YwUhOG17eC+fMB5Z0yDwrhWbL5kTLyWdLppZ+Q
 Q3iWoB2ZvPMEdBel61Mr0ZU0x9CdEi7e651jeoN3R1VfNm0TuUQSWJ7ONvTD1tkysXYD
 SxoelwBBd9HWow9S32JXenlZgjgz894EEidwj8hkAi2fYdaAlC1klzEApjIGPeuhwHun
 XORjgN+gskuMFXmqs0gjFtcBalTBGCOSW79tSFbFCOdzpJiUyryWzpJI/HRHef3/b5lx sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1ud6bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:23:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730IT4E006728;
        Sat, 3 Aug 2019 00:23:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u4yct862b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:23:20 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x730NJmh021649;
        Sat, 3 Aug 2019 00:23:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 17:23:19 -0700
Date:   Fri, 2 Aug 2019 17:23:18 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/13] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190803002318.GB7129@magnolia>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908030001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908030001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:37PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> In case of a IOMAP_COW, read a page from the srcmap before
> performing a write on the page.

Looks ok, I think...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/buffered-io.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f27756c0b31c..a96cc26eec92 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -581,7 +581,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap)
> +		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	pgoff_t index = pos >> PAGE_SHIFT;
> @@ -607,6 +607,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, iomap);
> +	else if (iomap->type == IOMAP_COW)
> +		status = __iomap_write_begin(inode, pos, len, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
> @@ -772,7 +774,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		}
>  
>  		status = iomap_write_begin(inode, pos, bytes, flags, &page,
> -				iomap);
> +				iomap, srcmap);
>  		if (unlikely(status))
>  			break;
>  
> @@ -871,7 +873,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			return PTR_ERR(rpage);
>  
>  		status = iomap_write_begin(inode, pos, bytes,
> -					   AOP_FLAG_NOFS, &page, iomap);
> +					   AOP_FLAG_NOFS, &page, iomap, srcmap);
>  		put_page(rpage);
>  		if (unlikely(status))
>  			return status;
> @@ -917,13 +919,13 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
>  EXPORT_SYMBOL_GPL(iomap_file_dirty);
>  
>  static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> -		unsigned bytes, struct iomap *iomap)
> +		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct page *page;
>  	int status;
>  
>  	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
> -				   iomap);
> +				   iomap, srcmap);
>  	if (status)
>  		return status;
>  
> @@ -961,7 +963,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
>  		if (IS_DAX(inode))
>  			status = iomap_dax_zero(pos, offset, bytes, iomap);
>  		else
> -			status = iomap_zero(inode, pos, offset, bytes, iomap);
> +			status = iomap_zero(inode, pos, offset, bytes, iomap, srcmap);
>  		if (status < 0)
>  			return status;
>  
> -- 
> 2.16.4
> 
