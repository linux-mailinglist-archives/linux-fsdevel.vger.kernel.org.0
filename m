Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3859A34D97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFDQfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 12:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfFDQfX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:35:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20C153107B1C;
        Tue,  4 Jun 2019 16:35:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 104D25D9E5;
        Tue,  4 Jun 2019 16:35:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/8] security: Override creds in __fput() with last
 fputter's creds [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey@schaufler-ca.com>, dhowells@redhat.com,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Jun 2019 17:35:10 +0100
Message-ID: <155966611030.17449.1411028213562548153.stgit@warthog.procyon.org.uk>
In-Reply-To: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 04 Jun 2019 16:35:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So that the LSM can see the credentials of the last process to do an fput()
on a file object when the file object is being dismantled, do the following
steps:

 (1) Cache the current credentials in file->f_fput_cred at the point the
     file object's reference count reaches zero.

 (2) In __fput(), use override_creds() to apply those credentials to the
     dismantling process.  This is necessary so that if we're dismantling a
     unix socket that has semi-passed fds still in it, their fputs will
     pick up the same credentials if they're reduced to zero at that point.

     Note that it's probably not strictly necessary to take an extra ref on
     the creds here (which override_creds() does).

 (3) Destroy the fput creds in file_free_rcu().

This additionally makes the creds available to:

	fsnotify
	eventpoll
	file locking
	->fasync, ->release file ops
	superblock destruction
	mountpoint destruction

This allows various notifications about object cleanups/destructions to
carry appropriate credentials for the LSM to approve/disapprove them based
on the process that caused them, even if indirectly.

Note that this means that someone looking at /proc/<pid>/fd/<n> may end up
being inadvertently noted as the subject of a cleanup message if the
process they're looking at croaks whilst they're looking at it.

Further, kernel services like nfsd and cachefiles may be seen as the
fputter and may not have a system credential.  In cachefiles's case, it may
appear that cachefilesd caused the notification.

Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
---

 fs/file_table.c    |   12 ++++++++++++
 include/linux/fs.h |    1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 3f9c1b452c1d..9bf2be45b7f9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -46,6 +46,7 @@ static void file_free_rcu(struct rcu_head *head)
 	struct file *f = container_of(head, struct file, f_u.fu_rcuhead);
 
 	put_cred(f->f_cred);
+	put_cred(f->f_fput_cred);
 	kmem_cache_free(filp_cachep, f);
 }
 
@@ -252,6 +253,7 @@ struct file *alloc_file_clone(struct file *base, int flags,
  */
 static void __fput(struct file *file)
 {
+	const struct cred *saved_cred;
 	struct dentry *dentry = file->f_path.dentry;
 	struct vfsmount *mnt = file->f_path.mnt;
 	struct inode *inode = file->f_inode;
@@ -262,6 +264,12 @@ static void __fput(struct file *file)
 
 	might_sleep();
 
+	/* Set the creds of whoever triggered the last fput for the LSM.  Note
+	 * that this has to be made available to further fputs, say on fds
+	 * trapped in a unix socket.
+	 */
+	saved_cred = override_creds(file->f_fput_cred);
+
 	fsnotify_close(file);
 	/*
 	 * The function eventpoll_release() should be the first called
@@ -293,6 +301,8 @@ static void __fput(struct file *file)
 	if (unlikely(mode & FMODE_NEED_UNMOUNT))
 		dissolve_on_fput(mnt);
 	mntput(mnt);
+
+	revert_creds(saved_cred);
 out:
 	file_free(file);
 }
@@ -334,6 +344,7 @@ void fput_many(struct file *file, unsigned int refs)
 	if (atomic_long_sub_and_test(refs, &file->f_count)) {
 		struct task_struct *task = current;
 
+		file->f_fput_cred = get_current_cred();
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_u.fu_rcuhead, true))
@@ -368,6 +379,7 @@ void __fput_sync(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 		BUG_ON(!(task->flags & PF_KTHREAD));
+		file->f_fput_cred = get_current_cred();
 		__fput(file);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f1c74596cd77..db05738b1951 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -943,6 +943,7 @@ struct file {
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	const struct cred	*f_cred;
+	const struct cred	*f_fput_cred;	/* Who did the last fput() (for LSM) */
 	struct file_ra_state	f_ra;
 
 	u64			f_version;

