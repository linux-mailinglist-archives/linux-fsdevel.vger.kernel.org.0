Return-Path: <linux-fsdevel+bounces-69480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15392C7D571
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D44F4E1D3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D829AB05;
	Sat, 22 Nov 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHFRdYqO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46A217F36;
	Sat, 22 Nov 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763836169; cv=none; b=cDGCQ2696T2tDbACZ8FImgHcLMnt6ylvmaewKaYV1PAgcKhkY4mS7jtUO4IR8w/SkcWbHrmdSshghN8NahBoWI85jkZt3jW9IG2wQp8ZKwDy8aogdUzr7FQ/q8+Cb2avyGeIrgXVy50cPCR4H9mB5fe2OucV+ZGfkTaLSnv/PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763836169; c=relaxed/simple;
	bh=8xw7rhH6O9SdjYiT0aP0fzTrgTnB7q3imFTDnslqKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMg/H6tEhEnn2WXHcxbh1aoAAvlfZxur9c/DFXLwlF00Mu1KJnYxo1jz2kZAxML4nff4OkQybHx96RhNS5jSkUpNlrdI+mprNjIl2Jrq/MrOVo9CSXGAaLwoWMrsg4r/0OAudseR0rhGIqGOpdErTcNwiK6FVEA9EJBA2c/9wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHFRdYqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29B5C4CEF5;
	Sat, 22 Nov 2025 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763836168;
	bh=8xw7rhH6O9SdjYiT0aP0fzTrgTnB7q3imFTDnslqKkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHFRdYqOPaQX70zmfnjBGRk3tGDlaAS2Jsb7U1vVsHowf+qQ2S/cXKybSueG1RSBe
	 khJ2DDVb4v1G/nHgmkDibOsm8EcRQMfHDiM/PONLXco8bieclt85EWjtezvmpUop49
	 tAmJNsVrerfklQpFkfZ35arZjm3eOxTm/nUh5EbkluMhEfWAhTb4kNwt9V5vQxd7tk
	 o3goh49Axy0FLzNQ6gBSYH0t28ml89l1Q47HdOD9xT22oIGVjV+NlEanAdLF0fAyaf
	 TAoz3S5eLQ6OkJCdVBQ5cT4ooEYsBYzDS3JeDNnkWQO5NLI4KGv5WyRt+y/9l5iDbO
	 bkyjmhWiOkqvA==
Date: Sat, 22 Nov 2025 10:29:26 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/11] fscrypt: pass a byte length to
 fscrypt_zeroout_range
Message-ID: <20251122182926.GC1626@quark>
References: <20251118062159.2358085-1-hch@lst.de>
 <20251118062159.2358085-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118062159.2358085-11-hch@lst.de>

On Tue, Nov 18, 2025 at 07:21:53AM +0100, Christoph Hellwig wrote:
> Range lengths are usually expressed as bytes in the VFS, switch
> fscrypt_zeroout_range to this convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c | 6 +++---
>  fs/ext4/inode.c | 3 ++-
>  fs/f2fs/file.c  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 235dd1c3d443..4e9893664c0f 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -115,7 +115,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>   * @inode: the file's inode
>   * @pos: the first file logical offset (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
> - * @len: number of blocks to zero out
> + * @len: bytes to zero out
[...]
> int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,                 
>                           sector_t sector, unsigned int len)

The type of 'len' is still unsigned int, so this reduces the maximum
length accepted by fscrypt_zeroout_range() from UINT32_MAX blocks to
UINT32_MAX bytes.  Is that really okay?

Both ext4 and f2fs call this from functions where they have the length
as a u32 number of logical blocks.  And of course both filesystems
support files longer than UINT32_MAX bytes.  So it's not clear to me.
ext4 extents have a smaller size limit, so maybe at least ext4 is okay.
But different extents can be contiguous and operated on together.  So
we'd have to check the callers of the callers, etc.

It would be safer to change the type to u64 and have the callers do
(u64)len_in_blocks << blockbits.

- Eric

