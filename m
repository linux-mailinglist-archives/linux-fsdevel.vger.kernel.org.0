Return-Path: <linux-fsdevel+bounces-34963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4209CF2F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2A1F2376C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89121D63E6;
	Fri, 15 Nov 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lja88Ylq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DC15383D;
	Fri, 15 Nov 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691956; cv=none; b=LvWzLr+/OUh0+odH2bACb8f3d5OjDSmgsyr/rYucm3m80EvXcsFaVPSMEUjJ/+4TY/j5RxdfdsATULxLR05yBJ80RTO7A70FRPYlnxlCO1+wlktbo27hlZZIy+Qy82VTpoxthn17Q0s78v1UXB1byxJl7l8A6ONRJIe2mwNooGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691956; c=relaxed/simple;
	bh=KUIL+HgTDFXAkVYtCNxJ77NnKMvuAJERqwJnGCtqeKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2+WLi46X1qxhSZQzTQZxNsyea9ZgtNH1HY6aJNgk3YgJ1GuL3ga212PgrraboKq/ezcsekBRG8owV+bo+g0Em4ERcdMGYqSNq5luyOCv8760hP1Vtyj42el7xWzeSQX9LEs8GuXglmOTu4bky0klRj8YwfzIoNA4DI6bVm3hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lja88Ylq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso2505263a12.2;
        Fri, 15 Nov 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731691953; x=1732296753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZqJxQOWKrlB7gmG0BuWpbPNnaGX9IRwHzdceyssFoA=;
        b=lja88Ylq+J1qQZPjAxoUX4aZqzb4hHpCQwgedLEiGLDt0t70V6Au7yc/e5bmnRczeK
         LBoxc7j8irWDkdnf8S6te6Wocq9pj+KGQOjqJR0HVuovDVPhjxcCvDgj8wXrvY0UEt3N
         qJnAAqhyeK/gIQJ+Q1Tj2nLcVUKPOPqohtH4G3EOYiUG2ZoGCoaL/Wh8LtglGhqQqzMt
         248LumMm+wAMlESbBZPSM2qz1fxYzO5dh7RS4pJKQsqLyKcf6BmCL1ZMY/D2Y/D+Oouv
         uvJEOhWCBagFPqvwGcOL5ZVmArdBFmqpS4W4C7vC7yv6jmt5o2vSa9zsnFmAYf2scLPY
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731691953; x=1732296753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZqJxQOWKrlB7gmG0BuWpbPNnaGX9IRwHzdceyssFoA=;
        b=XlPbpYdq0t/LHnpxQaN/rvrnGyJntbqVOT1w0UAnUj8afcTd/HAOPVmnkpJLGux4gf
         d8reCodSUoA7WI6OxkD5zaUCdAy3M6Y21ygzcjFfPkct4K91m1kbA6lU6g6gDexJh7wE
         K97AVxlPLZqg6UQ77rYXH8vOkf2VVNYyjPwJ31e82bxT67fClJGNykFK7c53f6eKvhcw
         rqSI3/teYUd74yaHUeBtFHMwPtQHeXKpWyO2SHXHbUcqCzSdHzs4tiTFzrn+KbkUfbkA
         XVXzJW0nXSh0UIfUpx3ZFQZ7QMMcQj5JP7uqKkKyvT5ygyY7MMTdaNVA1Ex/KyavXiV0
         H3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCURKmeAVa3JQUl3N1g+2sWLHF54GNQzSYJ1ZPWZs72VvNGak4lh+tJYVbmR4tRQPanwSxsZIDiQIP/LaOMb@vger.kernel.org, AJvYcCW0U3U8DvKEHwGYefRZXPkMwD93GMSe2+8CGz0gvuqOCtRvhWDD4KSznob2VJ8x/NwOjunnB2CBvn5ZKObKMQ==@vger.kernel.org, AJvYcCWDrzx4vyLvXwdDwHdUW/WvXXWILN2dLbjZB4uiVxeUSGKtagWl2VVLTtCYFylruhkvHldxSURrRotaM6cNZJuEhF60vVBG@vger.kernel.org, AJvYcCXumy0lK9blL5FJMS/t8EW7cZGg/F6BFDJvWBSYaXsuNVx+OyyLhSqpzFhSNXbm22fLCr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGg6dASGtxRV+oxpm744UI/YJYG1M6OCIcPlqOQ6rfPVm9S4k
	H/Xizx2oJxUzMPF9UbjXdOwDROCaeoyFg73bJdu3YYnVa1oo2KBMTt/tSpy0befYR8PLS+cC7Ag
	YYpA01d1vOX2xOZmM8CxRBkOhZTE=
X-Google-Smtp-Source: AGHT+IG1xDLK/SRedDevjxrd8inEE4c5vT/y+MmAdZtP/SSrKcAWcmV1nYqyiWWpucLgFpzqRaTFjHNk5DOtdousIpU=
X-Received: by 2002:a17:907:3f04:b0:a9a:cf6:b629 with SMTP id
 a640c23a62f3a-aa483480a73mr323964966b.29.1731691952496; Fri, 15 Nov 2024
 09:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114084345.1564165-1-song@kernel.org> <20241114084345.1564165-2-song@kernel.org>
 <CAOQ4uxjFpsOLipPN5tXgBG4SsLJEFpndnmoc67Nr7z66QTuHnQ@mail.gmail.com> <E48C3CBB-7712-4707-AE70-1326445CE4C4@fb.com>
In-Reply-To: <E48C3CBB-7712-4707-AE70-1326445CE4C4@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 18:32:21 +0100
Message-ID: <CAOQ4uxg5KmZMbqxYoTKKGWeHW_irjsr70gexwNnCt4KVRMuDyw@mail.gmail.com>
Subject: Re: [RFC/PATCH v2 bpf-next fanotify 1/7] fanotify: Introduce fanotify
 fastpath handler
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "repnop@google.com" <repnop@google.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 6:11=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Amir,
>
> > On Nov 15, 2024, at 12:51=E2=80=AFAM, Amir Goldstein <amir73il@gmail.co=
m> wrote:
>
> [...]
>
> >>
> >> +#ifdef CONFIG_FANOTIFY_FASTPATH
> >> +       fp_hook =3D srcu_dereference(group->fanotify_data.fp_hook, &fs=
notify_mark_srcu);
> >> +       if (fp_hook) {
> >> +               struct fanotify_fastpath_event fp_event =3D {
> >> +                       .mask =3D mask,
> >> +                       .data =3D data,
> >> +                       .data_type =3D data_type,
> >> +                       .dir =3D dir,
> >> +                       .file_name =3D file_name,
> >> +                       .fsid =3D &fsid,
> >> +                       .match_mask =3D match_mask,
> >> +               };
> >> +
> >> +               ret =3D fp_hook->ops->fp_handler(group, fp_hook, &fp_e=
vent);
> >> +               if (ret =3D=3D FAN_FP_RET_SKIP_EVENT) {
> >> +                       ret =3D 0;
> >> +                       goto finish;
> >> +               }
> >> +       }
> >> +#endif
> >> +
> >
> > To me it makes sense that the fastpath module could also return a negat=
ive
> > (deny) result for permission events.
>
> Yes, this should just work. And I actually plan to use it.
>
> > Is there a specific reason that you did not handle this or just didn't =
think
> > of this option?
>
> But I haven't tested permission events yet. At first glance, maybe we jus=
t
> need to change the above code a bit, as:
>
>
> >> f (ret =3D=3D FAN_FP_RET_SKIP_EVENT) {
> >> +                       ret =3D 0;
> >> +                       goto finish;
> >> +               }
>
> if (ret !=3D FAN_FP_RET_SEND_TO_USERSPACE) {
>         if (ret =3D=3D FAN_FP_RET_SKIP_EVENT)
>                 ret =3D 0;
>         goto finish;
> }
>
> Well, I guess we should change the value of FAN_FP_RET_SEND_TO_USERSPACE,
> so that this condition will look better.
>
> We may also consider reorder the code so that we do not call
> fsnotify_prepare_user_wait() when the fastpath handles the event.
>
> Does this look reasonable?

Yes.

Thanks,
Amir.

