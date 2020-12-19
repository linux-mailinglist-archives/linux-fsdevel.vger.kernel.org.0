Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C42DEC3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 01:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLSAHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 19:07:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49348 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgLSAHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 19:07:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ06MVk018009;
        Sat, 19 Dec 2020 00:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=h05qvuELutaWEFd0FH0nDiggcQgz3WjMZcVQ54H2AqM=;
 b=g8reo9uoK2ZSBudZW4xxmSItvP+/L42kFQiBXHAnIIwqiUYWSaYFiCVCMUJdD/XyW50R
 hVcc6UthXBb91n9ilE403Q8o7iLtw70p3Pd2drJQmMuqOLx+n6MdR4dAG/gcDaiGG39G
 9yJ7jshd32I/5o6rwFnuFPh5N7D+RsIAq8VcnsgdlsJUwhAyWYcQMha1150F9QQiZ1lY
 el+BDhsA67ctUdZRbZDJi41WxX7IXuW25pS+nC6MRWJdGxMJMEgXyknSYJh6s/9ajfim
 vH+PMr8q1uHc5JOBSnLj/dyQJmvrxvBtK6gPNUHbLFyiP3jIK9sL+n1uyKBTs3Fr5/oG RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35ckcbvw8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Dec 2020 00:06:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ05OhR049261;
        Sat, 19 Dec 2020 00:06:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35g3rgsfn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 00:06:31 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BJ06Tmr022519;
        Sat, 19 Dec 2020 00:06:29 GMT
Received: from localhost (/10.159.241.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 16:06:29 -0800
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
Subject: [PATCH v3 2/2] proc: ensure security hook is called after exec
Date:   Fri, 18 Dec 2020 16:06:16 -0800
Message-Id: <20201219000616.197585-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219000616.197585-1-stephen.s.brennan@oracle.com>
References: <20201219000616.197585-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180164
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Smack needs its security_task_to_inode() hook to be called when a task
execs a new executable. Store the self_exec_id of the task and call the
hook via pid_update_inode() whenever the exec_id changes.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

As discussed on the v2 of the patch, this should allow Smack to receive a
security_task_to_inode() call only when the uid/gid changes, or when the task
execs a new binary. I have verified that this doesn't change the performance of
the patch set, and that we do fall out of RCU walk on tasks which have recently
exec'd.

 fs/proc/base.c     | 4 +++-
 fs/proc/internal.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4b246e9bd5df..ad59e92e8433 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1917,6 +1917,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+	ei->exec_id = task->self_exec_id;
 	security_task_to_inode(task, inode);
 
 out:
@@ -1965,6 +1966,7 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
 	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
 
 	inode->i_mode &= ~(S_ISUID | S_ISGID);
+	PROC_I(inode)->exec_id = task->self_exec_id;
 	security_task_to_inode(task, inode);
 }
 
@@ -1979,7 +1981,7 @@ static bool pid_inode_needs_update(struct task_struct *task, struct inode *inode
 	task_dump_owner(task, inode->i_mode, &uid, &gid);
 	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
 		return true;
-	return false;
+	return task->self_exec_id != PROC_I(inode)->exec_id;
 }
 
 /*
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index f60b379dcdc7..1df9b039dfc3 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -92,7 +92,10 @@ union proc_op {
 
 struct proc_inode {
 	struct pid *pid;
-	unsigned int fd;
+	union {
+		unsigned int fd;
+		u32 exec_id;
+	};
 	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
-- 
2.25.1

