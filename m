Return-Path: <linux-fsdevel+bounces-61871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7CB7C805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF11892D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880FB2FB094;
	Wed, 17 Sep 2025 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQuphdWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C942FA0F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080702; cv=none; b=mb1eS33TCHFuRZ+a58t85Jw9WfGpmJuJYB6R6yAc8yFB1zqzAQgkCiMc1gIKwtZFhESqNj0O9dSHnkKFmn2jUzjMf51MMS3wEdixEhoBPPdBPXvwrdW8Lv4HrAVeuGpWjTob8jyjB2XdEKZTTTdddayaAb6LlRGggE4CT0EDOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080702; c=relaxed/simple;
	bh=oa0vHhrxyZCIIgVXIZyHtxCkFNV7aqhzkqAkyDBQVQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxFi8ZHTCva2hr6RljXSQ+i57FY6ffeAO/oQL+ePZpOt1IqdHqiEYNg8U1J6vcLB5mUR02sCuPyhh5Dm78KJ24G/I+D4qEjSqj9v38izGKTZf/Dl8NEk4MITXRzTlP0ndis/OQzpDQVW4uzlYlxP/s0Jh7DxGEkzZj5lq3/lSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQuphdWc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f1987d4b2so7163464a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 20:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758080698; x=1758685498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8lC4ZFoQIKqgBAuP6ysNsXfK9CM7H9836ItXVZ6+84=;
        b=eQuphdWcUR3AZgwSRAsLuolzXv652B+ToHBfOZuFkaU2K+jKRvei5eZWfDFKAe43Or
         nJCYiaVPEA8wBUOzBK4ZMsdsAizMMdPzdfOkzCy5X1l3AWn9O20MLoTrVXa0/6av6hXX
         YvqNQUjYH+tmxbTFqlE+sHnLxlAJMT3n3OPFF8q9kK7YpNpVp4+ajcpTjKhjl5dIrsHU
         ZYdg5nAnegcUfvAXliTykQmlVYB60+Lc8SQ4IjZaOvJNh29Jh5O0L8cvt+db9MUp4Lu/
         QyDUq4vw/ilriF1v6jWd3IoZ0Jn9GRqNMoWxsIpRvkSnvdna7hmkEKedSmgpNptbNjHw
         CDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758080698; x=1758685498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8lC4ZFoQIKqgBAuP6ysNsXfK9CM7H9836ItXVZ6+84=;
        b=EMYxFSb/BOfYD52TBSh+mMPs1ffdKgwethEAZ+50IC8a/zR2NMqkTTh0HtIjjUADP2
         ZTdotZzOnJ/szLmbg+wqJENkky0HWdK1ZJMAwwxYmmXoV0KOGqB+nXBw1Di61A8ZKnvJ
         aN8Ot82LXO+vpuyhQ4RcXt6smQ69sWepr2TyqH6lWfc8PXo90VKFTYi2co7pDpt02b9e
         ULZPR+wD/xcITxyC3yct8IsmnwpZCPYYP8DOdrPjloyUTZxG7jV4qyXzYOUHjeOfYFR4
         KsjcSWgSgIkiGLHyUeOyirDuUelLdhYDVe8EHZqjV9NY17iyXkoAi4qIm36QeaZqV0UC
         0HkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgqOPStX5TXsqIeRFQuuKe15euQBLCVtsCLjpx4e0mYaV7kbu4TX2rclYacDPm0XNvqqh3Qimk/YIR9vBH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z1iy14MZop69gAAd7UFiA2sj6IL/2WjHxLYI6M9vBNxLbEHf
	rotbT8NXh1CmsxEywqKO4CtiZbQb33OXuHuJaB135AbDOzA0d4Hf2e55LfpmEpXkMMwrRzbt5ax
	p5iPLPFP4AVHb+hqMVDLg//1f/89r7ik=
X-Gm-Gg: ASbGnctuFPTqCZ0ksozXpBafn7Vls+wKQXGbFiQAXv8LXvJ2H0rssvxWOS0cYb0cbHM
	2lEs5eru00vez/kg6lE4H2OnQnHUxkvzN6FPfK3hCWmuHiuAlzAKKx+JYLkywZWm/prGVO48Gkc
	Ta3diFqR8RXHqLLE+uB95czKio9Wdrg3kFhDfCvTMfz20Xp9pFB2eX+TVsRbYFBadAEup94JFY0
	jbvMBY0QVyhfrAlSrg/QIAU1vvxqFPV+gxKpI4=
X-Google-Smtp-Source: AGHT+IEkYVhQ2BZ2Ni4lk201OVQduO9+WF3uVv+BNAqFBXXk1/sOTq+gX54m7iTfh6s8Rv0RYqaeBmydmJOWP+kWstU=
X-Received: by 2002:a05:6402:848:b0:62f:257a:2865 with SMTP id
 4fb4d7f45d1cf-62f83c2db06mr839202a12.14.1758080698272; Tue, 16 Sep 2025
 20:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
In-Reply-To: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 05:44:45 +0200
X-Gm-Features: AS18NWA4pz9gr9bYS9xpf4rQWT9q9ZICfmD5jpg_w2UAGJFAppEKdLNhzA9z5go
Message-ID: <CAGudoHGs8LNQ9qT8k0dibgMLVoyjYM2FrNwgNMA-AzV5yz72GA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow to mark /proc files permanent outside of fs/proc/
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. This fell through the cracks.

Can you please resubmit your patch with my name dropped from it? It's
basically all you.

Alternatively perhaps Christian will be happy to do the edits?

After this is sorted out I'll resend my thing altering how the content
of the file is generated.

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
> --
> 2.47.0
>

