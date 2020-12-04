Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D52CE3E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501891AbgLDAHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:07:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLDAHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:07:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4061lG123363;
        Fri, 4 Dec 2020 00:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=M6YpxecNsswGuGNsYFeS11pXzHFa54HvZeVouPfIfQY=;
 b=HBfnQBxC4mFr98tz4VwTBw9johloCCEbAGPaZ+Og9sM5zXwJLhT5FsLkPFOR9cInuYeB
 rp/pYDrztZpKe0dr0P5Ozkj8gJ0GsVvPV8VFEtp+ESDmTIy6aEqIFxEMCO69XemKxnJM
 RPuH4iB6Yaur/X9N8Qt50zL1KrhTdtZaQcNIRrr0aXet0CVu2dmv1MRm1KxJ5Ug6fYdp
 AdaqCrHacx8CxSc2Ah8jbjzuSfnG3gfJNTeV/PAZTTZhqKERWqAVVSSPSNBF9mmNl43t
 JH3XLfZgNqIzTsHeGu+X8O3DD81VgY5pB+SZtzUWLT9+qKHUCU+HmbULl8qcmOHeKeGR rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 353dyr0vc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 00:06:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3NuDhY118763;
        Fri, 4 Dec 2020 00:04:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3540f2k2ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 00:03:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B403sjG017376;
        Fri, 4 Dec 2020 00:03:55 GMT
Received: from localhost (/10.159.156.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 16:03:54 -0800
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
Subject: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Thu,  3 Dec 2020 16:02:12 -0800
Message-Id: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030133
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function requires dropping from RCU into REF lookup
mode. When many threads are resolving paths within /proc in parallel,
this can result in heavy spinlock contention as each thread tries to
grab a reference to the /proc dentry lock (and drop it shortly
thereafter).

Allow the pid_revalidate() function to execute under LOOKUP_RCU. When
updates must be made to the inode due to the owning task performing
setuid(), drop out of RCU and into REF mode. Remove the call to
security_task_to_inode(), since we can rely on the call from
proc_pid_make_inode().

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
I'd like to use this patch as an RFC on this approach for reducing spinlock
contention during many parallel path lookups in the /proc filesystem. The
contention can be triggered by, for example, running ~100 parallel instances of
"TZ=/etc/localtime ps -fe >/dev/null" on a 100CPU machine. The %sys utilization
in such a case reaches around 90%, and profiles show two code paths with high
utilization:

    walk_component
      lookup_fast
        unlazy_child
          legitimize_root
            __legitimize_path
              lockref_get_not_dead

    terminate_walk
      dput
        dput

By applying this patch, %sys utilization falls to around 60% under the same
workload. Although this particular workload is a bit contrived, we have seen
some monitoring scripts which produced high %sys time due to this contention.

Changes from v2:
- Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
  unnecessary.
- Remove the call to security_task_to_inode().

 fs/proc/base.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..833d55a59e20 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1813,12 +1813,28 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 /*
  * Set <pid>/... inode ownership (can change due to setuid(), etc.)
  */
-void pid_update_inode(struct task_struct *task, struct inode *inode)
+static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
+			       unsigned int flags)
 {
-	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
+	kuid_t uid;
+	kgid_t gid;
+
+	task_dump_owner(task, inode->i_mode, &uid, &gid);
+	if (uid_eq(uid, inode->i_uid) && gid_eq(gid, inode->i_gid) &&
+			!(inode->i_mode & (S_ISUID | S_ISGID)))
+		return 1;
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
 
+	inode->i_uid = uid;
+	inode->i_gid = gid;
 	inode->i_mode &= ~(S_ISUID | S_ISGID);
-	security_task_to_inode(task, inode);
+	return 1;
+}
+
+void pid_update_inode(struct task_struct *task, struct inode *inode)
+{
+	do_pid_update_inode(task, inode, 0);
 }
 
 /*
@@ -1830,19 +1846,22 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
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
-	if (task) {
-		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+	if (flags & LOOKUP_RCU) {
+		inode = d_inode_rcu(dentry);
+		task = pid_task(proc_pid(inode), PIDTYPE_PID);
+		if (task)
+			rv = do_pid_update_inode(task, inode, flags);
+	} else {
+		inode = d_inode(dentry);
+		task = get_proc_task(inode);
+		if (task) {
+			rv = do_pid_update_inode(task, inode, flags);
+			put_task_struct(task);
+		}
 	}
-	return 0;
+	return rv;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.25.1

