Return-Path: <linux-fsdevel+bounces-58878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE7B3279B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3621C80431
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D302356BC;
	Sat, 23 Aug 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dhgw3tS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF65150997
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937392; cv=none; b=jwpPHK7ncpvh1QdZXUfqLVwPLygpK5bzvuUrUHZ8Uy/fIR5pMQmnVUlXP+BFS8cjTz295fqLDRq/3DvIfcvsZGgI5VG03feNDmnBGVtaCcCQ0frTshE5P/jBMxLEpyZwTSIQ9zrHLJJ9mFW8dQobvPcRVkQXUmk8jNyBM0XGMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937392; c=relaxed/simple;
	bh=0YFVWJ6mEe6+mn0X64o0CABy88FGkC9zJTxkoaKV3IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hm2Iwm/SFXYkcLLwTgAdX3aBsFWfWA5Ku+/dOX9dd/c3D4VZT2DtAnEYLsHNnwQpFvhtJTxkM1g/MRdvvvfs1wYh52TYgxJ3dcF5EFc2xDFNzhk+1qA5S3p+ncDvkJCPBvJhor6YERxoND+RWkqFaDjh4wlkMfIIxXwcByToNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dhgw3tS+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e951f2eddf0so1239855276.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755937388; x=1756542188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ECUzsLpIGLfSNANJzOpUlmNgO6Xf1gnfi/48aM/B14=;
        b=Dhgw3tS+SvAzJux3hluqYJKg7APtQ8TJ/1Fq5DdVm25l75SwrR2kHrsB55ytJQ9Zzv
         4IEir0wJa3+zVIHK78a/zeNvREH0WzBTheId471/fshWK0oIfUtZ9ZCgLw7Uhfr3ke3o
         iUt6Earv4gBcScQ1E59H0lkqiyTQaNevKyVKp39CTX/IkbJOClRpHOeYwas404VktLE4
         BaenDxDLAQ/pISyebGhWCaEdVIQKyXEYe/XdeYleu9w5P+FWN8EYcxzCLKYkp9ZfQFLy
         S/9SxE/HooS077EbnnSAvSgmNtgVvvWmZYNPK8eLLuPpcli2LWuBljW12D2SRYqXFYH9
         PKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755937388; x=1756542188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ECUzsLpIGLfSNANJzOpUlmNgO6Xf1gnfi/48aM/B14=;
        b=qV3CQrmq/cmfkXsdSIgzhDzVW4pnGiXrljbk5BbpjjcnTpkJxhokJAszaJ0j5WLXF0
         qiXZZXV4EbGT0ecDDo72VrLAALLRJpXaEqJghsq7lqyLcb5xJEykVTx6nrFa4kGltcZk
         zHuv86rRuaaaFkYntP4+fhPxWKuJ0D06X2S3ElTNa/LBb95yh3tUOw65vuzYIN3ZL38+
         NuWpKVuvrOqo0eVipUC+hUgtgHh7VMFBj9mIZ+UABs5WqEPXBdMJXQs5pu66RhVZ+95g
         xweUZJu99uEslm1I/sIvQ1VvCHYooZmhn5PMoV/RnnTpeENE2+6B728CV30QZq+sWQmI
         debA==
X-Forwarded-Encrypted: i=1; AJvYcCVclGqMIuKXtVHHaCQSMcTAC+CLJ2Rcy3vozSG0WOj/SeC3GVw0HevagzCy3oZofVTOkbUOmUtHJS1nwCx1@vger.kernel.org
X-Gm-Message-State: AOJu0Yznqa6sHajUQq3wVXm0AskM29qvYo5J7mPVoNZRCytjOlvDrdsx
	PMQMW9RBbdujio/sQUdPnVLMigzjUbEwX+j7qcPjNnEWw0QmR9KpnvXwUvULmbhc2d0J+hZRjWr
	v+aeUcmETkpgkJyYcQFC67+UrCjwuDjyuOBzSDZZBzg==
X-Gm-Gg: ASbGnctwvj1pYpUgMpc2hQvuvcSdRQi0Pbs1Vd+HJSa+3m9lS8DUEilJHfPAaYBywQF
	M5ZcAT5cfqjuGnBn77TLM8+Kn2vt41cb5hzfJqjBD4S9gtOTfQTuYMghlH65qbPA7kXJq81D94a
	+Ha1GL0/pApL9098gws2ieGjlY5JgDXaVIyOHvOksWhCSNW2APlwNM3TZuCWaLNamJfc/cnPwWL
	ccMHKDGtyIi
X-Google-Smtp-Source: AGHT+IH0BVIyZiw5bWrCKqslz5gV80c6AufAKs2rnSguLnlMSKmrPRYkojH4j4/wRFQ/wNMvYf2Fi3seu0hZ9/B27eE=
X-Received: by 2002:a05:690c:4c09:b0:719:f37e:e69c with SMTP id
 00721157ae682-71fdc421889mr66924497b3.36.1755937388335; Sat, 23 Aug 2025
 01:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHSKhtebXWE5m0RcesWe_w2z1Gpqt1n5X0wuE9oD1tX6VxztUg@mail.gmail.com>
 <76a95839-00b1-43b8-af78-af4da8a2941c@gmail.com>
In-Reply-To: <76a95839-00b1-43b8-af78-af4da8a2941c@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Sat, 23 Aug 2025 16:22:57 +0800
X-Gm-Features: Ac12FXyXLbqkgSJ552CB_VB52RDuHyiA8g2c5o9dPYHcJpfZiX_QPTNVRfVvNBQ
Message-ID: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
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

On Sat, Aug 23, 2025 at 4:08=E2=80=AFPM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> Hi there. Can we fix this by allowing callers to set work->done =3D NULL
> when no completion is desired?

No, we can't do that. Because cgwb_frn needs to track the state of wb
work by work->done.cnt, if we set work->done =3D Null, then we can not
know whether the wb work finished or not. See
mem_cgroup_track_foreign_dirty_slowpath() and
mem_cgroup_flush_foreign() for details.

> The already-existing "if (done)" check in finish_writeback_work()
> already provides the necessary protection, so the change is purely
> mechanical.
>
>
>
> On 8/23/2025 10:18 AM, Julian Sun wrote:
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun
> > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; =
>
> >  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_=
t
> > itself already allows overriding the wakeup function. > Please look for
> > init_wait_func() usages in the tree. Hopefully, that should > contain
> > the changes within memcg.
> > Well... Yes, I checked this function before, but it can't do the same
> > thing as in the previous email. There are some differences=E2=80=94plea=
se
> > check the code in the last email.
> >
> > First, let's clarify: the key point here is that if we want to remove
> > wb_wait_for_completion() and avoid self-freeing, we must not access
> > "done" in finish_writeback_work(), otherwise it will cause a UAF.
> > However, init_wait_func() can't achieve this. Of course, I also admit
> > that the method in the previous email seems a bit odd.
> >
> > To summarize again, the root causes of the problem here are:
> > 1. When memcg is released, it calls wb_wait_for_completion() to
> > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only need=
s to
> > issue wb work and no need to wait writeback finished.
> > 2. The current finish_writeback_work() will definitely dereference
> > "done", which may lead to UAF.
> >
> > Essentially, cgwb_frn introduces a new scenario where no wake-up is
> > needed. Therefore, we just need to make finish_writeback_work() not
> > dereference "done" and not wake up the waiting thread. However, this
> > cannot keep the modifications within memcg...
> >
> > Please correct me if my understanding is incorrect.
> >> > Thanks. > > -- > tejun
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>
>
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun
> > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t waitq; =
>
> >  > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_=
t
> > itself already allows overriding the wakeup function. > Please look for
> > init_wait_func() usages in the tree. Hopefully, that should > contain
> > the changes within memcg.
> > Well... Yes, I checked this function before, but it can't do the same
> > thing as in the previous email. There are some differences=E2=80=94plea=
se
> > check the code in the last email.
> >
> > First, let's clarify: the key point here is that if we want to remove
> > wb_wait_for_completion() and avoid self-freeing, we must not access
> > "done" in finish_writeback_work(), otherwise it will cause a UAF.
> > However, init_wait_func() can't achieve this. Of course, I also admit
> > that the method in the previous email seems a bit odd.
> >
> > To summarize again, the root causes of the problem here are:
> > 1. When memcg is released, it calls wb_wait_for_completion() to
> > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only need=
s to
> > issue wb work and no need to wait writeback finished.
> > 2. The current finish_writeback_work() will definitely dereference
> > "done", which may lead to UAF.
> >
> > Essentially, cgwb_frn introduces a new scenario where no wake-up is
> > needed. Therefore, we just need to make finish_writeback_work() not
> > dereference "done" and not wake up the waiting thread. However, this
> > cannot keep the modifications within memcg...
> >
> > Please correct me if my understanding is incorrect.
> >> > Thanks. > > -- > tejun
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

