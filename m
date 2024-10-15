Return-Path: <linux-fsdevel+bounces-32009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67DC99F238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EABB236E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0C1F76C3;
	Tue, 15 Oct 2024 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="gHZ4donL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F41F7065;
	Tue, 15 Oct 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007997; cv=none; b=gxHNS05JyDEkapOzzrSAM4XwBZhKMI/Oih4YXyrMnESqFgBHizArothtL/u/TcUq6hGo6BJH4QLaW7km2m82tI7fKgqZSvolEEkgMcjW/NUMNPPW2sZsJDrsv5kr7zOTiUPKz18ayQ91M+n7IYn3NVAlT7ryF7DRd1+w5kvUh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007997; c=relaxed/simple;
	bh=2mK+ZWFmR/HEmxNXgK8igOSG3DBZjetA7eR4+41kzn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bA/z7G4WrOUWUvPQOWbK8nd3jhabxI7N+sRY39Cw+Vd93WKjKTZ3lZ2M0j9EDKneJEpeioHfyx/wqNi2EWYWCn+fFZDCCwr2gGTAfvTv4FZ4JLUZ9NPs5o1pErqxJi34NNyTl+Al618Kg4CMPzT+6DFKuVUtwCS0GQjsRh0stDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=gHZ4donL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A7E3240003;
	Tue, 15 Oct 2024 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1729007992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muVbXj6XjdM0+48mRJ+sHlgnyRTe+ujByi/N8a3eBTU=;
	b=gHZ4donLANwwj7WEZd0j8tA3ic8bZf2ia6q3HlhTGiET+Nvgh3TjDYlHXDistcF+lyHcx2
	K0qrxStda8Eaw46w7rFD+mE5WWeXz86nJ/rdcqf4KW8x7aRh8RY0xKv0MhmQB/IYWJIOkH
	vSYxKazzw+dMgcNmipFPOlMp0aeRSfpjfHdvgRLzAhiIdVV5VjEEIYgW2MaT91tyOhb9V7
	0QwsOwXm0Y32jnBFs52zUfvQC8j8Lbx45RjU/hdZMntyh5dWa11406j3HEDbsTtdVoRNAU
	bWTDsEOH8FtsM0mwmj7RBwRUOepKNZt8+Y0Glwd+RaU+SntsCTlxJ0ZXfT7Img==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 01/10] libfs: Create the helper function
 generic_ci_validate_strict_name()
In-Reply-To: <20241010-tonyk-tmpfs-v6-1-79f0ae02e4c8@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 10 Oct 2024 16:39:36 -0300")
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
	<20241010-tonyk-tmpfs-v6-1-79f0ae02e4c8@igalia.com>
Date: Tue, 15 Oct 2024 11:59:48 -0400
Message-ID: <87bjzls6ff.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

> +static inline bool generic_ci_validate_strict_name(struct inode *dir, st=
ruct qstr *name)
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

There is something fishy here.  Concerningly, the fstests test doesn't
catch it.

utf8_validate is defined as:

  int utf8_validate(const struct unicode_map *um, const struct qstr *str)

Which returns 0 on success and !0 on error. Thus, when casting to bool,
the return code should be negated.

But generic/556 doesn't fail. That's because we are over cautious, and
also check the string at the end of generic_ci_d_hash.  So we never
really reach utf8_validate in the tested case.

But if you comment the final if in generic_ci_d_hash, you'll see this
patchset regresses the fstests case generic/556 over ext4.

We really need the check in both places, though.  We don't want to rely
on the behavior of generic_ci_d_hash to block invalid filenames, as that
might change.

--=20
Gabriel Krisman Bertazi

