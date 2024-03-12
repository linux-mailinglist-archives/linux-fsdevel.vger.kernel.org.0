Return-Path: <linux-fsdevel+bounces-14225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BC879A50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A81F243FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00013BAD4;
	Tue, 12 Mar 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXrvPo4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26013B2BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263210; cv=none; b=HXVsCBebBf5XSKGHEXga7bQVfkg5jyNom0XbTD6xdIdVsE+fFI1QcaXWQMVRtLTeiFIfXTTeCL4H0tW3KAaVk4Wx4GyxtoZSC6nWLTu+Z/up9ackoqb9kQBQ/ktknCLCZvZoQKHcOGfg7vdbFeNDNxJIdTKtcvAmghxC/W5NIwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263210; c=relaxed/simple;
	bh=tp5GJDJhFlsY2bgmgdHUuBDT+vKAUmP0b5/gPSMSm8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEJgljSMXUWMg4slIFGuHd6Mh8jv+6SimSiIbiZVlRSy42ltp1Crf4drQ1imeA9HAlCocUKn339kVDKmCmNbRZBM0xjs3mzuaJC8B5+AFDO3FpjcBXd/7DTuSTqYyaSyZLTFK5RoZFJMrW03xUMjHrx1wuCkjnjq0zV8c6JUYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXrvPo4C; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso141485a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710263207; x=1710868007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zB5OcsqYgooW+2YsYbicutHPTgoP7Ts7AFCJig6ZoKo=;
        b=eXrvPo4C9sB00275h6/4v4IGJ4TlUUp5o8rlY3gWLjPB1/uG1AZLFA5li7a5cZaGTP
         dbMKOUWgSAnD39CWIn+9zAKrHjcsbXN7DUSLsc+NDNVj7iBpewn/cQOc43fWLW+JiH1w
         /5KqKZwF3NyjYirx8TvFsNR4nphHu1cBbMYS/t9fldPzmYnt4nlEgq4xsCRqWp44MWZg
         1grsME6p56vBhKltx8W7/yjG43tsu61l0ELh6ePL2eBGGVekXqpvSyJZv4HDIkxiHGCr
         1xKPxH/4AnSDAa42MzNYuPkNpBL3BeRTbU9YuBhe3KsaELWLOl/7jlt8A45Wo2rTjxBg
         mfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263207; x=1710868007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB5OcsqYgooW+2YsYbicutHPTgoP7Ts7AFCJig6ZoKo=;
        b=dhzgMtwiUvHbcM3oth6rA3qAUx25UiGfEgPsbnU4lpekE4UWVp4uMZnxVQu46KE86e
         Qi0qcVm7pOilmm675yCUJiyByDGG0Gmcxa8epP+P98f54iZMM5kkUGdq5jI6FoLejrfo
         ls/hlRIBX9Wfw38mZeBNzoIUj2RMq/3fEL8SAMv3qx1gtlswHPC8cE43byUdyfPZqHNf
         TcnW8qSKGlnWyAVoUkHt28DfOy+Df4E+cwjeukdox0uVqO6wcom48uNkl6tn/EDHDZKA
         EvDBtMqu8YPwAhIaS9jgbvo6gPrSh5KzMi8qJ/wTwx9/lrNPWq6sln8JbV5SJrOO4s4O
         fpIw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqx4RG3FTaAVTssLR8HkMsT27Fd0VEU1LlJkNwBb+1top8itYdOWfBe0Upkhf/neY/4XiO0gdi8WuZqpnkpMvxMHdiX+/AUPYL+aTFw==
X-Gm-Message-State: AOJu0YyIe0u7V1wUuLUTRGW2NS7rZefIJE9MoMN0nwLIQORXuGVOpSoE
	O27eZ8Js4mEZ8IECIWll/XjggcwItQARoIkyiwoyFWmoj6cn4rWZ6F2wXHwaLA==
X-Google-Smtp-Source: AGHT+IEI+5ZeRxyTNwgNp4mYtKX2fYjiH77MdAHaIh6CM5o8Vto9KrIbDxf7Shq7e5wuKr+g45z/+A==
X-Received: by 2002:a50:c01b:0:b0:566:43ab:8b78 with SMTP id r27-20020a50c01b000000b0056643ab8b78mr6675907edb.30.1710263206888;
        Tue, 12 Mar 2024 10:06:46 -0700 (PDT)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402001700b0056857701bf5sm2379670edu.81.2024.03.12.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:06:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:06:36 +0000
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
Message-ID: <ZfCLnOBDnBp2wcJy@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
 <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311-geglaubt-kursverfall-500a27578cca@brauner>

Hey Christian,

On Mon, Mar 11, 2024 at 01:00:56PM +0100, Christian Brauner wrote:
> On Fri, Mar 08, 2024 at 05:23:30PM -0800, Alexei Starovoitov wrote:
> > On Fri, Mar 8, 2024 at 2:36 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > >
> > > These exports are specifically for an out-of-tree BPF LSM program that
> > > is not accessible to the public. The question in the other mail stands.
> > 
> > The question was already answered. You just don't like the answer.
> > bpf progs are not equivalent to kernel modules.
> > They have completely different safety and visibility properties.
> > The safety part I already talked about.
> > Sounds like the visibility has to be explained.
> > Kernel modules are opaque binary blobs.
> > bpf programs are fully transparent. The intent is known
> > to the verifier and to anyone with understanding
> > of bpf assembly.
> > Those that cannot read bpf asm can read C source code that is
> > embedded in the bpf program in kernel memory.
> > It's not the same as "llvm-dwarfdump module.ko" on disk.
> > The bpf prog source code is loaded into the kernel
> > at program verification time for debugging and visibility reasons.
> > If there is a verifier bug and bpf manages to crash the kernel
> > vmcore will have relevant lines of program C source code right there.
> > 
> > Hence out-of-tree or in-tree bpf makes no practical difference.
> > The program cannot hide its meaning and doesn't hamper debugging.
> > 
> > Hence adding EXPORT_SYMBOL == Brace for impact!
> > Expect crashes, api misuse and what not.
> > 
> > While adding bpf_kfunc is a nop for kernel development.
> > If kfunc is in the way of code refactoring it can be removed
> > (as we demonstrated several times).
> > A kfunc won't cause headaches for the kernel code it is
> > calling (assuming no verifier bugs).
> > If there is a bug it's on us to fix it as we demonstrated in the past.
> > For example: bpf_probe_read_kernel().
> > It's a wrapper of copy_from_kernel_nofault() and over the years
> > bpf users hit various bugs in copy_from_kernel_nofault(),
> > reported them, and _bpf developers_ fixed them.
> > Though copy_from_kernel_nofault() is as generic as it can get
> > and the same bugs could have been reproduced without bpf
> > we took care of fixing these parts of the kernel.
> > 
> > Look at path_put().
> > It's EXPORT_SYMBOL and any kernel module can easily screw up
> > reference counting, so that sooner or later distro folks
> > will experience debug pains due to out-of-tree drivers.
> > 
> > kfunc that calls path_put() won't have such consequences.
> > The verifier will prevent path_put() on a pointer that wasn't
> > acquired by the same bpf program. No support pains.
> > It's a nop for vfs folks.
> > 
> > > > First of all, there is no such thing as get_task_fs_pwd/root
> > > > in the kernel.
> > >
> > > Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
> > > LSM. I don't see how that's different from an out-of-tree kernel module.
> > 
> > Sorry, but you don't seem to understand what bpf can and cannot do,
> > hence they look similar.
> 
> Maybe. On the other hand you seem to ignore what I'm saying. You
> currently don't have a clear set of rules for when it's ok for someone
> to send patches and request access to bpf kfuncs to implement a new BPF
> program. This patchset very much illustrates this point. The safety
> properties of bpf don't matter for this. And again, your safety
> properties very much didn't protect you from your bpf_d_path() mess.
> 
> We're not even clearly told where and how these helper are supposed to be
> used. That's not ok and will never be ok. As long as there are no clear
> criteria to operate under this is highly problematic. This may be fine
> from a bpf perspective and one can even understand why because that's
> apparently your model or promise to your users. But there's no reason to
> expect the same level of laxness from any of the subsystems you're
> requesting kfuncs from.

You raise a completely fair point, and I truly do apologies for the
lack of context and in depth explanations around the specific
situations that the proposed BPF kfuncs are intended to be used
from. Admittedly, that's a failure on my part, and I can completely
understand why from a maintainers point of view there would be
reservations around acknowledging requests for adding such invisible
dependencies.

Now, I'm in a little bit of a tough situation as I'm unable to point
you to an open-source BPF LSM implementation that intends to make use
of such newly proposed BPF kfuncs. That's just an unfortunate
constraint and circumstance that I'm having to deal with, so I'm just
going to have to provide heavily redacted and incomplete example to
illustrate how these BPF kfuncs intend to be used from BPF LSM
programs that I personally work on here at Google. Notably though, the
contexts that I do share here may obviously be a nonholistic view on
how these newly introduced BPF kfuncs end up getting used in practice
by some other completely arbitrary open-source BPF LSM programs.

Anyway, as Alexei had pointed out in one of the prior responses, the
core motivating factor behind introducing these newly proposed BPF
kfuncs purely stems from the requirement of needing to call
bpf_d_path() safely on a struct path from the context of a BPF LSM
program, specifically within the security_file_open() and
security_mmap_file() LSM hooks. Now, as noted within the original bug
report [0], it's currently not considered safe to pluck a struct path
out from an arbitrary in-kernel data structure, which in our case was
current->mm->exe_file->f_path, and have it passed to bpf_d_path() from
the aforementioned LSM hook points, or any other LSM hook point for
that matter.

So, without using these newly introduced BPF kfuncs, our BPF LSM
program hanging off security_file_open() looks as follows:

```
int BPF_PROG(file_open, struct file *file)
{
  // Perform a whole bunch of operations on the supplied file argument. This
  // includes some form of policy evaluation, and if there's a violation against
  // policy and auditing is enabled, then we eventually call bpf_d_path() on
  // file->f_path. Calling bpf_d_path() on the file argument isn't problematic
  // as we have a stable path here as the file argument is reference counted.
  struct path *target = &file->f_path;

  // ...

  struct task_struct *current = bpf_get_current_task_btf();

  // ...
  
  bpf_rcu_read_lock();
  // Reserve a slot on the BPF ring buffer such that the actor's path can be
  // passed back to userspace.
  void *buf = bpf_ringbuf_reserve(&ringbuf, PATH_MAX, 0);
  if (!buf) {
    goto unlock;
  }

  // For contextual purposes when performing an audit we also call bpf_d_path()
  // on the actor, being current->mm->exe_file->f_path.
  struct path *actor = &current->mm->exe_file->f_path;

  // Now perform the path resolution on the actor via bpf_d_path().
  u64 ret = bpf_d_path(actor, buf, PATH_MAX);
  if (ret > 0) {
    bpf_ringbuf_submit(buf, BPF_RB_NO_WAKEUP);
  } else {
    bpf_ringbuf_discard(buf, 0);
  }

unlock:
  bpf_rcu_read_unlock();
  return 0;
}
```

Post landing these BPF kfuncs, the BPF LSM program hanging off
security_file_open() would be updated to make use of the
acquire/release BPF kfuncs as below. Here I'm only making use of
bpf_get_task_exe_file(), but similar usage also extends to
bpf_get_task_fs_root() and bpf_get_task_fs_pwd().

```
int BPF_PROG(file_open, struct file *file)
{
  // Perform a whole bunch of operations on the supplied file argument. This
  // includes some form of policy evaluation, and if there's a violation against
  // policy and auditing is enabled, then we eventually call bpf_path_d_path()
  // on file->f_path. Calling bpf_path_d_path() on the file argument isn't
  // problematic as we have a stable path here as the file argument is trusted
  // and reference counted.
  struct path *target = &file->f_path;

  // ...

  struct task_struct *current = bpf_get_current_task_btf();

  // ...
  
  // Reserve a slot on the BPF ring buffer such that the actor's path can be
  // passed back to userspace.
  void *buf = bpf_ringbuf_reserve(&ringbuf, PATH_MAX, 0);
  if (!buf) {
    return 0;
  }

  // For contextual purposes when performing an audit we also call
  // bpf_path_d_path() on the actor, being current->mm->exe_file->f_path.
  // Here we're operating on a stable trused and reference counted file,
  // thanks to bpf_get_task_exe_file().
  struct file *exe_file = bpf_get_task_exe_file(current);
  if (!exe_file) {
    bpf_ringbuf_discard(buf, 0);
    return 0;
  }

  // Now perform the path resolution on the actor via bpf_path_d_path(), which
  // only accepts a trusted struct path.
  u64 ret = bpf_path_d_path(&exe_file->f_path, buf, PATH_MAX);
  if (ret > 0) {
    bpf_ringbuf_submit(buf, BPF_RB_NO_WAKEUP);
  } else {
    bpf_ringbuf_discard(buf, 0);
  }

  // Drop the reference on exe_file.
  bpf_put_file(exe_file);
  return 0;
}
```

This is rather incredibly straightforward, but the fundamental
difference between the two implementations is that one allows us to
work on stable file, whereas the other does not. That's really
it. Similarly, we do more or less the same for our BPF LSM program
that hangs off security_mmap_file().

Do you need anything else which illustrates the proposed BPF kfunc
usage?

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

/M

