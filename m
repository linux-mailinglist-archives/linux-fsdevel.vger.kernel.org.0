Return-Path: <linux-fsdevel+bounces-64162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A58BDB6BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 23:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68CD3BAC42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010652D6401;
	Tue, 14 Oct 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq7GbwkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E11DDC1D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477601; cv=none; b=hsptyZZv832ICykHuWt8zya4kZhbVwxMdg3TKWY+LvRRwOoMWAXk1jtFO31BHTLYBbaoFL20absO3QGbcs7aFapO7jF2yXXRvcybYoEuJDCg0IkYaEW5xKwwqCzlNwYKlJHFM7JYhTuBywD1Y8Vh3vcyExOZYbSc0uGBgY+0Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477601; c=relaxed/simple;
	bh=jn4dzshEK0b/q4LSAmrY5+2g0zSY/o3rLvb537ZUDJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMtpyjzwLj8Gi/rvHK6XFYSrRnmhJ3QHwtnmcOCtqUaovotD+VDiznSFgtdUo4yJmNJSsn3b5vZCYs/xd7e29JHeCWTn77hP7vy35mG9RAcz0d4H6fRIDvjCMPV5//LrL27uU+ZsPChSNlu2Shd9lV9pY9JrkoryWDGdcxz/hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aq7GbwkQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2681645b7b6so20835ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760477597; x=1761082397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRskKZpnIRIllGR+ESE73jq8/mOCylC4thtJYDQxpyE=;
        b=Aq7GbwkQPnBR7SsQUnDAs+E9GY84TGGgKkvtWtR87H8BNyryZqGKcQ8r1Ya5bA8f6x
         6C5zOwHHV27K8KtqMK+mYu+J0iZf5yQSdwSMTNmhjwT82BFEnlPJncKrSG9lqlYO6GBZ
         wU3v1ZGk3SiGi1bT6Z5LOipgE0c9NB5eVRhpbgDUaHLrF7Gx4/mzuHB5dXycsR4hkw/6
         HrZSDC4J/hyweMrwjQf1VfL4y8KOtUl8imYQdzzh0ZT6ht3TAC4j+m/CNBNXKpxtSu38
         TlOQHqvbBPk/6PteaxPqv+1Jl53FM85+bAILVl5uTsAAee0u/TpDF3uAqXPcy3hCtrsM
         LWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760477597; x=1761082397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRskKZpnIRIllGR+ESE73jq8/mOCylC4thtJYDQxpyE=;
        b=i+qGCFGInpddZYNBioJUr9hhq3A9pdbp9FG0vEMwQAEj3S3Aq92kZxx5RR6uqXB+2i
         9kt9BXpbdvdldxLjeBhTHCxYz5CRumKuGUDFRA1/sVRdWd7qu08g6tsDk19MpUIRMzdB
         nxkzi2SIQ45OAwF7S57GA8VRVZrUo6hRQH4aAsXnD3Xm8XzK9QCEDFwfQV0zX+CYFrPB
         ren0F6ObF7LKSebh+1A13JuL1IGNCTjgKu2Wz/2PYyN/GzLgXWQ7Yl5LoEBZGZ2mZt1f
         CH2Meb52STO0zso76jpmgsFMKXZEglx7S0yV4Ksf65QCGZVZA6babmx5aTsjkPOYkz/s
         98qg==
X-Forwarded-Encrypted: i=1; AJvYcCWgcvexYP6gLKoxt2yLhvGH+8HfHl2iCjQLas2SoaK5mhSKopMUs84aTO12O2I9kYIgofUVL6e2UoCuGAUw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LE/xVH/LT+aLw5tNu602GkZD9jeBVbj0f/fBRE+vfxsy96or
	1cMnZTI4fk7kn1Ib6jTFOvTGims6eHovsTuzL0vytIj59bQdA85HBnYd+DAGIMkExQgXeYP0AoL
	Gl7VN7xvAlSB0aTEr3P3XMLcTppWvC6+YMWpwAjUs
X-Gm-Gg: ASbGncsvEOELFqJq7wVC6UsdKU6A7QSVomBWuSI05Rvkp4pU6lzHGsLZgFUBrM4p/b6
	fce8iZUBk7BB7s7fUsoiijOTjmuwh6y3IrRVrysTTP5b896yCSmFax0mO0AGLDvKEnayowyseqx
	p1zTdpCozSgqWvHzDziTW/Sy4hfJEN2rBIZeyeeWWO50HqcjVpThhMl2WncowP3kyxaHlo4I/nD
	qZWUPwJdGt4HSp73koUuyp2CgtgYB0Qm+2+JIg+Zp4j0jblu//2ohjfueD0sA==
X-Google-Smtp-Source: AGHT+IEHrs850EG3XMez/7ngys4coZSDbG9AXxNVFTWtUr9iNSb9QVL8mjJjo5KQMcuY6Vt1JkM1o+A/H66y4AjU968=
X-Received: by 2002:a17:903:3d06:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29087a16a7fmr1160785ad.6.1760477597088; Tue, 14 Oct 2025
 14:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
In-Reply-To: <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 14 Oct 2025 14:33:05 -0700
X-Gm-Features: AS18NWDEXIzf0W_8NyXmtodW3cUhtebQNJZvZW7z0zEtzur244eg_ScikaZgMeo
Message-ID: <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:28=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Mon, 13 Oct 2025, Kalesh Singh wrote:
>
> > The VMA count limit check in do_mmap() and do_brk_flags() uses a
> > strict inequality (>), which allows a process's VMA count to exceed
> > the configured sysctl_max_map_count limit by one.
> >
> > A process with mm->map_count =3D=3D sysctl_max_map_count will incorrect=
ly
> > pass this check and then exceed the limit upon allocation of a new VMA
> > when its map_count is incremented.
> >
> > Other VMA allocation paths, such as split_vma(), already use the
> > correct, inclusive (>=3D) comparison.
> >
> > Fix this bug by changing the comparison to be inclusive in do_mmap()
> > and do_brk_flags(), bringing them in line with the correct behavior
> > of other allocation paths.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: <stable@vger.kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v3:
> >  - Collect Reviewed-by and Acked-by tags.
> >
> > Changes in v2:
> >  - Fix mmap check, per Pedro
> >
> >  mm/mmap.c | 2 +-
> >  mm/vma.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 644f02071a41..da2cbdc0f87b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
> >               return -EOVERFLOW;
> >
> >       /* Too many mappings? */
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (mm->map_count >=3D sysctl_max_map_count)
> >               return -ENOMEM;
> >
> >       /*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a2e1ae954662..fba68f13e628 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >       if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> >               return -ENOMEM;
> >
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (mm->map_count >=3D sysctl_max_map_count)
> >               return -ENOMEM;
> >
> >       if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > --
> > 2.51.0.760.g7b8bcc2412-goog
>
> Sorry for letting you go so far before speaking up (I had to test what
> I believed to be true, and had hoped that meanwhile one of your many
> illustrious reviewers would say so first, but no): it's a NAK from me.
>
> These are not off-by-ones: at the point of these checks, it is not
> known whether an additional map/vma will have to be added, or the
> addition will be merged into an existing map/vma.  So the checks
> err on the lenient side, letting you get perhaps one more than the
> sysctl said, but not allowing any more than that.
>
> Which is all that matters, isn't it? Limiting unrestrained growth.
>
> In this patch you're proposing to change it from erring on the
> lenient side to erring on the strict side - prohibiting merges
> at the limit which have been allowed for many years.
>
> Whatever one thinks about the merits of erring on the lenient versus
> erring on the strict side, I see no reason to make this change now,
> and most certainly not with a Fixes Cc: stable. There is no danger
> in the current behaviour; there is danger in prohibiting what was
> allowed before.
>
> As to the remainder of your series: I have to commend you for doing
> a thorough and well-presented job, but I cannot myself see the point in
> changing 21 files for what almost amounts to a max_map_count subsystem.
> I call it misdirected effort, not at all to my taste, which prefers the
> straightforward checks already there; but accept that my taste may be
> out of fashion, so won't stand in the way if others think it worthwhile.

Hi Hugh,

Thanks for the detailed review and for taking the time to test the behavior=
.

You've raised a valid point. I wasn't aware of the history behind the
lenient check for merges. The lack of a comment, like the one that
exists for exceeding the limit in munmap(), led me to misinterpret
this as an off-by-one bug. The convention makes sense if we consider
potential merges.

If it was in-fact the intended behavior, then I agree we should keep
it lenient. It would mean though, that munmap() being able to free a
VMA if a split is required (by permitting exceeding the limit by 1)
would not work in the case where we have already exceeded the limit. I
find this to be inconsistent but this is also the current behavior ...

I will drop this patch and the patch that introduces the
vma_count_remaining() helper, as I see your point about it potentially
being unnecessary overhead.

Regarding your feedback on the rest of the series, I believe the 3
remaining patches are still valuable on their own.

 - The selftest adds a comprehensive tests for VMA operations at the
sysctl_max_map_count limit. This will self-document the exact behavior
expected, including the leniency for potential merges that you
highlighted, preventing the kind of misunderstanding that led to my
initial patch.

 - The rename of mm_struct->map_count to vma_count, is a
straightforward cleanup for code clarity that makes the purpose of the
field more explicit.

 - The tracepoint adds needed observability for telemetry, allowing us
to see when processes are failing in the field due to VMA count limit.

The  selftest, is what  makes up a large portion of the diff you
sited, and with vma_count_remaining() gone the series will not touch
nearly as many files.

Would this be an acceptable path forward?

Thanks,
Kalesh

>
> Hugh

