Return-Path: <linux-fsdevel+bounces-12179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1585C64D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E03A2841C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032E2151CCC;
	Tue, 20 Feb 2024 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpASEgxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474D1509BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462780; cv=none; b=UdojBiLUa4X6j7ZOkk1srQq5ZzeiKmAF7RoBDEb5HEdSNHr+rCnKULd/Ni57ea9ly6xg/JkYU57/FooauAB+oyaenF8t9GyKeAlGCmsHZsmm0AHadrf2Tq4zqD3ennI4bhPsCwfuhC+vIFzCoHmmakt1raJZ3Op6lf6lQAu4YHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462780; c=relaxed/simple;
	bh=lAWvibZYCLZJ18pHlosxEIJ4ZpAXKtZDbRFFnu5UjNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N86mFZRQNikAf0N9/AqkhPhphzfotHJaGmX3vAOkAV6bAxWULVaZ14mi3JRYQdp4unTO36wdsR5giUxasZHnTCENi+U7Ra4kqlB5z/WVoydmLgDXY4HwAfbjSPzQ6+pPK41mMo84puhGA1zj2QEkA0oi0NTZTslvJPBj/sDXB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpASEgxw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6080a3eecd4so39484977b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708462777; x=1709067577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAWvibZYCLZJ18pHlosxEIJ4ZpAXKtZDbRFFnu5UjNY=;
        b=RpASEgxwkOgocmvj8fdC72Q+wuzIgJgO+as12KY3i+3OKhqA0Ur+2USxl5/WxSw7GT
         n/AMBdCT+NTGrnnWMXZNONo+JRE2hKpdLW4UQg+45cK1Vr17TS6vIb4n2/DhEHIy4d7e
         viLLUOpZyT8mEju/VwiV32CdbT3D3Db5FmEh33LidWpziEM3Xm6EyhVWeEmbumCQVMwh
         3EvUT49/Gu+st7rv1CM9V40ySq27BReRViIotx1s9womXle68aBdsps1pt5ryPw3uboK
         Wu/FLi2Y7MjnzUpQD8y9evXWvjXFJw41+uWmmnpaTaYrNcDOQLMgcV4e9aA76TuP0gVN
         ICIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462777; x=1709067577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAWvibZYCLZJ18pHlosxEIJ4ZpAXKtZDbRFFnu5UjNY=;
        b=qPx0kodcGGRLo93f+tC+WxB+LDejEzkf+2NvcVzYeAfIVO3mDjVDBlw6XAU0BYPT8w
         JGXTpRUTZ4+mWt35UXV6N+G1sU39c6BwFZn73tsbkXncRWuf91WNUIRj8vN3jdG9me1D
         fi5zrdwZ1d9MHrAqkdwQXsdej582QlYXP5/QvM7tTNO+RkRf4hfM7lp75ydOSZ6WaeL5
         CHzyy1tRxZsdOaa4yKaQoq52To364c66I+dSuNNB8I3j6wzMKw1zLv6oG4ctsdCxgYTr
         VBiih0YbzHbx3i6cn+VksNeYF9ptLbQWGf49YNS07ky0g7AM2Df8W8zKZ/TZ4R2UnZ60
         TBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVymvIIyyjE2KhwaUyS+Dv+53ZR4bKI9oiozI7CU02OtzUyyVnHZzS7+W8i0lowHIwpBZk/s/Kms3aoPtRzbmWjy5tCwkqSjqQdX2o9rw==
X-Gm-Message-State: AOJu0YyXYLxkXhtFGaK3yNojznw2MP4NhXn9Ud/eCjLH6fvvV2/RA85q
	z5iRBiZhNDeLLUecBF301p+byKDeCSKjPDIS6xsyY7J9GCxyM2GXH9s6tHEF4no22m+5TTeBfSG
	0e97jE9ubt3QQ1aZuHi7GxF9vKFYVOMWQQRTR
X-Google-Smtp-Source: AGHT+IEUBep3JbSfIFxIrjxLVKPObAawmbo2MZhL9tIpGGThj6+3JFdPMLwKRYjCckQD2YbEpyoHbPFSy5F0AEYQhEA=
X-Received: by 2002:a81:7c55:0:b0:607:910c:9cb3 with SMTP id
 x82-20020a817c55000000b00607910c9cb3mr16089286ywc.36.1708462776952; Tue, 20
 Feb 2024 12:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz> <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home> <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home> <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com> <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz>
In-Reply-To: <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Feb 2024 12:59:23 -0800
Message-ID: <CAJuCfpFYAnDcyBtnPK_fc6PmFMJ6B4OqS=F7-QTidZ+QtJQx1A@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 10:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 2/19/24 18:17, Suren Baghdasaryan wrote:
> > On Thu, Feb 15, 2024 at 3:56=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> >>
> >> On Thu, Feb 15, 2024 at 06:27:29PM -0500, Steven Rostedt wrote:
> >> > All this, and we are still worried about 4k for useful debugging :-/
> >
> > I was planning to refactor this function to print one record at a time
> > with a smaller buffer but after discussing with Kent, he has plans to
> > reuse this function and having the report in one buffer is needed for
> > that.
>
> We are printing to console, AFAICS all the code involved uses plain print=
k()
> I think it would be way easier to have a function using printk() for this
> use case than the seq_buf which is more suitable for /proc and friends. T=
hen
> all concerns about buffers would be gone. It wouldn't be that much of a c=
ode
> duplication?

Ok, after discussing this with Kent, I'll change this patch to provide
a function returning N top consumers (the array and N will be provided
by the caller) and then we can print one record at a time with much
less memory needed. That should address reusability concerns, will use
memory more efficiently and will allow for more flexibility (more/less
than 10 records if needed).
Thanks for the feedback, everyone!

>
> >> Every additional 4k still needs justification. And whether we burn a
> >> reserve on this will have no observable effect on user output in
> >> remotely normal situations; if this allocation ever fails, we've alrea=
dy
> >> been in an OOM situation for awhile and we've already printed out this
> >> report many times, with less memory pressure where the allocation woul=
d
> >> have succeeded.
> >
> > I'm not sure this claim will always be true, specifically in the case
> > of low-end devices with relatively low amounts of reserves and in the
>
> That's right, GFP_ATOMIC failures can easily happen without prior OOMs.
> Consider a system where userspace allocations fill the memory as they
> usually do, up to high watermark. Then a burst of packets is received and
> handled by GFP_ATOMIC allocations that deplete the reserves and can't cau=
se
> OOMs (OOM is when we fail to reclaim anything, but we are allocating from=
 a
> context that can't reclaim), so the very first report would be an GFP_ATO=
MIC
> failure and now it can't allocate that buffer for printing.
>
> I'm sure more such scenarios exist, Cc: Tetsuo who I recall was an expert=
 on
> this topic.
>
> > presence of a possible quick memory usage spike. We should also
> > consider a case when panic_on_oom is set. All we get is one OOM
> > report, so we get only one chance to capture this report. In any case,
> > I don't yet have data to prove or disprove this claim but it will be
> > interesting to test it with data from the field once the feature is
> > deployed.
> >
> > For now I think with Vlastimil's __GFP_NOWARN suggestion the code
> > becomes safe and the only risk is to lose this report. If we get cases
> > with reports missing this data, we can easily change to reserved
> > memory.
>

