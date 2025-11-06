Return-Path: <linux-fsdevel+bounces-67300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA83C3AC67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03D8B34DC8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB802322A21;
	Thu,  6 Nov 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKgdbJuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385A3195F6
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430782; cv=none; b=SnMx7oUjEvUF8dRrp+idgpgOG5uopxVU/dIDdzsX8FpVSPf9lNzEnz9gjhkVP2/w3yODrpLGZgCavvfxTqItPXBeSKt315PpLLK+Wiohn705SGvcCJb/sFTbCCw6tK7ZvRm5EVT3JUKXKLcK107lxTfNJSQ18Shk86OB7CtzxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430782; c=relaxed/simple;
	bh=27NJKWGNcSxXkw/6VX3AWktNtI13IDjnXzjnGtQMSSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsBhaQYlG829dAnNJehS/uTA4NLbgX7xL5kLffVziB9KcMH9pm1BidahukIiR4GnM7+vgtFzyhyShB2HqQ6/kXrZq6j47c5CCuInL/U4vKg5QKoWfhDf8POlTOvyoLgSLQ/V4be4btHtRN7cROxQ6Pvpoiz8GR77lMwRS2aWP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKgdbJuo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1384444a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762430779; x=1763035579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ELMLjwv9zhNxrZy1x+2Ltl6cR1kt6BazqSE2RQWFss=;
        b=WKgdbJuoNNQDzKBC9iU6HH7SUOE4MsFG9t0NU3mOrN4M76EuuKOFCrKS0bJ3TIki9j
         8F0jVgige4VMWzIn8ajMmtlsvI4hGx0hFXoUKjqFUz2/5+oECG1lsFGcPDqsU++yC/c4
         6d2XOKu3KW9mWRUg+2K3ilPcXZXAfVN8nTViofmcj1iK4MKurp5Ik5RPeIanmY+b+62p
         pvLDAa2KKmIjvr8VXnpKyglyC61n+I5/j8+UhxojO6OnLU8XhNSq56QgctoIbcWI5U7t
         Dd8bMRe2uN3FRklp6HdmY1qgsFPQ6X9f3cwscZvYnxpgByslK250CI8RWDm3YNYcIQ8g
         iLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430779; x=1763035579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ELMLjwv9zhNxrZy1x+2Ltl6cR1kt6BazqSE2RQWFss=;
        b=Ggv2OVdmHmAyhCH8nxPhPdmnPFRxJQTj1Xv8Y4OE610ItDyh2EML3BVhfWyJyMuq+p
         R55PpxV0kLspfRwHYM/KuByosFiiXBkT6H9OhmxtVF+Jgf8FT0QYjthSe/d/SL/+j66u
         9hvSEg/zYuKxgV8myc8FLPgVuupnnf4eLJObNrI+ujPHqgRAPovr7UuNYtnq5y2VK7ai
         xgFZmFrnuLneg37N6/zVpeWb1aEu7eE7KS1c9ro1Wy4hfMDrZ1g1gc/iJkZRgnof3cev
         bNfP3eSF/llq4LbLeZn8+4FBIszCUIS45GmLMM6b0qTjlhf94Y6RLzAzoS2UD9AWAC+t
         hsVA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+OFJUJULDEnBl8a8lf9adwho3G5Llcz87jlWoRvtZqZ7k5/OmVB4CE3bBH63SIen5hZap04VJK69z0lU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61wpG35dn+QtjC0cabUx03ZeX8MSwRN1WMAZNlcDm6PjkISr+
	9CSFeio6Ijiu9eTvXENqL5NR3dMjg8XKbDAZ+esoagcpkCF2L1ORZhopwiuow2l1uxIxTsBxPD2
	NtRu7cDUTDaNJRXsScvcauCMiNFfwhiw=
X-Gm-Gg: ASbGncvbbLHAnUAL7taS2LWMGDg28f8n3cx1nn8wNDdW+D50aJ/5BlragcH8qwxXb9w
	YOLuq214Ivo/gS6YpGFR8sftSGQ2PV/bgiNBHPpoy7q+kC0vpdxjhHU19MUJXWqGuMnQS4tBade
	YwVuwlFjf73RUuM4Y08HJPreN97me4iC/BFKHX1XNsJRzlypDXpGMLYD5rEulu0Wlbj1v3zNIBS
	k82iczNuic93TDotuOnC33KDUbL5HrngiWr9a1lrBf5AJKwLTk/zqcmgwfOf7G/TNh/hBtsEjkL
	HuqpaWzlUjdTAT0=
X-Google-Smtp-Source: AGHT+IFewgIeZt0GBhSCLwwbLupiWrk7ObPfoT3K72tH/D6fKqxSroEIndJcH/DS0dGQfAu7B5dcTLDkDIQaeJ4ftQU=
X-Received: by 2002:a05:6402:24cd:b0:640:b044:d9bd with SMTP id
 4fb4d7f45d1cf-64105a688e5mr4890597a12.29.1762430778583; Thu, 06 Nov 2025
 04:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com> <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
In-Reply-To: <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 13:06:06 +0100
X-Gm-Features: AWmQ_blk5OHj6nrJkXypqjpRIzrmgpqDRwEg1cnKOyCQvNKvMvgqeXjYCOYVvS0
Message-ID: <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:14=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Nov 05, 2025 at 09:50:51PM +0100, Mateusz Guzik wrote:
> > For unrelated reasons I disassembled kmem_cache_free and the following
> > goodies popped up:
> > sub    0x18e033f(%rip),%rax        # ffffffff82f944d0 <page_offset_base=
>
> > [..]
> > add    0x18e031d(%rip),%rax        # ffffffff82f944c0 <vmemmap_base>
> > [..]
> > mov    0x2189e19(%rip),%rax        # ffffffff8383e010 <__pi_phys_base>
> >
> > These are definitely worthwhile to get rid of.
>
> Says which semi-respectable benchmark?
>
> If none, why bother?
>

I don't know what are you trying to say here.

Are you protesting the notion that reducing cache footprint of the
memory allocator is a good idea, or perhaps are you claiming these
vars are too problematic to warrant the effort, or something else?

I'll note that contrary to popular belief the Linux kernel is very
much *slow* in terms of single-threaded performance and it is not
about mitigations or hardening measures. There are tidbits of heavy
microoptimization here and there, but that's all paired with massive
perf loss few instructions later -- inlined rep movsq/stosq for small
sizes (gcc is at fault here), lock-prefixed instructions when they can
be avoided, but also cache-cold memory accesses which don't need to be
there and so on.

One great example of slowness is the SLUB allocator with its
cmpxchg16b-using fast paths, but that got recently damage-controlled
with introduction of "shaves". Even then, it still leaves performance
on the table.

I don't know if you consider this semi-respectable or better, but
years back Ingo Molnar created a simple benchmark for i-cache
footprint: https://lkml.org/lkml/2015/5/19/1009

I have been using a modified version of it on and off to optimize
FreeBSD and through systemic removal of tons of avoidable work
(including memory references which did not need to be there) I got to
single-threaded performance beating Linux. It's not that anything
clever is taking place there (in fact there is still plenty of room
for improvement), rather Linux has systemic issues where it loses on
performance when it does not have to.

All that said, will you notice not taking a cache miss in there in the
sea of other cache misses and other slowdows which are currently
present? I don't think so, but it does not invalidate the notion that
they should be eliminated if feasible.

I feel compelled to note runtime-consting of USER_PTR_MAX came in with
no benchmark results (semi-respectable or otherwise) and still
received no pushback despite a bug being uncovered related to it. Per
the above, I think runtime-consting of the thing makes perfect sense
and does not warrant benchmarking. Like I said, I'm not sure what you
were trying to state. If your position is that a benchmark is required
to remove a memory reference from a frequently used codepath, then you
should be protesting USER_PTR_MAX.

