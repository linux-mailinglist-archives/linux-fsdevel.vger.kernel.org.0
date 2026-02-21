Return-Path: <linux-fsdevel+bounces-77862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGySF5IMmml+YAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:50:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8616DBDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2A2306A53A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07353315793;
	Sat, 21 Feb 2026 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8RKHW3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAA10785;
	Sat, 21 Feb 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703370; cv=none; b=Sx+VHSbyZf9LRENY4Jts82vj6rUeWZ844CnXYRmScxfPBl+UpL1UR/QrU+5WnvWd4CW+9kmwkwyarUW4zBEqa5LfVrTz45D0S/wvbhesA/6IOwDPDiTutlPnuQ1i7Vl4O5BK7Dz+tQ0mUOz/MejfjV5m2AaH3M4B6IJoZYQuoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703370; c=relaxed/simple;
	bh=Y6CakBup81NzTHNSAM8tNOwbYIAPWvfjsed/7M38DSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JquF279ZZ0gTLw+QuP4CCgH1uczRzsJ7kbZFEFdhng14Qgd4y8C7MxICBgnejl/s5CcdveG0kP/hB+nPcuYgauxhmJASdbP22JAWF3p3RwnFuGJM5r36aCCrZIftH7nSi87+GDllAD/08nWinIXAdFJuMWAvmQl3smCi715XbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8RKHW3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C835FC4CEF7;
	Sat, 21 Feb 2026 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703370;
	bh=Y6CakBup81NzTHNSAM8tNOwbYIAPWvfjsed/7M38DSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8RKHW3v646t0sP75rq0a6ORsgJc2TtU6IdLNp05j+GKNcxcOOOaOLy1FcWYGZeG7
	 BmePywNnr0OAmdZfLZ+XsofQytwbivdBcOT8yDiiQwsSLS+/QnHLKjsudU5OKQxtBu
	 FaSTYr69Iqi5W0kHpjcwgc/iXxgLnmG1D4Eld1qhXPceHcdfKkcamHzKWWAtinK38u
	 HV4if1HmF3+cjMBXvGRjMew23/PKXEBcU7/7skxPh6Lj53bvsGXyJ/0Ujre2WL8DtG
	 +Zlxc2wwIiWmQ+txYhSOz3oXZ8kAVgTjWVk8VinEp7BhTatcBNoyL76jM/4AqqH9Cg
	 qdF+dIv5VUnRQ==
Date: Sat, 21 Feb 2026 11:49:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/9] fscrypt: pass a byte offset to fscrypt_zeroout_range
Message-ID: <20260221194922.GE2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-8-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77862-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C8616DBDA
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 07:14:45AM +0100, Christoph Hellwig wrote:
> Logical offsets into an inode are usually expresssed as bytes in the VFS.
> Switch fscrypt_zeroout_range to that convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c         | 6 +++---
>  fs/ext4/inode.c         | 3 ++-
>  fs/f2fs/file.c          | 4 +++-
>  include/linux/fscrypt.h | 4 ++--
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 36025ce7a264..e41e605cf7e6 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -113,7 +113,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>  /**
>   * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
>   * @inode: the file's inode
> - * @lblk: the first file logical block to zero out
> + * @pos: the first file logical offset (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
>   * @len: number of blocks to zero out
>   *
> @@ -127,7 +127,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> -int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> +int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
>  			  sector_t pblk, unsigned int len)
>  {
>  	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
> @@ -135,7 +135,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  	const unsigned int du_size = 1U << du_bits;
>  	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
>  	const unsigned int du_per_page = 1U << du_per_page_bits;
> -	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
> +	u64 du_index = pos >> du_bits;
>  	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
>  	loff_t pos = (loff_t)lblk << inode->i_blkbits;

This is a bisection hazard because the 'pos' local variable isn't
removed until a later patch.  It needs to be removed in this patch.

- Eric

