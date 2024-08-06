Return-Path: <linux-fsdevel+bounces-25153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011094978F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00101C20C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68D376E6;
	Tue,  6 Aug 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8z0iWoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0343C485
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968806; cv=none; b=PThxqqqqKE7685NtNdL+zyKcUTg3lGY9o+OWvRScloHRnH56Yg1l8Q8AXIkB0IqgIeazVTOoBpweejugE7PDPxTE8a5477iN1D/QfCbKHw9k/J0Y3MZIxE32XO1QOu1UCDooIMKxkgZ01RP10munY2OSCaXrMDe4u0PNv+8PnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968806; c=relaxed/simple;
	bh=cuS6kchMmChA1Efeq7UAsNdyrYzu+V1vc39ZlNdEerA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDOXM+4HaueAylsfQCTFIwU1UOi5kujFB+jxyIkqP7Ay3V9GNXlSqLGj+JnhDbcmZQOQKBeRVqgHOYM43YYab0L13asIiw/Ui36YUFkc5ycjyVsI3Qz2kFxtdoLSj+9ystU8GQ8jPe1MKJVUVt1lwivXLNLSsN1tIevrK58M5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8z0iWoP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso9459261fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722968803; x=1723573603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9D3TNRf9jiy/sH4K8O7Ku56VJ3Jwzdm0Jfa7u97qgU=;
        b=H8z0iWoP7MKZgTcpML2R0OuzLTl6rfr2m9Xo44ke2XUBaNa58fBpMQXfdfXW9JZjem
         6dMgEp1+U8jPNFK6pZIOBiGHCZ3DdApA4stmnKhntH/rngY47ZanrWSfUO17wyh5Ipmn
         6VXOe13CXQBIvF5SW4dIULhkjL/tXzcHNKrnSP/8VVOcYxNldO0njl4crxFezMEKHDMe
         g5vVdeNVTxrjNnB2sFdmBSIbvUE+g8xVj962vtDpq4JHorJa1YVDaBA/OTibwJ3X7ejk
         DlYvv7tCHanL8F/2sY9i7ciyaWG4zG5wN+3UCWpIweap8iTk31WGvRwrkMq+UsgkMCKI
         Um4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722968803; x=1723573603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9D3TNRf9jiy/sH4K8O7Ku56VJ3Jwzdm0Jfa7u97qgU=;
        b=LOGX6G6pGigYw5046W0QlYMzOoDldGMwy6ohgZ2YXXyqQc3hU1sPuC7ZPsHPIKFBSI
         n6Yoe2/ZPlRpLxujLDxCOeW4GuIuWeddORnIms2/+Ht9b/qyZVOLO5aV6cC1by9sWiXA
         y55jfhpuptwsDrkZK+iOa9jPMgZI4ggpY8ewBfG70z48UIkjn1opCwcvuRjG9RCJ/7oS
         l+MKe93kcFmG1nvqO0M9uU1+UzQXiCEnEMcxrnhG2txFxRBfhuIotxrDzhO4X679qrUP
         jJ5f4D/NmPvWQX2M34VXRqekesfjWsDZP6t3YiiY1ghfYRcrB5GkWyca+zJmPx2pckNc
         9Y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHZf7rrto/V/r4Ufy7D+DjptIunYJUD3/Kc97v20yYf3i5vkDRKFIta2ierYoWyXumfmcRphO8LwCC12q7obWYVNjqB9yg7/dfoRO+0g==
X-Gm-Message-State: AOJu0Yyi11lYxvVxK56/BULuegPyskdZpNspV6ySXEWxgie3HFdK9NVm
	HYWVQJ0LEDmHSBsw6Mb+MNcQ6vlPkcmADwzBPBFmpKcVuN7lTDj09kcmnrXrGLsaWwE6Vw9ajN/
	fu21JB5MuTrKgUv9NbYvQMkseBQQ=
X-Google-Smtp-Source: AGHT+IE87M6QaPh8W+qiXM42fJJiIjgwjOXG+WIi9RjtIBOoDy9dCJMTISs8EKp2avax1rDbhogYzpIEc5to1oUfb20=
X-Received: by 2002:a05:6512:3a87:b0:530:a9fe:7bb6 with SMTP id
 2adb3069b0e04-530bb38147dmr10870539e87.30.1722968802296; Tue, 06 Aug 2024
 11:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
 <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
 <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
 <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
 <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
 <CAJnrk1ZMYj3uheexfb3gG+pH6P_QBrmW-NPDeedWHGXhCo7u_g@mail.gmail.com>
 <CALOAHbA3MRp7X=A52HEZq6A-c2Qi=zZS8dinALGcgsisJ6Ck2g@mail.gmail.com>
 <CAJnrk1ZRBuEtL65m2e1rwU9wJn3FTLCiJctv_T-fKAQaAbwLFQ@mail.gmail.com>
 <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com> <d3b42254-3cd0-41f9-8cc1-fd528c150da2@fastmail.fm>
In-Reply-To: <d3b42254-3cd0-41f9-8cc1-fd528c150da2@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Aug 2024 11:26:30 -0700
Message-ID: <CAJnrk1YVvyv9pEddeKBvisqu5O7z_WtoEhUSzmJmxpCX0UaDWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Yafang Shao <laoar.shao@gmail.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:11=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 8/6/24 18:23, Joanne Koong wrote:
>
> >>
> >> This is very interesting. These logs (and the ones above with the
> >> lxcfs server running concurrently) are showing that the read request
> >> was freed but not through the do_fuse_request_end path. It's weird
> >> that fuse_simple_request reached fuse_put_request without
> >> do_fuse_request_end having been called (which is the only place where
> >> FR_FINISHED gets set and wakes up the wait events in
> >> request_wait_answer).
> >>
> >> I'll take a deeper look tomorrow and try to make more sense of it.
> >
> > Finally realized what's happening!
> > When we kill the cat program, if the request hasn't been sent out to
> > userspace yet when the fatal signal interrupts the
> > wait_event_interruptible and wait_event_killable in
> > request_wait_answer(), this will clean up the request manually (not
> > through the fuse_request_end() path), which doesn't delete the timer.
> >
> > I'll fix this for v3.
> >
> > Thank you for surfacing this and it would be much appreciated if you
> > could test out v3 when it's submitted to make sure.
>
> It is still just a suggestion, but if the timer would have its own ref,
> any oversight of another fuse_put_request wouldn't be fatal.
>

Thanks for the suggestion. My main concerns are whether it's worth the
extra (minimal?) performance penalty for something that's not strictly
needed and whether it ends up adding more of a burden to keep track of
the timer ref (eg in error handling like the case above where the
fatal signal is for a request that hasn't been sent to userspace yet,
having to account for the extra timer ref if the timer callback didn't
execute). I don't think adding a timer ref would prevent fatal crashes
on fuse_put_request oversights (unless we also mess up not releasing a
corresponding timer ref  :))

I don't feel that strongly about this though so if you do, I can add
this in for v3.

Thanks,
Joanne

>
> Thanks,
> Bernd

