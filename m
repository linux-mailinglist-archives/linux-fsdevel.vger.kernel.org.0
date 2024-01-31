Return-Path: <linux-fsdevel+bounces-9591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B28431EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2FA288E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93627FF;
	Wed, 31 Jan 2024 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV0jE6q8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE6363;
	Wed, 31 Jan 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660980; cv=none; b=qriANt8oqxgx/4XGJdfvaIhPo0YUfkTTd57PaoThVXmUfK2ZQ3tvrswkh/tVUiargBg9jus4s0BSMsxAlzSamFAFnBEf1D96mrLnNxM1Cs/58STKTYSTUkfFcOtKQaM4suMNBN0jimM1eOglsqbg50XovZTNlSTT47+8dzORX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660980; c=relaxed/simple;
	bh=D3cBN3aB5cNbTbyQFYW4Hq+b+QWshyCJ+Ot1mi+gd/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzlh7wDiHt9BZkl64sYB5UFAfY2FzFQOtC6B7TUXLLSoTWKLsV3lGEu1h/cHptJMhMopuVo4BOI4AlmgHb/yrRDIp7IMRj8f150Wbb3/DlaR73eZUND8PAZI06Kg6YULIUj35UGS28KceysZo0+o/MK8HEn/UI/U0r36iYzAsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV0jE6q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50234C43390;
	Wed, 31 Jan 2024 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706660979;
	bh=D3cBN3aB5cNbTbyQFYW4Hq+b+QWshyCJ+Ot1mi+gd/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV0jE6q8R4zeCARBAI0FTnrytJ5JAYcK0DeacrN9ClZe7QVHxN8rjDTtMEU0ZxnPX
	 SWWMlXqeQCyeW2LrjHG8SA0mgzYBD+scdKxU/E1UBwJtCzigduwqtlNftN9El76Ccw
	 YGOu7Gfs0KzJ8OLkDuA/6Wy+Oy+Y2FcHc3SWmpqmVWSB6gPdxVHBdKOAUbZyBh3sRX
	 AkHBeWM2X6ZYNfIRyDgryg46uvo12CI9+3rXlBqjrPkiaUomSYg7BX8eXnxIaamPde
	 Pmg4mmZ+nR6InQ5qIViQTsYkMdLhIQ9ykPyAv7QCD+8p3pW4Akhkaaw2C2hM+Nu36b
	 0Q0jQZR2ac2hQ==
Date: Tue, 30 Jan 2024 16:29:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/12] fscrypt: Factor out a helper to configure the
 lookup dentry
Message-ID: <20240131002937.GB2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-3-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-3-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:20PM -0300, Gabriel Krisman Bertazi wrote:
> Both fscrypt_prepare_lookup_dentry_partial and
> fscrypt_prepare_lookup_dentry will set DCACHE_NOKEY_NAME for dentries
> when the key is not available. 

Shouldn't this say: "Both fscrypt_prepare_lookup() and
fscrypt_prepare_lookup_partial() set DCACHE_NOKEY_NAME for dentries when the key
is not available."

> @@ -131,12 +128,13 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
>  int fscrypt_prepare_lookup_partial(struct inode *dir, struct dentry *dentry)
>  {
>  	int err = fscrypt_get_encryption_info(dir, true);
> +	bool is_nokey_name = false;
> +
> +	if (!err && !fscrypt_has_encryption_key(dir))
> +		is_nokey_name = true;

	bool is_nokey_name = (err == 0 && !fscrypt_has_encryption_key(dir));

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 12f9e455d569..68ca8706483a 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -948,6 +948,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>  	return 0;
>  }
>  
> +static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
> +						 bool is_nokey_name)

Maybe just fscrypt_prepare_dentry()?

- Eric

