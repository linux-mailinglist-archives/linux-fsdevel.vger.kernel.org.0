Return-Path: <linux-fsdevel+bounces-36545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31829E5959
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43152283DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AB21C18A;
	Thu,  5 Dec 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqfJnfm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50A218AC2;
	Thu,  5 Dec 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411232; cv=none; b=XU3GkU5BA0q8FUffRKjUdsORE6uKZ3YKV+Qux9JU3HrdwUmRJG5uVkiIupqqsLd7yr6dDylPxW/CKcALFCDD2QV773mpyf9b8VzYQUWJZmH81iWHxZbsapA0PIu5fUUyRYS61cLIpGM42Sd1XukuiEZqE5R3TZvhCqsnRijwE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411232; c=relaxed/simple;
	bh=ufzwSz+RjY/RnfKO90EppjjD716DJCcMFtKL6dpA+8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2s8toNYEQesE/P8NeQ9QilXa7BKxo2JJUjAh308vdwSwrwpr1QoGWhIV7Y+15q2gWcvq4vZDuhoqblebEP6oJSXcJcz5/POJYsLjy9YOydoxFRFWERL6sT28l5XpgM956shb3HM31guwKNWRsNTEzEAyk8yWfEdy4CwW4Kje1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqfJnfm9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa560a65fd6so179042966b.0;
        Thu, 05 Dec 2024 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733411229; x=1734016029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBaoIxbY49iWFWXwlZen/uBQT+uZZPvmyTOyfYYEkEQ=;
        b=CqfJnfm9tRmDZ3iZavO8kGqKrzja9485ZvfaUNvHrtfAsss6ulLG1EXN+5UMI1Z+Gp
         nh7IHgPRrLF2vEdpZZSYXA/OitOaxQxo5/ICeCR4DBxYxTruU53NDjoPs/3n1rj/r1x7
         SPzIm0LDhMx+JG+T99nPWBx2MTKHRQcQC6yf6uaHqSoNV9Jy+TlwJ88aYnPVzN01U0fq
         2f38jK4cGedqxRFiRqCsiQoEm/C5V0Wt7eaaWsUqk/DdBYjp8o1yFhmP7+X/ztCt0A1I
         48uNW+GEwFd2+Ni9OpqM9iGV7X2gzM1jqz+EtVFN3mtUNucQ2V2FNtn4tPvFziFzywWy
         eq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411229; x=1734016029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBaoIxbY49iWFWXwlZen/uBQT+uZZPvmyTOyfYYEkEQ=;
        b=KZJDUoYuNwgeQVx1aAL02aZJKZndVh/EvBLZc4fDGRNDaO+vdsCxhVfPCT5ebh/rUs
         9FaGo9DMJjzEeTI2Jt6coG4JUjsdWzJmBysPMdcnxcEyrlI8Yemx9dG/TEkJ5IGAr+OF
         IBDnU9eo2Gl3mHXCD0dLk3mKno8xEPaiAorM/uEfMy3BdyYyU5qMGYPDtBSVWd/iYQtU
         22asdS+hJcVFo8hy0sHfMJDshijEt341iYoUq0u0QislOnOu90wDC1bb0L8N7av6AHGa
         Uzsj5Td14Ne5DLUS4SZ7qhzmDLOaGJK0dmvLMOpO+/RzMO4/4thBuLqorKtNVvyB9Y54
         4R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIGa4EPG/YAgYeLBC8QXIYw0yVFdP7lioNHIn4ogjlNa4r1U7jpgvo8y4E68oQ3tg6INeyV9KTuaUyEUt3@vger.kernel.org, AJvYcCWQHYOCKqPkkgeQe6O/oLYW0VK4ChVRQ4WxHHWqROgjavQIB1RR18UaXXHtiaLGrx/V3zvlh+RFqFYhmSGl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2LPhUdf1oOftTV0SKOj/8EcGgipMvX3Mlal5Loe0e1uJfjr4
	CfRdLQxdtrNWME/mOtRGvwY/enatAmJj2LWs4Fq16t10YXM/00YMprGnbWEeR2MxBOOATGQQWxO
	ATf+M81lclYdWUiSLDmz01YAZTUZOMQ==
X-Gm-Gg: ASbGncsHywx81kUDMnEbOPxmL6pFKEdYsylLc5cbrAOBKyaUJhygZ4sDSVeA7kIeTCG
	/i49nAkaAzdO5EyZ5VfmnJ/4hENzv0Q==
X-Google-Smtp-Source: AGHT+IGsajCkSbET03SgaBMa1DXV5LowNTK4Z4Xh8z8mZSIfSFqooTwvyo6doh6w3IbjfERnpmGSDd9JjUomwhzyKLk=
X-Received: by 2002:a17:907:9707:b0:aa5:55b6:8080 with SMTP id
 a640c23a62f3a-aa620332febmr375024266b.12.1733411228897; Thu, 05 Dec 2024
 07:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205-kursgewinn-balsam-a3e8bfd1e7d4@brauner>
In-Reply-To: <20241205-kursgewinn-balsam-a3e8bfd1e7d4@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 16:06:56 +0100
Message-ID: <CAGudoHEXcYtwijh9zAkjTfZsoO5q=Y3mXk4+m7PJZfOfKZXb4A@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: Christian Brauner <brauner@kernel.org>
Cc: paulmck@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> > +     BUG_ON(files->resize_in_progress);
>
> I think this BUG_ON() here is a bit unnecessary.
>

I'm an assert-friendly guy, but I'm not going to argue about this one.

> > +     files->resize_in_progress =3D true;
>
> Minor: Why move that into expand_fdtable()? Having
> files->resize_in_progress in here doesn't add much more clarity than
> just having it set around expand_fdtable() in the caller.
>
> Leaving it there also makes the patch smaller and clearer to follow as
> you neither need the additional err nor the goto.

The is indeed not the best looking goto in the world, but per the
commit message I moved the flag in so that it can be easier referred
to when describing synchronisation against fd_install.

--=20
Mateusz Guzik <mjguzik gmail.com>

