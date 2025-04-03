Return-Path: <linux-fsdevel+bounces-45581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F15A79940
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2CA3B3543
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88902881E;
	Thu,  3 Apr 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ILhueHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7A5339D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638947; cv=none; b=SmCRHBy0c9ylzcZUksbZAaHci1U0axK+D0JPrFjKhai/Pn0vhVQF1kLsstc9d5Fj0dH6k3uY8syaLLBfZTkxJ+FWrfesghboJVBdZ4r1LoOM9zRit+IXRxDLFlt1EFsd9O56vMgg++O3rtEcnhIgmCbGd6kSbfgQDPwrbD49rNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638947; c=relaxed/simple;
	bh=/FLcwFiUacRZ99g9AZh4T4RkZZ1ldX11E+A+YbEiRa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drdqCbldsf4Zz9E9+dxfcuiIz5wmMNbY8vB3kZmIgcbNgzkY6cPVzQHWb23M7+/KD0Qsc7OYizO++03OSsfudKgdeYJsJcB/BZgeUFdA8HpMbNX2Ccv4q9uY3Ibc7KxTZgnXYGzlxx7+eM1iNbtvFFDvtZTmBPUKBKmz6bFb6wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ILhueHE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242ac37caeso245435ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743638943; x=1744243743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljcbpuZJwXDAqPnol/jqn4PauxJjKGDyJjaPa56FKYI=;
        b=3ILhueHEZ3VtMwRqOfxB4jzQ8GuxKNmcilXGWDh60QV+QUmGdEUP4t7KJwG/mIBe1H
         mlyDH2mZ1Mfiq3plo9/G+ykk5uCG5a0FyhG4sjE5B3Pso3kPsur3/nLcM3j4dt0U7pFz
         IvwmLUsarJzMrDCrXbcBqBjYIJW/k20DXiIGZqInAPUuFzMkjVAbkITUvbgWqdZzHzl/
         e1Y74T6iSPQjHdULYNHf5+bVTT1vws2Nqk+zhqIfpPe94O+mYQijHPOEvPePHDTR4xvm
         elTdv6iWP5TaVcuJ/GQtILl+JJP2/eOGfqMY+d6kX0+iEMkDzblYM4hQtKyAT9qTf0de
         6yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638943; x=1744243743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljcbpuZJwXDAqPnol/jqn4PauxJjKGDyJjaPa56FKYI=;
        b=crCVA8+tigcbcgfIzoY170lOrY4R/o3xPrMdATF5GSbI0yQJ2IrVA/inHfkIMPS9bp
         6GXwdXiVDjvC7xSmPz8tW86FBUrSsM9K3lm75SpiuwyaBtccK39Vw3LjJwgEeSE7m8Aa
         ti4kT03aUSNIxk1wR5XDGx9yPD9bIZJRiTJIuCIQZ7UNRxDbZLWg817uPml6ogxjeR/8
         vQVlKJ0N5Bz3259n3AK2/ssMg6eKs0gf/wWyenKo3svuyP9wxS6F/WvLEKMVrfyHbQdf
         9rzRMsicti4SaA4V7foocieW0B6FvZGk1tx5Q/fzpCAx3KrBSkKzqii/DVKSPkL3K2SP
         WZig==
X-Forwarded-Encrypted: i=1; AJvYcCVAOt/j7/kc6kuYnAuEQA8DUfDofxV2TG0hLMCrt09shlPknNwY38VhAqu4XbcHYGHyHr6T6TFM64cAydft@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtPSejGGLVQRjVXojEoy38n0OBGDzGII96SynfS53G6F3YxF5
	OocOnOIve95MHEJnC71fgblVWo3YI/44xRtx3G8LyT9QRhZ9XZn8pUSF+fCLx5sNTGAi4gUoG4S
	qeuqSoQ+H4nn1PLMHnG2nSkKw61k1nd3jbZWG
X-Gm-Gg: ASbGnctQ6UEpHdxGheVVS+ZB3N38Lq1BRBgtlzGFiPx8UyJ0H9cmcYRYb4QsuRiZPMR
	qG/m6U8WeccM/Tk1CHP/aWnI9WdDs1YMcFSieC3MaoeLd8yueZCpCjZDEIgdAjzw6jxXpUcYfas
	lQfeQXMDhi/xaJZe7boLmxN2kt4m5z4IsEYDDJQeek4mTouo0HC7OSnvYv
X-Google-Smtp-Source: AGHT+IHutOHO69SHU0XC60NdDFG2HVTZqKjKhFOA2HECg4WHds9ohBB1sYtL21Jdh2GqT2tdCyHjyFFTpGz4e0i31ds=
X-Received: by 2002:a17:903:440b:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22978359fcemr754035ad.19.1743638943220; Wed, 02 Apr 2025
 17:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329000338.1031289-1-pcc@google.com> <20250329000338.1031289-2-pcc@google.com>
 <Z-2ZwThH-7rkQW86@arm.com>
In-Reply-To: <Z-2ZwThH-7rkQW86@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 2 Apr 2025 17:08:51 -0700
X-Gm-Features: AQ5f1Jrfy-UpUdfn1d71XnyyKzDPZn2N3LIuWaGJ42FoAiNjcFlKYw9ZKliguAY
Message-ID: <CAMn1gO55tC78BpD+KuFgygg1Of57pr16O4BvKsUsrpo830-jEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:10=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Fri, Mar 28, 2025 at 05:03:36PM -0700, Peter Collingbourne wrote:
> > diff --git a/lib/string.c b/lib/string.c
> > index eb4486ed40d25..b632c71df1a50 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, =
size_t count)
> >       if (count =3D=3D 0 || WARN_ON_ONCE(count > INT_MAX))
> >               return -E2BIG;
> >
> > +#ifndef CONFIG_DCACHE_WORD_ACCESS
> >  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >       /*
> >        * If src is unaligned, don't cross a page boundary,
> > @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src=
, size_t count)
> >       /* If src or dest is unaligned, don't do word-at-a-time. */
> >       if (((long) dest | (long) src) & (sizeof(long) - 1))
> >               max =3D 0;
> > +#endif
> >  #endif
> >
> >       /*
> > -      * read_word_at_a_time() below may read uninitialized bytes after=
 the
> > -      * trailing zero and use them in comparisons. Disable this optimi=
zation
> > -      * under KMSAN to prevent false positive reports.
> > +      * load_unaligned_zeropad() or read_word_at_a_time() below may re=
ad
> > +      * uninitialized bytes after the trailing zero and use them in
> > +      * comparisons. Disable this optimization under KMSAN to prevent
> > +      * false positive reports.
> >        */
> >       if (IS_ENABLED(CONFIG_KMSAN))
> >               max =3D 0;
> > @@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src,=
 size_t count)
> >       while (max >=3D sizeof(unsigned long)) {
> >               unsigned long c, data;
> >
> > +#ifdef CONFIG_DCACHE_WORD_ACCESS
> > +             c =3D load_unaligned_zeropad(src+res);
> > +#else
> >               c =3D read_word_at_a_time(src+res);
> > +#endif
> >               if (has_zero(c, &data, &constants)) {
> >                       data =3D prep_zero_mask(c, data, &constants);
> >                       data =3D create_zero_mask(data);
>
> Kees mentioned the scenario where this crosses the page boundary and we
> pad the source with zeros. It's probably fine but there are 70+ cases
> where the strscpy() return value is checked, I only looked at a couple.

The return value is the same with/without the patch, it's the number
of bytes copied before the null terminator (i.e. not including the
extra nulls now written).

> Could we at least preserve the behaviour with regards to page boundaries
> and keep the existing 'max' limiting logic? If I read the code
> correctly, a fall back to reading one byte at a time from an unmapped
> page would panic. We also get this behaviour if src[0] is reading from
> an invalid address, though for arm64 the panic would be in
> ex_handler_load_unaligned_zeropad() when count >=3D 8.

So do you think that the code should continue to panic if the source
string is unterminated because of a page boundary? I don't have a
strong opinion but maybe that's something that we should only do if
some error checking option is turned on?

> Reading across tag granule (but not across page boundary) and causing a
> tag check fault would result in padding but we can live with this and
> only architectures that do MTE-style tag checking would get the new
> behaviour.

By "padding" do you mean the extra (up to sizeof(unsigned long)) nulls
now written to the destination? It seems unlikely that code would
deliberately depend on the nulls not being written, the number of
nulls written is not part of the documented interface contract and
will vary right now depending on how close the source string is to a
page boundary. If code is accidentally depending on nulls not being
written, that's almost certainly a bug anyway (because of the page
boundary thing) and we should fix it if discovered by this change.

> What I haven't checked is whether a tag check fault in
> ex_handler_load_unaligned_zeropad() would confuse the KASAN logic for
> MTE (it would be a second tag check fault while processing the first).
> At a quick look, it seems ok but it might be worth checking.

Yes, that works, and I added a test case for that in v5. The stack
trace looks like this:

[   21.969736] Call trace:
[   21.969739]  show_stack+0x18/0x24 (C)
[   21.969756]  __dump_stack+0x28/0x38
[   21.969764]  dump_stack_lvl+0x54/0x6c
[   21.969770]  print_address_description+0x7c/0x274
[   21.969780]  print_report+0x90/0xe8
[   21.969789]  kasan_report+0xf0/0x150
[   21.969799]  __do_kernel_fault+0x5c/0x1cc
[   21.969808]  do_bad_area+0x30/0xec
[   21.969816]  do_tag_check_fault+0x20/0x30
[   21.969824]  do_mem_abort+0x3c/0x8c
[   21.969832]  el1_abort+0x3c/0x5c
[   21.969840]  el1h_64_sync_handler+0x50/0xcc
[   21.969847]  el1h_64_sync+0x6c/0x70
[   21.969854]  fixup_exception+0xb0/0xe4 (P)
[   21.969865]  __do_kernel_fault+0x80/0x1cc
[   21.969873]  do_bad_area+0x30/0xec
[   21.969881]  do_tag_check_fault+0x20/0x30
[   21.969889]  do_mem_abort+0x3c/0x8c
[   21.969896]  el1_abort+0x3c/0x5c
[   21.969905]  el1h_64_sync_handler+0x50/0xcc
[   21.969912]  el1h_64_sync+0x6c/0x70
[   21.969917]  sized_strscpy+0x30/0x114 (P)
[   21.969929]  kunit_try_run_case+0x64/0x160
[   21.969939]  kunit_generic_run_threadfn_adapter+0x28/0x4c
[   21.969950]  kthread+0x1c4/0x208
[   21.969956]  ret_from_fork+0x10/0x20

Peter

