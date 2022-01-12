Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E248C613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354118AbiALO2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiALO2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:28:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4936AC06173F;
        Wed, 12 Jan 2022 06:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09937B81F02;
        Wed, 12 Jan 2022 14:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F02EC36AEA;
        Wed, 12 Jan 2022 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641997730;
        bh=8WIH+0qVHO2YBYQ9GPnvwj6icMEELix8gczxJYwvnIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzS4M2/DzXW/uYSD3qH8Mf3jszHIBeMg7D7/vFjqrT5ZWPax2SV9M31DbttMAtqvC
         PTLiWacplV6qtagr2TBtoLqK+Joe1tf+AmUyqHuW3+l401kpQY85aez7caWtQ5Syue
         BYA0T5DDOXr9pyNd7qm6kxDRamLGSJY2mBMB1rIbQFHsOCKNg0RWuIp+wRw1OwZDW1
         Z7L525sW7HAvzM25rfl8376n5ysqcFTNefviVmYEfltshpNPn1ydTK7umxmXO5twgh
         fWQq4ykVAnb2GyfppHl3e9QAvNRUqXXur2z4wrW2oRMey6OFDhVWHM+hQCXGfZPV4H
         0+uZCUlOg9/Eg==
Date:   Wed, 12 Jan 2022 15:28:46 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        containers@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER)
 failed: ENOSPC (28)
Message-ID: <20220112142846.3b3m2dyhdtppgwrw@example.org>
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
 <20220112131837.igsjkkttqskw4eix@wittgenstein>
 <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
 <20220112140254.cvngcwggeevwaazw@wittgenstein>
 <20220112141445.txgrdlycvfkiwsv5@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112141445.txgrdlycvfkiwsv5@example.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:14:45PM +0100, Alexey Gladkov wrote:
> On Wed, Jan 12, 2022 at 03:02:54PM +0100, Christian Brauner wrote:
> > On Wed, Jan 12, 2022 at 02:22:42PM +0100, Anders Roxell wrote:
> > > On Wed, 12 Jan 2022 at 14:18, Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> > > > > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> > > > > on x86_64, i386, arm and arm64 the following tests failed.
> > > > >
> > > > > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> > > > > getxattr05.c:87: TPASS: Got same data when acquiring the value of
> > > > > system.posix_acl_access twice
> > > > > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > > > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> > > > >
> > > > > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> > > > > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > > > > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> > > > >
> > > > > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> > > > >
> > > > > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> > > > >
> > > > > strace output:
> > > > > --------------
> > > > > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> > > > > [pid   481] clone(child_stack=NULL,
> > > > > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> > > > > child_tidptr=0x7f3af0fa7a10) = 483
> > > > > strace: Process 483 attached
> > > > > [pid   481] wait4(-1,  <unfinished ...>
> > > > > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
> > > >
> > > > This looks like another regression in the ucount code. Reverting the
> > > > following commit fixes it and makes the getxattr05 test work again:
> > > >
> > > > commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
> > > > Author: Alexey Gladkov <legion@kernel.org>
> > > > Date:   Fri Dec 17 15:48:23 2021 +0100
> > > >
> > > >     ucounts: Split rlimit and ucount values and max values
> > > >
> > > >     Since the semantics of maximum rlimit values are different, it would be
> > > >     better not to mix ucount and rlimit values. This will prevent the error
> > > >     of using inc_count/dec_ucount for rlimit parameters.
> > > >
> > > >     This patch also renames the functions to emphasize the lack of
> > > >     connection between rlimit and ucount.
> > > >
> > > >     v2:
> > > >     - Fix the array-index-out-of-bounds that was found by the lkp project.
> > > >
> > > >     Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >     Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > >     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
> > > >     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > > >
> > > > The issue only surfaces if /proc/sys/user/max_user_namespaces is
> > > > actually written to.
> > > 
> > > I did a git bisect and that pointed me to this patch too.
> > 
> > Uhm, doesn't this want to be:
> 
> Yes. I miss it. I tried not to mix the logic, but I myself stepped on this
> problem.

It should be fixed in the four places:

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 22070f004e97..5c373a453f43 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -264,7 +264,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 	long ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long new = atomic_long_add_return(v, &iter->ucount[type]);
+		long new = atomic_long_add_return(v, &iter->rlimit[type]);
 		if (new < 0 || new > max)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
@@ -279,7 +279,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
 	struct ucounts *iter;
 	long new = -1; /* Silence compiler warning */
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long dec = atomic_long_sub_return(v, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(v, &iter->rlimit[type]);
 		WARN_ON_ONCE(dec < 0);
 		if (iter == ucounts)
 			new = dec;
@@ -292,7 +292,7 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
 {
 	struct ucounts *iter, *next;
 	for (iter = ucounts; iter != last; iter = next) {
-		long dec = atomic_long_sub_return(1, &iter->ucount[type]);
+		long dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 		WARN_ON_ONCE(dec < 0);
 		next = iter->ns->ucounts;
 		if (dec == 0)
@@ -313,7 +313,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	long dec, ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long new = atomic_long_add_return(1, &iter->ucount[type]);
+		long new = atomic_long_add_return(1, &iter->rlimit[type]);
 		if (new < 0 || new > max)
 			goto unwind;
 		if (iter == ucounts)
@@ -330,7 +330,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 	}
 	return ret;
 dec_unwind:
-	dec = atomic_long_sub_return(1, &iter->ucount[type]);
+	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
 unwind:
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);

-- 
Rgrds, legion

