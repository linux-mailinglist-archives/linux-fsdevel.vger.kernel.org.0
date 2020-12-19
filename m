Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D512DEC44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 01:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLSAHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 19:07:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgLSAHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:07:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ06FvD007874;
        Sat, 19 Dec 2020 00:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=zxiY7+GksnlWJv9IRLMUs6wIm9qq5bjvBFvbKqgvlng=;
 b=cVRS1aPm18bYapDw9tLAzv3uFGMxrx48q2eUdBDy2RWSiSdqeuPU/ufUthe/ZMh6QpCG
 tTG4Bw4mDD09mW3NqbmkdNPa132AqBdY3+aFTrZOXfYT+VNC5QczGpsMCknu5Sym59IG
 gO/hJuv432nQAU79raUqzK4DBMYiOUPN6IkyqIDjVwCCKNo4MAGbmkhd5BBcStR5WBlI
 L8YFPVYjksft5EyWp2nrNv+HDCKESh1RXQy2LDm8YvckFd03k6sVN8plKxw76LWYU/P1
 t4DmlTdW/u+biRSt0z1vXkxnC4hN6RtkPdHR5EbFayB0/hLslCfOzUG127wkozoe2C9l xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9rvqrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Dec 2020 00:06:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ05OH8151366;
        Sat, 19 Dec 2020 00:06:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7esvfc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 00:06:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BJ06Rok003375;
        Sat, 19 Dec 2020 00:06:27 GMT
Received: from localhost (/10.159.241.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 16:06:27 -0800
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
Subject: [PATCH v3 1/2] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Fri, 18 Dec 2020 16:06:15 -0800
Message-Id: <20201219000616.197585-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180164
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function requires dropping from RCU into REF lookup
mode. When many threads are resolving paths within /proc in parallel,
this can result in heavy spinlock contention on d_locrkef as each thread
tries to grab a reference to the /proc dentry (and drop it shortly
thereafter).

Allow the pid_revalidate() function to execute under LOOKUP_RCU. When
updates must be made to the inode, drop out of RCU and into REF mode.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

When running running ~100 parallel instances of "TZ=/etc/localtime ps -fe
>/dev/null" on a 100CPU machine, the %sys utilization reaches 90%, and perf
shows the following code path as being responsible for heavy contention on
the d_lockref spinlock:

      walk_component()
        lookup_fast()
          unlazy_child()
            lockref_get_not_dead(&nd->path.dentry->d_lockref)

By applying this patch, %sys utilization falls to around 60% under the same
workload. Although this particular workload is a bit contrived, we have seen
some monitoring scripts which produced similarly high %sys time due to this
contention.

Changes from v3:
- Rather than call pid_update_inode() with flags, create
  proc_inode_needs_update() to determine whether the call can be skipped.
- Restore the call to the security hook (see next patch).
Changes from v2:
- Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
  unnecessary.
- Remove the call to security_task_to_inode().

 fs/proc/base.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..4b246e9bd5df 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1968,6 +1968,20 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
 	security_task_to_inode(task, inode);
 }
 
+/* See if we can avoid the above call. Assumes RCU lock held */
+static bool pid_inode_needs_update(struct task_struct *task, struct inode *inode)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	if (inode->i_mode & (S_ISUID | S_ISGID))
+		return true;
+	task_dump_owner(task, inode->i_mode, &uid, &gid);
+	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
+		return true;
+	return false;
+}
+
 /*
  * Rewrite the inode's ownerships here because the owning task may have
  * performed a setuid(), etc.
@@ -1977,19 +1991,20 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int rv = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
-
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
-		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		rv = 1;
+		if ((flags & LOOKUP_RCU) && pid_inode_needs_update(task, inode))
+			rv = -ECHILD;
+		else if (!(flags & LOOKUP_RCU))
+			pid_update_inode(task, inode);
 	}
-	return 0;
+	rcu_read_unlock();
+	return rv;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.25.1

