Return-Path: <linux-fsdevel+bounces-36659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964FF9E7683
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4333628429B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41E1F3D39;
	Fri,  6 Dec 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnwQheyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295920626A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504209; cv=none; b=kJkQHo/skZhRI1uJVwG9CVEs81GZ6dadtVo3fGl6B1OWSI6xfwx/cfJnpWZixzeu6XP3hBFflEdHUAijlpf2OswHKgFURdfKlu8qjIyktOvoUscyFUboDDTHAMZb7tnxm+Vckyeyv6/QtE753YUZ4bMbBLcWAbjTfU7rdHL2jT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504209; c=relaxed/simple;
	bh=hHxIRxyxhnui1YFklOaZq7n1tqVuSYtB7Yo+KPutrjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugWUljVPztf13xoP4BJ/XVtvnQvsl86NcAAdKWhwn0bXDLbkTsobzJhjGhzDOGvtNlZRqrYcHPKuPch/ss3ItYepygDDiVmRWTXaAPvvOG5hBjTXvVcBWG6YwnELrRFjW/qoAzsGRzBJz9JDsUjsXMxUXLykY1+NQfieX1UuWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnwQheyc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46684744173so38347271cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733504206; x=1734109006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y5YzZactQ0sWv1M0AKI2mATRzhZkuaJYPcUlU74hzo=;
        b=SnwQheycxPqf7tZc3V/SAaoVK8J4jBnwY/jXE2Zh9/T3O/oz1il0UXdbzt9GyqVpH0
         y/beBCN+ezCQvDtdM4M/Pv26bZQy71qabokCPCxSIAMf2gmAPBAhYiutbPTC3UI+74+I
         5BiYb/NyL8JCIcew2TMS17djsQRttJ9WOZSVEUGUsRHfdtnlO5mTNs2WdxMmnQJYb4b2
         gY2bfLngaS3HL7PDzMXKDk0GgBoA9p0791wwp6iFpKUGmyAMbnIWBi9Jg15pm64+bYp4
         TjoRs08byPjA9Xn+7QVb+zN/QcIfDQV29dGvSDgS7AX3+XtZXYk8Ld9B0aEfbmUEW94F
         tmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504206; x=1734109006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y5YzZactQ0sWv1M0AKI2mATRzhZkuaJYPcUlU74hzo=;
        b=J6/1l4TseZMlusvnSrHRoFMHyJsSAww4yfRjOHBttkBI01uq29U125EOw/6960RLPO
         HK1HMBLW3ukFK/D8pzmfQrizzUO/f8SXwKSJg1JH2vTGHR6JiS63Hb+6IZxjvcgzzgZT
         MCEMNIx3pAlTDzIRADwvzcLABFZiulUSz8HB4FVGpPjkUscFBvUZHeJSwxL0Gn0mhbpf
         QxWVHRGOabQKvXOHuqeLvKf92zWYmfOLQnrtfrpKcQo0eOjrKH6ruclMSLY97GZU7Tsz
         ASaJxgQy8CxYUOhJATquRpsvQGIQ7AJTJFO/dasXvxftrvMhlOBhpDFpSN/6OCRbRRSi
         WRuA==
X-Gm-Message-State: AOJu0YzPxTI9/thKjnxleVowri+GSdG6UKWh1TQqxIYsLs+fGXhYRFo9
	NmjPrxCIsFJgf+ksoXq8UduLLFyHQWPmaOshS5hkNuGk+NcpJKzEn6tkL3tUepX+iTSbfVwnc82
	BG5Fgg9NPcOPdsGiI89y5JyCLmio=
X-Gm-Gg: ASbGnctUlMMwP2q3hXAgZ2k0WbqcHzZmDGPMVRhPeyniacjc+I9Ba6CVZiaTyKWFoyy
	whjs4yXwQvXj54FuKro6NoNd0uHPZUNSA
X-Google-Smtp-Source: AGHT+IETbnmsShPTqoAYGkOy9iDYF8KRXck+Gbl8d8nd5q95AmuCuln+5cHhc1Lyy6D6kdFe7Es8VVDzFmZOV9fC+VI=
X-Received: by 2002:a05:622a:22a5:b0:466:af6c:1d7f with SMTP id
 d75a77b69052e-46734c9e6e5mr84679571cf.7.1733504206534; Fri, 06 Dec 2024
 08:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204164316.219105-1-etmartin4313@gmail.com>
 <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com> <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
 <80ee53a6-085a-4aff-b528-0e32b4780c03@linux.alibaba.com>
In-Reply-To: <80ee53a6-085a-4aff-b528-0e32b4780c03@linux.alibaba.com>
From: Etienne <etmartin4313@gmail.com>
Date: Fri, 6 Dec 2024 11:56:35 -0500
Message-ID: <CAMHPp_Rg3LpnWFn+a9kr=Lwsi+ngTDoGt5SD4Bojz5ss3D1o-g@mail.gmail.com>
Subject: Re: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:47=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 12/6/24 1:09 AM, Etienne wrote:
> > On Wed, Dec 4, 2024 at 8:51=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibab=
a.com> wrote:
> >>
> >>
> >>
> >> On 12/5/24 12:43 AM, etmartin4313@gmail.com wrote:
> >>> From: Etienne Martineau <etmartin4313@gmail.com>
> >>>
> >>> If hung task checking is enabled and FUSE server stops responding for=
 a
> >>> long period of time, the hung task timer may fire towards the FUSE cl=
ients
> >>> and trigger stack dumps that unnecessarily alarm the user.
> >>
> >> Isn't that expected that users shall be notified that there's somethin=
g
> >> wrong with the FUSE service (because of either buggy implementation or
> >> malicious purpose)?  Or is it expected that the normal latency of
> >> handling a FUSE request is more than 30 seconds?
> >
> > In one way you're right because seeing those stack dumps tells you
> > right away that something is wrong with a FUSE service.
> > Having said that, with many FUSE services running, those stack dumps
> > are not helpful at pointing out which of the FUSE services is having
> > issues.
> >
> > Maybe we should instead have proper debug in place to dump the FUSE
> > connection so that user can abort via
> > /sys/fs/fuse/connections/'nn'/abort
> > Something like "pr_warn("Fuse connection %u not responding\n", fc->dev)=
;" maybe?
>
> If the goal is to identifying which fuse connection is problematic, then
> yes, it is not that easy to do that as the hung task has no concept of
> underlying filesystem.  It is not what the hung task mechanism needs to d=
o.
>
> To do that, at least you should record the per-request timestamp when
> the request is submitted, or a complete timeout mechanism in FUSE as
> pointed by Joanne [1].
>
> [1]
> https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoon=
g@gmail.com/
>
>
> >
> > Also, now that you are pointing out a malicious implementation, I
> > realized that on a system with 'hung_task_panic' set, a non-privileged
> > user can easily trip the hung task timer and force a panic.
> >
> > I just tried the following sequence using FUSE sshfs and without this
> > patch my system went down.
> >
> >  sudo bash -c 'echo 30 > /proc/sys/kernel/hung_task_timeout_secs'
> >  sudo bash -c 'echo 1 > /proc/sys/kernel/hung_task_panic'
> >  sshfs -o allow_other,default_permissions you@localhost:/home/you/test =
./mnt
> >  kill -STOP `pidof /usr/lib/openssh/sftp-server`
> >  ls ./mnt/
> >  ^C
>
> IMHO hung_task_panic shall not be enabled in productive environment.
>
>
>
> --
> Thanks,
> Jingbo

Thanks Jingbo and Joanne for the pointers. I left some comments on
that other thread.
Thanks,
Etienne

