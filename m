Return-Path: <linux-fsdevel+bounces-42616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0EA450D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D7718929C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E52356CB;
	Tue, 25 Feb 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pUGf76oi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JkKYjJTe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pUGf76oi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JkKYjJTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373332054F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524991; cv=none; b=enzHxrbs0p2lM1vS1o9DZT3+BvnSbCPBXb8i4Fgi9KlWRxHvUQedA0mg5EiJT7PZPDiIo9sIAg27v7sInf/GNrKYO0nMDljj8e2zBtarB/k6uhyrLw1Z4CLQuoXO7wZmsduwTubmeJh9zpcVFlEcbFh8L0fZrw4ng5MpG8Gw1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524991; c=relaxed/simple;
	bh=FraLCERrpqkMdV8b8FoiVo9StO8B66Jw2WqFKYg+NPU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IiUczCRd3rtMfRJDDU/xl1yNL2CYJpqceIgnht624+CWAQpWzjkdfA+QL4MnpnMhw2OC3ePa0t6GiCDnew7HgWLtwfA1JkcZjOxo7Pt2+CXEn5W6qJhxyBfXyjfZd5gZ86+jn7MhTQ1whVW0U650bRjBcbkzEcpSdv8TlnxmrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pUGf76oi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JkKYjJTe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pUGf76oi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JkKYjJTe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED4C1F38D;
	Tue, 25 Feb 2025 23:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740524988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jekEtcgApMeslkidU5vi9OfsEx3cNd5zvOn8LVAOeOw=;
	b=pUGf76oiuBFAIvs6UTBG+StHeXtyYm6P5POApZewJ73bO9Q0R9cqjoITCPhrpr85ripqJ0
	qzujJvmNLmngQw6A7/iEh2Md8xYOIloaN74KTXdOxBLoNw2E8+N7NoE9FN/st/ajM3DhYy
	f9HO+Wz2ZtkiwxNhrSBMCOhGL9itOZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740524988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jekEtcgApMeslkidU5vi9OfsEx3cNd5zvOn8LVAOeOw=;
	b=JkKYjJTeTfUFPo69gnmYOiyGnXjj+dG/FwkrT7fW1RuYsPFHOcSUwohO27WUY5y2BySVHS
	v8sp2jsmIheiA8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740524988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jekEtcgApMeslkidU5vi9OfsEx3cNd5zvOn8LVAOeOw=;
	b=pUGf76oiuBFAIvs6UTBG+StHeXtyYm6P5POApZewJ73bO9Q0R9cqjoITCPhrpr85ripqJ0
	qzujJvmNLmngQw6A7/iEh2Md8xYOIloaN74KTXdOxBLoNw2E8+N7NoE9FN/st/ajM3DhYy
	f9HO+Wz2ZtkiwxNhrSBMCOhGL9itOZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740524988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jekEtcgApMeslkidU5vi9OfsEx3cNd5zvOn8LVAOeOw=;
	b=JkKYjJTeTfUFPo69gnmYOiyGnXjj+dG/FwkrT7fW1RuYsPFHOcSUwohO27WUY5y2BySVHS
	v8sp2jsmIheiA8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0718813332;
	Tue, 25 Feb 2025 23:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jFNjJLlNvmffLAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Feb 2025 23:09:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 09/21] make d_set_d_op() static
In-reply-to: <20250224212051.1756517-9-viro@zeniv.linux.org.uk>
References: <>, <20250224212051.1756517-9-viro@zeniv.linux.org.uk>
Date: Wed, 26 Feb 2025 10:09:42 +1100
Message-id: <174052498256.102979.671849437813888877@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 25 Feb 2025, Al Viro wrote:
> Convert the last user (d_alloc_pseudo()) and be done with that.
> Any out-of-tree filesystem using it should switch to d_splice_alias_ops()
> or, better yet, check whether it really needs to have ->d_op vary among
> its dentries.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  Documentation/filesystems/porting.rst | 11 +++++++++++
>  fs/dcache.c                           |  5 ++---
>  include/linux/dcache.h                |  1 -
>  3 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesyst=
ems/porting.rst
> index 004cd69617a2..61b5771dde53 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1164,3 +1164,14 @@ magic.
> =20
>  If your filesystem sets the default dentry_operations, use set_default_d_o=
p()
>  rather than manually setting sb->s_d_op.
> +
> +---
> +
> +**mandatory**
> +
> +d_set_d_op() is no longer exported (or public, for that matter); _if_
> +your filesystem really needed that, make use of d_splice_alias_ops()
> +to have them set.  Better yet, think hard whether you need different
> +->d_op for different dentries - if not, just use set_default_d_op()
> +at mount time and be done with that.  Currently procfs is the only
> +thing that really needs ->d_op varying between dentries.
> diff --git a/fs/dcache.c b/fs/dcache.c
> index a4795617c3db..29db27228d97 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1796,7 +1796,7 @@ struct dentry *d_alloc_pseudo(struct super_block *sb,=
 const struct qstr *name)
>  	if (likely(dentry)) {
>  		dentry->d_flags |=3D DCACHE_NORCU;
>  		if (!dentry->d_op)
> -			d_set_d_op(dentry, &anon_ops);
> +			dentry->d_op =3D &anon_ops;

This is safe because d_op_flags(anon_ops) is zero so there is no need to
update dentry->d_flags.  I wonder if that deserves a comment.

Thanks,
NeilBrown


>  	}
>  	return dentry;
>  }
> @@ -1837,7 +1837,7 @@ static unsigned int d_op_flags(const struct dentry_op=
erations *op)
>  	return flags;
>  }
> =20
> -void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
> +static void d_set_d_op(struct dentry *dentry, const struct dentry_operatio=
ns *op)
>  {
>  	unsigned int flags =3D d_op_flags(op);
>  	WARN_ON_ONCE(dentry->d_op);
> @@ -1846,7 +1846,6 @@ void d_set_d_op(struct dentry *dentry, const struct d=
entry_operations *op)
>  	if (flags)
>  		dentry->d_flags |=3D flags;
>  }
> -EXPORT_SYMBOL(d_set_d_op);
> =20
>  void set_default_d_op(struct super_block *s, const struct dentry_operation=
s *ops)
>  {
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index e8cf1d0fdd08..5a03e85f92a4 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -242,7 +242,6 @@ extern void d_instantiate_new(struct dentry *, struct i=
node *);
>  extern void __d_drop(struct dentry *dentry);
>  extern void d_drop(struct dentry *dentry);
>  extern void d_delete(struct dentry *);
> -extern void d_set_d_op(struct dentry *dentry, const struct dentry_operatio=
ns *op);
> =20
>  /* allocate/de-allocate */
>  extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
> --=20
> 2.39.5
>=20
>=20


