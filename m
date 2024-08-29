Return-Path: <linux-fsdevel+bounces-27768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9EE963BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EAE282711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601D15E5D2;
	Thu, 29 Aug 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQv4ALTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDD647;
	Thu, 29 Aug 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913056; cv=none; b=W615srnP7XCCmvElREWxVcFRWkLDLFHUnaEJlWwLpJY0svfX2VZwR5/PHpOfGw/SXKYb5CS5IdcGJAEP5ESZvoEQDRP5sMAyRWsB8wP9ibGgMzVuKtvJZqDZwvxEwWnYqWOzSwUYV5kuViO+6zaXeAyAWCTWTmE4akfVOwvbsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913056; c=relaxed/simple;
	bh=VU81vUW30AdKSehoqmKNMJjqyl1FXmEDl82UsAHavbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0SrFH3Cv14xKqPksSSqH0yBkDniHHZZnM6frt2dSRUCxy6BJOW/jKXtYqUBSoG699ON439aTPeNTR42SwO5S9g6VJgXvjtY0HIZu93evYAuIG7vJpBtUUMHn8VYWeuITmMf9m997gcGFa1huJ7EVgd1pPNXJC0p7FOmRlSyF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQv4ALTN; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf6721aae5so1799416d6.2;
        Wed, 28 Aug 2024 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724913053; x=1725517853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVHRuwAUcEYymH+J/b0R0e+3iNvUH3y6v7Jow7lKvQY=;
        b=IQv4ALTNbagKhB9j7itvHwIIkGqofLGBzd79YMXXMEwC1Yw7WwdTRVSXeMkP4DeSkc
         /IuiHm67ZsrFHtIr4UypKhSPEb9POhGqWdGgkeeyG7HW1hj0ga3l5ukaxBTXp/LtLL64
         k5a1PPRmBK/rNk9u0o3J90AdjTsZ8UkB7k2YNjnVhU7C1BI/H+EzN/z/oKbH2UBl6p9o
         yZ20YoKSaZlbAu94E5HOMpa4qlTQJjmBnDyq+Hli7otP9rwnlUTr+PRouxB23RZZFCw2
         fvmtGt/IPxF6RDWtWlTqxLzV5nb0HXazT8EeW/kKUeWz0sZEhvmIS/x96TJVTNMwF6Av
         LkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724913053; x=1725517853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVHRuwAUcEYymH+J/b0R0e+3iNvUH3y6v7Jow7lKvQY=;
        b=LOY0j4oE/SFjSGK9ZEl9BMT4iyugdu4FxYLyW4RssjZdYzI+lxKQxa3QGOj9PRRqHw
         /i1xzr9KH9zzaUT6xBNMHyUYItl0DUuDmE0gfNtVdZ+yerzHS7RpHX+FaoYlJzHuGGTj
         VigLZ8Z4hWepzX/8odQdnK27nZeZul98WPlk5FFo6yfNkdY6mY2/ESrF1iU27NAYGOZJ
         f0d++ie0TzoHedRF5ivRuxqOf/Bw8CaR5Tx1SotcJrAR5+JSMnKkgnpUoW4Hcq62jKaF
         tADYxX0hZzltl3VCQJYxd/rJX6tJR3ugJwZIZz8dey0u+ZB8wEmQbm//N42UdZstNplN
         6xeg==
X-Forwarded-Encrypted: i=1; AJvYcCU+oKcHJ5hLkGYF8vGNk+Bkpv8kp6ykGtBDGki5ywYznpPJ9JnbpT7uNqNST6PFlNLpSe3Q@vger.kernel.org, AJvYcCUxEmRud/VXlQh2jBQmgid4q1y4BV8dldleKMhi9LGjDMglWHG2OsokkahXat5VEwljukfzoqvn@vger.kernel.org, AJvYcCVJ2u3AjBDE+2B8dttndSQUoN5m6IyALKtiD7QiRnC/N18ovWfJG+Lw7fnd3dgCc4fdIj5b4+gAC/e1JkgZxf5MfyuV@vger.kernel.org, AJvYcCVdLb5DCwfa+X0mHSN36xRVWdvNka9UTlVCrtW8Ya2WHXlBiXUvlSgHAM2by8imG5KO262fe20GmA==@vger.kernel.org, AJvYcCWr0sAomN/TTFcQwYaMLZ2oRORiCTsqa5zX3H5i46OL5jqHh8g89qPkD0C/qU7hJSQQ5fSlUg==@vger.kernel.org, AJvYcCXZFSSEmlwEEIHdfBhJKHRtydO3OXab6KK6MHgi9iejM0e0tCCgib3vVZdFsXL+llrao78hSag5Gjlz/HkkF5fUUFPWr4V/@vger.kernel.org, AJvYcCXcWQzTS2sD4TRytLiQp9/k4wtKu19lPiXpl58+KZBvaTtrEW6awb9ZgAti6DI/sx00fW2Y9jeyljH2o6Kjdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxayWA/FlzvSvQYLc/4m4rkF0HMPrWLsIwRK0tH3i/sL6c9LRm6
	Zsejs6QN8A1ORtzPw9wsdqL8TM8fSBjC29Ysixrc0a2x9j80wZdjpPtxmk8uASh0FvzORoZ/fYR
	E4iUSdZ8dS7fwvEcp0+Lp9cOv2HA=
X-Google-Smtp-Source: AGHT+IHAaYj3VKJPFC+rsCIttyDdBV4rNcUvYcw6ZzQZduvgmQVvDq94rvCCqajdqQxNsCbTeYDYWfFYA4N5Ml43Gtc=
X-Received: by 2002:a05:6214:2d4a:b0:6bb:ab4a:dbdb with SMTP id
 6a1803df08f44-6c33e5e7de8mr21034396d6.1.1724913053063; Wed, 28 Aug 2024
 23:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-2-laoar.shao@gmail.com>
 <8A36564D-56E3-469B-B201-0BD7C11D6EFC@kernel.org>
In-Reply-To: <8A36564D-56E3-469B-B201-0BD7C11D6EFC@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Aug 2024 14:30:14 +0800
Message-ID: <CALOAHbBHkS=J8Bv+XsoWvwdfG7fGFg0eVw9PhOVWVbJ1ebrr1w@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, alx@kernel.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:04=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On August 27, 2024 8:03:14 PM PDT, Yafang Shao <laoar.shao@gmail.com> wro=
te:
> >We want to eliminate the use of __get_task_comm() for the following
> >reasons:
> >
> >- The task_lock() is unnecessary
> >  Quoted from Linus [0]:
> >  : Since user space can randomly change their names anyway, using locki=
ng
> >  : was always wrong for readers (for writers it probably does make sens=
e
> >  : to have some lock - although practically speaking nobody cares there
> >  : either, but at least for a writer some kind of race could have
> >  : long-term mixed results
> >
> >- The BUILD_BUG_ON() doesn't add any value
> >  The only requirement is to ensure that the destination buffer is a val=
id
> >  array.
>
> Sorry, that's not a correct evaluation. See below.
>
> >
> >- Zeroing is not necessary in current use cases
> >  To avoid confusion, we should remove it. Moreover, not zeroing could
> >  potentially make it easier to uncover bugs. If the caller needs a
> >  zero-padded task name, it should be explicitly handled at the call sit=
e.
>
> This is also not an appropriate rationale. We don't make the kernel "more=
 buggy" not purpose. ;) See below.
>
> >
> >Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-npJ=
ooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> >Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu9=
9v7+b6AyHMmaDFA@mail.gmail.com/
> >Suggested-by: Alejandro Colomar <alx@kernel.org>
> >Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfb=
osf5wdo65dk4@srb3hsk72zwq
> >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> >Cc: Christian Brauner <brauner@kernel.org>
> >Cc: Jan Kara <jack@suse.cz>
> >Cc: Eric Biederman <ebiederm@xmission.com>
> >Cc: Kees Cook <keescook@chromium.org>
> >Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >Cc: Matus Jokay <matus.jokay@stuba.sk>
> >Cc: Alejandro Colomar <alx@kernel.org>
> >Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >---
> > fs/exec.c             | 10 ----------
> > fs/proc/array.c       |  2 +-
> > include/linux/sched.h | 32 ++++++++++++++++++++++++++------
> > kernel/kthread.c      |  2 +-
> > 4 files changed, 28 insertions(+), 18 deletions(-)
> >
> >diff --git a/fs/exec.c b/fs/exec.c
> >index 50e76cc633c4..8a23171bc3c3 100644
> >--- a/fs/exec.c
> >+++ b/fs/exec.c
> >@@ -1264,16 +1264,6 @@ static int unshare_sighand(struct task_struct *me=
)
> >       return 0;
> > }
> >
> >-char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *t=
sk)
> >-{
> >-      task_lock(tsk);
> >-      /* Always NUL terminated and zero-padded */
> >-      strscpy_pad(buf, tsk->comm, buf_size);
> >-      task_unlock(tsk);
> >-      return buf;
> >-}
> >-EXPORT_SYMBOL_GPL(__get_task_comm);
> >-
> > /*
> >  * These functions flushes out all traces of the currently running exec=
utable
> >  * so that a new one can be started
> >diff --git a/fs/proc/array.c b/fs/proc/array.c
> >index 34a47fb0c57f..55ed3510d2bb 100644
> >--- a/fs/proc/array.c
> >+++ b/fs/proc/array.c
> >@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_=
struct *p, bool escape)
> >       else if (p->flags & PF_KTHREAD)
> >               get_kthread_comm(tcomm, sizeof(tcomm), p);
> >       else
> >-              __get_task_comm(tcomm, sizeof(tcomm), p);
> >+              get_task_comm(tcomm, p);
> >
> >       if (escape)
> >               seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "=
\n\\");
> >diff --git a/include/linux/sched.h b/include/linux/sched.h
> >index f8d150343d42..c40b95a79d80 100644
> >--- a/include/linux/sched.h
> >+++ b/include/linux/sched.h
> >@@ -1096,9 +1096,12 @@ struct task_struct {
> >       /*
> >        * executable name, excluding path.
> >        *
> >-       * - normally initialized setup_new_exec()
> >-       * - access it with [gs]et_task_comm()
> >-       * - lock it with task_lock()
> >+       * - normally initialized begin_new_exec()
> >+       * - set it with set_task_comm()
> >+       *   - strscpy_pad() to ensure it is always NUL-terminated and
> >+       *     zero-padded
> >+       *   - task_lock() to ensure the operation is atomic and the name=
 is
> >+       *     fully updated.
> >        */
> >       char                            comm[TASK_COMM_LEN];
> >
> >@@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_str=
uct *tsk, const char *from)
> >       __set_task_comm(tsk, from, false);
> > }
> >
> >-extern char *__get_task_comm(char *to, size_t len, struct task_struct *=
tsk);
> >+/*
> >+ * - Why not use task_lock()?
> >+ *   User space can randomly change their names anyway, so locking for =
readers
> >+ *   doesn't make sense. For writers, locking is probably necessary, as=
 a race
> >+ *   condition could lead to long-term mixed results.
> >+ *   The strscpy_pad() in __set_task_comm() can ensure that the task co=
mm is
> >+ *   always NUL-terminated and zero-padded. Therefore the race conditio=
n between
> >+ *   reader and writer is not an issue.
> >+ *
> >+ * - Why not use strscpy_pad()?
> >+ *   While strscpy_pad() prevents writing garbage past the NUL terminat=
or, which
> >+ *   is useful when using the task name as a key in a hash map, most us=
e cases
> >+ *   don't require this. Zero-padding might confuse users if it=E2=80=
=99s unnecessary,
> >+ *   and not zeroing might even make it easier to expose bugs. If you n=
eed a
> >+ *   zero-padded task name, please handle that explicitly at the call s=
ite.
>
> I really don't like this part of the change. You don't know that existing=
 callers don't depend on the padding. Please invert this logic: get_task_co=
mm() must use strscpy_pad(). Calls NOT wanting padding can call strscpy() t=
hemselves.
>
> >+ *
> >+ * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
>
> This doesn't need checking here; strscpy() will already do that.
>
> >+ */
> > #define get_task_comm(buf, tsk) ({                    \
> >-      BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
>
> Also, please leave the TASK_COMM_LEN test so that destination buffers con=
tinue to be the correct size: current callers do not perform any return val=
ue analysis, so they cannot accidentally start having situations where the =
destination string might be truncated. Again, anyone wanting to avoid that =
restriction can use strscpy() directly and check the return value.

Hello Kees,

Thanks for your input.

Alejandro has addressed all the other changes except for the removal
of BUILD_BUG_ON(). I have a question regarding this: if we're using it
to avoid truncation, why not write it like this?

    BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);

This way, it ensures that the size is at least as large as TASK_COMM_LEN.

--
Regards
Yafang

