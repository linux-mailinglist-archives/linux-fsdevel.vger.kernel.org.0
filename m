Return-Path: <linux-fsdevel+bounces-33712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C09BDE08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 05:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF542832E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 04:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62018FDAA;
	Wed,  6 Nov 2024 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2YqnW7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A013541B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868298; cv=none; b=Gy8eCSYNN+ufSnMq87gdUC61usIjagJC3WwavfG1Fgbh44IJtmvGw/NwouNuO4IrZzobvN3V1ErSala0z0BrvhgC8+t/76VtxrruYdBEtq0pUu0ZIOMq/w2Xs3vuz7ZArM1wSwXMQ69h/sOCLRy2TFQ/ivf5Yqpomq9YrpKcDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868298; c=relaxed/simple;
	bh=LdyvcGK5ggPPw0mXer7lTISLm33Byqe+sqxIB3ZcAKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ap3orzAMy6+FV8E2j6QqILpFL9PRLTNGBv5ZqYC3xTaHvP+kPsfzIdtP7KvrrulltPen8NsrKQR0DJ/ZQ9mjSCuN6ZQaFFayWAoR3djI2DcWXbM/z1xjsnPCM0fK9Ve/t11ArLAp7ULwLdaKCk2hKi0ETJPmFRnDrNRxzDuIqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2YqnW7V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730868295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdyvcGK5ggPPw0mXer7lTISLm33Byqe+sqxIB3ZcAKA=;
	b=C2YqnW7VszUMybKNk11xjRl3GoKu1ayEdayCx2Rt36SbglKof+caa+tiaeFvxBjNGVlIkZ
	vOIH0QEzo6IG3k934fV/eTw5MaEjpcyLWElJHcva29StVfQie/CobZXYcqYniuOscQVfhW
	gitIYuCfgfWbhA4CEfRHKgAjmuniL64=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-tF6mfvsqP42Y4WUE3uE4Cg-1; Tue, 05 Nov 2024 23:44:53 -0500
X-MC-Unique: tF6mfvsqP42Y4WUE3uE4Cg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84fdfb0203eso1780141241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2024 20:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730868293; x=1731473093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdyvcGK5ggPPw0mXer7lTISLm33Byqe+sqxIB3ZcAKA=;
        b=QY0kcvaAnM+snZq54TrtylTk3gszg7cDPpxIjR+1msj1xjpivmF9JluXxBfktzP7lR
         RDevzi7fkoKEqnc2wXCgHu5XPjPqH2L/tlg/BgvE/LfvqrAMIdoP/EperaG45a3/szKV
         WSySrXl82rkJr/sxoqAhr0l6hRd5gNNVQqVzu3Vy0jGt5qbxfXzF3jc8LMMkZRDFnlR4
         sv8w6MsoiXlzj6d863kDiEPJEDBDPFCLGvtc93BGZExDLqd7kNMse2ZxZ6q/Us89ggL9
         miX3g82Jr3CnGm/bWljEAc9/OjBXwKwaOA7knjaYAtKJMCIII3GdzzqqcJjaMX9fYibq
         bJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUxaZiWLSt2xIJavaOgNbenDrp1kUzlRpz8DMVZk/Pgm6Etr6HsL3eMhWAXb4OZewDUOSHCwkyKd1AHmm9p@vger.kernel.org
X-Gm-Message-State: AOJu0YwKddZJ3EGGBRjZkYvNbd6NWbe1vaGnCRmU5MWTWUYnJek7mH6k
	DXBTtBiG3mlIWE1SDEamkCo/7k9vDsIl0ZMsJIe1MaX7Em0awVGqAn40BwIzIISAE6qZvo/ME2o
	YUrjmGEsO4s+ckX74Jd2HTYc0Sc2it1hbXULzlxvchFG87h5may7seo9oVp21EVdqVTXU13g7YD
	furQEFNFM/BYiCozVdtRhbBa7wnRTqaI6fB2tTbu7hJ4Pmbejm09p18w==
X-Received: by 2002:a05:6102:3753:b0:4a4:9363:b84f with SMTP id ada2fe7eead31-4a8cfb25e4amr37666144137.5.1730868292819;
        Tue, 05 Nov 2024 20:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4iGAezGMJs15MNuuVVJkx2duwmdHhkRxiLbHUY21XKlOr3ugjz4SNSgTPpCow5imWMd0nbAcU7G/vr44oXyY=
X-Received: by 2002:a05:6102:3753:b0:4a4:9363:b84f with SMTP id
 ada2fe7eead31-4a8cfb25e4amr37666136137.5.1730868292604; Tue, 05 Nov 2024
 20:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
 <20241016-fuse-uring-for-6-10-rfc4-v4-12-9739c753666e@ddn.com>
 <b4e388fe-4986-4ce7-b696-31f2d725cf1c@gmail.com> <473a3eb3-5472-4f1c-8709-f30ef3bee310@ddn.com>
 <f8e7a026-da8a-4ce4-9b76-24c7eef4a80a@gmail.com> <9db7b714-55f4-4017-9d30-cdb4aeac2886@ddn.com>
In-Reply-To: <9db7b714-55f4-4017-9d30-cdb4aeac2886@ddn.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 12:44:41 +0800
Message-ID: <CAFj5m9L9xjYcm2-B_Dv=L3Ne3kRY5DVQ8mU7pqocqXE13Ajp-g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 12/15] io_uring/cmd: let cmds to know about dying task
To: Bernd Schubert <bschubert@ddn.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jens Axboe <axboe@kernel.dk>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Amir Goldstein <amir73il@gmail.com>, Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:02=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
>
>
> On 11/5/24 02:08, Pavel Begunkov wrote:
> > On 11/4/24 22:15, Bernd Schubert wrote:
> >> On 11/4/24 01:28, Pavel Begunkov wrote:
> > ...
> >>> In general if you need to change something, either stick your
> >>> name, so that I know it might be a derivative, or reflect it in
> >>> the commit message, e.g.
> >>>
> >>> Signed-off-by: initial author
> >>> [Person 2: changed this and that]
> >>> Signed-off-by: person 2
> >>
> >> Oh sorry, for sure. I totally forgot to update the commit message.
> >>
> >> Somehow the initial version didn't trigger. I need to double check to
> >
> > "Didn't trigger" like in "kernel was still crashing"?
>
> My initial problem was a crash in iov_iter_get_pages2() on process
> kill. And when I tested your initial patch IO_URING_F_TASK_DEAD didn't
> get set. Jens then asked to test with the version that I have in my
> branch and that worked fine. Although in the mean time I wonder if
> I made test mistake (like just fuse.ko reload instead of reboot with
> new kernel). Just fixed a couple of issues in my branch (basically
> ready for the next version send), will test the initial patch
> again as first thing in the morning.
>
>
> >
> > FWIW, the original version is how it's handled in several places
> > across io_uring, and the difference is a gap for !DEFER_TASKRUN
> > when a task_work is queued somewhere in between when a task is
> > started going through exit() but haven't got PF_EXITING set yet.
> > IOW, should be harder to hit.
> >
>
> Does that mean that the test for PF_EXITING is racy and we cannot
> entirely rely on it?

Another solution is to mark uring_cmd as io_uring_cmd_mark_cancelable(),
which provides a chance to cancel cmd in the current context.

Thanks,


