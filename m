Return-Path: <linux-fsdevel+bounces-73320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C7D158B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B4D302D5D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35E28466F;
	Mon, 12 Jan 2026 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qLLqk0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B62749CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256312; cv=pass; b=nF4qm5WtPk6zWX/5LQksMcPWguDu6UcKM+crDsmgMMqapLWrNSMwOcdQEAdnOsbraxaPZGLJ2oKlfOBj+uCw7H9BS0OCS592iml4X5gwU0FfiddFThbOi8omb8jYWNlQLDD0Vs+7xsAiGD6O0Awc90jIgAlgQ+ldREMLEAqIEq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256312; c=relaxed/simple;
	bh=s2faJVeXwOJzRSusfeu8mBj4+CZbPROWwKb0cmB2nuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jddq7tsPW589+VYQtoN23TIBuSDyiKf6A30flt5I2O7MgTHEC5vT6Tp6rhBj14WUlTlwegvm0laQ6EgUnl5OEl9xOFqBMpNFuxiKWeXP1TQJlLtfMSmysquSX2KSxG48GNEZ+v2bwOb/FgH9XsELY18m5XCkfODM/s6YUKoIKSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qLLqk0O; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edb8d6e98aso108401cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768256310; cv=none;
        d=google.com; s=arc-20240605;
        b=AfAPHmiXYbU6lhUJItxG3tiK5HehJy6BHWdVCUBZqWQbU8Ar2j9yNYF4/gcRipXy9A
         uhVhAYtDkMWg/1yX+Vq8H4+/SS9ncii2ZS3NkBhZZPQdBIT/FGOuklfYV/v/geOAZUKW
         +EnkEx6jmoskGHVFQ3eGdq8EPe/oCxNOHHPvJI2bBlsEEKqJUDmbNUhbdBZRuZ63z2tT
         w/VtRfH9sbME7U5P2A/i2o4fJETHON7NWvg/hd4ABg7bZUuRYOEDhGuxO5JRF9X4UK13
         mhZ2gm8ryrYZEDSOEFr2dzfmhfhhzZdzOMiZz6aLtc3aEBUGoAANQpopvZeAjD+Vqym7
         0+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqx6ovJNZlQMxRNZ6xtrUrvyplQ/Aq0eWptvKJzLwh4=;
        fh=KdwyYQUcp3fBpC41v1OyhtcsD2Fz6I6HQgDsQmEZvnc=;
        b=avAVCR6RNMW/LKUiUzQrj3XohOGx26pbt33eQ8fiQFnFYHLHyygvxsq5Ea0ORkOM/g
         O/DeIpCZpUHnpjTrrj8SrkqfnhzAbR5c0ecSx6g9Ay08ARZKl3ZdqPoAkuvo6rj6aU9f
         QbjVqogAzkV1hVRK3IUETh+eQji/BstEgEo/0E+xKFq+aSUOlXqYgnVisoyoaNYzeWuW
         eGqXQv7X+2PJ7I0Pew4L7CZWfMA3lHTXyfavaKcAjAeXj9QXIsXrwN03LyiSFlwOymKX
         y5v0ag8QXJ50GklRZObUvH4KerOQlQ2K5ePAu/9LaZ6T6DV1Ctiky2kjK+Ho/5noElga
         5IHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768256310; x=1768861110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqx6ovJNZlQMxRNZ6xtrUrvyplQ/Aq0eWptvKJzLwh4=;
        b=2qLLqk0O+DHYl2h8V+5QBQEF/uz7wO38wCD8kBLYXkxlNIMvxOz3pTL0FGHu2VSrKw
         427SNiCP0anLsA4kQw/yhISJv7VorcfTApM0OsMNma+w/0O9GvubLgmQrOzcpK8GbfWm
         jL5I9ObvzyhH2Ji+Fde0bIz2ZXDC/kRam4IWCHcUWgZnyh2lH/XRckRUJpbqjvcFF2pN
         WaYTNLIKbjLyJbvkP4KUpwHc12ssgaefNXPZbf8ZZgNytM0Pi6CuCIbQk+KsEj5gt/3s
         14/4M/NAO0z6suPM0UxgZTUnU2uJrboCxF497FGKyYtLPVu4xXtia2wCCa83tvQp0c8d
         SQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768256310; x=1768861110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqx6ovJNZlQMxRNZ6xtrUrvyplQ/Aq0eWptvKJzLwh4=;
        b=Vnznl9LSQhHiMfop4Fxy0Ulyi4VSgZ6u16zTeyfcPWHOa8LPhlIgAkCjhCHX98IG4P
         WCNnlzYhMSzjPbiQAg/8/7Kc+yO+3y0QLikZG4EFbQCjCfxUSxA1lZ5k/ag1tP3N7oC9
         e2A9k8hkNxsW9Uy7Mnzx916XCGzkAyoRVlLloVjW+j8RQWSp41axeo0FWryHQ2BKjXDD
         FLTwK0V5AGeXHgkSYLGTBy4G0Iv/bJYWFNJ7O9c/daT4QSAibG8ZTbqoDtdJT1HRgxmP
         oEvT+rTq7Imafahi7ykh86ZHN2zZ9P67+k8jolUK+HMKDSFW1KrBXy0hZdg1MEu4ISqR
         pvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqydpCp0eVS2/6PZSo5h9weD6iPoeQvX+3lQSPsVgmxdzg/w8QJpD3+ZQhKEhFxKEfi9xLhLutWHJFu3sg@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOTVbvy6z/rJr3qt2Wqlqxoc+qoGMtAHpKIp4Oqtn6bRtAmi0
	UVKkE15BnPvxX11k7tZqvq6y3NJdEnDOLefOoL/FNIk17qXirbqyjNflP1qlzTVdij8kNvLlb3e
	g9HxZFOV3vs/0wpjZO34oPXxDPhFkJFijGfJzEnsXNps3infieCbqu9qnwPNXgg==
X-Gm-Gg: AY/fxX7jz1lrQvBmKEzNGImQj8dGJT0SL7JHwLuASq/4FbV1LTp7NG4SyStRGNsPdMX
	v2YDhR0XR1Ckh6gJJM1kaXi+T+EbM9Z0m26E7YXHgFtfMJFSivB25dvJx57Uy+OqLfkIfMf/CpC
	UOJxaVOfzY0ZDqeNtj+mb3uxuviwhBG0VazJo1NuZNxbFfKmQpBsROG+0cZ04Q+m38iYaj0CZeg
	/ydz3HlYbsqPnMuyuJI4XPzq88ETW2w4ZNsgpIL8IYRq4KI3aqRJVflmfv6+lNRMPBeehRK
X-Received: by 2002:a05:622a:1b88:b0:4f4:bb86:504f with SMTP id
 d75a77b69052e-5013a3984bfmr3348061cf.16.1768256310151; Mon, 12 Jan 2026
 14:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108050748.520792-1-avagin@google.com> <20260108050748.520792-3-avagin@google.com>
 <wfl47fj3l4xhffrwuqfn5pgtrrn3s64lxxodnz5forx7d4x443@spsi3sx33lnf>
In-Reply-To: <wfl47fj3l4xhffrwuqfn5pgtrrn3s64lxxodnz5forx7d4x443@spsi3sx33lnf>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 12 Jan 2026 14:18:18 -0800
X-Gm-Features: AZwV_QgFDLRZ2CO39u42hYQfjphtOd--py_KaLDidq3C2V9cruvBn8uqBMP31xw
Message-ID: <CAEWA0a4s+Uhm405CnvNsE61ed5_xJ8PUZqL74zfeZnivw1BChA@mail.gmail.com>
Subject: Re: [PATCH 2/3] exec: inherit HWCAPs from the parent process
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:46=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jan 08, 2026 at 05:07:47AM +0000, Andrei Vagin <avagin@google.com=
> wrote:
> > @@ -1780,6 +1791,50 @@ static int bprm_execve(struct linux_binprm *bprm=
)
> >       return retval;
> >  }
> >
> > +static void inherit_hwcap(struct linux_binprm *bprm)
> > +{
> > +     int i, n;
> > +
> > +#ifdef ELF_HWCAP4
> > +     n =3D 4;
> > +#elif defined(ELF_HWCAP3)
> > +     n =3D 3;
> > +#elif defined(ELF_HWCAP2)
> > +     n =3D 2;
> > +#else
> > +     n =3D 1;
> > +#endif
>
> Is it guaranteed that HWCAP n+1 exists only when n does?
> (To make this work.)
>

It is true for all existing arch-es. I can't imagine why we would want to
define ELF_HWCAP{n+1} without having ELF_HWCAP{n}. If you think we need
to handle this case, I can address it in the next version.

It is just a small optimization to stop iterating after handling all
entries. The code will work correctly even when HWCAP n+1 exists but n
doesn't.

>
> > +
> > +     for (i =3D 0; n && i < AT_VECTOR_SIZE; i +=3D 2) {
> > +             long val =3D current->mm->saved_auxv[i + 1];
> > +
> > +             switch (current->mm->saved_auxv[i]) {
> > +             case AT_HWCAP:
> > +                     bprm->hwcap =3D val & ELF_HWCAP;
> > +                     break;
> > +#ifdef ELF_HWCAP2
> > +             case AT_HWCAP2:
> > +                     bprm->hwcap2 =3D val & ELF_HWCAP2;
> > +                     break;
> > +#endif
> > +#ifdef ELF_HWCAP3
> > +             case AT_HWCAP3:
> > +                     bprm->hwcap3 =3D val & ELF_HWCAP3;
> > +                     break;
> > +#endif
> > +#ifdef ELF_HWCAP4
> > +             case AT_HWCAP4:
> > +                     bprm->hwcap4 =3D val & ELF_HWCAP4;
> > +                     break;
> > +#endif
> > +             default:
> > +                     continue;
> > +             }
> > +             n--;
> > +     }
> > +     mm_flags_set(MMF_USER_HWCAP, bprm->mm);
>
> Will this work when mm->saved_auxv isn't set by the prctl (it is
> zeroes?)?

The inherit_hwcap function is only called if MMF_USER_HWCAP is set (auxv wa=
s
modified via prctl). However, even if mm->saved_auxv hasn't been
modified, it still
contains valid values.

Thanks,
Andrei

ps: Please ignore the html version I mistakenly sent.

