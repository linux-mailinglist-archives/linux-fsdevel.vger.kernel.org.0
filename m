Return-Path: <linux-fsdevel+bounces-8094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685382F5A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE877287370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39F1D6A7;
	Tue, 16 Jan 2024 19:41:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642B1D6A5;
	Tue, 16 Jan 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434088; cv=none; b=GOrTPOJPDZZ7X8bSiUFVQmyAJq0z05jt1S6Uz0xeMEsg1//5mjFWXJAAyU+OUlyCXemIlXDvt6QTb2wQwrlJZyoDKbpiXkEbzmMksJl/g1OyHs1/VV7MXQVMXeDRWzqgTR6MCAlfS9gCDHpWaZgkLoGVSyotrSVePtd97ffvUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434088; c=relaxed/simple;
	bh=xoCBuoVCslr61Vw0KJiDApyhb68/DiVp6YVsyBkv690=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=d6IVExsRiUJF01Ji4v+u4JRwwpO7+3MoRBnqCGudCXsVPbpDNoyQr9WtfBI4gxPm1pvL2BitVlVnN9ZaFisIaUZWEGeUyMD1h+SKAkFbtEc4czq3xAE7/CV/I9hJck5ixTwFQCNy8s6QSliPnRKpQzmd5dFbMWpnZWHhvWe+sOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB17CC43390;
	Tue, 16 Jan 2024 19:41:26 +0000 (UTC)
Date: Tue, 16 Jan 2024 14:42:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, kernel test robot
 <oliver.sang@intel.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Create dentries and inodes at dir open
Message-ID: <20240116144241.7b7c0026@gandalf.local.home>
In-Reply-To: <CAHk-=wjZKo9-OE=9DA3rSnmSNWJSJTgFc3Yvrvm7476Cyn5xqQ@mail.gmail.com>
References: <20240116114711.7e8637be@gandalf.local.home>
	<CAHk-=wjna5QYoWE+v3BWDwvs8N=QWjNN=EgxTN4dBbmySc-jcg@mail.gmail.com>
	<20240116131228.3ed23d37@gandalf.local.home>
	<CAHk-=wji07LQSMZuqbHFRnnaKvpQugqZ_GnCsfPvg9qJGVDujA@mail.gmail.com>
	<20240116133753.2808d45e@gandalf.local.home>
	<CAHk-=wjZKo9-OE=9DA3rSnmSNWJSJTgFc3Yvrvm7476Cyn5xqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 10:53:36 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Let's at least *try* to move towards a better and simpler world, in other
> words.

OK, but I did just finish the below. I'll save it for another time if the
single inode becomes an issue.

I cropped it to just 31 bits, so I'm not sure how much that would still
expose kernel addresses.

But as you prefer a single inode number, I'll submit that instead, and
store this as one of my many git branches that I hoard.

This patch would give me:

~# ls -i /sys/kernel/tracing/events
2024739183 9p               801480813 iocost        281269778 qdisc
 401505785 alarmtimer       641794539 iomap        1206040657 ras
1930290274 avc             1239754069 iommu         275816503 raw_syscalls
1108006611 block            138722947 io_uring     1758073266 rcu
1528091656 bpf_test_run     694421747 ipi          1384703124 regmap
 557364529 bpf_trace          2765888 irq            30507018 regulator
1351362737 cfg80211         369905250 irq_matrix   2078862821 resctrl
 886445085 cgroup          1115008967 irq_vectors   324090967 rpm
 796209754 clk             1448778784 jbd2         1141318882 rseq
 478739129 compaction        99410253 kmem         1274783780 rtc
1714397712 cpuhp           2001779594 ksm          1409072807 sched
 720701943 csd               51728677 kyber         347239934 scsi
1824588347 dev             1507974437 libata       1768671172 sd
1640041299 devfreq         1421146927 lock         1167562598 signal
 121399632 dma_fence        956825721 mac80211        4116590 skb
 975908383 drm              738868061 maple_tree   1435501164 smbus
1227060804 e1000e_trace     969175760 mce          1664441095 sock
1770307058 enable          1225375766 mdio         1634697993 spi
1372107864 error_report     744198394 migrate       556841757 swiotlb
1356665351 exceptions       602669807 mmap          400337480 syscalls
[..]

~# ls -i /sys/kernel/tracing/events/sched
1906992193 enable                            1210369853 sched_process_wait
 592505447 filter                            1443020725 sched_stat_blocked
1742488280 sched_kthread_stop                1213185672 sched_stat_iowait
1674576234 sched_kthread_stop_ret            1908510325 sched_stat_runtime
1999376743 sched_kthread_work_execute_end    1570203600 sched_stat_sleep
1041533096 sched_kthread_work_execute_start   608113040 sched_stat_wait
 166824308 sched_kthread_work_queue_work     2033295833 sched_stick_numa
 492462616 sched_migrate_task                1617500395 sched_swap_numa
1786868196 sched_move_numa                   1865216679 sched_switch
 691687388 sched_pi_setprio                  1465729401 sched_wait_task
1610977146 sched_process_exec                 969941227 sched_wake_idle_without_ipi
 610128037 sched_process_exit                  84398030 sched_wakeup
2139284699 sched_process_fork                 750220489 sched_wakeup_new
 169172804 sched_process_free                1024064201 sched_waking

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a0598eb3e26e..57448bf4acb4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -19,6 +19,7 @@
 #include <linux/namei.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/siphash.h>
 #include <linux/tracefs.h>
 #include <linux/kref.h>
 #include <linux/delay.h>
@@ -32,6 +33,9 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
+/* Used for making inode numbers */
+static siphash_key_t inode_key;
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -57,6 +61,28 @@ static int eventfs_dir_open(struct inode *inode, struct file *file);
 static int eventfs_iterate(struct file *file, struct dir_context *ctx);
 static int eventfs_dir_release(struct inode *inode, struct file *file);
 
+/* Copied from scripts/kconfig/symbol.c */
+static unsigned strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned hash = 2166136261U;
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+/* Just try to make something consistent and unique */
+static int eventfs_inode_ino(struct eventfs_inode *ei, const char *name)
+{
+	unsigned long sip = (unsigned long)ei;
+
+	sip += strhash(name);
+	sip = siphash_1u32((int)sip, &inode_key);
+
+	/* keep it positive */
+	return sip & ((1U << 31) - 1);
+}
+
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
 	unsigned int ia_valid = iattr->ia_valid;
@@ -491,6 +517,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	mutex_unlock(&eventfs_mutex);
 
 	dentry = create_file(name, mode, attr, parent, data, fops);
+	if (!IS_ERR_OR_NULL(dentry))
+		dentry->d_inode->i_ino = eventfs_inode_ino(ei, name);
 
 	mutex_lock(&eventfs_mutex);
 
@@ -585,6 +613,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	mutex_unlock(&eventfs_mutex);
 
 	dentry = create_dir(ei, parent);
+	if (!IS_ERR_OR_NULL(dentry))
+		dentry->d_inode->i_ino = eventfs_inode_ino(ei, ei->name);
 
 	mutex_lock(&eventfs_mutex);
 
@@ -721,19 +751,19 @@ struct eventfs_list {
 	int			count;
 };
 
-static int update_entry(struct eventfs_dents *dents, struct dentry *d,
-		     int type, int cnt)
+static int update_entry(struct eventfs_dents *dents, struct eventfs_inode *ei,
+			const char *name, int type, int cnt)
 {
-	dents[cnt].name = kstrdup_const(d->d_name.name, GFP_KERNEL);
+	dents[cnt].name = kstrdup_const(name, GFP_KERNEL);
 	if (!dents[cnt].name)
 		return -ENOMEM;
-	dents[cnt].ino = d->d_inode->i_ino;
+	dents[cnt].ino = eventfs_inode_ino(ei, name);
 	dents[cnt].type = type;
 	return 0;
 }
 
-static int add_entry(struct eventfs_dents **edents, struct dentry *d,
-		     int type, int cnt)
+static int add_entry(struct eventfs_dents **edents, struct eventfs_inode *ei,
+		     const char *name, int type, int cnt)
 {
 	struct eventfs_dents *tmp;
 
@@ -742,7 +772,7 @@ static int add_entry(struct eventfs_dents **edents, struct dentry *d,
 		return -ENOMEM;
 	*edents = tmp;
 
-	return update_entry(tmp, d, type, cnt);
+	return update_entry(tmp, ei, name, type, cnt);
 }
 
 /*
@@ -758,8 +788,6 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
 	struct eventfs_dents *dents;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *dentry;
 	const char *name;
 	umode_t mode;
 	void *data;
@@ -780,11 +808,11 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
+	if (ei && ei->is_freed)
+		ei = NULL;
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei_dentry) {
+	if (!ei) {
 		srcu_read_unlock(&eventfs_srcu, idx);
 		return -ENOENT;
 	}
@@ -810,7 +838,6 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
-	inode_lock(ei_dentry->d_inode);
 	for (i = 0; i < ei->nr_entries; i++) {
 		void *cdata = data;
 		entry = &ei->entries[i];
@@ -830,12 +857,7 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 		/* callbacks returning zero just means skip this file */
 		if (r == 0)
 			continue;
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-		if (!dentry)
-			continue;
-
-		ret = update_entry(dents, dentry, DT_REG, cnt);
-		dput(dentry);
+		ret = update_entry(dents, ei, name, DT_REG, cnt);
 
 		if (ret < 0)
 		    goto fail;
@@ -845,12 +867,7 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
-		if (!dentry)
-			continue;
-
-		ret = add_entry(&dents, dentry, DT_DIR, cnt);
-		dput(dentry);
+		ret = add_entry(&dents, ei_child, ei_child->name, DT_DIR, cnt);
 		if (ret < 0)
 			goto fail;
 		cnt++;
@@ -859,12 +876,10 @@ static int eventfs_dir_open(struct inode *inode, struct file *file)
 	edents->count = cnt;
 	edents->dents = dents;
 
-	inode_unlock(ei_dentry->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	file->private_data = edents;
 	return 0;
  fail:
-	inode_unlock(ei_dentry->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	for (; cnt >= 0; cnt--)
 		kfree_const(dents[cnt].name);
@@ -1029,6 +1044,9 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
+	if (siphash_key_is_zero(&inode_key))
+		get_random_bytes(&inode_key, sizeof(inode_key));
+
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
 		goto fail_ei;

