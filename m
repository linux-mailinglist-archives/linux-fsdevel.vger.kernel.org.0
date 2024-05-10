Return-Path: <linux-fsdevel+bounces-19241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3698C1C26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DA31C22077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199A13B7BC;
	Fri, 10 May 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRFtePo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3B13A3E3;
	Fri, 10 May 2024 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304813; cv=none; b=OoYqYZVoNHuI5QYq+oVd+GD2B0dNrnWptEM4c+METKIP+gC/myJS5+to4QAUIES+7HymgswcaHUL0N5hLoQj2H/IrRtOn8h0kVqlbCGhAbTu0frrCbcpkeQcG3chqbZaJmtUpbL8S91nGOD5ZLKsxRYUbZzwRvDfTmCB7HFKZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304813; c=relaxed/simple;
	bh=jo2BzBRrRJMYVX1EgU8hOrka+kTaZZ2coGuJC5mSa9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGrRIXOCyKL+4cbTE23qyRfQw1JqK/q2bl3BJNtoStJewSJYdMmzbr8tjyH2MkZF4jl9hLuRAhqacDXUEPVlrITVGvbDwYFl9N2M3VUXwgDYlemx++TqfrG+9Bp0OoT4HacSsRMRdP3NVDHf00cPqpKOfri0qokWM//+/N+s7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRFtePo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD6C116B1;
	Fri, 10 May 2024 01:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304812;
	bh=jo2BzBRrRJMYVX1EgU8hOrka+kTaZZ2coGuJC5mSa9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRFtePo+YEyD+qy4sC1+JJSrwUxDTsPjzlaO3jKndejZOJKx/aJJvzEK229uFiy5r
	 zjP6IgPuO5eGIO8vwen7wRlIpgsHXvcW8nQHIhGNf7JzZI+qONSq/V9C92aIHQ/lcn
	 3CsQwh48LMQTeq3SUn55svpVcdB9Vi4zPgotqsH4uiWl8oplnSOszq7OgE3F8Ot2tF
	 dYLTbEe40bOu/MU0h9kKqxJQYhOM1X5KckOHHPYdAKXzOOPNmfoQWE7DbnGPyIYP0U
	 hY0Vu3F+R5lzHTINSZhJp8UaM+KFOYr5IfnbST0QAOaLpBWb2DDBxrUeMkvtEKMGjB
	 o0/qGQVDs1iOQ==
Date: Fri, 10 May 2024 01:33:30 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v16 3/9] libfs: Introduce case-insensitive string
 comparison helper
Message-ID: <20240510013330.GI1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-4-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-4-eugen.hristev@collabora.com>

On Fri, Apr 05, 2024 at 03:13:26PM +0300, Eugen Hristev wrote:
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
> + * This is a filesystem helper for comparison with directory entries.
> + * generic_ci_d_compare should be used in VFS' ->d_compare instead.
> + *
> + * @parent: Inode of the parent of the dirent under comparison
> + * @name: name under lookup.
> + * @folded_name: Optional pre-folded name under lookup
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + *
> + * Test whether a case-insensitive directory entry matches the filename
> + * being searched.  If @folded_name is provided, it is used instead of
> + * recalculating the casefold of @name.
> + *
> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
> + * < 0 on error.
> + */
> +int generic_ci_match(const struct inode *parent,
> +		     const struct qstr *name,
> +		     const struct qstr *folded_name,
> +		     const u8 *de_name, u32 de_name_len)
> +{
> +	const struct super_block *sb = parent->i_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
> +	int res = 0;
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

If fscrypt_fname_disk_to_usr() returns an error and !sb_has_strict_encoding(sb),
then this function returns 0 (indicating no match) instead of the error code
(indicating an error).  Is that the correct behavior?  I would think that
strict_encoding should only have an effect on the actual name comparison.

> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +	if (folded_name->name) {
> +		if (dirent.len == folded_name->len &&
> +		    !memcmp(folded_name->name, dirent.name, dirent.len))
> +			goto out;
> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);

Shouldn't the memcmp be done with the original user-specified name, not the
casefolded name?  I would think that the user-specified name is the one that's
more likely to match the on-disk name, because of case preservation.  In most
cases users will specify the same case on both file creation and later access.

- Eric

