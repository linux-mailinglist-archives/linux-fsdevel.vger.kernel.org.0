Return-Path: <linux-fsdevel+bounces-20986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C631A8FBC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765E4286815
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E570314A636;
	Tue,  4 Jun 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o8sfW9bl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SPzJV6CQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o8sfW9bl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SPzJV6CQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19A801;
	Tue,  4 Jun 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528737; cv=none; b=F+1/OSPdCcVD+6dSny1v6cA9kOHU4+ufB58aVVACNEdJQuSg6Uwqy0rKyWQfTcUdRcCyiNLMzKX6VgJPACasm0Nv5v0ouutbV1S+2j1owlA4qQWJ48Iw6xz3gtsN4mbAo9WjBnN6GnONeUHWzzWEjedu4FQ8HouQmEBLL4whPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528737; c=relaxed/simple;
	bh=HY2uD1V2XNnt7Yw6Q2og4xGbhV0iSXg8vgOOgV62bR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExGQk1NnmEbs6CcvgJEPv5XUy0hDv/vZNymqYi1P6U2sujrBk0sYYGfRHzAk2tr0HZWpb5XK8l282wNAKY6pf45iUwdeonMAjgvfwOVdCoAR0A5aj9YTMF7zCZJ2Q7RDyhRCG6CKu+/O59FSQRrvvmy3E5OlGpe+IO7jR3tt4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o8sfW9bl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SPzJV6CQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o8sfW9bl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SPzJV6CQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4595E1F385;
	Tue,  4 Jun 2024 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717528733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHpikqLS3lplK6ETI4WYKgRmbL70DTWGHED9kErL4ec=;
	b=o8sfW9blSyqGKsN8DSf9C+mekBpd2Xbi1tNe9oAh5kMA2DHcklcTUHr7k63mY1a5VNhcYL
	G7ZJCdnLRXeWTl57U8p+MvbCVRKNwHsOzClwAhWNRrbiIlNsu2kWsIDNPLsfXmnNEVewEQ
	5UxzehF1OeguS6HVcPIkki0+FYZtxHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717528733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHpikqLS3lplK6ETI4WYKgRmbL70DTWGHED9kErL4ec=;
	b=SPzJV6CQWR7M8Dk+ygpjpqscjUPSfb6KMQl+0n9rlKlwduUWs/NWZkuxqEO6KAMv0LjFTL
	s4rnOHSl5WcN+0Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717528733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHpikqLS3lplK6ETI4WYKgRmbL70DTWGHED9kErL4ec=;
	b=o8sfW9blSyqGKsN8DSf9C+mekBpd2Xbi1tNe9oAh5kMA2DHcklcTUHr7k63mY1a5VNhcYL
	G7ZJCdnLRXeWTl57U8p+MvbCVRKNwHsOzClwAhWNRrbiIlNsu2kWsIDNPLsfXmnNEVewEQ
	5UxzehF1OeguS6HVcPIkki0+FYZtxHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717528733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHpikqLS3lplK6ETI4WYKgRmbL70DTWGHED9kErL4ec=;
	b=SPzJV6CQWR7M8Dk+ygpjpqscjUPSfb6KMQl+0n9rlKlwduUWs/NWZkuxqEO6KAMv0LjFTL
	s4rnOHSl5WcN+0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F307E13A93;
	Tue,  4 Jun 2024 19:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iATjNJxoX2YjZAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 04 Jun 2024 19:18:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  jaegeuk@kernel.org,  adilger.kernel@dilger.ca,  tytso@mit.edu,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  jack@suse.cz,  ebiggers@google.com,  kernel@collabora.com,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v17 3/7] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <20240529082634.141286-4-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Wed, 29 May 2024 11:26:30 +0300")
Organization: SUSE
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
	<20240529082634.141286-4-eugen.hristev@collabora.com>
Date: Tue, 04 Jun 2024 15:18:47 -0400
Message-ID: <878qzkldns.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

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
> [eugen.hristev@collabora.com: rework to first test the exact match, cleanup
> and add error message]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Other than the origin of the length in memcmp mentioned by Eric, this patch
looks good to me now.

Thanks again for picking up this work!

> ---
>  fs/libfs.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +++
>  2 files changed, 78 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index b635ee5adbcc..6a6cfa2d7d93 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1854,6 +1854,80 @@ static const struct dentry_operations generic_ci_dentry_ops = {
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
> +	int res = 0;
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
> +		if (res < 0) {
> +			kfree(decrypted_name.name);
> +			return res;
> +		}
> +		dirent.name = decrypted_name.name;
> +		dirent.len = decrypted_name.len;
> +	}
> +
> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +
> +	if (dirent.len == (folded_name->name ? folded_name->len : name->len) &&
> +	    !memcmp(name->name, dirent.name, dirent.len))
> +		goto out;
> +
> +	if (folded_name->name)
> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> +	else
> +		res = utf8_strncasecmp(um, name, &dirent);
> +
> +out:
> +	kfree(decrypted_name.name);
> +	if (res < 0 && sb_has_strict_encoding(sb)) {
> +		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
> +		return 0;
> +	}
> +	return !res;
> +}
> +EXPORT_SYMBOL(generic_ci_match);
>  #endif
>  
>  #ifdef CONFIG_FS_ENCRYPTION
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 639885621608..f8ca264a0edc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3367,6 +3367,10 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
>  extern int generic_check_addressable(unsigned, u64);
>  
>  extern void generic_set_sb_d_ops(struct super_block *sb);
> +extern int generic_ci_match(const struct inode *parent,
> +			    const struct qstr *name,
> +			    const struct qstr *folded_name,
> +			    const u8 *de_name, u32 de_name_len);
>  
>  static inline bool sb_has_encoding(const struct super_block *sb)
>  {

-- 
Gabriel Krisman Bertazi

