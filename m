Return-Path: <linux-fsdevel+bounces-29208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE279977166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB221B258DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FCA1C68A7;
	Thu, 12 Sep 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="ZULENZAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F41C1731;
	Thu, 12 Sep 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168590; cv=none; b=X3Kx80LmjEnf7inyRGycPNxWV9YrWysgZ4RiU1TV/t/ok0i1NxOZq7iVUEn1fJ9w8r3IlhvNy54XSAV/yJYOI4BeZDSYh+GmFVsFjgDu2lk9tAIyf1xpCMd44ZOP2hHNsMMUk+WWiU0PQ8MWHo6thubqwpF/Cm7000anq9BW2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168590; c=relaxed/simple;
	bh=EHbInnzeVOwdq+QTXFprolW5A83xLgCi7GxP2s/eGHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GPqGTwAAHeK6TVq+RBbeQ4uc2XOmRLJoZF5CBdGBimUAISifa1V6KNqTiyoQOzBQlId32WPqEAkBw8u5D5rsmICfx/adGmpZVRtXosLWSKu4gVmSHEz78rGN9pw3Zhhz8+NThJGY91Cx31r1g4AEsLque2XFHbNuoC97BsR2FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=ZULENZAD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DF8040004;
	Thu, 12 Sep 2024 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhVEzySNXDFTJF7lljGKHlz+SIBbvJp0eSgo4Oo37/k=;
	b=ZULENZADwMpQGMgo4yZ/4tnPL8DAAPc85CMRm+8URvtrlmis1HLvsdb5KjgeIqxhaeG9/C
	JRcRYXRX8ehBz+0sfUrBhShbZACnMVTrlZUscCt3wkIFykU+TeDlsEeYvFcdCX8GXR2rHd
	pdNVvQ425fwCgSGRb4lrXz/ZEXpt+dFFTh49dFocTy4Hf1Kt9BYKJeHXVux4VocdHNoRiw
	ZiflCt4/ukJ7sHIXTDxIoQDOo2iCpUBgWZ2KCvzmqcZj1xUpGTbZ0sB0GSFfYKNp2eCQW/
	gA3b6y8yXZPcgI1HghtM3KB7Pt6wPFhwONjA/U9NDBlf6Dhu1IQbvCuXpyHBZw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 01/10] libfs: Create the helper function
 generic_ci_validate_strict_name()
In-Reply-To: <20240911144502.115260-2-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:44:53 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-2-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:16:22 -0400
Message-ID: <87a5gck7i1.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Create a helper function for filesystems do the checks required for
> casefold directories and strict encoding.
>
> Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Moved function to libfs and adpated its name
> - Wrapped at 72 chars column
> - Decomposed the big if (...) to be more clear
> ---
>  fs/libfs.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  2 files changed, 39 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8aa34870449f..99fb36b48708 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1928,6 +1928,44 @@ int generic_ci_match(const struct inode *parent,
>  	return !res;
>  }
>  EXPORT_SYMBOL(generic_ci_match);
> +
> +/**
> + * generic_ci_validate_strict_name - Check if a given name is suitable
> + * for a directory
> + *
> + * This functions checks if the proposed filename is valid for the
> + * parent directory. That means that only valid UTF-8 filenames will be
> + * accepted for casefold directories from filesystems created with the
> + * strict encoding flag.  That also means that any name will be
> + * accepted for directories that doesn't have casefold enabled, or
> + * aren't being strict with the encoding.
> + *
> + * @dir: inode of the directory where the new file will be created
> + * @name: name of the new file
> + *
> + * Return:
> + * * True if the filename is suitable for this directory. It can be
> + * true if a given name is not suitable for a strict encoding
> + * directory, but the directory being used isn't strict
> + * * False if the filename isn't suitable for this directory. This only
> + * happens when a directory is casefolded and the filesystem is strict
> + * about its encoding.
> + */
> +bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *nam=
e)
> +{
> +	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
> +		return true;
> +
> +	/*
> +	 * A casefold dir must have a encoding set, unless the filesystem
> +	 * is corrupted
> +	 */
> +	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
> +		return true;
> +
> +	return utf8_validate(dir->i_sb->s_encoding, name);
> +}
> +EXPORT_SYMBOL(generic_ci_validate_strict_name);
>  #endif
>=20=20
>  #ifdef CONFIG_FS_ENCRYPTION
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..937142950dfe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3385,6 +3385,7 @@ extern int generic_ci_match(const struct inode *par=
ent,
>  			    const struct qstr *name,
>  			    const struct qstr *folded_name,
>  			    const u8 *de_name, u32 de_name_len);
> +bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *nam=
e);

As mentioned in the other patch, please make this an inline helper.  But
also, the declaration needs to be guarded by CONFIG_UNICODE.

>=20=20
>  static inline bool sb_has_encoding(const struct super_block *sb)
>  {

--=20
Gabriel Krisman Bertazi

