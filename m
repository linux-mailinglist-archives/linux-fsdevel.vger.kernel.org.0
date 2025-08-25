Return-Path: <linux-fsdevel+bounces-58985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC249B33AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC45F1887510
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA812D0C7D;
	Mon, 25 Aug 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="POwQCc5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A892D0278;
	Mon, 25 Aug 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113870; cv=none; b=FY/zq9+XYaM4EADT7EEI1RsMar4el2O38vn4ehkewFAJW+qzmnXocc4b5Im5aXTaZWeSwEC85uqYGGdEOF2SyiapJ39GsMRY4v9VVsrlvM7ec4925aupQulfjGNuEOMr6IFVW3Qm0f6+ER4eLOlqoVhxbHb0k+nJzQCX3ON/X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113870; c=relaxed/simple;
	bh=XHBoXoD67Yx74hzKym+Sk2iHmWZ1Sa4F0v5fKW3S0hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ns6HA4nblgZmrolWg435mIkcuC3qen89jIjTtVjfxzMoSSu+KTOhJC0Sj1J5tCdLcTYatZ9FcQs7PbL/JrxD4qFPIMITnM7MGSqc4nR4KhxlzZBAn0rC6cy7QNIdQAo3zzH2TsqhWLMwoQj+nsOBHjCRuptdktohbfEDlr79UYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=POwQCc5P; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52D3943373;
	Mon, 25 Aug 2025 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756113858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+BDbrF2ImSWufoscsZvanJuCMuSyyB4F+Zy1wd7ISY=;
	b=POwQCc5Px3GaGw3yylTzSQ9xEDDUIa+41J5/HlP0XRmV0mD1RKGZV5xt7RqX5Wnai07Qpb
	3zptf8eveY2HNDibMzuJ8+P9xFcNWy5lUPT8OWdgeOprtFlhQq+NL3Sk/3R4i5soA1SlMc
	8nYoAbY6IMgdnUNoNDcXDJZN6MUtqLPPsOkhFec29u97e5IWDmCUXnr3g0Pae+p9iWV6tr
	+q892cHAef7zLPc4bb1gA9LqLfVnbg2u5uri3QHrcLWjyyoKoQHYGKQtVUOhApkTraOEYS
	T3qIGI1sGTdPIlG1PY94QkzH7s3B9WqOkHOhNqjZN0/Flq7CTUEq1lR2CpCkGg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 2/9] fs: Create sb_same_encoding() helper
In-Reply-To: <20250822-tonyk-overlayfs-v6-2-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:05 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-2-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 05:24:15 -0400
Message-ID: <87ecsz69fk.fsf@mailhost.krisman.be>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> For cases where a file lookup can look in different filesystems (like in
> overlayfs), both super blocks must have the same encoding and the same
> flags. To help with that, create a sb_same_encoding() function.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>


Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>


> ---
>  include/linux/fs.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a4d353a871b094b562a87ddcffe8336a26c5a3e2..7de9e1e4839a2726f4355ddf2=
0b9babb74cc9681 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3747,6 +3747,24 @@ static inline bool sb_has_encoding(const struct su=
per_block *sb)
>  	return !!sb_encoding(sb);
>  }
>=20=20
> +/*
> + * Compare if two super blocks have the same encoding and flags
> + */
> +static inline bool sb_same_encoding(const struct super_block *sb1,
> +				    const struct super_block *sb2)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sb1->s_encoding =3D=3D sb2->s_encoding)
> +		return true;
> +
> +	return (sb1->s_encoding && sb2->s_encoding &&
> +	       (sb1->s_encoding->version =3D=3D sb2->s_encoding->version) &&
> +	       (sb1->s_encoding_flags =3D=3D sb2->s_encoding_flags));
> +#else
> +	return true;
> +#endif
> +}
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>  		unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

--=20
Gabriel Krisman Bertazi

