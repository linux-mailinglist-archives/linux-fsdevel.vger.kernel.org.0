Return-Path: <linux-fsdevel+bounces-10972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81E84F7D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E642818ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA06A025;
	Fri,  9 Feb 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Udgh1gJw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOEeVhjP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Udgh1gJw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iOEeVhjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B414D112;
	Fri,  9 Feb 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490003; cv=none; b=XKBrFqJjCrojLNOajqreUH18D3zRHIZgD54K+zXYtrIGZBG6SB4jSgAKdNbmrSCX5QMxgHA1KY7UoXAKmj1YYx3MK2jsGZc6yW5XByJ0dzVF//Y4X5ev63DyzTVO9kB8snUmuo4/vDajizRnh2ZomADcxgktRvqaV4khogjAlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490003; c=relaxed/simple;
	bh=+apgDI2AugL6rqmIPz9McG/DX5pEwWcqyZ0qSy2xde4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CqHFFNEOPhR2+vn213yXJ8R6CVrnR6v4XZfOs4xEWRa1OLJV6B036hQ4+UVXWjl52xIqfIQRDCGiIEqIPzxdDrqfR7f1vHl3Xyh+OuwyxjvwIHm+CJFFNDs4ZH7EbKNZmSFDkHP6cFcZ5SfX+dLVZFhX8AxiFjGJb9SM7YRoXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Udgh1gJw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOEeVhjP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Udgh1gJw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iOEeVhjP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A986422233;
	Fri,  9 Feb 2024 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707489999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oUQkc/1wI2qWJWC7YK0GbMsld4JtgJbyTyEQVQCM+E=;
	b=Udgh1gJw12RNLIfc49aMEGAdhUHni7kqfa6KytMVtTCRwj8Hl6h+Na22JFyn9fe8kKShY9
	yCAGw+qQOlIjET1tnB8kZBUh8JQYpnpUanbLELojNdiBQb9m1g4bF0Za+9oCXr1JjA608D
	iFIXXrozeMIWyUSn/gc8asBGGQc8Zfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707489999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oUQkc/1wI2qWJWC7YK0GbMsld4JtgJbyTyEQVQCM+E=;
	b=iOEeVhjPZtE+jOQOn6c2YmDU8wR86QYTDBTtdGxcXIrLSqa2DuHtdqo86NnOTqDp502GY+
	i+Qi3OjQb83HhkDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707489999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oUQkc/1wI2qWJWC7YK0GbMsld4JtgJbyTyEQVQCM+E=;
	b=Udgh1gJw12RNLIfc49aMEGAdhUHni7kqfa6KytMVtTCRwj8Hl6h+Na22JFyn9fe8kKShY9
	yCAGw+qQOlIjET1tnB8kZBUh8JQYpnpUanbLELojNdiBQb9m1g4bF0Za+9oCXr1JjA608D
	iFIXXrozeMIWyUSn/gc8asBGGQc8Zfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707489999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oUQkc/1wI2qWJWC7YK0GbMsld4JtgJbyTyEQVQCM+E=;
	b=iOEeVhjPZtE+jOQOn6c2YmDU8wR86QYTDBTtdGxcXIrLSqa2DuHtdqo86NnOTqDp502GY+
	i+Qi3OjQb83HhkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 707A413353;
	Fri,  9 Feb 2024 14:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sw5LFc86xmWidwAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 09 Feb 2024 14:46:39 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,  viro@zeniv.linux.org.uk,
  jaegeuk@kernel.org,  tytso@mit.edu,  amir73il@gmail.com,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 04/12] fscrypt: Drop d_revalidate for valid dentries
 during lookup
In-Reply-To: <20240209-netto-ungehalten-35cfdd4b6473@brauner> (Christian
	Brauner's message of "Fri, 9 Feb 2024 15:03:23 +0100")
Organization: SUSE
References: <20240129204330.32346-1-krisman@suse.de>
	<20240129204330.32346-5-krisman@suse.de>
	<20240131004724.GC2020@sol.localdomain>
	<871q9x2vwj.fsf@mailhost.krisman.be>
	<20240201032433.GB1526@sol.localdomain>
	<87le82yl7k.fsf@mailhost.krisman.be>
	<20240209-netto-ungehalten-35cfdd4b6473@brauner>
Date: Fri, 09 Feb 2024 09:46:38 -0500
Message-ID: <87le7tu241.fsf@mailhost.krisman.be>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Udgh1gJw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iOEeVhjP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: A986422233
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Feb 02, 2024 at 11:50:07AM -0300, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > On Wed, Jan 31, 2024 at 03:35:40PM -0300, Gabriel Krisman Bertazi wrote:
>> >> Eric Biggers <ebiggers@kernel.org> writes:
>> >> 
>> >> > On Mon, Jan 29, 2024 at 05:43:22PM -0300, Gabriel Krisman Bertazi wrote:
>> >> >> Unencrypted and encrypted-dentries where the key is available don't need
>> >> >> to be revalidated with regards to fscrypt, since they don't go stale
>> >> >> from under VFS and the key cannot be removed for the encrypted case
>> >> >> without evicting the dentry.  Mark them with d_set_always_valid, to
>> >> >
>> >> > "d_set_always_valid" doesn't appear in the diff itself.
>> >> >
>> >> >> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
>> >> >> index 4aaf847955c0..a22997b9f35c 100644
>> >> >> --- a/include/linux/fscrypt.h
>> >> >> +++ b/include/linux/fscrypt.h
>> >> >> @@ -942,11 +942,22 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>> >> >>  static inline void fscrypt_prepare_lookup_dentry(struct dentry *dentry,
>> >> >>  						 bool is_nokey_name)
>> >> >>  {
>> >> >> -	if (is_nokey_name) {
>> >> >> -		spin_lock(&dentry->d_lock);
>> >> >> +	spin_lock(&dentry->d_lock);
>> >> >> +
>> >> >> +	if (is_nokey_name)
>> >> >>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>> >> >> -		spin_unlock(&dentry->d_lock);
>> >> >> +	else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
>> >> >> +		 dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
>> >> >> +		/*
>> >> >> +		 * Unencrypted dentries and encrypted dentries where the
>> >> >> +		 * key is available are always valid from fscrypt
>> >> >> +		 * perspective. Avoid the cost of calling
>> >> >> +		 * fscrypt_d_revalidate unnecessarily.
>> >> >> +		 */
>> >> >> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>> >> >>  	}
>> >> >> +
>> >> >> +	spin_unlock(&dentry->d_lock);
>> >> >
>> >> > This makes lookups in unencrypted directories start doing the
>> >> > spin_lock/spin_unlock pair.  Is that really necessary?
>> >> >
>> >> > These changes also make the inline function fscrypt_prepare_lookup() very long
>> >> > (when including the fscrypt_prepare_lookup_dentry() that's inlined into it).
>> >> > The rule that I'm trying to follow is that to the extent that the fscrypt helper
>> >> > functions are inlined, the inline part should be a fast path for unencrypted
>> >> > directories.  Encrypted directories should be handled out-of-line.
>> >> >
>> >> > So looking at the original fscrypt_prepare_lookup():
>> >> >
>> >> > 	static inline int fscrypt_prepare_lookup(struct inode *dir,
>> >> > 						 struct dentry *dentry,
>> >> > 						 struct fscrypt_name *fname)
>> >> > 	{
>> >> > 		if (IS_ENCRYPTED(dir))
>> >> > 			return __fscrypt_prepare_lookup(dir, dentry, fname);
>> >> >
>> >> > 		memset(fname, 0, sizeof(*fname));
>> >> > 		fname->usr_fname = &dentry->d_name;
>> >> > 		fname->disk_name.name = (unsigned char *)dentry->d_name.name;
>> >> > 		fname->disk_name.len = dentry->d_name.len;
>> >> > 		return 0;
>> >> > 	}
>> >> >
>> >> > If you could just add the DCACHE_OP_REVALIDATE clearing for dentries in
>> >> > unencrypted directories just before the "return 0;", hopefully without the
>> >> > spinlock, that would be good.  Yes, that does mean that
>> >> > __fscrypt_prepare_lookup() will have to handle it too, for the case of dentries
>> >> > in encrypted directories, but that seems okay.
>> >> 
>> >> ok, will do.  IIUC, we might be able to do without the d_lock
>> >> provided there is no store tearing.
>> >> 
>> >> But what was the reason you need the d_lock to set DCACHE_NOKEY_NAME
>> >> during lookup?  Is there a race with parallel lookup setting d_flag that
>> >> I couldn't find? Or is it another reason?
>> >
>> > d_flags is documented to be protected by d_lock.  So for setting
>> > DCACHE_NOKEY_NAME, fs/crypto/ just does the safe thing of taking d_lock.  I
>> > never really looked into whether the lock can be skipped there (i.e., whether
>> > anything else can change d_flags while ->lookup is running), since this code
>> > only ran for no-key names, for which performance isn't really important.
>> 
>> Yes, I was looking for the actual race that could happen here, and
>> couldn't find one. As far as I understand it, the only thing that could
>> see the dentry during a lookup would be a parallel lookup, but those
>> will be held waiting for completion in d_alloc_parallel, and won't touch
>> d_flags.  Currently, right after this code, we call d_set_d_op() in
>> generic_set_encrypted_ci_d_ops(), which will happily write d_flags without
>> the d_lock. If this is a problem here, we have a problem there.
>> 
>> What I really don't want to do is keep the lock for DCACHE_NOKEY_NAME,
>> but drop it for unsetting DCACHE_OP_REVALIDATE right in the same field,
>> without a good reason.  I get the argument that unencrypted
>> dentries are a much hotter path and we care more.  But the locking rules
>> of ->d_lookup don't change for both cases.
>
> Even if it were to work in this case I don't think it is generally safe
> to do. But also, for DCACHE_OP_REVALIDATE afaict this is an
> optimization. Why don't you simply accept the raciness, just like fuse
> does in fuse_dentry_settime(), check for DCACHE_OP_REVALIDATE locklessly
> and only take the lock if that thing is set?

That sounds extremely reasonable.  I will follow that approach!

Thanks,

-- 
Gabriel Krisman Bertazi

