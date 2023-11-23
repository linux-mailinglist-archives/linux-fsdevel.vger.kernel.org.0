Return-Path: <linux-fsdevel+bounces-3543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E57F6314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1455E281DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4DA3D963;
	Thu, 23 Nov 2023 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eh3KgSzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB1D5E;
	Thu, 23 Nov 2023 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wk5beXennXPU1SdLfS4CekuNuzZhsJLb/G4f8HExOZI=; b=eh3KgSzcXHHolOUfODGVniOzlM
	xWvgTv6KbdnOfsqJ9d7UYC+7ZtNGImHkOgjDIcHy9sfGjUroJifQrzIbmP724hZSzC9lNZdzgOl14
	F3DxX9pEmiVQdnmOM90BTxj8KkFUyOwuYYQUNV4/AsTtGcuj173RqQHSI0a2DVXcW/A1Tf5NPqHKc
	X/j0M3yJqLEo40vplXSVgc0MStWXqjx0CMBxT/3wB/W8NPsSFdjof84RRTfo959pOiS3jxKgoIo7L
	OYfUWr5DelZqryH8LQeXAh7QYkNU90TcIOL/wYENwMWrSrnmgooIiM8DbYDPpr3VCR8JuvHwFzYbs
	eRMuuQ9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Bj4-005BPU-0v;
	Thu, 23 Nov 2023 15:34:46 +0000
Date: Thu, 23 Nov 2023 07:34:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 12/18] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <ZV9xFt1WhLIoULyc@infradead.org>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
 <20231123125121.4064694-13-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123125121.4064694-13-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 23, 2023 at 08:51:14PM +0800, Zhang Yi wrote:
> index fd4d43bafd1b..3b9ba390dd1b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -852,13 +852,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  	 * cache.  It's up to the file system to write the updated size to disk,
>  	 * preferably after I/O completion so that no stale data is exposed.
>  	 */
> -	if (pos + ret > old_size) {
> +	if ((iter->flags & IOMAP_WRITE) && pos + ret > old_size) {
>  		i_size_write(iter->inode, pos + ret);
>  		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  	}
>  	__iomap_put_folio(iter, pos, ret, folio);
>  
> -	if (old_size < pos)
> +	if ((iter->flags & IOMAP_WRITE) && old_size < pos)
>  		pagecache_isize_extended(iter->inode, old_size, pos);
>  	if (ret < len)
>  		iomap_write_failed(iter->inode, pos + ret, len - ret);

I agree with your rationale, but I hate how this code ends up
looking.  In many ways iomap_write_end seems like the wrong
place to update the inode size anyway.  I've not done a deep
analysis, but I think there shouldn't really be any major blocker
to only setting IOMAP_F_SIZE_CHANGED in iomap_write_end, and then
move updating i_size and calling pagecache_isize_extended to
iomap_write_iter.


