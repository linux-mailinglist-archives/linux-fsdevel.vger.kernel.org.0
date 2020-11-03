Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA742A4D06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgKCRdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:33:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48586 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgKCRdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:33:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3HSvi3095756;
        Tue, 3 Nov 2020 17:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=otr9P7pRAVeP7QxQsAfTSy2iYBcnH0mKk6ofL7EzoV8=;
 b=kLRjoIUi/LH30Xr6ER6XQKsD0zkAbff+r40FSsc7FNvU9hu/lmQMN56qNKcKiTWUdI72
 eG5+zCI8YNo4HIFgZCnakBcV9TLUiFPexa2mbjg1LLDkkpmE7bpAZDUi2DLMMJfP8jmv
 q7J7ZFwPw9vzXJ8qg4CfUNEwIM3kJFGU3ADnW4Jd2PuBGp8BN7qYZmLsSjfo3GHqyJ1K
 VGUHFR8AwP6AYoTa/zYYE6g9se6T2bOBM+CATcq6ef3rdvscUtSHRrP2h/gruzBCFAdX
 Wj2Pb8ZzgHS3o4Jf5XsFODqsNfEXP/mNu6xas29XihH8bXoAfdoefn6RpBPYV84ffyFC Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34hhw2jjfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 17:33:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3HUm8S145418;
        Tue, 3 Nov 2020 17:33:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34jf48tc08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 17:33:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A3HX1dZ031067;
        Tue, 3 Nov 2020 17:33:01 GMT
Received: from localhost (/10.159.234.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 09:33:01 -0800
Date:   Tue, 3 Nov 2020 09:33:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org
Subject: [RFC PATCH] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201103173300.GF7123@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

__sb_start_write has some weird looking lockdep code that claims to
exist to handle nested freeze locking requests from xfs.  The code as
written seems broken -- if we think we hold a read lock on any of the
higher freeze levels (e.g. we hold SB_FREEZE_WRITE and are trying to
lock SB_FREEZE_PAGEFAULT), it converts a blocking lock attempt into a
trylock.

However, it's not correct to downgrade a blocking lock attempt to a
trylock unless the downgrading code or the callers are prepared to deal
with that situation.  Neither __sb_start_write nor its callers handle
this at all.  For example:

sb_start_pagefault ignores the return value completely, with the result
that if xfs_filemap_fault loses a race with a different thread trying to
fsfreeze, it will proceed without pagefault freeze protection (thereby
breaking locking rules) and then unlocks the pagefault freeze lock that
it doesn't own on its way out (thereby corrupting the lock state), which
leads to a system hang shortly afterwards.

Normally, this won't happen because our ownership of a read lock on a
higher freeze protection level blocks fsfreeze from grabbing a write
lock on that higher level.  *However*, if lockdep is offline,
lock_is_held_type unconditionally returns 1, which means that
percpu_rwsem_is_held returns 1, which means that __sb_start_write
unconditionally converts blocking freeze lock attempts into trylocks,
even when we *don't* hold anything that would block a fsfreeze.

Apparently this all held together until 5.10-rc1, when bugs in lockdep
caused lockdep to shut itself off early in an fstests run, and once
fstests gets to the "race writes with freezer" tests, kaboom.  This
might explain the long trail of vanishingly infrequent livelocks in
fstests after lockdep goes offline that I've never been able to
diagnose.

We could fix it by spinning on the trylock if wait==true, but AFAICT the
locking works fine if lockdep is not built at all (and I didn't see any
complaints running fstests overnight), so remove this snippet entirely.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/super.c |   33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a51c2083cd6b..e1fd667454d4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1647,36 +1647,11 @@ EXPORT_SYMBOL(__sb_end_write);
  */
 int __sb_start_write(struct super_block *sb, int level, bool wait)
 {
-	bool force_trylock = false;
-	int ret = 1;
+	if (!wait)
+		return percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
 
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * We want lockdep to tell us about possible deadlocks with freezing
-	 * but it's it bit tricky to properly instrument it. Getting a freeze
-	 * protection works as getting a read lock but there are subtle
-	 * problems. XFS for example gets freeze protection on internal level
-	 * twice in some cases, which is OK only because we already hold a
-	 * freeze protection also on higher level. Due to these cases we have
-	 * to use wait == F (trylock mode) which must not fail.
-	 */
-	if (wait) {
-		int i;
-
-		for (i = 0; i < level - 1; i++)
-			if (percpu_rwsem_is_held(sb->s_writers.rw_sem + i)) {
-				force_trylock = true;
-				break;
-			}
-	}
-#endif
-	if (wait && !force_trylock)
-		percpu_down_read(sb->s_writers.rw_sem + level-1);
-	else
-		ret = percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
-
-	WARN_ON(force_trylock && !ret);
-	return ret;
+	percpu_down_read(sb->s_writers.rw_sem + level-1);
+	return 1;
 }
 EXPORT_SYMBOL(__sb_start_write);
 
