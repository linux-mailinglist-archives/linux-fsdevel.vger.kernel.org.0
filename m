Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B344F2D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFVAl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 20:41:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48966 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFVAl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:41:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0eQFr079807;
        Sat, 22 Jun 2019 00:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vW+yoFV6y0QRsmwmXhUJuIyZPvvr9SXUixJB7kXKpOY=;
 b=XC8skp8NS5+1h3kQnDG5RuMgQ7XMyCl1lIIvsM0XQ4rGa1UL512YtVNUzxsTXa09JzUs
 gq1siyEjmZTHxCbewn/O912nzkrdJs2q86FJ9evn+YVM0b50aztu25mdcTUNwcii3Idu
 cxpzl6ug+R+ywm8/gJbPg6Wgq01ftW/ocOazoxpYED7OKpbO9F5puNidBOvM48GX/O7K
 /ngBD6PpgIwTM55DWK9/T91lN9yFgrjKMG0AGI90NgQTq3j+Woa30COKiR0/Wo8nfLEG
 T8JsAn8x66/6QQ40LBnNV08KgW3XOkozOpvQg5MkCPlJ6AWvCPBuSLHHWgujEwS1mCKT 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t7809rux5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:41:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5M0fFbK185003;
        Sat, 22 Jun 2019 00:41:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t77ypf6ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 00:41:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5M0fD4w009640;
        Sat, 22 Jun 2019 00:41:14 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 17:41:13 -0700
Date:   Fri, 21 Jun 2019 17:41:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, david@fromorbit.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/6] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190622004106.GB1611011@magnolia>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621192828.28900-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 02:28:24PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Commit message needed here...

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 6648957af268..8a7b20e432ef 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -655,7 +655,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> -		struct page **pagep, struct iomap *iomap)
> +		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	pgoff_t index = pos >> PAGE_SHIFT;
> @@ -681,6 +681,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, iomap);
> +	else if (iomap->type == IOMAP_COW)
> +		status = __iomap_write_begin(inode, pos, len, page, srcmap);

Pardon my stream of consciousness while I try to reason about this
change...

Hmm.  For writes to the page cache (which aren't necessarily aligned to
a page granularity), this part of the iomap code has used whatever iomap
the fs provides to read in whatever page contents are needed from disk
so that we can do a read-modify-write through the page cache.

For XFS this means that we (almost*) always report data fork extents in
response to a write query, even if the write would be COW, because we
know that we won't need the cow fork mapping until writeback.  This has
led to the sort of funny situation where an (IOMAP_WRITE|IOMAP_DIRECT)
request will return the COW fork extent, but an (IOMAP_WRITE) request
returns the data fork extent.

(* "almost", because we will sometimes return a cow fork extent if the
data fork is a hole and the file has extent size hints enabled.  We're
safe from reading in stale disk contents because cow fork extents do not
achieve written status until writeback completes, and the page stays
locked so we can't write and writeback it simultaneously)

I /think/ this finally enables us to fix that weird quirk of the xfs
iomap methods, because now we always report the write address and we
always report the read address if the actor is supposed to do a
read-modify-write.  It's the actor's responsibilty to sort that out,
not the ->iomap_begin function's.

--D


>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
> @@ -833,7 +835,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		}
>  
>  		status = iomap_write_begin(inode, pos, bytes, flags, &page,
> -				iomap);
> +				iomap, srcmap);
>  		if (unlikely(status))
>  			break;
>  
> @@ -932,7 +934,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			return PTR_ERR(rpage);
>  
>  		status = iomap_write_begin(inode, pos, bytes,
> -					   AOP_FLAG_NOFS, &page, iomap);
> +					   AOP_FLAG_NOFS, &page, iomap, srcmap);
>  		put_page(rpage);
>  		if (unlikely(status))
>  			return status;
> @@ -978,13 +980,13 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
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
> @@ -1022,7 +1024,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
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
