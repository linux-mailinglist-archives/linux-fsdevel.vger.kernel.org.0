Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4147136CB47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhD0StU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 14:49:20 -0400
Received: from mx-out.tlen.pl ([193.222.135.158]:58974 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0StS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:49:18 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 14:49:18 EDT
Received: (wp-smtpd smtp.tlen.pl 35945 invoked from network); 27 Apr 2021 20:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1619548408; bh=NS3BxI4uZDwsHBHnYgklyfy26nY9bsujkvflz4Xv7Qk=;
          h=From:To:Cc:Subject;
          b=LLwCkaNiNDB0JCJmJgrbT39EwIuXiX/QbjC4pTya5OKbKE0wkMzagVXxyhkddgZyQ
           lgvik77uSYHG1qabbnq0TTUqJNIqPxmTleyXfo2ZUjqxcGVWp6DW9gKk51Tdj68Tqc
           L9ubbtaW0fojw0N+x0fhHPsV3gBW1kcI7GrPe/RM=
Received: from 89-64-46-199.dynamic.chello.pl (HELO localhost.localdomain) (arek_koz@o2.pl@[89.64.46.199])
          (envelope-sender <arek_koz@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 27 Apr 2021 20:33:28 +0200
From:   "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] proc: Use seq_read_iter where possible
Date:   Tue, 27 Apr 2021 20:34:15 +0200
Message-Id: <20210427183414.12499-1-arek_koz@o2.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 53da6af5e6ff36288411c5fc49c71474
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [oZNE]                               
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since seq_read_iter looks mature enough to be used for all procfs files,
re-allow applications to perform zero-copy data forwarding from them.
According to the sendfile(2) man-page, it is still enough for the file
being read to support mmap-like operations, and the proc files support
memory mapping, so returning -EINVAL was an inconsistency.

Some executable-inspecting tools rely on patching entry point
instructions with minimal machine code that uses sendfile to read
/proc/self/maps to stdout.  The sendfile call allows them to do it
faster and without excessive allocations.

This is inspired by the series by Cristoph Hellwig (linked).

Link: https://lore.kernel.org/lkml/20201104082738.1054792-1-hch@lst.de/
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arkadiusz Kozdra (Arusekk) <arek_koz@o2.pl>
---
 fs/proc/array.c      |  9 +++++----
 fs/proc/base.c       | 36 ++++++++++++++++++++++++------------
 fs/proc/fd.c         |  3 ++-
 fs/proc/proc_net.c   |  4 ++--
 fs/proc/task_mmu.c   | 12 ++++++++----
 fs/proc/task_nommu.c |  3 ++-
 6 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index bb87e4d89cd8..3c3da655a6d0 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -797,9 +797,10 @@ static int children_seq_open(struct inode *inode, struct file *file)
 }
 
 const struct file_operations proc_tid_children_operations = {
-	.open    = children_seq_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.open		= children_seq_open,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 #endif /* CONFIG_PROC_CHILDREN */
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfcdba56..b9921a0c2d3d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -535,7 +535,8 @@ static ssize_t lstats_write(struct file *file, const char __user *buf,
 
 static const struct file_operations proc_lstats_operations = {
 	.open		= lstats_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= lstats_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -784,7 +785,8 @@ static int proc_single_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_single_file_operations = {
 	.open		= proc_single_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1473,7 +1475,8 @@ static int sched_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_operations = {
 	.open		= sched_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= sched_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1548,7 +1551,8 @@ static int sched_autogroup_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_autogroup_operations = {
 	.open		= sched_autogroup_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= sched_autogroup_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1651,7 +1655,8 @@ static int timens_offsets_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_timens_offsets_operations = {
 	.open		= timens_offsets_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= timens_offsets_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1708,7 +1713,8 @@ static int comm_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_comm_operations = {
 	.open		= comm_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= comm_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -2497,7 +2503,8 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_timers_operations = {
 	.open		= proc_timers_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release_private,
 };
@@ -2589,7 +2596,8 @@ static int timerslack_ns_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_timerslack_ns_operations = {
 	.open		= timerslack_ns_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= timerslack_ns_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -3041,7 +3049,8 @@ static int proc_projid_map_open(struct inode *inode, struct file *file)
 static const struct file_operations proc_uid_map_operations = {
 	.open		= proc_uid_map_open,
 	.write		= proc_uid_map_write,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3049,7 +3058,8 @@ static const struct file_operations proc_uid_map_operations = {
 static const struct file_operations proc_gid_map_operations = {
 	.open		= proc_gid_map_open,
 	.write		= proc_gid_map_write,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3057,7 +3067,8 @@ static const struct file_operations proc_gid_map_operations = {
 static const struct file_operations proc_projid_map_operations = {
 	.open		= proc_projid_map_open,
 	.write		= proc_projid_map_write,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3108,7 +3119,8 @@ static int proc_setgroups_release(struct inode *inode, struct file *file)
 static const struct file_operations proc_setgroups_operations = {
 	.open		= proc_setgroups_open,
 	.write		= proc_setgroups_write,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_setgroups_release,
 };
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 07fc4fad2602..9fa169f05548 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -77,7 +77,8 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 15c2e55d2ed2..a223480189f9 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -76,7 +76,7 @@ static int seq_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_seq_ops = {
 	.proc_open	= seq_open_net,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_simple_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release_net,
@@ -188,7 +188,7 @@ static int single_release_net(struct inode *ino, struct file *f)
 
 static const struct proc_ops proc_net_single_ops = {
 	.proc_open	= single_open_net,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_write	= proc_simple_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release_net,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e862cab69583..7655f5018945 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -351,7 +351,8 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
@@ -1009,14 +1010,16 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_smaps_operations = {
 	.open		= pid_smaps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
 
 const struct file_operations proc_pid_smaps_rollup_operations = {
 	.open		= smaps_rollup_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= smaps_rollup_release,
 };
@@ -1947,7 +1950,8 @@ static int pid_numa_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_numa_maps_operations = {
 	.open		= pid_numa_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..d17f929ad8a7 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -295,7 +295,8 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= map_release,
 };
-- 
2.31.1

