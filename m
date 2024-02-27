Return-Path: <linux-fsdevel+bounces-13019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61786A35C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E701F2D61A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD756442;
	Tue, 27 Feb 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmMtuxBz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XDjQQ6kE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmMtuxBz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XDjQQ6kE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3D55C27;
	Tue, 27 Feb 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075523; cv=none; b=WpZhNrkyd+98SSxh340QJ2OJh+FO6wkw9Rtcb2RpELOFVLH6ASwrUOjLI1Mw7BLTWXKRZEX9p9ShsmeP6DIFpYiXva0G/30OLJjAge5i9V1mx1L2K+Aok2PnfCLhmeAUFHcO442EV39ceRncQPvPOAUSYWJI7ojr0mPQ2wF0hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075523; c=relaxed/simple;
	bh=tA3/vEEEu8QXoYbYcy3pyT4OI+U5YXiY4BAU2ShoSHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpPDzaF3UXAvvPs69w+a+4xtrwlSFnTL4XVeynVgAaSGZJYvqeudEnJDO3lbO9riQmxCz0H+CuMTPRIeanwzjZNVc0+LdlMXAF3dde84K6M/Z+jzKvtRxNSkZbxXlMumJEV2WEQNLv3/QeQkOABnHgOuzed0NdGBYLOMVvmxlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VmMtuxBz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XDjQQ6kE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VmMtuxBz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XDjQQ6kE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08D3E1FD99;
	Tue, 27 Feb 2024 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709075519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ6SQ2yaAw2hiYYQZNRKqMsoRQXaHuKM2VBBZj5Sx+0=;
	b=VmMtuxBzz+Hbuqi3byFtqCXkjCQ/pLKGaigzIMDpLAEhyCn3FQXgkdPQ04NPP5SDJed1Rr
	/3Pxe8ptRgUXQGJgrwcH7cAzwKznboS6SEI9xtml5kTrUwQyB3ok3llMUheGpKidw4vCMP
	gIOZYdSZoyMwDndThPFxGVWecu+fNxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709075519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ6SQ2yaAw2hiYYQZNRKqMsoRQXaHuKM2VBBZj5Sx+0=;
	b=XDjQQ6kEKgAQGUkbGDeXysZ2CROqCpbNV2SXcFLKRdq3PVtWI2z89yrsCxzwGyHxZ9LJoS
	cTUwCOWuPr8QmJBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709075519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ6SQ2yaAw2hiYYQZNRKqMsoRQXaHuKM2VBBZj5Sx+0=;
	b=VmMtuxBzz+Hbuqi3byFtqCXkjCQ/pLKGaigzIMDpLAEhyCn3FQXgkdPQ04NPP5SDJed1Rr
	/3Pxe8ptRgUXQGJgrwcH7cAzwKznboS6SEI9xtml5kTrUwQyB3ok3llMUheGpKidw4vCMP
	gIOZYdSZoyMwDndThPFxGVWecu+fNxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709075519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZ6SQ2yaAw2hiYYQZNRKqMsoRQXaHuKM2VBBZj5Sx+0=;
	b=XDjQQ6kEKgAQGUkbGDeXysZ2CROqCpbNV2SXcFLKRdq3PVtWI2z89yrsCxzwGyHxZ9LJoS
	cTUwCOWuPr8QmJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B601113ABA;
	Tue, 27 Feb 2024 23:11:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H0veJT5s3mUPMgAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 27 Feb 2024 23:11:58 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>,  Eric Biggers
 <ebiggers@google.com>
Subject: Re: [PATCH v12 2/8] f2fs: Simplify the handling of cached
 insensitive names
In-Reply-To: <20240220085235.71132-3-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 20 Feb 2024 10:52:29 +0200")
Organization: SUSE
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
	<20240220085235.71132-3-eugen.hristev@collabora.com>
Date: Tue, 27 Feb 2024 18:11:53 -0500
Message-ID: <87cysh5wp2.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VmMtuxBz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XDjQQ6kE
X-Spamd-Result: default: False [-6.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 08D3E1FD99
X-Spam-Level: 
X-Spam-Score: -6.81
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c      | 53 ++++++++++++++++++++++++++--------------------
>  fs/f2fs/f2fs.h     | 17 ++++++++++++++-
>  fs/f2fs/recovery.c |  5 +----
>  3 files changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 3f20d94e12f9..f5b65cf36393 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -42,35 +42,49 @@ static unsigned int bucket_blocks(unsigned int level)
>  		return 4;
>  }
>  
> +#if IS_ENABLED(CONFIG_UNICODE)
>  /* If @dir is casefolded, initialize @fname->cf_name from @fname->usr_fname. */
>  int f2fs_init_casefolded_name(const struct inode *dir,
>  			      struct f2fs_filename *fname)
>  {
> -#if IS_ENABLED(CONFIG_UNICODE)
>  	struct super_block *sb = dir->i_sb;
> +	unsigned char *buf;
> +	int len;
>  
>  	if (IS_CASEFOLDED(dir) &&
>  	    !is_dot_dotdot(fname->usr_fname->name, fname->usr_fname->len)) {
> -		fname->cf_name.name = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
> -					GFP_NOFS, false, F2FS_SB(sb));
> -		if (!fname->cf_name.name)
> +		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
> +					    GFP_NOFS, false, F2FS_SB(sb));
> +		if (!buf)
>  			return -ENOMEM;
> -		fname->cf_name.len = utf8_casefold(sb->s_encoding,
> -						   fname->usr_fname,
> -						   fname->cf_name.name,
> -						   F2FS_NAME_LEN);
> -		if ((int)fname->cf_name.len <= 0) {
> -			kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
> -			fname->cf_name.name = NULL;
> +
> +		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
> +				    buf, F2FS_NAME_LEN);
> +		if (len <= 0) {
> +			kmem_cache_free(f2fs_cf_name_slab, buf);
>  			if (sb_has_strict_encoding(sb))
>  				return -EINVAL;
>  			/* fall back to treating name as opaque byte sequence */
> +			return 0;
>  		}
> +		fname->cf_name.name = buf;
> +		fname->cf_name.len = len;
>  	}
> -#endif
> +
>  	return 0;
>  }
>  
> +void f2fs_free_casefolded_name(struct f2fs_filename *fname)
> +{
> +	unsigned char *buf = (unsigned char *)fname->cf_name.name;
> +
> +	if (buf) {
> +		kmem_cache_free(f2fs_cf_name_slab, buf);
> +		fname->cf_name.name = NULL;
> +	}
> +}

If we use kfree here, we can drop the buf !=NULL check.

> +#endif /* CONFIG_UNICODE */
> +
>  static int __f2fs_setup_filename(const struct inode *dir,
>  				 const struct fscrypt_name *crypt_name,
>  				 struct f2fs_filename *fname)
> @@ -142,12 +156,7 @@ void f2fs_free_filename(struct f2fs_filename *fname)
>  	kfree(fname->crypto_buf.name);
>  	fname->crypto_buf.name = NULL;
>  #endif
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	if (fname->cf_name.name) {
> -		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
> -		fname->cf_name.name = NULL;
> -	}
> -#endif
> +	f2fs_free_casefolded_name(fname);
>  }
>  
>  static unsigned long dir_block_index(unsigned int level,
> @@ -235,11 +244,9 @@ static inline int f2fs_match_name(const struct inode *dir,
>  	struct fscrypt_name f;
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (fname->cf_name.name) {
> -		struct qstr cf = FSTR_TO_QSTR(&fname->cf_name);
> -
> -		return f2fs_match_ci_name(dir, &cf, de_name, de_name_len);
> -	}
> +	if (fname->cf_name.name)
> +		return f2fs_match_ci_name(dir, &fname->cf_name,
> +					  de_name, de_name_len);
>  #endif
>  	f.usr_fname = fname->usr_fname;
>  	f.disk_name = fname->disk_name;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 84c9fead3ad4..2ff8e52642ec 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -530,7 +530,7 @@ struct f2fs_filename {
>  	 * internal operation where usr_fname is also NULL.  In all these cases
>  	 * we fall back to treating the name as an opaque byte sequence.
>  	 */
> -	struct fscrypt_str cf_name;
> +	struct qstr cf_name;
>  #endif
>  };
>  
> @@ -3533,8 +3533,23 @@ int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  /*
>   * dir.c
>   */
> +unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de);

This is not part of the original patch and doesn't make sense here. It
seems to be included by a bad rebase?


-- 
Gabriel Krisman Bertazi

