Return-Path: <linux-fsdevel+bounces-44407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21326A683CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1393AD05A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B2199235;
	Wed, 19 Mar 2025 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmjlEsir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983C145A18
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355335; cv=none; b=Sy+NWVmUPNtDCSB90MClW4Ln1XbPcORg3o4OjVfHj0fmYjUqCrDKLAI7dyHubqGvBPteBc/NmiDSyBZmIjtA81TnvGaPGu37e6KK8Zgv/ikXWPY6tTqOXG48lJ0azi1BS6GZPlFdMYxQUb/Ex1k0OBMCCI3MhqeERXeHK2kunLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355335; c=relaxed/simple;
	bh=Hci/3CsZb65ypppDc73oxREkEn6yYwNHVBtLzmK0uos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG0H1g74NEIwujm9/3aJPpFSgWC5g6KqCoruiruN2UOOgMO+8cgK52fFUX6wdz+lyxuTPQ8Fj5DzGnqARqS1uBOvv1dA13+fyxfawfA5++AFbjwkHNLnEM4JwePa+Kg1JPx757WEQ4b+hiLL0xtujbrTdBF6WRnL/SOTRI82m+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmjlEsir; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso5978a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742355331; x=1742960131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1eGmQWoQGN9Dkax1HXc1+f2DIdudnDU/1Bx3UVDXHM=;
        b=CmjlEsiruGBUH0buOuZE+HHVLjNfmFwGKcesJcFXX5F38SzrRyBOgcOXwKqeESpkhh
         HbBi7EJUDMpw02G59zaPqx6KpuZwrk1UwGoVeeuQ74uij79dVVpdZiCz4mWWhUmOF/fE
         SZ/wN//oGkWLSSr1XXhIzeG+ppw7CPTPXuLCrR3U4hCx4keV828XnM06rqFhyKe72yIs
         nAo4XUhZAk/0MYvpVpCCeIajc0CHBHYvYXtoMYydmwW4gut3qtKZ6nhDlmE2Sc+xbzls
         r2PfMO9GOSWYuLkpfeeP33AOT+D6NC7mBWuu+XZ8481ljZBvNxqnfwUMEzN87TaBYHO7
         aC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742355331; x=1742960131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1eGmQWoQGN9Dkax1HXc1+f2DIdudnDU/1Bx3UVDXHM=;
        b=G1IYTP5ed+ZRmjc5593mILyFY1PcQ9CFo+DwOKQphySqTavqvjFCKhz6Hmm/PF/7ew
         zcCzcv35wcHD71e/r0Bz2c2gWhzLqsXYtyzdWc3R8B+CIzWKzEQpiwhUrI6JR3jdI6hs
         eM3U2iD4Ki/UBomAV5+r7JdlYgNUvOaxJByBAGdq3WJG2LhnuJtF6t2rRLC5yAXY7bt6
         KOL/kYv9KM1wKrfWVByEgjToQc9DCnRJI45cYDbSBYSyYvdSnRxDwC7OGyXd1pYR4elG
         UgZMtojLDnVGPlU7rGrVPaakhFfaHpGdJPi1P6ce6A/tdOU5zrg6J1WGDZ3v3Uxh8ZQX
         KUqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYZ13zvi7tdwx+7WszoLzu41oK80WKhg0Z4xVZ4HnQ50WGZHTmy6By9EOybuT7eJVHmFAXCd8GruUeMigj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl1908CPUbOiSVrUubKXHzE8fTGIy1pQ/A/gTYV/0gP/hnj86
	Kx2LUBf/p4Tzp/D/Fy/LxBrjn3uMmPZZGQIC6yFnK2OcgHOljbV3Oe8WYwEzvJ068mZwZF6KAxF
	n3Vf773YeBUCiQsqVDlNO5xG7/zc6Sri+DGUK
X-Gm-Gg: ASbGnctp1TjJIIm/ghjTGX2sXimt7Vsc5xY8YBHeXUISpYPrtuvd6P7gVZhICRwyVZ/
	ume32HL1sawQ48Wn9UpWPpPm6tiDxxS6HfY1bGb0oygOi+NwvZ2sroYdH4848fhrfpt+bLdchyZ
	98BI5L1rkuegVZrg7xAdzXXQfB9nqgSuTPkMQEoWNnzriPcyetX59k9iZ5LnudZBcpHQ==
X-Google-Smtp-Source: AGHT+IEt+19WG9IHzZ81Mv9euoAb/rztC5JqY4WZb1WW6DcgrlMezNBnKgRxYmL642WrrToMiGpcBZS+CqAISTXPMYI=
X-Received: by 2002:aa7:c1da:0:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5eb7e96330cmr62254a12.0.1742355330636; Tue, 18 Mar 2025
 20:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318214035.481950-1-pcc@google.com> <20250318214035.481950-2-pcc@google.com>
 <202503181957.55A0E0A@keescook>
In-Reply-To: <202503181957.55A0E0A@keescook>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 18 Mar 2025 20:35:19 -0700
X-Gm-Features: AQ5f1Jq3z05plokQ9oy7A8yZz95pSsT-oxsin3iEVaTMKIK56JFI_UIbnlyp_vI
Message-ID: <CAMn1gO7TG0xXMFNFXTm9W8n4hdit9Yr40m4jvFCjdv9fGiU5iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:06=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 18, 2025 at 02:40:32PM -0700, Peter Collingbourne wrote:
> > The call to read_word_at_a_time() in sized_strscpy() is problematic
> > with MTE because it may trigger a tag check fault when reading
> > across a tag granule (16 bytes) boundary. To make this code
> > MTE compatible, let's start using load_unaligned_zeropad()
> > on architectures where it is available (i.e. architectures that
> > define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
> > takes care of page boundaries as well as tag granule boundaries,
> > also disable the code preventing crossing page boundaries when using
> > load_unaligned_zeropad().
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf=
98ada827fdf755548
> > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > Cc: stable@vger.kernel.org
> > ---
> > v2:
> > - new approach
> >
> >  lib/string.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
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
>
> I would prefer this were written as:
>
> #if !defined(CONFIG_DCACHE_WORD_ACCESS) && \
>     defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>
> Having 2 #ifs makes me think there is some reason for having them
> separable. But the logic here is for a single check.

There is indeed a reason for having two: there's an #else in the
middle (which pertains to CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
only).

>
> >       /*
> >        * If src is unaligned, don't cross a page boundary,
> > @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src=
, size_t count)
> >       /* If src or dest is unaligned, don't do word-at-a-time. */
> >       if (((long) dest | (long) src) & (sizeof(long) - 1))
> >               max =3D 0;
> > +#endif
> >  #endif
>
> (Then no second #endif needed)
>
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
> The rest seems good. Though I do wonder: what happens on a page boundary
> for read_word_at_a_time(), then? We get back zero-filled remainder? Will
> that hide a missing NUL terminator? As in, it's not actually there
> because of the end of the page/granule, but a zero was put in, so now
> it looks like it's been terminated and the exception got eaten? And
> doesn't this hide MTE faults since we can't differentiate "overran MTE
> tag" from "overran granule while over-reading"?

Correct. The behavior I implemented seems good enough for now IMO (and
at least good enough for backports). If we did want to detect this
case, we would need an alternative to "load_unaligned_zeropad" that
would do something other than fill the unreadable bytes with zeros in
the fault handler. For example, it could fill them with all-ones. That
would prevent the loop from being terminated by the tag check fault,
and we would proceed to the next granule, take another tag check fault
which would recur in the fault handler and cause the bug to be
detected.

Peter

