Return-Path: <linux-fsdevel+bounces-58630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E4B3019A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFEEAC049B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E43431F2;
	Thu, 21 Aug 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wx6OpSke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E92FB639
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799225; cv=none; b=f9qxYz3yqOjuDToCWXPjezjRvSfd+sg18iXBrW1P/g/yY0LpXzeZbM1ee+/odVNeIfwGVNKQeDupjKoZB6f+1mP5u2SVZP2T/KwO95uICwcnwDrehBbG0/z07uXUBFbN8gNiaPdR7TzayDyae0HT1EcEn1IW8Eoxe2y+xQrGhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799225; c=relaxed/simple;
	bh=2IBX6VJaYzIt3d8MSLKvykSIMbupgv/nCD5znMsyLf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMeCcZEBeyF5ltidthLZ8IP5MTA1B/xh0xQY5whNXEwSGvKZIMUYgpR2OFhqhu1d2lDYQWmW/d53Gu8DPcjEGp8YnhEAjFLGDGj2TNErrmlHy95yQYYajJqIEgfuKBxx4PsGhOdLqYuGrmGoMM5OwNj4RmiwCG5WBm+Ymc7W4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wx6OpSke; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e93498d436dso1305262276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755799221; x=1756404021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lia9zAzQkMkj0u6l/RsjUG2VG0X8+ajRHGScPdguQ=;
        b=Wx6OpSkep5WbG02axiChwnA6yhuDLwR7Q/b5tcRB9gZzMc5FuHDQbdKz4abnCyR1H2
         PGfdScqC0DT9ymNLeXnkQ1QJf/Xt6KCETxwolUP7NpZ+Da3QZ5vZkQ/fLUr3BW6VegWO
         9PRVLxZO1ntqvcUNaUBfk6OSO3cNQ/xUAmdI78QMUOqUJu4Q8wBWUAUUTr2x+BrHUlHY
         soQKF+El42/3tEPKUJW0Kd4WDY8jA7mmHAAnalx8HTcCGCY1tQuQ+o4llCxuOvafPYEe
         /2fxmx+yq87c+pthNnzoN0Q2IAfGbpv5IaNEBAc9R9VywPp/HYS8Hkj7/Bhdy8OnTASG
         IhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799221; x=1756404021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lia9zAzQkMkj0u6l/RsjUG2VG0X8+ajRHGScPdguQ=;
        b=cIrqAqME1vqMjUkAeIE6HTYQ3w3PRHW9eFYmd601ZzzJPf0R1uU3WiF3uzuGgE55rU
         gVXJmekk7I3mBd3NeUq24SixAlqW4dt9m00HCtoAEElD92/mfIO5mSOR0Ziw8Jr2XEln
         8Y8X/R+Et5s29AOkdNSY8KiCmXEHvMmPt2tRJwd3fzcGJ7B0Ud0UN2qCb3BCbS/zNJr7
         hC5lLozGQuN2zWp94kf/mp7ug8tym5ZhfQ02P4qNlLKeK0RxLVuzIscsfn+Sw5pAaXv9
         vtB3Zx2Z/D0RA4/VBtfSELUyUnnYHucGXORTHceMnwIbEZPYAO4gc+kxdAfq3/DXkSii
         /Csw==
X-Gm-Message-State: AOJu0Yyw5u5K6cneLyfjM0kaMUMmVfcfYrXHS40tLkAMI2cRTns+iKXY
	2jFDsS6/YNqZN29GzTqkCekONxbR50Q8G5WfMYEtG7XWA98IlDC1+azVpLT/Qg1hheEnw/lm00M
	ef31BTDfx1CsPLjVZHrKlnC4KDUUfDH9c0cNFjMZ6skHGGvTtQE/JKmR4HJ9m3LiyTt7zw/g=
X-Gm-Gg: ASbGnctPV6VFgX98FmZ7ESZZkNgnTOKy/gXX9ksILF5nfRyCmws1tRNhTguzAO23QgZ
	yDRArLnve1SOuKmHzKBSKnSkHWCMdvwxN9CxD0tJU4mk6vj4CRmCwIx19CaLP/SJDX3ygbDLA13
	0TxoheH7WLvnWkoJtgH6aj4HZ7QPN57zD7tGsGSbm9T6+Zh6OjMI6c+Pnf/uFGnardGW+S3wkla
	SjKRP1TVuIF
X-Google-Smtp-Source: AGHT+IHZiFSlHaDYSx8oxyHmCj/KbihWFMT9IF+j+/jr/Ilj6ZzdxoI20FyXRZA9RZCJDjjSM6r7mSJmwQpFWryxS5s=
X-Received: by 2002:a05:6902:3411:b0:e90:6c6c:dc3a with SMTP id
 3f1490d57ef6-e951c33207dmr490273276.34.1755799221387; Thu, 21 Aug 2025
 11:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com> <aKdQgIvZcVCJWMXl@slm.duckdns.org>
In-Reply-To: <aKdQgIvZcVCJWMXl@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Fri, 22 Aug 2025 02:00:10 +0800
X-Gm-Features: Ac12FXwQ52FAG0PW2wUzBrp0izeD42MUA03rmCmMwjxx7EXlVIqi8U_EajVPCpg
Message-ID: <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 22, 2025 at 12:59=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 21, 2025 at 10:30:30AM +0800, Julian Sun wrote:
> > On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgrou=
p_subsys_state *css)
> > > >       int __maybe_unused i;
> > > >
> > > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > > +             struct wb_completion *done =3D memcg->cgwb_frn[i].don=
e;
> > > > +
> > > > +             if (atomic_dec_and_test(&done->cnt))
> > > > +                     kfree(done);
> > > > +     }
> > > >  #endif
> > >
> > > Can't you just remove done? I don't think it's doing anything after y=
our
> > > changes anyway.
> >
> > Thanks for your review.
> >
> > AFAICT done is also used to track free slots in
> > mem_cgroup_track_foreign_dirty_slowpath() and
> > mem_cgroup_flush_foreign(), otherwise we have no method to know which
> > one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> >
> > Am I missing something?
>
> No, I missed that. I don't think we need to add extra mechanisms in wb fo=
r
> this tho. How about shifting wb_wait_for_completion() and kfree(memcg) in=
to
> a separate function and punt those to a separate work item? That's going =
to
> be a small self-contained change in memcg.
>

Do you mean logic like this?

    for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
        wb_wait_for_completion(&memcg->cgwb_frn[i].done);
    kfree(memcg);

But there still exist task hang issues as long as
wb_wait_for_completion() exists.
I think the scope of impact of the current changes should be
manageable. I have checked all the other places where wb_queue_work()
is called, and their free_done values are all 0, and I also tested
this patch with the reproducer in [1] with kasan and kmemleak enabled.
The test result looks fine, so this should not have a significant
impact.
What do you think?

[1]: https://lore.kernel.org/all/20190821210235.GN2263813@devbig004.ftw2.fa=
cebook.com/
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

