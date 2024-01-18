Return-Path: <linux-fsdevel+bounces-8260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B30831BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A8F1F21FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7D1E521;
	Thu, 18 Jan 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ExxPuQp4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5bnkvf4d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IWg419VO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mDcGGn5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D939B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590383; cv=none; b=sY7OdN0w6O7uPF/QsRB/3o2dP7JnqOHJchb8qEfbponVnezdwcBwrRYrxMw9kU/PvTZD+hulZWexmn3cBpVSMfu+RiskJLtzqgFwNjqxmiWzboVklcuqBQvtrdoAFmxSscygyhD0Z1RDglx2BTzLrabE4Lq4lRXBrXwFr1HDjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590383; c=relaxed/simple;
	bh=RW7uf+l2ocim/RQVMvmGf7abwTPQqD11NxG4G7apOaY=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=JZDf8YMDbLRrQUgjbT70youWfenZm9U0Krk2DWQKkhBkaQMT/YnmrcEPyq1Rfgd5SOor7ZNWDcL1jVxlg9Vf3cHmEFYzNg5S6HTr003xXSfgmp/15J8PsvxYVvZemJMhLErP+51pEhsnpgfYBAX/uK2b8YXBZKhcMVjr014FV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ExxPuQp4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5bnkvf4d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IWg419VO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mDcGGn5t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF41221D35;
	Thu, 18 Jan 2024 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705590376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfRFRRvugXaVnG/b59iYjbhOe/njb+zF0sG2DN7y6L0=;
	b=ExxPuQp4MSjgahuamXfUCdHYJsuA1YCGhEi2djqqDnnpppC1NkYuxag2/0mlThn56IykFI
	uZxkfkoacgbLXgiQYU4YytUvuRW3+zPRVs9dwQPYzdM1AfyytAr99o5oVjuaSB/cF7SfeV
	PSr3faKZjy1mfSfN/JGwuYSs5MbOQ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705590376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfRFRRvugXaVnG/b59iYjbhOe/njb+zF0sG2DN7y6L0=;
	b=5bnkvf4dPC6bbzFmB6RmS+otCaPovzX36VnJC271jVaTC/IJJFceTd9x43NCfiru7w03ZN
	rAYMriOtehyfPhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705590374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfRFRRvugXaVnG/b59iYjbhOe/njb+zF0sG2DN7y6L0=;
	b=IWg419VOYKH3lMDGWV+uheAwE0ewD8OGd7UyitOqGhjx+Qejq/bSwiFaDZhy77eR1YP+Qd
	v1hnyLuxwliDq2/3MJTJJDYwbS1248VatfJqj+JdIgwf0f0Nx4IJ1SLK38dBY3DwuK+fCD
	Wsvqtfikz+uIo22lHIZY6nLG03rScP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705590374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfRFRRvugXaVnG/b59iYjbhOe/njb+zF0sG2DN7y6L0=;
	b=mDcGGn5t8LqADm07gC5KWakHTckuSS7u4JLXcnFV1jRjSDFmnHv8tpZHSALOsEY4hhOssk
	vMlMIpCugMGhGzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4310A13874;
	Thu, 18 Jan 2024 15:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DE+pOmU+qWWCKAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 18 Jan 2024 15:06:13 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,  Al Viro <viro@zeniv.linux.org.uk>,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
In-Reply-To: <CAHk-=wjkFcF4HKDhSf_fpsLNmDGMkD-ozaNdEhpEQ4JH=MsnNg@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 17 Jan 2024 18:33:40 -0800")
Organization: SUSE
References: <20240117222836.11086-1-krisman@suse.de>
	<20240117223857.GN1674809@ZenIV> <87edeffr0k.fsf@mailhost.krisman.be>
	<CAHk-=wjd_uD4aHWEVZ735EKRcEU6FjUo8_aMXSxRA7AD8DapZA@mail.gmail.com>
	<20240118020554.GA1353741@mit.edu>
	<CAHk-=wjkFcF4HKDhSf_fpsLNmDGMkD-ozaNdEhpEQ4JH=MsnNg@mail.gmail.com>
Date: Thu, 18 Jan 2024 12:06:11 -0300
Message-ID: <87a5p2fzq4.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IWg419VO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mDcGGn5t
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF41221D35
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, 17 Jan 2024 at 18:06, Theodore Ts'o <tytso@mit.edu> wrote:
>> So we don't need to worry about the user not being able to fix it,
>> because they won't have been able to create the file in the first
>> place.
>
> Yeah, that's a fine argument, until you have a bug or subtle bit flip
> data corruption, and now instead of having something you can recover,
> the system actively says "Nope".

I know this is not your point, but I should add that, in case of a
bug or bit flip, we support "fixing" the "bad utf8" string through fsck.

>> I admit that when I discovered that MacOS errored out on illegal utf-8
>> characters it was mildly annoying,
>
> We may have to be able to interoperate with shit, but let's call it what it is.
>
> Nobody pretends FAT is a great filesystem that made great design
> decisions. That doesn't mean that we can't interoperate with it just
> fine.
>
> But we don't need to take those idiotic and bad design decisions to
> heart, and we don't need to hide the fact that they are horrendous
> design mistakes.

There is a correctness issue with accepting the creation of invalid
utf-8 names that justifies the existence of strict mode.  Currently
undefined code-points can become a casefold match to some other file in
a later unicode version. When you decide to update your unicode version
or even copy the file to a volume with a different version, the lookup
might yield a different file, making one of them inaccessible or
overwriting the wrong file.

Obviously, not all corruptions would yield a "valid" undefined
code-point.  But those are possible.

We currently don't care much, since mkfs will create the volume with a
fixed, never-changed unicode version. That is, unless the user goes out
of their way to shoot themselves in the foot.

Strict mode is an easy way to prevent this class of issues (aside from
corruptions).

> So "strict" mode should mean that you can't *create* a misformed UTF-8
> filename.
>
> It's that same "be conservative in what you do".
>
> But *dammit*, if "strict" mode means that you can't even read other
> peoples mistakes because your "->lookup()" function refuses to even
> look at it, then "strict" mode is GARBAGE.
>
> That's the "be liberal in what you accept" part. Do it, or be damned.

Yes, we could be more liberal in the lookup while restricting the
creation of invalid utf8 sequences.  But, the only case where it would
matter is for corrupted volumes, where a file-name suddenly changed to
something invalid.  Considering ext4 and f2fs, since the disk direntry
hash (which is hash(casefolded(filename))) didn't get corrupted exactly
right, looking up the exact-match of the invalid name might fail.

This would create an even more inconsistent semantics, where small,
non-hashed directories can find these files, but larger, hashed
directories might not.  And that is even more confusing to users,
since it exposes internal filesystem details.

I get the point about how annoying the current semantics is.  But I
still think this is the sanest approach to a fundamentally insane
feature.

-- 
Gabriel Krisman Bertazi

