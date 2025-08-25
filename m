Return-Path: <linux-fsdevel+bounces-58982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12632B33AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FF1B25092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AC2D0C7F;
	Mon, 25 Aug 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="kvn0mNy8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5572BDC09;
	Mon, 25 Aug 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113574; cv=none; b=AWRozJCCE6e1W6hhuDgISlZbCe34gkMmdVkct6yZg8EbFnVAwx8ilnTV+/V9oGOon2S/Lm/nfPhKc0G1mvZTjU/hIEZJFv+2H6harB0e3uzOwKwlVIVXxPajqL3EAnYUDg9u49IEwmukhpynvyxsxNx6wHwZ9FfCrSgxeClAzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113574; c=relaxed/simple;
	bh=uE5mnGbZRWRnWNvy0/RvSU78B/PHJkLHIRBN7Zor5uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWDWUmBoAsExT5mW0R9bC7dEwgyj405057X5to8ImJJUjc34c0i5eRdjWlybxFcWt6fEDAilBtXM7CugW+osaN/zlMzcuYgVUdfGuBJv84Gahi8RPrac6+RSNjU00XyowAyHbeBO86NUNuoW8GVw0CEcQlBl6OHeR3kda8F/aJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=kvn0mNy8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id B731B4336C;
	Mon, 25 Aug 2025 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756113562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcaET94D0CtmDnUPywhTcMXStXKKCVgM0X4nxaZ9MJw=;
	b=kvn0mNy86keWTKP/Rk8EaZBoeKIKIc1WapBgvwGKBauW8HY1h9d6ZzRgqU/E/XWqDyV7/T
	oznP4I0cHh0t2ykC3/KUx5r2Vvu4tb8TFJLhoowPCBPAdy1OMN1I/SQTrE207lcyqjajud
	ovVGKoiwxI8CPg0ASC3InzlzJ0pAo1ZH8ck+V24l+4jbLeCUXICMCAvyNb5Ndb9LTfxDKC
	K4qhZizUWgaiF9ZdazKB5kPCG5ZyBgRVVR8DpGWSr//H+apo029saQfQuF197+4L04wGqA
	qh+tlLpyeN3YQ33Wk5il2gMOogeOL+Zl7VfSzswpXhjprh/edHZ3PYFdX0j9YA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 1/9] fs: Create sb_encoding() helper
In-Reply-To: <20250822-tonyk-overlayfs-v6-1-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:04 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-1-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 05:19:19 -0400
Message-ID: <87ikib69ns.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Filesystems that need to deal with the super block encoding need to use
> a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
> not declared otherwise. In order to move this if/endif guards outside of
> the filesytem code and make it simpler, create a new function that
> returns the s_encoding member of struct super_block if Unicode is
> enabled, and return NULL otherwise.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

> ---
>  include/linux/fs.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e1d4fef5c181d291a7c685e5897b2c018df439ae..a4d353a871b094b562a87ddcf=
fe8336a26c5a3e2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3733,15 +3733,20 @@ static inline bool generic_ci_validate_strict_nam=
e(struct inode *dir, struct qst
>  }
>  #endif
>=20=20
> -static inline bool sb_has_encoding(const struct super_block *sb)
> +static inline struct unicode_map *sb_encoding(const struct super_block *=
sb)
>  {
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	return !!sb->s_encoding;
> +	return sb->s_encoding;
>  #else
> -	return false;
> +	return NULL;
>  #endif
>  }
>=20=20
> +static inline bool sb_has_encoding(const struct super_block *sb)
> +{
> +	return !!sb_encoding(sb);
> +}
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>  		unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

--=20
Gabriel Krisman Bertazi

