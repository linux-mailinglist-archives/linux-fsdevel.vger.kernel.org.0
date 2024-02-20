Return-Path: <linux-fsdevel+bounces-12188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84A85CBA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB661C21B87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 23:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846D154434;
	Tue, 20 Feb 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i7jMSMQk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1qvswjm5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i7jMSMQk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1qvswjm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88534763E8;
	Tue, 20 Feb 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470204; cv=none; b=cZ5Yur5JxVs58yZNgcVU4wxHgAfkKCRvosyQbjEz+s0cGKitsgMcl6WX33cfdaiONCnxEhjjaxia3qbmHicxWOxmPEQl680tw4RyWwAkJvvTC4rbKZz//YNRZDfUB8TEg/nbjmElNrNlEIZJfF88oD3cu/BUHcbISDSevIbrJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470204; c=relaxed/simple;
	bh=nOwq1O6o5gI4UVjj1xHw2KYACb9RT6S4411/ujxy5Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTns1UP63lS4NY7R57OqC0RHdPMptowPWeC0WsTho/k7l1pLmyKxp7DZrJ7cm+ySOA+6qOgtlo63h0MJCu0Ww/x6G7cxHozm1y1tjUuWOyNCGfyXp1RCHFMyaKx6uZl+7usXu2IG8oLchWazcAdp/Tuk+gXaKW5Ksl+I812mlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i7jMSMQk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1qvswjm5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i7jMSMQk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1qvswjm5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B47EC21EC0;
	Tue, 20 Feb 2024 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708470194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WF1IXh+fBnSN8LQbhCP/XIN1EbVVDvvTkk0nMzutoiw=;
	b=i7jMSMQk7cleGz/czFetNQYmji0YBhI+Rpe/S4RNzrjaPs334KRqcFNgd8baNZaeSv4gcb
	B8ThL3hXGv+4JIJ3ph+DZBm314tpaphHanOxhvUvO2ETGKKjnCEE7ZcX/Hx1Ua5SUQOGxE
	d9PLaeNPKh6KcpMpGSyylXhXU990IYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708470194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WF1IXh+fBnSN8LQbhCP/XIN1EbVVDvvTkk0nMzutoiw=;
	b=1qvswjm5EoNFxZ2Pfu9puIJJj0ydlCpLpSKobCjmDLPFO1kUGoh6BxbP1jbCZ5qwL98QOK
	pBaLl1xcxY643yCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708470194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WF1IXh+fBnSN8LQbhCP/XIN1EbVVDvvTkk0nMzutoiw=;
	b=i7jMSMQk7cleGz/czFetNQYmji0YBhI+Rpe/S4RNzrjaPs334KRqcFNgd8baNZaeSv4gcb
	B8ThL3hXGv+4JIJ3ph+DZBm314tpaphHanOxhvUvO2ETGKKjnCEE7ZcX/Hx1Ua5SUQOGxE
	d9PLaeNPKh6KcpMpGSyylXhXU990IYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708470194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WF1IXh+fBnSN8LQbhCP/XIN1EbVVDvvTkk0nMzutoiw=;
	b=1qvswjm5EoNFxZ2Pfu9puIJJj0ydlCpLpSKobCjmDLPFO1kUGoh6BxbP1jbCZ5qwL98QOK
	pBaLl1xcxY643yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BB6D139D0;
	Tue, 20 Feb 2024 23:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FCoqGLIv1WW2LwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 20 Feb 2024 23:03:14 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk,  jaegeuk@kernel.org,  tytso@mit.edu,
  amir73il@gmail.com,  linux-ext4@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  brauner@kernel.org
Subject: Re: [PATCH v6 03/10] fscrypt: Drop d_revalidate for valid dentries
 during lookup
In-Reply-To: <20240214235904.GH1638@sol.localdomain> (Eric Biggers's message
	of "Wed, 14 Feb 2024 15:59:04 -0800")
Organization: SUSE
References: <20240213021321.1804-1-krisman@suse.de>
	<20240213021321.1804-4-krisman@suse.de>
	<20240214235904.GH1638@sol.localdomain>
Date: Tue, 20 Feb 2024 18:03:13 -0500
Message-ID: <87o7caagcu.fsf@mailhost.krisman.be>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i7jMSMQk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1qvswjm5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
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
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,gmail.com,vger.kernel.org,lists.sourceforge.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: B47EC21EC0
X-Spam-Flag: NO

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Feb 12, 2024 at 09:13:14PM -0500, Gabriel Krisman Bertazi wrote:
>> Finally, we need to clean the dentry->flags even for unencrypted
>> dentries, so the ->d_lock might be acquired even for them.  In order to
>
> might => must?
>
>> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
>> index 47567a6a4f9d..d1f17b90c30f 100644
>> --- a/include/linux/fscrypt.h
>> +++ b/include/linux/fscrypt.h
>> @@ -951,10 +951,29 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
>>  static inline void fscrypt_prepare_dentry(struct dentry *dentry,
>>  					  bool is_nokey_name)
>>  {
>> +	/*
>> +	 * This code tries to only take ->d_lock when necessary to write
>> +	 * to ->d_flags.  We shouldn't be peeking on d_flags for
>> +	 * DCACHE_OP_REVALIDATE unlocked, but in the unlikely case
>> +	 * there is a race, the worst it can happen is that we fail to
>> +	 * unset DCACHE_OP_REVALIDATE and pay the cost of an extra
>> +	 * d_revalidate.
>> +	 */
>>  	if (is_nokey_name) {
>>  		spin_lock(&dentry->d_lock);
>>  		dentry->d_flags |= DCACHE_NOKEY_NAME;
>>  		spin_unlock(&dentry->d_lock);
>> +	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
>> +		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
>> +		/*
>> +		 * Unencrypted dentries and encrypted dentries where the
>> +		 * key is available are always valid from fscrypt
>> +		 * perspective. Avoid the cost of calling
>> +		 * fscrypt_d_revalidate unnecessarily.
>> +		 */
>> +		spin_lock(&dentry->d_lock);
>> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>> +		spin_unlock(&dentry->d_lock);
>>  	}
>>  }
>
> Does this all get optimized out when !CONFIG_FS_ENCRYPTION?
>
> As-is, I don't think the d_revalidate part will be optimized out.
>

it seems to get optimized out:

This is ext4_lookup built with CONFIG_FS_ENCRYPTION=n

ffffffff814ca3e0 <ext4_lookup>:
ffffffff814ca3e0:       e8 5b b5 c3 ff          call   ffffffff81105940 <__fentry__>
ffffffff814ca3e5:       41 54                   push   %r12
ffffffff814ca3e7:       55                      push   %rbp
ffffffff814ca3e8:       53                      push   %rbx
ffffffff814ca3e9:       48 83 ec 58             sub    $0x58,%rsp
ffffffff814ca3ed:       8b 56 24                mov    0x24(%rsi),%edx
ffffffff814ca3f0:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
ffffffff814ca3f7:       00 00
ffffffff814ca3f9:       48 89 44 24 50          mov    %rax,0x50(%rsp)
ffffffff814ca3fe:       31 c0                   xor    %eax,%eax
ffffffff814ca400:       48 c7 c0 dc ff ff ff    mov    $0xffffffffffffffdc,%rax
ffffffff814ca407:       81 fa ff 00 00 00       cmp    $0xff,%edx
ffffffff814ca40d:       76 21                   jbe    ffffffff814ca430 <ext4_lookup+0x50>
ffffffff814ca40f:       48 8b 4c 24 50          mov    0x50(%rsp),%rcx
ffffffff814ca414:       65 48 33 0c 25 28 00    xor    %gs:0x28,%rcx
ffffffff814ca41b:       00 00
ffffffff814ca41d:       0f 85 cd 01 00 00       jne    ffffffff814ca5f0 <ext4_lookup+0x210>  <- (__stack_chk_fail)
ffffffff814ca423:       48 83 c4 58             add    $0x58,%rsp
ffffffff814ca427:       5b                      pop    %rbx
ffffffff814ca428:       5d                      pop    %rbp
ffffffff814ca429:       41 5c                   pop    %r12
ffffffff814ca42b:       e9 70 21 8b 00          jmp    ffffffff81d7c5a0 <__x86_return_thunk>
ffffffff814ca430:       48 89 f3                mov    %rsi,%rbx
ffffffff814ca433:       89 54 24 20             mov    %edx,0x20(%rsp)
ffffffff814ca437:       48 8d 76 20             lea    0x20(%rsi),%rsi
ffffffff814ca43b:       48 8b 43 28             mov    0x28(%rbx),%rax
ffffffff814ca43f:       48 8d 54 24 10          lea    0x10(%rsp),%rdx
ffffffff814ca444:       48 89 fd                mov    %rdi,%rbp
ffffffff814ca447:       48 89 74 24 10          mov    %rsi,0x10(%rsp)
ffffffff814ca44c:       48 89 44 24 18          mov    %rax,0x18(%rsp)
ffffffff814ca451:       e8 ca f0 ff ff          call   ffffffff814c9520 <ext4_fname_setup_ci_filename>

[..]

I had also confirmed previously that fscrypt_lookup_prepare and
fscrypt_prepare_dentry gets correctly inlined into
ext4_fname_prepare_lookup.


> You may need to create a !CONFIG_FS_ENCRYPTION stub explicitly.

But, in spite of gcc doing the right thing now, fscrypt_prepare_dentry
might grow in the future. So, if you don't mind, I will still add the
stub explicitly, as you suggested.

thanks,

-- 
Gabriel Krisman Bertazi

