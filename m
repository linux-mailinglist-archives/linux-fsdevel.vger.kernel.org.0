Return-Path: <linux-fsdevel+bounces-32025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495C99F5B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB761C237C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E22036F8;
	Tue, 15 Oct 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYks4C3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d2oXo14o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OYks4C3z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d2oXo14o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06492036E0;
	Tue, 15 Oct 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017325; cv=none; b=HFU7HENySsU23COb2OOOx7/KAARYRg2c9CDaST66xzC6bklwVyfSZQkcTwgYU/VMHdjYbjHUxovgQKabB0sMLD3C5nTrAnXn49WIO+pzUS/ECGaGd5+ZIcyMXythM4nFdnnwQWLlh2kLHPm090h6dT9/ujclen3oHRmcanPYLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017325; c=relaxed/simple;
	bh=sXBjcMEip2iMYc6Cb9tM3ec1NMU3XjJtMG0zksq4F8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPvT5jfIUITtoRiqYAMlRiN/egn/vlVHrtzCckUxqctTHYbnrCoSAy+LO2kQpgP4vV9miu1T3nnYEqXhrAHe6I/YsZV0hy/D5DI6rGTRuTn0elEl/pdb+1EUmeLGgETQb2MS5ePcvWoesRtGnXL4Hs+k0REWd3BL4YJD0Zy0vxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYks4C3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d2oXo14o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OYks4C3z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d2oXo14o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CC5721B9B;
	Tue, 15 Oct 2024 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729017322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZstxhVk9QOrcNizGJVVQwN2mCzQEZY3vaa7cVcnk/k=;
	b=OYks4C3zNQfaTB0uJRa597TOaL1xPd5XsUl+zquiDOI2keIPIA9VPl6RcMRUE5tqXmdLD8
	hKx+QhgkSbGqJoce02xRLEUwICxqRlq7xUN7uHRPrvCKgbE0u1gKCCOcqe+WWu9HRyaxVr
	yxat4EWnlUyYQBgKmc2ik2G8QsDcADI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729017322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZstxhVk9QOrcNizGJVVQwN2mCzQEZY3vaa7cVcnk/k=;
	b=d2oXo14ovteimlXL6Ac5e5DJ+Di4YEbS/EkR5bQgMaxxV7+/gVFD4ffVwwISEs26y+Qz/b
	ryOd5Kyr966hXdDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729017322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZstxhVk9QOrcNizGJVVQwN2mCzQEZY3vaa7cVcnk/k=;
	b=OYks4C3zNQfaTB0uJRa597TOaL1xPd5XsUl+zquiDOI2keIPIA9VPl6RcMRUE5tqXmdLD8
	hKx+QhgkSbGqJoce02xRLEUwICxqRlq7xUN7uHRPrvCKgbE0u1gKCCOcqe+WWu9HRyaxVr
	yxat4EWnlUyYQBgKmc2ik2G8QsDcADI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729017322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZstxhVk9QOrcNizGJVVQwN2mCzQEZY3vaa7cVcnk/k=;
	b=d2oXo14ovteimlXL6Ac5e5DJ+Di4YEbS/EkR5bQgMaxxV7+/gVFD4ffVwwISEs26y+Qz/b
	ryOd5Kyr966hXdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFF8D13A53;
	Tue, 15 Oct 2024 18:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T6M/J+m1DmeoTQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 15 Oct 2024 18:35:21 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Hugh Dickins <hughd@google.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jonathan Corbet <corbet@lwn.net>,
  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 07/10] tmpfs: Add casefold lookup support
In-Reply-To: <20241010-tonyk-tmpfs-v6-7-79f0ae02e4c8@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 10 Oct 2024 16:39:42 -0300")
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
	<20241010-tonyk-tmpfs-v6-7-79f0ae02e4c8@igalia.com>
Date: Tue, 15 Oct 2024 14:35:20 -0400
Message-ID: <87wmi9qknr.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:


> @@ -4663,10 +4756,24 @@ static int shmem_fill_super(struct super_block *s=
b, struct fs_context *fc)
>  	sb->s_export_op =3D &shmem_export_ops;
>  	sb->s_flags |=3D SB_NOSEC | SB_I_VERSION;
>=20=20
> -	sb->s_d_op =3D &simple_dentry_operations;
> +	if (!ctx->encoding && ctx->strict_encoding) {
> +		pr_err("tmpfs: strict_encoding option without encoding is forbidden\n"=
);
> +		error =3D -EINVAL;
> +		goto failed;
> +	}
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		sb->s_d_op =3D &shmem_ci_dentry_ops;
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
> +	}
> +#endif

Actually...

The previous patch moved the dentry ops configuration for the !casefolded c=
ase to this
place, only for thsi patch to remove it.  Drop patch 6, instead?

> +
>  #else
>  	sb->s_flags |=3D SB_NOUSER;
> -#endif
> +#endif /* CONFIG_TMPFS */
>  	sbinfo->max_blocks =3D ctx->blocks;
>  	sbinfo->max_inodes =3D ctx->inodes;
>  	sbinfo->free_ispace =3D sbinfo->max_inodes * BOGO_INODE_SIZE;
> @@ -4940,6 +5047,8 @@ int shmem_init_fs_context(struct fs_context *fc)
>  	ctx->uid =3D current_fsuid();
>  	ctx->gid =3D current_fsgid();
>=20=20
> +	ctx->encoding =3D NULL;
> +
>  	fc->fs_private =3D ctx;
>  	fc->ops =3D &shmem_fs_context_ops;
>  	return 0;

--=20
Gabriel Krisman Bertazi

