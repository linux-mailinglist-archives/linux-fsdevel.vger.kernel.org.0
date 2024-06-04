Return-Path: <linux-fsdevel+bounces-20985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6B8FBC67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250851C24FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DB14B07A;
	Tue,  4 Jun 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEfy7KFv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ApTIBBZg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEfy7KFv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ApTIBBZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B713E8BF;
	Tue,  4 Jun 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528672; cv=none; b=mEX1F9fLsb5iqYRpvCobNdsFqlxESG1GWs4s/Yk2mHvPGHRFoSYoxx+uTKfBRytSnGUOK+7Z/DleY4v220iYwAaATS+JEnB8QL6vhQ2J7D2+akjyVtakZm73ePpSLBdkSUgAHtIQ6uFTEPeIOZuSEd7m9U08YrqylskiU2XjlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528672; c=relaxed/simple;
	bh=bhz6beSoZHU0cD/b+1WGcJg+4R07D7ffbbCwhG5yiv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbHukTugZMx39cSXjS0LUKWDBEht3FSVaANifzHXrCegfzz44u5d7W2nBUW6EXijnKAA3wNbzZ6NQGpqY+hBBeNjEIjmybl2fnEOvIME+dJka4yNCdwxHH6DjW4ilgQL1nkHuT+dmq3ZZOm4WibW2hfeBB/4BMAz6HIXHO1kCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEfy7KFv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ApTIBBZg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEfy7KFv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ApTIBBZg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44A8F21A49;
	Tue,  4 Jun 2024 19:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717528667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rO2JAWmDJtlVxTQDorgmfpM/zzgopthZzmv/CylN0UA=;
	b=lEfy7KFvbYAu5Gy+ndRbat4fzOU68RDR7fbdoOvM8TNr+eLnWDKN3NLWHNk5nTEB+RBK/J
	VVk1aglcyJbAa95ekP89831ZhX+bpi36WVN+SgUs1vlh9OZrCfhOshwyHnQrQUseKv5/yt
	4429yG93oPOP/VXrBtWeE3tCOPD+aho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717528667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rO2JAWmDJtlVxTQDorgmfpM/zzgopthZzmv/CylN0UA=;
	b=ApTIBBZgztLzgx2iXdTJhOWHbFiIpXmzJZXspoqfRyp+gK25RM6uuwfp5piowKx1ScboFA
	x7Mzq2DSvBYLAsCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717528667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rO2JAWmDJtlVxTQDorgmfpM/zzgopthZzmv/CylN0UA=;
	b=lEfy7KFvbYAu5Gy+ndRbat4fzOU68RDR7fbdoOvM8TNr+eLnWDKN3NLWHNk5nTEB+RBK/J
	VVk1aglcyJbAa95ekP89831ZhX+bpi36WVN+SgUs1vlh9OZrCfhOshwyHnQrQUseKv5/yt
	4429yG93oPOP/VXrBtWeE3tCOPD+aho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717528667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rO2JAWmDJtlVxTQDorgmfpM/zzgopthZzmv/CylN0UA=;
	b=ApTIBBZgztLzgx2iXdTJhOWHbFiIpXmzJZXspoqfRyp+gK25RM6uuwfp5piowKx1ScboFA
	x7Mzq2DSvBYLAsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E55BD13A93;
	Tue,  4 Jun 2024 19:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mLlRMVpoX2bXYwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 04 Jun 2024 19:17:46 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  jaegeuk@kernel.org,  adilger.kernel@dilger.ca,  tytso@mit.edu,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  jack@suse.cz,  ebiggers@google.com,  kernel@collabora.com,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v17 4/7] ext4: Reuse generic_ci_match for ci comparisons
In-Reply-To: <20240529082634.141286-5-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Wed, 29 May 2024 11:26:31 +0300")
Organization: SUSE
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
	<20240529082634.141286-5-eugen.hristev@collabora.com>
Date: Tue, 04 Jun 2024 15:17:41 -0400
Message-ID: <87cyowldpm.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
>
> It also adds a comment explaining why fname->cf_name.name must be
> checked prior to the encryption hash optimization, because that tripped
> me before.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
>  1 file changed, 27 insertions(+), 64 deletions(-)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index ec4c9bfc1057..20668741a23c 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1390,58 +1390,6 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
>  }
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -/*
> - * Test whether a case-insensitive directory entry matches the filename
> - * being searched for.  If quick is set, assume the name being looked up
> - * is already in the casefolded form.
> - *
> - * Returns: 0 if the directory entry matches, more than 0 if it
> - * doesn't match or less than zero on error.
> - */
> -static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
> -			   u8 *de_name, size_t de_name_len, bool quick)
> -{
> -	const struct super_block *sb = parent->i_sb;
> -	const struct unicode_map *um = sb->s_encoding;
> -	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> -	struct qstr entry = QSTR_INIT(de_name, de_name_len);
> -	int ret;
> -
> -	if (IS_ENCRYPTED(parent)) {
> -		const struct fscrypt_str encrypted_name =
> -				FSTR_INIT(de_name, de_name_len);
> -
> -		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> -		if (!decrypted_name.name)
> -			return -ENOMEM;
> -		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
> -						&decrypted_name);
> -		if (ret < 0)
> -			goto out;
> -		entry.name = decrypted_name.name;
> -		entry.len = decrypted_name.len;
> -	}
> -
> -	if (quick)
> -		ret = utf8_strncasecmp_folded(um, name, &entry);
> -	else
> -		ret = utf8_strncasecmp(um, name, &entry);
> -	if (ret < 0) {
> -		/* Handle invalid character sequence as either an error
> -		 * or as an opaque byte sequence.
> -		 */
> -		if (sb_has_strict_encoding(sb))
> -			ret = -EINVAL;
> -		else if (name->len != entry.len)
> -			ret = 1;
> -		else
> -			ret = !!memcmp(name->name, entry.name, entry.len);
> -	}
> -out:
> -	kfree(decrypted_name.name);
> -	return ret;
> -}
> -
>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  				  struct ext4_filename *name)
>  {
> @@ -1503,20 +1451,35 @@ static bool ext4_match(struct inode *parent,
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	if (IS_CASEFOLDED(parent) &&
>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
> -		if (fname->cf_name.name) {
> -			if (IS_ENCRYPTED(parent)) {
> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> -					fname->hinfo.minor_hash !=
> -						EXT4_DIRENT_MINOR_HASH(de)) {
> +		int ret;
>  
> -					return false;
> -				}
> -			}
> -			return !ext4_ci_compare(parent, &fname->cf_name,
> -						de->name, de->name_len, true);
> +		/*
> +		 * Just checking IS_ENCRYPTED(parent) below is not
> +		 * sufficient to decide whether one can use the hash for
> +		 * skipping the string comparison, because the key might
> +		 * have been added right after
> +		 * ext4_fname_setup_ci_filename().  In this case, a hash
> +		 * mismatch will be a false negative.  Therefore, make
> +		 * sure cf_name was properly initialized before
> +		 * considering the calculated hash.
> +		 */
> +		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
> +		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
> +		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
> +			return false;
> +
> +		ret = generic_ci_match(parent, fname->usr_fname,
> +				       &fname->cf_name, de->name,
> +				       de->name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			return false;
>  		}
> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
> -						de->name_len, false);

With the changes to patch 3 in this iteration, This could become:

/*
 * Treat comparison errors as not a match.  The
 * only case where it happens is disk corruption
 * or ENOMEM.
 */
return ext4_ci_compare(parent, fname->usr_fname, de->name,
		       de->name_len, false) > 0;

-- 
Gabriel Krisman Bertazi

