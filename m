Return-Path: <linux-fsdevel+bounces-59425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A7B38954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB4E46490E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472D2D4B44;
	Wed, 27 Aug 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBQLoxoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B84C98;
	Wed, 27 Aug 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318465; cv=none; b=PGvsB+CtXoj2nG9TJxMeD4Bw/zWEXCSZTVk492JsLw/f9ad89ghSI5/xIctXgYHmLPY8GK9kwmNlw6VTJW0dkqxuEH0jCmF7g91GEL2Po7iOxvCMvliN6inzk+YDfmY1UZGoYW3PywJ9wqW4iqC8JQjFJ1rVExex6Teh/Tj7el4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318465; c=relaxed/simple;
	bh=WAFX1IVjxCr6lxN0OWYtqi/fknlG0qVBh37tAs9skCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGYCY1HCgQJAfJlvBqw1wCLdJceLdO+JqZs5TCAp3vn8bMoaXTGl32WUAthPe9wNLHAu91QJpjFbJa4SF4Mx0bxpuF39D8htDyDzRd/wiYuaFdRRAR1jwf726QB7Z/B+ngOokPxHyXyaWo705omcdMMiv0a9+mQ6JIli/iEn3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBQLoxoI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afeba8e759eso11178866b.3;
        Wed, 27 Aug 2025 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756318461; x=1756923261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVQT6EwM2XfyxwdqB5IbpraKmNgOxlOjBUQJepRw89w=;
        b=dBQLoxoI7LA8cdUEDJtn8uCSoe4AQUEZxNDQgHnD2L6w9JA1vpYsuc7Ez94QMp5QMW
         K2ZU0msbb392oY2fZeFrQuRaWmbuchDfp9nRs7qFJ4NfFgG0BuIkMMQ3DRTMiZ/ZBNVD
         yUVNoagh6NAwpgCv7JxEgNlIE2P9WFJcTgFuWDwNA4M0GHcbtRhO+ez1FoxH3A1JWJpb
         GDZcxJBF84hPWy17q3fKhFyPvutmHFTE9iC9hjdkwo0yHwy0IasZg38O00XsEqQJuhsn
         DdpJSSPXUrxA79TpghlJ5tHYmTdGyJsjCrVXGhxQDK9Ucx1GdxuB4weFHUrFLnTvpHwt
         8Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756318461; x=1756923261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVQT6EwM2XfyxwdqB5IbpraKmNgOxlOjBUQJepRw89w=;
        b=jFGeJFSi3BPLNa96LCquQyTVX4XpOTo8VAl3o8QCWuuy43FsL93Fs3ngnKz0A26GWv
         G1rmjUh2ZEKxHcPNrlwlLuudaRrBrEWjZNqooJlUqlQvCVvCJpXI15xV4ORkywsolEaK
         L+V4LeENwU1SFMDZXPNiesS+OLkBPkaSozH0WmsH9R47DwGkkqaDH9VaMs0PeJMdZdYZ
         0wHbpMTT+2ZVpZuOgyfdpQ20CPvNuJS6nM5OuKNcQvIhfdDSI9zgjICq74KsCvhGxxas
         X+y5Yhz5nDHjViBOdyOPVkk0EYSR5tnj9D/MhGeCgCCCzveBvoE3+f2VVuGEsMnHdn32
         ovsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUCxb7HqYaC5GcknD1DhdJbl/FCI1JVEsmS/WbLSMgUjIdEmxUHjWX+5YcSRsCiLVAmWUvIktZv9HhZyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUK5g/sEK7tFHyDK7I0hPhL3VoEVe1FgRlWoRu7V+5SxHmlJa
	Zq7fW50BC1Wx4HUo3fWXAQqmVuzMiovthciKtC2AmEcolzLz5goGDmBpdQ2UnQimHXs6/kW4Cfv
	IiH+Ae7c7YfXcgK2L1dZerTWBYd9sZYI=
X-Gm-Gg: ASbGncu3Dmm9HIqq1S9PvXMHEo+PfS7QLO/AwK/m0UWDIXOWB8Rh+JewSmD00xUlVwA
	LMwSaJVr6oQMJmITYq+kY2z/gGnqI4H+F9PMEyEo5bDqlfqYFnjvmFcio9Mv8Ebzy85D1jQINS7
	i4WyKwGCSkOaNxHa0YSvGJObcgV5eIvbjjsQ6kO8K4kA8xgkgkB0aigii/9IBdbzfXG4rftryGV
	oNDm41ZxspDIrKR
X-Google-Smtp-Source: AGHT+IFcns/i8B7OkrfutKwqMx9ieCSGim1RGlSGQU3kS5KmFwiIYse2MdZm9Vo9wTNfLc3KTlv44vAxDXdIFWh6nL8=
X-Received: by 2002:a17:907:1c84:b0:af9:4fa9:b132 with SMTP id
 a640c23a62f3a-afe29548f36mr1941851366b.33.1756318461278; Wed, 27 Aug 2025
 11:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHHBRhU+XidV9U4osc2Ta4w0Lgi2XiFkYukKQoH45zT6vw@mail.gmail.com>
 <20250826-leinen-villa-02f66f98e13e@brauner>
In-Reply-To: <20250826-leinen-villa-02f66f98e13e@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 27 Aug 2025 20:14:08 +0200
X-Gm-Features: Ac12FXwxmqWdDmYkudS4Qm4tuffTsrkY0hoo-vi10tkGd2D-OiY52PKisY_s1EE
Message-ID: <CAGudoHESh8dKPLHp68G3QFtzqHXpyg1s8kF_GHHN=S8sfOK=Bg@mail.gmail.com>
Subject: Re: Infinite loop in get_file_rcu() in face of a saturated ref count
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:23=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Aug 25, 2025 at 11:43:00PM +0200, Mateusz Guzik wrote:
> > __get_file_rcu() bails early:
> >
> >         if (unlikely(!file_ref_get(&file->f_ref)))
> >                 return ERR_PTR(-EAGAIN);
> >
> > But get_file_rcu():
> >        for (;;) {
> >                 struct file __rcu *file;
> >
> >                 file =3D __get_file_rcu(f);
> >                 if (!IS_ERR(file))
> >                         return file;
> >         }
> >
> > So if this encounters a saturated refcount, the loop with never end.
> >
> > I don't know what makes the most sense to do here and I'm no position
> > to mess with any patches.
> >
> > This is not a serious problem either, so I would put this on the back
> > burner. Just reporting for interested.
>
> That's like past 2^63 - 1 references. Apart from an odd bug is that
> really something to worry about. I mean, we can add a VFS_WARN_ON_ONCE()
> in there of course but specifically handling that in the code doesn't
> seem sensible to me.

I'm not worried about the overflow, I am worried about the indefinite
& unkillable spin.

The only consumer of get_file_rcu() is get_mm_exe_file(), which is
ultimately used to serve out /proc/$pid/exe

Suppose there is a bug where the refcount got botched and and
file_ref_get() now fails.

With the current code the userspace processes who happen to try to
load the value will end up hanging from the user's pov as they will
keep spinning. No reaction to ^C or any other signal.

--
Mateusz Guzik <mjguzik gmail.com>

