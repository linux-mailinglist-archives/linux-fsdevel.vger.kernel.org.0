Return-Path: <linux-fsdevel+bounces-14361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D787B339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9496289690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2C537E3;
	Wed, 13 Mar 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc+8nY0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAB4E1CE;
	Wed, 13 Mar 2024 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363929; cv=none; b=TpUMb+yN41rBy+UYyvVk95KfwaKQR2NcJsLV1zzkgBSB2havicQ+LDpBbV8OcEjldoBOTrgg4YVnd3e6n5ffoDLWzckSLcOubWRdExcMAwhpwyb3mIPpC63GEzYazueZNGEOYDx10TxVL02f+vvIWbczTsJwlkoJUGrHnxNTa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363929; c=relaxed/simple;
	bh=CH2rZ4PLi2IfM/uHiuMK9LdURXsrNx68tG+esLsv5Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTQpwkcv41Mqlc3oEUFkQOzmC6vt0UoBs0ux66xDsbpvK2urSAb9YUCLq0sluV8V4RAGJStZa09i2+hEKbr92pRrb6xTofPp8r+DudlIVuiFSPkH0r/xdkHINfnQglmJWwL43/cLTp1RUQkP4rdNiuIGrc/sDL4bA7YsXHjhasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc+8nY0g; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e7ae72312so203013f8f.1;
        Wed, 13 Mar 2024 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710363926; x=1710968726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZzVp1B0o1fPUeYOWrqe1Q57q16dmLKhwAmLef5VA14=;
        b=Jc+8nY0g+HgXorpBon5IbPHDFTq4f4avVkggDJJwl5h13KOUZQu6oMVfm9h/5ve63X
         inQEginxALP4HZwdofFK4tJr6OEZR3v+VnAxqqIE6tpoLhz/LZmoff4LLldd7ZalLUtj
         R5/jVBHKpzXKoTwHYHZ6PwcieUykDU8h+f4g1x0zegzklIXVKymBX7I1WkF4MhR3074U
         0tfjXnXNlkRCH7/10OtZbUVT9kRxJDlUe/sFGEAOvuG2VeRYAvX5F7LxZ8HizC7/fPxB
         WHtVS3vxLiHsY7Xsq+gRIFwLIVwP4VwZhyXMqM9L66Bzew5cEZeVt3kY2lDXmq4fQSi5
         uqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363926; x=1710968726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZzVp1B0o1fPUeYOWrqe1Q57q16dmLKhwAmLef5VA14=;
        b=cNtSTjnbTtMQ5wkSpGnHMQWL2RRaBR+QpMVJwW9BjXuxwJq3oL1HUi1JDren+Lbx5f
         BlvL5jt6Y2ss34638on6VqpdThkH/NngmV68QENcQyUoVJOgPz9Yw0Vl3GtwsKePmYWE
         mMR3SfgDXVc5eVDhlS2OVoVNx9x6UlN/wXO2egibIimdEdB+3CjUjzvv9NEp0XuqPzq/
         NZR0IW6mYepd5EFdvB8Ca72i4mFXBADbE5+HQ8ORLw9iEv4zBsntfTkyI/J0Cvx/USLO
         1T+a8SdxBkQq0IAU5iG+zrF3CDpXKbN6gB4/tIF0HhJu6yScJjbqnwdaha6IN5g+4nPK
         KJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUlyBEQ7s6KWa65C2N4jf68C3wnwB+MaTTy9NJjEtlzXKhV+yeDD075IMphfIVRWp3TNZC4+VLpMNXmQ1ZE/6Fcq824DSOFStIPC4m+Ftf9RMDLC0I8zbDdOOOnX1THzfWYYGluiwzMe/3zRuVDeteNZD9fu+/mqRDu3TWBABv0/Wky1sUh+5fLSw==
X-Gm-Message-State: AOJu0YyrWTfM8Ady+fVQamnMBRfm7SEdGq/MDnXS+TOj3llSnnF4uHsr
	xzLuZlaIDPoBkAWaG5oCvH+C3Xz3WIj85S3gNUrF1QrWOCLvYaNDaoDVFz3oZ3Qq0dlTZYvNHwa
	UPHSH7fj38qunx6AEQJc4Zh4FhBU=
X-Google-Smtp-Source: AGHT+IFDFscIvQkKhWL6uTHrhCEwdvqJ5pjqZbod6Uv4pkjnS2CrY1wfRH/QplSvK4c2Ab2/TnZ4YDaEDqej2LD7zf8=
X-Received: by 2002:adf:ffcc:0:b0:33d:2775:1e63 with SMTP id
 x12-20020adfffcc000000b0033d27751e63mr2732491wrs.41.1710363925428; Wed, 13
 Mar 2024 14:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner> <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner> <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner>
In-Reply-To: <20240311-geglaubt-kursverfall-500a27578cca@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Mar 2024 14:05:13 -0700
Message-ID: <CAADnVQLnzrxyUM-EiorEP_qvfmdiSK5Kj1WtGjFoAogygHSvmA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, 
	Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 5:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > > > One can argue that get_mm_exe_file() is not exported,
> > > > but it's nothing but rcu_lock-wrap plus get_file_rcu()
> > > > which is EXPORT_SYMBOL.
> > >
> > > Oh, good spot. That's an accident. get_file_rcu() definitely shouldn'=
t
> > > be exported. So that'll be removed asap.
> >
> > So, just to make a point that
> > "Included in that set are functions that aren't currently even
> > exported to modules"
> > you want to un-export get_file_rcu() ?
>
> No. The reason it was exported was because of the drm subsystem and we
> already quite disliked that. But it turned out that's not needed so in
> commit 61d4fb0b349e ("file, i915: fix file reference for
> mmap_singleton()") they were moved away from this helper.

Arguably that commit 61d4fb0b349e should have had
Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
i915 was buggy before you touched it
and safe_by_rcu exposed the bug.
I can see why you guys looked at it, saw issues,
and decided to look away.
Though your guess in commit 61d4fb0b349e
"
    Now, there might be delays until
    file->f_op->release::singleton_release() is called and
    i915->gem.mmap_singleton is set to NULL.
"
feels unlikely.
I suspect release() delay cannot be that long to cause rcu stall.
In the log prior to the splat there are just two mmap related calls
from selftests in i915_gem_mman_live_selftests():
i915: Running i915_gem_mman_live_selftests/igt_mmap_offset_exhaustion
i915: Running i915_gem_mman_live_selftests/igt_mmap
1st mmap test passed, but 2nd failed.
So it looks like it's not a race, but an issue with cleanup in that driver.
And instead of getting to the bottom of the issue
you've decided to paper over with get_file_active().
I agree with that trade-off.
But the bug in i915 is still there and it's probably an UAF.
get_file_active() is probably operating on a broken 'struct file'
that got to zero, but somehow it still around
or it's just a garbage memory and file->f_count
just happened to be zero.

My point is that it's not ok to have such double standards.
On one side you're arguing that we shouldn't introduce kfunc:
+__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
+{
+ return get_task_exe_file(task);
+}
that cleanly takes ref cnt on task->mm->exe_file and _not_ using lower
level get_file/get_file_rcu/get_file_active api-s directly which
are certainly problematic to expose anywhere, since safe_by_rcu
protocol is delicate.

But on the other side there is buggy i915 that does
questionable dance with get_file_active().
It's EXPORT_SYMBOL_GPL as well and out of tree driver can
ruin safe_by_rcu file properties with hard to debug consequences.

> There is absolutely no way that any userspace will
> get access to such low-level helpers. They have zero business to be
> involved in the lifetimes of objects on this level just as no module has.

correct, and kfuncs do not give bpf prog to do direct get_file*() access
because we saw how tricky safe_by_rcu is.
Hence kfuncs acquire file via get_task_exe_file or get_mm_exe_file
and release via fput.
That's the same pattern that security/tomoyo/util.c is doing:
   exe_file =3D get_mm_exe_file(mm);
   if (!exe_file)
        return NULL;

   cp =3D tomoyo_realpath_from_path(&exe_file->f_path);
   fput(exe_file);

in bpf_lsm case it will be:

   exe_file =3D bpf_get_mm_exe_file(mm);
   if (!exe_file)
   // the verifier will enforce that bpf prog has this NULL check here
   // because we annotate kfunc as:
BTF_ID_FLAGS(func, bpf_get_mm_exe_file, KF_ACQUIRE | KF_TRUSTED_ARGS |
KF_RET_NULL)

 bpf_path_d_path(&exe_file->f_path, ...);
 bpf_put_file(exe_file);
// and the verifier will enforce that bpf_put_file() is called too.
// and there is no path out of this bpf program that can take file refcnt
// without releasing.

So really these kfuncs are a nop from vfs pov.
If there is a bug in the verifier we will debug it and we will fix it.

You keep saying that bpf_d_path() is a mess.
Right. It is a mess now and we're fixing it.
When it was introduced 4 years ago it was safe at that time.
The unrelated verifier "smartness" made it possible to use it in UAF.
We found the issue now and we're fixing it.
Over these years we didn't ask vfs folks to help fix such bugs,
and not asking for help now.
You're being cc-ed on the patches to be aware on how we plan to fix
this bpf_d_path() mess. If you have a viable alternative please suggest.
As it stands the new kfuncs are clean and safe way to solve this mess.

