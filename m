Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6A2EA0B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhADXXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:23:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45114 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbhADXXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:23:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NIkN0157881;
        Mon, 4 Jan 2021 23:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=of7cDloEGBPE5l8WJ889ZLzwlRrbg724FmM0fBM4+OA=;
 b=GtFrS5/8a9nCTxCjnqVUQa91ZYBEEcVT1X9IWYtCbZXrYMFyvDIpjUQYBht/DXkgUWPF
 a4k+J08vTkAqjqEY4HeAN76GhVnFDhG2aTfE1qvd3vzixnYWwbFB1uoqPPPtyBtSoujn
 WLsdwkiDm2K5lx2/XwbJFtLEaD618jhsVxPR4ube9ECoiVwdkG65fZGMK1qubGijhkuP
 DrMO7GOv7KiWQWjZkI4K9VqP39aIT1uYIyEq6DYZOZ9lZ+Y8OZV7VW2fDj/WzY6Sy24+
 eAl7Dw6QC5N9/geVG0wgcRV7HxE3FUByL1IZUDai2c0i6gkR5SIfwKcNPP82BMgP2BY5 fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35tebappcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 23:22:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NKJmP089224;
        Mon, 4 Jan 2021 23:21:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35uxnrut8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 23:21:59 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104NLq9j000985;
        Mon, 4 Jan 2021 23:21:54 GMT
Received: from localhost (/10.159.240.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 23:21:52 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Mon,  4 Jan 2021 15:21:22 -0800
Message-Id: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040141
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function drops from RCU into REF lookup mode. When
many threads are resolving paths within /proc in parallel, this can
result in heavy spinlock contention on d_lockref as each thread tries to
grab a reference to the /proc dentry (and drop it shortly thereafter).

Investigation indicates that it is not necessary to drop RCU in
pid_revalidate(), as no RCU data is modified and the function never
sleeps. So, remove the LOOKUP_RCU check.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
When running running ~100 parallel instances of "TZ=/etc/localtime ps -fe
>/dev/null" on a 100CPU machine, the %sys utilization reaches 90%, and perf
shows the following code path as being responsible for heavy contention on
the d_lockref spinlock:

      walk_component()
        lookup_fast()
          d_revalidate()
            pid_revalidate() // returns -ECHILD
          unlazy_child()
            lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention

By applying this patch, %sys utilization falls to around 60% under the same
workload. Although this particular workload is a bit contrived, we have seen
some monitoring scripts which produced similarly high %sys time due to this
contention.

Changes in v4:
- Simplify by unconditionally calling pid_update_inode() from pid_revalidate,
  and removing the LOOKUP_RCU check.
Changes in v3:
- Rather than call pid_update_inode() with flags, create
  proc_inode_needs_update() to determine whether the call can be skipped.
- Restore the call to the security hook (see next patch).
Changes in v2:
- Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
  unnecessary.
- Remove the call to security_task_to_inode().

 fs/proc/base.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f52217f432bc..633ef74e8dfd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1974,19 +1974,18 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int ret = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 
 	if (task) {
 		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		ret = 1;
 	}
-	return 0;
+	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.25.1

