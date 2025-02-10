Return-Path: <linux-fsdevel+bounces-41346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E56A2E1F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1FF188786F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1551CF9B;
	Mon, 10 Feb 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVvg4m6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbVKTVRS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GVvg4m6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbVKTVRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2CC125;
	Mon, 10 Feb 2025 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150428; cv=none; b=VLzZMzsfkdP+PAV7fLf88jx91oPhXaD9B9awUi8do18ctYrzCcjm2VZLSr20xbDgaLjOtGqLcZ+YECJHNMdgXvUJqftgpJ6WURDcRDMPSBkgK9hzFU4Y9ckc5fKoEuqf1xScEms0i4bSmBWKSezJJTViePCv91USBjLdqpHB+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150428; c=relaxed/simple;
	bh=6vm4jw6wg9RdZqCVO4c/MR5vasxo/EaDKybb5J4L5A0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ErxwaYqR5tt2wVL0MTQnCrGEIgt7P7S9LFbYz3+/RxZioKigOCTnn1Uq/Tofa3QYkFFal0CiQBbKCXq3JRlyDG1XcBJS94kZ3n7yiZ8TARzeMm7Zfx49J9Mskk4RyJXS1AtF8wnfLGI3fsPumEkslyRWRoNnVUCwberXIR8J3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVvg4m6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbVKTVRS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GVvg4m6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbVKTVRS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B82921102;
	Mon, 10 Feb 2025 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739150425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNHkLWb8LhlVxwfN71tab7fM7Ihwg66qglqKNi6jmFg=;
	b=GVvg4m6Oi+5Nf73A3l4nea6uMla+aAQMPpYPlG8SWuZ7oRQepMR8R9VmmtKyM73xUIh4X8
	470qmg9kUKy1tnAru1Wrl9o4Tv+dVCprIlazwc2A4YvAKbYdNOP86tNqxDPENlx58ONqeW
	oPeqOtzaGLovzCA95Uyfv78PZECyg7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739150425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNHkLWb8LhlVxwfN71tab7fM7Ihwg66qglqKNi6jmFg=;
	b=RbVKTVRSav7aiYPr8v8nupZZlw+Bdw+DsmKbdWDU8HAdGceAvEXvrFVD8+hjZxcIymRl2T
	CXfKlMNq8eRzBqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739150425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNHkLWb8LhlVxwfN71tab7fM7Ihwg66qglqKNi6jmFg=;
	b=GVvg4m6Oi+5Nf73A3l4nea6uMla+aAQMPpYPlG8SWuZ7oRQepMR8R9VmmtKyM73xUIh4X8
	470qmg9kUKy1tnAru1Wrl9o4Tv+dVCprIlazwc2A4YvAKbYdNOP86tNqxDPENlx58ONqeW
	oPeqOtzaGLovzCA95Uyfv78PZECyg7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739150425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNHkLWb8LhlVxwfN71tab7fM7Ihwg66qglqKNi6jmFg=;
	b=RbVKTVRSav7aiYPr8v8nupZZlw+Bdw+DsmKbdWDU8HAdGceAvEXvrFVD8+hjZxcIymRl2T
	CXfKlMNq8eRzBqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B2BF13AA4;
	Mon, 10 Feb 2025 01:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKKtC1JUqWcyNgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 10 Feb 2025 01:20:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Tom Talpey" <tom@talpey.com>, "Paul Moore" <paul@paul-moore.com>,
 "Eric Paris" <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
In-reply-to: <4bxqnnpfau5sq2h7oexvrvazqqpn55e7vsjlj44epdcas2clzf@424354eeo6dl>
References:
 <>, <4bxqnnpfau5sq2h7oexvrvazqqpn55e7vsjlj44epdcas2clzf@424354eeo6dl>
Date: Mon, 10 Feb 2025 12:20:15 +1100
Message-id: <173915041509.22054.12649815796390080222@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 08 Feb 2025, Kent Overstreet wrote:
> On Fri, Feb 07, 2025 at 06:30:00PM +1100, NeilBrown wrote:
> > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> > > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > > > > Do you think there could be a problem with changing the error ret=
urned
> > > > > > in this circumstance? i.e. if you try to destroy a subvolume with=
 a
> > > > > > non-existant name on a different filesystem could getting -ENOENT
> > > > > > instead of -EXDEV be noticed?
> > > > >=20
> > > > > -EXDEV is the standard error code for "we're crossing a filesystem
> > > > > boundary and we can't or aren't supposed to be", so no, let's not c=
hange
> > > > > that.
> > > > >=20
> > > >=20
> > > > OK.  As bcachefs is the only user of user_path_locked_at() it shouldn=
't
> > > > be too hard.
> > >=20
> > > Hang on, why does that require keeping user_path_locked_at()? Just
> > > compare i_sb...
> > >=20
> >=20
> > I changed user_path_locked_at() to not return a dentry at all when the
> > full path couldn't be found.  If there is no dentry, then there is no
> > ->d_sb.
> > (if there was an ->i_sb, there would be an inode and this all wouldn't
> > be an issue).
> >=20
> > To recap: the difference happens if the path DOESN'T exist but the
> > parent DOES exist on a DIFFERENT filesystem.  It is very much a corner
> > case and the error code shouldn't matter.  But I had to ask...
>=20
> Ahh...
>=20
> Well, if I've scanned the series correctly (sorry, we're on different
> timezones and I haven't had much caffeine yet) I hope you don't have to
> keep that function just for bcachefs - but I do think the error code is
> important.
>=20
> Userspace getting -ENOENT and reporting -ENOENT to the user will
> inevitably lead to head banging frustration by someone, somewhere, when
> they're trying to delete something and the system is tell them it
> doesn't exist when they can see it very much does exist, right there :)
> the more precise error code is a very helpful cue...
>=20

???
You will only get -ENOENT if there is no ent.  There is no question of a
confusing error message.
If you ask for a non-exist name on the correct filesystem, you get -ENOENT
If you ask for an existing name of the wrong filesystem, you get -EXDEV
That all works as expected and always has.

But what if you ask for a non-existing name in a directory on the
wrong filesystem? =20
The code you originally wrote in 42d237320e9817a9 would return
-ENOENT because that it what user_path_at() would return.
But using user_path_at() is "wrong" because it doesn't lock the directory
so ->d_parent is not guaranteed to be stable.
Al fixed that in bbe6a7c899e7f265c using user_path_locked_at(), but
that doesn't check for a negative dentry so Al added a check to return
-ENOENT, but that was added *after* the test that returns -EXDEV.

So now if you call subvolume_destroy on a non-existing name in a
directory on the wrong filesystem, you get -EXDEV.  I think that is
a bit weird but not a lot weird.
My patch will change it back to -ENOENT - the way you originally wrote
it.

I hope you are ok with that.

NeilBrown


