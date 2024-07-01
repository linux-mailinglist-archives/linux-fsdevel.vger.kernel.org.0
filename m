Return-Path: <linux-fsdevel+bounces-22893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C591E6C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D15285C38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026B316EB67;
	Mon,  1 Jul 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5o+ZVLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56B2A1D3;
	Mon,  1 Jul 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855672; cv=none; b=LgpANM1QSS1q1TixpORdsxwHJCNRI2dKzPyi4jJxESMbtVb2qc9OTj2nPCnScVKh7xu82CrXSYJS6WMaeY8TpjamMEfoD1x7pxBh2dqhJQ4R0k9yF8F8ElSGEnRbeO1d+NbyUtlIFQ8K5SLqRUqotDx+UF3UAgQAVDHz85f6NjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855672; c=relaxed/simple;
	bh=D30lWS9cNuL/PyG9DqAw+dkkjmfhHDQKpiUlEs54iXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRirieFhf1nE/hkHoHCzA9df60o+VXxzsXRPkieGRserh8/oGMyJV8Wg89VJPZ8WLQAX13Kyo57pMqiVXSaC+t08kInDjFN4GphJobaJugG61iZZhgUIlckX42SBvLj8r7fK78R2T/BTwlu0Fzq+XgAGq6Iy8qZgAtJ6LFoip4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5o+ZVLv; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c444e7d196so849439eaf.1;
        Mon, 01 Jul 2024 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719855670; x=1720460470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz2PXaK1fBTz/chHttDXyvAV78LrNcExjcb6CqQnGw0=;
        b=j5o+ZVLvzgkdvU3lRMnFj+wXLABU2F5m3tQotpZRx48DodjAPr27uN1ZM+PfcUuBw3
         89WZ1e5tQy7QmVt9fCPtJ79EwRr9I4envTtXVB676hWUN+WLJ4vEx4bAvq6fs4i7HTpu
         znDjpvcpPKnr+jKZX7Qkf0CaDoPHWjLpMqLsLNU1l9RJVm0qPbkH3HtpmVqwMyj1wK6Z
         7Sa+fJx/tW82bEC80TORfvXvszdUvxovI6t1DQMGXm+IUzSVvbV+ABI03+MwamagdFca
         2XvNP6940j4g5FcTBR9yeXWNdrg+gLB8JdGvdxX39Gr2+5ycLRl7I4T5XMHzElxgZnPs
         O0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855670; x=1720460470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz2PXaK1fBTz/chHttDXyvAV78LrNcExjcb6CqQnGw0=;
        b=QhiQi0edQLxmy+YWTbKEDUo0jvkJJMDVOl6Q5XeX6R4WbGOnQG9PUdOCOUrcL3KpUL
         f1fED6YOQfPKHOOokNusyCVpNINkvmX5f7hlK/s4kHTfArw9fUptJFv3Eb3ADiVG5ua0
         8o8P3mlkJRkGL9YOi+TD4yQ018FA2yUyTO9KuFF7pNiWyarAsm9k2RjHtQK2okpeZWc4
         kcpsIpf6qZqGoxmmldpUDsQqa1gAy3pDfyfjGKFmcHs1FONbGS5+T7m9qHAVUuZGZwzM
         4dk5XPkQynPthEcHZoxgSAaDeY/E8Krk6imhDJk7zIcer1XnP5Fotuz1m+/eHfklj6kD
         WJvw==
X-Forwarded-Encrypted: i=1; AJvYcCWb891kLo+7OdlDX/1NVKVQFejyHOU8/zqlexGk/rMcIEKbL/6SZuPAQFT4rP+ewz/xvD8foghOGTuVSifu3Mhr7eEesV4zvIsDpVmKTxkA6fIZJA3yhotuOKosWfr4tZ407lw9Nm7jm/EocA==
X-Gm-Message-State: AOJu0YxYzavRF1n5sDIWIHMbAAEBSAiUvSos1oWkjoQz9kMx2+1UZmTz
	aXFhzmeWCMDq4waehH/nD6Gei7pKzLE8AfT9UwM+XwNcgfKO+VlKXNtKmlWDt69TzSJVUmmxF/p
	yAQfhVP5F1sgI6f1EkRQP8ktuH3roNQ==
X-Google-Smtp-Source: AGHT+IHG5CgH8tYtIHgUDpdKp4PkrbNiyZsqUwtvOBsBzeuR99snzSMW2I3ufdCQyt0ea7AMuYziV6qaeYPwHuB3yb8=
X-Received: by 2002:a05:6870:2182:b0:254:a7ef:b714 with SMTP id
 586e51a60fabf-25db35cc52emr5607015fac.58.1719855669933; Mon, 01 Jul 2024
 10:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsk85UOsa0ijXcYRvvZLXEMQKe4phWhND+0qSNP36N5Tw@mail.gmail.com>
 <5f1f44be-80ad-4b4e-90a0-c2e4e8cd3dbf@app.fastmail.com>
In-Reply-To: <5f1f44be-80ad-4b4e-90a0-c2e4e8cd3dbf@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 10:40:57 -0700
Message-ID: <CAEf4BzaxM=dNhtTRn44jaEqrdcufUv3HmEfFc2d2mV=Y5e2xbQ@mail.gmail.com>
Subject: Re: fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
 different size
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 1, 2024, at 12:19, Naresh Kamboju wrote:
> > fs/proc/task_mmu.c: In function 'do_procmap_query':
> > fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
> > different size [-Werror=3Dint-to-pointer-cast]
> >   598 |         if (karg.vma_name_size && copy_to_user((void __user
> > *)karg.vma_name_addr,
> >       |                                                ^
> > fs/proc/task_mmu.c:605:48: error: cast to pointer from integer of
> > different size [-Werror=3Dint-to-pointer-cast]
> >   605 |         if (karg.build_id_size && copy_to_user((void __user
> > *)karg.build_id_addr,
> >       |                                                ^
> > cc1: all warnings being treated as errors
> >
>
> There is already a fix in linux-next:
>
> @@ -595,14 +595,14 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
>         query_vma_teardown(mm, vma);
>         mmput(mm);
>
> -       if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_na=
me_addr,
> +       if (karg.vma_name_size && copy_to_user((void __user *)(uintptr_t)=
karg.vma_name_addr,
>                                                name, karg.vma_name_size))=
 {
>                 kfree(name_buf);
>                 return -EFAULT;
>         }
>
>
> This could be expressed slightly nicer using u64_to_user_ptr(),
> but functionally that is the same.

oh, of course we have a helper for that. I will update my patch, I
don't think Andrew has applied it to mm-unstable just yet, thanks for
suggestion!

>
> I also see a slight issue in the use of .compat_ioctl:
>
>  const struct file_operations proc_pid_maps_operations =3D {
>         .open           =3D pid_maps_open,
>         .read           =3D seq_read,
>         .llseek         =3D seq_lseek,
>         .release        =3D proc_map_release,
> +       .unlocked_ioctl =3D procfs_procmap_ioctl,
> +       .compat_ioctl   =3D procfs_procmap_ioctl,
>  };
>
>
> Since the argument is always a pointer, this should be
>
>        .compat_ioctl =3D compat_ptr_ioctl,

Another thing I didn't know about, I'll send a patch to switch to this, tha=
nks!

>
> In practice this is only relevant on 32-bit s390
> tasks to sanitize the pointer value.
>
>      Arnd

