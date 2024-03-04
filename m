Return-Path: <linux-fsdevel+bounces-13417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166586F825
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F9AB20B51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA15443D;
	Mon,  4 Mar 2024 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RgsW7pz7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PR4QviNL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rT7LfeyB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="piU5ZQ4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC953C39
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515028; cv=none; b=H1NPGxAy+/wfuhPu6OjGGYrzx9P/OG/eRrXHt/JfTwVKU8tiNEGbCzKwpFNmgS2r4nrcFxtBH917J5VbgIwEF5Ao5btyFsX7g15ImJKjqRsmOB9jd21Ko68Gh+4oacF5vETsoYzC5yOYnjVmnLHru99ezX3E+gzIArW7OsSErWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515028; c=relaxed/simple;
	bh=1Aq5/mIoxS2d/PxL35bmJseWMxsFTTehB+gbQ++C5NM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hrVB8C4m27C3Dr06E4nUZkD/Ltgak6wonSzGePgQQDmK4XBawaYFaiYzGx9yFs+NmwlozxJqYGhntGgkIjR04fPP/jkylIvuuahj3If6q3QcdqrJAiw/wOMsS8MbUS3Aaid3J+/k6EC9t7DNWA3MmzVH/gou7aDmtTpp0PEm7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RgsW7pz7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PR4QviNL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rT7LfeyB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=piU5ZQ4A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39915679F2;
	Mon,  4 Mar 2024 01:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709515024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BhzHrZUvZkmoqepVbNm6BaBGGtxilY+mLB34SlnSCI=;
	b=RgsW7pz7L5xMrxarCi99vh37/2Z7LDBkMaqbnouG4pCtGA15RJeMdk4HpQh1P00CTfaHC1
	K4GJIg37Hi1hZml8TQ4eEtxU/whLoAZaoMPQs4pXMnVRODE1meW/CTRybm1/AO2mRl69fQ
	jU9IQehD+Q/C8o0xmyto2oPfHv6mX7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709515024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BhzHrZUvZkmoqepVbNm6BaBGGtxilY+mLB34SlnSCI=;
	b=PR4QviNL9fW30QNqvLsAZQ/S1sUgB/xQ+1K1vZOaAYrOD+eGfoi1aCZGQ/V0Xr1Bx26WU+
	Ss32xY8itzt7zODA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709515022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BhzHrZUvZkmoqepVbNm6BaBGGtxilY+mLB34SlnSCI=;
	b=rT7LfeyBDW84bizhefCkStI4Je4X8OvbixyA+HTFHQaCSJfe7dOdRbOglKT7mxCmaAbzFg
	Hk2pvl3gq3RB6q2NAbwuuf0U+dVbaUqMPlB4UtjAZLjeMvbFfgstN821Ee23NyMpZI1Ira
	cVwpHPMOVBFrMs1HLaS0M18ySSbVVyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709515022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BhzHrZUvZkmoqepVbNm6BaBGGtxilY+mLB34SlnSCI=;
	b=piU5ZQ4ACgESro3kyVjdBM0JD8GzsUeaTBqAo/yRPoauS5zxDAHlvofhIfLlFxNn34hG6e
	0PQCmosrdRqBvwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 784BC1379D;
	Mon,  4 Mar 2024 01:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J6U2Bwoh5WU8CgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 01:16:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Matthew Wilcox" <willy@infradead.org>, "Amir Goldstein" <amir73il@gmail.com>,
 paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <ZeUTyxYFS6kGoM1h@dread.disaster.area>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>,
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>,
 <ZeUTyxYFS6kGoM1h@dread.disaster.area>
Date: Mon, 04 Mar 2024 12:16:50 +1100
Message-id: <170951501074.24797.10807279234722357224@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rT7LfeyB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=piU5ZQ4A
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[fromorbit.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 39915679F2
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Mon, 04 Mar 2024, Dave Chinner wrote:
> On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > I have in mind a more explicit statement of how much waiting is
> > acceptable.
> >=20
> > GFP_NOFAIL - wait indefinitely
>=20
> Make this the default, and we don't need a flag for it at all.

These aren't meant to be flags - those start with __.
They are ..  "flag combinations" to use the term description from
gfp_types.h

There could only be a "default" if we used macro magic to allow the GFP_
argument to be omitted.

>=20
> > GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> > GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
> >             don't wait indefinitely.  May abort more quickly if fatal
> >             signal is pending.
>=20
> KILLABLE and RETRY are the same thing from the caller POV.
> Effectively "GFP_MAY_FAIL", where it will try really hard, but if it
> there is a risk of deadlock or a fatal signal pending, it will fail.
>=20
> > GFP_NO_RETRY - only try things once.  This may sleep, but will give up
> >             fairly quickly.  Either deadlock is a significant
> >             possibility, or alternate strategy is fairly cheap.
> > GFP_ATOMIC - don't sleep - same as current.
>=20
> We're talking about wait semantics, so GFP_ATOMIC should be named
> GFP_NO_WAIT and described as "same as NO_RETRY but will not sleep".
>=20
> That gives us three modifying flags to the default behaviour of
> sleeping until success: GFP_MAY_FAIL, GFP_NO_RETRY and GFP_NO_WAIT.


We currently have both __GFP_NORETRY and __GFP_RETRY_MAYFAIL which
differ in how many retries (1 or a few) and are both used (the former
about twice as much as the latter).
Do we need both?

Commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by __GFP_RETRY_MAYF=
AIL with more useful semantic")

might be useful in understanding the RETRY_MAYFAIL semantic.

I think the intent is that RETRY_MAYFAIL doesn't trigger the oom killer.
That seems like it could be a useful distinction.

GFP_NOFAIL - retry indefinitely
GFP_NOOOM  - retry until fatal signal or OOM condition
GFP_NORETRY - sleep if needed, but don't retry
GFP_NOSLEEP - AKA GFP_ATOMIC

We might need a better name than GFP_NOOOM :-)

Thanks,
NeilBrown


>=20
> I will note there is one more case callers might really want to
> avoid: direct reclaim. That sort of behaviour might be worth folding
> into GFP_NO_WAIT, as there are cases where we want the allocation
> attempt to fail without trying to reclaim memory because it's *much*
> faster to simply use the fallback mechanism than it is to attempt
> memory reclaim (e.g.  xlog_kvmalloc()).
>=20
> > I don't see how "GFP_KERNEL" fits into that spectrum.
>=20
> Agreed.
>=20
> > The definition of
> > "this will try really hard, but might fail and we can't really tell you
> > what circumstances it might fail in" isn't fun to work with.
>=20
> Yup, XFS was designed for NO_FAIL and MAY_FAIL behaviour, and in more
> recent times we also use NO_RECLAIM to provide our own kvmalloc
> semantics because the current kvmalloc API really only supports
> "GFP_KERNEL" allocation.
>=20
> > > Deprecating GFP_NOFS and GFP_NOIO would be wonderful - those should
> > > really just be PF_MEMALLOC_NOFS and PF_MEMALLOC_NOIO, now that we're
> > > pushing for memalloc_flags_(save|restore) more.
>=20
> This is largely now subsystem maintenance work - the infrastructure
> is there, and some subsystems have been converted over entirely to
> use it. The remaining work either needs to be mandated or have
> someone explicitly tasked with completing that work.
>=20
> IOWs, the process in which we change APIs and then leave the long
> tail of conversions to subsystem maintainers is just a mechanism for
> creating technical debt that takes forever to clean up...
>=20
> > > Getting rid of those would be a really nice cleanup beacuse then gfp
> > > flags would mostly just be:
> > >  - the type of memory to allocate (highmem, zeroed, etc.)
> > >  - how hard to try (don't block at all, block some, block forever)
>=20
> Yup, would be a very good improvement.
>=20
> -Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20


