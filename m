Return-Path: <linux-fsdevel+bounces-66963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03BC31E60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42324E3ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB732ED27;
	Tue,  4 Nov 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oocAw9TR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A352D29C7;
	Tue,  4 Nov 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270930; cv=none; b=li6bvxkaHGoOwY9DVQwGybr5qKjkcRjh3SruDcLccsaJLdn7ANkkrqfvZ2lmrkEp7hXU/+OyVasBVPH6MazCrPsxOZTR7Slnmnpp/tA7aLEBMtQdxK9EHmyVY6Snv08oDMrMMyRGktkDgW2txDDNRT+LonGS6lIzS+U1nvUjTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270930; c=relaxed/simple;
	bh=zn1m5Yrbru0NFZYJtkCvLKEy/K3uEFrJ9Xpgegcq+/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI2k6K+ZopNZbXyln+tdjR7voVrPd+y14KYuVxNWOzwWRz4TLxYBW3hQ5THgo3f2J70uB/IvGDLLqkWP/lkRiHJ/kkhlQGQJcIRO7A5WmxxtX3oxhkCWCl/Kq+HwThbRFZ151fvnC8oB9Qtyw61yrsJ+fE6rHdcAbU8koWxSxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oocAw9TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AAFC4CEF7;
	Tue,  4 Nov 2025 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270930;
	bh=zn1m5Yrbru0NFZYJtkCvLKEy/K3uEFrJ9Xpgegcq+/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oocAw9TRzbKZDGx0kb70RwQtL6Cv5s5WstpdVwwAxl8sGO1daWPCUwBylVcnrmssZ
	 a9neZiXhrdkGWZKbWBgN3nGMQtKI7w1qPnuD5hu6I2a2C0OOz2fCHcATvHspzu+uLt
	 XaQo0TYXFkHWYlahZKXrJKnjuyyBRE8px0CRl68UM3qnbsUEoX8iqjr1rRra9Xw0i6
	 KBEJ7nL702821ndOZRFYjXE8li5Syc5TdZgYo+A8BAwJC/sMKYak8mVQFI/vtf0Tlz
	 tZc21Roa9XpYz54cqfBEPpTWeaSucVf9bcQU5WGwblGAEzSPsnGFyPLtPgg103bhV4
	 aa7bOSfo+KA6g==
Date: Tue, 4 Nov 2025 07:42:09 -0800
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
Subject: Re: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize()
 in xfs_fs_fill_super
Message-ID: <20251104154209.GA196362@frogsfrogsfrogs>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103163617.151045-5-yangyongpeng.storage@gmail.com>

On Tue, Nov 04, 2025 at 12:36:17AM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> sb_min_blocksize() may return 0. Check its return value to avoid the
> filesystem super block when sb->s_blocksize is 0.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
> for sb_set_blocksize()")

Odd line wrapping, does this actually work with $stablemaintainer
scripts?

> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Otherwise looks fine to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
>  	sb->s_xattr = xfs_xattr_handlers;
>  	sb->s_export_op = &xfs_export_operations;
>  #ifdef CONFIG_XFS_QUOTA
> -- 
> 2.43.0
> 
> 

