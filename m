Return-Path: <linux-fsdevel+bounces-14376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D087B522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 00:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7647F1F23ACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119635D737;
	Wed, 13 Mar 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqWrSyHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i9lzNmZ8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqWrSyHq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i9lzNmZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4741C6A;
	Wed, 13 Mar 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710371825; cv=none; b=XMNZMLFV9xIEKE/zu2VH0bN/KV3LHcSrg31E8dEZwO2oc+ODFsKM9jLPFXP7Vx5bnK8o8bwAnqJxaygz+bzLpgkV/BBGZIyFkA1wfyoGA/AEUf+/810O3yNtqT0wNmvO642pkyg+hrqj4+VEhmgW8/I/UGvIgHgWIwsFMzHQzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710371825; c=relaxed/simple;
	bh=8lzW/AQHC+tREFa+aWy43EFhJt/UIZCWdjroRaubi+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P2Ze8fyoAq/ek7gTAxuPBaFPQmtMN5Sjeq4ZCRWDO+viSkSqbNkzsdNjzc4aVV8ijaC554Uuiw0Q7Ljsuideoll48+T2a85lBF7kOQnS8U0Mh/ntMmKyYkbpu5nRgr+2F3w/sKOW5qb0Gc0V0/+85Ltr8RzM4Eb3i0wsE304SG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqWrSyHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i9lzNmZ8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqWrSyHq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i9lzNmZ8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAF6821C8B;
	Wed, 13 Mar 2024 23:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710371821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7RbUqbuA7M29O8XyGy5jta6BO+8xzgDHtTQ2mM79V8=;
	b=GqWrSyHqcJY1yQWvgbV+eS7TGk3R1eowFEWk8qH++wqW1XOoog8N1CRLbQ/5syORsdTWs2
	E3Sw0PmY8ySJuHqw2q8llZjFUnrCE1+vOZZHrnVxpz8ejlZlK1C5janPKENqbus7Frm9lT
	HFEJEruoNqLwoAeqYWOs99xStMyqLcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710371821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7RbUqbuA7M29O8XyGy5jta6BO+8xzgDHtTQ2mM79V8=;
	b=i9lzNmZ8JB8vdNSz3LV4JUZq2HVGHzkH69nJEdM9rL25pEZfNX8gmbKBMpZ68Bw6enKDBi
	5e0qyiWiCOXTJoBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710371821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7RbUqbuA7M29O8XyGy5jta6BO+8xzgDHtTQ2mM79V8=;
	b=GqWrSyHqcJY1yQWvgbV+eS7TGk3R1eowFEWk8qH++wqW1XOoog8N1CRLbQ/5syORsdTWs2
	E3Sw0PmY8ySJuHqw2q8llZjFUnrCE1+vOZZHrnVxpz8ejlZlK1C5janPKENqbus7Frm9lT
	HFEJEruoNqLwoAeqYWOs99xStMyqLcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710371821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7RbUqbuA7M29O8XyGy5jta6BO+8xzgDHtTQ2mM79V8=;
	b=i9lzNmZ8JB8vdNSz3LV4JUZq2HVGHzkH69nJEdM9rL25pEZfNX8gmbKBMpZ68Bw6enKDBi
	5e0qyiWiCOXTJoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CC213977;
	Wed, 13 Mar 2024 23:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3BhxGe0z8mU0BQAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Mar 2024 23:17:01 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v13 3/9] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <20240305101608.67943-4-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 5 Mar 2024 12:16:02 +0200")
Organization: SUSE
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
	<20240305101608.67943-4-eugen.hristev@collabora.com>
Date: Wed, 13 Mar 2024 19:16:56 -0400
Message-ID: <87il1pk9hz.fsf@mailhost.krisman.be>
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
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
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
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: rework to first test the exact match]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/libfs.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +++
>  2 files changed, 85 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index c297953db948..c107c24f33b9 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1776,6 +1776,87 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_revalidate = fscrypt_d_revalidate,
>  #endif
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

I think I've made this comment before, but I'd prefer this to be written
in a much simpler way

if (res < 0)
   return res;
return (match || !res);

Other than that, this looks good to me.

-- 
Gabriel Krisman Bertazi

