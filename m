Return-Path: <linux-fsdevel+bounces-13341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1E86ED0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 00:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323351F237B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D75F543;
	Fri,  1 Mar 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ocAx1jpV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZLeExeAr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ocAx1jpV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZLeExeAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2265F465
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336895; cv=none; b=tmsJpjS5Yz9GTH9RgktUR9O2gmMqtpwgOwYFO3PmTup19h6BlNmkuYmZGq7NW3+5SZchoeqcJV86nffQo7WamjdvgZresoWEPUrzEtVcdrEXzamfwoKdZG26QTNBEDne2DIuizycTMBGpZwVU5SsZ+2JRXy+m6NWkRO/NIn5Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336895; c=relaxed/simple;
	bh=68PbKwKX43AAhvncfBJjVtPY5+7VZyoa51wWfr0HkMo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gJphBFIq7h22DmPvxIbg1EsPja90g5NMO6BBHgdzlLDB4lnO8GMb5emQZ/lz6cAdJOyXItm62DGVFFruMI59hxojeIFl5p9StfIXvcetNLKfZy+w69rJy3Fy4NyUha4HdNtG7T76+3ntXLoSWXFkvbXjyWYiz3UrRIraUAjABRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ocAx1jpV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZLeExeAr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ocAx1jpV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZLeExeAr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9290A20D18;
	Fri,  1 Mar 2024 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709336891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4mtuGG7fT9cEaNkhgmYblBuL3AELoQCFPyay9bo8bE=;
	b=ocAx1jpVMLI6HvWx5rTvCAXpbf/jEJdoMQaytqMB1bmq0GZKBxQVFqYuR4P4n6USPNr9VZ
	fEc9lN6w2PkkvAhz990nCv5w4b6uttP5oRby3uIaonEca8T+juHaql/+dc7DEIaUMRvch0
	voTPD+dWWNZW17fyo9breKntSPi9UzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709336891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4mtuGG7fT9cEaNkhgmYblBuL3AELoQCFPyay9bo8bE=;
	b=ZLeExeAruIWgLLregNdOFADT6UTWcOqa3RDJQWHeg8WcGkhCQUB+JHjKd2qI6OXkinY77/
	K0wYhj5lq4BVyhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709336891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4mtuGG7fT9cEaNkhgmYblBuL3AELoQCFPyay9bo8bE=;
	b=ocAx1jpVMLI6HvWx5rTvCAXpbf/jEJdoMQaytqMB1bmq0GZKBxQVFqYuR4P4n6USPNr9VZ
	fEc9lN6w2PkkvAhz990nCv5w4b6uttP5oRby3uIaonEca8T+juHaql/+dc7DEIaUMRvch0
	voTPD+dWWNZW17fyo9breKntSPi9UzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709336891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4mtuGG7fT9cEaNkhgmYblBuL3AELoQCFPyay9bo8bE=;
	b=ZLeExeAruIWgLLregNdOFADT6UTWcOqa3RDJQWHeg8WcGkhCQUB+JHjKd2qI6OXkinY77/
	K0wYhj5lq4BVyhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D06D013A80;
	Fri,  1 Mar 2024 23:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2HM+HDdp4mWNcgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 23:48:07 +0000
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
In-reply-to: <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
Date: Sat, 02 Mar 2024 10:47:59 +1100
Message-id: <170933687972.24797.18406852925615624495@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.32
X-Spamd-Result: default: False [-3.32 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(0.78)[0.260];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat, 02 Mar 2024, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 04:54:55PM +1100, Dave Chinner wrote:
> > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > While we are considering revising mm rules, I would really like to
> > > revised the rule that GFP_KERNEL allocations are allowed to fail.
> > > I'm not at all sure that they ever do (except for large allocations - so
> > > maybe we could leave that exception in - or warn if large allocations
> > > are tried without a MAY_FAIL flag).
> > >=20
> > > Given that GFP_KERNEL can wait, and that the mm can kill off processes
> > > and clear cache to free memory, there should be no case where failure is
> > > needed or when simply waiting will eventually result in success.  And if
> > > there is, the machine is a gonner anyway.
> >=20
> > Yes, please!
> >=20
> > XFS was designed and implemented on an OS that gave this exact
> > guarantee for kernel allocations back in the early 1990s.  Memory
> > allocation simply blocked until it succeeded unless the caller
> > indicated they could handle failure. That's what __GFP_NOFAIL does
> > and XFS is still heavily dependent on this behaviour.
>=20
> I'm not saying we should get rid of __GFP_NOFAIL - actually, I'd say
> let's remove the underscores and get rid of the silly two page limit.
> GFP_NOFAIL|GFP_KERNEL is perfectly safe for larger allocations, as long
> as you don't mind possibly waiting a bit.
>=20
> But it can't be the default because, like I mentioned to Neal, there are
> a _lot_ of different places where we allocate memory in the kernel, and
> they have to be able to fail instead of shoving everything else out of
> memory.
>=20
> > This is the sort of thing I was thinking of in the "remove
> > GFP_NOFS" discussion thread when I said this to Kent:
> >=20
> > 	"We need to start designing our code in a way that doesn't require
> > 	extensive testing to validate it as correct. If the only way to
> > 	validate new code is correct is via stochastic coverage via error
> > 	injection, then that is a clear sign we've made poor design choices
> > 	along the way."
> >=20
> > https://lore.kernel.org/linux-fsdevel/ZcqWh3OyMGjEsdPz@dread.disaster.are=
a/
> >=20
> > If memory allocation doesn't fail by default, then we can remove the
> > vast majority of allocation error handling from the kernel. Make the
> > common case just work - remove the need for all that code to handle
> > failures that is hard to exercise reliably and so are rarely tested.
> >=20
> > A simple change to make long standing behaviour an actual policy we
> > can rely on means we can remove both code and test matrix overhead -
> > it's a win-win IMO.
>=20
> We definitely don't want to make GFP_NOIO/GFP_NOFS allocations nofail by
> default - a great many of those allocations have mempools in front of
> them to avoid deadlocks, and if you do that you've made the mempools
> useless.
>=20

Not strictly true.  mempool_alloc() adds __GFP_NORETRY so the allocation
will certainly fail if that is appropriate.

I suspect that most places where there is a non-error fallback already
use NORETRY or RETRY_MAYFAIL or similar.

But I agree that changing the meaning of GFP_KERNEL has a potential to
cause problems.  I support promoting "GFP_NOFAIL" which should work at
least up to PAGE_ALLOC_COSTLY_ORDER (8 pages).
I'm unsure how it should be have in PF_MEMALLOC_NOFS and
PF_MEMALLOC_NOIO context.  I suspect Dave would tell me it should work in
these contexts, in which case I'm sure it should.

Maybe we could then deprecate GFP_KERNEL.

Thanks,
NeilBrown

