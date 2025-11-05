Return-Path: <linux-fsdevel+bounces-67201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A38C37C8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 21:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD45434F51B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A12D640A;
	Wed,  5 Nov 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9jcCS3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889417993
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375867; cv=none; b=jvvBmdmw1RiY9C1jtAnemI9BpT7q2xU8+Udd29Ie4e/qaIFmi1qwLlbpfXgvgvYI+MDUYWbtT31x5XUEpeivabHpowaooqP1t30bGhVYsZ7kv+LP1YOlGb7BOgL631o8Owp4AuugW2MASkmkVzlbzDloMhh+BFS7EfDsuMBLZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375867; c=relaxed/simple;
	bh=or+4VKsHWRz5VD4h84eLNF/hLmxWmAARGHAlbsRpyTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czxQqWmfrJd/2V3vbUZVb8hv2y/Aot4DdwxEowQCJyNkfxIOVx+HxvG/2iRkN2Hyvss7rgztdL/PWMvQQtknSnFCcIyMkQOxK3itKpMFcS3fCabWlPu6rbXJhk6q+HeggL1OcAz5aEITFkFYcC/liJl/oE2DR7WMzOdGTer1Wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9jcCS3r; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b726997b121so179282566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762375863; x=1762980663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM5fqfy1/WRWSedgbxiLr9vaV/x8JCAAOVl/pGWJOkE=;
        b=b9jcCS3r1AG9LsLtqvnBSide19n8pIMSixPxbKsgcuvZTiwUmut6qpsi8g4X5WjU5p
         r5rPqNT9f/BOM8WOVVl9UpizxneUOS5KGIDb6WLmNN6v7b5JchtxJazlHTOIZp8xo5pf
         dN+LOTe33iKvouEOOEa5CgwpI4enTOkDtZslGlg3GmUvSjn+fo5h9R3X3zWVKvDTf4YX
         Co42dautnqkX9DnBjDARM+3YmmK2ArGQ+v3I4vreSQtmaVcYP8cTjsz1i28fZGKP8Hjg
         ZGbGWo2wlJyqEr3B6KhOmWfzAQ0BITIwpcWnA/3sbxkgRljZ6QT7KhJ0BPtxxdPH3/pa
         oIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762375863; x=1762980663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jM5fqfy1/WRWSedgbxiLr9vaV/x8JCAAOVl/pGWJOkE=;
        b=FtfIKuKoH1T0q05imgQZ0FCWybiLvi2zhokmpt78QEueMK0CehGXFpCqsDBVdTv21c
         Pi8kGGrEchTrBtoMAL5W0oLtML3kwB+QjoKT+JACqEoRs2OdIxfOVh8eXPnnQvvtmKAT
         P5RHOKCzGY8oczdsikQle7yq7W6AEBeFZuWR8L9M3UkRiIW6GgvnFrb8pdelehQqhjkz
         OVNxbUX3dq8GZ4dnAIM3Wq+7TUsr46uVH9sChKfONpjmAhl9XVTjDLy6l+zFz/Iy9tTO
         ieDftaLT2OSZkK4LxdIm2aULTmh+JMVQaGAyplP7zqUcJnoxI46a6O3bBqlMw2JPDieI
         k3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV7X4Fz1ADlV2D3nZpzoB/xSmL9+2d/8q8+Hi8OQFjySxQ2+7eLI8r7Akl5JGfuyRFw6p4+/Lc9RvAatVfw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Tso3h1g0vapRG0bxmdfe8K1aeVFeYZkd7HK0Mz8bCsxB+Z+q
	8rlVwKmtN4Q0Xiz4k0qgzq8UUK6KfG4yFmmLu1N+8xystNMzICcIkUYPDbcYvtxOqil4Nqg2s/0
	jaSTu22i/OXV1yJbPQSxypfC0c1FnVN4=
X-Gm-Gg: ASbGnctJfVbCpNZLSnjGRdGTZ2LGJdH8ZBVVZWiqUlL/uaPnwnhsEstl6XHjtuxGf7/
	jat7bSo4Ufo30JZHIdt4OnyfdUFtyZsyU8RDV7QlTWloZSyJfbGrp93c0q6F54txK2fpcv9jFYD
	+gToyHkba7J21o7dZodUohwsj6CdqfJAi2garJmux7l4uBV/ocYYxwd16yJBDm/lIsbnP0JWibM
	IP72z+fWUCDFPuRPkuhNdmAhsof2s+s/P+or+dFXEYIbg2MENYW0Ju8ToRpYeY9nKYZqAp3qkRH
	djVzBsnp7aaacu++68CdAZ729w==
X-Google-Smtp-Source: AGHT+IGbEybLUi0HR5DL1r383IrFZ4SyhLhd7epb/QCwDEz1eFkdDLiBYkJx24FvVTqVW7pOioiZvLEz9kDEXou/oCk=
X-Received: by 2002:a17:907:970a:b0:b53:f93f:bf59 with SMTP id
 a640c23a62f3a-b7289645bddmr73728566b.29.1762375863097; Wed, 05 Nov 2025
 12:51:03 -0800 (PST)
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
In-Reply-To: <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Nov 2025 21:50:51 +0100
X-Gm-Features: AWmQ_blU8I8VpOvett216i1zUPJ3yG5Sefg95R4GpAd3IgrBUODhYcE_oXu4WkU
Message-ID: <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:14=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, Nov 04, 2025 at 11:25:44AM +0100, Borislav Petkov wrote:
> > On Tue, Nov 04, 2025 at 03:25:20PM +0900, Linus Torvalds wrote:
> > > Borislav - comments?
> >
> > LGTM at a quick glance but lemme take it for a spin around the hw jungl=
e here
> > later and give it a more thorough look, once I've put out all the daily
> > fires...
>
> Did a deeper look, did randbuilds, boots fine on a couple of machines, so=
 all
> good AFAIIC.
>
> I sincerely hope that helps.
>

Derailing the thread from the previous derailment with the following:

For unrelated reasons I disassembled kmem_cache_free and the following
goodies popped up:
sub    0x18e033f(%rip),%rax        # ffffffff82f944d0 <page_offset_base>
[..]
add    0x18e031d(%rip),%rax        # ffffffff82f944c0 <vmemmap_base>
[..]
mov    0x2189e19(%rip),%rax        # ffffffff8383e010 <__pi_phys_base>

These are definitely worthwhile to get rid of.

I'm just worried that given their low level nature they may happen to
be used before the runtime machinery is done patching and for now
can't be bothered to test that.

Worst case separate helpers could be added which are only legally used
after the patching and select cases like the above can get converted
to do it. Again not looking into it myself.

But perhaps someone would be interested? ;)

I'm responding to this e-mail since this would require some testing on
a bunch of uarchs most likely, especially with LA57.

