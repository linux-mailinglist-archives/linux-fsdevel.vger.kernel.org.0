Return-Path: <linux-fsdevel+bounces-14241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29176879CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D421F28416A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322C14290F;
	Tue, 12 Mar 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KIjMWH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1A14264A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274277; cv=none; b=i2hdmsQYisce9KdYoVjItTB53D6Vzfp13fR+D83TKCcpIma1073PY7VqQo51SF86NjM6ek5QhWTlcRnJVlgUTj2qGQkXe4vdnyC+zX/F3EjAbrurzBF5IToSX6OPnbJtCBDnQScVUi62m3fX5NTcf6YrvTX+YnniM9CDWQbwZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274277; c=relaxed/simple;
	bh=ZTzOhV15T2M/IQSF7GpXLwUn0RlUF6gGc0Px4d4WFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flNiL769O+rpiX6JtjmrCVuyR7V413LT1HDVjXMLAakrzbqT4Wr6lQLwyUMJzDiHZ+opwLbLMngvIizYNTtrdEbfnu7b5vXH4fC2nwhPXcywlZuztxmgSs4TkyvCbFOjxilQsJGq1Q2rlWbAmJ8jy83yjHHs7Jt1buv+rjeChpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KIjMWH9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5135486cfccso5820545e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710274274; x=1710879074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTW9UBNB4skRIIaA0uCJ32yGuAcFB87u0woHqEplkTs=;
        b=4KIjMWH9jxSDdQHvU3oAQtVx7A+VJn5FDhQzKDvo+7XO/6WEbaWEneEUPZJqeHeSjt
         cYAbSuE3iYU7b0fVFW+0HLRBs9tESJGxUJFcg5KN/NUYd316o+hv1fQncGvRlSR4YKGB
         S+gAFWtLN9k1UTunyBjloJfxS9yQGkqZbGB0YUtDitHvOPkSCf1yX5isJ4OErl9dybmF
         6pLBaHOYPIhKfBjxhdDHalEEQFACoAgabSHsBB5YasrZOsOrIX+xGKZrj/aXahwbqFYE
         YUp+aTke/Oy7ygr6Fm3ud8RCEwWfN3+wSh+qqpR4Vrv+yLi2eYTdhXrLz6ZGK6nJYoAm
         4RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274274; x=1710879074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTW9UBNB4skRIIaA0uCJ32yGuAcFB87u0woHqEplkTs=;
        b=lrQkntyI1LAafQrkgfwrviwCHvE9w5iTrfpWMRQjoktoq1O9v2T4fN0HI6aByFNxnc
         zCP1ULLHMyjaEGRI8RvGzJk1qPBHWyI5fCouPhAMx2XdWvObLhGkzFvEc6lSRzesVaI6
         ePgJr8CiXNstcM9v+nDk7qjp3DNk3/jpRJD9f7ASggp0YcPpsS7tG7ODl/qgg562JdUR
         +3N0AyTGOGI+UIBrSKoga18X17sAQh4RyTzEiKlbLOT0/Lvv/lMihqJvYmYsVv8c/cQH
         lFsB59MYNwwvBtLrRnY+x4Ht6KMApR99mJFn97EYCLw17cI8GqXYuTdzl34lDrQ7x/ms
         EANw==
X-Forwarded-Encrypted: i=1; AJvYcCVc7wQXatOOr88ghCvVeF94haSO3V5T2iru9XJ/Y+wknjcFDwfKz2O+qT8jBfGsy25nMtECh1LneM2RyD8xBQwxTxgmu0jkuTNa6m6Lgw==
X-Gm-Message-State: AOJu0YzY6Wo/0cVis47UdC7q5My2okF7ekBoCaA2ezeBzuItG93I0uoP
	R2LDzTwxcRhT3u+oMwdgdio2pG1y8Bx9SbLQcOljCDYxuvaMAfBEIv3E+nsvjg==
X-Google-Smtp-Source: AGHT+IF+AhYKVculquTNUnhCVljsflyqLdu6h/Yij3aC1xYaUjGLnZQatobo+tgbJCrmukCn6bUzVw==
X-Received: by 2002:ac2:5f7b:0:b0:512:e58c:7bf1 with SMTP id c27-20020ac25f7b000000b00512e58c7bf1mr6443085lfc.40.1710274273885;
        Tue, 12 Mar 2024 13:11:13 -0700 (PDT)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id h8-20020a0564020e0800b005653c441a20sm3775534edh.34.2024.03.12.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:11:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 20:11:09 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>,
	Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <ZfC23WIxnBc9CU6c@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
 <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner>
 <ZfCLnOBDnBp2wcJy@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfCLnOBDnBp2wcJy@google.com>

On Tue, Mar 12, 2024 at 05:06:36PM +0000, Matt Bobrowski wrote:
> Hey Christian,
> 
> On Mon, Mar 11, 2024 at 01:00:56PM +0100, Christian Brauner wrote:
> > On Fri, Mar 08, 2024 at 05:23:30PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Mar 8, 2024 at 2:36 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > >
> > > > These exports are specifically for an out-of-tree BPF LSM program that
> > > > is not accessible to the public. The question in the other mail stands.
> > > 
> > > The question was already answered. You just don't like the answer.
> > > bpf progs are not equivalent to kernel modules.
> > > They have completely different safety and visibility properties.
> > > The safety part I already talked about.
> > > Sounds like the visibility has to be explained.
> > > Kernel modules are opaque binary blobs.
> > > bpf programs are fully transparent. The intent is known
> > > to the verifier and to anyone with understanding
> > > of bpf assembly.
> > > Those that cannot read bpf asm can read C source code that is
> > > embedded in the bpf program in kernel memory.
> > > It's not the same as "llvm-dwarfdump module.ko" on disk.
> > > The bpf prog source code is loaded into the kernel
> > > at program verification time for debugging and visibility reasons.
> > > If there is a verifier bug and bpf manages to crash the kernel
> > > vmcore will have relevant lines of program C source code right there.
> > > 
> > > Hence out-of-tree or in-tree bpf makes no practical difference.
> > > The program cannot hide its meaning and doesn't hamper debugging.
> > > 
> > > Hence adding EXPORT_SYMBOL == Brace for impact!
> > > Expect crashes, api misuse and what not.
> > > 
> > > While adding bpf_kfunc is a nop for kernel development.
> > > If kfunc is in the way of code refactoring it can be removed
> > > (as we demonstrated several times).
> > > A kfunc won't cause headaches for the kernel code it is
> > > calling (assuming no verifier bugs).
> > > If there is a bug it's on us to fix it as we demonstrated in the past.
> > > For example: bpf_probe_read_kernel().
> > > It's a wrapper of copy_from_kernel_nofault() and over the years
> > > bpf users hit various bugs in copy_from_kernel_nofault(),
> > > reported them, and _bpf developers_ fixed them.
> > > Though copy_from_kernel_nofault() is as generic as it can get
> > > and the same bugs could have been reproduced without bpf
> > > we took care of fixing these parts of the kernel.
> > > 
> > > Look at path_put().
> > > It's EXPORT_SYMBOL and any kernel module can easily screw up
> > > reference counting, so that sooner or later distro folks
> > > will experience debug pains due to out-of-tree drivers.
> > > 
> > > kfunc that calls path_put() won't have such consequences.
> > > The verifier will prevent path_put() on a pointer that wasn't
> > > acquired by the same bpf program. No support pains.
> > > It's a nop for vfs folks.
> > > 
> > > > > First of all, there is no such thing as get_task_fs_pwd/root
> > > > > in the kernel.
> > > >
> > > > Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
> > > > LSM. I don't see how that's different from an out-of-tree kernel module.
> > > 
> > > Sorry, but you don't seem to understand what bpf can and cannot do,
> > > hence they look similar.
> > 
> > Maybe. On the other hand you seem to ignore what I'm saying. You
> > currently don't have a clear set of rules for when it's ok for someone
> > to send patches and request access to bpf kfuncs to implement a new BPF
> > program. This patchset very much illustrates this point. The safety
> > properties of bpf don't matter for this. And again, your safety
> > properties very much didn't protect you from your bpf_d_path() mess.
> > 
> > We're not even clearly told where and how these helper are supposed to be
> > used. That's not ok and will never be ok. As long as there are no clear
> > criteria to operate under this is highly problematic. This may be fine
> > from a bpf perspective and one can even understand why because that's
> > apparently your model or promise to your users. But there's no reason to
> > expect the same level of laxness from any of the subsystems you're
> > requesting kfuncs from.
> 
> You raise a completely fair point, and I truly do apologies for the
> lack of context and in depth explanations around the specific
> situations that the proposed BPF kfuncs are intended to be used
> from. Admittedly, that's a failure on my part, and I can completely
> understand why from a maintainers point of view there would be
> reservations around acknowledging requests for adding such invisible
> dependencies.
> 
> Now, I'm in a little bit of a tough situation as I'm unable to point
> you to an open-source BPF LSM implementation that intends to make use
> of such newly proposed BPF kfuncs. That's just an unfortunate
> constraint and circumstance that I'm having to deal with, so I'm just
> going to have to provide heavily redacted and incomplete example to
> illustrate how these BPF kfuncs intend to be used from BPF LSM
> programs that I personally work on here at Google. Notably though, the
> contexts that I do share here may obviously be a nonholistic view on
> how these newly introduced BPF kfuncs end up getting used in practice
> by some other completely arbitrary open-source BPF LSM programs.
> 
> Anyway, as Alexei had pointed out in one of the prior responses, the
> core motivating factor behind introducing these newly proposed BPF
> kfuncs purely stems from the requirement of needing to call
> bpf_d_path() safely on a struct path from the context of a BPF LSM
> program, specifically within the security_file_open() and
> security_mmap_file() LSM hooks. Now, as noted within the original bug
> report [0], it's currently not considered safe to pluck a struct path
> out from an arbitrary in-kernel data structure, which in our case was
> current->mm->exe_file->f_path, and have it passed to bpf_d_path() from
> the aforementioned LSM hook points, or any other LSM hook point for
> that matter.
> 
> So, without using these newly introduced BPF kfuncs, our BPF LSM
> program hanging off security_file_open() looks as follows:
> 
> ```
> int BPF_PROG(file_open, struct file *file)
> {
>   // Perform a whole bunch of operations on the supplied file argument. This
>   // includes some form of policy evaluation, and if there's a violation against
>   // policy and auditing is enabled, then we eventually call bpf_d_path() on
>   // file->f_path. Calling bpf_d_path() on the file argument isn't problematic
>   // as we have a stable path here as the file argument is reference counted.
>   struct path *target = &file->f_path;
> 
>   // ...
> 
>   struct task_struct *current = bpf_get_current_task_btf();
> 
>   // ...
>   
>   bpf_rcu_read_lock();
>   // Reserve a slot on the BPF ring buffer such that the actor's path can be
>   // passed back to userspace.
>   void *buf = bpf_ringbuf_reserve(&ringbuf, PATH_MAX, 0);
>   if (!buf) {
>     goto unlock;
>   }
> 
>   // For contextual purposes when performing an audit we also call bpf_d_path()
>   // on the actor, being current->mm->exe_file->f_path.
>   struct path *actor = &current->mm->exe_file->f_path;
> 
>   // Now perform the path resolution on the actor via bpf_d_path().
>   u64 ret = bpf_d_path(actor, buf, PATH_MAX);
>   if (ret > 0) {
>     bpf_ringbuf_submit(buf, BPF_RB_NO_WAKEUP);
>   } else {
>     bpf_ringbuf_discard(buf, 0);
>   }
> 
> unlock:
>   bpf_rcu_read_unlock();
>   return 0;
> }
> ```

Note that we're also aware of the fact that calling bpf_d_path()
within an RCU read-side critical shouldn't be permitted. I have a
patch teed up which addresses this. bpf_path_d_path() OTOH isn't
susceptible to this problem as the BPF verifier ensure that BPF kfuncs
annotated KF_SLEEPABLE can't be called whilst in an RCU read-side
critical section.

/M

