Return-Path: <linux-fsdevel+bounces-10806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C084E7C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D341C23977
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17771DFE8;
	Thu,  8 Feb 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cp1Ss3GC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vLlp/3cx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cp1Ss3GC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vLlp/3cx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC41CD2E;
	Thu,  8 Feb 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417519; cv=none; b=up9LfukfNKu+SENW80trUgV7Hgu251qOfSzw6wOJV+RECV+3QyDYKFBvkr+vTi8HwA1JZTNsJsrXljZbcePmijRodIn7H7V9ppN8mBXxPD4oALqy4e6vwARm3lQ9JB3uLIQhiUs8r8kKEsBmfeEZTAtBCzsjqU44qnizbuaUuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417519; c=relaxed/simple;
	bh=6abgFve46OM13HlNlCYnUsRSkx2iInDQ7z2Y+oFpha0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jEu+74tPaLFAesAn/X7SQWzdyleWPTaQTIy2ww4qIwgTqP1JynOdsvSIaDnn7N9e2w2WdIHyljFhHT/muoEqrJyK2+lkEw8qJ4Zxgob1XvS3MFn7MFYhbyYHxSGil51Z3IDnkmgUfDq8s+zb1Csx/Ba2sCPXyKBZ0i5nUvSlej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cp1Ss3GC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vLlp/3cx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cp1Ss3GC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vLlp/3cx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3977122042;
	Thu,  8 Feb 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707417515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxyCzxouVGDBxxk7qAU+KiLGXbUeN/r+/hUstnS9Hy8=;
	b=Cp1Ss3GCWoG0SwIvKr2u+ToGd8icmHzK77Lbr8PjQ1STlwx5z33v/kux/j617zHFSvC1QP
	YdBDKzE4ms45aTmasFe58fSdIAFhSXwmAFLGLn2424cWssgyxkq2SuSsgfSC2Eh9pFXKLH
	5ELQhsNBpA62YyOM3oP8/ZUijViZbAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707417515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxyCzxouVGDBxxk7qAU+KiLGXbUeN/r+/hUstnS9Hy8=;
	b=vLlp/3cxXdDlcwqR8dAHrDorHzLLkVjX5fcIZDiJCY1/l/KduPN62rKwFVI7Yezr5oJ7f5
	Z8NCUyqDwBWRF8Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707417515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxyCzxouVGDBxxk7qAU+KiLGXbUeN/r+/hUstnS9Hy8=;
	b=Cp1Ss3GCWoG0SwIvKr2u+ToGd8icmHzK77Lbr8PjQ1STlwx5z33v/kux/j617zHFSvC1QP
	YdBDKzE4ms45aTmasFe58fSdIAFhSXwmAFLGLn2424cWssgyxkq2SuSsgfSC2Eh9pFXKLH
	5ELQhsNBpA62YyOM3oP8/ZUijViZbAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707417515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxyCzxouVGDBxxk7qAU+KiLGXbUeN/r+/hUstnS9Hy8=;
	b=vLlp/3cxXdDlcwqR8dAHrDorHzLLkVjX5fcIZDiJCY1/l/KduPN62rKwFVI7Yezr5oJ7f5
	Z8NCUyqDwBWRF8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9FC1326D;
	Thu,  8 Feb 2024 18:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S2IMMKofxWVpMQAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 08 Feb 2024 18:38:34 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  jaegeuk@kernel.org,
  chao@kernel.org,  viro@zeniv.linux.org.uk,  brauner@kernel.org,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  jack@suse.cz,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel@collabora.com,  Gabriel Krisman
 Bertazi <krisman@collabora.com>,  Eric Biggers <ebiggers@google.com>
Subject: Re: [RESEND PATCH v9 1/3] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <20240208064334.268216-2-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Thu, 8 Feb 2024 08:43:32 +0200")
References: <20240208064334.268216-1-eugen.hristev@collabora.com>
	<20240208064334.268216-2-eugen.hristev@collabora.com>
Date: Thu, 08 Feb 2024 13:38:33 -0500
Message-ID: <87ttmivm1i.fsf@mailhost.krisman.be>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cp1Ss3GC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vLlp/3cx"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 3977122042
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
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Hi Eugen,

Thanks for picking this up.  Please,  CC me in future versions.

> ---
>  fs/libfs.c         | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +++
>  2 files changed, 72 insertions(+)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index bb18884ff20e..f80cb982ac89 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1773,6 +1773,74 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  };
> +
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
> + * @parent: Inode of the parent of the dirent under comparison
> + * @name: name under lookup.
> + * @folded_name: Optional pre-folded name under lookup
> + * @de_name: Dirent name.
> + * @de_name_len: dirent name length.
> + *
> + *
> + * Test whether a case-insensitive directory entry matches the filename
> + * being searched.  If @folded_name is provided, it is used instead of
> + * recalculating the casefold of @name.

Can we add a note that this is a filesystem helper for comparison with
directory entries, and VFS' ->d_compare should use generic_ci_d_compare.

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
> +	int res, match = false;

I know I originally wrote it this way, but match is an integer, so
let's use integers instead of false/true.

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
> +	if (folded_name->name)
> +		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> +	else
> +		res = utf8_strncasecmp(um, name, &dirent);

Similar to

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=367122c529f35b4655acbe33c0cc4d6d3b32ba71

We should be checking for an exact-match first to avoid the utf8
comparison cost unnecessarily.  The only problem is that we need to
ensure we fail for an invalid utf-8 de_name in "strict mode".

Fortunately, if folded_name->name exists, we know the name-under-lookup
was validated when initialized, so an exact-match of de_name must also
be valid.  If folded_name is NULL, though, we might either have an
invalid utf-8 dentry-under-lookup or the allocation itself failed, so we
need to utf8_validate it.

Honestly, I don't care much about this !folded_name->name case, since
utf8_strncasecmp will do the right thing and an invalid utf8 on
case-insensitive directories should be an exception, not the norm.  but
the code might get simpler if we do both:

(untested)

if (folded_name->name) {
	if (dirent.len == folded_name->len &&
	    !memcmp(folded_name->name, dirent.name, dirent.len)) {
            	res = 1;
		goto out;
        }
	res = utf8_strncasecmp_folded(um, folded_name, &dirent);
} else {
	if (dirent.len == name->len &&
	    !memcmp(name->name, dirent.name, dirent.len) &&
            (!sb_has_strict_encoding(sb) || !utf8_validate(um, name))) {
            	res = 1;
		goto out;
        }
	res = utf8_strncasecmp(um, name, &dirent);
}

> +
> +	if (!res)
> +		match = true;
> +	else if (res < 0 && !sb_has_strict_encoding(sb)) {
> +		/*
> +		 * In non-strict mode, fallback to a byte comparison if
> +		 * the names have invalid characters.
> +		 */
> +		res = 0;
> +		match = ((name->len == dirent.len) &&
> +			 !memcmp(name->name, dirent.name, dirent.len));
> +	}

This goes away entirely.

> +
> +out:
> +	kfree(decrypted_name.name);
> +	return (res >= 0) ? match : res;

and this becomes:

return res;

-- 
Gabriel Krisman Bertazi

