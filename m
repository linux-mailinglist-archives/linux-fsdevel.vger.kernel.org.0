Return-Path: <linux-fsdevel+bounces-45660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B2A7A7BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1007A7A4582
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AD2512D4;
	Thu,  3 Apr 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es+zoAxQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7F33DB;
	Thu,  3 Apr 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697042; cv=none; b=L7w7OLeHN8wNLs+3Z2+kL43I6cfCFG+UnFOb/WLo93DxqNF9pjgounPmiD5pByR6MWqKlL5UdK5Cz/unLwHJdSsjEWmXSQVO7CCHv8ZUPx+JpYAXfrEsH9MZ7+Ixmy96vAUEb4E2pL9iKarPKWjte3veIDOx+XY+Xu/c5Sxe6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697042; c=relaxed/simple;
	bh=mciINuOiA6SXlEiQqq7znATGm/qWXcLyL5KKYNRmH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbY8sOdrRtQ0krQk2hAMG+TWqZ+DmPrXL4Ged2oZxbauvCwHmfGO/i9YfGKsG8dXoWqTi3V6l5VET34xZP582CYm8ESp6pHVVQV6YM7S8uHbJ2stdK5aq+gazEBZy88cSiwC9Sitikhz1wxxx5CLz33yrbjCSbnIFK0zwqcG46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es+zoAxQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so1353622b3a.2;
        Thu, 03 Apr 2025 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743697040; x=1744301840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrlDtqZMiFT4AIYDXfp4xswJ1nrQcwl2WHvmHsEcdj8=;
        b=es+zoAxQgbEHnjDdf6BClK7WR9mNJhulDsXV7dezKBoj4j9G4rjQIeodRzQ54AVK9E
         1H0lTt/XlxuCOGLH5DtsMtnNHf4fpWbjppkYbtj2WrAg/ABwS96xUOQueH8QCkRliPSN
         wywVW0trPRwEkCOhAF9xA7TXqLCpk7tFEIrOiupJWm7BrzzgXL0D/aX7BWRQXw/ZvJ7a
         XI3p+00UKunOdUP2vrRtnZ1Ig33dyj9THWQi5FSSbKDywAaDMjvx20FbC9Qwjt6fp6Kf
         yrD6q2Yt+o07bZSHJxbuNpbfqK2mLhlXX+rYnpJDkE5M5kLAPhCwtOk2R1Ma9T+dEqVN
         TkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743697040; x=1744301840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrlDtqZMiFT4AIYDXfp4xswJ1nrQcwl2WHvmHsEcdj8=;
        b=KiQFEVWO+/vAcZyjmT/Esci0PUKZN70fT/GZSBCexdDwVshAadtng0pn0S1Hq4+zCV
         pHEpKNc2VjSOOGDR9tvIvzBztibrLlJTXG+uuhmBlzR6pNfask9Ao9ekFLrdJwWGb/1o
         4A2TH6mAYWyQj7Drdr3re/Gk0XxeyMc9fqkjT6Hc7kdDjhejs+EWGXBmpTvXzbFTjy6Z
         KKqxVg56QGsb0rsChcPvEMYzzma2cKLxpvHQJuhAB2RtZzeUzmMxAQFE4ULyYrmNGWKR
         kgPCH9/kCI5U/S54gV7aKgg6blNmkGGMJbDQP4r7LLgRbS4DxTNR242uxWWGOq/V4/IX
         RpVg==
X-Forwarded-Encrypted: i=1; AJvYcCU+vaCTYgcZKNGhjSMYkPuZHiH/XrlwehPuGI/9+mYVEgaekH36brZ73JFCs31Y5hgkKLLn1OFQ3dVsF7kLcORA5w==@vger.kernel.org, AJvYcCVQHmdBgh0XHQXjMXWPlgYasYLf8/moRqDeugQiIa8jso5Z4wl5t2wwY7yg7Ot1/IsO6Gw=@vger.kernel.org, AJvYcCWEu1EMHEFfE1vJ11WOgjWT08cJqBSSE7Zp26FXr2nUTmT1MMRnMqRzMdzBI70ayiWPbFpVNNaDdCpUvT1WQw==@vger.kernel.org, AJvYcCXOAkPoJGyT+ZqcUJVCIJkBhQH3G8A1S9JXYuw2aYcJ8MRn4TCnTQsdvIL9965Lrq29GX1kX6wnmV7GkBsV@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVX1ilvAqyeaOLqFXypMao24/Hvv7G6GyaoBqNi0wkCNA9yzd
	gfPUpZdaqVdDJ8e9FkPLzJPwWWR0rqAULcdnoqZ26sEqiELwyzhw/9btcvNJSo4EgCxxX17jE2Z
	k0WF51giDxAePGfx/86R5ifBfdZ0=
X-Gm-Gg: ASbGncs7POnPp9w/Amd0I4IfJvh94mJs2+zCeQ4RZsuMm2enToT3vt8HfjY9ss6MPRG
	AGzF8JdgXsi78UGmUK0e9elifbKOhex8ue7iAGHKH2SkHH+81aO6fUuVEMeCjiQqz29xpMOk2zP
	wBDNYV9sZgLDmqMJd7A4O7UtcdtX7GH//WXpRbT4FhdQ==
X-Google-Smtp-Source: AGHT+IEBSskNXsIbuqDvn/U9LSu6LemK4P3tlqREkuD8KUd3EhC5S8wl7sbDcR2Rt95XQ/sMlfmu/6VNCXsvhSJaXm8=
X-Received: by 2002:a05:6a00:3a1e:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-739e48f9521mr216458b3a.3.1743697040257; Thu, 03 Apr 2025
 09:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121820.455916-1-bhupesh@igalia.com> <20250331121820.455916-2-bhupesh@igalia.com>
In-Reply-To: <20250331121820.455916-2-bhupesh@igalia.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 3 Apr 2025 09:17:07 -0700
X-Gm-Features: AQ5f1JoPHx0PeSv2IqtIqL5NZPMMksgJM8eq0HuoqlbPglyYkI1vhpYvqJ-LgI4
Message-ID: <CAEf4Bza1xjSD9KPkB0gE6AN0vc=xejW-jkn0M_Z_pSQ4_7e7Jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 5:18=E2=80=AFAM Bhupesh <bhupesh@igalia.com> wrote:
>
> Provide a parallel implementation for get_task_comm() called
> get_task_full_name() which allows the dynamically allocated
> and filled-in task's full name to be passed to interested
> users such as 'gdb'.
>
> Currently while running 'gdb', the 'task->comm' value of a long
> task name is truncated due to the limitation of TASK_COMM_LEN.
>
> For example using gdb to debug a simple app currently which generate
> threads with long task names:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
>
>   NameThatIsTooLo
>
> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
> that all the legacy / existing ABI, continue to work as before using
> '/proc/$pid/task/$tid/comm'.
>
> This patch only adds a parallel, dynamically-allocated
> 'task->full_name' which can be used by interested users
> via '/proc/$pid/task/$tid/full_name'.
>
> After this change, gdb is able to show full name of the task:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
>
>   NameThatIsTooLongForComm[4662]
>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  fs/exec.c             | 21 ++++++++++++++++++---
>  include/linux/sched.h |  9 +++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index f45859ad13ac..4219d77a519c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  {
>         struct task_struct *me =3D current;
>         int retval;
> +       va_list args;
> +       char *name;
> +       const char *fmt;
>
>         /* Once we are committed compute the creds */
>         retval =3D bprm_creds_from_file(bprm);
> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>                  * detecting a concurrent rename and just want a terminat=
ed name.
>                  */
>                 rcu_read_lock();
> -               __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.=
dentry->d_name.name),
> -                               true);
> +               fmt =3D smp_load_acquire(&bprm->file->f_path.dentry->d_na=
me.name);
> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);

this `args` argument, it's not initialized anywhere, right? It's not
clear where it's coming from, but you are passing it directly into
kvasprintf(), I can't convince myself that this is correct. Can you
please explain what is happening here?

Also, instead of allocating a buffer unconditionally, maybe check that
comm is longer than 16, and if not, just use the old-schoold 16-byte
comm array?


> +               if (!name)
> +                       return -ENOMEM;
> +
> +               me->full_name =3D name;
> +               __set_task_comm(me, fmt, true);
>                 rcu_read_unlock();
>         } else {
> -               __set_task_comm(me, kbasename(bprm->filename), true);
> +               fmt =3D kbasename(bprm->filename);
> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);
> +               if (!name)
> +                       return -ENOMEM;
> +
> +               me->full_name =3D name;
> +               __set_task_comm(me, fmt, true);
>         }
>
>         /* An exec changes our domain. We are no longer part of the threa=
d
> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>         return 0;
>
>  out_unlock:
> +       kfree(me->full_name);
>         up_write(&me->signal->exec_update_lock);
>         if (!bprm->cred)
>                 mutex_unlock(&me->signal->cred_guard_mutex);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 56ddeb37b5cd..053b52606652 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1166,6 +1166,9 @@ struct task_struct {
>          */
>         char                            comm[TASK_COMM_LEN];
>
> +       /* To store the full name if task comm is truncated. */
> +       char                            *full_name;
> +
>         struct nameidata                *nameidata;
>
>  #ifdef CONFIG_SYSVIPC
> @@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *ts=
k, const char *from, bool exec
>         buf;                                            \
>  })
>
> +#define get_task_full_name(buf, buf_size, tsk) ({      \
> +       BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);      \
> +       strscpy_pad(buf, (tsk)->full_name, buf_size);   \
> +       buf;                                            \
> +})
> +
>  #ifdef CONFIG_SMP
>  static __always_inline void scheduler_ipi(void)
>  {
> --
> 2.38.1
>

