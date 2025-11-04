Return-Path: <linux-fsdevel+bounces-66922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2CC30A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C31189E84B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F72E1C4E;
	Tue,  4 Nov 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bR/ORk0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1E2D8370;
	Tue,  4 Nov 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254274; cv=none; b=RkQ5uL5bNWl1rri/p1WbWRpdIt6VH9U+n67r4WA939pxIJZO/G6sknd5zeO04suFI7sgJeQm7kLmUN/5oh3DluBm+1lmtfqwJobkhSIKWnE4YpFcvgmA3xQ3Af+Wvns12hnXn+cqxtwzIx0qqPikyah7ftoTq2nFYNOAxdn0bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254274; c=relaxed/simple;
	bh=hawChhwqgQoJXhI1uWGlkqNdZt8Ytu7a5JpukOOTcnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR8soJPYZPNYIpH9fe7qZNJkwOYlZ6+tNny+MNHmd4OX5C9rmsSTdFhPpXdMzHsNF3ngs96366qCRawgPK5YGs5fcUrIQyG3xnTbWgmdNuyRDTlOdrlX5M6F/DYmpvJlnRo7X7/+gxMA3YO0xPFcmwg0O8wDqjhTnH6CFmIAGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bR/ORk0m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cXSCABKME0BubnQOIaemnozhXE+EYAjmmWCLEvgl6vo=; b=bR/ORk0mGEsg35jaWW18FEIPYE
	d17jSp4BEkZ3Xhn0vlRXdHrit6VV52OWnTt9sRlNsdPmnqlH4LenUWZYzAKJTyNvBnliYjZ1PnsVS
	w/143/V84PxFjnvNOQdUm9f8JtH/zG79ndRfPPmH0Y+LX0IgRkJRFtHwdoTrgeeHtw+apCrbyVt5H
	suIQqKdtVfipscGjq3NE+LRiAp+SEWcpaEAdin1kL1cUOlYDcl5x4ksgZGZpTtng6ChnxG6gUC51u
	1B/ZETieW1FpHqb1IiNcWZ3RCFGQEtKzssFuvm49gzA62t0gfNbRolueml3Jf+e0mFHq2VN9h/n9f
	2yx30psQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEpx-0000000BgXZ-3F5D;
	Tue, 04 Nov 2025 11:04:29 +0000
Date: Tue, 4 Nov 2025 03:04:29 -0800
From: Christoph Hellwig <hch@infradead.org>
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
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v5 4/5] xfs: check the return value of sb_min_blocksize()
 in xfs_fs_fill_super
Message-ID: <aQndvQnhv_1jNtlF@infradead.org>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-5-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103164722.151563-5-yangyongpeng.storage@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 12:47:22AM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> sb_min_blocksize() may return 0. Check its return value to avoid the
> filesystem super block when sb->s_blocksize is 0.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
> for sb_set_blocksize()")
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/xfs/xfs_super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 1067ebb3b001..bc71aa9dcee8 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
>  	if (error)
>  		return error;
>  
> -	sb_min_blocksize(sb, BBSIZE);
> +	if (!sb_min_blocksize(sb, BBSIZE)) {
> +		xfs_err(mp, "unable to set blocksize");
> +		return -EINVAL;
> +	}

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

