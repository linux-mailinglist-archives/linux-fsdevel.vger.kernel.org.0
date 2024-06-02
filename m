Return-Path: <linux-fsdevel+bounces-20750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D238D7773
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB41F21373
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3B56EB4C;
	Sun,  2 Jun 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZfxwuwT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C739FDD;
	Sun,  2 Jun 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717352612; cv=none; b=YsKjQ2a4CHLLV38k6VmLzLedGlmJNVeQ/Ne/QVTW4obL4s4ogmkkhm5pj653s4GmANi8qV3/Ga4VOkHgrKRm/0uywrtxPdyxpV6hVCzs4bCJ/L/v7EeSp6MuZWJC/s8OtVpx+DaDZUwsLUa8sJYmzofy4fBDJ413CYyj7SzXAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717352612; c=relaxed/simple;
	bh=EjC02BhhSxaLN8L0b3nopo1EYeiw9c1TftvPeiVpOCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0LlAsKe2rThSr5Zav+rDYzut7CAASRsxKLNDmOdXjK5cBOXJGSScvFQo37rMYAa2zPFsApBgoiekI00NpxRS8ZICqUj34aEC9tkfxO2fq7A/GIFBA3SZQ2nDSnV1xV5k8hFVdxfyRAFLOuLPgnVe8ltIaqG5u2/i5eQG0qsMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZfxwuwT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4210aa0154eso23602295e9.0;
        Sun, 02 Jun 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717352609; x=1717957409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr/6Wsm0egkRb/ylviGUiuT2dKJTjbzFzZRbk1jvK28=;
        b=CZfxwuwT3gjn608BDHoKB2e5CTZw1/PFD+GwTgCdmR+ROE/1bz4hyABM6OavK/PVU0
         UJb6AKst0zT0Mae80ClXKT6LY7PPv6RpXELRHAFxgdBQE2I/g+obvwpP2QvjRxyyAGrJ
         /tMMorX9XQBLCn70DD1SYMEmtzc4j21qUB266OdNi5O1o4AOatkiEdx4RAAMJzaD0Eav
         TLUBdqTyiQC6fHFky6g+n//6D8mx0MFNJcwLv+3jCqp/J4eB8BP1rmlEdpiqNSYSY0Gn
         b6nlb+lb63+tawoaaC1+AD08aztwq+ete8Q82Tqvw/zvuGd3fslBKzzsxj7VCOZefoFR
         GiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717352609; x=1717957409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr/6Wsm0egkRb/ylviGUiuT2dKJTjbzFzZRbk1jvK28=;
        b=Btm9JQnkPGY9bsKy8OBCv/bbpJ6KTpFVV1JOWUtiTqwc/eTXnXynU0b0buI0Kz5Ksp
         9JLklGx3gnDHPk7k3kRZzIKH5OC88w3ev7bK17bOrHrkgcAzgTWnO5ZhDC2EfaAhZSPb
         W6eJbvdei3pAXmORMpDhG0MPNjqDx+FUHiwD8fvCCQEY6HEVTfbcibVwXzUvLecOduE4
         uRW0qDRNz4vMhotQ0uE4gzeKrOrhrALKozwasZ1kcOTPweNO+Hn0hClZfMAxGPM9CIRi
         Q3m/5o3nU4iF7fDEk4TC5a4UWAqwxgAXIDdmw5wgRBlSyGkXveMlQSD17jgk7TDq5r51
         jj2w==
X-Forwarded-Encrypted: i=1; AJvYcCVHIhdAk276eyLwzEFjzaqaHSkzq9f14XqQc9SAwMyrajTU5BSheO8Vmk4N6LIbD2LlLw8P9XFKT0j4jyqB8JFLd0DOjCXxKr+XtI9jMAb91AXAz4PDMRlmQZd5X21xPEm5l588vDUZ8/vDoCPjwO4H4k5hZ4QBCCH5z8l0ywJD2wW5TAWHd9Qe77PfHjJDOR0LqAZyUvKipaniySHttV+G99rH1+xQ8liDStsnJXqydeVfKCyjUXHHQ0VIZstoyc/jUfIE3nmq6d9YauDafRo1N3gKCe4qJ0zSV6qT8w==
X-Gm-Message-State: AOJu0YzIDVByFxcaoFLLDvzVCm8EzRDqzq+zo7+V6KS5+4M0911QD30M
	qhP/gmKhWiFoF7A5+BYTskkViGlBFY2RZ3b/PORzu8zlqwvSQtcI4Se/UnCGcL9nDpEnEeEUZVX
	HKpUKnrYKypobfNe+M3O02D6UMww=
X-Google-Smtp-Source: AGHT+IEqBUebKrFkVe/BMrUTZcNp6QHc5RmcCuTRnWLHtkrfVemXSY7n9l4vdu8nv6VxYuVVes1X9ysaRl9XXhiuDnk=
X-Received: by 2002:a05:600c:1c19:b0:421:2adb:dd4c with SMTP id
 5b1f17b1804b1-4212e07009amr62269425e9.22.1717352608691; Sun, 02 Jun 2024
 11:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com> <874jabdygo.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jabdygo.fsf@email.froward.int.ebiederm.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 2 Jun 2024 11:23:17 -0700
Message-ID: <CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 10:53=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Sat, Jun 1, 2024 at 11:57=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >>
> >> On Sun, Jun 2, 2024 at 11:52=E2=80=AFAM Eric W. Biederman <ebiederm@xm=
ission.com> wrote:
> >> >
> >> > Yafang Shao <laoar.shao@gmail.com> writes:
> >> >
> >> > > Quoted from Linus [0]:
> >> > >
> >> > >   Since user space can randomly change their names anyway, using l=
ocking
> >> > >   was always wrong for readers (for writers it probably does make =
sense
> >> > >   to have some lock - although practically speaking nobody cares t=
here
> >> > >   either, but at least for a writer some kind of race could have
> >> > >   long-term mixed results
> >> >
> >> > Ugh.
> >> > Ick.
> >> >
> >> > This code is buggy.
> >> >
> >> > I won't argue that Linus is wrong, about removing the
> >> > task_lock.
> >> >
> >> > Unfortunately strscpy_pad does not work properly with the
> >> > task_lock removed, and buf_size larger that TASK_COMM_LEN.
> >> > There is a race that will allow reading past the end
> >> > of tsk->comm, if we read while tsk->common is being
> >> > updated.
> >>
> >> It appears so. Thanks for pointing it out. Additionally, other code,
> >> such as the BPF helper bpf_get_current_comm(), also uses strscpy_pad()
> >> directly without the task_lock. It seems we should change that as
> >> well.
> >
> > Hmm. What race do you see?
> > If lock is removed from __get_task_comm() it probably can be removed fr=
om
> > __set_task_comm() as well.
> > And both are calling strscpy_pad to write and read comm.
> > So I don't see how it would read past sizeof(comm),
> > because 'buf' passed into __set_task_comm is NUL-terminated.
> > So the concurrent read will find it.
>
> The read may race with a write that is changing the location
> of '\0'.  Especially if the new value is shorter than
> the old value.

so ?
strscpy_pad in __[gs]et_task_comm will read/write either long
or byte at a time.
Assume 64 bit and, say, we had comm where 2nd u64 had NUL.
Now two cpus are racing. One is writing shorter comm.
Another is reading.
The latter can read 1st u64 without NUL and will proceed
to read 2nd u64. Either it will read the old u64 with NUL in it
or it will read all zeros in 2nd u64 or some zeros in 2nd u64
depending on how the compiler generated memset(.., 0, ..)
as part of strscpy_pad().
_pad() part is critical here.
If it was just strscpy() then there would indeed be a chance
of reading both u64-s and not finding NUL in any of them.

> If you are performing lockless reads and depending upon a '\0'
> terminator without limiting yourself to the size of the buffer
> there needs to be a big fat comment as to how in the world
> you are guaranteed that a '\0' inside the buffer will always
> be found.

I think Yafang can certainly add such a comment next to
__[gs]et_task_comm.

I prefer to avoid open coding memcpy + mmemset when strscpy_pad works.

