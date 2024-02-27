Return-Path: <linux-fsdevel+bounces-13020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE186A3C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C6D1C243B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5555C2E;
	Tue, 27 Feb 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xQ8f1Ns3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L0Kim+WT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xQ8f1Ns3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L0Kim+WT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654F5576E;
	Tue, 27 Feb 2024 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076787; cv=none; b=Yq4Hsi5aJHlqD01tDC3k1KX03tDZzYbss3s//flxfVLIhL4pQiekeTf19EI1WtUjtflI7SQtVA1LnQt2KHfm+JtbzuPHdCbcy9r53TBjlEUuuUA1Ciy5RroxOtHGOJdRSMl9o3sN5ihpBNVRctlGuLRnwnqZBoHkIM+0yPr6U0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076787; c=relaxed/simple;
	bh=rVI+xSd8FYJi7TzLJ7Ikl21QrMCLhmodA6y/Pc5d06c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCq+/UhVc8L83hMLqsDdoop5LF5//pGWoarW+v3V55ACQv2QqT+28qvb+faroTgb/HeROI/e6tD3x7EjYHjorz3ZPYZFzUCewyQ2qQKpeLH2A3/befSOLPfvKt9gzJZBzJObxW0twbFt4nFEAzXITLfpj1agDD/8bHbTK1Ty8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xQ8f1Ns3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L0Kim+WT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xQ8f1Ns3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L0Kim+WT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7055022299;
	Tue, 27 Feb 2024 23:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XcCT6OIixHhjBjRbIEMhs9CTkZAbGq3CBxIJeInpl0=;
	b=xQ8f1Ns3iGPxbm0Sj6jv30DtRJppv+f317F+9awYDiAjwjn6FnIlWRA+vNCxa1HCGUxm3s
	yJX0sbF3PYVO+9O7EZE3/moFHfstEPKxL2U0wA8RpMg+JeGc6f3fwppTTVwaq0vTJbZ4s8
	Ubz4zZTKdqnPkfmJ+w0spkoaKiY/nUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XcCT6OIixHhjBjRbIEMhs9CTkZAbGq3CBxIJeInpl0=;
	b=L0Kim+WTB0aMM3EOz4MBC7ESAUEX7JhLQSDLvgTuYYlWjODdBE2wVs3fpr1RIkTGn+dn5H
	pbN0FK3QlGkx17Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XcCT6OIixHhjBjRbIEMhs9CTkZAbGq3CBxIJeInpl0=;
	b=xQ8f1Ns3iGPxbm0Sj6jv30DtRJppv+f317F+9awYDiAjwjn6FnIlWRA+vNCxa1HCGUxm3s
	yJX0sbF3PYVO+9O7EZE3/moFHfstEPKxL2U0wA8RpMg+JeGc6f3fwppTTVwaq0vTJbZ4s8
	Ubz4zZTKdqnPkfmJ+w0spkoaKiY/nUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XcCT6OIixHhjBjRbIEMhs9CTkZAbGq3CBxIJeInpl0=;
	b=L0Kim+WTB0aMM3EOz4MBC7ESAUEX7JhLQSDLvgTuYYlWjODdBE2wVs3fpr1RIkTGn+dn5H
	pbN0FK3QlGkx17Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32DF213ABA;
	Tue, 27 Feb 2024 23:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DCM3Bi9x3mUnNgAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 27 Feb 2024 23:33:03 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v12 3/8] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <20240220085235.71132-4-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 20 Feb 2024 10:52:30 +0200")
Organization: SUSE
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
	<20240220085235.71132-4-eugen.hristev@collabora.com>
Date: Tue, 27 Feb 2024 18:32:58 -0500
Message-ID: <875xy95vpx.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.965];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> generic_ci_match can be used by case-insensitive filesystems to compare
> strings under lookup with dirents in a case-insensitive way.  This
> function is currently reimplemented by each filesystem supporting
> casefolding, so this reduces code duplication in filesystem-specific
> code.

Just a note that this conflicts with the other patchset to generic
helpers that I just applied.  The conflict is trivial, If you could base
the next iteration on top of my for-next, it would be helpful.

>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: rework to first test the exact match]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/libfs.c         | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +++
>  2 files changed, 89 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index bb18884ff20e..65e2fb17a2b6 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1773,6 +1773,91 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  };
> +
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
> + * This is a filesystem helper for comparison with directory entries.
> + * generic_ci_d_compare should be used in VFS' ->d_compare instead.
> + *
> + * @parent: Inode of the parent of the dirent under comparison
> + * @name: name under lookup.
> + * @folded_name: Optional pre-folded name under lookup
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + *
> + * Test whether a case-insensitive directory entry matches the filename
> + * being searched.  If @folded_name is provided, it is used instead of
> + * recalculating the casefold of @name.
> + *
> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
> + * < 0 on error.
> + */
> +int generic_ci_match(const struct inode *parent,
> +		     const struct qstr *name,
> +		     const struct qstr *folded_name,
> +		     const u8 *de_name, u32 de_name_len)
> +{
> +	const struct super_block *sb = parent->i_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
> +	int res, match = 0;
> +
> +	if (IS_ENCRYPTED(parent)) {
> +		const struct fscrypt_str encrypted_name =
> +			FSTR_INIT((u8 *) de_name, de_name_len);
> +
> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
> +			return -EINVAL;
> +
> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		if (!decrypted_name.name)
> +			return -ENOMEM;
> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
> +						&decrypted_name);
> +		if (res < 0)
> +			goto out;
> +		dirent.name = decrypted_name.name;
> +		dirent.len = decrypted_name.len;
> +	}
> +
> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.

> +	 * This comparison is safe under RCU because the caller
> +	 * guarantees the consistency between str and len. See
> +	 * __d_lookup_rcu_op_compare() for details.

As I mentioned in the previous review, there's no RCU here. This comment
makes no sense here.

> +	 */
> +	if (folded_name->name) {
> +		if (dirent.len == folded_name->len &&
> +		    !memcmp(folded_name->name, dirent.name, dirent.len)) {
> +			match = 1;
> +			goto out;
> +		}
> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> +	} else {
> +		if (dirent.len == name->len &&
> +		    !memcmp(name->name, dirent.name, dirent.len) &&
> +		    (!sb_has_strict_encoding(sb) || !utf8_validate(um, name))) {
> +			match = 1;
> +			goto out;
> +		}
> +		res = utf8_strncasecmp(um, name, &dirent);
> +	}
> +
> +out:

> +	kfree(decrypted_name.name);
> +	if (match) /* matched by direct comparison */
> +		return 1;
> +	else if (!res) /* matched by utf8 comparison */
> +		return 1;
> +	else if (res < 0) /* error on utf8 comparison */
> +		return res;
> +	return 0; /* no match */
> +}

It can be simplified to

if (res < 0)
   return res;
return (match || !res);

>  
>  #ifdef CONFIG_FS_ENCRYPTION
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 820b93b2917f..7af691ff8d44 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3296,6 +3296,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
>  extern int generic_check_addressable(unsigned, u64);
>  
>  extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
> +extern int generic_ci_match(const struct inode *parent,
> +			    const struct qstr *name,
> +			    const struct qstr *folded_name,
> +			    const u8 *de_name, u32 de_name_len);
>  
>  static inline bool sb_has_encoding(const struct super_block *sb)
>  {

-- 
Gabriel Krisman Bertazi

