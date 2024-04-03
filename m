Return-Path: <linux-fsdevel+bounces-15965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC7896306
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 05:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C613D1C22D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456043F9E0;
	Wed,  3 Apr 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aClhbdbd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8F1BC58;
	Wed,  3 Apr 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115369; cv=none; b=BxQf39fmNQ+j33jd0sABQUehXrnPiZLGqz3lVfTp2EtaMFEj6+TdgOEu+fT5vr7cHhfZ+uu8yfYG9Z7N14c4z++YjWNFqmtB3MYqB+uYMePNl9Im8+1bB7ZzHVUcC+tcBbx1Em1iR7YJheNQdRBHXs62cnDtmE9jRsRNElyI6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115369; c=relaxed/simple;
	bh=Rmvd8nlsaI+hpmRh1qnteVgeuRcBm6ZauEhHSFcq6qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWy5eXdZ/ieqlIOmqp8WBr/2rAnCt2VT/PFtakXmU8IUjswD6a3J9Xl++rs5lnR5TCZPxqjerAYIMgIBJz8QsWq94dEz4AL2HYUwczU7GA9DF6OvL4dbiQjEYlsN6XDIcMssQ1QiSldkauqqVQC2I4sLSUQqt4C9CRXvUgK5Urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aClhbdbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77CAC433C7;
	Wed,  3 Apr 2024 03:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712115369;
	bh=Rmvd8nlsaI+hpmRh1qnteVgeuRcBm6ZauEhHSFcq6qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aClhbdbdUf0PRV3ksSMgIogl99uV9A3aanVVmXIJTYMgzeQe7UdHa57D7dp0enHK0
	 Bq3g2NIrcPWaAzf+D46JyigoOz7R3no2zA8R63og4SeSqjn3Dy3eaMZHsW8yxSr2b5
	 JSYOCRkyDyF3Ywij6dcVjcGzD1bjej/hedtdhyLb4KrV1Uoa96z1NL8bOIFvgrRJIH
	 oKkfML9kvNkFJcaZI4vpdS2Le/IVLxnlc9uY8btzW9S7X25LGXMqGil4jKKvknVnUM
	 ASgAdFe1+TiSuqR6xeGWwFvqM96Qxvnk7nnRQJg4k0W+NuVh+gyApkIsszv4TjvdVE
	 yfSgnpwRoZBtA==
Date: Tue, 2 Apr 2024 20:36:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v15 3/9] libfs: Introduce case-insensitive string
 comparison helper
Message-ID: <20240403033607.GE2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-4-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-4-eugen.hristev@collabora.com>

On Tue, Apr 02, 2024 at 06:48:36PM +0300, Eugen Hristev wrote:
> +int generic_ci_match(const struct inode *parent,
> +		     const struct qstr *name,
> +		     const struct qstr *folded_name,
> +		     const u8 *de_name, u32 de_name_len)
> +{
> +	const struct super_block *sb = parent->i_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
> +	int res = 0, match = 0;
> +
> +	if (IS_ENCRYPTED(parent)) {
> +		const struct fscrypt_str encrypted_name =
> +			FSTR_INIT((u8 *) de_name, de_name_len);
> +
> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
> +			return -EINVAL;
> +
> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		if (!decrypted_name.name)
> +			return -ENOMEM;
> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
> +						&decrypted_name);
> +		if (res < 0)
> +			goto out;
> +		dirent.name = decrypted_name.name;
> +		dirent.len = decrypted_name.len;
> +	}
> +
> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +	if (folded_name->name) {
> +		if (dirent.len == folded_name->len &&
> +		    !memcmp(folded_name->name, dirent.name, dirent.len)) {
> +			match = 1;
> +			goto out;
> +		}
> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> +	} else {
> +		if (dirent.len == name->len &&
> +		    !memcmp(name->name, dirent.name, dirent.len) &&
> +		    (!sb_has_strict_encoding(sb) || !utf8_validate(um, name))) {
> +			match = 1;
> +			goto out;
> +		}
> +		res = utf8_strncasecmp(um, name, &dirent);
> +	}

The 'match' variable is unnecessary because setting res=0 achieves the same
effect.

- Eric

