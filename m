Return-Path: <linux-fsdevel+bounces-14250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213D879E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EB71F22C57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6BB143C50;
	Tue, 12 Mar 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WRBcpldV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+m1lanxo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WRBcpldV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+m1lanxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50277A730
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281400; cv=none; b=f4DspH595H7MytEw0Xb1LQKQrQkaBwBuyrLBl4S6goyZPZZRxDSuaVHnR9VmcFZaNbg07AVpA4yQMCD8PtAbJ6B3vT4N0ZrbE+Rg2REVXLVWvSpfOT9BxKWm9ou1ErNQZ+nP9GArHpbt1jfYZMZMMXbjhQKBlGGCMS+nnVBslEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281400; c=relaxed/simple;
	bh=2zZDDPusHVtvuKY47+MZf+1hs1x9DqzNC73qRKOk8WE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EipURxplsq/fc5o/hoZc4dLLPgw11LKcHRKDxTjLBGXBCG7K097BrrLZUausD65mBu/3MBeKZJ7N2P/SnfkOnKgBJrcUKYrAyGYLjR+sVEkKxYUz2gofNRF8qfetl7mFzhohH5JKYgf2Cf7DEKYXtS2VBWX9ryUHE8ylv16LAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WRBcpldV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+m1lanxo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WRBcpldV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+m1lanxo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B052221BF8;
	Tue, 12 Mar 2024 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710281396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnhnvuAguaShvZnqnUxmnsYkUTMmDsH7p0cA6XDgY/U=;
	b=WRBcpldVLBNeFN/rOJ5oOkzmrfstQVpSJ8V1Re7qSwyXK4W98THjh5+slt3isMEYE7vai0
	EcxNV5rBTGkL5kaH28V6naF7drLF9lGlgPNVPp3tQBFrV5bvBwfvJ5GxWt3uHnEjmXEPc2
	tajOyKLYL4JdYd37MZQ+MkcJUjuxXQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710281396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnhnvuAguaShvZnqnUxmnsYkUTMmDsH7p0cA6XDgY/U=;
	b=+m1lanxoZbPHWDQLSDFeL9FMF23WRPwPKdTO8XjmZlayF1oGe2Ka2LpJbCuLoA1wXPBDNc
	T7Ocf7tRrYQRSeAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710281396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnhnvuAguaShvZnqnUxmnsYkUTMmDsH7p0cA6XDgY/U=;
	b=WRBcpldVLBNeFN/rOJ5oOkzmrfstQVpSJ8V1Re7qSwyXK4W98THjh5+slt3isMEYE7vai0
	EcxNV5rBTGkL5kaH28V6naF7drLF9lGlgPNVPp3tQBFrV5bvBwfvJ5GxWt3uHnEjmXEPc2
	tajOyKLYL4JdYd37MZQ+MkcJUjuxXQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710281396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnhnvuAguaShvZnqnUxmnsYkUTMmDsH7p0cA6XDgY/U=;
	b=+m1lanxoZbPHWDQLSDFeL9FMF23WRPwPKdTO8XjmZlayF1oGe2Ka2LpJbCuLoA1wXPBDNc
	T7Ocf7tRrYQRSeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E4261364F;
	Tue, 12 Mar 2024 22:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n0CEDLDS8GVkNAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Mar 2024 22:09:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Vlastimil Babka" <vbabka@suse.cz>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Dave Chinner" <david@fromorbit.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Amir Goldstein" <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>,
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>,
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
Date: Wed, 13 Mar 2024 09:09:44 +1100
Message-id: <171028138478.13576.3004333623297072625@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -7.10
X-Spam-Flag: NO

On Wed, 13 Mar 2024, Vlastimil Babka wrote:
> On 3/3/24 23:45, NeilBrown wrote:
> > On Sat, 02 Mar 2024, Kent Overstreet wrote:
> >>=20
> >> *nod*=20
> >>=20
> >> > I suspect that most places where there is a non-error fallback already
> >> > use NORETRY or RETRY_MAYFAIL or similar.
> >>=20
> >> NORETRY and RETRY_MAYFAIL actually weren't on my radar, and I don't see
> >> _tons_ of uses for either of them - more for NORETRY.
> >>=20
> >> My go-to is NOWAIT in this scenario though; my common pattern is "try
> >> nonblocking with locks held, then drop locks and retry GFP_KERNEL".
> >> =20
> >> > But I agree that changing the meaning of GFP_KERNEL has a potential to
> >> > cause problems.  I support promoting "GFP_NOFAIL" which should work at
> >> > least up to PAGE_ALLOC_COSTLY_ORDER (8 pages).
> >>=20
> >> I'd support this change.
> >>=20
> >> > I'm unsure how it should be have in PF_MEMALLOC_NOFS and
> >> > PF_MEMALLOC_NOIO context.  I suspect Dave would tell me it should work=
 in
> >> > these contexts, in which case I'm sure it should.
> >> >=20
> >> > Maybe we could then deprecate GFP_KERNEL.
> >>=20
> >> What do you have in mind?
> >=20
> > I have in mind a more explicit statement of how much waiting is
> > acceptable.
> >=20
> > GFP_NOFAIL - wait indefinitely
> > GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> > GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
> >             don't wait indefinitely.  May abort more quickly if fatal
> >             signal is pending.
> > GFP_NO_RETRY - only try things once.  This may sleep, but will give up
> >             fairly quickly.  Either deadlock is a significant
> >             possibility, or alternate strategy is fairly cheap.
> > GFP_ATOMIC - don't sleep - same as current.
> >=20
> > I don't see how "GFP_KERNEL" fits into that spectrum.  The definition of
> > "this will try really hard, but might fail and we can't really tell you
> > what circumstances it might fail in" isn't fun to work with.
>=20
> The problem is if we set out to change everything from GFP_KERNEL to one of
> the above, it will take many years. So I think it would be better to just
> change the semantics of GFP_KERNEL too.

It took a long time to completely remove the BKL too.  I don't think
this is something we should be afraid of.  We can easily use tools to
remind us about the work that needs doing and the progress being made.

>=20
> If we change it to remove the "too-small to fail" rule, we might suddenly
> introduce crashes in unknown amount of places, so I don't think that's feas=
ible.

I don't think anyone wants that.

>=20
> But if we change it to effectively mean GFP_NOFAIL (for non-costly
> allocations), there should be a manageable number of places to change to a
> variant that allows failure. Also if these places are GFP_KERNEL by mistake
> today, and should in fact allow failure, they would be already causing
> problems today, as the circumstances where too-small-to-fail is violated are
> quite rare (IIRC just being an oom victim, so somewhat close to
> GFP_KILLABLE). So changing GFP_KERNEL to GFP_NOFAIL should be the lowest
> risk (one could argue for GFP_KILLABLE but I'm afraid many places don't
> really handle that as they assume the too-small-to-fail without exceptions
> and are unaware of the oom victim loophole, and failing on any fatal signal
> increases the chances of this happening).

I think many uses of GFP_KERNEL should be changed to GFP_NOFAIL.
But that ISN'T just changing the flag (or the meaning of the flag).  It
also involves removing that code that handles failure.  That is, to me,
a strong argument against redefining GFP_KERNEL to mean GFP_NOFAIL.  We (I)
really do want that error handling code to be removed.  That needs to be
done on a case-by-case basis.

Thanks,
NeilBrown

