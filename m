Return-Path: <linux-fsdevel+bounces-61826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E37B5A1DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A071482D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC72E8DF5;
	Tue, 16 Sep 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIsO8RsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7762E0905
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053323; cv=none; b=dhGExdQG6Pr5c82opTJhYBIFO+itSFAuGbzvutmy8bXzNF8KhZRedGgrAeDRI/SYeMa2/A0/mp1JNN4DacILFxJS/rvqvx6JAGaZVGxWSTNc4YU6XT8vLYdJ/b16gRtR/y2A49PY8/vpKait+DFZQcJVI1kHMp/dxaqR6yeSWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053323; c=relaxed/simple;
	bh=G6CklpEIQ7Jb943ATNScD0+tWQkQ7nBD/btfivKvGhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPusZmYeVycRcAbEIPyQXFlULZkv+SUOybFKgNiAYC14UZlRF7dkMXViSluVdLMblNjUBXmrEyNAbuqGMqb8uMlMiiKI8kN6OwwH7ABKAvqnh5Q8qnbCovaPrcNcP1puZJja9hZrt6rczXbBxF3yJ3kBKoKy7xwid88D78WO2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIsO8RsE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-265abad93bfso42525ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758053321; x=1758658121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9Lkzd2qHU0WJpoFh7WhpO5uCyrQhSbia0bX3ioP2o8=;
        b=zIsO8RsEJUD145hvelYKaRsx+Qzp3myczur3fTapMhPMe8OLfWYGEiqq+GcZGCrZbh
         6t2PEOuPETyirK648hJm39rPPifyTwFGUkvxjnXUx+6x7ySOVRPYM3RsNrUqR/1eP9Xs
         IT1EYvr8SVx5HImaqGGOixVUpRYlu0fblK6fLIyEermjTwmzKjetgRXUhLJAnq9e6jLr
         ViZMKxZ+ER0UVe1W6adZTxDTdi0t5hdouLsnkKJpGq93pgRVet6eQqE8aMfV1qs7SekM
         6dhu9MdNDUF/n+arUEFaJlawiZmrobf8Oa+9uqwKRTSc7qFjzy+KhkCh4LHgwSI8y8M1
         RsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053321; x=1758658121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9Lkzd2qHU0WJpoFh7WhpO5uCyrQhSbia0bX3ioP2o8=;
        b=e4Kl3Nqh+NlIvHUyLsq2mo5mbYZaKYzSFoLL+2IuAsnfL1wJuh1jm4ZuFU972sHo9V
         PNf7icYwctNcQSy8zgGmowKomyR7qid39iT7JMJwMe04ZtogtuPs+E1xJ8rp8wH/RIbk
         bPJcCuOybOHpPUdemRJd3eonFMgy3euW7jGbBQabMs0+Mvee1bCLQ8TeOVTMpjfA6LTU
         070flLoWlWm6dOekb+DJGzAQzMbOBkYnX2XLiK/nF+mWzpbBjHNwbw9XUOJOxkgTxShY
         h3GHfWpJeR0OUfFWmmZp+tS5ki+DrbuC2W2pKKjBj2c2cH0u/kvpajJ5GtQykQDLFgoP
         YSMg==
X-Forwarded-Encrypted: i=1; AJvYcCWF9sug0mGSk500NGoWd33acrsSb2PIeExsv0kZqG5jEMd9UudlNyHb4X6kVFC25t4iHIDQ69XLwSsLxZlE@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPY7FCgjm4O+114+44NERqL53/AgkAw3s/6MEkkbdYEbpkoe/
	aJii93gc1ok8sOaW3d6U9eals5gkO/BI8lRmWUHSoZndTlO+1DCa7E/H6RKmeOaTMzind6CgetB
	4y+YGHde17Wvm7HEc8qCtA7Z4h4yCw8E1g2EOE6Un
X-Gm-Gg: ASbGncsuyOvIJ+FNgllbj9yxT63AYlDc0vYj8jhBfVRsP4xyOBVWDXqf3CP1VoC4CMy
	fL9Ad7BStV0n+DAy2QDlv2YibALz5NA8S2fMBAsOqTX6wvBK58R40gSYP9YNkU8MvMJCgeyocR3
	fsAAA5wJeAtphd4o6VJPlHTi4wU2MJt3DIembBElE8P7BurzCI4x4Pt2PGYiU/10uS3fyObXIQM
	oRExduo31wuwYd2Fq2ir6QilThAW9Yp7xjClKacasjUhPNeW0A=
X-Google-Smtp-Source: AGHT+IHB+zIC9M5csK1y9pYvqYGZ9e1a8g5vFs0VSlYor4LBlSAEw+sh6AmBy5K67UD64uBbR+RJ2cXCghc/d1plz/M=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr122185ad.3.1758053321270; Tue, 16 Sep 2025
 13:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
 <20250916115220.4a90c745@batman.local.home> <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
 <20250916134833.281e7f8b@gandalf.local.home> <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
 <20250916140245.5894a2aa@gandalf.local.home> <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
 <20250916145146.046f56a8@batman.local.home>
In-Reply-To: <20250916145146.046f56a8@batman.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 13:08:29 -0700
X-Gm-Features: AS18NWCVdunjcrUP7tBqVqoMShUmOYlO_Ndh14lC0p7nbWIxXHPwlnQ10YTDEow
Message-ID: <CAC_TJvc2MwQHvY_ry=a4CGA_zEw2TE8R_K520Eizjt83At0N_Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:51=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 11:23:03 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > > When it comes to tracing, you already lost. If it goes into the ring =
buffer
> > > it's a raw pointer. BPF doesn't use the output of the trace event, so=
 you
> > > are exposing nothing from that. It uses the proto directly.
> >
> > My understanding is that the BPF tracepoint type uses the trace event
> > fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
> > access to the proto arguments. Please CMIW: Isn't what we'd be adding
> > to the trace buffer is the hashed mm_id value?
>
> Ah, right. Can't the BPF infrastructure protect against it?
>
> >
> > >
> > > Heck, if you enable function tracing, you are exposing every function
> > > address it traces via the raw data output.
> >
> > Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
> > Android production kernels.
>
> Does it block all the other trace events that share pointers?
>
> Like nmi handler tracepoints, x86_fpu tracepoints, page_fault kernel
> tracepoint, tasklet tracepoints, cpu hot plug tracepoints, timer
> tracepoints, work queue tracepoints, ipi tracepoints, scheduling
> tracepoints, locking tracepoints, rcu tracepoints, dma tracepoints,
> module tracepoints, xdp tracepoints, filemap tracepoints, page map
> tracepoints, vmscan tracepoints, percpu tracepoints, kmem_cache
> tracepoints, mmap lock tracepoints, file lock tracepoints, and many
> more! (I got tired of looking them up).

Hi Steve,

I see your point :)  I'll use the raw pointer and handle not exposing
it from the BPF side.

Thanks for discussing.

--Kalesh

>
> Again, are you really protecting anything if this one trace point
> hashes the pointer? Most other tracepoints expose this. If BPF can
> access a tracepoint entry struct, it can access the raw address and
> break KASLR.

Thanks,
Kalesh
>
> -- Steve

