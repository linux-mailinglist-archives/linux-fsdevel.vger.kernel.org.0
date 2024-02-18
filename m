Return-Path: <linux-fsdevel+bounces-11930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B98593B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 01:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64D4B21264
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C21360;
	Sun, 18 Feb 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/xwhoLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148247FF
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708217063; cv=none; b=sfUBXi/U/XGgS1Xxgn1kZS2v00UMM8a4+VL+zJCWQZSH6E4zodJcyhVbkjaJ1W+Ks+3bGmsJ0S5eTFxTei9l8hF0GVc1tG1XRR0U4zOY4CHL49yM2eeIXb84NI+Sz4oW2g2wIi2Pfkb+syVj0zFxTEJrGmfMfS5iikfBE0tUAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708217063; c=relaxed/simple;
	bh=eObXZNCrhmMoAtoJx0M+KCXazEG8uiFRYjucowDmnr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0NxfuLIByq8LIetDJif5KIuXA2oFZAiLh8s0TiNgO0l+Ta/jXR5V3+v/zvoDArGwjFI2giDBucBbuPGB3aNNHQ5rGhAFlSDr/z/y0SWTGY5Zwx2Scic3rDffaGD9LBUYpfAGM6pSOYnJeYKQLOqDOz5wDHSmHdahHJLMHQKrks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/xwhoLJ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607f94d0b7cso20287047b3.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708217058; x=1708821858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=T/xwhoLJPGVdk1V/HhrRgMZsfbN6nYRAHY5lwofz/l8q5zNjsBdJVXHBeS39CuSKox
         oqZe9CArJF37hHdFcyB5oiFH4ujlXu4RT29aK9L9rAZCvLrzgxNAndKlFHnw4Em75p+K
         eE/5z2hTbf2OGDYB0xQNRG48TSeSBUr/9TVi5eFpo8xxObEsGC6nEnrLNaYSUIa+x4oD
         Fe+W3UaU3cJXUBmqIgQ0Fq9wm5jDazohABpGuT1uZ2A6O+/4Atyt1q0Z3BBgfyWd05Uy
         yWqNIE2qrm1W/0DpZtWfEZFltW6lBPHP4XgwnjDduBKb5WSU3rF9Np+VyvH5zaXEZ//3
         viqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708217058; x=1708821858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFEGcM8EospHG4JmqyUXYLdSoH1Alzf1U0lPv6eqJTM=;
        b=bxSo2RCGsILWzUTRDwaSWzGDkXF3pdz3qWb7EPZflvUqv7HB3S7GCq9GZP91sK8sOP
         yjpBqSSJXSOUzk5qlPB8NYhibFGE4YC0cApDaiBwu4LLSG6lkbW4xM6Si7/dK0IBAIWR
         ReSYQ0GSIqJ7k+mDqkbFdkUhhh1w+4Ig7bg7k/uZ+5yciDnTj+U1US/zow06r4QGLThK
         x+R47Vcj7w8sHY/zO2GPNEy/1C+EL21SJ7x68Vz1cqhp5vHOQnvKZfq6Js8B19Z4cd/6
         /S3Vke4nsOswbdTclRfxclgGj1X8+hopJwu4oK8u1go5+/r3UlNihITNIObxNaIcfDv8
         B79Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXKD9ciyPAbyHGfKJ41W/Ttpn7RgTeNYxS8vTZHh3pwT+SvEGu7xph3zTmJXFKFycwzzOuoKAYlHO6QjFloOOxwzo00hsXSA/D3wgO7g==
X-Gm-Message-State: AOJu0YyEXHDtVag2WYq2SRinVKQdLvxqbmFucDURDbHWSDTTpR9ECwiF
	35pT/WS1i9yN9Qj0d02/eO6QwFDHK+3l6mbfo+4JHlfqqOmS6Iwz3a57EF2LxtAOVm4/YEJDEIQ
	Ni3nrnutRsW13n4/Dw+2PAZtyrZEQikRA5wTF
X-Google-Smtp-Source: AGHT+IF0zbur3ZnS0QBbUiRVZnclSCZcw12C5kwuIUJh6ZOEbr9od3x9F9LKEta3pcFjU0rivXF1DW3eH5+/zL6adzk=
X-Received: by 2002:a81:914a:0:b0:604:f681:a1 with SMTP id i71-20020a81914a000000b00604f68100a1mr9152837ywg.16.1708217057719;
 Sat, 17 Feb 2024 16:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz> <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
In-Reply-To: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Feb 2024 00:44:05 +0000
Message-ID: <CAJuCfpFvSOtz7DaYdv=FXRvTvoRbMziXctFXqSpP_u97uNsFSQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > > When a high-order page is split into smaller ones, each newly split
> > > page should get its codetag. The original codetag is reused for these
> > > pages but it's recorded as 0-byte allocation because original codetag
> > > already accounts for the original high-order allocated page.
> >
> > Wouldn't it be possible to adjust the original's accounted size and
> > redistribute to the split pages for more accuracy?
>
> I can't recall why I didn't do it that way but I'll try to change and
> see if something non-obvious comes up. Thanks!

Ok, now I recall what's happening here. alloc_tag_add() effectively
does two things:
1. it sets reference to point to the tag (ref->ct =3D &tag->ct)
2. it increments tag->counters

In pgalloc_tag_split() by calling
alloc_tag_add(codetag_ref_from_page_ext(page_ext), tag, 0); we
effectively set the reference from new page_ext to point to the
original tag but we keep the tag->counters->bytes counter the same
(incrementing by 0). It still increments tag->counters->calls but I
think we need that because when freeing individual split pages we will
be decrementing this counter for each individual page. We allocated
many pages with one call, then split into smaller pages and will be
freeing them with multiple calls. We need to balance out the call
counter during the split.

I can refactor the part of alloc_tag_add() that sets the reference
into a separate alloc_tag_ref_set() and make it set the reference and
increments tag->counters->calls (with a comment explaining why we need
this increment here). Then I can call alloc_tag_ref_set() from inside
alloc_tag_add() and when splitting  pages. I think that will be a bit
more clear.

>
> >

