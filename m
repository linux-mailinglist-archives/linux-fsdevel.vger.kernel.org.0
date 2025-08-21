Return-Path: <linux-fsdevel+bounces-58631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C342CB301D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC16AC71FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6174719EED3;
	Thu, 21 Aug 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DO6sQ6VL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71520E6E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800177; cv=none; b=Bb9t9dc9iOIgziX0i/7cZ6JKyBWBY0gN3EqOjO5WWM3eUIMazBeZsx9khLNpMaqSG1RPnp8yuiTmVzROXEpei2bmIVyJagnVt5vNUIQcscL7xTDWyqXfzUznpdr4Jo1qmGao3hrDzTyuy0TUcEzVUlghviYOVdomhYw7+3PuLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800177; c=relaxed/simple;
	bh=hDqzdK67aNuhe/bUVwwb1jo/Xv67HuCol2GYLCffAlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiA4Jx9c0SBB3/7VZno7ML/XplW5jh6BtLL6zoH4tBL6SVgjupMEaX3bGszPP99yUtzuZ1uq7oqJDAU8x5PkFfY9PAcVb65YuU8/C3wlmIn0K5A9OGtXlx1Aa2f3P4vuND9M9pKRydlwkLiugcd88+WdAtnpo/vZno5b6nGcVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DO6sQ6VL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e9503150139so1323509276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755800175; x=1756404975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9/oELP0413f2vQDazoVmFhVHsn1S2Y0CDApUKooico=;
        b=DO6sQ6VLrZ2y34udapCOaqDFEMSQXBRI5J3F3Nobtx8NNx9pf8i7c1/fxXMozLyvoX
         nZ852/ok5X1SPmDy0Mp4ywPwffifAGXlSU2Bh3cDow/VXp7D+1mJpD/pmLXeK2cNcJeL
         ojfUShDeXlDNIuhAw8yQnHTd68rocy6xDOVGfm1/48llE2AaRI1ezHzGSpiYoah9XcYY
         eF6quS1dPXcYzhWmCBf/WiwE1hX3fLUp5eT5gCBBIDRopQJvBfdeQ8fryJMuc+8rV78A
         ydTMa6eeH++V7QnTox4TLqNRHBYbpjjHrp0Ii4FlTH+YWziDg//gFxvvdt7nZkjMjSYI
         oQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800175; x=1756404975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9/oELP0413f2vQDazoVmFhVHsn1S2Y0CDApUKooico=;
        b=oU5PEyrP7pNLGXrqnyUq4Zswo4sgSLRE9y9LZWqIA0q5vDpv61FoE1Yym4pP0Dhz1X
         0ni5n7JLNSMg/9DGNyeoLfE/vFOCsEEHhlq77SggPScP2euvNgrEqJJDU5yGeFfuY671
         BdElu6lTtWVylB5Q7bof98JwSNXRB/6YoGxulTzexnFkHqPlFgv7mtL6eK2fwGUCDuSC
         CIGC5iB3RYhu/JXnJSdwKDZZZWqnkWzhYhIk630SwBB1lL4GhwX/wZ52605uBQf6v5Cc
         XY9KsUHziC5OhQMKuxM12Zn2WECx2uwH5/Co3o9Dfn3ugAo3YCEx/I/YnnTh9Y73ykzm
         GRQw==
X-Gm-Message-State: AOJu0Ywck+Nr6fuJBv1E2CmORI5vEpZKNARHHAfkWKyaZl38sM3CK2aZ
	fVQAHaaF5xhwWScZPKEVC0nCR8M21DBNmchl2BYro5wuEqfS7wD0jACjDvyz17Mo6Y7qU2xwu9b
	bKow7eSR0AwvacWy6Jv2GHIG2Ws52Dnw1zIcuzcnUO1REqCJuYnBg7SfjBgjArehVdw==
X-Gm-Gg: ASbGncttYXoxJrSE9+4qesOoSGcs6yAcUD1zqX+ya1FUBEhotTSrdYZmkwA3DP2aAKu
	JRE+0ILvH3Ts7DEY6RmvfyF3OnH7y/Gz9m3+mZPIKYd1xEdHgTR0IAH1GZ8hKq8vv1I6G1jmWxb
	Z5T64xh7Gry0zhCl8V/jEQktN5I3c5tp9VZDSIhCGgMUecs4GzvBnH/XOb7yPBcxhbwVjqa7E73
	mU3sGJzzQYN7uQUapQjdow=
X-Google-Smtp-Source: AGHT+IE3bh28/Gt8RcxbTvDGB2ZwCKqcAEFwLVbLaQ1ETaz0DQgFhU7c2HeE+tfwYm/vwZ38OnbEAKkCkSN20XXIc+A=
X-Received: by 2002:a05:6902:2086:b0:e95:16fe:f257 with SMTP id
 3f1490d57ef6-e951c2e8178mr706872276.15.1755800174337; Thu, 21 Aug 2025
 11:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org> <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
In-Reply-To: <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Fri, 22 Aug 2025 02:16:00 +0800
X-Gm-Features: Ac12FXzSKuEp-w5_Lomw3unO-QADLCAsMZrvOlvz_slkZscwz7__XKmzGfNsSag
Message-ID: <CAHSKhtcxL0qN2M_yfA7N3yF1JrzRaMafQ+fnjmFzaxPCLSda0g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:00=E2=80=AFAM Julian Sun <sunjunchao@bytedance.co=
m> wrote:
>
> Hi,
>
> On Fri, Aug 22, 2025 at 12:59=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Aug 21, 2025 at 10:30:30AM +0800, Julian Sun wrote:
> > > On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wro=
te:
> > > >
> > > > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgr=
oup_subsys_state *css)
> > > > >       int __maybe_unused i;
> > > > >
> > > > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > > > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > > > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > > > +             struct wb_completion *done =3D memcg->cgwb_frn[i].d=
one;
> > > > > +
> > > > > +             if (atomic_dec_and_test(&done->cnt))
> > > > > +                     kfree(done);
> > > > > +     }
> > > > >  #endif
> > > >
> > > > Can't you just remove done? I don't think it's doing anything after=
 your
> > > > changes anyway.
> > >
> > > Thanks for your review.
> > >
> > > AFAICT done is also used to track free slots in
> > > mem_cgroup_track_foreign_dirty_slowpath() and
> > > mem_cgroup_flush_foreign(), otherwise we have no method to know which
> > > one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> > >
> > > Am I missing something?
> >
> > No, I missed that. I don't think we need to add extra mechanisms in wb =
for
> > this tho. How about shifting wb_wait_for_completion() and kfree(memcg) =
into
> > a separate function and punt those to a separate work item? That's goin=
g to
> > be a small self-contained change in memcg.
> >
>
> Do you mean logic like this?
>
>     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
>         wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>     kfree(memcg);
>
> But there still exist task hang issues as long as
> wb_wait_for_completion() exists.
> I think the scope of impact of the current changes should be
> manageable. I have checked all the other places where wb_queue_work()
> is called, and their free_done values are all 0, and I also tested
> this patch with the reproducer in [1] with kasan and kmemleak enabled.
> The test result looks fine, so this should not have a significant
> impact.

BTW, the test case is like this =E2=80=94 it ran for over a night.
    while true; do ./repro.sh && sleep 300 && ./stop.sh; done

sjc@debian:~/linux$ cat stop.sh
#!/bin/bash
#

TEST=3D/sys/fs/cgroup/test
A=3D$TEST/A
B=3D$TEST/B
echo "-memory" > $TEST/cgroup.subtree_control
pkill write-range

sync
sleep 5
sync
sleep 5
echo 3 > /proc/sys/vm/drop_caches

rmdir $A $B

> What do you think?
>
> [1]: https://lore.kernel.org/all/20190821210235.GN2263813@devbig004.ftw2.=
facebook.com/
> > Thanks.
> >
> > --
> > tejun
>
>
> Thanks,
> --
> Julian Sun <sunjunchao@bytedance.com>


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

