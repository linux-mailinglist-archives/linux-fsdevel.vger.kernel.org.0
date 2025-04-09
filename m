Return-Path: <linux-fsdevel+bounces-46133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B085A831E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3E17AB47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592652116FB;
	Wed,  9 Apr 2025 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlR+CXiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF7101C8;
	Wed,  9 Apr 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230447; cv=none; b=H08SvxGZOB+zMSgHQWr8hh5jMMLoKef7OK2NDVy3aydZQMYvv0ZBlv5wRTdaYKAfAjCzglXlmhRXbv1cEgZ9ldiMiMzw5FuPK7k+ax3QrKn1lamJ8PkhDI3KYXIzCnyzSG26tPdEsDIQi4GYtCPxyVbID66XAWt0M3OfXj5EWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230447; c=relaxed/simple;
	bh=fEbv5zBpraILF+Ghnm54tkWozFw0v+CbBgAZephHFoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tbs19YqjXApIMgxAnCCZMF2yITpKE+l4aQRmR6gUnMIpxMhpCI7xK1czvMhN4adOjJOywNIIxn3MAXVh0sNFSCDpMyqlHYCScgD/Z14os2dN3IEnvaMBHu7mQ5ptYJ6yxHFBuLPfQMibbKTLLawPJeO6kJMCf1uLaCJJk4rapdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlR+CXiY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso177680a12.2;
        Wed, 09 Apr 2025 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744230444; x=1744835244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0LAM8wut9PB5pz05xM4sp997UQqATNN0PYbo23aLv4=;
        b=mlR+CXiY76+zgimfpKpIIituwjq2EFuj+J1ujP8DcK8Rn1WmJHzcuZoHF6Yo0ZBPXw
         DtR4Rf72BOlVNBGs//Hd4U8mHqWw/1uWMfZYI/n8N5kPPOzhPUMVHPNO8Tq737cjVJXG
         j3bjQxUKivfzQatd3qdPKfzTVTiZRLGbiuWwd9i0SV4XanTz9b4W+nSO3lUPLRu/BSSh
         MFGLYTO8+GFN7xYHobFAr30FksIlVR5N6ipbs0Sle74P0A/L9h4H3srXC58Ip5ymVDzT
         NRpjJ2YsYNjvRnEXUhHEYUeHKni47EaesCyFO8kFt1WhY5vtL4yVWDS+wQlrDyaE4c7J
         lFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744230444; x=1744835244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0LAM8wut9PB5pz05xM4sp997UQqATNN0PYbo23aLv4=;
        b=pVSKY/fcSj4L0xxCB8EJiTbL/N7RCb3UqHw14f4yvuRAb/9uUCMFpASsvxupG+2kn+
         eHvrMXCbUwm3ICRazqq+HkC1jF9jidQ5BJBspL6ZqfxYGsl/Gboh+AC21I68ahmdEjVU
         QYn7cbY5w+kj7UNaRYqlTY5S1U5ZYEHUplszqm2Jvv48AQbXZ67cT+9aAk/lLI+GYsgv
         aY4lLCUbcH7pBT8OKVGrzgmp0eBPATAq65/cLlDFNXX5LNaGtIAcBHK4w4UQDjdnb6wP
         +P7hjAkbzRfXiCG7td6hFJ/O81gA6nQ2Ng6Blq/DT/Siin5JUBMAGCmNTa/sRWN9csdw
         6k2w==
X-Forwarded-Encrypted: i=1; AJvYcCUfL2KWWk/jnR8Xetszmio37Yik2gFjiZzP6Am233MYVbMKzFZk/zbWZwoNYRCuOiCS9fICbEP3akrIhulW@vger.kernel.org, AJvYcCXahGeo4U3TYt+parNNNsnNsUG3KGs7D4W/mt/pNzgesECfHEz1TUZK4TValHL65brLgwEl5lGPQeqPcPOT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn36rGRTstUbGa3Eae6V44pa0WIWyfNciff+V4aYV7fnGG51Ky
	QD8/VgjydWJ1qR7nkMw7SjHzj3jKFDdsV2S37gsv9Qgx2YXhj1TaLL3CGVFXYncRvHo7KptwILC
	XBc1KpY/zPAbObgraX5LZOSwsLyk=
X-Gm-Gg: ASbGncsRZSGjSQE//hEt2UTRlYr2uuqO/0Loaeyy32xlsJB0oFSUsDL67k5gYxwFDeE
	2yVEWgbmUJepvHROWFvltnWP8nKL7Gzu5OJmCC9JesRQQ+gUU+6+4/ab3Kv8PdhMyafCo3FSJ/8
	FaWB5kjocDh32kXHztYujo
X-Google-Smtp-Source: AGHT+IGuQy4DnmjwQ9A6RQoT1MD/6UgYznoCA9Kpk7nYN37cfGWMeQEMlO/3HPRLThtJNF2da/qGvE7mElSV2NyMWXM=
X-Received: by 2002:a05:6402:4416:b0:5f2:1572:643b with SMTP id
 4fb4d7f45d1cf-5f3290edbebmr227085a12.0.1744230444042; Wed, 09 Apr 2025
 13:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
In-Reply-To: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 9 Apr 2025 22:27:12 +0200
X-Gm-Features: ATxdqUGtAF0YoVOpwXPnhA1JTNpmAMSamK1sRZQNMtQLNmmBN_hoYbY-w1Rn9SQ
Message-ID: <CAGudoHGtvBArbAhpynYLd=FzshR+UM-qx=n_1wOq1BPqW9nTXA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow to mark /proc files permanent outside of fs/proc/
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:20=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.com=
> wrote:
>
> From 06e2ff406942fef65b9c397a7f44478dd4b61451 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Sat, 5 Apr 2025 14:50:10 +0300
> Subject: [PATCH 1/1] proc: allow to mark /proc files permanent outside of
>  fs/proc/
>
> From: Mateusz Guzik <mjguzik@gmail.com>
>
> Add proc_make_permanent() function to mark PDE as permanent to speed up
> open/read/close (one alloc/free and lock/unlock less).
>
> Enable it for built-in code and for compiled-in modules.
> This function becomes nop magically in modular code.
>
> Use it on /proc/filesystems to add a user.
>
>                 Note, note, note!
>
> If built-in code creates and deletes PDEs dynamically (not in init
> hook), then proc_make_permanent() must not be used.
>
> It is intended for simple code:
>
>         static int __init xxx_module_init(void)
>         {
>                 g_pde =3D proc_create_single();
>                 proc_make_permanent(g_pde);
>                 return 0;
>         }
>         static void __exit xxx_module_exit(void)
>         {
>                 remove_proc_entry(g_pde);
>         }
>
> If module is built-in then exit hook never executed and PDE is
> permanent so it is OK to mark it as such.
>
> If module is module then rmmod will yank PDE, but proc_make_permanent()
> is nop and core /proc code will do everything right.
>
> [adobriyan@gmail.com: unexport function (usual exporting is a bug)]
> [adobriyan@gmail.com: rewrite changelog]
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  fs/filesystems.c        |  4 +++-
>  fs/proc/generic.c       | 12 ++++++++++++
>  fs/proc/internal.h      |  3 +++
>  include/linux/proc_fs.h | 10 ++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 58b9067b2391..81dcd0ddadb6 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -252,7 +252,9 @@ static int filesystems_proc_show(struct seq_file *m, =
void *v)
>
>  static int __init proc_filesystems_init(void)
>  {
> -       proc_create_single("filesystems", 0, NULL, filesystems_proc_show)=
;
> +       struct proc_dir_entry *pde =3D
> +               proc_create_single("filesystems", 0, NULL, filesystems_pr=
oc_show);
> +       proc_make_permanent(pde);
>         return 0;
>  }
>  module_init(proc_filesystems_init);
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index a3e22803cddf..0342600c0172 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -826,3 +826,15 @@ ssize_t proc_simple_write(struct file *f, const char=
 __user *ubuf, size_t size,
>         kfree(buf);
>         return ret =3D=3D 0 ? size : ret;
>  }
> +
> +/*
> + * Not exported to modules:
> + * modules' /proc files aren't permanent because modules aren't permanen=
t.
> + */
> +void impl_proc_make_permanent(struct proc_dir_entry *pde);
> +void impl_proc_make_permanent(struct proc_dir_entry *pde)
> +{
> +       if (pde) {
> +               pde_make_permanent(pde);
> +       }
> +}
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 96122e91c645..885b1cd38020 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -80,8 +80,11 @@ static inline bool pde_is_permanent(const struct proc_=
dir_entry *pde)
>         return pde->flags & PROC_ENTRY_PERMANENT;
>  }
>
> +/* This is for builtin code, not even for modules which are compiled in.=
 */
>  static inline void pde_make_permanent(struct proc_dir_entry *pde)
>  {
> +       /* Ensure magic flag does something. */
> +       static_assert(PROC_ENTRY_PERMANENT !=3D 0);
>         pde->flags |=3D PROC_ENTRY_PERMANENT;
>  }
>
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index ea62201c74c4..2d59f29b49eb 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -247,4 +247,14 @@ static inline struct pid_namespace *proc_pid_ns(stru=
ct super_block *sb)
>
>  bool proc_ns_file(const struct file *file);
>
> +static inline void proc_make_permanent(struct proc_dir_entry *pde)
> +{
> +       /* Don't give matches to modules. */
> +#if defined CONFIG_PROC_FS && !defined MODULE
> +       /* This mess is created by defining "struct proc_dir_entry" elsew=
here. */
> +       void impl_proc_make_permanent(struct proc_dir_entry *pde);
> +       impl_proc_make_permanent(pde);
> +#endif
> +}
> +
>  #endif /* _LINUX_PROC_FS_H */

This diff should not be changing /proc/filesystems, that's for the
other patch to do.

So I think this patch is all you and my name needs to be dropped from
it, along with marking /proc/filesystems as permanent.

Given that you kept the name (proc_make_permanent), the
fs/filesystems.c side of things is identical so my first patch can be
just swapped for this one.

Alternatively I can resend the patchset with this (augmented as
described above).
--=20
Mateusz Guzik <mjguzik gmail.com>

