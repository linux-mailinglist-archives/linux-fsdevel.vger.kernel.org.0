Return-Path: <linux-fsdevel+bounces-15226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2488ABB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BD01F6212F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551C131737;
	Mon, 25 Mar 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mrFZOgOi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4/Yvcn8T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BWf6VYBA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xCG5b50G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB150248;
	Mon, 25 Mar 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384004; cv=none; b=fAbMRFZgFlRDQ2YjHTcxLvlWjKEDpKOtimuoaae6iGYeozFz9YsbldzltK8YGTgQgEBGHp+GvhR4Fg2/O4g8HzVBLR/bAHbxvMU+5NXk86nfWaLRVqbKX+iLvLu+9AIorQskeRl9eJ0JP4Yli1W/Xw8lS3cbrcHv96BWqBELLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384004; c=relaxed/simple;
	bh=V6sqoAqJ7i7dh2ESkwK1PkgUFkhkxCtWlGMo+TiLqjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctwXfwhyIAUebLfo5tXBrsQvM08/MkN01zTfgPGtb5ZB2Yukxn0fpsstpcGglidkZSbFn1K3w3uL9bL+fn2Pd8qWQKIr5MYOozdSi4tNRMUD8hXcYgmI16TKO7K26o3WA479fDIfsiEe9IB/sx47g5WY4RQLjQTree/QfmVluaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mrFZOgOi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4/Yvcn8T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BWf6VYBA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xCG5b50G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6EAC5C90A;
	Mon, 25 Mar 2024 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711384000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WThhszHeU//Rn2fJzvzyuvkfkPtE9gPEySysSjnivks=;
	b=mrFZOgOi12pLbOQ7oT+rnFcub4rPm5E4q3euVX0uV9bVmaxKCBrpH+cuI7LW2ePTT+y0Pn
	47A4RAjy6JfQP1785AKY9hgvthTUj0JJSjLnpRytu0/zl90tK6VQK8lkhvklvEGQMrwIuo
	DuVw0XoyZm9e3z6xu0bWexaG+pSYtIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711384000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WThhszHeU//Rn2fJzvzyuvkfkPtE9gPEySysSjnivks=;
	b=4/Yvcn8TXQcPf0e7bI1evj/lQ1gd5qTsHIdEsmEoHKb1RD+PH/igWmNL7PXvGE0ozNAoLg
	a8e+fxnRq3534MDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711383998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WThhszHeU//Rn2fJzvzyuvkfkPtE9gPEySysSjnivks=;
	b=BWf6VYBAVqOASPU5DE5X9OS5DTw31U7zWNlXe2sk9i54kNcyf1Vlg8ljhDSimFLfmHxlE7
	GyFOev61YoGQrPaBKEDd/1uck5Pf33OVIo2HJYZ8ZlJNfxYzC67qwGYobTfQs40LMMEIRB
	ESClhQqgeX2uxL3Q96lgSdETTC98R6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711383998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WThhszHeU//Rn2fJzvzyuvkfkPtE9gPEySysSjnivks=;
	b=xCG5b50G7PvmnwFPyZTszr5GBE229eX2pzuy/JVPVUQT3YjHh//PS5TiP9+312Xm2nAIUs
	AImV+/iM4oNd6zAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8496213503;
	Mon, 25 Mar 2024 16:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 00xLGr6lAWaZFwAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 25 Mar 2024 16:26:38 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v14 8/9] ext4: Move CONFIG_UNICODE defguards into the
 code flow
In-Reply-To: <20240320084622.46643-9-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Wed, 20 Mar 2024 10:46:21 +0200")
References: <20240320084622.46643-1-eugen.hristev@collabora.com>
	<20240320084622.46643-9-eugen.hristev@collabora.com>
Date: Mon, 25 Mar 2024 12:26:37 -0400
Message-ID: <87edbynupu.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
>
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
>  }

Oops. I ended up replying to v10 but it still applies in the latest
version. copying it here for reference:

  This shouldn't remove the error path.  It effectively reintroduces the
  memory leak fixed by commit 7ca4b085f430 ("ext4: fix memory leaks in
  ext4_fname_{setup_filename,prepare_lookup}").

  This patch was only about inlining the codeguards, so it shouldn't be
  changing the logic.

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
>  
>  void ext4_fname_free_filename(struct ext4_filename *fname)
> @@ -70,10 +60,7 @@ void ext4_fname_free_filename(struct ext4_filename *fname)
>  	fname->usr_fname = NULL;
>  	fname->disk_name.name = NULL;
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	kfree(fname->cf_name.name);
> -	fname->cf_name.name = NULL;
> -#endif
> +	ext4_fname_free_ci_filename(fname);
>  }
>  
>  static bool uuid_is_zero(__u8 u[16])
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4061d11b9763..c68f48f706cd 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2740,8 +2740,25 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  extern int ext4_fname_setup_ci_filename(struct inode *dir,
> -					 const struct qstr *iname,
> -					 struct ext4_filename *fname);
> +					const struct qstr *iname,
> +					struct ext4_filename *fname);
> +
> +static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
> +{
> +	kfree(fname->cf_name.name);
> +	fname->cf_name.name = NULL;
> +}
> +#else
> +static inline int ext4_fname_setup_ci_filename(struct inode *dir,
> +					       const struct qstr *iname,
> +					       struct ext4_filename *fname)
> +{
> +	return 0;
> +}
> +
> +static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
> +{
> +}
>  #endif
>  
>  /* ext4 encryption related stuff goes here crypto.c */
> @@ -2764,16 +2781,11 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
>  					    int lookup,
>  					    struct ext4_filename *fname)
>  {
> -	int err = 0;
>  	fname->usr_fname = iname;
>  	fname->disk_name.name = (unsigned char *) iname->name;
>  	fname->disk_name.len = iname->len;
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	err = ext4_fname_setup_ci_filename(dir, iname, fname);
> -#endif
> -
> -	return err;
> +	return ext4_fname_setup_ci_filename(dir, iname, fname);
>  }
>  
>  static inline int ext4_fname_prepare_lookup(struct inode *dir,
> @@ -2785,10 +2797,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
>  
>  static inline void ext4_fname_free_filename(struct ext4_filename *fname)
>  {
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	kfree(fname->cf_name.name);
> -	fname->cf_name.name = NULL;
> -#endif
> +	ext4_fname_free_ci_filename(fname);
>  }
>  
>  static inline int ext4_ioctl_get_encryption_pwsalt(struct file *filp,
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 3268cf45d9db..a5d9e5b01015 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1834,8 +1834,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
>  		}
>  	}
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	if (!inode && IS_CASEFOLDED(dir)) {
> +	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
>  		/* Eventually we want to call d_add_ci(dentry, NULL)
>  		 * for negative dentries in the encoding case as
>  		 * well.  For now, prevent the negative dentry
> @@ -1843,7 +1842,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
>  		 */
>  		return NULL;
>  	}
> -#endif
> +
>  	return d_splice_alias(inode, dentry);
>  }
>  
> @@ -3173,16 +3172,14 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
>  	ext4_fc_track_unlink(handle, dentry);
>  	retval = ext4_mark_inode_dirty(handle, dir);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
>  	/* VFS negative dentries are incompatible with Encoding and
>  	 * Case-insensitiveness. Eventually we'll want avoid
>  	 * invalidating the dentries here, alongside with returning the
>  	 * negative dentries at ext4_lookup(), when it is better
>  	 * supported by the VFS for the CI case.
>  	 */
> -	if (IS_CASEFOLDED(dir))
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>  		d_invalidate(dentry);
> -#endif
>  
>  end_rmdir:
>  	brelse(bh);
> @@ -3284,16 +3281,15 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>  		goto out_trace;
>  
>  	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry), dentry);
> -#if IS_ENABLED(CONFIG_UNICODE)
> +
>  	/* VFS negative dentries are incompatible with Encoding and
>  	 * Case-insensitiveness. Eventually we'll want avoid
>  	 * invalidating the dentries here, alongside with returning the
>  	 * negative dentries at ext4_lookup(), when it is  better
>  	 * supported by the VFS for the CI case.
>  	 */
> -	if (IS_CASEFOLDED(dir))
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>  		d_invalidate(dentry);
> -#endif
>  
>  out_trace:
>  	trace_ext4_unlink_exit(dentry, retval);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 215b4614eb15..179083728b4b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3609,14 +3609,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
>  		return 0;
>  	}
>  
> -#if !IS_ENABLED(CONFIG_UNICODE)
> -	if (ext4_has_feature_casefold(sb)) {
> +	if (!IS_ENABLED(CONFIG_UNICODE) && ext4_has_feature_casefold(sb)) {
>  		ext4_msg(sb, KERN_ERR,
>  			 "Filesystem with casefold feature cannot be "
>  			 "mounted without CONFIG_UNICODE");
>  		return 0;
>  	}
> -#endif
>  
>  	if (readonly)
>  		return 1;

-- 
Gabriel Krisman Bertazi

