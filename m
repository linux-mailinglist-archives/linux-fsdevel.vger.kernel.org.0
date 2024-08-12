Return-Path: <linux-fsdevel+bounces-25683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8394EE04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C921C2814A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B517D340;
	Mon, 12 Aug 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzk+jSTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF117C7B9;
	Mon, 12 Aug 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468897; cv=none; b=r/HBUeCAp5vftPLq/hobU60mdjybaAlpPI/IGzGRK1VcJym2ysiW2EaiiPvtBsYqWjP07uB19JNK/1HQ9nindPmYYhgropFIhedlw0+4jjK19byEFV2YMGoLZq6p/T0ZR80ZLt61Sh+p5pixQ6LCu3n2Qxm28N/xGKbpAm3neV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468897; c=relaxed/simple;
	bh=9tDCZscCvY5hEFTSTcbkZLdNaN18qRijSaHg1zfRqS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwx96wMUOkmPaQZurzYMEP7DR1Gh8vtw6S93OscNV6MOq/26bWETX4u+QyvN1+YIdaaCjoR5DZ1Bi6OeN5bq8uV95xzDP02LuoAwFr6ofrH7Z7eNbId0ywa0Ws134MhJT4q1joDDHOaT9U/wnIfiIsQ2ni2VLuoxptamA8jBcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzk+jSTS; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70968db52d0so4516144a34.3;
        Mon, 12 Aug 2024 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723468895; x=1724073695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntaXkWZopfKg+6j7rnXEQlGZAwKedjmgSjz6FEutgS8=;
        b=Jzk+jSTSf2RXGpLuQWXDI/X2DTn+EbgwoqZZC/4TNIr8r8uRNqAxQ9HTpWVrV0dwIe
         G06XpqMRqVau7ztMRu3e4ibnQ9cRO8LQAxESLQYqQvdnuqZOY46h9CFJ0Aaq6v4kq54u
         ZVcM3OkfKLbAykmsnL6gUSHPm+FiVbog7Bkh8ulgpj6XFQYw/gBdROr96n/KXbVSIZJW
         qhvL8prpw9w4+X1dGhhVUASi7yP+c0ApvU4e15rx5GqL9SxW2aoldikIGQBD2+yG5vFj
         24doDWU9LFHnqlOGM9LdrU9OWYc1CfTJi5qamBMSn425Geo9vUR8AjQPKAwTb0l87RKc
         6izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723468895; x=1724073695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntaXkWZopfKg+6j7rnXEQlGZAwKedjmgSjz6FEutgS8=;
        b=tde+Wg/BvBTUhlA4Z8twGtUd2HkESaejNCl1aOS3JakC4zmrgsc18HwZoTlgIpfkdA
         A+NsB9H7zPj0MCl26OReJ/qmu6K7i4BZG2bcF935I93NvIVlYmGgejn7e+kPt6Fza96B
         s8VmhQshaPjwE8MrCNUSnz37dmVmpFO4jCaWjxNMKyVSXhvWWfP1C6sawOFYSgpqT0KQ
         Rc1fcVQvXo17UjJ0PfyCba45ZvOP3RZlfprkj5kHnYEKfVrw4GJJA4rdRrVPsRRDhsns
         W4/48hs0hizqbgf5m8yOGTk99k9agRqwUN7oartROcqOBQJW587kDzCyhwtdcXmACC+o
         6NUw==
X-Forwarded-Encrypted: i=1; AJvYcCUT74V1Y2Jl/zCNcVvtC6K6BNk5z/ZdRjyxmc3OnsT1B11Gydl5970mH7eRn1inZ8IrREnEZMyiolcEG28qi50xfV0LBHml5VpU/0T8Zxnx5R9VPjwRKeiFkBN4YbnywzrmNMqk4kXmddg3Nice11usy1n0T60ZCglM/oSomnPSqrFLDrsEmLIY4Cr1jR6v5TD4hWIsq4Z2PypUThD5QwFku+ljtCEt1jvr53VONvg5iIxw1ox6vVTpIBdp8Uy4cpBBqvqdD6o3uJJrYcOhENc0k5LC1jSVgJ7PRHCYU888DHbIglZNxwRjodgKu6kAQZaxvrU8hg==
X-Gm-Message-State: AOJu0YzG/H7Lec1IpDcL9hiXjsA38UG2zWIlRrHqNKTxsuNhpkRkgisz
	9bTNxc63ubNNudgNw6Vj64s1aMaNRrGfOIqbKvenqtm5Tqp7osSrCmX6ivk3GaKsVB4C4igtUdM
	WAr/X4a9V2ZYdNNkVlDXuboLoIYk=
X-Google-Smtp-Source: AGHT+IGVQve+llYsp0AugSRGeMMoIczqwy8oRpZMYGNh2sJDxIw1ZBHkds1sjMf3hXZlB+uLcjMVRoLPG20nTXUm0IM=
X-Received: by 2002:a05:6830:34a6:b0:703:651b:382f with SMTP id
 46e09a7af769-70c9387ae3fmr240831a34.3.1723468894738; Mon, 12 Aug 2024
 06:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-2-laoar.shao@gmail.com>
 <qztvfvesnxkaol6n3ucf5ovp2ssq4hzxceaedgfexieggzj6zh@pyd5f43pccyh>
In-Reply-To: <qztvfvesnxkaol6n3ucf5ovp2ssq4hzxceaedgfexieggzj6zh@pyd5f43pccyh>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 12 Aug 2024 21:20:57 +0800
Message-ID: <CALOAHbA5MVVhSAm-atWxigaceWBDo4h5ucRv09onnMYFVWsOzQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] Get rid of __get_task_comm()
To: Alejandro Colomar <alx@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, Matus Jokay <matus.jokay@stuba.sk>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:05=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Yafang,
>
> On Mon, Aug 12, 2024 at 10:29:25AM GMT, Yafang Shao wrote:
> > We want to eliminate the use of __get_task_comm() for the following
> > reasons:
> >
> > - The task_lock() is unnecessary
> >   Quoted from Linus [0]:
> >   : Since user space can randomly change their names anyway, using lock=
ing
> >   : was always wrong for readers (for writers it probably does make sen=
se
> >   : to have some lock - although practically speaking nobody cares ther=
e
> >   : either, but at least for a writer some kind of race could have
> >   : long-term mixed results
> >
> > - The BUILD_BUG_ON() doesn't add any value
> >   The only requirement is to ensure that the destination buffer is a va=
lid
> >   array.
> >
> > - Zeroing is not necessary in current use cases
> >   To avoid confusion, we should remove it. Moreover, not zeroing could
> >   potentially make it easier to uncover bugs. If the caller needs a
> >   zero-padded task name, it should be explicitly handled at the call si=
te.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-np=
JooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> > Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu=
99v7+b6AyHMmaDFA@mail.gmail.com/
> > Suggested-by: Alejandro Colomar <alx@kernel.org>
> > Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurf=
bosf5wdo65dk4@srb3hsk72zwq
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Matus Jokay <matus.jokay@stuba.sk>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > ---
> >  fs/exec.c             | 10 ----------
> >  fs/proc/array.c       |  2 +-
> >  include/linux/sched.h | 31 +++++++++++++++++++++++++------
> >  kernel/kthread.c      |  2 +-
> >  4 files changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index a47d0e4c54f6..2e468ddd203a 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1264,16 +1264,6 @@ static int unshare_sighand(struct task_struct *m=
e)
> >       return 0;
> >  }
> >
> > -char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *=
tsk)
> > -{
> > -     task_lock(tsk);
> > -     /* Always NUL terminated and zero-padded */
> > -     strscpy_pad(buf, tsk->comm, buf_size);
>
> This comment is correct (see other comments below).
>
> (Except that pedantically, I'd write it as NUL-terminated with a hyphen,
>  just like zero-padded.)
>
> > -     task_unlock(tsk);
> > -     return buf;
> > -}
> > -EXPORT_SYMBOL_GPL(__get_task_comm);
> > -
> >  /*
> >   * These functions flushes out all traces of the currently running exe=
cutable
> >   * so that a new one can be started
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index 34a47fb0c57f..55ed3510d2bb 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task=
_struct *p, bool escape)
> >       else if (p->flags & PF_KTHREAD)
> >               get_kthread_comm(tcomm, sizeof(tcomm), p);
> >       else
> > -             __get_task_comm(tcomm, sizeof(tcomm), p);
> > +             get_task_comm(tcomm, p);
>
> LGTM.  (This would have been good even if not removing the helper.)
>
> >
> >       if (escape)
> >               seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "=
\n\\");
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 33dd8d9d2b85..e0e26edbda61 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1096,9 +1096,11 @@ struct task_struct {
> >       /*
> >        * executable name, excluding path.
> >        *
> > -      * - normally initialized setup_new_exec()
> > -      * - access it with [gs]et_task_comm()
> > -      * - lock it with task_lock()
> > +      * - normally initialized begin_new_exec()
> > +      * - set it with set_task_comm()
> > +      *   - strscpy_pad() to ensure it is always NUL-terminated
>
> The comment above is inmprecise.
> It should say either
> "strscpy() to ensure it is always NUL-terminated", or
> "strscpy_pad() to ensure it is NUL-terminated and zero-padded".

will change it.

>
> > +      *   - task_lock() to ensure the operation is atomic and the name=
 is
> > +      *     fully updated.
> >        */
> >       char                            comm[TASK_COMM_LEN];
> >
> > @@ -1912,10 +1914,27 @@ static inline void set_task_comm(struct task_st=
ruct *tsk, const char *from)
> >       __set_task_comm(tsk, from, false);
> >  }
> >
> > -extern char *__get_task_comm(char *to, size_t len, struct task_struct =
*tsk);
> > +/*
> > + * - Why not use task_lock()?
> > + *   User space can randomly change their names anyway, so locking for=
 readers
> > + *   doesn't make sense. For writers, locking is probably necessary, a=
s a race
> > + *   condition could lead to long-term mixed results.
> > + *   The strscpy_pad() in __set_task_comm() can ensure that the task c=
omm is
> > + *   always NUL-terminated.
>
> This comment has the same imprecission that I noted above.

will change it.

>
> > Therefore the race condition between reader and
> > + *   writer is not an issue.
> > + *
> > + * - Why not use strscpy_pad()?
> > + *   While strscpy_pad() prevents writing garbage past the NUL termina=
tor, which
> > + *   is useful when using the task name as a key in a hash map, most u=
se cases
> > + *   don't require this. Zero-padding might confuse users if it=E2=80=
=99s unnecessary,
> > + *   and not zeroing might even make it easier to expose bugs. If you =
need a
> > + *   zero-padded task name, please handle that explicitly at the call =
site.
> > + *
> > + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> > + */
> >  #define get_task_comm(buf, tsk) ({                   \
> > -     BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
> > -     __get_task_comm(buf, sizeof(buf), tsk);         \
> > +     strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));     \
> > +     buf;                                            \
> >  })
> >
> >  #ifdef CONFIG_SMP
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index f7be976ff88a..7d001d033cf9 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -101,7 +101,7 @@ void get_kthread_comm(char *buf, size_t buf_size, s=
truct task_struct *tsk)
> >       struct kthread *kthread =3D to_kthread(tsk);
> >
> >       if (!kthread || !kthread->full_name) {
> > -             __get_task_comm(buf, buf_size, tsk);
> > +             strscpy(buf, tsk->comm, buf_size);
> >               return;
> >       }
>
> Other than that, LGTM.

Thanks for your review.

--=20
Regards
Yafang

