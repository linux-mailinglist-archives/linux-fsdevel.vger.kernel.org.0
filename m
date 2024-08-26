Return-Path: <linux-fsdevel+bounces-27195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1795F64F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84751F22DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C793194AEB;
	Mon, 26 Aug 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW/tEoNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0798186619;
	Mon, 26 Aug 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689161; cv=none; b=c6hMQHbyUuVUReZgP0QyoSPUUZMfrlgTmKm7x6zrzs6K+TV8B++Gvt/wUPZfaXUEBSn01TvzeKTS4bjWDNNDOVT8OHEFi6KjuVc1AWyMKCk8rhrjg1UydyXToXzS/hzh1lETyVWIYqdaGei7nxBRvtRiVhqYx9VeqBJR4Rd7dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689161; c=relaxed/simple;
	bh=2TNxklj2DP+/gfuMrzYVi36ytGXhB5WDn+kWAt/Ahpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGfAiCPXfr3H7CPadLJiqMHR9U53bkUnrscyLoL7Ho277kJI9R8QSqyVszhJ/hOk9rniyY2HU+4Vukq2ed4knAK8Z/PdPIiNk4L77osqNnoU/5lTycmPLB0atEil5q0VOyxH7AtVMliNgExwKjTnpKIOKVRKWsskSDc1N6wm/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW/tEoNC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd9d408040so3086373a12.0;
        Mon, 26 Aug 2024 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689159; x=1725293959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TNxklj2DP+/gfuMrzYVi36ytGXhB5WDn+kWAt/Ahpc=;
        b=MW/tEoNCNXap43jyG9w+S7UU1Pde9HwOOhufnmPC5dRNLQZuaEzaossY6POPw0QArX
         COUBESouqYCaxf5DxBllCEtL0WeZFO8rGG/3OlWccFA2H2ILkXUOwrMygZ4TNGjF3CZq
         /pjdMgM0H6u2i6IhrQpi4xZxbpbpNUOK7yWhAVBtd29q/ZYSLfn6wIw3DT4leyFTW8LX
         SukeL7Ub/owrB/ypohxzJX3K1IGPOe8lXw5IoqV5cJUevjf3SFEJNpztLyNDzJgyv0Wv
         jWsLDS9mfi0pGY3vTh2f3zWU+sJGYjpAOAv9RakqudfET4bvobdRI+dP24L4s4EZFvAr
         RT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689159; x=1725293959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TNxklj2DP+/gfuMrzYVi36ytGXhB5WDn+kWAt/Ahpc=;
        b=SNwgX+HMjenoOVjmk8dj9kBABamGu6FmC12kAF4XrKf7e72ViJChFBt9TwyQbzfTIL
         BY8WJ7+ALG00s3x2iczlHvmap68lu/iF+nJGw6gIG+LRP1FQjue677ihwaUhWFfkndQw
         IDWXEofiyWmV64+GNuSAcx0Nq9bwySxIAIiFVa7o/8T7xTijUrMSXpHcylSp+5PSvmZ3
         fg3cZ0LQjB00CeatlXTw20+GnneCj/mTFjtVCLUtd9jNc9H84gJlp0hLuQjXhrYqj0Di
         cpo8hQEfaHvUN9dblCP6zNAis/AAhA+MQpxdUTazInH1PR4L2NemO1e6P6g4m9stMjMl
         sbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzIhHm4OC3bGTDGu/iedumF4jZnuzrq2oGC0LUabctG6ejXydn1YErXaSg9RmIaEWskKMHdRF4hH75uCGPtg==@vger.kernel.org, AJvYcCXNCVDqN576lB4wELfsK6LQOIRU6abwdGesoHPjRfUYbUNBSc/oWzKNeNxEoykNOrZO3qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6BBsXyBEBMyT9ZVS8bG4LPWX9GAcxRytxC427y+4W97aiXIV
	s7f82kBTHKuN8d6vy9PIOKA+/NNsV0NEkggerw5IXuJp+9ysBfrzX+1P3xALiuVnGpmFylpQK4w
	/9jJks7v0d8xlr5+AD14wRPYQnXg=
X-Google-Smtp-Source: AGHT+IF9cs5m/kA6mXNVEWrGv85VEaW26troShS04+qtdhQGucmzQKnmayLz60i/IMyXgyX1YJV77MdA8x9DInrQuTM=
X-Received: by 2002:a17:90a:ae11:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2d8259f3fdbmr71826a91.41.1724689158928; Mon, 26 Aug 2024
 09:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814185417.1171430-1-andrii@kernel.org> <20240814185417.1171430-10-andrii@kernel.org>
 <8fc31d49d4666599cc2ac6815ff3e0b09adc8a94.camel@gmail.com>
In-Reply-To: <8fc31d49d4666599cc2ac6815ff3e0b09adc8a94.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 09:19:06 -0700
Message-ID: <CAEf4Bza97MFcZ=oZ0d6T8DBdNHLR6U4UGZ5cxD+qiasoVcxM3g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
> > Add sleepable implementations of bpf_get_stack() and
> > bpf_get_task_stack() helpers and allow them to be used from sleepable
> > BPF program (e.g., sleepable uprobes).
> >
> > Note, the stack trace IPs capturing itself is not sleepable (that would
> > need to be a separate project), only build ID fetching is sleepable and
> > thus more reliable, as it will wait for data to be paged in, if
> > necessary. For that we make use of sleepable build_id_parse()
> > implementation.
> >
> > Now that build ID related internals in kernel/bpf/stackmap.c can be use=
d
> > both in sleepable and non-sleepable contexts, we need to add additional
> > rcu_read_lock()/rcu_read_unlock() protection around fetching
> > perf_callchain_entry, but with the refactoring in previous commit it's
> > now pretty straightforward. We make sure to do rcu_read_unlock (in
> > sleepable mode only) right before stack_map_get_build_id_offset() call
> > which can sleep. By that time we don't have any more use of
> > perf_callchain_entry.
> >
> > Note, bpf_get_task_stack() will fail for user mode if task !=3D current=
.
> > And for kernel mode build ID are irrelevant. So in that sense adding
> > sleepable bpf_get_task_stack() implementation is a no-op. It feel right
> > to wire this up for symmetry and completeness, but I'm open to just
> > dropping it until we support `user && crosstask` condition.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> All seems logical.
> You skip wiring up support for sleepable bpf_get_task_stack() in
> tp_prog_func_proto(), pe_prog_func_proto() and
> raw_tp_prog_func_proto(), this is because these are used for programs
> that are never run in sleepable context, right?

Correct. I contemplated for a bit wiring it up for tracepoints, as we
might get sleepable tracepoints eventually, but we can always do it as
a follow up.

>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>

