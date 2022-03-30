Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAB64EC943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348579AbiC3QI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348692AbiC3QIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:08:22 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20223D749
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 09:06:34 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KTBBc40cpzMprt9;
        Wed, 30 Mar 2022 18:06:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KTBBZ5nHZzlhPJV;
        Wed, 30 Mar 2022 18:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648656392;
        bh=8z/gwYk4igoSvFw5d9ygcqzUz71oGnSSI3aVBjvHzrg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=S2lhB0PW4iY3T7nJCWRrrxY/EEwhD0huzWX5e8KJOHm5GGVGGjY8iCRzduT1unZj8
         JG4xoo/fZxx5CFQIGQ1hNdrIQ5/d5AarQVv/fbgm8Ro3omT1l6w9nJK/6OGKmHeHa+
         Jgh2LeETNI80KsVqtBvJCrnTLRD7VC2cxrAc8gbs=
Message-ID: <f6cf4112-b7b9-7ad7-dbb0-27304176146f@digikod.net>
Date:   Wed, 30 Mar 2022 18:06:15 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220321161557.495388-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
In-Reply-To: <20220321161557.495388-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

What is the status of this pull request? Do you need something more?

Regards,
  Mickaël


On 21/03/2022 17:15, Mickaël Salaün wrote:
> Hi Linus,
> 
> This patch series adds a new syscall named trusted_for.  It enables user
> space to ask the kernel: is this file descriptor's content trusted to be
> used for this purpose?  The set of usage currently only contains
> execution, but other may follow (e.g. configuration, sensitive data).
> If the kernel identifies the file descriptor as trustworthy for this
> usage, user space should then take this information into account.  The
> "execution" usage means that the content of the file descriptor is
> trusted according to the system policy to be executed by user space,
> which means that it interprets the content or (try to) maps it as
> executable memory.
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
> integrity gap by bringing the ability to check the use of scripts.
> Other uses are expected as well.
> 
> For further details, please see the latest cover letter:
> https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net
> 
> Commit dae71698b6c5 ("printk: Move back proc_dointvec_minmax_sysadmin()
> to sysctl.c") was recently added due to the sysctl refactoring.
> 
> Commit e674341a90b9 ("selftests/interpreter: fix separate directory
> build") will fix some test build cases as explained here:
> https://lore.kernel.org/r/20220119101531.2850400-1-usama.anjum@collabora.com
> Merging this commit without the new KHDR_INCLUDES is not an issue.
> The upcoming kselftest pull request is ready:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
> This patch series has been open for review for more than three years and
> got a lot of feedbacks (and bikeshedding) which were all considered.
> Since I heard no objection, please consider to pull this code for
> v5.18-rc1 .  These five patches have been successfully tested in the
> latest linux-next releases for several weeks.
> 
> Regards,
>   Mickaël
> 
> --
> The following changes since commit dcb85f85fa6f142aae1fe86f399d4503d49f2b60:
> 
>    gcc-plugins/stackleak: Use noinstr in favor of notrace (2022-02-03 17:02:21 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/trusted-for-v18
> 
> for you to fetch changes up to e674341a90b95c3458d684ae25e6891afc3e03ad:
> 
>    selftests/interpreter: fix separate directory build (2022-03-04 10:56:25 +0100)
> 
> ----------------------------------------------------------------
> Add the trusted_for system call (v18)
> 
> The final goal of this patch series is to enable the kernel to be a
> global policy manager by entrusting processes with access control at
> their level.  To reach this goal, two complementary parts are required:
> * user space needs to be able to know if it can trust some file
>    descriptor content for a specific usage;
> * and the kernel needs to make available some part of the policy
>    configured by the system administrator.
> 
> In a nutshell, this is a required building block to control script
> execution.
> 
> For further details see the latest cover letter:
> https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net
> 
> ----------------------------------------------------------------
> Mickaël Salaün (4):
>        printk: Move back proc_dointvec_minmax_sysadmin() to sysctl.c
>        fs: Add trusted_for(2) syscall implementation and related sysctl
>        arch: Wire up trusted_for(2)
>        selftest/interpreter: Add tests for trusted_for(2) policies
> 
> Muhammad Usama Anjum (1):
>        selftests/interpreter: fix separate directory build
> 
>   Documentation/admin-guide/sysctl/fs.rst            |  50 +++
>   arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
>   arch/arm/tools/syscall.tbl                         |   1 +
>   arch/arm64/include/asm/unistd.h                    |   2 +-
>   arch/arm64/include/asm/unistd32.h                  |   2 +
>   arch/ia64/kernel/syscalls/syscall.tbl              |   1 +
>   arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
>   arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
>   arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
>   arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
>   arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
>   arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
>   arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
>   arch/s390/kernel/syscalls/syscall.tbl              |   1 +
>   arch/sh/kernel/syscalls/syscall.tbl                |   1 +
>   arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
>   arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
>   arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
>   arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
>   fs/open.c                                          | 133 ++++++++
>   fs/proc/proc_sysctl.c                              |   2 +-
>   include/linux/syscalls.h                           |   1 +
>   include/linux/sysctl.h                             |   3 +
>   include/uapi/asm-generic/unistd.h                  |   5 +-
>   include/uapi/linux/trusted-for.h                   |  18 +
>   kernel/printk/sysctl.c                             |   9 -
>   kernel/sysctl.c                                    |   9 +
>   tools/testing/selftests/Makefile                   |   1 +
>   tools/testing/selftests/interpreter/.gitignore     |   2 +
>   tools/testing/selftests/interpreter/Makefile       |  21 ++
>   tools/testing/selftests/interpreter/config         |   1 +
>   .../selftests/interpreter/trust_policy_test.c      | 362 +++++++++++++++++++++
>   32 files changed, 625 insertions(+), 12 deletions(-)
>   create mode 100644 include/uapi/linux/trusted-for.h
>   create mode 100644 tools/testing/selftests/interpreter/.gitignore
>   create mode 100644 tools/testing/selftests/interpreter/Makefile
>   create mode 100644 tools/testing/selftests/interpreter/config
>   create mode 100644 tools/testing/selftests/interpreter/trust_policy_test.c
