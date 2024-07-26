Return-Path: <linux-fsdevel+bounces-24308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3493D0FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651A2B21AB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7EB178CDE;
	Fri, 26 Jul 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlkI1ziY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E22B9C4;
	Fri, 26 Jul 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989137; cv=none; b=vC99Dt3ivAJltkNAIk/UfEn3u2DUc3sDfIg/MkcIPPHUUcDyhrxuao4es8IMg4eM0TZfAdoDsQpxbVf4AOKHBd4k9rfcAlCzUUHfQ5nxWlX//6I3J0+3cUfvT02s9IjHD8tgbaRsaVXHtS5vCIy/IC1gVycfuy73lkaWIwJ6kRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989137; c=relaxed/simple;
	bh=Vl/Awbyoo4KAidoa5fcjjrV8769SV1OfqcUrdbgJFmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCJ62ISFbOqJIgsFoyOBvTjVOHo6cB0hE+62J75t8QhU1vYgRRWmE1UB2MxChidvPQQ4x9BLD8xQZJJhlXSZA//FDeac+xeKk0K9On7tD/dWzwyTSH693sXncosVP8yJ8q2PdAyJZRFa4G9Psk3yLtniaKMZwmx8ZQBJOV3Zq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlkI1ziY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3923C4AF07;
	Fri, 26 Jul 2024 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989136;
	bh=Vl/Awbyoo4KAidoa5fcjjrV8769SV1OfqcUrdbgJFmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlkI1ziYE+BtmN/udhW+U9iFE9aQU6C7dc7vbhLkxAVYNmG7VnhkCEsOMGojBlXar
	 mwmTpfwVOmLlq00D4Tw+U3/T9mJYBYa/wCEW74gNMmG5uVSu6/Rlp8IZPOGnv+1skW
	 7eJsrckLpJcW0X4HRXQzXHBQ1cEQF3sOWqhTrjszpAYTjYpSut+kASy+8jnPM1Yyw1
	 oFW0Ee1Eq/DG49Mm3T6nQPgFH9dGi8G2sBRCS0eNACnDFxb3c3CXkGdLJgjx5myqz7
	 vRdOnLa7m2luRoQbLbjvYPpTP9nn5Nt9jS8BYCc8oQYwHTW/ZT2O7YYPfoP1vtx0EF
	 l253am/EhZJ4w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1648293e87.2;
        Fri, 26 Jul 2024 03:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs7PEKo/iaU0dGNkcxpq02e9WANRWKYqfJuFiSGx6+l5JNDu8Z/0P/8MHFUvbqpGyh3zN/AyVIARtha/mmexPCCLuz/nyrVspuHILXkAnrEOe1OCAqKik+4waEkDTGI7qRSlBXyFPN4U5eNFKFwsGDQYIqr/LvsVsd+nBRTJ0YS1v7MvfALbCF/w7akuJK03L9mH/Z
X-Gm-Message-State: AOJu0YztFaLlat2T080nBCf7vvtj9+Z2S/AwzFABYie26yE2yTAEhZjZ
	dVGvV9cu6skdpwl/g0/1/0ybbppdrbJR6v3uwqJ+ilFe+GIrmK8SoUHNGreG0RY7uEGWNLfYyEd
	7fMSzqVKjIEDLyg0K2DIzRHO9thg=
X-Google-Smtp-Source: AGHT+IHe+AmLjrcRbmhxlqy6g4R3ho9sqPdtKPBE3G9WLql7LqDiIHh1LhiZdFLsSOvzHp/1EeI4dE7NaIAZx3LWcao=
X-Received: by 2002:a05:6512:308d:b0:52e:be14:7012 with SMTP id
 2adb3069b0e04-52fd3f24d19mr4009464e87.32.1721989135101; Fri, 26 Jul 2024
 03:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726090858.71541-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240726090858.71541-1-adrian.ratiu@collabora.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jul 2024 12:18:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE-MLYdckRptBzaLM26nFqOB9K2xLuKdVAzdkHOS=FFCA@mail.gmail.com>
Message-ID: <CAMj1kXE-MLYdckRptBzaLM26nFqOB9K2xLuKdVAzdkHOS=FFCA@mail.gmail.com>
Subject: Re: [PATCH v3] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 11:11, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.
>
> The traditional forcing behavior is kept as default because
> it can break GDB and some other use cases.
>
> Previously we tried a more sophisticated approach allowing
> distributions to fine-tune /proc/pid/mem behavior, however
> that got NAK-ed by Linus [1], who prefers this simpler
> approach with semantics also easier to understand for users.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com/ [1]
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v3:
> * Simplified code to use shorthand ifs and a
>   lookup_constant() table.
>
> Changes in v2:
> * Added bootparam on top of Linus' patch.
> * Slightly reworded commit msg.
> ---
>  .../admin-guide/kernel-parameters.txt         | 10 ++++
>  fs/proc/base.c                                | 54 ++++++++++++++++++-
>  security/Kconfig                              | 32 +++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c1134ad5f06d..793301f360ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4791,6 +4791,16 @@
>         printk.time=    Show timing data prefixed to each printk message line
>                         Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>
> +       proc_mem.force_override= [KNL]
> +                       Format: {always | ptrace | never}
> +                       Traditionally /proc/pid/mem allows users to override memory
> +                       permissions. This allows people to limit that.

Better to use passive tense here rather than referring to 'users' and 'people'.

'Traditionally, /proc/pid/mem allows memory permissions to be
overridden without restrictions.
This option may be set to restrict that'

> +                       Can be one of:
> +                       - 'always' traditional behavior always allows mem overrides.

punctuation please

> +                       - 'ptrace' only allow for active ptracers.
> +                       - 'never'  never allow mem permission overrides.

Please be consistent: 'mem overrides' or 'mem permission overrides' in
both instances.

> +                       If not specified, default is always.

'always'

> +
>         processor.max_cstate=   [HW,ACPI]
>                         Limit processor to maximum C-state
>                         max_cstate=9 overrides any DMI blacklist limit.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..0ca3fc3d9e0e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -85,6 +85,7 @@
>  #include <linux/elf.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/user_namespace.h>
> +#include <linux/fs_parser.h>
>  #include <linux/fs_struct.h>
>  #include <linux/slab.h>
>  #include <linux/sched/autogroup.h>
> @@ -117,6 +118,35 @@
>  static u8 nlink_tid __ro_after_init;
>  static u8 nlink_tgid __ro_after_init;
>
> +enum proc_mem_force {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +static enum proc_mem_force proc_mem_force_override __ro_after_init =
> +       IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
> +       IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
> +       PROC_MEM_FORCE_NEVER;
> +
> +struct constant_table proc_mem_force_table[] = {

This can be static const __initconst

> +       { "always", PROC_MEM_FORCE_ALWAYS },
> +       { "ptrace", PROC_MEM_FORCE_PTRACE },
> +       { }
> +};
> +
> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +

Can this ever happen?

> +       proc_mem_force_override = lookup_constant(proc_mem_force_table,
> +                                                 buf, PROC_MEM_FORCE_NEVER);
> +
> +       return 0;
> +}
> +early_param("proc_mem.force_override", early_proc_mem_force_override);
> +
>  struct pid_entry {
>         const char *name;
>         unsigned int len;
> @@ -835,6 +865,26 @@ static int mem_open(struct inode *inode, struct file *file)
>         return ret;
>  }
>
> +static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> +{
> +       switch (proc_mem_force_override) {
> +       case PROC_MEM_FORCE_NEVER:
> +               return false;
> +       case PROC_MEM_FORCE_PTRACE: {
> +               bool ptrace_active = false;
> +               struct task_struct *task = get_proc_task(file_inode(file));
> +
> +               if (task) {
> +                       ptrace_active = task->ptrace && task->mm == mm && task->parent == current;
> +                       put_task_struct(task);
> +               }
> +               return ptrace_active;
> +       }

This indentation looks dodgy. If you move the local var declarations
out of this block, and use assignments instead, you don't need to  { }
at all.


> +       default:
> +               return true;
> +       }
> +}
> +
>  static ssize_t mem_rw(struct file *file, char __user *buf,
>                         size_t count, loff_t *ppos, int write)
>  {
> @@ -855,7 +905,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
>         if (!mmget_not_zero(mm))
>                 goto free;
>
> -       flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
> +       flags = write ? FOLL_WRITE : 0;
> +       if (proc_mem_foll_force(file, mm))
> +               flags |= FOLL_FORCE;
>
>         while (count > 0) {
>                 size_t this_len = min_t(size_t, count, PAGE_SIZE);
> diff --git a/security/Kconfig b/security/Kconfig
> index 412e76f1575d..a93c1a9b7c28 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -19,6 +19,38 @@ config SECURITY_DMESG_RESTRICT
>
>           If you are unsure how to answer this question, answer N.
>
> +choice
> +       prompt "Allow /proc/pid/mem access override"
> +       default PROC_MEM_ALWAYS_FORCE
> +       help
> +         Traditionally /proc/pid/mem allows users to override memory
> +         permissions for users like ptrace, assuming they have ptrace
> +         capability.
> +
> +         This allows people to limit that - either never override, or
> +         require actual active ptrace attachment.
> +
> +         Defaults to the traditional behavior (for now)
> +
> +config PROC_MEM_ALWAYS_FORCE
> +       bool "Traditional /proc/pid/mem behavior"
> +       help
> +         This allows /proc/pid/mem accesses to override memory mapping
> +         permissions if you have ptrace access rights.
> +
> +config PROC_MEM_FORCE_PTRACE
> +       bool "Require active ptrace() use for access override"
> +       help
> +         This allows /proc/pid/mem accesses to override memory mapping
> +         permissions for active ptracers like gdb.
> +
> +config PROC_MEM_NO_FORCE
> +       bool "Never"
> +       help
> +         Never override memory mapping permissions
> +
> +endchoice
> +
>  config SECURITY
>         bool "Enable different security models"
>         depends on SYSFS
> --
> 2.44.2
>
>

