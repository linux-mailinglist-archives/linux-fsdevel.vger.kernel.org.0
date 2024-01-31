Return-Path: <linux-fsdevel+bounces-9699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089F844738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A62E1F26E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2E18AFB;
	Wed, 31 Jan 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zIC50bxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+jqCvSz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zIC50bxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j+jqCvSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3017570;
	Wed, 31 Jan 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726147; cv=none; b=jj5qEY5xpVU0pGqmP9GoEUXH2RgEvNpcRXovYGxTA/H76RgTA6iny5c4LTutlBjZtR+v5zU48vyLeRB/pRWSQTa6pvCPct6i8pYL1VFNXmAo4TquBwzBfJZ/01BLfqaze/r6hmrnuR6ALjVDA+jnswHgeDWtH3AsJztZ7SaqvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726147; c=relaxed/simple;
	bh=+JoJG7pRbDHijVXwiQYZPDo+9pZSH4Hb0WFUZddSJ1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtClWv/Op5IYgy+uLs/f7hZNpQ8Y1i5yzyUSBiFvyU7MwtdGjX2Fs+TLv+gcSnDGLZU4h2MnFcJvLATvd4iSngK5djOm78mC4ccC7FHvOBqwmfmF/RRXPFPmH8QOwQ4jgyFKqEJ840Epo8ZMP3VWwjktFwS1BuklG53N4OzQXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zIC50bxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+jqCvSz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zIC50bxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j+jqCvSz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85CDD1FB95;
	Wed, 31 Jan 2024 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706726143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZh9bI2nucB4Tu4k5g98e4aelswvFCokcNSj9QwRR1o=;
	b=zIC50bxiaXCsrC0a8NycfxSrLtttxTPUKEqhfr/fkjmRCCLKykep8hZ5fNkchvfwtXBxS+
	wCHfZHe7cDhw0pku9rU7iebpI+rqpKrGa0XWl9NE+2ZzThCLJ59CxF48FusXICVQbCDxsP
	wn5ybbRHmqFUhurn4B9kLyxEBQaMLnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706726143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZh9bI2nucB4Tu4k5g98e4aelswvFCokcNSj9QwRR1o=;
	b=j+jqCvSzcjrsvk/Y5XdBS+yuxLHBqVFJclQblqqLKQ7effDnO0wZvBlwfAChV8MHMrWn4d
	MkdS9gULamqN+BAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706726143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZh9bI2nucB4Tu4k5g98e4aelswvFCokcNSj9QwRR1o=;
	b=zIC50bxiaXCsrC0a8NycfxSrLtttxTPUKEqhfr/fkjmRCCLKykep8hZ5fNkchvfwtXBxS+
	wCHfZHe7cDhw0pku9rU7iebpI+rqpKrGa0XWl9NE+2ZzThCLJ59CxF48FusXICVQbCDxsP
	wn5ybbRHmqFUhurn4B9kLyxEBQaMLnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706726143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZh9bI2nucB4Tu4k5g98e4aelswvFCokcNSj9QwRR1o=;
	b=j+jqCvSzcjrsvk/Y5XdBS+yuxLHBqVFJclQblqqLKQ7effDnO0wZvBlwfAChV8MHMrWn4d
	MkdS9gULamqN+BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11BE5139B1;
	Wed, 31 Jan 2024 18:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id faPhLv6SumVySwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 31 Jan 2024 18:35:42 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  amir73il@gmail.com,  linux-ext4@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] fscrypt: Drop d_revalidate for valid dentries
 during lookup
In-Reply-To: <20240131004724.GC2020@sol.localdomain> (Eric Biggers's message
	of "Tue, 30 Jan 2024 16:47:24 -0800")
Organization: SUSE
References: <20240129204330.32346-1-krisman@suse.de>
	<20240129204330.32346-5-krisman@suse.de>
	<20240131004724.GC2020@sol.localdomain>
Date: Wed, 31 Jan 2024 15:35:40 -0300
Message-ID: <871q9x2vwj.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Jan 29, 2024 at 05:43:22PM -0300, Gabriel Krisman Bertazi wrote:
>> Unencrypted and encrypted-dentries where the key is available don't need
>> to be revalidated with regards to fscrypt, since they don't go stale
>> from under VFS and the key cannot be removed for the encrypted case
>> without evicting the dentry.  Mark them with d_set_always_valid, to
>
> "d_set_always_valid" doesn't appear in the diff itself.
>
>> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
>> index 4aaf847955c0..a22997b9f35c 100644
>> --- a/include/linux/fscrypt.h
>> +++ b/include/linux/fscrypt.h
>> @@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>>  static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
>>  						 bool is_nokey_name)
>>  {
>> -	if (is_nokey_name) {
>> -		spin_lock(&dentry->d_lock);
>> +	spin_lock(&dentry->d_lock);
>> +
>> +	if (is_nokey_name)
>>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>> -		spin_unlock(&dentry->d_lock);
>> +	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
>> +		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
>> +		/*
>> +		 * Unencrypted dentries and encrypted dentries where the
>> +		 * key is available are always valid from fscrypt
>> +		 * perspective. Avoid the cost of calling
>> +		 * fscrypt_d_revalidate unnecessarily.
>> +		 */
>> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>>  	}
>> +
>> +	spin_unlock(&dentry->d_lock);
>
> This makes lookups in unencrypted directories start doing the
> spin_lock/spin_unlock pair.  Is that really necessary?
>
> These changes also make the inline function fscrypt_prepare_lookup() very long
> (when including the fscrypt_prepare_lookup_dentry() that's inlined into it).
> The rule that I'm trying to follow is that to the extent that the fscrypt helper
> functions are inlined, the inline part should be a fast path for unencrypted
> directories.  Encrypted directories should be handled out-of-line.
>
> So looking at the original fscrypt_prepare_lookup():
>
> 	static inline int fscrypt_prepare_lookup(struct inode *dir,
> 						 struct dentry *dentry,
> 						 struct fscrypt_name *fname)
> 	{
> 		if (IS_ENCRYPTED(dir))
> 			return __fscrypt_prepare_lookup(dir, dentry, fname);
>
> 		memset(fname, 0, sizeof(*fname));
> 		fname->usr_fname = &dentry->d_name;
> 		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
> 		fname->disk_name.len = dentry->d_name.len;
> 		return 0;
> 	}
>
> If you could just add the DCACHE_OP_REVALIDATE clearing for dentries in
> unencrypted directories just before the "return 0;", hopefully without the
> spinlock, that would be good.  Yes, that does mean that
> __fscrypt_prepare_lookup() will have to handle it too, for the case of dentries
> in encrypted directories, but that seems okay.

ok, will do.  IIUC, we might be able to do without the d_lock
provided there is no store tearing.

But what was the reason you need the d_lock to set DCACHE_NOKEY_NAME
during lookup?  Is there a race with parallel lookup setting d_flag that
I couldn't find? Or is it another reason?


-- 
Gabriel Krisman Bertazi

