Return-Path: <linux-fsdevel+bounces-25155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB494979F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF11F220D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF01770F3;
	Tue,  6 Aug 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiZzMJiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC95B1FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969462; cv=none; b=HgZ/2JCZQaBJr4e//sRYN0WhHHY4bm+3xNDHGrJ0gFNGm6cx2XIEeoqCD+WNYx9F4A3/Ms6mWaFXTuAKDRTjOC87uQV+Cj8DfGalQpcper9OPxnWH3djBxtPU6zKiruFr8bZOyFMdU1XyW26ScGnzVNb3dFvk6H01wCu42C2aIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969462; c=relaxed/simple;
	bh=QV/HCX1ik303wns+PkOcQgI3Cs8a6bznzgKLK+XURsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rY3XbrGCJoEXCov1+vzYmMnIvPJoXnGH27AKbk0c/637yB9AmANORDaZMzP7pdwGHH/FXwH54wzHk8DEI99u7Hxe3ugvmyx7wOhxgfMsf5wVh5E5dGmU+zZ5JNTmOaS1prjLmzbEKhdnaH4mwHyEOArE7zpROCL8mXvU4PAm1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiZzMJiw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so1227962e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722969459; x=1723574259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lzAV7Irx5BVWIJpNZSPydhqmdINFYyLN2grijtgPFY=;
        b=AiZzMJiwsKnKphKsV2PXDYssQbjjPnosWTQSKs8WQn3tuH6HABLvgYki8H1T0Tc9nt
         2UqSWioyGYjzNsOsISKw/S1E9/hEPh2VfdOZLQq/kUfCpRWI2za0CXIB4bj1NPK0w8MF
         IPDxomXRe/3y0g7Zgq3+GGALt5afF3Xcsl/XQ8BAdaih98GDdbRTD/WEmVFxxeSZ827b
         WerzcgdlMOW8m6kgVvB0cGYT7wv5vQUS7EM7ehl6l9HuFAQFR413DRQpPahq1YH8gE2e
         wOY1oJZuH1qntZVw2ivlh2T64A29u3EFyoUd6d3r8rQQLev5A6tpRRYHnjRsShJZxush
         78Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722969459; x=1723574259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lzAV7Irx5BVWIJpNZSPydhqmdINFYyLN2grijtgPFY=;
        b=C5tRpcIM3rCOrJEEiVR+Rd1PpEZpdwQXeuw+EId2+Qo2/enCZl3lzSgxGKNOD6Y9z/
         ClLSzKFQwZLF43ERinaBqkPNnqRCR2Z++mX3CeadGqP/vJG1PKvAH9YewFdQIsChzwi5
         pOgV4mOFpzVEEmZzA9Za1CWkpA4i66JJjE4HgeBH1m1YJEXJQ+SoDMe2yfpx/yqfennn
         KUY5p9jW8Qxkpj9JJT5hNax/3MXpvsmNkwKVBi5q3SGKc1oc0d2C52jGKqEFEkJhhxFz
         qSbm6sq1iUBqDzVy/77B6Nc1DDpv6Rxdq7l/YGJAzfanlLFyT5W0DdJm5SjfwJOspsV7
         MrQw==
X-Forwarded-Encrypted: i=1; AJvYcCV83z7MpCAKd2cDYaXmNNsHO/N5vVd0JhRIwCJunrBBfYNKYyQAP7cFGcB8Q6RQXYf0gdsxgQyI95jUTVZubfTVXAeQIDt2u8tVSTNTig==
X-Gm-Message-State: AOJu0YwxpjxLLXON2mWIzT8KCvpdHJCi0qVriKbQtBZ6JI01lYEVyLOP
	fDmt0DDe0zOvuZiTEl2bJtFEc7WcwW6knzh1h5f0DuH9DahzPKrcCW2dLcAyErAmfW1CGF1Wzrp
	prlDkQgzQVfyxz58kaTuwVWHOdE8=
X-Google-Smtp-Source: AGHT+IH+V/gM8opdyf0D6CfajM//6TW1dr5metqAfx5bhqKe0BblFdybOZIHLxwvHPaMs8CpNtC/8KVK8EF1SEyQgZ8=
X-Received: by 2002:a05:6512:3b8b:b0:530:ae0d:9fc8 with SMTP id
 2adb3069b0e04-530bb36b6bcmr12078482e87.2.1722969458597; Tue, 06 Aug 2024
 11:37:38 -0700 (PDT)
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
 <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com>
 <d3b42254-3cd0-41f9-8cc1-fd528c150da2@fastmail.fm> <CAJnrk1YVvyv9pEddeKBvisqu5O7z_WtoEhUSzmJmxpCX0UaDWw@mail.gmail.com>
In-Reply-To: <CAJnrk1YVvyv9pEddeKBvisqu5O7z_WtoEhUSzmJmxpCX0UaDWw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Aug 2024 11:37:25 -0700
Message-ID: <CAJnrk1ah5KP97A6o6kGa+CJE_hwdM1knTfniiwEqsyMGW0A3ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Yafang Shao <laoar.shao@gmail.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:26=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Aug 6, 2024 at 10:11=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > On 8/6/24 18:23, Joanne Koong wrote:
> >
> > >>
> > >> This is very interesting. These logs (and the ones above with the
> > >> lxcfs server running concurrently) are showing that the read request
> > >> was freed but not through the do_fuse_request_end path. It's weird
> > >> that fuse_simple_request reached fuse_put_request without
> > >> do_fuse_request_end having been called (which is the only place wher=
e
> > >> FR_FINISHED gets set and wakes up the wait events in
> > >> request_wait_answer).
> > >>
> > >> I'll take a deeper look tomorrow and try to make more sense of it.
> > >
> > > Finally realized what's happening!
> > > When we kill the cat program, if the request hasn't been sent out to
> > > userspace yet when the fatal signal interrupts the
> > > wait_event_interruptible and wait_event_killable in
> > > request_wait_answer(), this will clean up the request manually (not
> > > through the fuse_request_end() path), which doesn't delete the timer.
> > >
> > > I'll fix this for v3.
> > >
> > > Thank you for surfacing this and it would be much appreciated if you
> > > could test out v3 when it's submitted to make sure.
> >
> > It is still just a suggestion, but if the timer would have its own ref,
> > any oversight of another fuse_put_request wouldn't be fatal.
> >
>
> Thanks for the suggestion. My main concerns are whether it's worth the
> extra (minimal?) performance penalty for something that's not strictly
> needed and whether it ends up adding more of a burden to keep track of
> the timer ref (eg in error handling like the case above where the
> fatal signal is for a request that hasn't been sent to userspace yet,
> having to account for the extra timer ref if the timer callback didn't
> execute). I don't think adding a timer ref would prevent fatal crashes
> on fuse_put_request oversights (unless we also mess up not releasing a
> corresponding timer ref  :))

I amend this last sentence - I just realized your point about the
fatal crashes is that if we accidentally miss a fuse_put_request
altogether, we'd also miss releasing the timer ref in that path, which
means the timer callback would be the one releasing the last ref.

>
> I don't feel that strongly about this though so if you do, I can add
> this in for v3.
>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd

