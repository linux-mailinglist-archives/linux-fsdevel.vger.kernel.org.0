Return-Path: <linux-fsdevel+bounces-12026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD285A6A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BA1C20C27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961739FEC;
	Mon, 19 Feb 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="avRGE7em";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rslRCV1q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="avRGE7em";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rslRCV1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45183383BB;
	Mon, 19 Feb 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354541; cv=none; b=nk1or6aC+cWM0r/XjhgFzyexkHLwCpl1pfjOF8BsI+PqCB3ZuUN0A7TJU2jbEf07zC4EU5hz0Oqd/stG7CYyVDrGZXP8mkT7+LnMTkPGNielsR0VUI/7LzhhS2UJhVTI3kHvZGP8uck/29BlEog4aVl+mllI1UfFcDSXRl71iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354541; c=relaxed/simple;
	bh=9wlvF0ScyfXlUKJvQHCY1lykuhVQIEGLiokTklW2Gwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FELljpqdP/M9Sl1zVIleM3Y1kOII/TdnTJ7XRJBnWxabU2OSSlhNE6l5rHVjG3TLJ2YGpOD2Jebi1q7RBECYUdnnQ2rVVAleE1jhZ3TURzYDTwTgBNnre633kB3H0GUfuCViXMvIXMUGblDBSWIrHkxL8wDuVe43ON0Vyl+f9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=avRGE7em; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rslRCV1q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=avRGE7em; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rslRCV1q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6691F808;
	Mon, 19 Feb 2024 14:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708354537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbja5lMg+1Mwqzz2hVATSrE04xaNuRS9E3B10FLnVis=;
	b=avRGE7emlGK5R4lKzhzXy/KUzSRA9hYSOhJA+eAltWjJCyHVXalS5saGrIkYiu+wgD7sOc
	efDfHL+rhifvUvdMglnmWCmNC4sF0j1btEHVDdD5UXpdqoKcObGkAmPtWS5tSzReR4ZMq7
	vAEJSswwKYtR/sc0qtxRNpeHQ7mzxqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708354537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbja5lMg+1Mwqzz2hVATSrE04xaNuRS9E3B10FLnVis=;
	b=rslRCV1qhQjgRNyL9E23Je3vLima4yq+nmbzcAsktechQjpAwDAIxEfRX3o2Vb+ufEz+3U
	oCsAEYa/ATeNNfDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708354537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbja5lMg+1Mwqzz2hVATSrE04xaNuRS9E3B10FLnVis=;
	b=avRGE7emlGK5R4lKzhzXy/KUzSRA9hYSOhJA+eAltWjJCyHVXalS5saGrIkYiu+wgD7sOc
	efDfHL+rhifvUvdMglnmWCmNC4sF0j1btEHVDdD5UXpdqoKcObGkAmPtWS5tSzReR4ZMq7
	vAEJSswwKYtR/sc0qtxRNpeHQ7mzxqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708354537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbja5lMg+1Mwqzz2hVATSrE04xaNuRS9E3B10FLnVis=;
	b=rslRCV1qhQjgRNyL9E23Je3vLima4yq+nmbzcAsktechQjpAwDAIxEfRX3o2Vb+ufEz+3U
	oCsAEYa/ATeNNfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA12513647;
	Mon, 19 Feb 2024 14:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +d5pMuhr02UhaAAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 19 Feb 2024 14:55:36 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v10 3/8] libfs: Introduce case-insensitive string
 comparison helper
In-Reply-To: <50d2afaa-fd7e-4772-ac84-24e8994bfba8@collabora.com> (Eugen
	Hristev's message of "Mon, 19 Feb 2024 06:22:37 +0200")
Organization: SUSE
References: <20240215042654.359210-1-eugen.hristev@collabora.com>
	<20240215042654.359210-4-eugen.hristev@collabora.com>
	<87zfw0bd6y.fsf@mailhost.krisman.be>
	<50d2afaa-fd7e-4772-ac84-24e8994bfba8@collabora.com>
Date: Mon, 19 Feb 2024 09:55:31 -0500
Message-ID: <87msrwbj18.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=avRGE7em;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rslRCV1q
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,collabora.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 3C6691F808
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> On 2/16/24 18:12, Gabriel Krisman Bertazi wrote:
>> Eugen Hristev <eugen.hristev@collabora.com> writes:
>> 
>>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>>>
>>> generic_ci_match can be used by case-insensitive filesystems to compare
>>> strings under lookup with dirents in a case-insensitive way.  This
>>> function is currently reimplemented by each filesystem supporting
>>> casefolding, so this reduces code duplication in filesystem-specific
>>> code.
>>>
>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>> [eugen.hristev@collabora.com: rework to first test the exact match]
>>> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>>> ---
>>>  fs/libfs.c         | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/fs.h |  4 +++
>>>  2 files changed, 84 insertions(+)
>>>
>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>> index bb18884ff20e..82871fa1b066 100644
>>> --- a/fs/libfs.c
>>> +++ b/fs/libfs.c
>>> @@ -1773,6 +1773,86 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>>>  	.d_hash = generic_ci_d_hash,
>>>  	.d_compare = generic_ci_d_compare,
>>>  };
>>> +
>>> +/**
>>> + * generic_ci_match() - Match a name (case-insensitively) with a dirent.
>>> + * This is a filesystem helper for comparison with directory entries.
>>> + * generic_ci_d_compare should be used in VFS' ->d_compare instead.
>>> + *
>>> + * @parent: Inode of the parent of the dirent under comparison
>>> + * @name: name under lookup.
>>> + * @folded_name: Optional pre-folded name under lookup
>>> + * @de_name: Dirent name.
>>> + * @de_name_len: dirent name length.
>>> + *
>>> + *
>> 
>> Since this need a respin, mind dropping the extra empty line here?
>> 
>>> + * Test whether a case-insensitive directory entry matches the filename
>>> + * being searched.  If @folded_name is provided, it is used instead of
>>> + * recalculating the casefold of @name.
>>> + *
>>> + * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
>>> + * < 0 on error.
>>> + */
>>> +int generic_ci_match(const struct inode *parent,
>>> +		     const struct qstr *name,
>>> +		     const struct qstr *folded_name,
>>> +		     const u8 *de_name, u32 de_name_len)
>>> +{
>>> +	const struct super_block *sb = parent->i_sb;
>>> +	const struct unicode_map *um = sb->s_encoding;
>>> +	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
>>> +	struct qstr dirent = QSTR_INIT(de_name, de_name_len);
>>> +	int res;
>>> +
>>> +	if (IS_ENCRYPTED(parent)) {
>>> +		const struct fscrypt_str encrypted_name =
>>> +			FSTR_INIT((u8 *) de_name, de_name_len);
>>> +
>>> +		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
>>> +			return -EINVAL;
>>> +
>>> +		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
>>> +		if (!decrypted_name.name)
>>> +			return -ENOMEM;
>>> +		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
>>> +						&decrypted_name);
>>> +		if (res < 0)
>>> +			goto out;
>>> +		dirent.name = decrypted_name.name;
>>> +		dirent.len = decrypted_name.len;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Attempt a case-sensitive match first. It is cheaper and
>>> +	 * should cover most lookups, including all the sane
>>> +	 * applications that expect a case-sensitive filesystem.
>>> +	 *
>> 
>> 
>>> +	 * This comparison is safe under RCU because the caller
>>> +	 * guarantees the consistency between str and len. See
>>> +	 * __d_lookup_rcu_op_compare() for details.
>>> +	 */
>> 
>> This paragraph doesn't really make sense here.  It is originally from
>> the d_compare hook, which can be called under RCU, but there is no RCU
>> here.  Also, here we are comparing the dirent with the
>> name-under-lookup, name which is already safe.
>> 
>> 
>>> +	if (folded_name->name) {
>>> +		if (dirent.len == folded_name->len &&
>>> +		    !memcmp(folded_name->name, dirent.name, dirent.len)) {
>>> +			res = 1;
>>> +			goto out;
>>> +		}
>>> +		res = !utf8_strncasecmp_folded(um, folded_name, &dirent);
>> 
>> Hmm, second thought on this.  This will ignore errors from utf8_strncasecmp*,
>> which CAN happen for the first time here, if the dirent itself is
>> corrupted on disk (exactly why we have patch 6).  Yes, ext4_match will drop the
>> error, but we want to propagate it from here, such that the warning on
>> patch 6 can trigger.
>> 
>> This is why I did that match dance on the original submission.  Sorry
>> for suggesting it.  We really want to get the error from utf8 and
>> propagate it if it is negative. basically:
>> 
>>         res > 0: match
>>         res == 0: no match.
>>         res < 0: propagate error and let the caller handle it
>
> In that case I will revert to the original v9 implementation and send a v11 to
> handle that.

Please, note that the memcmp optimization is still valid. On match, we
know the name is valid utf8.  It is just a matter of propagating the
error code from utf8 to the caller if we need to call it.

-- 
Gabriel Krisman Bertazi
 

