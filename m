Return-Path: <linux-fsdevel+bounces-8309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9E832B13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36A81F258EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB55380F;
	Fri, 19 Jan 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eazi30v7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qaapnByS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eazi30v7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qaapnByS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3A1E48F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673634; cv=none; b=QqY72qR8jAzSRv2vxb00OylPxK6M29OoWPaT+mHrG0/KRgDN7ryOrLo5xblZCDl8EqTQMlF31mFgG+4fDMLQxOnt3AYHsMffCpOvrwRZEUDHmzpvYhWdXC9RX2PgpeZ7NPPRu/NlOLHDbmCChvOErjD9pU54g5prSo16I+ARldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673634; c=relaxed/simple;
	bh=BxHETcSb3trXL/MQ1MNzQa2KZfmHhBl0SB3QF2I7bDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6AqvqyY6kQkuM0/8dvxC85kWmgmc9XqpH0FPPf9+BxLfM3Z/F0M2nNTjndKT9Fk6WJZlaOMTNnr6lbtxgSGpZRZgbZXLfdrWTDXnUHhDoBwtHeqevuC6nT0/Yk+bKwj3nbUKe5L93U5IqnzoTvg5xwCKTm/rOzpHmL6AcDTMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eazi30v7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qaapnByS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eazi30v7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qaapnByS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F22671F7F6;
	Fri, 19 Jan 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705673631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lV+Kcubpp20etRJetAFPnB7QiS5HtvMlf1xfmF4ojCw=;
	b=eazi30v7qq+7R+6s17DOoGoaRZNBUETZRagPn/YyM/mW5DQ5sPo/D/uEww7Fqqwn5eIPg+
	N6KBliJr17zVcv0R23+FDgCeYJy2kRv0rQLVqhJ6d/1sFTvfPCMJz9S7TDJdY1kwMiKeoP
	qg0gumeAUJ2g7UrQEugJmhfNw4XafpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705673631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lV+Kcubpp20etRJetAFPnB7QiS5HtvMlf1xfmF4ojCw=;
	b=qaapnBySHXmBwx6mBr9M6krlPzkadgN//GH0tc7bJfOGkykcxcVmg02Dq5wKdNRgo7pVUx
	XtJXp3benezquZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705673631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lV+Kcubpp20etRJetAFPnB7QiS5HtvMlf1xfmF4ojCw=;
	b=eazi30v7qq+7R+6s17DOoGoaRZNBUETZRagPn/YyM/mW5DQ5sPo/D/uEww7Fqqwn5eIPg+
	N6KBliJr17zVcv0R23+FDgCeYJy2kRv0rQLVqhJ6d/1sFTvfPCMJz9S7TDJdY1kwMiKeoP
	qg0gumeAUJ2g7UrQEugJmhfNw4XafpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705673631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lV+Kcubpp20etRJetAFPnB7QiS5HtvMlf1xfmF4ojCw=;
	b=qaapnBySHXmBwx6mBr9M6krlPzkadgN//GH0tc7bJfOGkykcxcVmg02Dq5wKdNRgo7pVUx
	XtJXp3benezquZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 562941388C;
	Fri, 19 Jan 2024 14:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BXSoAp6DqmUiLQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 14:13:50 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>,  tytso@mit.edu,
  linux-fsdevel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  jaegeuk@kernel.org
Subject: Re: [PATCH v2] libfs: Attempt exact-match comparison first during
 casefold lookup
In-Reply-To: <CAHk-=whgQXOouz7KVHKb_SYEo1qujH_1c9TjMLmaQmdbdRE_uw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 18 Jan 2024 11:29:31 -0800")
Organization: SUSE
References: <20240118004618.19707-1-krisman@suse.de>
	<20240118035053.GB1103@sol.localdomain>
	<8734uufy1o.fsf@mailhost.krisman.be>
	<CAHk-=whgQXOouz7KVHKb_SYEo1qujH_1c9TjMLmaQmdbdRE_uw@mail.gmail.com>
Date: Fri, 19 Jan 2024 11:13:47 -0300
Message-ID: <87cytx76n8.fsf@mailhost.krisman.be>
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
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.15%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 18 Jan 2024 at 07:42, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>>
>> But I don't see how this could be a problem.  the str pointer itself
>> can't change since it's already a copy of the dentry->d_name pointer; if
>> the string is external, it is guaranteed to exist until the end of the
>> lookup; Finally, If it's inlined, the string can change concurrently
>> which, in the worst case scenario, gives us a false result. But then,
>> VFS will retry, like we do for the case-insensitive comparison right
>> below.
>>
>> ..Right? :)
>
> Wrong, for two subtle reasons.
>
> The issue is not that the string can go away. The issue is that the
> string and the length have been loaded independently - and may not
> match.
>
> So when you do that
>
>         if (len == name->len && !memcmp(str, name->name, len))
>
> the 'name->len' you test for equality with 'len' may not match the
> length of the string allocated in 'name->name', because they are two
> different loads of two different values, and we do not hold the lock
> that makes them consistent.
>
> See the big comment (and the READ_ONCE()" in dentry_cmp(), and notice
> how dentry_cmp() intentionally doesn't use 'name->len' at all.
>

I see what you mean.  I really appreciate the explanation, by the way.
Thanks for that.

I'll follow up with a v3.

-- 
Gabriel Krisman Bertazi

