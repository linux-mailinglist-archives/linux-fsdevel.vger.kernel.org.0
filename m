Return-Path: <linux-fsdevel+bounces-24235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBC93BEDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 11:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B391F21246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBCC197521;
	Thu, 25 Jul 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAUIdSjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB481E;
	Thu, 25 Jul 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898948; cv=none; b=BC/GomjfyCchbzcrg+fGh6HQGEvsfGJBbI8XD7J+Pj90+rBWbaVf0ichqqrXZxyyujlf4DBSsL0mLVHjQn3hyHIPb69MgTJwmsgD4Gdoyfy0srbxdElsrFXwtdKndeCRd1IGB9zqhzugYxY5ikhr9MyWX51ap0jzJYq2T5CmuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898948; c=relaxed/simple;
	bh=OcwgtfgPw0hhdhtKtHhoQsMyS9KzBLMScSWx7P0e2cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laOP2VNMVMOXZA+jEDTyZ67TCEmX+EpUhnSv8RVNTsFmOg/Ow8HwndqxaIFoCmFPuMiJoTZw2a0w2BUIf7X1bRftgjo+39H4trp8IllNTNjkNmI6ZoBmEzY919v5gmVylx4sqTUGJOt9KaIhkLN2DsPk3nsEyc+VaJgGvehHa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAUIdSjF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so942869a12.0;
        Thu, 25 Jul 2024 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721898945; x=1722503745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysBx5Z51EpiZcBKUWEbzyyIn2+Nt7E1e5BC6UDT7EQE=;
        b=XAUIdSjFFoUFoYSvFiO24+hIwLYFo1hvbSbHT8wXlTmAxH+mOb32i2SdLfd1wAUEJW
         EOFvJNCa2nCXRVmFzLALNxnnLSREs78CXay8fh3DOIKRkxTTrIH8qGBr0a3MazA03M5y
         mKtwkfipMuGF6cuat8wI2Lrn2gFb4azlwc25Wv8sE7UibTVCEdqY+FaocGx5Z1IKGjiO
         ao2y+26mMma12qR/eKIdwJXRfMte+r8595XjYM/xNv5YZqqekNierStb9sZN6ZNBhGiT
         T6aLMDzMFCqdlbMywMqdyrrD7UW/h91P99vlgkmEhOtYOTzfrA3zHR08YN5NYljvREZV
         QGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898945; x=1722503745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysBx5Z51EpiZcBKUWEbzyyIn2+Nt7E1e5BC6UDT7EQE=;
        b=mbKiVOc5uXgzqHqE2oP5HSBqdEYkpJA+CQ38qZsMZR85ooelmY+FoOKFW6jOn2dZ3O
         t/CWSxGCDqGsTOyVkJRxSGCc04h4gINf7ltGqSUOFcfQfvyVK6DqjzaWrA3/DXW7sQts
         HRgbhmYdxM6mCm8Dt9sd1mJrjqfbe0kBUgsjHtbYXdlLGg35wgpAyzPzbV5xmmSVcoR/
         oQGz9x8jzJ8brmfjoiYy8fl4+N2f5eVWgYAYJlAF3EeCEPjgitC42ujcEF2hUdXHt482
         zOGSsNbTQG8RuMyH+KQcjjOP451L3jyNJw/YJvgYM2ic+eZhKdkstY1xCZD/MwgE87lT
         zTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOzGJbjHspFnYUMPQy/82ehSRqKSCUrQ06nVXNx4xSL/xuA8ovr6h+vIAZ8OtI9VFoer9ET41wYsg9e0S6kw/lEEYWhBNWBtFMAFvbk+/aezvGjROES9k5Wc/g5Dh7L8fsn7Rf+pn7sa7O/7uPXilzAKyVADzYeSRrFXr64yMq0ywk1ea3hhxBIw==
X-Gm-Message-State: AOJu0Yzc7h7TPUmUND/Sf6j3oWMSPMtORqrMT0Os4mNj1uTBRFrOHiC1
	IDTj/64/kGLBe+/HGKoaAnTTZYcPuidt+6VCgT/XGB7jfk8DrakVpqD1u//WvwYzXsafu7XRAtq
	P+LFTTKhDVA1Y/3yLhS/3H9wcj+M=
X-Google-Smtp-Source: AGHT+IGhAa6wCja7qg4dQ0/wwMduOr4UN/fm29G/e5fxGtFKB4d6+ysR2xYbfM2QDED6KN/IpGrm/XlhsbvHP2bcUcs=
X-Received: by 2002:a50:f68d:0:b0:5a2:8bef:c370 with SMTP id
 4fb4d7f45d1cf-5ac6261dc83mr996668a12.15.1721898945272; Thu, 25 Jul 2024
 02:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725075830.63585-1-sunjunchao2870@gmail.com> <20240725085156.dezpnf44cilt46su@quack3>
In-Reply-To: <20240725085156.dezpnf44cilt46su@quack3>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Thu, 25 Jul 2024 05:15:34 -0400
Message-ID: <CAHB1NagCqP4k9XvmAoyZ8NaRb0Y-bT1unnnOsmnt-mE6_k=8Rg@mail.gmail.com>
Subject: Re: [PATCH] scripts: reduce false positives in the macro_checker script.
To: Jan Kara <jack@suse.cz>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, masahiroy@kernel.org, 
	akpm@linux-foundation.org, n.schier@avm.de, ojeda@kernel.org, 
	djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=
=A8=E5=9B=9B 04:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu 25-07-24 03:58:30, Julian Sun wrote:
> > Reduce false positives in the macro_checker
> > in the following scenarios:
> >   1. Conditional compilation
> >   2. Macro definitions with only a single character
> >   3. Macro definitions as (0) and (1)
> >
> > Before this patch:
> >       sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> >       99
> >
> > After this patch:
> >       sjc@sjc:linux$ ./scripts/macro_checker.py  fs | wc -l
> >       11
> >
> > Most of the current warnings are valid now.
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ...
> >  def file_check_macro(file_path, report):
> > +    # number of conditional compiling
> > +    cond_compile =3D 0
> >      # only check .c and .h file
> >      if not file_path.endswith(".c") and not file_path.endswith(".h"):
> >          return
> > @@ -57,7 +72,14 @@ def file_check_macro(file_path, report):
> >          while True:
> >              line =3D f.readline()
> >              if not line:
> > -                return
> > +                break
> > +            line =3D line.strip()
> > +            if line.startswith(cond_compile_mark):
> > +                cond_compile +=3D 1
> > +                continue
> > +            if line.startswith(cond_compile_end):
> > +                cond_compile -=3D 1
> > +                continue
> >
> >              macro =3D re.match(macro_pattern, line)
> >              if macro:
> > @@ -67,6 +89,11 @@ def file_check_macro(file_path, report):
> >                      macro =3D macro.strip()
> >                      macro +=3D f.readline()
> >                      macro =3D macro_strip(macro)
> > +                if file_path.endswith(".c")  and cond_compile !=3D 0:
> > +                    continue
> > +                # 1 is for #ifdef xxx at the beginning of the header f=
ile
> > +                if file_path.endswith(".h") and cond_compile !=3D 1:
> > +                    continue
> >                  check_macro(macro, report)
> >
> >  def get_correct_macros(path):
>
>
> > So I don't think this is right. As far as I understand this skips any m=
acros
> > that are conditionally defined? Why? There is a lot of them and checkin=
g
> > them is beneficial... The patterns you have added should be dealing wit=
h
> > most of the conditional defines anyway.
Yes, this skips all checks for conditional macro. This is because I
observed that almost all false positives come from conditional
compilation. Testing showed that skipping them does not cause the
genuine warnings to disappear.
Also as you said, it may still lead to skipping checks for genuinely
problematic macro definitions. Perhaps we could provide an option that
allows users to control whether or not to check macros under
conditional compilation?
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

