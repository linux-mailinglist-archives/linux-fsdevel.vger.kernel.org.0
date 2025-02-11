Return-Path: <linux-fsdevel+bounces-41551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF00A3199A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 00:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E5D3A7204
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB67E267712;
	Tue, 11 Feb 2025 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGOGMF6y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7vK8NZ7Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rGOGMF6y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7vK8NZ7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0127291F;
	Tue, 11 Feb 2025 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316957; cv=none; b=q2u+li2bTmZfbv1hrFyH3WHN6UbZKqkuTapGjepgRf5A2k5N09nsi1qDWpzy+jhfnw3MAwo7HCoKH4mWaJWJijVdh6tcc7OJ5zjiZ1Y6gTqbY3F2plDBEOFitdfhcwoMstZUS2Vec9DQGs+8p4W4ZXGfF71VtB76ydtNkdXV+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316957; c=relaxed/simple;
	bh=li9UlZg3Uq63o0WhQBvFu/IPvtmgwFB7Tx+fBAMTREI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oocQeic3HXkERDkdNkS8VpKt2QirB2koGEB0L+XygX/m4cuLNUE+iOB17CZMzrHajkNITrlg6+DoqSCJu/a8sVevkZGNVwT/Qr0J1khuFe/O9kbcsoD4RJyeUUA5TMyxB7FxPnfCIJXEJbiDbp4xedj0RZKpgLY9xwK0RgadzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGOGMF6y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7vK8NZ7Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rGOGMF6y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7vK8NZ7Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77241336E2;
	Tue, 11 Feb 2025 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739316952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGDSTV55Co8jM4LZXo94jJfAwpKe9R+JXyCuLkh+OEM=;
	b=rGOGMF6yr3gf/CLvmmM9IjiKDaz9aez0fN29u3ea1O1jk9aOsDraV+qKBrXiUWdbw0DYBe
	kspt8wH1q+udph/qBfO6bCfDAYHNJ5ALJg2SphwKG8w1pW1cwNWRv8H0vUFSY5kiSl4IqK
	Ff7txz8DeUixnSaSLbEK3vuSRFGsWzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739316952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGDSTV55Co8jM4LZXo94jJfAwpKe9R+JXyCuLkh+OEM=;
	b=7vK8NZ7ZzIuUu2gkXo8h5KOE+6GfK0DZQOy1DO6GeifxyBUg3r1tu6p8ykbIJXYW1Vpf03
	Nqj4TwKCDhaEp6Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rGOGMF6y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7vK8NZ7Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739316952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGDSTV55Co8jM4LZXo94jJfAwpKe9R+JXyCuLkh+OEM=;
	b=rGOGMF6yr3gf/CLvmmM9IjiKDaz9aez0fN29u3ea1O1jk9aOsDraV+qKBrXiUWdbw0DYBe
	kspt8wH1q+udph/qBfO6bCfDAYHNJ5ALJg2SphwKG8w1pW1cwNWRv8H0vUFSY5kiSl4IqK
	Ff7txz8DeUixnSaSLbEK3vuSRFGsWzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739316952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGDSTV55Co8jM4LZXo94jJfAwpKe9R+JXyCuLkh+OEM=;
	b=7vK8NZ7ZzIuUu2gkXo8h5KOE+6GfK0DZQOy1DO6GeifxyBUg3r1tu6p8ykbIJXYW1Vpf03
	Nqj4TwKCDhaEp6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A682313782;
	Tue, 11 Feb 2025 23:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4L8VFtXeq2e8dgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 11 Feb 2025 23:35:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <20250210051553.GY1977892@ZenIV>
References: <>, <20250210051553.GY1977892@ZenIV>
Date: Wed, 12 Feb 2025 10:35:41 +1100
Message-id: <173931694193.22054.5515495694621442391@noble.neil.brown.name>
X-Rspamd-Queue-Id: 77241336E2
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 10 Feb 2025, Al Viro wrote:
> On Mon, Feb 10, 2025 at 03:58:02PM +1100, NeilBrown wrote:
> > On Sat, 08 Feb 2025, Al Viro wrote:
> > > 1) what's wrong with using middle bits of dentry as index?  What the he=
ll
> > > is that thing about pid for?
> >=20
> > That does "hell" have to do with it?
> >=20
> > All we need here is a random number.  Preferably a cheap random number.
> > pid is cheap and quite random.
> > The dentry pointer would be even cheaper (no mem access) providing it
> > doesn't cost much to get the randomness out.  I considered hash_ptr()
> > but thought that was more code that it was worth.
> >=20
> > Do you have a formula for selecting the "middle" bits in a way that is
> > expected to still give good randomness?
>=20
> ((unsigned long) dentry / L1_CACHE_BYTES) % <table size>
>=20
> Bits just over the cacheline size should have uniform distribution...

I tested this, doing the calculation on each allocation and counting the
number of times each bucket was hit.
On my test kernel with lockdep enabled the dentry is 328 bytes and
L1_CACHE_BYTES is 64.  So 6 cache lines per dentry and 10 dentries per
4K slab.  The indices created by the above formula were roughly 1 in 6
of available.
The 256 possibilities can be divided into 4 groups of 64 and within each
group there are 10 possible values.: 0 6 12 18 24 30 36 42 48 54

Without lockdep making the dentry extra large, struct dentry is 192
bytes, exactly 3 cache lines.  There are 16 entries per 4K slab.
Now exactly 1/4 of possible indices are used.
For every group of 16 possible indices, only 0, 4, 8, 12 are used.
slabinfo says the object size is 256 which explains some of the spread.=20
But ultimately the problem is that addresses are not evenly distributed
inside a single slab.

If I divide by PAGE_SIZE instead of L1_CACHE_BYTES I get every possible
value used but it is far from uniform.
With 40000 allocations we would want about 160 in each slot.
The median I measured is 155 (good) but the range is from 16 to 330
which is nearly +/- 100% of the median.
So that isn't random - but then you weren't suggesting that exactly.

I don't think there is a good case here for selecting bits from the
middle of the dentry address.

If I use hash_ptr(dentry, 8) I get a more uniform distribution.  64000
entries would hope for 250 per bucket.  Median is 248.  Range is 186 to
324 so +/- 25%.

Maybe that is the better choice.


>=20
> > > 2) part in d_add_ci() might be worth a comment re d_lookup_done() coming
> > > for the original dentry, no matter what.
> >=20
> > I think the previous code deserved explanation more than the new, but
> > maybe I missed something.
> > In each case, d_wait_lookup() will wait for the given dentry to no
> > longer be d_in_lookup() which means waiting for DCACHE_PAR_LOOKUP to be
> > cleared.  The only place which clears DCACHE_PAR_LOOKUP is
> > __d_lookup_unhash_wake(). which always wakes the target.
> > In the previous code it would wake both the non-case-exact dentry and
> > the case-exact dentry waiters but they would go back to sleep if their
> > DCACHE_PAR_LOOKUP hadn't been cleared, so no interesting behaviour.
> > Reusing the wq from one to the other is a sensible simplification, but
> > not something we need any reminder of once it is no longer needed.
>=20
> It's not just about the wakeups; any in-lookup dentry should be taken
> out of in-lookup hash before it gets dropped.
> =20
> > > 3) the dance with conditional __wake_up() is worth a helper, IMO.
>=20
> I mean an inlined helper function.

Yes.. Of course...

Maybe we should put

static inline void wake_up_key(struct wait_queue_head *wq, void *key)
{
	__wake_up(wq, TASK_NORMAL, 0, key);
}

in include/linux/wait.h to avoid the __wake_up() "internal" name, and
then use
	wake_up_key(d_wait, dentry);
in the two places in dcache.c, or did you want something
dcache-specific?
I'm not good at guessing what other people are thinking.

Thanks,
NeilBrown

