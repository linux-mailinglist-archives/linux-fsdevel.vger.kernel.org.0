Return-Path: <linux-fsdevel+bounces-36232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8E9DFF68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47198B23CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62C1FCFC2;
	Mon,  2 Dec 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="E5uGDr9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C81FC0EB;
	Mon,  2 Dec 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136614; cv=none; b=AeowuT7iCIIJhYE/9LjKTxQDLPk8kwJhiOW2tKbcy2zXEbTWwKo+GrZfbGN87jjUlWebqV3//xTVGj610UrtSlt2dnr0emYq3ZIoqSZgOTUYc2rOhNg8UdzZPgK6y8HLiMM6LfjVqFZ103pnjQYfhtPH4qwU38+qPIU3r6yJzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136614; c=relaxed/simple;
	bh=nWj9kVjFkA/uzz5o+psqx7pHEdWGVkcXfYTvTuBT39A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rthC+TutTRxIMJHm32ThbmjWfk/e1Tk6ycR/aVgGnruJb2zi4h6aXXLSI/czKig+f257hY03av3ic++30Hz5JyKegyjXq0RVB2cexYP4/4sFWO8bD9ANylj+FSTTbYa/xgkhcdCBsVH32Dhmx3KeHavetjzVtHxdUdoFzVe8WAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=E5uGDr9f; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1733136274;
	bh=yq8INn4zbqzqDhdWCGdL8z+1i1zAqXBLUq6KmP1JVYM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=E5uGDr9fYjfHo3lHmuz4fFFchfOz5KOxDw6oDLr7hssldy12vEJyZFgxGPbEZbkPr
	 rboK6KdiyWavWJFdNZUq5qKRp3TXNLjF1TyCLrRw3Kj0FM6HwjXYvmoNJnqNjUIgnu
	 huitjDunqC3Gf6IedTFVl+G2Z1QugCGmMdfHh7z8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <CAHk-=wjty_0NfiZn2HVzT0Ye-RR09+Rqbd1azwJLOTJrX+V5MQ@mail.gmail.com>
Date: Mon, 2 Dec 2024 11:44:11 +0100
Cc: Chris Mason <clm@meta.com>,
 Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>,
 regressions@lists.linux.dev,
 regressions@leemhuis.info
Content-Transfer-Encoding: quoted-printable
Message-Id: <48D7686C-6BD4-4439-B7FD-411530802161@flyingcircus.io>
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
 <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
 <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>
 <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
 <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
 <CAHk-=wjty_0NfiZn2HVzT0Ye-RR09+Rqbd1azwJLOTJrX+V5MQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>

Hi,

waking this thread up again: we=E2=80=99ve been running the original fix =
on top of 6.11 for roughly 8 weeks now and have not had a single =
occurence of this. I=E2=80=99d be willing to call this as fixed.=20

@Linus: we didn=E2=80=99t specify an actual deadline, but I guess 8 week =
without any hit is good enough?

My plan would be to migrate our fleet to 6.6 now. AFAICT the relevant =
patch series is the one in
https://lore.kernel.org/all/20240415171857.19244-4-ryncsn@gmail.com/T/#u =
and was released in 6.6.54.

I=E2=80=99d like to revive the discussion on the second issue, though, =
as it ended with Linus=E2=80=99 last post
and I couldn=E2=80=99t find whether this may have been followed up =
elsewhere or still needs to be worked on?

Christian

> On 12. Oct 2024, at 19:01, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Fri, 11 Oct 2024 at 06:06, Chris Mason <clm@meta.com> wrote:
>>=20
>> - Linus's starvation observation.  It doesn't feel like there's =
enough
>> load to cause this, especially given us sitting in truncate, where it
>> should be pretty unlikely to have multiple procs banging on the page =
in
>> question.
>=20
> Yeah, I think the starvation can only possibly happen in
> fdatasync-like paths where it's waiting for existing writeback without
> holding the page lock. And while Christian has had those backtraces
> too, the truncate path is not one of them.
>=20
> That said, just because I wanted to see how nasty it is, I looked into
> changing the rules for folio_wake_bit().
>=20
> Christian, just to clarify, this is not for  you to test - this is
> very experimental - but maybe Willy has comments on it.
>=20
> Because it *might* be possible to do something like the attached,
> where we do the page flags changes atomically but without any locks if
> there are no waiters, but if there is a waiter on the page, we always
> clear the page flag bit atomically under the waitqueue lock as we wake
> up the waiter.
>=20
> I changed the name (and the return value) of the
> folio_xor_flags_has_waiters() function to just not have any
> possibility of semantic mixup, but basically instead of doing the xor
> atomically and unconditionally (and returning whether we had waiters),
> it now does it conditionally only if we do *not* have waiters, and
> returns true if successful.
>=20
> And if there were waiters, it moves the flag clearing into the wakeup =
function.
>=20
> That in turn means that the "while whiteback" loop can go back to be
> just a non-looping "if writeback", and folio_wait_writeback() can't
> get into any starvation with new writebacks always showing up.
>=20
> The reason I say it *might* be possible to do something like this is
> that it changes __folio_end_writeback() to no longer necessarily clear
> the writeback bit under the XA lock. If there are waiters, we'll clear
> it later (after releasing the lock) in the caller.
>=20
> Willy? What do you think? Clearly this now makes PG_writeback not
> synchronized with the PAGECACHE_TAG_WRITEBACK tag, but the reason I
> think it might be ok is that the code that *sets* the PG_writeback bit
> in __folio_start_writeback() only ever starts with a page that isn't
> under writeback, and has a
>=20
>        VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
>=20
> at the top of the function even outside the XA lock. So I don't think
> these *need* to be synchronized under the XA lock, and I think the
> folio flag wakeup atomicity might be more important than the XA
> writeback tag vs folio writeback bit.
>=20
> But I'm not going to really argue for this patch at all - I wanted to
> look at how bad it was, I wrote it, I'm actually running it on my
> machine now and it didn't *immediately* blow up in my face, so it
> *may* work just fine.
>=20
> The patch is fairly simple, and apart from the XA tagging issue is
> seems very straightforward. I'm just not sure it's worth synchronizing
> one part just to at the same time de-synchronize another..
>=20
>                   Linus
> <0001-Test-atomic-folio-bit-waiting.patch>

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


