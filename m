Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56984108694
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 03:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKYCsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 21:48:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:34958 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfKYCsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:48:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 18:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="205972989"
Received: from hu.sh.intel.com ([10.239.158.51])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2019 18:48:08 -0800
From:   "Chen, Hu" <hu1.chen@intel.com>
Cc:     avagin@openvz.org, hu1.chen@intel.com, lkp@intel.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] proc: align mnt_id in /proc/pid/fdinfo and /proc/pid/mountinfo
Date:   Mon, 25 Nov 2019 10:26:37 +0800
Message-Id: <20191125022641.4169-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <201911221116.HjFCwKbG%lkp@intel.com>
References: <201911221116.HjFCwKbG%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For Android application process, we found that the mnt_id read from
/proc/pid/fdinfo doesn't exist in /proc/pid/mountinfo. Thus CRIU fails
to dump such process and it complains

"(00.019206) Error (criu/files-reg.c:1299): Can't lookup mount=42 for
fd=-3 path=/data/dalvik-cache/x86_64/system@framework@boot.art"

This is due to how Android application is launched. In Android, there is
a special process called Zygote which handles the forking of each new
application process:
0. Zygote opens and maps some files, for example
   "/data/dalvik-cache/x86_64/system@framework@boot.art" in its current
   mount namespace, say "old mnt ns".
1. Zygote waits for the request to fork a new application.
2. Zygote gets a request, it forks and run the new process in a new
   mount namespace, say "new mnt ns".

The file opened in step 0 ties to the mount point in "old mnt ns". The
mnt_id of that mount is listed in /proc/pid/fdinfo. However,
/proc/pid/mountinfo points to current ns, i.e., "new mnt ns".

Althgouh this issue is exposed in Android, we believe it's generic.
Prcoess may open files and enter new mnt ns.

To address it, this patch searches the mirror mount in current ns with
MAJOR and MINOR and shows the mirror's mnt_id.

v2: fix warning reported by lkp

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---
 fs/mount.h     |  2 ++
 fs/namespace.c | 30 ++++++++++++++++++++++++++++++
 fs/proc/fd.c   | 12 ++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..6bbfc2b3b8ba 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -153,3 +153,5 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
 	return ns->seq == 0;
 }
+
+extern struct mount *lookup_mirror_mnt(const struct mount *mnt);
diff --git a/fs/namespace.c b/fs/namespace.c
index 2adfe7b166a3..131b36517472 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -683,6 +683,36 @@ bool __is_local_mountpoint(struct dentry *dentry)
 	return is_covered;
 }
 
+/*
+ * lookup_mirror_mnt - Return @mnt's mirror mount in the current/local mount
+ * namespace. If mirror isn't found, just return NULL.
+ */
+struct mount *lookup_mirror_mnt(const struct mount *mnt)
+{
+	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
+	struct mount *mnt_local;
+	bool is_matched = false;
+
+	/* mnt belongs to current namesapce */
+	if (mnt->mnt_ns == ns)
+		return (struct mount *) mnt;
+
+	down_read(&namespace_sem);
+	list_for_each_entry(mnt_local, &ns->list, mnt_list) {
+		struct super_block *sb = mnt->mnt.mnt_sb;
+		struct super_block *sb_local = mnt_local->mnt.mnt_sb;
+
+		if (MAJOR(sb->s_dev) == MAJOR(sb_local->s_dev) &&
+		    MINOR(sb->s_dev) == MINOR(sb_local->s_dev)) {
+			is_matched = true;
+			break;
+		}
+	}
+	up_read(&namespace_sem);
+
+	return is_matched ? mnt_local : NULL;
+}
+
 static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
 {
 	struct hlist_head *chain = mp_hash(dentry);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..cbf2571b0620 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -23,6 +23,7 @@ static int seq_show(struct seq_file *m, void *v)
 	int f_flags = 0, ret = -ENOENT;
 	struct file *file = NULL;
 	struct task_struct *task;
+	struct mount *mount = NULL;
 
 	task = get_proc_task(m->private);
 	if (!task)
@@ -53,9 +54,16 @@ static int seq_show(struct seq_file *m, void *v)
 	if (ret)
 		return ret;
 
+	/* After unshare -m, real_mount(file->f_path.mnt) is not meaningful in
+	 * current mount namesapce. We want to know the mnt_id in current mount
+	 * namespace
+	 */
+	mount = lookup_mirror_mnt(real_mount(file->f_path.mnt));
+	if (!mount)
+		mount = real_mount(file->f_path.mnt);
+
 	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
-		   (long long)file->f_pos, f_flags,
-		   real_mount(file->f_path.mnt)->mnt_id);
+		   (long long)file->f_pos, f_flags, mount->mnt_id);
 
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
-- 
2.22.0

