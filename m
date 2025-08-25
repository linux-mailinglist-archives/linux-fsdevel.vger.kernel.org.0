Return-Path: <linux-fsdevel+bounces-59035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66901B33FAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C33B899E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740615624D;
	Mon, 25 Aug 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KLeFCrbJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2um9rrJW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KLeFCrbJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2um9rrJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037478F58
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125522; cv=none; b=nN1QgSv/2VZjSQkKMLsx9HnSai0Q2/KoOHO8QIb0eWCgqyMzJZ/3Cy8zYQE6a9U00jLuXLt8FdFfymkquufjcxSjQaAmdKrq4gSpaWjsSAKW8U8pSEZMVFFegFPAOud+sJUTlcAFuD98MonWjVnQ45qS+RkgceZ7Udn4lSE1tNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125522; c=relaxed/simple;
	bh=X3I3acS3cdFFshCVRbV9y/PaUCtuRZm5VUxrSZbBRfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usdE+9aPtZI1cDTF9Nec0EDMghJ1aNgqROGGoAI4UXeMgmMEyDhnjiVZHSv7T4yderqYnk/W0V2AcsTmJHHi7J7w347hmaIDoFTydc8eTZvUy1v4jSd5faq1Z9vBbc8QZMzo7OWvdNIVt1MZGCeiAGD0oUfcwetJlvwtPRr1V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KLeFCrbJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2um9rrJW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KLeFCrbJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2um9rrJW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3088D1F7A0;
	Mon, 25 Aug 2025 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756125517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj8WWGkayyH3J/FhPAZ32Ye1VixZrdXbP3zOfgCaq/4=;
	b=KLeFCrbJhdwyZ0Oo7tMhI6sC+dsJAVO0CFKXCNKTnCqm+n9oS4MDSAimXzkKMqpawUuiip
	UMNtJnGZblt/E6Oj3o6ixEIa9HX4LxENL7SSwzOj/fPRdY+Mp9nrN/AdWbVwZDobCPyfLf
	D4unlpvoQqyjZM6ZM0k1P4/q0Tdp6IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756125517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj8WWGkayyH3J/FhPAZ32Ye1VixZrdXbP3zOfgCaq/4=;
	b=2um9rrJWZuu/1symJbkCaFgW1ClTpD+3HaMp/VeEgL7P4NR7pgaed4QhzcgD10hgLYyK5R
	nP4MC80m8E4wQBAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KLeFCrbJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2um9rrJW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756125517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj8WWGkayyH3J/FhPAZ32Ye1VixZrdXbP3zOfgCaq/4=;
	b=KLeFCrbJhdwyZ0Oo7tMhI6sC+dsJAVO0CFKXCNKTnCqm+n9oS4MDSAimXzkKMqpawUuiip
	UMNtJnGZblt/E6Oj3o6ixEIa9HX4LxENL7SSwzOj/fPRdY+Mp9nrN/AdWbVwZDobCPyfLf
	D4unlpvoQqyjZM6ZM0k1P4/q0Tdp6IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756125517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj8WWGkayyH3J/FhPAZ32Ye1VixZrdXbP3zOfgCaq/4=;
	b=2um9rrJWZuu/1symJbkCaFgW1ClTpD+3HaMp/VeEgL7P4NR7pgaed4QhzcgD10hgLYyK5R
	nP4MC80m8E4wQBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF2FD136DB;
	Mon, 25 Aug 2025 12:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hyG0KUxZrGjJFgAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 25 Aug 2025 12:38:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
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
Date: Mon, 25 Aug 2025 08:38:34 -0400
Message-ID: <87sehf4lv9.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3088D1F7A0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,mit.edu,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,igalia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

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

FWIW, sb_has_encoding is completely superfluous now.  It is also only
used by overlayfs itself, so it should be easy to drop in favor of your
new helper in the following patches.  It even has a smaller function
name :)

>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>  		unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *);

--=20
Gabriel Krisman Bertazi

