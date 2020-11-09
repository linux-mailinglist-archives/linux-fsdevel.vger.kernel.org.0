Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E22AC37A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKISRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:17:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgKISRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:17:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9I9ihL113375;
        Mon, 9 Nov 2020 18:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=L8CBYQV4P4s2bxK8vs2Sx/iljdBfIt6H46S+OgitivI=;
 b=ck26avDY+1tLiHo0ktm2ufeNQWDD16fBrOdVopOtipiWXL6OvfGBOSNxoKBCJGqsDCWO
 uBMDgr7ilA5xBLQvDWo3TD9FdvDCZNRfC7YvsBR4FRM7G9i+duC5/pOIe8pf31s1rSYi
 ZKzvu81j4N2aSbjinsepv6itjuTH17qPheogeL4vuDrNdryLkXjOY5sJXad6D+p3dngo
 ScZ7LnlPOjHZL3UFvUxFb9FrJIs1/H9lW6OGo1m52B2K5J3UCF+86edlkuZeOOwPCn+H
 9/bKCkSSqHAtu7T3X39ME98sZV1WpRuZPDhRDg0HylLMSwyH42hw9kovjG0/HJAgs9CH kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72edmtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 18:16:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IB9bC195311;
        Mon, 9 Nov 2020 18:16:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55m9mx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 18:16:52 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9IGqFm009922;
        Mon, 9 Nov 2020 18:16:52 GMT
Received: from localhost (/10.159.239.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 10:16:52 -0800
Subject: [PATCH 1/3] vfs: remove lockdep bogosity in __sb_start_write
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Nov 2020 10:16:50 -0800
Message-ID: <160494581071.772573.10466314698408344068.stgit@magnolia>
In-Reply-To: <160494580419.772573.9286165021627298770.stgit@magnolia>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090126
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

NOTE: Commit f4b554af9931 in 2015 created the current weird logic (which
used to exist in a different form in commit 5accdf82ba25c from 2012) in
__sb_start_write.  XFS solved this whole problem in the late 2.6 era by
creating a variant of transactions (XFS_TRANS_NO_WRITECOUNT) that don't
grab intwrite freeze protection, thus making lockdep's solution
unnecessary.  The commit claims that Dave Chinner explained that the
trylock hack + comment could be removed, but nobody ever did.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
 

