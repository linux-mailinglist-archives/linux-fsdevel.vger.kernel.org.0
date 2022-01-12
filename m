Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77748C574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353870AbiALODE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353879AbiALODC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:03:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED8C061756;
        Wed, 12 Jan 2022 06:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91DEF60C02;
        Wed, 12 Jan 2022 14:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50ABC36AEA;
        Wed, 12 Jan 2022 14:02:57 +0000 (UTC)
Date:   Wed, 12 Jan 2022 15:02:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        containers@lists.linux.dev, Alexey Gladkov <legion@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER)
 failed: ENOSPC (28)
Message-ID: <20220112140254.cvngcwggeevwaazw@wittgenstein>
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
 <20220112131837.igsjkkttqskw4eix@wittgenstein>
 <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 02:22:42PM +0100, Anders Roxell wrote:
> On Wed, 12 Jan 2022 at 14:18, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> > > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> > > on x86_64, i386, arm and arm64 the following tests failed.
> > >
> > > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> > > getxattr05.c:87: TPASS: Got same data when acquiring the value of
> > > system.posix_acl_access twice
> > > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> > >
> > > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> > > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> > >
> > > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> > >
> > > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> > >
> > > strace output:
> > > --------------
> > > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> > > [pid   481] clone(child_stack=NULL,
> > > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> > > child_tidptr=0x7f3af0fa7a10) = 483
> > > strace: Process 483 attached
> > > [pid   481] wait4(-1,  <unfinished ...>
> > > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
> >
> > This looks like another regression in the ucount code. Reverting the
> > following commit fixes it and makes the getxattr05 test work again:
> >
> > commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
> > Author: Alexey Gladkov <legion@kernel.org>
> > Date:   Fri Dec 17 15:48:23 2021 +0100
> >
> >     ucounts: Split rlimit and ucount values and max values
> >
> >     Since the semantics of maximum rlimit values are different, it would be
> >     better not to mix ucount and rlimit values. This will prevent the error
> >     of using inc_count/dec_ucount for rlimit parameters.
> >
> >     This patch also renames the functions to emphasize the lack of
> >     connection between rlimit and ucount.
> >
> >     v2:
> >     - Fix the array-index-out-of-bounds that was found by the lkp project.
> >
> >     Reported-by: kernel test robot <oliver.sang@intel.com>
> >     Signed-off-by: Alexey Gladkov <legion@kernel.org>
> >     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
> >     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> >
> > The issue only surfaces if /proc/sys/user/max_user_namespaces is
> > actually written to.
> 
> I did a git bisect and that pointed me to this patch too.

Uhm, doesn't this want to be:

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 22070f004e97..108c6a879cd8 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -264,7 +264,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
        long ret = 0;

        for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-               long new = atomic_long_add_return(v, &iter->ucount[type]);
+               long new = atomic_long_add_return(v, &iter->rlimit[type]);
                if (new < 0 || new > max)
                        ret = LONG_MAX;
                else if (iter == ucounts)
@@ -279,7 +279,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
        struct ucounts *iter;
        long new = -1; /* Silence compiler warning */
        for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-               long dec = atomic_long_sub_return(v, &iter->ucount[type]);
+               long dec = atomic_long_sub_return(v, &iter->rlimit[type]);
                WARN_ON_ONCE(dec < 0);
                if (iter == ucounts)
                        new = dec;


otherwise,

inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_NPROC, 1)

means

long inc_rlimit_ucounts(struct ucounts *ucounts, UCOUNT_RLIMIT_NPROC, long v)
{
	struct ucounts *iter;
	long max = LONG_MAX;
	long ret = 0;

	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
		long new = atomic_long_add_return(v, &iter->ucount[UCOUNT_RLIMIT_NPROC]);
		if (new < 0 || new > max)
			ret = LONG_MAX;
		else if (iter == ucounts)
			ret = new;
		max = get_userns_rlimit_max(iter->ns, UCOUNT_RLIMIT_NPROC);
	}
	return ret;
}

which means that UCOUNT_RLIMIT_NPROC overwrites ucount[UCOUNT_RLIMIT_NPROC]?
