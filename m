Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B810225376
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGSSR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 14:17:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:17:56 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jxDsQ-0003b6-HU; Sun, 19 Jul 2020 18:17:30 +0000
Date:   Sun, 19 Jul 2020 20:17:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200719181729.6f37lilhvov5a74f@wittgenstein>
References: <20200719100418.2112740-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200719100418.2112740-1-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:04:10PM +0200, Adrian Reber wrote:
> This is v6 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
> changes to v5 are:
> 
>  * split patch dealing with /proc/self/exe into two patches:
>    * first patch to enable changing it with CAP_CHECKPOINT_RESTORE
>      and detailed history in the commit message
>    * second patch changes -EINVAL to -EPERM
>  * use kselftest_harness.h infrastructure for test
>  * replace if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))
>    with if (!checkpoint_restore_ns_capable(&init_user_ns))
> 
> Adrian Reber (5):
>   capabilities: Introduce CAP_CHECKPOINT_RESTORE
>   pid: use checkpoint_restore_ns_capable() for set_tid
>   pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
>   proc: allow access in init userns for map_files with
>     CAP_CHECKPOINT_RESTORE
>   selftests: add clone3() CAP_CHECKPOINT_RESTORE test
> 
> Nicolas Viennot (2):
>   prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
>   prctl: exe link permission error changed from -EINVAL to -EPERM
> 
>  fs/proc/base.c                                |   8 +-
>  include/linux/capability.h                    |   6 +
>  include/uapi/linux/capability.h               |   9 +-
>  kernel/pid.c                                  |   2 +-
>  kernel/pid_namespace.c                        |   2 +-
>  kernel/sys.c                                  |  13 +-
>  security/selinux/include/classmap.h           |   5 +-
>  tools/testing/selftests/clone3/.gitignore     |   1 +
>  tools/testing/selftests/clone3/Makefile       |   4 +-
>  .../clone3/clone3_cap_checkpoint_restore.c    | 177 ++++++++++++++++++
>  10 files changed, 212 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> 
> base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822

Adrian, Nicolas thank you!
I grabbed the series to run the various core test-suites we've added
over the last year and pushed it to
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=cap_checkpoint_restore
for now to let kbuild/ltp chew on it for a bit.

Thanks!
Christian
