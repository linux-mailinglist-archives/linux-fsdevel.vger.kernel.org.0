Return-Path: <linux-fsdevel+bounces-9594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2384324C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DCC1F26F38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D523CB;
	Wed, 31 Jan 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULyDPVWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5101C2D;
	Wed, 31 Jan 2024 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662513; cv=none; b=SHcXtHAFFmQFx6sI/GsetipRswLHaNFd7OGVDk11eYuz2h1DIg10W9+HVgqmZnAd3a9XJR4DfY7k3Pd6yswedg0c5kPOAt07DlU1BCCZ57ToKmDeh5EKUtXe5d/NEOu92tXlHEZUTp7vRGldfgRDuhu27GLML3AfKis/XbiXSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662513; c=relaxed/simple;
	bh=b6D5tgoiY0lFGwJnyqS5OmgtxE7MvY+XGJIgjypMCCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8VOF/Mby0UgYDLR+rVRDpFbzaWcW5wbUFNz+Hjl8wpuYeYoVb/K5h+bQ7Hp9tB95Vj/bPCcZRs4kfJymQVWEM+gJLBWOmUMIpuJXVmLFc+jKyfDPiYrMhAoZ2VAH07Seu+tBX6WVYTgAvcOCZp5++1eidRp0cKpgQmGhU5MVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULyDPVWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638F9C433C7;
	Wed, 31 Jan 2024 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706662512;
	bh=b6D5tgoiY0lFGwJnyqS5OmgtxE7MvY+XGJIgjypMCCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULyDPVWIqpMMds9rDMvrJICLTprvo3p9XsKetIQfuD+91wA00AxEfY+5E8MsyKMvz
	 gymOXOTG4mcyYaeI8lDnQIrcANzTSzz0kORRbopRcbkFjMdb6PJrUAuQzvZQr1M33+
	 JUZHY1fvEipusp4AjaN0VGFjbJZZDf3aFIwd+T/TZd8bf6FQG0PRd6IKHnYIXGcd7S
	 80q15tYL1S6bqf3cMQgH3YwJr8HP7rNROGfoQ4V1IojqEhX1SYHh3OiEntLviZLM57
	 vv/NPSBtEdilvBR4+hfKgUbms2+BQZUxIedsrU/ku/DQxFrfV49wn5rmvIH164emH9
	 MeAX/6O/eJKWw==
Date: Tue, 30 Jan 2024 16:55:10 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] fscrypt: Ignore plaintext dentries during d_move
Message-ID: <20240131005510.GD2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-7-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-7-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:24PM -0300, Gabriel Krisman Bertazi wrote:
> Now that we do more than just clear the DCACHE_NOKEY_NAME in
> fscrypt_handle_d_move, skip it entirely for plaintext dentries, to avoid
> extra costs.
> 
> Note that VFS will call this function for any dentry, whether the volume
> has fscrypt on not.  But, since we only care about DCACHE_NOKEY_NAME, we
> can check for that, to avoid touching the superblock for other fields
> that identify a fscrypt volume.
> 
> Note also that fscrypt_handle_d_move is hopefully inlined back into
> __d_move, so the call cost is not significant.  Considering that
> DCACHE_NOKEY_NAME is a fscrypt-specific flag, we do the check in fscrypt
> code instead of the caller.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> 
> ---
> Changes since v4:
>   - Check based on the dentry itself (eric)
> ---
>  include/linux/fscrypt.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index c1e285053b3e..ab668760d63e 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -232,6 +232,15 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
>   */
>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
>  {
> +	/*
> +	 * VFS calls fscrypt_handle_d_move even for non-fscrypt
> +	 * filesystems.  Since we only care about DCACHE_NOKEY_NAME
> +	 * dentries here, check that to bail out quickly, if possible.
> +	 */
> +	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
> +		return;

I think you're over-complicating this a bit.  This should be merged with patch
5, since this is basically fixing patch 5, and the end result should look like:

/*
 * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
 * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
 * cleared and there might be an opportunity to disable d_revalidate.  Note that
 * we don't have to support the inverse operation because fscrypt doesn't allow
 * no-key names to be the source or target of a rename().
 */
static inline void fscrypt_handle_d_move(struct dentry *dentry)
{
	if (dentry->d_flags & DCACHE_NOKEY_NAME) {
		dentry->d_flags &= ~DCACHE_NOKEY_NAME;
		if (dentry->d_op->d_revalidate == fscrypt_d_revalidate)
			dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
	}
}

Note that checking for NULL dentry->d_op is not necessary, since it's already
been verified that DCACHE_NOKEY_NAME is set, which means fscrypt is in use,
which means that there are dentry_operations.

- Eric

