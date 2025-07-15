Return-Path: <linux-fsdevel+bounces-55005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627CB064E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B58D4E6BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85127FB28;
	Tue, 15 Jul 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFl0h5jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28D1DE4E1;
	Tue, 15 Jul 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599166; cv=none; b=qXfDkfGBtJebg+NZJZubsTsoY3h6heYdUJqmnqZJSdXfvjZSp2Kb3MviFsVi70r6xFVUa+rpFWoAz9lblDnTLVfWFmMO1ECpM2UoriXxAQrWk4zmbLh1rb4powkZUnQUfWesryPgjfeEsj8vEooDU9MhcKGIeywAT1HpirTv2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599166; c=relaxed/simple;
	bh=nNVdOuKoan23VnHElyXa1O9OQOwkYvq2YE9Vv0XlCJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipqHA1cFkJ6RSH/b02qUgHQeW+eCSFijwl0y/owiyD/16ZRHvL1W7Fi2QJ0gZ/1Md+fLvT8HsRH/BScYXY+SiIKCBaTaT37zsDxYivBZ1KLvlLrJMUQ2G0uszFT1dpMDXo3E4Na5LNr5+7f86fuRhNAQ4ooBTINTGp3r9reIL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFl0h5jj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6133613a12.2;
        Tue, 15 Jul 2025 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752599164; x=1753203964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNVdOuKoan23VnHElyXa1O9OQOwkYvq2YE9Vv0XlCJQ=;
        b=UFl0h5jjPzwm5dELWqu9G6Skc5hDjRRfPX23AZ9KSTd51CoG7HmkNppDHXvw1blUYp
         A/hxQs4d9vugzfU2iL6c17gsZg2SlVsEco4KNeloSOLhNIa/6ahj0m5fguZQ0HREi9Yf
         7GeoFxjtwvEEvp5FtQWYnXnbc1GILx5EDIqkYfMJn9x1/DYrO01DCZKg968kbaNjmKdk
         jxm36i1hwFMv1501SIyruqxII3JsRfEgsz7Xh2SyCsCixdj+QJN2j0FU9UL3szsBwknf
         MUQC6e6afB/hZYMmXhMavHsistCoKlSNDBaLXysYAar5+utOma+x4l8pueS/Z6UGfyWe
         vYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599164; x=1753203964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNVdOuKoan23VnHElyXa1O9OQOwkYvq2YE9Vv0XlCJQ=;
        b=ZH6CnMUxx4yw3Y9xnEMnNnhGizPPRuQOblw8uWedVOy0F+XUDyq90t+3IXKQy6l1Wz
         l7waJ8eyMZbx9JVLjwPqWOeY7FxpN5VA7YCSO81DfvFdVxGwsL/4VSfK2a8QSj6fVnFF
         Yawzp6sVsG4s0R7wVQ6BY0aA3Pe+DVtbiKf8kaRgGrKuaO+TLOQiqISFVjFnHCC12eO7
         qySCCReoGeEcMGLfY7hTHIQu803ALwmBmHy9Jg3nH5XUPEbSB80ZIYDFfFLp/iXXAoN9
         eiyShRIA7H3cBfSpECo1Ce16BpmuWwKe/EQ91/UX3rSzAswoUDm0iA29jYPZOWpxA1IG
         5jtw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5rcJzB66919eXlM26g611o316gUTxjqUDAIR8/oKBgFaLA5HxeVSLhX6v5ilQzVspUBMBbalKNMfEuRC@vger.kernel.org, AJvYcCVt591P0ujrCV+XYB1gNP2zdW4Ir8dmVkwnAxr4ZW4WlgidDem+zirZo4lOMKv9V1hSTtmyJ1p97ec9cLJUzEtX@vger.kernel.org, AJvYcCXQiELyYWnz5oxKtpb3HNMx2dW8d1qNvkHU/8sK67cAyMLWuCYzttYqHbk8yi+Eno9d5bWKXx2z0gG3VkJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtwQzaJ2uliLAtQsT+Xyq5iEgUEBrjo7BW1uVCorAC7+iSZD3
	8xBJNbJwnG/p3WTv3Hh4flJUA4/QnJ3reEc8PaQ4sVxEqcTs1E6uJLiafF8zIfUrN7rgdb4HBB6
	rPneLaoOebUkepoIfNGqbQHg7iZSbVZA=
X-Gm-Gg: ASbGncuLaZK1r5athSZLRijU8S95hOXLZwRWI5eAnIOfr7qip+ba0fBaF76Bq7JeD+a
	V5/Xo1GJ4X/cb/Ie5TJRfnPtvX+Aub8a4VFpBxbKpOZHgAEvPLmUVD3v0qjabiwEx6Mv9XY/0Cf
	jF7bbGrsl5IoXcqOPEA5lrtTq9xfg64FFzSuw+fSsdn7mH6R5ippMhJ9o67xxCbZhDjGEBA53GC
	Uh7DCNpkwSFG3bW/kAnAZ8=
X-Google-Smtp-Source: AGHT+IHWqURmLszmS2cR9qYVf+7DTyCLlk2oIrQTrSNPf7Sik3aoVs3pk12vcxBQJlr2vazV6C5tHVX8fcy6hAcG1xY=
X-Received: by 2002:a17:90b:1d89:b0:31a:b92c:d679 with SMTP id
 98e67ed59e1d1-31c4f5e3054mr25099820a91.35.1752599163826; Tue, 15 Jul 2025
 10:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz> <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com> <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
In-Reply-To: <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:05:49 -0700
X-Gm-Features: Ac12FXwuHfagbWZ-YO4ikvn0k0dO4RWKvyLjInqotU51-B4cAdEKuZJSujCN-MQ
Message-ID: <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:31=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jul 15, 2025 at 12:23:31PM +0200, Vlastimil Babka wrote:
> > On 7/15/25 11:52, David Hildenbrand wrote:
> > > On 15.07.25 11:40, Lorenzo Stoakes wrote:
> > >> On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
> > >>>> Andrew, could you please remove this patchset from mm-unstable for=
 now
> > >>>> until I fix the issue and re-post the new version?
> > >>>
> > >>> Andrew can you do that please? We keep getting new syzbot reports.
> > >>
> > >> I also pinged up top :P just to be extra specially clear...
> > >>
> > >>>
> > >>>> The error I got after these fixes is:
> > >>>
> > >>> I suspect the root cause is the ioctls are not serialized against e=
ach other
> > >>> (probably not even against read()) and yet we treat m->private as s=
afe to
> > >>> work on. Now we have various fields that are dangerous to race on -=
 for
> > >>> example locked_vma and iter races would explain a lot of this.
> > >>>
> > >>> I suspect as long as we used purely seq_file workflow, it did the r=
ight
> > >>> thing for us wrt serialization, but the ioctl addition violates tha=
t. We
> > >>> should rather recheck even the code before this series, if dangerou=
s ioctl
> > >>> vs read() races are possible. And the ioctl implementation should b=
e
> > >>> refactored to use an own per-ioctl-call private context, not the se=
q_file's
> > >>> per-file-open context.
> > >>
> > >> Entirely agree with this analysis. I had a look at most recent repor=
t, see:
> > >>
> > >> https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6=
b@lucifer.local/
> > >>
> > >> AFAICT we either have to lock around the ioctl or find a new way of =
storing
> > >> per-ioctl state.
> > >>
> > >> We'd probably need to separate out the procmap query stuff to do tha=
t
> > >> though. Probably.
> > >
> > > When I skimmed that series the first time, I was wondering "why are w=
e
> > > even caring about PROCMAP_QUERY that in the context of this patch ser=
ies".
> > >
> > > Maybe that helps :)
> >
> > Yeah seems like before patch 8/8 the ioctl handling, specifically
> > do_procmap_query() only looks at priv->mm and nothing else so it should=
 be
> > safe as that's a stable value.
> >
> > So it should be also enough to drop the last patch from mm for now, not
> > whole series.
>
> Yeah to save the mothership we can ditch the landing craft :P
>
> Maybe worth doing that, and figure out in a follow up how to fix this.

For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
and locked_vma don't need to be persisted between ioctl calls. So we
can just add those two fields into a small struct, and for seq_file
case have it in priv, but for PROCMAP_QUERY just have it on the stack.
The code can be written to accept this struct to maintain the state,
which for PROCMAP_QUERY ioctl will be very short-lived on the stack
one.

Would that work?

>
> Or we could just sling in a cheeky spinlock

