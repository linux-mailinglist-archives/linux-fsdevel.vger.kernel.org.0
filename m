Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13288698
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfHIW73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:59:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:23377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730744AbfHIW7J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:59:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:08 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="199539307"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:08 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 18/19] {mm,procfs}: Add display file_pins proc
Date:   Fri,  9 Aug 2019 15:58:32 -0700
Message-Id: <20190809225833.6657-19-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that we have the file pins information stored add a new procfs entry
to display them to the user.

NOTE output will be dependant on where the file pin is tied to.  Some
processes may have the pin associated with a file descriptor in which
case that file is reported as well.

Others are associated directly with the process mm and are reported as
such.

For example of a file pinned to an RDMA open context (fd 4) and a file
pinned to the mm of that process:

4: /dev/infiniband/uverbs0
   /mnt/pmem/foo
/mnt/pmem/bar

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/proc/base.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..f4d219172235 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2995,6 +2995,7 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
  */
 static const struct file_operations proc_task_operations;
 static const struct inode_operations proc_task_inode_operations;
+static const struct file_operations proc_pid_file_pins_operations;
 
 static const struct pid_entry tgid_base_stuff[] = {
 	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
@@ -3024,6 +3025,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
 	ONE("statm",      S_IRUGO, proc_pid_statm),
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
+	REG("file_pins",  S_IRUGO, proc_pid_file_pins_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
 #endif
@@ -3422,6 +3424,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("stat",      S_IRUGO, proc_tid_stat),
 	ONE("statm",     S_IRUGO, proc_pid_statm),
 	REG("maps",      S_IRUGO, proc_pid_maps_operations),
+	REG("file_pins", S_IRUGO, proc_pid_file_pins_operations),
 #ifdef CONFIG_PROC_CHILDREN
 	REG("children",  S_IRUGO, proc_tid_children_operations),
 #endif
@@ -3718,3 +3721,214 @@ void __init set_proc_pid_nlink(void)
 	nlink_tid = pid_entry_nlink(tid_base_stuff, ARRAY_SIZE(tid_base_stuff));
 	nlink_tgid = pid_entry_nlink(tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
+
+/**
+ * file_pin information below.
+ */
+
+struct proc_file_pins_private {
+	struct inode *inode;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	struct files_struct *files;
+	unsigned int nr_pins;
+	struct xarray fps;
+} __randomize_layout;
+
+static void release_fp(struct proc_file_pins_private *priv)
+{
+	up_read(&priv->mm->mmap_sem);
+	mmput(priv->mm);
+}
+
+static void print_fd_file_pin(struct seq_file *m, struct file *file,
+			    unsigned long i)
+{
+	struct file_file_pin *fp;
+	struct file_file_pin *tmp;
+
+	if (list_empty_careful(&file->file_pins))
+		return;
+
+	seq_printf(m, "%lu: ", i);
+	seq_file_path(m, file, "\n");
+	seq_putc(m, '\n');
+
+	list_for_each_entry_safe(fp, tmp, &file->file_pins, list) {
+		seq_puts(m, "   ");
+		seq_file_path(m, fp->file, "\n");
+		seq_putc(m, '\n');
+	}
+}
+
+/* We are storing the index's within the FD table for later retrieval */
+static int store_fd(const void *priv , struct file *file, unsigned i)
+{
+	struct proc_file_pins_private *fp_priv;
+
+	/* cast away const... */
+	fp_priv = (struct proc_file_pins_private *)priv;
+
+	if (list_empty_careful(&file->file_pins))
+		return 0;
+
+	/* can't sleep in the iterate of the fd table */
+	xa_store(&fp_priv->fps, fp_priv->nr_pins, xa_mk_value(i), GFP_ATOMIC);
+	fp_priv->nr_pins++;
+
+	return 0;
+}
+
+static void store_mm_pins(struct proc_file_pins_private *priv)
+{
+	struct mm_file_pin *fp;
+	struct mm_file_pin *tmp;
+
+	list_for_each_entry_safe(fp, tmp, &priv->mm->file_pins, list) {
+		xa_store(&priv->fps, priv->nr_pins, fp, GFP_KERNEL);
+		priv->nr_pins++;
+	}
+}
+
+
+static void *fp_start(struct seq_file *m, loff_t *ppos)
+{
+	struct proc_file_pins_private *priv = m->private;
+	unsigned int pos = *ppos;
+
+	priv->task = get_proc_task(priv->inode);
+	if (!priv->task)
+		return ERR_PTR(-ESRCH);
+
+	if (!priv->mm || !mmget_not_zero(priv->mm))
+		return NULL;
+
+	priv->files = get_files_struct(priv->task);
+	down_read(&priv->mm->mmap_sem);
+
+	xa_destroy(&priv->fps);
+	priv->nr_pins = 0;
+
+	/* grab fds of "files" which have pins and store as xa values */
+	if (priv->files)
+		iterate_fd(priv->files, 0, store_fd, priv);
+
+	/* store mm_file_pins as xa entries */
+	store_mm_pins(priv);
+
+	if (pos >= priv->nr_pins) {
+		release_fp(priv);
+		return NULL;
+	}
+
+	return xa_load(&priv->fps, pos);
+}
+
+static void *fp_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct proc_file_pins_private *priv = m->private;
+
+	(*pos)++;
+	if ((*pos) >= priv->nr_pins) {
+		release_fp(priv);
+		return NULL;
+	}
+
+	return xa_load(&priv->fps, *pos);
+}
+
+static void fp_stop(struct seq_file *m, void *v)
+{
+	struct proc_file_pins_private *priv = m->private;
+
+	if (v)
+		release_fp(priv);
+
+	if (priv->task) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
+	}
+
+	if (priv->files) {
+		put_files_struct(priv->files);
+		priv->files = NULL;
+	}
+}
+
+static int show_fp(struct seq_file *m, void *v)
+{
+	struct proc_file_pins_private *priv = m->private;
+
+	if (xa_is_value(v)) {
+		struct file *file;
+		unsigned long fd = xa_to_value(v);
+
+		rcu_read_lock();
+		file = fcheck_files(priv->files, fd);
+		if (file)
+			print_fd_file_pin(m, file, fd);
+		rcu_read_unlock();
+	} else {
+		struct mm_file_pin *fp = v;
+
+		seq_puts(m, "mm: ");
+		seq_file_path(m, fp->file, "\n");
+	}
+
+	return 0;
+}
+
+static const struct seq_operations proc_pid_file_pins_op = {
+	.start	= fp_start,
+	.next	= fp_next,
+	.stop	= fp_stop,
+	.show	= show_fp
+};
+
+static int proc_file_pins_open(struct inode *inode, struct file *file)
+{
+	struct proc_file_pins_private *priv = __seq_open_private(file,
+						&proc_pid_file_pins_op,
+						sizeof(*priv));
+
+	if (!priv)
+		return -ENOMEM;
+
+	xa_init(&priv->fps);
+	priv->inode = inode;
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->task = NULL;
+	if (IS_ERR(priv->mm)) {
+		int err = PTR_ERR(priv->mm);
+
+		seq_release_private(inode, file);
+		return err;
+	}
+
+	return 0;
+}
+
+static int proc_file_pins_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct proc_file_pins_private *priv = seq->private;
+
+	/* This is for "protection" not sure when these may end up not being
+	 * NULL here... */
+	WARN_ON(priv->files);
+	WARN_ON(priv->task);
+
+	if (priv->mm)
+		mmdrop(priv->mm);
+
+	xa_destroy(&priv->fps);
+
+	return seq_release_private(inode, file);
+}
+
+static const struct file_operations proc_pid_file_pins_operations = {
+	.open		= proc_file_pins_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= proc_file_pins_release,
+};
-- 
2.20.1

