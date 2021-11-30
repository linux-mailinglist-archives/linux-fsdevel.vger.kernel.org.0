Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28946310C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhK3KhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 05:37:06 -0500
Received: from smtp-8fac.mail.infomaniak.ch ([83.166.143.172]:37735 "EHLO
        smtp-8fac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232938AbhK3KhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:37:01 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4J3JTx0DbszMq2FX;
        Tue, 30 Nov 2021 11:33:41 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4J3JTr6kV7zlhNx2;
        Tue, 30 Nov 2021 11:33:35 +0100 (CET)
Message-ID: <86c3fdf8-bc00-8868-1ff1-96e6e1ca9203@digikod.net>
Date:   Tue, 30 Nov 2021 11:35:00 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20211115185304.198460-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v17 0/3] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <20211115185304.198460-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Al,

I think there is no more comment on this series, everything has been 
addressed. Could you please consider to merge this into your tree or 
push it to linux-next?

Regards,
  Mickaël


On 15/11/2021 19:53, Mickaël Salaün wrote:
> Hi,
> 
> This new patch series fix the syscall signature as suggested by
> Alejandro Colomar.  It applies on Linus's master branch (v5.16-rc1) and
> next-20211115.
> 
> Andrew, can you please consider to merge this into your tree?
> 
> Overview
> ========
> 
> The final goal of this patch series is to enable the kernel to be a
> global policy manager by entrusting processes with access control at
> their level.  To reach this goal, two complementary parts are required:
> * user space needs to be able to know if it can trust some file
>    descriptor content for a specific usage;
> * and the kernel needs to make available some part of the policy
>    configured by the system administrator.
> 
> Primary goal of trusted_for(2)
> ==============================
> 
> This new syscall enables user space to ask the kernel: is this file
> descriptor's content trusted to be used for this purpose?  The set of
> usage currently only contains execution, but other may follow (e.g.
> configuration, sensitive data).  If the kernel identifies the file
> descriptor as trustworthy for this usage, user space should then take
> this information into account.  The "execution" usage means that the
> content of the file descriptor is trusted according to the system policy
> to be executed by user space, which means that it interprets the content
> or (try to) maps it as executable memory.
> 
> A simple system-wide security policy can be set by the system
> administrator through a sysctl configuration consistent with the mount
> points or the file access rights.  The documentation explains the
> prerequisites.
> 
> It is important to note that this can only enable to extend access
> control managed by the kernel.  Hence it enables current access control
> mechanism to be extended and become a superset of what they can
> currently control.  Indeed, the security policy could also be delegated
> to an LSM, either a MAC system or an integrity system.  For instance,
> this is required to close a major IMA measurement/appraisal interpreter
> integrity gap by bringing the ability to check the use of scripts [1].
> Other uses are expected, such as for magic-links [2], SGX integration
> [3], bpffs [4].
> 
> Complementary W^X protections can be brought by SELinux, IPE [5] and
> trampfd [6].
> 
> System call description
> =======================
> 
> trusted_for(int fd, enum trusted_for_usage usage, u32 flags);
> 
> @fd is the file descriptor to check.
> 
> @usage identifies the user space usage intended for @fd: only
> TRUSTED_FOR_EXECUTION for now, but trusted_for_usage could be extended
> to identify other usages (e.g. configuration, sensitive data).
> 
> @flags must be 0 for now but it could be used in the future to do
> complementary checks (e.g. signature or integrity requirements, origin
> of the file).
> 
> This system call returns 0 on success, or -EACCES if the kernel policy
> denies the specified usage (which should be enforced by the caller).
> 
> The first patch contains the full syscall and sysctl documentation.
> 
> Prerequisite of its use
> =======================
> 
> User space needs to adapt to take advantage of this new feature.  For
> example, the PEP 578 [7] (Runtime Audit Hooks) enables Python 3.8 to be
> extended with policy enforcement points related to code interpretation,
> which can be used to align with the PowerShell audit features.
> Additional Python security improvements (e.g. a limited interpreter
> without -c, stdin piping of code) are on their way [8].
> 
> Examples
> ========
> 
> The initial idea comes from CLIP OS 4 and the original implementation
> has been used for more than 13 years:
> https://github.com/clipos-archive/clipos4_doc
> Chrome OS has a similar approach:
> https://chromium.googlesource.com/chromiumos/docs/+/master/security/noexec_shell_scripts.md
> 
> Userland patches can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> Actually, there is more than the O_MAYEXEC changes (which matches this search)
> e.g., to prevent Python interactive execution. There are patches for
> Bash, Wine, Java (Icedtea), Busybox's ash, Perl and Python. There are
> also some related patches which do not directly rely on O_MAYEXEC but
> which restrict the use of browser plugins and extensions, which may be
> seen as scripts too:
> https://github.com/clipos-archive/clipos4_portage-overlay/tree/master/www-client
> 
> An introduction to O_MAYEXEC was given at the Linux Security Summit
> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
> The "write xor execute" principle was explained at Kernel Recipes 2018 -
> CLIP OS: a defense-in-depth OS:
> https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
> See also a first LWN article about O_MAYEXEC and a new one about
> trusted_for(2) and its background:
> * https://lwn.net/Articles/820000/
> * https://lwn.net/Articles/832959/
> 
> This can be tested with CONFIG_SYSCTL.  I would really appreciate
> constructive comments on this patch series.
> 
> [1] https://lore.kernel.org/lkml/20211014130125.6991-1-zohar@linux.ibm.com/
> [2] https://lore.kernel.org/lkml/20190904201933.10736-6-cyphar@cyphar.com/
> [3] https://lore.kernel.org/lkml/CALCETrVovr8XNZSroey7pHF46O=kj_c5D9K8h=z2T_cNrpvMig@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CALCETrVeZ0eufFXwfhtaG_j+AdvbzEWE0M3wjXMWVEO7pj+xkw@mail.gmail.com/
> [5] https://lore.kernel.org/lkml/20200406221439.1469862-12-deven.desai@linux.microsoft.com/
> [6] https://lore.kernel.org/lkml/20200922215326.4603-1-madvenka@linux.microsoft.com/
> [7] https://www.python.org/dev/peps/pep-0578/
> [8] https://lore.kernel.org/lkml/0c70debd-e79e-d514-06c6-4cd1e021fa8b@python.org/
> 
> Previous versions:
> v16: https://lore.kernel.org/r/20211110190626.257017-1-mic@digikod.net/
> v15: https://lore.kernel.org/r/20211012192410.2356090-1-mic@digikod.net/
> v14: https://lore.kernel.org/r/20211008104840.1733385-1-mic@digikod.net/
> v13: https://lore.kernel.org/r/20211007182321.872075-1-mic@digikod.net/
> v12: https://lore.kernel.org/r/20201203173118.379271-1-mic@digikod.net/
> v11: https://lore.kernel.org/r/20201019164932.1430614-1-mic@digikod.net/
> v10: https://lore.kernel.org/r/20200924153228.387737-1-mic@digikod.net/
> v9: https://lore.kernel.org/r/20200910164612.114215-1-mic@digikod.net/
> v8: https://lore.kernel.org/r/20200908075956.1069018-1-mic@digikod.net/
> v7: https://lore.kernel.org/r/20200723171227.446711-1-mic@digikod.net/
> v6: https://lore.kernel.org/r/20200714181638.45751-1-mic@digikod.net/
> v5: https://lore.kernel.org/r/20200505153156.925111-1-mic@digikod.net/
> v4: https://lore.kernel.org/r/20200430132320.699508-1-mic@digikod.net/
> v3: https://lore.kernel.org/r/20200428175129.634352-1-mic@digikod.net/
> v2: https://lore.kernel.org/r/20190906152455.22757-1-mic@digikod.net/
> v1: https://lore.kernel.org/r/20181212081712.32347-1-mic@digikod.net/
> 
> Regards,
> 
> Mickaël Salaün (3):
>    fs: Add trusted_for(2) syscall implementation and related sysctl
>    arch: Wire up trusted_for(2)
>    selftest/interpreter: Add tests for trusted_for(2) policies
> 
>   Documentation/admin-guide/sysctl/fs.rst       |  50 +++
>   arch/alpha/kernel/syscalls/syscall.tbl        |   2 +
>   arch/arm/tools/syscall.tbl                    |   1 +
>   arch/arm64/include/asm/unistd.h               |   2 +-
>   arch/arm64/include/asm/unistd32.h             |   2 +
>   arch/ia64/kernel/syscalls/syscall.tbl         |   2 +
>   arch/m68k/kernel/syscalls/syscall.tbl         |   2 +
>   arch/microblaze/kernel/syscalls/syscall.tbl   |   2 +
>   arch/mips/kernel/syscalls/syscall_n32.tbl     |   2 +
>   arch/mips/kernel/syscalls/syscall_n64.tbl     |   2 +
>   arch/mips/kernel/syscalls/syscall_o32.tbl     |   2 +
>   arch/parisc/kernel/syscalls/syscall.tbl       |   2 +
>   arch/powerpc/kernel/syscalls/syscall.tbl      |   2 +
>   arch/s390/kernel/syscalls/syscall.tbl         |   2 +
>   arch/sh/kernel/syscalls/syscall.tbl           |   2 +
>   arch/sparc/kernel/syscalls/syscall.tbl        |   2 +
>   arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>   arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>   arch/xtensa/kernel/syscalls/syscall.tbl       |   2 +
>   fs/open.c                                     | 111 ++++++
>   include/linux/fs.h                            |   1 +
>   include/linux/syscalls.h                      |   1 +
>   include/uapi/asm-generic/unistd.h             |   4 +-
>   include/uapi/linux/trusted-for.h              |  18 +
>   kernel/sysctl.c                               |  12 +-
>   tools/testing/selftests/Makefile              |   1 +
>   .../testing/selftests/interpreter/.gitignore  |   2 +
>   tools/testing/selftests/interpreter/Makefile  |  21 +
>   tools/testing/selftests/interpreter/config    |   1 +
>   .../selftests/interpreter/trust_policy_test.c | 362 ++++++++++++++++++
>   30 files changed, 613 insertions(+), 4 deletions(-)
>   create mode 100644 include/uapi/linux/trusted-for.h
>   create mode 100644 tools/testing/selftests/interpreter/.gitignore
>   create mode 100644 tools/testing/selftests/interpreter/Makefile
>   create mode 100644 tools/testing/selftests/interpreter/config
>   create mode 100644 tools/testing/selftests/interpreter/trust_policy_test.c
> 
> 
> base-commit: 8ab774587903771821b59471cc723bba6d893942
> 
