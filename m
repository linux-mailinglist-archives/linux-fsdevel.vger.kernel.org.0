Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8432C8EB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgK3UIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 15:08:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbgK3UIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:08:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUK5N3t124928;
        Mon, 30 Nov 2020 20:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=vV22iuphH7okguNUcjnpFoN+hxHfHxrPfWxv3vHOUxs=;
 b=KnQigUcFSOWX44ycxctXGqjVgCpkPDtBJ7gd6wuK1BkqY+m5zNscp43AkEsU9fhcI46W
 btuSRy9Kn7yQ1mtach9QIAakp2Iirb2CK/Oay07+hTYZ0rOigP7pXPUOZDjc8EA3u3g3
 gs0TQEDipbbLsws8nbE1lzh6xUvMEhu3wDQux5Y1DDEWOPodYUFbLKZQefmc07hwDyJF
 ans0T21Trk9q8NA+c6l5QJl0fYQlUQht5g6gjSHWfrQl3VdpZPUrsYrt+49uBLoYb9Hn
 H+lsCf/+PrrDhsTRRABdebI+0diOPjrdDqiL2g0GQyW4dquDAKH4YV4q6EHzjz05eANx vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 353dyqf3ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 20:07:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUJk4j9163488;
        Mon, 30 Nov 2020 20:07:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3540ex0hk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 20:07:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AUK6xA2020566;
        Mon, 30 Nov 2020 20:07:01 GMT
Received: from localhost (/10.159.146.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 12:06:59 -0800
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
Subject: [PATCH] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Mon, 30 Nov 2020 12:06:19 -0800
Message-Id: <20201130200619.84819-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300129
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function requires dropping from RCU into REF lookup
mode. When many threads are resolving paths within /proc in parallel,
this can result in heavy spinlock contention as each thread tries to
grab a reference to the /proc dentry (and drop it shortly thereafter).

Allow the pid_revalidate() function to execute under LOOKUP_RCU. When
updates must be made to the inode due to the owning task performing
setuid(), drop out of RCU and into REF mode.

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
workload.

One item I'd like to highlight about this patch is that the
security_task_to_inode() hook is called less frequently as a result. I don't
know whether this is a major concern, which is why I've included security
reviewers as well.

 fs/proc/base.c      | 50 ++++++++++++++++++++++++++++++++-------------
 fs/proc/internal.h  |  5 +++++
 include/linux/pid.h |  2 ++
 kernel/pid.c        | 12 +++++++++++
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..038056f94ed0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1813,12 +1813,29 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 /*
  * Set <pid>/... inode ownership (can change due to setuid(), etc.)
  */
-void pid_update_inode(struct task_struct *task, struct inode *inode)
+static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
+							   unsigned int flags)
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
 	security_task_to_inode(task, inode);
+	return 1;
+}
+
+void pid_update_inode(struct task_struct *task, struct inode *inode)
+{
+	do_pid_update_inode(task, inode, 0);
 }
 
 /*
@@ -1830,19 +1847,24 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
-
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
+	int rv = 0;
+
+	if (flags & LOOKUP_RCU) {
+		inode = d_inode_rcu(dentry);
+		task = get_proc_task_rcu(inode);
+		if (task) {
+			rv = do_pid_update_inode(task, inode, flags);
+			put_task_struct_rcu_user(task);
+		}
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
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index cd0c8d5ce9a1..aa6df65ad3eb 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -121,6 +121,11 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
 	return get_pid_task(proc_pid(inode), PIDTYPE_PID);
 }
 
+static inline struct task_struct *get_proc_task_rcu(const struct inode *inode)
+{
+	return get_pid_task_rcu_user(proc_pid(inode), PIDTYPE_PID);
+}
+
 void task_dump_owner(struct task_struct *task, umode_t mode,
 		     kuid_t *ruid, kgid_t *rgid);
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 9645b1194c98..0b2c54f85e6d 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -86,6 +86,8 @@ static inline struct pid *get_pid(struct pid *pid)
 extern void put_pid(struct pid *pid);
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
 extern struct task_struct *get_pid_task(struct pid *pid, enum pid_type);
+extern struct task_struct *get_pid_task_rcu_user(struct pid *pid,
+						 enum pid_type type);
 
 extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 0a9f2e437217..05acbd15cfa6 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -390,6 +390,18 @@ struct task_struct *get_pid_task(struct pid *pid, enum pid_type type)
 }
 EXPORT_SYMBOL_GPL(get_pid_task);
 
+struct task_struct *get_pid_task_rcu_user(struct pid *pid, enum pid_type type)
+{
+	struct task_struct *task;
+
+	task = pid_task(pid, type);
+	if (task && refcount_inc_not_zero(&task->rcu_users))
+		return task;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(get_pid_task_rcu_user);
+
 struct pid *find_get_pid(pid_t nr)
 {
 	struct pid *pid;
-- 
2.25.1

