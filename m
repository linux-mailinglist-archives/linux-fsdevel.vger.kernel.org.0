Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD032256E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 06:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBWFeq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 00:34:46 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:37251 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBWFen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:34:43 -0500
Received: by mail-qv1-f52.google.com with SMTP id s12so6626477qvq.4;
        Mon, 22 Feb 2021 21:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=htCaREn9FFby45h2rJBm0z090mxug6XkP4LVXlHJXvU=;
        b=PuvnH9p+Ic4VsxxTiFEY3frp5ECaWc3tqPv4J/pJW0GOfGLSVyWgJ2cqghMlVwh2ER
         wR7lLLxNh2fiD1pcNFHx9wyucfcOrCWxqefzYYqVeKaVluvQsc5aa/V34n+sHYkyq9In
         JmkseBVeq0O6fNoRbXNVF/QuwHwISBD07LTLQ0AyYowEBoCk2J6GNcjCrHBtOK139p6/
         D8L/9Gol4xr4u6OcIReHBlIheMGnhmwo9G4F6/2uWOMqJORgT3v4fJ/2syNMjDOlDNVP
         4XXBDIfOH/pc5oD09bG8cWsywn3QLQiY3F9/P4rSTvK7Jfdm2aAOBTXjbgpLeOvch1kV
         mbOw==
X-Gm-Message-State: AOAM530OEkKB5HiV4JfCPWSoxqSaneLqnof5V5EQBJM40JJb6reaHrAt
        gR/oNCNRfjQudmg6BiwdsrBeL72TXVmjFJXVYnQ=
X-Google-Smtp-Source: ABdhPJyDY4bkbLl7IqFF9EnsTvu9ltg9ZDuQd688n8PkkoPPrA83/lZe+VjqdkojUU/9a00J2+g8tD0zEArOq6XV1eY=
X-Received: by 2002:a05:6214:248a:: with SMTP id gi10mr23763108qvb.35.1614058440800;
 Mon, 22 Feb 2021 21:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20200128132539.782286-1-laurent@vivier.eu> <348e8e7a-3a2c-23b7-4a2e-d3f5e8a62173@vivier.eu>
 <743e8674-fd7e-c7e1-aa7e-6674a9e9e116@gmx.de>
In-Reply-To: <743e8674-fd7e-c7e1-aa7e-6674a9e9e116@gmx.de>
From:   YunQiang Su <syq@debian.org>
Date:   Tue, 23 Feb 2021 13:35:38 +0800
Message-ID: <CAKcpw6W_o5j3rTnZJJaEN57qBgNdX5+rdALS-dSx-QmaXLpS3g@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
To:     Helge Deller <deller@gmx.de>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, YunQiang Su <ysu@wavecomp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Helge Deller <deller@gmx.de> 于2021年2月13日周六 下午3:40写道：
>
> On 6/5/20 6:20 PM, Laurent Vivier wrote:
> > Le 28/01/2020 à 14:25, Laurent Vivier a écrit :
> >> It can be useful to the interpreter to know which flags are in use.
> >>
> >> For instance, knowing if the preserve-argv[0] is in use would
> >> allow to skip the pathname argument.
> >>
> >> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> >> flag to inform interpreter if the preserve-argv[0] is enabled.
> >>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> If nobody objects, I'd like to take this patch through the
> parisc arch git tree.
>

Thank you. I see this patch has been in linux-next now.
@Laurent, I guess it is time to work on to push the patch for qemu?

> It fixes a real-world problem with qemu-user which fails to
> preserve the argv[0] argument when the callee of an exec is a
> qemu-user target.
> This problem leads to build errors on multiple Debian buildd servers
> which are using qemu-user as emulation for the target machines.
>
> For details see Debian bug:
> http://bugs.debian.org/970460
>
>
> Helge
>
>
> >> ---
> >>
> >> Notes:
> >>      This can be tested with QEMU from my branch:
> >>
> >>        https://github.com/vivier/qemu/commits/binfmt-argv0
> >>
> >>      With something like:
> >>
> >>        # cp ..../qemu-ppc /chroot/powerpc/jessie
> >>
> >>        # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
> >>                              --persistent no --preserve-argv0 yes
> >>        # systemctl restart systemd-binfmt.service
> >>        # cat /proc/sys/fs/binfmt_misc/qemu-ppc
> >>        enabled
> >>        interpreter //qemu-ppc
> >>        flags: POC
> >>        offset 0
> >>        magic 7f454c4601020100000000000000000000020014
> >>        mask ffffffffffffff00fffffffffffffffffffeffff
> >>        # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
> >>        sh
> >>
> >>        # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
> >>                              --persistent no --preserve-argv0 no
> >>        # systemctl restart systemd-binfmt.service
> >>        # cat /proc/sys/fs/binfmt_misc/qemu-ppc
> >>        enabled
> >>        interpreter //qemu-ppc
> >>        flags: OC
> >>        offset 0
> >>        magic 7f454c4601020100000000000000000000020014
> >>        mask ffffffffffffff00fffffffffffffffffffeffff
> >>        # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
> >>        /bin/sh
> >>
> >>      v3: mix my patch with one from YunQiang Su and my comments on it
> >>          introduce a new flag in the uabi for the AT_FLAGS
> >>      v2: only pass special flags (remove Magic and Enabled flags)
> >>
> >>   fs/binfmt_elf.c              | 5 ++++-
> >>   fs/binfmt_elf_fdpic.c        | 5 ++++-
> >>   fs/binfmt_misc.c             | 4 +++-
> >>   include/linux/binfmts.h      | 4 ++++
> >>   include/uapi/linux/binfmts.h | 4 ++++
> >>   5 files changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> >> index ecd8d2698515..ff918042ceed 100644
> >> --- a/fs/binfmt_elf.c
> >> +++ b/fs/binfmt_elf.c
> >> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> >>      unsigned char k_rand_bytes[16];
> >>      int items;
> >>      elf_addr_t *elf_info;
> >> +    elf_addr_t flags = 0;
> >>      int ei_index = 0;
> >>      const struct cred *cred = current_cred();
> >>      struct vm_area_struct *vma;
> >> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> >>      NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
> >>      NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
> >>      NEW_AUX_ENT(AT_BASE, interp_load_addr);
> >> -    NEW_AUX_ENT(AT_FLAGS, 0);
> >> +    if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> >> +            flags |= AT_FLAGS_PRESERVE_ARGV0;
> >> +    NEW_AUX_ENT(AT_FLAGS, flags);
> >>      NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
> >>      NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
> >>      NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> >> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> >> index 240f66663543..abb90d82aa58 100644
> >> --- a/fs/binfmt_elf_fdpic.c
> >> +++ b/fs/binfmt_elf_fdpic.c
> >> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
> >>      char __user *u_platform, *u_base_platform, *p;
> >>      int loop;
> >>      int nr; /* reset for each csp adjustment */
> >> +    unsigned long flags = 0;
> >>
> >>   #ifdef CONFIG_MMU
> >>      /* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> >> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
> >>      NEW_AUX_ENT(AT_PHENT,   sizeof(struct elf_phdr));
> >>      NEW_AUX_ENT(AT_PHNUM,   exec_params->hdr.e_phnum);
> >>      NEW_AUX_ENT(AT_BASE,    interp_params->elfhdr_addr);
> >> -    NEW_AUX_ENT(AT_FLAGS,   0);
> >> +    if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> >> +            flags |= AT_FLAGS_PRESERVE_ARGV0;
> >> +    NEW_AUX_ENT(AT_FLAGS,   flags);
> >>      NEW_AUX_ENT(AT_ENTRY,   exec_params->entry_addr);
> >>      NEW_AUX_ENT(AT_UID,     (elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
> >>      NEW_AUX_ENT(AT_EUID,    (elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> >> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> >> index cdb45829354d..b9acdd26a654 100644
> >> --- a/fs/binfmt_misc.c
> >> +++ b/fs/binfmt_misc.c
> >> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
> >>      if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
> >>              goto ret;
> >>
> >> -    if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
> >> +    if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
> >> +            bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> >> +    } else {
> >>              retval = remove_arg_zero(bprm);
> >>              if (retval)
> >>                      goto ret;
> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> >> index b40fc633f3be..265b80d5fd6f 100644
> >> --- a/include/linux/binfmts.h
> >> +++ b/include/linux/binfmts.h
> >> @@ -78,6 +78,10 @@ struct linux_binprm {
> >>   #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
> >>   #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
> >>
> >> +/* if preserve the argv0 for the interpreter  */
> >> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> >> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> >> +
> >>   /* Function parameter for binfmt->coredump */
> >>   struct coredump_params {
> >>      const kernel_siginfo_t *siginfo;
> >> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> >> index 689025d9c185..a70747416130 100644
> >> --- a/include/uapi/linux/binfmts.h
> >> +++ b/include/uapi/linux/binfmts.h
> >> @@ -18,4 +18,8 @@ struct pt_regs;
> >>   /* sizeof(linux_binprm->buf) */
> >>   #define BINPRM_BUF_SIZE 256
> >>
> >> +/* if preserve the argv0 for the interpreter  */
> >> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> >> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> >> +
> >>   #endif /* _UAPI_LINUX_BINFMTS_H */
> >>
> >
>
