Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5824216A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHKU42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 16:56:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60158 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKU41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:56:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BKq2EJ088104;
        Tue, 11 Aug 2020 20:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k2VWWWbupWKsZ1yfbVGMeUuEcG7jFnMXzMnNN7D9wBc=;
 b=sPF5uvevUtJn8PKDuoqtpm0Xe0SKw5IX8zR8IF77i/Kp+81zWAw8FjY0szXIYwqj3l8z
 KJ/sFLoILzUon8peK9clhVNO3QNyFw6LwDVmtrUNwzei1tVZxDJXy57ObxoeSe545iMp
 4PN0XCPLaiwTXgnzlo+icJjNd5NyDK6w/mQRS8saKxpQo54F+pnPlZvuFBJLfPpYLMak
 2OCmz+ocRV5AjxlpXjMraA83EQRAtUKwsQ1lw+2gorD8x8MVkQA7puEn/Gh8Wy3oARK4
 YfnP+i6Dv6JDMy6/UqdNwbRRMOgxZrWYhg1SSQZZoXTbWKq+vLe5LRlTJGnD51qS40I0 sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ydngxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 20:56:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BKqT50150388;
        Tue, 11 Aug 2020 20:56:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32t600beu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 20:56:18 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07BKuFA8027409;
        Tue, 11 Aug 2020 20:56:15 GMT
Received: from localhost (/10.159.237.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 20:56:14 +0000
Date:   Tue, 11 Aug 2020 13:56:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: Convert readahead to iomap_iter
Message-ID: <20200811205314.GF6107@magnolia>
References: <20200728173216.7184-1-willy@infradead.org>
 <20200728173216.7184-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728173216.7184-3-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:32:15PM +0100, Matthew Wilcox (Oracle) wrote:
> This approach removes at least two indirect function calls from the
> readahead path.  Previous call chain (indirect function calls marked *):
> 
> xfs_vm_readahead
>   iomap_readahead
>     iomap_apply
>       xfs_read_iomap_begin [*]
>       iomap_readahead_actor [*]
>         iomap_readpage_actor
> 
> New call chain:
> 
> xfs_vm_readahead
>   xfs_iomap_next_read
>   iomi_advance
>   iomap_readahead
>     iomap_readpage_actor

I mostly like this, with a few comments...

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 82 ++++++++++++++----------------------------
>  fs/xfs/xfs_aops.c      |  9 ++++-
>  fs/xfs/xfs_iomap.c     | 15 ++++++++
>  fs/xfs/xfs_iomap.h     |  2 ++
>  fs/zonefs/super.c      | 20 ++++++++++-
>  include/linux/iomap.h  | 10 +++++-
>  6 files changed, 79 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..fff23ed6a682 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -206,13 +206,6 @@ iomap_read_end_io(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -struct iomap_readpage_ctx {
> -	struct page		*cur_page;
> -	bool			cur_page_in_bio;
> -	struct bio		*bio;
> -	struct readahead_control *rac;
> -};
> -
>  static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
>  		struct iomap *iomap)
> @@ -369,35 +362,10 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readpage);
>  
> -static loff_t
> -iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> -{
> -	struct iomap_readpage_ctx *ctx = data;
> -	loff_t done, ret;
> -
> -	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> -		}
> -		if (!ctx->cur_page) {
> -			ctx->cur_page = readahead_page(ctx->rac);
> -			ctx->cur_page_in_bio = false;
> -		}
> -		ret = iomap_readpage_actor(inode, pos + done, length - done,
> -				ctx, iomap, srcmap);
> -	}
> -
> -	return done;
> -}
> -
>  /**
>   * iomap_readahead - Attempt to read pages from a file.
> + * @iomi: The iomap iterator for this operation.
>   * @rac: Describes the pages to be read.
> - * @ops: The operations vector for the filesystem.
>   *
>   * This function is for filesystems to call to implement their readahead
>   * address_space operation.
> @@ -409,35 +377,37 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
>   * function is called with memalloc_nofs set, so allocations will not cause
>   * the filesystem to be reentered.
>   */
> -void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
> +loff_t iomap_readahead(struct iomap_iter *iomi, struct iomap_readpage_ctx *ctx)
>  {
> -	struct inode *inode = rac->mapping->host;
> -	loff_t pos = readahead_pos(rac);
> -	loff_t length = readahead_length(rac);
> -	struct iomap_readpage_ctx ctx = {
> -		.rac	= rac,
> -	};
> -
> -	trace_iomap_readahead(inode, readahead_count(rac));
> +	loff_t done, ret, length = iomap_length(iomi);
>  
> -	while (length > 0) {
> -		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
> -				&ctx, iomap_readahead_actor);
> -		if (ret <= 0) {
> -			WARN_ON_ONCE(ret == 0);
> -			break;
> +	for (done = 0; done < length; done += ret) {
> +		if (ctx->cur_page && offset_in_page(iomi->pos + done) == 0) {
> +			if (!ctx->cur_page_in_bio)
> +				unlock_page(ctx->cur_page);
> +			put_page(ctx->cur_page);
> +			ctx->cur_page = NULL;
>  		}
> -		pos += ret;
> -		length -= ret;
> +		if (!ctx->cur_page) {
> +			ctx->cur_page = readahead_page(ctx->rac);
> +			ctx->cur_page_in_bio = false;
> +		}
> +		ret = iomap_readpage_actor(iomi->inode, iomi->pos + done,
> +				length - done, ctx,
> +				&iomi->iomap, &iomi->srcmap);
>  	}
>  
> -	if (ctx.bio)
> -		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> -		put_page(ctx.cur_page);
> +	if (iomi->len == done) {
> +		if (ctx->bio)
> +			submit_bio(ctx->bio);
> +		if (ctx->cur_page) {
> +			if (!ctx->cur_page_in_bio)
> +				unlock_page(ctx->cur_page);
> +			put_page(ctx->cur_page);
> +		}
>  	}
> +
> +	return done;
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b35611882ff9..2884752e40e8 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -625,7 +625,14 @@ STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops);
> +	IOMAP_ITER(iomi, rac->mapping->host, readahead_pos(rac),
> +			readahead_length(rac), 0);
> +	struct iomap_readpage_ctx ctx = {
> +		.rac = rac,
> +	};
> +
> +	while (iomap_iter(&iomi, xfs_iomap_next_read))
> +		iomi.copied = iomap_readahead(&iomi, &ctx);

Why not have iomap_readahead set iomi.copied on its way out?  The actor
function is supposed to set iomi.ret if an error happens, right?

Oh wait no, the actor function returns a positive copied value, or a
negative error code, and then it's up to the _next_read function to
notice if copied is negative, stuff it in ret, and then return false to
stop the iteration?

>  }
>  
>  static int
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0e3f62cde375..66f2fcaf136e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1150,6 +1150,21 @@ const struct iomap_ops xfs_read_iomap_ops = {
>  	.iomap_begin		= xfs_read_iomap_begin,
>  };
>  
> +int
> +xfs_iomap_next_read(
> +	const struct iomap_iter *iomi,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)

Aren't these last two parameters already in the iomap iter?
Are they passed separately to work around the pointer being const?

> +{
> +	if (iomi->copied < 0)
> +		return iomi->copied;

Is this boilerplate going to end up in every single iomap_next_t
function?  If so, it should probably just go in iomap_iter prior to the
next() call, right?

I also wonder if these functions (and the typedef) ought to be called
iomap_iter_advance_t since that's what they do -- pick up the status
from the last round, and advance the iterator to the next mapping that
we want to process.

> +	if (iomi->copied >= iomi->len)
> +		return 0;

Er... if we copied more than we asked for, doesn't that imply something
bad just happened?

> +
> +	return xfs_read_iomap_begin(iomi->inode, iomi->pos + iomi->copied,
> +			iomi->len - iomi->copied, iomi->flags, iomap, srcmap);

Would be kinda nice if you could just pass the whole iomap_iter, but I
get that we're probably stuck with this until the entirety gets
converted.

--D

> +}
> +
>  static int
>  xfs_seek_iomap_begin(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e..1b1fa225e938 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -46,4 +46,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
>  
> +int xfs_iomap_next_read(const struct iomap_iter *iomi, struct iomap *iomap,
> +		struct iomap *srcmap);
>  #endif /* __XFS_IOMAP_H__*/
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 07bc42d62673..4842b85ce36d 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -70,6 +70,17 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> +static int zonefs_iomap_next(const struct iomap_iter *iomi,
> +		struct iomap *iomap, struct iomap *srcmap)
> +{
> +	if (iomi->copied < 0)
> +		return iomi->copied;
> +	if (iomi->copied >= iomi->len)
> +		return 0;
> +	return zonefs_iomap_begin(iomi->inode, iomi->pos + iomi->copied,
> +			iomi->len - iomi->copied, iomi->flags, iomap, srcmap);
> +}
> +
>  static const struct iomap_ops zonefs_iomap_ops = {
>  	.iomap_begin	= zonefs_iomap_begin,
>  };
> @@ -81,7 +92,14 @@ static int zonefs_readpage(struct file *unused, struct page *page)
>  
>  static void zonefs_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &zonefs_iomap_ops);
> +	IOMAP_ITER(iomi, rac->mapping->host, readahead_pos(rac),
> +			readahead_length(rac), 0);
> +	struct iomap_readpage_ctx ctx = {
> +		.rac = rac,
> +	};
> +
> +	while (iomap_iter(&iomi, zonefs_iomap_next))
> +		iomi.copied = iomap_readahead(&iomi, &ctx);
>  }
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index fe58e68ec0c1..dd9bfed85c4f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -212,7 +212,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
>  int iomap_readpage(struct page *page, const struct iomap_ops *ops);
> -void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  int iomap_set_page_dirty(struct page *page);
>  int iomap_is_partially_uptodate(struct page *page, unsigned long from,
>  		unsigned long count);
> @@ -299,6 +298,15 @@ int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);
>  
> +struct iomap_readpage_ctx {
> +	struct page		*cur_page;
> +	bool			cur_page_in_bio;
> +	struct bio		*bio;
> +	struct readahead_control *rac;
> +};
> +
> +loff_t iomap_readahead(struct iomap_iter *, struct iomap_readpage_ctx *);
> +
>  /*
>   * Flags for direct I/O ->end_io:
>   */
> -- 
> 2.27.0
> 
