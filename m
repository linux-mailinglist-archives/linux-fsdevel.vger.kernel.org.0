Return-Path: <linux-fsdevel+bounces-66968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF0C31F41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0F1899590
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BA27FB3A;
	Tue,  4 Nov 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhIYInPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8826B75B;
	Tue,  4 Nov 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271873; cv=none; b=U6+nKPpHBUnBaN0Hl2ckpir2f9vtBvMp6puoBSbnW9J5GuYyJHbLDf2HdHFrGJs84JXT3t45HXj2ZhE0krs1Z7IVxa3ZLs+PD5jJtcAs0Zf5Nv2L64HqdEb14j3mjbUrOGIED9eL0bPjvB7o5M2fN/NSYHe4sbKAev9504W1XEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271873; c=relaxed/simple;
	bh=etPxiZ7rjP8VtgOg/n1V87qRxchqdEoQZ9KyI3fRorU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUDpu0mv50tjiOPsi08K0dqR1+t0ogIVevrc4tSYhdpQ8JJPlINJp1f7ovJ/d/RAMllVzpx4P1bDdlmp0s81CmGQqGRJ8Uhv17rcSP/MLRwMW3qC+YSph2yCluHk6GxVu6LhQfPfLtNSO2QKfV17Cr9oJkkBsE1uip2OJkMn2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhIYInPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB013C4CEF7;
	Tue,  4 Nov 2025 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762271872;
	bh=etPxiZ7rjP8VtgOg/n1V87qRxchqdEoQZ9KyI3fRorU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhIYInPyIxnNY1EIllIQhhpfP0DP2/EeT3oIkIX3I5K0jheAHc3+3C16W4p9GJAB3
	 qyJM5t9DGGOR+a1d2pRYrYHVBiHtZQXvRjN4ka+q5H5I8XIcY2iBsEILKp+3dERtxH
	 P+xsYopX8bWUApscI9kNQKLnBfb1PO/vLa3MN4DRtMFXDIAdZXGYsz/a7dosKn4puZ
	 G3dJQHVa41HF+WK8KZDHNNW6KAldY7z6faIj6DpnHl0RaYyUe6idw2hGOYupkrm+pK
	 NgAhPZv/mp8b3HUD/zT1TyxYt5KN5Drgy9lju8+eQ9Jid6aXAt3izazhFpqk47PmZ3
	 aMvhIN/ZvaIag==
Date: Tue, 4 Nov 2025 07:57:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v4 5/5] block: add __must_check attribute to
 sb_min_blocksize()
Message-ID: <20251104155752.GB196362@frogsfrogsfrogs>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-6-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103163617.151045-6-yangyongpeng.storage@gmail.com>

On Tue, Nov 04, 2025 at 12:36:18AM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When sb_min_blocksize() returns 0 and the return value is not checked,
> it may lead to a situation where sb->s_blocksize is 0 when
> accessing the filesystem super block. After commit a64e5a596067bd
> ("bdev: add back PAGE_SIZE block size validation for
> sb_set_blocksize()"), this becomes more likely to happen when the
> block device’s logical_block_size is larger than PAGE_SIZE and the
> filesystem is unformatted. Add the __must_check attribute to ensure
> callers always check the return value.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bdev.c       | 2 +-
>  include/linux/fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..638f0cd458ae 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
>  
>  EXPORT_SYMBOL(sb_set_blocksize);
>  
> -int sb_min_blocksize(struct super_block *sb, int size)
> +int __must_check sb_min_blocksize(struct super_block *sb, int size)
>  {
>  	int minsize = bdev_logical_block_size(sb->s_bdev);
>  	if (size < minsize)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..26d4ca0f859a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
>  extern void inode_add_lru(struct inode *inode);
>  
>  extern int sb_set_blocksize(struct super_block *, int);
> -extern int sb_min_blocksize(struct super_block *, int);
> +extern int __must_check sb_min_blocksize(struct super_block *, int);
>  
>  int generic_file_mmap(struct file *, struct vm_area_struct *);
>  int generic_file_mmap_prepare(struct vm_area_desc *desc);
> -- 
> 2.43.0
> 
> 

