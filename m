Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709E4174A90
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCAArg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 19:47:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33028 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCAArf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:47:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id x8so2819171qts.0;
        Sat, 29 Feb 2020 16:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oH0ncHNV8XxAqVrlyEJMu+Cv/ThtQO/KP6auu0wc1lg=;
        b=JBiw+nr5O2EgoGHCgthrjTdz7ghd30CabF2c+uundh7dsC4b7mbSbngjk96uxG/jvr
         e5rRkJRQEGLQ0N+WskZsaKtdNjhtTYIJ9ebgFphHpkwOAIG/JahVu5TZUN1DdcbxT2lW
         a5mfkrjUFlh3h28Jn7Oh/29PMlxVWDKV8+AIGxrxvr+8EHOwernqvVzetFBN6vl7R5iD
         R6I6s7fQg+WBe7baqhfaO2AyHfwEum5sjtTiC3wzKC9dRfRSi03eSkBpEwddRxWTwHu9
         ubAUriskyPyCgI4lZGA+G5gf2rm0F70MgIPmEy2KJnFtzt8qapgn2gQgSm30UvTW9ydw
         +4pw==
X-Gm-Message-State: APjAAAX0xrs0KF52khBJ24evfxBsulcYd0Miv0wdFBRXyTjIcgkKksrg
        d3e97gko8B+0STC7jt5ialP5SVExXk1RNE13vWg=
X-Google-Smtp-Source: APXvYqyyJpbm+wc92foVb2tgN6GdgD9tF3sjZIJHrWt8MtUjgy13G9NMtx15eXtf5uWPSkPa6budnFBYEhuAcp2cyqM=
X-Received: by 2002:ac8:12c5:: with SMTP id b5mr10245689qtj.386.1583023654212;
 Sat, 29 Feb 2020 16:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200128132539.782286-1-laurent@vivier.eu>
In-Reply-To: <20200128132539.782286-1-laurent@vivier.eu>
From:   YunQiang Su <syq@debian.org>
Date:   Sun, 1 Mar 2020 08:47:23 +0800
Message-ID: <CAKcpw6W8_a3LPMPTph1asU3dCfjXk-xh5_7+MCEFicwTph+EKg@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> 于2020年1月28日周二 下午9:25写道：
>
> It can be useful to the interpreter to know which flags are in use.
>
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
>
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
>

I am suggested to post linux-arch and/or linux-api.

> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     This can be tested with QEMU from my branch:
>
>       https://github.com/vivier/qemu/commits/binfmt-argv0
>
>     With something like:
>
>       # cp ..../qemu-ppc /chroot/powerpc/jessie
>
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 yes
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: POC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       sh
>
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 no
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: OC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       /bin/sh
>
>     v3: mix my patch with one from YunQiang Su and my comments on it
>         introduce a new flag in the uabi for the AT_FLAGS
>     v2: only pass special flags (remove Magic and Enabled flags)
>
>  fs/binfmt_elf.c              | 5 ++++-
>  fs/binfmt_elf_fdpic.c        | 5 ++++-
>  fs/binfmt_misc.c             | 4 +++-
>  include/linux/binfmts.h      | 4 ++++
>  include/uapi/linux/binfmts.h | 4 ++++
>  5 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index ecd8d2698515..ff918042ceed 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>         unsigned char k_rand_bytes[16];
>         int items;
>         elf_addr_t *elf_info;
> +       elf_addr_t flags = 0;
>         int ei_index = 0;
>         const struct cred *cred = current_cred();
>         struct vm_area_struct *vma;
> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>         NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>         NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>         NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -       NEW_AUX_ENT(AT_FLAGS, 0);
> +       if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +               flags |= AT_FLAGS_PRESERVE_ARGV0;
> +       NEW_AUX_ENT(AT_FLAGS, flags);
>         NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>         NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>         NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..abb90d82aa58 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>         char __user *u_platform, *u_base_platform, *p;
>         int loop;
>         int nr; /* reset for each csp adjustment */
> +       unsigned long flags = 0;
>
>  #ifdef CONFIG_MMU
>         /* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>         NEW_AUX_ENT(AT_PHENT,   sizeof(struct elf_phdr));
>         NEW_AUX_ENT(AT_PHNUM,   exec_params->hdr.e_phnum);
>         NEW_AUX_ENT(AT_BASE,    interp_params->elfhdr_addr);
> -       NEW_AUX_ENT(AT_FLAGS,   0);
> +       if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +               flags |= AT_FLAGS_PRESERVE_ARGV0;
> +       NEW_AUX_ENT(AT_FLAGS,   flags);
>         NEW_AUX_ENT(AT_ENTRY,   exec_params->entry_addr);
>         NEW_AUX_ENT(AT_UID,     (elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>         NEW_AUX_ENT(AT_EUID,    (elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..b9acdd26a654 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>         if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>                 goto ret;
>
> -       if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
> +       if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
> +               bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> +       } else {
>                 retval = remove_arg_zero(bprm);
>                 if (retval)
>                         goto ret;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..265b80d5fd6f 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -78,6 +78,10 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
>
> +/* if preserve the argv0 for the interpreter  */
> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  /* Function parameter for binfmt->coredump */
>  struct coredump_params {
>         const kernel_siginfo_t *siginfo;
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index 689025d9c185..a70747416130 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -18,4 +18,8 @@ struct pt_regs;
>  /* sizeof(linux_binprm->buf) */
>  #define BINPRM_BUF_SIZE 256
>
> +/* if preserve the argv0 for the interpreter  */
> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  #endif /* _UAPI_LINUX_BINFMTS_H */
> --
> 2.24.1
>
