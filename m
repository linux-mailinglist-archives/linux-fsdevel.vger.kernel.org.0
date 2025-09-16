Return-Path: <linux-fsdevel+bounces-61803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D0B59F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B6E16CF14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D128D8D0;
	Tue, 16 Sep 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Ci38nCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18183279DC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044232; cv=none; b=jBI+OI5YK9XlY9uaLZxloEHX0CyJmxAUI2lN07BwqbdjYWUmHEzoUxcZ6NRo9+iN5vShuITwODIWK+WB1stqGBMyxdcplQDMJ2NBiZ5/OQRTmDyAR/EdWhNoWWK6B4jZPRVKbGkJ216i7K0Octx9vl+o8fYEFblBIBbVfXh9asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044232; c=relaxed/simple;
	bh=kv6ZpslqdALj+1UMNbOILF/wNT6aZwL4VN3adeyqTFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRfOpo4puGQqDzu+AuZP1yudYFfCysXYJ4Dt6SCM9rF7Ic9/sr85O6szgiYyFaWhtnDuOGxMjs63aQkOnZDI89Ugr6Gk0t3E9VSjw3+gC8EFK50A308HeYJRoBXwYx+BgXl1MPUbaE5J738ml2ioSMkyTBnpdiTA2dSaYf827dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Ci38nCw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-265f460ae7bso15815ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758044230; x=1758649030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA74VvTmfLQYH/wAbK7AqscvwtHz9UXBzDQdDDhZ8Jk=;
        b=3Ci38nCwBbgQhieU0DsFxgAM67EHujVieSmIynhuNcjojuL3J9GG8jgndSq1JTckro
         +FZs7zw1xh/3l53Uefe8CAJToeefFiMddpocnx4zqbqa6cYS/6tDg/2U2plCciEJhe4x
         Xl2rIGaYtShFBoYBmkSlqV07qc9VD3SYgfy6Z7jcE/aTgMV9UcBR0Fv7AXwHPsACbSxw
         9eHzzItPForUAV05pOe3s3CWRyOeJ+5WIJCfey4BFDmJZegMICIm021+MpUJZOX+XIgd
         +yTAdh/9xEdJvlUNrXLIII8+H23Uy0ED3rM/gy0KcZvLMuG+6kxh7L846oYeTweb6RB5
         Kc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044230; x=1758649030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA74VvTmfLQYH/wAbK7AqscvwtHz9UXBzDQdDDhZ8Jk=;
        b=tFQMppE/Cowt9NkDRB8PUI4NzigPrBp4iVlhPkLe/Tx9m9n8Qf7cGA0NH3Pp9GZDci
         UMqFy4Db3c+TYpD/0n9E6bsrQ+8CKw9DiYMAhbbNVgP38hSm5pgJCv5E73y/e1a+NFph
         ckrqmnLaZj7sqclGe8Dntd5R0LBnTWMBd7ZfQop4zsCXJ8tgttb81NXD8LPTIgTVBiL6
         AiN7fXQb3didCO4j2+1HWUmFxAv0T9Ggd0qJYHprLskvfsH7Cdn7fwpL7gM+XNdVsEgi
         UE1v62JRSA60e7FfeEjc+c89FAW97vEUixMyN4s7GVeuuOCK0LbiUA43M1CK6GQiJHq7
         9fxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq6OS1Nan1K+Dcf3FvlT5M49zALGRacYUUVFuZe4TawuE+EnN8hu7i65kMz6Ffvu3kXpcb6qdGCB6+hTqM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+P0/s+kHfIEe3c8Hlj4ix3sYX5TP1JDzejvvg5SCqH754Fo1u
	3FmyNXwhIfqhMuCVXtHyS7bj1dJVpTriADLUVMGZffg8wWwSGG3MImtB7gybz7et8ntLievziK2
	z+uLXBG13XTcaOGkD116044+2RuRj+qujw9C7L4vk
X-Gm-Gg: ASbGncvB46Yn864sGKYpf+vHZ+IB+YhbhJFY2NzEGq0fNMH5c2p2GdNEJPn8nlsGxXQ
	SgDTK7TV/CKeSUXd0gzvONjbnHjlGF6gB5NDJay/E+gOFX9G/Pxaps8GM6QcxaP1pUIbnHWmDzh
	he3tockvMIa2hwW3Yexa6Ra/YDkH1t6gq16/YzjpGb5PYi7hMboHYCijS2rfwGtYT4wQSqoBkrC
	ZYSeMrGUs4jmwtcEcP/n3rKiRKICodF1ASAVyThZHaT+FiaUNPl48c=
X-Google-Smtp-Source: AGHT+IEX8t5jebkJIlwMxZnNynAqrdl33amj/WSy/bikpKDzclCAMtzRK9J6Z6CrGhjF/ewhMpAMvfCa6gHuq1eekRA=
X-Received: by 2002:a17:902:e5cb:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-26801092aefmr164555ad.16.1758044228996; Tue, 16 Sep 2025
 10:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com> <20250916115220.4a90c745@batman.local.home>
In-Reply-To: <20250916115220.4a90c745@batman.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:36:57 -0700
X-Gm-Features: AS18NWA2d_yigeV8O2eyFGhdEoQ1sMbWT_8VJ2GS10eRsMmT9vFpF8pvM3GYncQ
Message-ID: <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 8:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 15 Sep 2025 18:19:53 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
>
> > Hi Steve,
> >
> > Thanks for the comments and suggestion you are right we can use bpf to
> > get the comm. There is nothing special about this trace event.  I will
> > drop comm in the next revision.
> >
> > The reason I did the task_struct parameter (current): I believe there
> > is a limitation that we must  specify at least 1 parameter to the
> > TRACE_EVENT()  PROTO and ARGS macros.
>
> OK, then this is another issue. We don't want tracepoint "markers".
> Each tracepoint can take up to 5K in memory due to the code it
> generates and the meta data to control it.
>
> For something like that, we highly recommend dynamic probes (fprobes,
> kprobes, etc).
>
> The only purpose of a static tracepoint is to get data within a
> function that is too difficult to get via a probe. It should never be
> used as a trigger where its purpose is "we hit this path".

Hi Steve,

I completely agree with the principle that static tracepoints
shouldn't be used as markers if a dynamic probe will suffice. The
intent here is to avoid introducing overhead in the common case to
avoid regressing mmap, munmap, and other syscall latencies; while
still providing observability for the max vma_count exceeded failure
condition.

The original centralized check (before previous review rounds) was
indeed in a dedicated function, exceeds_max_map_count(), where a
kprobe/fprobe could have been easily attached without impacting the
common path. This was changed due to previous review feedback to the
capacity based vma_count_remaining() which necessitated the check to
be done externally by the callers:

https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.com/

Would you be ok with something like:

trace_max_vma_count_exceeded(mm);

TP_STRUCT__entry(
__field(unsigned int, mm_id)
__field(unsigned int vma_count)
)

mm_id would be the hash of the mm_struct ptr similar to rss_stat and
the vma_count is the current vma count (some syscalls have different
requirements on the capacity remaining: mremap requires 6 available
slots, other syscalls require 1).

Thanks,
Kalesh

>
> -- Steve

