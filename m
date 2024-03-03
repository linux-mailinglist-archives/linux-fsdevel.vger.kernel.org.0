Return-Path: <linux-fsdevel+bounces-13405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7DC86F77E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 23:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA9E2815BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C97AE4F;
	Sun,  3 Mar 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ePRFfgZw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V4xIMvt5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x3sXYsH8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6hPNgHEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1601E51E
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505960; cv=none; b=IGmvNwsNCNHK09tuVj63cX0sxx6U4y4CzMo/GvamaUhzXttELMhZCFauB66jEnpEZaY5CiEAPAvXrCT7KCk0wH3QYFeX+kQmmB+5iwNSTXwWhZXXjZlYLKdLtynT51uyDZ5SZQ3CEJjMatk8v/eQd6B1dFORVfLSOiMWfZ6z0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505960; c=relaxed/simple;
	bh=TEAPtJASiHy+NtL4dtXQx6+wDMIG6Qp52WTbp2aVG9I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DwEdN79+ijrlaRK3dpGkiBYeRVeAPYKkdEtdFZKFnqxEBccqpuw2/GiQ2bRD7nFM0CPtyFwQBSjLOrlrsiyVQjVGKoiyRewWGNRpsB+pfbBNInR1BoK/mcENHa6iscHXt9AxATXmzi2bofQsIzm9AlTFzJ24jK8HhQHsyXjBDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ePRFfgZw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V4xIMvt5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x3sXYsH8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6hPNgHEP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E99B5674D9;
	Sun,  3 Mar 2024 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709505956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hY8gqozPNICnDT7ZJFqvwxo0ZIvUuWJmYwRNFcx2kHc=;
	b=ePRFfgZwlYlxlo1hCf7sE/BCXE6Ms4fyhvRKM/bilahK2B5bg9FHv+DScdS9GcROAwBt6J
	YzZXOrOBV7MsH7pV0fxCrV8rW3983t+GBoDSNS/jMdU1FUjC1pXXT/OjQvsIfuiDK7lCrs
	EZG9aaKnNmlmpEoJM+hecjHA5KrqyUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709505956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hY8gqozPNICnDT7ZJFqvwxo0ZIvUuWJmYwRNFcx2kHc=;
	b=V4xIMvt5bIqFh0iUjPqdwfa0xvxTlLxLR7//CfEQ8FQd0gIvnyaOgbcjRv5l2N7ISHY2N3
	7Wt/Nf9to2uBLICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709505955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hY8gqozPNICnDT7ZJFqvwxo0ZIvUuWJmYwRNFcx2kHc=;
	b=x3sXYsH8U5HpI+E8FjUOlpsAHkbNtOZY34Oksdpxwknzy1r7JKLqvgtn+3+75aHOtGmj+s
	4EDw2SpDhR62pxLRfvO/sbGIFBaEwPjw+BA9mD+hSC2WOwzs+T9URmEBELqCXe3l5UTFt5
	2BWuaZ2bDVcg+6L889eaAEl+CSD7qQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709505955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hY8gqozPNICnDT7ZJFqvwxo0ZIvUuWJmYwRNFcx2kHc=;
	b=6hPNgHEPfs6p+HXcXzwp/3Ba96qCGnCt2K5uqhzgb8aJUSvQb5+oyraGVYUhU5QZPYGZEG
	RQvlpvfkjvlNYpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33CF91379D;
	Sun,  3 Mar 2024 22:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HFEFMZ/95GWFZQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 03 Mar 2024 22:45:51 +0000
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
Cc: "Dave Chinner" <david@fromorbit.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Amir Goldstein" <amir73il@gmail.com>,
 paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
Date: Mon, 04 Mar 2024 09:45:48 +1100
Message-id: <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x3sXYsH8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6hPNgHEP
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E99B5674D9
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Sat, 02 Mar 2024, Kent Overstreet wrote:
> On Sat, Mar 02, 2024 at 10:47:59AM +1100, NeilBrown wrote:
> > On Sat, 02 Mar 2024, Kent Overstreet wrote:
> > > On Fri, Mar 01, 2024 at 04:54:55PM +1100, Dave Chinner wrote:
> > > > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > > > While we are considering revising mm rules, I would really like to
> > > > > revised the rule that GFP_KERNEL allocations are allowed to fail.
> > > > > I'm not at all sure that they ever do (except for large allocations=
 - so
> > > > > maybe we could leave that exception in - or warn if large allocatio=
ns
> > > > > are tried without a MAY_FAIL flag).
> > > > >=20
> > > > > Given that GFP_KERNEL can wait, and that the mm can kill off proces=
ses
> > > > > and clear cache to free memory, there should be no case where failu=
re is
> > > > > needed or when simply waiting will eventually result in success.  A=
nd if
> > > > > there is, the machine is a gonner anyway.
> > > >=20
> > > > Yes, please!
> > > >=20
> > > > XFS was designed and implemented on an OS that gave this exact
> > > > guarantee for kernel allocations back in the early 1990s.  Memory
> > > > allocation simply blocked until it succeeded unless the caller
> > > > indicated they could handle failure. That's what __GFP_NOFAIL does
> > > > and XFS is still heavily dependent on this behaviour.
> > >=20
> > > I'm not saying we should get rid of __GFP_NOFAIL - actually, I'd say
> > > let's remove the underscores and get rid of the silly two page limit.
> > > GFP_NOFAIL|GFP_KERNEL is perfectly safe for larger allocations, as long
> > > as you don't mind possibly waiting a bit.
> > >=20
> > > But it can't be the default because, like I mentioned to Neal, there are
> > > a _lot_ of different places where we allocate memory in the kernel, and
> > > they have to be able to fail instead of shoving everything else out of
> > > memory.
> > >=20
> > > > This is the sort of thing I was thinking of in the "remove
> > > > GFP_NOFS" discussion thread when I said this to Kent:
> > > >=20
> > > > 	"We need to start designing our code in a way that doesn't require
> > > > 	extensive testing to validate it as correct. If the only way to
> > > > 	validate new code is correct is via stochastic coverage via error
> > > > 	injection, then that is a clear sign we've made poor design choices
> > > > 	along the way."
> > > >=20
> > > > https://lore.kernel.org/linux-fsdevel/ZcqWh3OyMGjEsdPz@dread.disaster=
.area/
> > > >=20
> > > > If memory allocation doesn't fail by default, then we can remove the
> > > > vast majority of allocation error handling from the kernel. Make the
> > > > common case just work - remove the need for all that code to handle
> > > > failures that is hard to exercise reliably and so are rarely tested.
> > > >=20
> > > > A simple change to make long standing behaviour an actual policy we
> > > > can rely on means we can remove both code and test matrix overhead -
> > > > it's a win-win IMO.
> > >=20
> > > We definitely don't want to make GFP_NOIO/GFP_NOFS allocations nofail by
> > > default - a great many of those allocations have mempools in front of
> > > them to avoid deadlocks, and if you do that you've made the mempools
> > > useless.
> > >=20
> >=20
> > Not strictly true.  mempool_alloc() adds __GFP_NORETRY so the allocation
> > will certainly fail if that is appropriate.
>=20
> *nod*=20
>=20
> > I suspect that most places where there is a non-error fallback already
> > use NORETRY or RETRY_MAYFAIL or similar.
>=20
> NORETRY and RETRY_MAYFAIL actually weren't on my radar, and I don't see
> _tons_ of uses for either of them - more for NORETRY.
>=20
> My go-to is NOWAIT in this scenario though; my common pattern is "try
> nonblocking with locks held, then drop locks and retry GFP_KERNEL".
> =20
> > But I agree that changing the meaning of GFP_KERNEL has a potential to
> > cause problems.  I support promoting "GFP_NOFAIL" which should work at
> > least up to PAGE_ALLOC_COSTLY_ORDER (8 pages).
>=20
> I'd support this change.
>=20
> > I'm unsure how it should be have in PF_MEMALLOC_NOFS and
> > PF_MEMALLOC_NOIO context.  I suspect Dave would tell me it should work in
> > these contexts, in which case I'm sure it should.
> >=20
> > Maybe we could then deprecate GFP_KERNEL.
>=20
> What do you have in mind?

I have in mind a more explicit statement of how much waiting is
acceptable.

GFP_NOFAIL - wait indefinitely
GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
            don't wait indefinitely.  May abort more quickly if fatal
            signal is pending.
GFP_NO_RETRY - only try things once.  This may sleep, but will give up
            fairly quickly.  Either deadlock is a significant
            possibility, or alternate strategy is fairly cheap.
GFP_ATOMIC - don't sleep - same as current.

I don't see how "GFP_KERNEL" fits into that spectrum.  The definition of
"this will try really hard, but might fail and we can't really tell you
what circumstances it might fail in" isn't fun to work with.

Thanks,
NeilBrown


>=20
> Deprecating GFP_NOFS and GFP_NOIO would be wonderful - those should
> really just be PF_MEMALLOC_NOFS and PF_MEMALLOC_NOIO, now that we're
> pushing for memalloc_flags_(save|restore) more.
>=20
> Getting rid of those would be a really nice cleanup beacuse then gfp
> flags would mostly just be:
>  - the type of memory to allocate (highmem, zeroed, etc.)
>  - how hard to try (don't block at all, block some, block forever)
>=20


