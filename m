Return-Path: <linux-fsdevel+bounces-40052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38700A1BB7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C924F3A898D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFF1D5CEB;
	Fri, 24 Jan 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9bsOePr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9D3224;
	Fri, 24 Jan 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739927; cv=none; b=b/V4/7kJt4v7NPjRys4Fe0sSR0z4/o2DEN9zTWpoYWuXuRJOUAgF2scYhtYYlqLZHu/Z0q3PwspttQK0HvlORCM4xJkp0fdaS4msMzOM6YbioU1o++79IoFT9XvX3aCmVldM0zpBleUTNrUCT101dSwdrvztwqkNuMYzCdZxkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739927; c=relaxed/simple;
	bh=ZHirykXIdW6YxKqRyZObTukCRsmD57QlDckLNyrix/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azepZRMB7XcIGK05l7LIoqpDqzaMNILNfrecY2McdIMlqO3vXB4YpHs/dXRzDTiqId7Hc6YUzXZnWSkKpwDMTJ1H/NndR4U2abHSOaKhSR7ldTvuQHbBUaRxgrbT063yoywNrWJObedDYMTVOl3joIopfA+GF4irUeJ03fE1iA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9bsOePr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3389636a91.3;
        Fri, 24 Jan 2025 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737739925; x=1738344725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9tU465r4veHmtQGjcmCOL+KaVRkBXBk0y82tXRvmPg=;
        b=G9bsOePrxjZ/aYOBxf0pL/bUW3d9FW/7wzbaVPVUtJLLNJMnsRW1JOi81oSkl0wq1t
         vXzIqIOzGypBRiiXntG0V34gv1u0JQhVbFVwg/pTgDzlQsjxUrulKesp5UGHdadbrGV6
         RXyI2XMnI+frs9QZYLyPlqOQXO/mCBDsK1Ps0cFWMNDCZu4cuOY15T2FuShgChdnioxu
         znhupj11MT9i2MAJ927+ty0KMT4+aGQCguxl5ejEduVZMKiWmzSSC4sM3XdtmjNaSmfE
         mwvrrZzh+IZWg+QxdjYfgGISeTT6HjsPW/wRyR8QD49c7lGmVi0QUQY5tlGkkDUhbYu8
         +JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737739925; x=1738344725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9tU465r4veHmtQGjcmCOL+KaVRkBXBk0y82tXRvmPg=;
        b=cYzvVNfYRT3IzCydiKjXuwxeVvd/kqOZmI4uZq/EgPBjVsYuV40YOBPT3xcaUi0Mbs
         2kB9HMZtlkXz2ESjBbCS/HGLyQFVjYu4Y08SxOM9b0ukMpSxQfQEv6rOBymChM41+K+/
         m3+W8RmREnYHOyFLOUrqkKFxQ2/ZXu5iaPOjJkCNdjRyNbWHqIzjVh6/MpwNqHJWPq01
         TyOzRULjTz45pcKx0TBTrOUauqnY9+rhh4Aq3JQ59oopgIEhEEbvdICRp0UNu2Wtdbow
         EgH8QKYwGs1ZLbRYapIs3uLvKPudIxeIW+e+CkMuukAUqRcDosuRQ0EuHJ2Q6OVDzMuu
         T/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUx/7gSFhCyG7HZ4trSploQ53zCpTmlioZw5WBUV042/0qVryjWkcPVLATc5q3e3k4PI3y/48ZQHnyOl5TA1n+IrKuS@vger.kernel.org, AJvYcCVxCbmURnYQ+c4OApdqwOwSKtP3ACbAH9wTYswgdlYPZ9yaJa6f35nluqDCNiYogw8kJiPmHc8cKr7t6vB0fA==@vger.kernel.org, AJvYcCVyowdoe5UEBwzQfr+SrL+nIHdUyvaN0xbFzVeqVSJ2a8mATOaloAvwBozOdfKwR1c8zeQ=@vger.kernel.org, AJvYcCWOCqt3LMsJpoH9JXTDCTNQqanB0KjUcDuwrAl+da2PmIHqrpPLENn/i3xhhWGQHiSYhBR4VeAXEsjGrjOoRoMTuw==@vger.kernel.org, AJvYcCXtwugj28GrefFpmTAlEkh6VTVhHbw2tVn3tWefUwj5bDhYs5gR6Bje11ETAzvz5azFHN4bSk7QubDGgNps@vger.kernel.org
X-Gm-Message-State: AOJu0Yweq0kK/xEo6UmV8H2URw0YyJbKR1qsJaEQwtERDO+tHnTBHoh8
	AXxRLE/+t7B6nZKwJwuA91xWDk0ihj/d/8c8OTlOt0vpDvEFI3syPXmBVCyi+sXziyyTa/ei8j9
	GR/4yaH2sE0EZI2+H50xSMBO6a5c=
X-Gm-Gg: ASbGncvr9EgKEaqQL90xSqYR32B8NxkJij3Pxxpz4cYcmDp24qI4fS3ouTkfEqV14eZ
	LHTpQ8upEnGH2EJvHoc9C5RbdyJYzlGCE3bU9fwvYLivdLs7pX2q9kKTGsut964vR4aSmMEFaVJ
	gh/w==
X-Google-Smtp-Source: AGHT+IHv177rknNWtVl10ZByeW9NL8yl4cw9RJrKhUy4O48kbuJiw1c2KWX22rSEvTe1hGREuZSZr4B6zTzN2smJdUs=
X-Received: by 2002:a05:6a00:84f:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-72dafaf8ab3mr52503267b3a.24.1737739925486; Fri, 24 Jan 2025
 09:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org> <20250124-zander-restaurant-7583fe1634b9@brauner>
In-Reply-To: <20250124-zander-restaurant-7583fe1634b9@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 09:31:53 -0800
X-Gm-Features: AWEUYZki9vGi1HFUl8Dz1x-Ht8YaCMiKiPorW6F6sk3BICcrwFMYNypBn50mLzw
Message-ID: <CAEf4BzbGZHAmBYkPVHFH-M60p3Z4DyrZFeh6ZKZ7+isu+RmdqA@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 1:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 23, 2025 at 01:43:42PM -0800, Andrii Nakryiko wrote:
> > It's very common for various tracing and profiling toolis to need to
> > access /proc/PID/maps contents for stack symbolization needs to learn
> > which shared libraries are mapped in memory, at which file offset, etc.
> > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> > are looking at data for our own process, which is a trivial case not to=
o
> > relevant for profilers use cases).
> >
> > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > discover memory layout of another process: it allows to fully control
> > arbitrary other processes. This is problematic from security POV for
> > applications that only need read-only /proc/PID/maps (and other similar
> > read-only data) access, and in large production settings CAP_SYS_PTRACE
> > is frowned upon even for the system-wide profilers.
> >
> > On the other hand, it's already possible to access similar kind of
> > information (and more) with just CAP_PERFMON capability. E.g., setting
> > up PERF_RECORD_MMAP collection through perf_event_open() would give one
> > similar information to what /proc/PID/maps provides.
> >
> > CAP_PERFMON, together with CAP_BPF, is already a very common combinatio=
n
> > for system-wide profiling and observability application. As such, it's
> > reasonable and convenient to be able to access /proc/PID/maps with
> > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> >
> > For procfs, these permissions are checked through common mm_access()
> > helper, and so we augment that with cap_perfmon() check *only* if
> > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't b=
e
> > permitted by CAP_PERFMON.
> >
> > Besides procfs itself, mm_access() is used by process_madvise() and
> > process_vm_{readv,writev}() syscalls. The former one uses
> > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMO=
N
> > seems like a meaningful allowable capability as well.
> >
> > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> > but that's outside the scope of this change), and as such won't be
> > affected by this patch.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/fork.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ded49f18cd95..c57cb3ad9931 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct=
 *task)
> >  }
> >  EXPORT_SYMBOL_GPL(get_task_mm);
> >
> > +static bool can_access_mm(struct mm_struct *mm, struct task_struct *ta=
sk, unsigned int mode)
> > +{
> > +     if (mm =3D=3D current->mm)
> > +             return true;
> > +     if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > +             return true;
>
> Just fyi, I suspect that this will trigger new audit denials if the task
> doesn't have CAP_SYS_ADMIN or CAP_PERFORM in the initial user namespace
> but where it would still have access through ptrace_may_access(). Such
> changes have led to complaints before.
>
> I'm not sure how likely that is but it might be noticable. If that's the
> case ns_capable_noaudit(&init_user_ns, ...) would help.

Yep, thanks. Not sure if this is the problem, but I'm open to changing
this. I can also switch the order and do perfmon_capable() check after
ptrace_may_access() to mitigate this problem? I guess that's what I'm
going to do in v2.

>
> > +     return ptrace_may_access(task, mode);
> > +}
> > +
> >  struct mm_struct *mm_access(struct task_struct *task, unsigned int mod=
e)
> >  {
> >       struct mm_struct *mm;
> > @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *t=
ask, unsigned int mode)
> >       mm =3D get_task_mm(task);
> >       if (!mm) {
> >               mm =3D ERR_PTR(-ESRCH);
> > -     } else if (mm !=3D current->mm && !ptrace_may_access(task, mode))=
 {
> > +     } else if (!can_access_mm(mm, task, mode)) {
> >               mmput(mm);
> >               mm =3D ERR_PTR(-EACCES);
> >       }
> > --
> > 2.43.5
> >

