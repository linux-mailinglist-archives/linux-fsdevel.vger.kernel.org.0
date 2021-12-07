Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BF46C74F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhLGWVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 17:21:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37970 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhLGWVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:21:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77432CE1E01;
        Tue,  7 Dec 2021 22:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F9CC341C3;
        Tue,  7 Dec 2021 22:17:30 +0000 (UTC)
Date:   Tue, 7 Dec 2021 17:17:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yabin Cui <yabinc@google.com>
Subject: [PATCH v2] tracefs: Set all files to the same group ownership as
 the mount option
Message-ID: <20211207171729.2a54e1b3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As people have been asking to allow non-root processes to have access to
the tracefs directory, it was considered best to only allow groups to have
access to the directory, where it is easier to just set the tracefs file
system to a specific group (as other would be too dangerous), and that way
the admins could pick which processes would have access to tracefs.

Unfortunately, this broke tooling on Android that expected the other bit
to be set. For some special cases, for non-root tools to trace the system,
tracefs would be mounted and change the permissions of the top level
directory which gave access to all running tasks permission to the
tracing directory. Even though this would be dangerous to do in a
production environment, for testing environments this can be useful.

Now with the new changes to not allow other (which is still the proper
thing to do), it breaks the testing tooling. Now more code needs to be
loaded on the system to change ownership of the tracing directory.

The real solution is to have tracefs honor the gid=xxx option when
mounting. That is,

(tracing group tracing has value 1003)

 mount -t tracefs -o gid=1003 tracefs /sys/kernel/tracing

should have it that all files in the tracing directory should be of the
given group.

Copy the logic from d_walk() from dcache.c and simplify it for the mount
case of tracefs if gid is set. All the files in tracefs will be walked and
their group will be set to the value passed in.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Kalesh Singh <kaleshsingh@google.com>
Reported-by: Yabin Cui <yabinc@google.com>
Fixes: 49d67e445742 ("tracefs: Have tracefs directories not set OTH permission bits by default")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20211207161518.3a00be3c@gandalf.local.home
  - Removed unused "out_unlock" label.


 fs/tracefs/inode.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 607b03444623..a6709c08fa54 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -161,6 +161,78 @@ struct tracefs_fs_info {
 	struct tracefs_mount_opts mount_opts;
 };
 
+static void change_gid(struct dentry *dentry, kgid_t gid)
+{
+	if (!dentry->d_inode)
+		return;
+	dentry->d_inode->i_gid = gid;
+}
+
+/*
+ * Taken from d_walk, but without he need for handling renames.
+ * Nothing can be renamed while walking the list, as tracefs
+ * does not support renames. This is only called when mounting
+ * or remounting the file system, to set all the files to
+ * the given gid.
+ */
+static void set_gid(struct dentry *parent, kgid_t gid)
+{
+	struct dentry *this_parent;
+	struct list_head *next;
+
+	this_parent = parent;
+	spin_lock(&this_parent->d_lock);
+
+	change_gid(this_parent, gid);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct list_head *tmp = next;
+		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
+		next = tmp->next;
+
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+
+		change_gid(dentry, gid);
+
+		if (!list_empty(&dentry->d_subdirs)) {
+			spin_unlock(&this_parent->d_lock);
+			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
+			this_parent = dentry;
+			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
+			goto repeat;
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	/*
+	 * All done at this level ... ascend and resume the search.
+	 */
+	rcu_read_lock();
+ascend:
+	if (this_parent != parent) {
+		struct dentry *child = this_parent;
+		this_parent = child->d_parent;
+
+		spin_unlock(&child->d_lock);
+		spin_lock(&this_parent->d_lock);
+
+		/* go into the first sibling still alive */
+		do {
+			next = child->d_child.next;
+			if (next == &this_parent->d_subdirs)
+				goto ascend;
+			child = list_entry(next, struct dentry, d_child);
+		} while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
+		rcu_read_unlock();
+		goto resume;
+	}
+	rcu_read_unlock();
+
+	spin_unlock(&this_parent->d_lock);
+	return;
+}
+
 static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -193,6 +265,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
+			set_gid(tracefs_mount->mnt_root, gid);
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
-- 
2.31.1

