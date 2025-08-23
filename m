Return-Path: <linux-fsdevel+bounces-58886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D3B32981
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7C89E0896
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2322E62CB;
	Sat, 23 Aug 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y3d3EgDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A621DD0C7
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962254; cv=none; b=AjxnF649xTktolUiKr42YkROljwnJQFnuWGuncQqkbUxRxFQkvVl1A3GsbRbMcDttb0oUOv9o284xLbLQVbeYNSjWAwNCjiiwcXl5ciN+voy/13GVk9qKKfmstKkRwEhixpW8uNopTTxB+1GRrAZ3fZ0pSFhoCMGf34E3H5++mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962254; c=relaxed/simple;
	bh=8gddN4QAHS9UO9USCj5SBZtn10yohbkXCSnNNqxIG34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb0wsIW5XAYgsLa8bd8nCxyO4Unl1TeI6KZgEVhwBsfvOUwTQIatM58L+yL7Emc33Syx8BLd963twzoBhDPv+btXzx0VQCp6ZBfcQk6uDQT1wPm5LdIPQ0lCMfLUcatjTOB31TnHshiAFgtC5NOlOQrqmqCpzYIgMVG7ahYyfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y3d3EgDf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60504db9so23905157b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755962251; x=1756567051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuRxDgISxpxh2GnvxFHQaLERLGxx6pa9QJkvdj6dXFA=;
        b=Y3d3EgDfMMFAfeWUu85nopbtkfZJN0qeDkv2wdqm7qYqNqae0k5J1knswr/W/Ucc7c
         P6/IExNjaRzWRgJyG/YUfM1UGaWHTdM7Jbua0/YhBGbyR/JVH3Iv3qSfHKSCMh3Ee6tT
         li9xjGDYEnk68HRMUKWs9cMJAgAzMnMLTgSYMeIn19Gtnwr7GfTFQQKJpAF+2IbO6AKX
         Wv2nHk5ykiuLy0bzFcsAm0I/x9Q/x8lKFc9aS/nOasEA6jKDkfT5H+0xhS2tMnPw0nPw
         CJ3j31iXh3eQkRkoTp6+8p0LsVNt15IgaFszcqDxXmHP5HF36YvM+zvA/JsgfwKJneWR
         84+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755962251; x=1756567051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuRxDgISxpxh2GnvxFHQaLERLGxx6pa9QJkvdj6dXFA=;
        b=QXi0bji8y2curGSkmCVZJcY6AWq8B/ZvzOd+v+WZr7UbLaGbYhr37A5nUYzuTgwSN8
         kUFt3pZki+uAIbZmEN5nmpi2sp5uh8iHUhG/6GyNmp+49IIGMLzvNRHBDYEtGko2UWUj
         Wg7SloRuQ1n/IK6aaVQdgO3Si/1TwRQM/+uUEmSmZugeR3yiGk2s4N08MHSR8d1U43nR
         J0rrEXBiRobFO6gbnMbI05fKtBIlPLEEkPGFYrzrfXEfVX+ERYguFE9SxVILjCchoyKx
         8txBUyRZr5RQe9UHZndXX7efUgZuYpS0vnBp+eVVBY34j3AnN6lHBFeZfBJgzLEFUH4j
         UjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXj709vWFXTuTPCUC15Ut8mgcFp2bxYvaDUzJWjpWpd3a78gH4Q8hU8pZrxyZaYARok1FkGFKSFG5Fn44ph@vger.kernel.org
X-Gm-Message-State: AOJu0YzingJQYrbb3AtWt0nMi4M6qYr8Non3ABz0inj7IW/cg+GJjZbS
	5UGQjc05FMQI1dDXg3bCxpum6G42d8/grjCwpUr1G/GjhIb77+pNnygcmbbqN0t5DR3O1yceGDA
	levR7DplrDHE3o0p2p9j8JAUwF5XU6C5YQmu4Ki/Xut0pSpX9Uciuaa0w5esLb4f2pA==
X-Gm-Gg: ASbGncsMU37+Sk0i40Nv1L3Rh2SBrye2ddL6cmsIQpF+2s2g9VsLPwN6qO43vkXBIy+
	pyn6+HYBG36L8e7p1r9W2V1K7m7huar6rv3gXZr7YuipsDonuRGK4favct4blL4Z1TLHPEBTPZp
	G7fkxl/VfAVBGy8/y1rUEEhCskCZnYuafmBTB7p8C/IuA+qptY/ZuuCajJv5roGJH9I1nmQNf2K
	J71YoxrWACk
X-Google-Smtp-Source: AGHT+IGfmqDZeqPR9mSevC/rcJ40kyyYwYfMlgm7zFyEEtXeFJRkcrNU7yLh0iiiwELRzs/EafzpuCacOFikh66vbYo=
X-Received: by 2002:a05:690c:6102:b0:71f:f866:bba4 with SMTP id
 00721157ae682-71ff866f374mr19817227b3.17.1755962250487; Sat, 23 Aug 2025
 08:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
 <a3f9e0fd-28fd-41ea-9c78-e3c971e7445c@gmail.com>
In-Reply-To: <a3f9e0fd-28fd-41ea-9c78-e3c971e7445c@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Sat, 23 Aug 2025 23:17:19 +0800
X-Gm-Features: Ac12FXwWa1i1Z_eWULAcABG_D4uLHUyCsSFkbKNqIneaeOcJBr_iJqr2a3VgmDw
Message-ID: <CAHSKhtewVTFTsfnLQwjJeaqg950Rn-_Jde5pQq8knoJaX=XsLQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2025 at 10:09=E2=80=AFPM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> Makes sense, yeah. What about using a shared, long-lived completion
> object (done_acc) inside cgwb_frn. All writeback jobs point to this same
> object via work->done =3D &frn->done_acc.

Well, IMO there's still no method to know which work has finished and
which hasn't. All we know is whether all the work has finished or not,
isn't it?
>
> On 8/23/2025 12:23 PM, Julian Sun wrote:
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 4:08=E2=80=AFPM Giorgi Tchankvetadze
> > <giorgitchankvetadze1997@gmail.com> wrote:
> >> > Hi there. Can we fix this by allowing callers to set work->done =3D
> > NULL > when no completion is desired?
> > No, we can't do that. Because cgwb_frn needs to track the state of wb
> > work by work->done.cnt, if we set work->done =3D Null, then we can not
> > know whether the wb work finished or not. See
> > mem_cgroup_track_foreign_dirty_slowpath() and
> > mem_cgroup_flush_foreign() for details.
> >
> >> The already-existing "if (done)" check in finish_writeback_work() > al=
ready provides the necessary protection, so the change is purely >
> > mechanical. > > > > On 8/23/2025 10:18 AM, Julian Sun wrote: > > Hi, > =
>
> >  > > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> =
wrote: >
> >  >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun >
> >  > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t
> > waitq; > > > > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > >
> > wait_queue_head_t > > itself already allows overriding the wakeup
> > function. > Please look for > > init_wait_func() usages in the tree.
> > Hopefully, that should > contain > > the changes within memcg. > >
> > Well... Yes, I checked this function before, but it can't do the same >
> >  > thing as in the previous email. There are some differences=E2=80=94p=
lease > >
> > check the code in the last email. > > > > First, let's clarify: the key
> > point here is that if we want to remove > > wb_wait_for_completion() an=
d
> > avoid self-freeing, we must not access > > "done" in
> > finish_writeback_work(), otherwise it will cause a UAF. > > However,
> > init_wait_func() can't achieve this. Of course, I also admit > > that
> > the method in the previous email seems a bit odd. > > > > To summarize
> > again, the root causes of the problem here are: > > 1. When memcg is
> > released, it calls wb_wait_for_completion() to > > prevent UAF, which i=
s
> > completely unnecessary=E2=80=94cgwb_frn only needs to > > issue wb work=
 and no
> > need to wait writeback finished. > > 2. The current
> > finish_writeback_work() will definitely dereference > > "done", which
> > may lead to UAF. > > > > Essentially, cgwb_frn introduces a new scenari=
o
> > where no wake-up is > > needed. Therefore, we just need to make
> > finish_writeback_work() not > > dereference "done" and not wake up the
> > waiting thread. However, this > > cannot keep the modifications within
> > memcg... > > > > Please correct me if my understanding is incorrect. >
> >  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun
> > <sunjunchao@bytedance.com> > > > > > > Hi, > > > > On Sat, Aug 23, 2025
> > at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote: > >> > Hello, > > O=
n Fri,
> > Aug 22, 2025 at 04:22:09PM +0800, Julian Sun > > wrote: > > +struct
> > wb_wait_queue_head { > > + wait_queue_head_t waitq; > > > > +
> > wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_t > >
> > itself already allows overriding the wakeup function. > Please look for
> >  > > init_wait_func() usages in the tree. Hopefully, that should >
> > contain > > the changes within memcg. > > Well... Yes, I checked this
> > function before, but it can't do the same > > thing as in the previous
> > email. There are some differences=E2=80=94please > > check the code in =
the last
> > email. > > > > First, let's clarify: the key point here is that if we
> > want to remove > > wb_wait_for_completion() and avoid self-freeing, we
> > must not access > > "done" in finish_writeback_work(), otherwise it wil=
l
> > cause a UAF. > > However, init_wait_func() can't achieve this. Of
> > course, I also admit > > that the method in the previous email seems a
> > bit odd. > > > > To summarize again, the root causes of the problem her=
e
> > are: > > 1. When memcg is released, it calls wb_wait_for_completion() t=
o
> >  > > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only=
 needs to
> >  > > issue wb work and no need to wait writeback finished. > > 2. The
> > current finish_writeback_work() will definitely dereference > > "done",
> > which may lead to UAF. > > > > Essentially, cgwb_frn introduces a new
> > scenario where no wake-up is > > needed. Therefore, we just need to mak=
e
> > finish_writeback_work() not > > dereference "done" and not wake up the
> > waiting thread. However, this > > cannot keep the modifications within
> > memcg... > > > > Please correct me if my understanding is incorrect. >
> >  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun
> > <sunjunchao@bytedance.com> > > > >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

