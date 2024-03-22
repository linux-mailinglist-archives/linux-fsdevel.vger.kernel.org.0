Return-Path: <linux-fsdevel+bounces-15133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E638874C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A391C20CEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664081750;
	Fri, 22 Mar 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+DCSaHC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iMJ5N/8y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i+DCSaHC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iMJ5N/8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187280059;
	Fri, 22 Mar 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145500; cv=none; b=lPMfhFf11QGBQzO8sIYW0tpjEIiUxxDvWJKcWxJoh7rh0Elz58Uo8gD1rjIr65kEkxp5ZgaPE8S6+7T5eV+wvwiq7D5bm5cC8F3PkDDywUchJHZg94v1+HO+CJnXZJi4xBrGl7jgKt6lPfS93pYizk6F7xMukdJ0W775wgsHYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145500; c=relaxed/simple;
	bh=mtr17MhmRQz+7hZNY3mNWDm7X7H/pBoEUAZnkiSDZWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lF+LDNFwuB29Wf7M9HfEiVdQl5y52HVoydykvFLf5fdnkcfMM+rweSlOfGBJVOinqHTLc1hYL0z/lAwUf10E4oWBEh0EKGbfopXZTlUseeSRmdb7/VC2nC1KW5LHqzBwl8MJboC6F8Yu/tk1EY7GPNkS/scXqHWlrBEC40gEhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+DCSaHC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iMJ5N/8y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i+DCSaHC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iMJ5N/8y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF29C38A8F;
	Fri, 22 Mar 2024 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711145496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTZ09ncmKCd8WkUQEbzrII1H6hejyxJNsILQlSmmkc0=;
	b=i+DCSaHCastt8j3z9SusKvybZUMm+JTSJQd4EcxLc2dhlAZj06dj7Js9m1BwY/qgfj73wV
	CKeniWdM4e0/nu6HyO5IHta94rFjYi0htoAsWPXea4Lp/RdvdpLIXtaQSy7WLavxztp46p
	vJUFt6NzRnckQxP2fXoOrbW+ghNMYPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711145496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTZ09ncmKCd8WkUQEbzrII1H6hejyxJNsILQlSmmkc0=;
	b=iMJ5N/8yUDUsqNpMRpxpGOdi4bp5VNayAK61HozHKt8IRaaoQwNuSxZbf9UMLzsu+h8pF0
	vTgiKlp/xqEyVtDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711145496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTZ09ncmKCd8WkUQEbzrII1H6hejyxJNsILQlSmmkc0=;
	b=i+DCSaHCastt8j3z9SusKvybZUMm+JTSJQd4EcxLc2dhlAZj06dj7Js9m1BwY/qgfj73wV
	CKeniWdM4e0/nu6HyO5IHta94rFjYi0htoAsWPXea4Lp/RdvdpLIXtaQSy7WLavxztp46p
	vJUFt6NzRnckQxP2fXoOrbW+ghNMYPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711145496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTZ09ncmKCd8WkUQEbzrII1H6hejyxJNsILQlSmmkc0=;
	b=iMJ5N/8yUDUsqNpMRpxpGOdi4bp5VNayAK61HozHKt8IRaaoQwNuSxZbf9UMLzsu+h8pF0
	vTgiKlp/xqEyVtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7C3C132FF;
	Fri, 22 Mar 2024 22:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ov9IhgC/mUEHgAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 22 Mar 2024 22:11:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,  linux-fsdevel@vger.kernel.org,
  Eugen Hristev <eugen.hristev@collabora.com>,  brauner@kernel.org,
  jack@suse.cz,  Eric Biggers <ebiggers@google.com>,
  linux-kernel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  kernel@collabora.com,  Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [f2fs-dev] [PATCH v10 7/8] ext4: Move CONFIG_UNICODE defguards
 into the code flow
In-Reply-To: <20240215042654.359210-8-eugen.hristev@collabora.com> (Eugen
	Hristev via Linux-f2fs-devel's message of "Thu, 15 Feb 2024 06:26:53
	+0200")
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
	<20240215042654.359210-8-eugen.hristev@collabora.com>
Date: Fri, 22 Mar 2024 18:11:35 -0400
Message-ID: <87ttkx9aso.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i+DCSaHC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="iMJ5N/8y"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.53)[80.55%]
X-Spam-Score: -4.04
X-Rspamd-Queue-Id: DF29C38A8F
X-Spam-Flag: NO

Eugen Hristev via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/crypto.c | 19 +++----------------
>  fs/ext4/ext4.h   | 33 +++++++++++++++++++++------------
>  fs/ext4/namei.c  | 14 +++++---------
>  fs/ext4/super.c  |  4 +---
>  4 files changed, 30 insertions(+), 40 deletions(-)
>
> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
> index 7ae0b61258a7..1d2f8b79529c 100644
> --- a/fs/ext4/crypto.c
> +++ b/fs/ext4/crypto.c
> @@ -31,12 +31,7 @@ int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
>  
>  	ext4_fname_from_fscrypt_name(fname, &name);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> -	if (err)
> -		ext4_fname_free_filename(fname);
> -#endif
> -	return err;
> +	return ext4_fname_setup_ci_filename(dir, iname, fname);

This shouldn't remove the error path.  It effectively reintroduces the
memory leak fixed by commit 7ca4b085f430 ("ext4: fix memory leaks in
ext4_fname_{setup_filename,prepare_lookup}").

This patch was only about inlining the codeguards, so it shouldn't be
changing the logic.

>  }
>  
>  int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
> @@ -51,12 +46,7 @@ int ext4_fname_prepare_lookup(struct inode *dir, struct dentry *dentry,
>  
>  	ext4_fname_from_fscrypt_name(fname, &name);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
> -	if (err)
> -		ext4_fname_free_filename(fname);
> -#endif
> -	return err;
> +	return ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
>  }

likewise


-- 
Gabriel Krisman Bertazi

