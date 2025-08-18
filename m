Return-Path: <linux-fsdevel+bounces-58107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB23B29650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 03:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7061965E1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC32222D8;
	Mon, 18 Aug 2025 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpKv2a2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0B1B7F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755481160; cv=none; b=Y9KC+gUAsxcXYO6356ZDi6cu9m5p0IWKdy54LrcCEW8clIXNegPg+E+uje9fI08EqRqXUVtlyKZzSy4IeRSP1tosWP7Es9YNYzAqKWfiZFIEeoWMEueHci01uYq7NGET/cLPBbj9s8NaB9EaNngHQHvGGxXwF3UaDb6B1RNQoz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755481160; c=relaxed/simple;
	bh=Rb8yRjwTHujDI/KtC91QPXecIRV7gIEqLM3IjrDwPh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcB5y1kXe2iv1c2pk2LypTWp+OPXyV+cFDKXT1JJRL3mQLWymEjNzVllab+02RqjvmWdkCG+BK+VcabPW/hLimbzYdqSc7+Wx4ta3Uo+lA8PnmQFihRwo0fcB+nGfl4toy/u/lOkDXaIfmEV94f2GlNskgi81sWQnwagStfQwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpKv2a2R; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb72d51dcso517208766b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755481157; x=1756085957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC1BccjsbYL36CPp7CsaS9jGmztyFwsXC53xiY/CEtc=;
        b=OpKv2a2ROue46daPByaL5D+v1Wc+yODjUz3LvuFvenz2wr3PKB/fb2ojdNg8vurHCS
         Fb9d8FuJ+HQTTvFCUHoKLe5GBqjtCiMJUWD8k82EV695NIyTu9yvgiMfMacnl2M1z70i
         53W/exN5rFXvHEgZL4Mc+5FvkU4kV2uiXW73bayx41Xg0ctCVj02PQNQX6U7Dpg5QhwN
         QJzdHG22Hy82mzWt+MTyCtREx19+K1+bUiHyM5btYfnEq0Dr+TYSDvzubVzqh8apa+VR
         jkMPbNhI+SWBwg6kz2IqTz6VTQvvv4+GyKEsbmvmgdcsKT4LPT0JWQsryDZjPQauJsmC
         2FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755481157; x=1756085957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC1BccjsbYL36CPp7CsaS9jGmztyFwsXC53xiY/CEtc=;
        b=LuHcYhYWV1saegITOjIHwcEfC5Lj+fHcRnuuiaaD7p2DkcU7bedrjhDJQuxQfL2qHL
         s8ag64vRQWfy8iHF8nQvuRTWnw5rv9OktMXS9Z0oO4mDsV5w6B74KuRXAN+ubmbB+CWg
         rqiKYde3FVLzqDjqBla8ua8nAoAS3GcSCDj39E1Gn0DfMgvmNwDqRAdNDLHP09LGdfMl
         KC3ipDZAZ3GaDGpJWnzoVqIQw39TIMHyS4Iw0SxKqZcQYs9aTkX9Jjf/DEijDxK+ZbFp
         zIhjERnbS/JOWFzW7abWg7EXiDem/BaWMCLtE1X2I3mi6FFZX6DOsbQtG/O+QUiIy1Eg
         YqKw==
X-Gm-Message-State: AOJu0YwspSJcE82IYj32iR0xdhguq3vzleohKYsuXhBgGimG//txqBL5
	oI0x9qmTu8i316QpSVgSLKT9KCYQNQ+XMXxXWDJzY2hyLYKoIuFYF8soyu5HNxCZsckhG/f9DHN
	mC8DObtB92g5l4x0h+L80s1xw5gbN/OnaOAgRWos=
X-Gm-Gg: ASbGncs3B/tZhdjbTMnjIFrVBMR/weou4XzXJlaDuWd91sXvDBromk2843ZmXFqTonQ
	Te2KnxP2ZdmXDZGoZtThVGIYwEiyI58pF/AYa5sRlsqVGwtW2SaumkgIe4Fcqzt+ptTsZ3pZdNt
	Xl8ehUfqA7vu6L4ScXWURmvg8AqPAjvawsslifEZe7WObY6JyM/tIHPa93+JT+ZvCtj9XIY2TpQ
	LRX/Q==
X-Google-Smtp-Source: AGHT+IF3ZhSRZgSiEd8LxGef+hfRvGrQE+d8Z3Da3xPpLldPEog1tbMaWXJWoS4WyDny9rxNB6Hjg3VnUZRl/dHW2A4=
X-Received: by 2002:a17:907:6d22:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-afceae2d340mr708727966b.31.1755481156691; Sun, 17 Aug 2025
 18:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
In-Reply-To: <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
From: Gang He <dchg2000@gmail.com>
Date: Mon, 18 Aug 2025 09:39:04 +0800
X-Gm-Features: Ac12FXx8XqajJCSWDntI1tQfgeNM4n_vXMeqXoe332YKO2SoQ4Y3ioLyALskZp8
Message-ID: <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Bernd Schubert <bernd@bsbernd.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8816=E6=97=
=A5=E5=91=A8=E5=85=AD 04:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On August 15, 2025 9:45:34 AM GMT+02:00, Gang He <dchg2000@gmail.com> wro=
te:
> >Hi Bernd,
> >
> >Sorry for interruption.
> >I tested your fuse over io_uring patch set with libfuse null example,
> >the fuse over io_uring mode has better performance than the default
> >mode. e.g., the fio command is as below,
> >fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D1
> >--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
> >-name=3Dtest_fuse1
> >
> >But, if I increased fio iodepth option, the fuse over io_uring mode
> >has worse performance than the default mode. e.g., the fio command is
> >as below,
> >fio -direct=3D1 --filename=3D/mnt/singfile --rw=3Dread  -iodepth=3D4
> >--ioengine=3Dlibaio --bs=3D4k --size=3D4G --runtime=3D60 --numjobs=3D1
> >-name=3Dtest_fuse2
> >
> >The test result showed the fuse over io_uring mode cannot handle this
> >case properly. could you take a look at this issue? or this is design
> >issue?
> >
> >I went through the related source code, I do not understand each
> >fuse_ring_queue thread has only one  available ring entry? this design
> >will cause the above issue?
> >the related code is as follows,
> >dev_uring.c
> >1099
> >1100     queue =3D ring->queues[qid];
> >1101     if (!queue) {
> >1102         queue =3D fuse_uring_create_queue(ring, qid);
> >1103         if (!queue)
> >1104             return err;
> >1105     }
> >1106
> >1107     /*
> >1108      * The created queue above does not need to be destructed in
> >1109      * case of entry errors below, will be done at ring destruction=
 time.
> >1110      */
> >1111
> >1112     ent =3D fuse_uring_create_ring_ent(cmd, queue);
> >1113     if (IS_ERR(ent))
> >1114         return PTR_ERR(ent);
> >1115
> >1116     fuse_uring_do_register(ent, cmd, issue_flags);
> >1117
> >1118     return 0;
> >1119 }
> >
> >
> >Thanks
> >Gang
>
>
> Hi Gang,
>
> we are just slowly traveling back with my family from Germany to France -=
 sorry for delayed responses.
>
> Each queue can have up to N ring entries - I think I put in max 65535.
>
> The code you are looking at will just add new entries to per queue lists.
>
> I don't know why higher fio io-depth results in lower performance. A poss=
ible reason is that /dev/fuse request get distributed to multiple threads, =
while fuse-io-uring might all go the same thread/ring. I had posted patches=
 recently that add request  balancing between queues.
Io-depth > 1 case means asynchronous IO implementation, but from the
code in the fuse_uring_commit_fetch() function, this function
completes one IO request, then fetches the next request. This logic
will block handling more IO requests before the last request is being
processed in this thread. Can each thread accept more IO requests
before the last request in the thread is being processed? Maybe this
is the root cause for fio (iodepth>1) test case.

Thanks
Gang


>
> Cheers,
> Bernd
>
>
>
> Cheers,
> Bernd

