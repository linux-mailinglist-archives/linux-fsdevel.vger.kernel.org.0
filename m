Return-Path: <linux-fsdevel+bounces-9593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD58843242
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31001F217A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 00:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F34C89;
	Wed, 31 Jan 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmoHVBiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AD185E;
	Wed, 31 Jan 2024 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662046; cv=none; b=rZlUQU2i7thxhtIuufSP9JtjuG7mOjkXPDWrm5HyAqdqUrV8QSMu8ErPD/wul/Y2/3jZbhpk7RUt6PASjd3oeJ5JZ4sdSpX3ZOx6wrhIBrawu56LFpL9Ky5pvMxINlyZaC39xTQ5PUKFjaoQ7Z8+OwQsXWvs7SkmcZ+kL7mrPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662046; c=relaxed/simple;
	bh=rV7wK+L19fmxaxl/W1mi4BvAypDvQMbo6pwGGFaxUL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phvapPR3g40VNyc20JA6koJGvXqPO9RM4OT0YX1DcCC3VVDHao7Wrx7FvzZzYdr0I4tet2xaPheTdY3u43bb1d7Uw+19QG/sFur7Adod2BFJP5LnWLBZlEQvfSZUnuKFBa79VB3leCsaHJYdTVnqynAfDTrrzo5ZCzSWshbUxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmoHVBiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D39C433C7;
	Wed, 31 Jan 2024 00:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706662046;
	bh=rV7wK+L19fmxaxl/W1mi4BvAypDvQMbo6pwGGFaxUL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmoHVBiqwCOGoG4zg2ywsClj7kFrRUiadSDvkIO+nq5XGRfbwNXui5F6nJ2FJ5oyx
	 V6h44ZwDx9QmuPII0gfaSGSJ7Zx4H5POiGm3TNg4zugezD2TR0ym/1sXQfPdINZcOH
	 gyXRTipbVQCso0rzE1WEh5AHq1Z7/Xpwgdu+yA2rAn6iCzqdqKOlvSk9vhh+QHNrin
	 KqxQkPIy6wB9ciYAxOJpzM/2r7dgIa1nmNbXnGAB1OaC8qaoWyjSaM3B7AhSL42B4+
	 iVDusfCjBzxuf+7b5gg4rpu/1omDGxtOmIHi5kKSngQdtQLumhQx9nrJwtptpEX+G7
	 rMDIgk+pIAbcA==
Date: Tue, 30 Jan 2024 16:47:24 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] fscrypt: Drop d_revalidate for valid dentries
 during lookup
Message-ID: <20240131004724.GC2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-5-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-5-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:22PM -0300, Gabriel Krisman Bertazi wrote:
> Unencrypted and encrypted-dentries where the key is available don't need
> to be revalidated with regards to fscrypt, since they don't go stale
> from under VFS and the key cannot be removed for the encrypted case
> without evicting the dentry.  Mark them with d_set_always_valid, to

"d_set_always_valid" doesn't appear in the diff itself.

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 4aaf847955c0..a22997b9f35c 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>  static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
>  						 bool is_nokey_name)
>  {
> -	if (is_nokey_name) {
> -		spin_lock(&dentry->d_lock);
> +	spin_lock(&dentry->d_lock);
> +
> +	if (is_nokey_name)
>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
> -		spin_unlock(&dentry->d_lock);
> +	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
> +		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
> +		/*
> +		 * Unencrypted dentries and encrypted dentries where the
> +		 * key is available are always valid from fscrypt
> +		 * perspective. Avoid the cost of calling
> +		 * fscrypt_d_revalidate unnecessarily.
> +		 */
> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>  	}
> +
> +	spin_unlock(&dentry->d_lock);

This makes lookups in unencrypted directories start doing the
spin_lock/spin_unlock pair.  Is that really necessary?

These changes also make the inline function fscrypt_prepare_lookup() very long
(when including the fscrypt_prepare_lookup_dentry() that's inlined into it).
The rule that I'm trying to follow is that to the extent that the fscrypt helper
functions are inlined, the inline part should be a fast path for unencrypted
directories.  Encrypted directories should be handled out-of-line.

So looking at the original fscrypt_prepare_lookup():

	static inline int fscrypt_prepare_lookup(struct inode *dir,
						 struct dentry *dentry,
						 struct fscrypt_name *fname)
	{
		if (IS_ENCRYPTED(dir))
			return __fscrypt_prepare_lookup(dir, dentry, fname);

		memset(fname, 0, sizeof(*fname));
		fname->usr_fname = &dentry->d_name;
		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
		fname->disk_name.len = dentry->d_name.len;
		return 0;
	}

If you could just add the DCACHE_OP_REVALIDATE clearing for dentries in
unencrypted directories just before the "return 0;", hopefully without the
spinlock, that would be good.  Yes, that does mean that
__fscrypt_prepare_lookup() will have to handle it too, for the case of dentries
in encrypted directories, but that seems okay.

- Eric

