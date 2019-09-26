Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48703BEA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfIZCLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:11:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35157 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:11:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so748340wmi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxjAHwEwDNiMy6S90d8rh9EFaxyVFbJePkiNhcl+5HA=;
        b=BcPswcjb50Br5OlfxRdtNpv1QIQkjG8k/U2/vFNClUe8uBOGIKJ3QtPK4Fm8gGfYrT
         RYcGPL6GbFACaD51AcAMXRxoFrp4y7n+m+9/7unvkbiy+XF1AY3gNw+zeOfs7hqzOLvA
         rJTPzGP+Im4WnEZEG3oHP4xfFIp24B3GNJEQ+rLHayEEtqkSrzFcBYrbRGqh76bI4wvz
         M698wm0plKVBbrLMAJIgbwV24o3Vn/COpDaf/Y4ZprHweDYIZqR2LRV0PCZYqvQsmMeF
         eZuw7fHDlA+N6TE7KSjxNx7KRUQ1k/LzM5JmZr+geHeZxmHUU8FfKQqAzKSg+XLWrKTD
         yxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxjAHwEwDNiMy6S90d8rh9EFaxyVFbJePkiNhcl+5HA=;
        b=WvWxx5h8e/FlmeTMaS12NOB9+lablxKd7ZK14cDHFYlPyU5Xs3iduKutk3LuGL3XEV
         d9ayrrYCbR/pwwoWyPb6/09/zdQ6Pi/g8L+Sd66tL8EgMZFHIUE0kYgkcWHX92iNclUa
         1KA3yVIp5jfOCj36kIglQ0A+fdxkjux9zaw8yKsyJmZqrGMIBYHCbOyjhekiV72jrZas
         tnHqAk2wnxQXZhNgSWOd+h3VxLLBB1p/Z5dn3FSDJYXTblTvGnNGRlF6a/5ArTdvYff2
         3v/Iy5aZKCF+49GO5nVDzMEngoWcYEixHCiYbxn988D3IMUv9f4sMeeJQB1OgnYwDClO
         /L+A==
X-Gm-Message-State: APjAAAXyLxOuahbC3kn5y4gfw1xI/lvKdmslwbh2NZmOMSQ3RWWdpSXg
        3bxeLE/W7L/9sF6+eGn+vGvcZkBGEGw=
X-Google-Smtp-Source: APXvYqxe6j+4b9YOfwL+Z4H9JU30CYWk5BSM9HhRP1bGflgwGLUodxRhuis21LYKPbFa+WQettV13A==
X-Received: by 2002:a05:600c:20c4:: with SMTP id y4mr720309wmm.87.1569463869811;
        Wed, 25 Sep 2019 19:11:09 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:11:08 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 05/16] zuf: zuf-core The ZTs
Date:   Thu, 26 Sep 2019 05:07:14 +0300
Message-Id: <20190926020725.19601-6-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zuf-core establishes the communication channels with the ZUS
User Mode Server.

In this patch we have the core communication mechanics.
Which is the Novelty of this project.
(See previous submitted documentation for more info)

Users will come later in the patchset

NOTE: The use of the file relay.h. defines an object "relay".
 "Relay" here is in the sense of a relay-race where runners
 pass the baton from runner to runner.
 Also here it is when thread of an Application passes execution
 to the Server thread and back.
 TODO: In future we might define a new scheduler object that
       will do the same but without passing through the scheduler
       at all but relinquishing the reminder of its time slice
       to the next thread. Maybe we can cut another 1/2 a micro
       off the latency of an IOP (By avoiding locks and atomics)

[v2 for Linux v5.3]
  lin-jump5.3: task_struct cpus_allowed => cpus_mask

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/_extern.h  |   16 +
 fs/zuf/_pr.h      |    5 +
 fs/zuf/relay.h    |  104 +++++
 fs/zuf/zuf-core.c | 1077 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/zuf/zuf.h      |   41 ++
 fs/zuf/zus_api.h  |  291 ++++++++++++
 6 files changed, 1533 insertions(+), 1 deletion(-)
 create mode 100644 fs/zuf/relay.h

diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 0e8aa52f1259..1f786fc24b85 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -27,6 +27,22 @@ void zufc_zts_fini(struct zuf_root_info *zri);
 long zufc_ioctl(struct file *filp, unsigned int cmd, ulong arg);
 int zufc_release(struct inode *inode, struct file *file);
 int zufc_mmap(struct file *file, struct vm_area_struct *vma);
+const char *zuf_op_name(enum e_zufs_operation op);
+
+int zufc_dispatch_mount(struct zuf_root_info *zri, struct zus_fs_info *zus_zfi,
+			enum e_mount_operation operation,
+			struct zufs_ioc_mount *zim);
+
+int __zufc_dispatch(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo);
+static inline
+int zufc_dispatch(struct zuf_root_info *zri, struct zufs_ioc_hdr *hdr,
+		  struct page **pages, uint nump)
+{
+	struct zuf_dispatch_op zdo;
+
+	zuf_dispatch_init(&zdo, hdr, pages, nump);
+	return __zufc_dispatch(zri, &zdo);
+}
 
 /* zuf-root.c */
 int zufr_register_fs(struct super_block *sb, struct zufs_ioc_register_fs *rfs);
diff --git a/fs/zuf/_pr.h b/fs/zuf/_pr.h
index 51924b6bd2a5..2cdb0806687b 100644
--- a/fs/zuf/_pr.h
+++ b/fs/zuf/_pr.h
@@ -34,6 +34,11 @@
 	} while (0)
 #define zuf_info(s, args ...)          pr_info("~info~ " s, ## args)
 
+#define zuf_err_dispatch(sb, s, args ...) \
+	do { if (zuf_fst(sb)->zri->state != ZUF_ROOT_SERVER_FAILED) \
+		pr_err("[%s:%d] " s, __func__, __LINE__, ## args); \
+	} while (0)
+
 #define zuf_chan_debug(c, s, args...)	pr_debug(c " [%s:%d] " s, __func__, \
 							__LINE__, ## args)
 
diff --git a/fs/zuf/relay.h b/fs/zuf/relay.h
new file mode 100644
index 000000000000..4cf642e177cd
--- /dev/null
+++ b/fs/zuf/relay.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Relay scheduler-object Header file.
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#ifndef __RELAY_H__
+#define __RELAY_H__
+
+/* ~~~~ Relay ~~~~ */
+struct relay {
+	wait_queue_head_t fss_wq;
+	bool fss_wakeup;
+	bool fss_waiting;
+
+	wait_queue_head_t app_wq;
+	bool app_wakeup;
+	bool app_waiting;
+
+	cpumask_t cpus_allowed;
+};
+
+static inline void relay_init(struct relay *relay)
+{
+	init_waitqueue_head(&relay->fss_wq);
+	init_waitqueue_head(&relay->app_wq);
+}
+
+static inline bool relay_is_app_waiting(struct relay *relay)
+{
+	return relay->app_waiting;
+}
+
+static inline void relay_app_wakeup(struct relay *relay)
+{
+	relay->app_waiting = false;
+
+	relay->app_wakeup = true;
+	wake_up(&relay->app_wq);
+}
+
+static inline int __relay_fss_wait(struct relay *relay, bool keep_locked)
+{
+	relay->fss_waiting = !keep_locked;
+	relay->fss_wakeup = false;
+	return  wait_event_interruptible(relay->fss_wq, relay->fss_wakeup);
+}
+
+static inline int relay_fss_wait(struct relay *relay)
+{
+	return __relay_fss_wait(relay, false);
+}
+
+static inline bool relay_is_fss_waiting_grab(struct relay *relay)
+{
+	if (relay->fss_waiting) {
+		relay->fss_waiting = false;
+		return true;
+	}
+	return false;
+}
+
+static inline void relay_fss_wakeup(struct relay *relay)
+{
+	relay->fss_wakeup = true;
+	wake_up(&relay->fss_wq);
+}
+
+static inline int relay_fss_wakeup_app_wait(struct relay *relay)
+{
+	relay->app_waiting = true;
+
+	relay_fss_wakeup(relay);
+
+	relay->app_wakeup = false;
+
+	return wait_event_interruptible(relay->app_wq, relay->app_wakeup);
+}
+
+static inline
+void relay_fss_wakeup_app_wait_spin(struct relay *relay, spinlock_t *spinlock)
+{
+	relay->app_waiting = true;
+
+	relay_fss_wakeup(relay);
+
+	relay->app_wakeup = false;
+	spin_unlock(spinlock);
+
+	wait_event(relay->app_wq, relay->app_wakeup);
+}
+
+static inline void relay_fss_wakeup_app_wait_cont(struct relay *relay)
+{
+	wait_event(relay->app_wq, relay->app_wakeup);
+}
+
+#endif /* ifndef __RELAY_H__ */
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index c9bb31f75bed..60f0d3ffe562 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -18,23 +18,884 @@
 #include <linux/delay.h>
 #include <linux/pfn_t.h>
 #include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <linux/kref.h>
 
 #include "zuf.h"
+#include "relay.h"
+
+enum { INITIAL_ZT_CHANNELS = 3 };
+
+struct zufc_thread {
+	struct zuf_special_file hdr;
+	struct relay relay;
+	struct vm_area_struct *vma;
+	int no;
+	int chan;
+
+	/* Kernel side allocated IOCTL buffer */
+	struct vm_area_struct *opt_buff_vma;
+	void *opt_buff;
+	ulong max_zt_command;
+
+	/* Next operation*/
+	struct zuf_dispatch_op *zdo;
+};
+
+struct zuf_threads_pool {
+	struct __mount_thread_info {
+		struct zuf_special_file zsf;
+		spinlock_t lock;
+		struct relay relay;
+		struct zufs_ioc_mount *zim;
+	} mount;
+
+	uint _max_zts;
+	uint _max_channels;
+	 /* array of pcp_arrays */
+	struct zufc_thread *_all_zt[ZUFS_MAX_ZT_CHANNELS];
+};
+
+/* ~~~~ some helpers ~~~~ */
+const char *zuf_op_name(enum e_zufs_operation op)
+{
+#define CASE_ENUM_NAME(e) case e: return #e
+	switch  (op) {
+		CASE_ENUM_NAME(ZUFS_OP_NULL);
+		CASE_ENUM_NAME(ZUFS_OP_BREAK);
+	case ZUFS_OP_MAX_OPT:
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static inline ulong _zt_pr_no(struct zufc_thread *zt)
+{
+	/* So in hex it will be channel as first nibble and cpu as 3rd and on */
+	return ((ulong)zt->no << 8) | zt->chan;
+}
+
+static struct zufc_thread *_zt_from_cpu(struct zuf_root_info *zri,
+					int cpu, uint chan)
+{
+	return per_cpu_ptr(zri->_ztp->_all_zt[chan], cpu);
+}
+
+static struct zufc_thread *_zt_from_f_private(struct file *file)
+{
+	struct zuf_special_file *zsf = file->private_data;
+
+	WARN_ON(zsf->type != zlfs_e_zt);
+	return container_of(zsf, struct zufc_thread, hdr);
+}
+
+/* ~~~~ init/ fini ~~~~ */
+static int _alloc_zts_channel(struct zuf_root_info *zri, int channel)
+{
+	zri->_ztp->_all_zt[channel] = alloc_percpu_gfp(struct zufc_thread,
+						       GFP_KERNEL | __GFP_ZERO);
+	if (unlikely(!zri->_ztp->_all_zt[channel])) {
+		zuf_err("!!! alloc_percpu channel=%d failed\n", channel);
+		return -ENOMEM;
+	}
+	return 0;
+}
 
 int zufc_zts_init(struct zuf_root_info *zri)
 {
+	int c;
+
+	zri->_ztp = kcalloc(1, sizeof(struct zuf_threads_pool), GFP_KERNEL);
+	if (unlikely(!zri->_ztp))
+		return -ENOMEM;
+
+	spin_lock_init(&zri->_ztp->mount.lock);
+	relay_init(&zri->_ztp->mount.relay);
+
+	zri->_ztp->_max_zts = num_possible_cpus();
+	zri->_ztp->_max_channels = INITIAL_ZT_CHANNELS;
+
+	for (c = 0; c < INITIAL_ZT_CHANNELS; ++c) {
+		int err = _alloc_zts_channel(zri, c);
+
+		if (unlikely(err))
+			return err;
+	}
+
 	return 0;
 }
 
 void zufc_zts_fini(struct zuf_root_info *zri)
 {
+	int c;
+
+	/* Always safe/must call zufc_zts_fini */
+	if (!zri->_ztp)
+		return;
+
+	for (c = 0; c < zri->_ztp->_max_channels; ++c) {
+		if (zri->_ztp->_all_zt[c])
+			free_percpu(zri->_ztp->_all_zt[c]);
+	}
+	kfree(zri->_ztp);
+	zri->_ztp = NULL;
+}
+
+/* ~~~~ mounting ~~~~*/
+int __zufc_dispatch_mount(struct zuf_root_info *zri,
+			  enum e_mount_operation operation,
+			  struct zufs_ioc_mount *zim)
+{
+	struct __mount_thread_info *zmt = &zri->_ztp->mount;
+
+	zim->hdr.operation = operation;
+	for (;;) {
+		bool fss_waiting;
+
+		spin_lock(&zmt->lock);
+
+		if (unlikely(!zmt->zsf.file)) {
+			spin_unlock(&zmt->lock);
+			zuf_err("Server not up\n");
+			zim->hdr.err = -EIO;
+			return zim->hdr.err;
+		}
+
+		fss_waiting = relay_is_fss_waiting_grab(&zmt->relay);
+		if (fss_waiting)
+			break;
+		/* in case of break above spin_unlock is done inside
+		 * relay_fss_wakeup_app_wait
+		 */
+
+		spin_unlock(&zmt->lock);
+
+		/* It is OK to wait if user storms mounts */
+		zuf_dbg_verbose("waiting\n");
+		msleep(100);
+	}
+
+	zmt->zim = zim;
+	relay_fss_wakeup_app_wait_spin(&zmt->relay, &zmt->lock);
+
+	if (zim->hdr.err > 0) {
+		zuf_err("[%s] Bad Server RC not negative => %d\n",
+			zuf_op_name(zim->hdr.operation), zim->hdr.err);
+		zim->hdr.err = -EBADRQC;
+	}
+	return zim->hdr.err;
+}
+
+int zufc_dispatch_mount(struct zuf_root_info *zri, struct zus_fs_info *zus_zfi,
+			enum e_mount_operation operation,
+			struct zufs_ioc_mount *zim)
+{
+	zim->hdr.out_len = sizeof(*zim);
+	zim->hdr.in_len = sizeof(*zim);
+	if (operation == ZUFS_M_MOUNT || operation == ZUFS_M_REMOUNT)
+		zim->hdr.in_len += zim->zmi.po.mount_options_len;
+	zim->zmi.zus_zfi = zus_zfi;
+	zim->zmi.num_cpu = zri->_ztp->_max_zts;
+	zim->zmi.num_channels = zri->_ztp->_max_channels;
+
+	return __zufc_dispatch_mount(zri, operation, zim);
+}
+
+static int _zu_mount(struct file *file, void *parg)
+{
+	struct super_block *sb = file->f_inode->i_sb;
+	struct zuf_root_info *zri = ZRI(sb);
+	struct __mount_thread_info *zmt = &zri->_ztp->mount;
+	bool waiting_for_reply;
+	struct zufs_ioc_mount *zim;
+	ulong cp_ret;
+	int err;
+
+	spin_lock(&zmt->lock);
+
+	if (unlikely(!file->private_data)) {
+		/* First time register this file as the mount-thread owner */
+		zmt->zsf.type = zlfs_e_mout_thread;
+		zmt->zsf.file = file;
+		file->private_data = &zmt->zsf;
+		zri->state = ZUF_ROOT_MOUNT_READY;
+	} else if (unlikely(file->private_data != zmt)) {
+		spin_unlock(&zmt->lock);
+		zuf_err("Say what?? %p != %p\n",
+			file->private_data, zmt);
+		return -EIO;
+	}
+
+	zim = zmt->zim;
+	zmt->zim = NULL;
+	waiting_for_reply = zim && relay_is_app_waiting(&zmt->relay);
+
+	spin_unlock(&zmt->lock);
+
+	if (waiting_for_reply) {
+		cp_ret = copy_from_user(zim, parg, zim->hdr.out_len);
+		if (unlikely(cp_ret)) {
+			zuf_err("copy_from_user => %ld\n", cp_ret);
+			 zim->hdr.err = -EFAULT;
+		}
+
+		relay_app_wakeup(&zmt->relay);
+	}
+
+	/* This gets to sleep until a mount comes */
+	err = relay_fss_wait(&zmt->relay);
+	if (unlikely(err || !zmt->zim)) {
+		struct zufs_ioc_hdr *hdr = parg;
+
+		/* Released by _zu_break INTER or crash */
+		zuf_dbg_zus("_zu_break? %p => %d\n", zmt->zim, err);
+		put_user(ZUFS_OP_BREAK, &hdr->operation);
+		put_user(EIO, &hdr->err);
+		return err;
+	}
+
+	zim = zmt->zim;
+	cp_ret = copy_to_user(parg, zim, zim->hdr.in_len);
+	if (unlikely(cp_ret)) {
+		err = -EFAULT;
+		zuf_err("copy_to_user =>%ld\n", cp_ret);
+	}
+	return err;
+}
+
+static void zufc_mounter_release(struct file *file)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	struct __mount_thread_info *zmt = &zri->_ztp->mount;
+
+	zuf_dbg_zus("closed fu=%d au=%d fw=%d aw=%d\n",
+		  zmt->relay.fss_wakeup, zmt->relay.app_wakeup,
+		  zmt->relay.fss_waiting, zmt->relay.app_waiting);
+
+	spin_lock(&zmt->lock);
+	zmt->zsf.file = NULL;
+	if (relay_is_app_waiting(&zmt->relay)) {
+		zri->state = ZUF_ROOT_SERVER_FAILED;
+		zuf_err("server emergency exit while IO\n");
+		if (zmt->zim)
+			zmt->zim->hdr.err = -EIO;
+		spin_unlock(&zmt->lock);
+
+		relay_app_wakeup(&zmt->relay);
+		msleep(1000); /* crap */
+	} else {
+		if (zmt->zim)
+			zmt->zim->hdr.err = 0;
+		spin_unlock(&zmt->lock);
+	}
+}
+
+/* ~~~~ ZU_IOC_NUMA_MAP ~~~~ */
+static int _zu_numa_map(struct file *file, void *parg)
+{
+	struct zufs_ioc_numa_map *numa_map;
+	int n_nodes = num_possible_nodes();
+	uint *nodes_cpu_count;
+	uint max_cpu_per_node = 0;
+	uint alloc_size;
+	int cpu, i, err;
+
+	alloc_size = sizeof(*numa_map) +
+			(n_nodes * sizeof(numa_map->cpu_set_per_node[0]));
+
+	if ((n_nodes > 255) || (alloc_size > PAGE_SIZE)) {
+		zuf_warn("!!!unexpected big machine with %d nodes alloc_size=0x%x\n",
+			  n_nodes, alloc_size);
+		return -ENOTSUPP;
+	}
+
+	nodes_cpu_count = kcalloc(n_nodes, sizeof(uint), GFP_KERNEL);
+	if (unlikely(!nodes_cpu_count))
+		return -ENOMEM;
+
+	numa_map = kzalloc(alloc_size, GFP_KERNEL);
+	if (unlikely(!numa_map)) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	numa_map->possible_nodes	= num_possible_nodes();
+	numa_map->possible_cpus		= num_possible_cpus();
+
+	numa_map->online_nodes		= num_online_nodes();
+	numa_map->online_cpus		= num_online_cpus();
+
+	for_each_online_cpu(cpu)
+		set_bit(cpu, numa_map->cpu_set_per_node[cpu_to_node(cpu)].bits);
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		uint ctn  = cpu_to_node(cpu);
+		uint ncc = ++nodes_cpu_count[ctn];
+
+		max_cpu_per_node = max(max_cpu_per_node, ncc);
+	}
+
+	for (i = 1; i < n_nodes; ++i) {
+		if (nodes_cpu_count[i] &&
+		    (nodes_cpu_count[i] != nodes_cpu_count[0])) {
+			zuf_info("@[%d]=%d Unbalanced CPU sockets @[0]=%d\n",
+				  i, nodes_cpu_count[i], nodes_cpu_count[0]);
+			numa_map->nodes_not_symmetrical = true;
+			break;
+		}
+	}
+
+	numa_map->max_cpu_per_node = max_cpu_per_node;
+
+	zuf_dbg_verbose(
+		"possible_nodes=%d possible_cpus=%d online_nodes=%d online_cpus=%d\n",
+		numa_map->possible_nodes, numa_map->possible_cpus,
+		numa_map->online_nodes, numa_map->online_cpus);
+
+	err = copy_to_user(parg, numa_map, alloc_size);
+	kfree(numa_map);
+out:
+	kfree(nodes_cpu_count);
+	return err;
+}
+
+static void _prep_header_size_op(struct zufs_ioc_hdr *hdr,
+				 enum e_zufs_operation op, int err)
+{
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->operation = op;
+	hdr->in_len = sizeof(*hdr);
+	hdr->err = err;
+}
+
+/* ~~~~~ ZT thread operations ~~~~~ */
+
+static int _zu_init(struct file *file, void *parg)
+{
+	struct zufc_thread *zt;
+	int cpu = smp_processor_id();
+	struct zufs_ioc_init zi_init;
+	int err;
+
+	err = copy_from_user(&zi_init, parg, sizeof(zi_init));
+	if (unlikely(err)) {
+		zuf_err("=>%d\n", err);
+		return err;
+	}
+	if (unlikely(zi_init.channel_no >= ZUFS_MAX_ZT_CHANNELS)) {
+		zuf_err("[%d] channel_no=%d\n", cpu, zi_init.channel_no);
+		return -EINVAL;
+	}
+
+	zuf_dbg_zus("[%d] channel=%d\n", cpu, zi_init.channel_no);
+
+	zt = _zt_from_cpu(ZRI(file->f_inode->i_sb), cpu, zi_init.channel_no);
+	if (unlikely(!zt)) {
+		zi_init.hdr.err = -ERANGE;
+		zuf_err("_zt_from_cpu(%d, %d) => %d\n",
+			cpu, zi_init.channel_no, err);
+		goto out;
+	}
+
+	if (unlikely(zt->hdr.file)) {
+		zi_init.hdr.err = -EINVAL;
+		zuf_err("[%d] !!! thread already set\n", cpu);
+		goto out;
+	}
+
+	relay_init(&zt->relay);
+	zt->hdr.type = zlfs_e_zt;
+	zt->hdr.file = file;
+	zt->no = cpu;
+	zt->chan = zi_init.channel_no;
+
+	zt->max_zt_command = zi_init.max_command;
+	zt->opt_buff = vmalloc(zi_init.max_command);
+	if (unlikely(!zt->opt_buff)) {
+		zi_init.hdr.err = -ENOMEM;
+		goto out;
+	}
+
+	file->private_data = &zt->hdr;
+out:
+	err = copy_to_user(parg, &zi_init, sizeof(zi_init));
+	if (err)
+		zuf_err("=>%d\n", err);
+	return err;
+}
+
+/* Caller checks that file->private_data != NULL */
+static void zufc_zt_release(struct file *file)
+{
+	struct zuf_root_info *zri = ZRI(file->f_inode->i_sb);
+	struct zufc_thread *zt = _zt_from_f_private(file);
+
+	if (unlikely(zt->hdr.file != file))
+		zuf_err("What happened zt->file(%p) != file(%p)\n",
+			zt->hdr.file, file);
+
+	zuf_dbg_zus("[%d] closed fu=%d au=%d fw=%d aw=%d\n",
+		  zt->no, zt->relay.fss_wakeup, zt->relay.app_wakeup,
+		  zt->relay.fss_waiting, zt->relay.app_waiting);
+
+	if (relay_is_app_waiting(&zt->relay)) {
+		zuf_err("server emergency exit while IO\n");
+
+		/* NOTE: Do not call _unmap_pages the vma is gone */
+		zt->hdr.file = NULL;
+
+		zri->state = ZUF_ROOT_SERVER_FAILED;
+
+		relay_app_wakeup(&zt->relay);
+		msleep(1000); /* crap */
+	}
+
+	vfree(zt->opt_buff);
+	memset(zt, 0, sizeof(*zt));
+}
+
+static int _map_pages(struct zufc_thread *zt, struct page **pages, uint nump,
+		      bool map_readonly)
+{
+	int p, err;
+
+	if (!(zt->vma && pages && nump))
+		return 0;
+
+	for (p = 0; p < nump; ++p) {
+		ulong zt_addr = zt->vma->vm_start + p * PAGE_SIZE;
+		ulong pfn = page_to_pfn(pages[p]);
+		pfn_t pfnt = phys_to_pfn_t(PFN_PHYS(pfn), PFN_MAP | PFN_DEV);
+		vm_fault_t flt;
+
+		if (map_readonly)
+			flt = vmf_insert_mixed(zt->vma, zt_addr, pfnt);
+		else
+			flt = vmf_insert_mixed_mkwrite(zt->vma, zt_addr, pfnt);
+		err = zuf_flt_to_err(flt);
+		if (unlikely(err)) {
+			zuf_err("zuf: remap_pfn_range => %d p=0x%x start=0x%lx\n",
+				 err, p, zt->vma->vm_start);
+			return err;
+		}
+	}
+	return 0;
+}
+
+static void _unmap_pages(struct zufc_thread *zt, struct page **pages, uint nump)
+{
+	if (!(zt->vma && zt->zdo && pages && nump))
+		return;
+
+	zt->zdo->pages = NULL;
+	zt->zdo->nump = 0;
+
+	zap_vma_ptes(zt->vma, zt->vma->vm_start, nump * PAGE_SIZE);
+}
+
+static int _copy_outputs(struct zufc_thread *zt, void *arg)
+{
+	struct zufs_ioc_hdr *hdr = zt->zdo->hdr;
+	struct zufs_ioc_hdr *user_hdr = zt->opt_buff;
+
+	if (zt->opt_buff_vma->vm_start != (ulong)arg) {
+		zuf_err("malicious Server\n");
+		return -EINVAL;
+	}
+
+	/* Update on the user out_len and return-code */
+	hdr->err = user_hdr->err;
+	hdr->out_len = user_hdr->out_len;
+
+	if (!hdr->out_len)
+		return 0;
+
+	if ((hdr->err == -EZUFS_RETRY && zt->zdo->oh) ||
+	    (hdr->out_max < hdr->out_len)) {
+		if (WARN_ON(!zt->zdo->oh)) {
+			zuf_err("Trouble op(%s) out_max=%d out_len=%d\n",
+				zuf_op_name(hdr->operation),
+				hdr->out_max, hdr->out_len);
+			return -EFAULT;
+		}
+		zuf_dbg_zus("[%s] %d %d => %d\n",
+			    zuf_op_name(hdr->operation),
+			    hdr->out_max, hdr->out_len, hdr->err);
+		return zt->zdo->oh(zt->zdo, zt->opt_buff, zt->max_zt_command);
+	} else {
+		void *rply = (void *)hdr + hdr->out_start;
+		void *from = zt->opt_buff + hdr->out_start;
+
+		memcpy(rply, from, hdr->out_len);
+		return 0;
+	}
+}
+
+static int _zu_wait(struct file *file, void *parg)
+{
+	struct zufc_thread *zt;
+	bool __chan_is_locked = false;
+	int err;
+
+	zt = _zt_from_f_private(file);
+	if (unlikely(!zt)) {
+		zuf_err("Unexpected ZT state\n");
+		err = -ERANGE;
+		goto err;
+	}
+
+	if (!zt->hdr.file || file != zt->hdr.file) {
+		zuf_err("fatal\n");
+		err = -E2BIG;
+		goto err;
+	}
+	if (unlikely((ulong)parg != zt->opt_buff_vma->vm_start)) {
+		zuf_err("fatal 2\n");
+		err = -EINVAL;
+		goto err;
+	}
+
+	if (relay_is_app_waiting(&zt->relay)) {
+		if (unlikely(!zt->zdo)) {
+			zuf_err("User has gone...\n");
+			err = -E2BIG;
+			goto err;
+		}
+
+		/* overflow_handler might decide to execute the parg here at
+		 * zus context and return to server.
+		 * If it also has an error to report to zus it will set
+		 * zdo->hdr->err. EZUS_RETRY_DONE is when that happens.
+		 * In this case pages stay mapped in zt->vma.
+		 */
+		err = _copy_outputs(zt, parg);
+		if (err == EZUF_RETRY_DONE) {
+			put_user(zt->zdo->hdr->err, (int *)parg);
+			return 0;
+		}
+
+		_unmap_pages(zt, zt->zdo->pages, zt->zdo->nump);
+
+		zt->zdo = NULL;
+		if (unlikely(err)) /* _copy_outputs returned an err */
+			goto err;
+
+		relay_app_wakeup(&zt->relay);
+	}
+
+	err = __relay_fss_wait(&zt->relay, __chan_is_locked);
+	if (err)
+		zuf_dbg_err("[%d] relay error: %d\n", zt->no, err);
+
+	if (zt->zdo &&  zt->zdo->hdr &&
+	    zt->zdo->hdr->operation != ZUFS_OP_BREAK &&
+	    zt->zdo->hdr->operation < ZUFS_OP_MAX_OPT) {
+		/* call map here at the zuf thread so we need no locks
+		 * TODO: Currently only ZUFS_OP_WRITE protects user-buffers
+		 * we should have a bit set in zt->zdo->hdr set per operation.
+		 * TODO: Why this does not work?
+		 */
+		_map_pages(zt, zt->zdo->pages, zt->zdo->nump, 0);
+	} else {
+		/* This Means we were released by _zu_break */
+		zuf_dbg_zus("_zu_break? => %d\n", err);
+		_prep_header_size_op(zt->opt_buff, ZUFS_OP_BREAK, err);
+	}
+
+	return err;
+
+err:
+	put_user(err, (int *)parg);
+	return err;
+}
+
+static int _try_grab_zt_channel(struct zuf_root_info *zri, int cpu,
+				 struct zufc_thread **ztp)
+{
+	struct zufc_thread *zt;
+	int c;
+
+	for (c = 0; ; ++c) {
+		zt = _zt_from_cpu(zri, cpu, c);
+		if (unlikely(!zt || !zt->hdr.file))
+			break;
+
+		if (relay_is_fss_waiting_grab(&zt->relay)) {
+			*ztp = zt;
+			return true;
+		}
+	}
+
+	*ztp = _zt_from_cpu(zri, cpu, 0);
+	return false;
+}
+
+#ifdef CONFIG_ZUF_DEBUG
+#define DEBUG_CPU_SWITCH(cpu)		\
+	do {					\
+		int cpu2 = smp_processor_id();	\
+		if (cpu2 != cpu)		\
+			zuf_warn("App switched cpu1=%u cpu2=%u\n", \
+				 cpu, cpu2);	\
+	} while (0)
+
+static
+int _r_zufs_dispatch(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo)
+
+#else /* !CONFIG_ZUF_DEBUG */
+#define DEBUG_CPU_SWITCH(cpu)
+
+int __zufc_dispatch(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo)
+#endif /* CONFIG_ZUF_DEBUG */
+{
+	struct task_struct *app = get_current();
+	struct zufs_ioc_hdr *hdr = zdo->hdr;
+	int cpu;
+	struct zufc_thread *zt;
+
+	if (unlikely(zri->state == ZUF_ROOT_SERVER_FAILED))
+		return -EIO;
+
+	if (unlikely(hdr->out_len && !hdr->out_max)) {
+		/* TODO: Complain here and let caller code do this proper */
+		hdr->out_max = hdr->out_len;
+	}
+
+	if (unlikely(zdo->__locked_zt)) {
+		zt = zdo->__locked_zt;
+		zdo->__locked_zt = NULL;
+
+		cpu = get_cpu();
+		/* FIXME: Very Pedantic need it stay */
+		if (unlikely((zt->zdo != zdo) || cpu != zt->no)) {
+			zuf_warn("[%ld] __locked_zt but zdo(%p != %p) || cpu(%d != %d)\n",
+				 _zt_pr_no(zt), zt->zdo, zdo, cpu, zt->no);
+			put_cpu();
+			goto channel_busy;
+		}
+		goto has_channel;
+	}
+channel_busy:
+	cpu = get_cpu();
+
+	if (!_try_grab_zt_channel(zri, cpu, &zt)) {
+		put_cpu();
+
+		/* If channel was grabbed then maybe a break_all is in progress
+		 * on a different CPU make sure zt->file on this core is
+		 * updated
+		 */
+		mb();
+		if (unlikely(!zt->hdr.file)) {
+			zuf_err("[%d] !zt->file\n", cpu);
+			return -EIO;
+		}
+		zuf_dbg_err("[%d] can this be\n", cpu);
+		/* FIXME: Do something much smarter */
+		msleep(10);
+		if (signal_pending(get_current())) {
+			zuf_dbg_err("[%d] => EINTR\n", cpu);
+			return -EINTR;
+		}
+		goto channel_busy;
+	}
+
+	/* lock app to this cpu while waiting */
+	cpumask_copy(&zt->relay.cpus_allowed, &app->cpus_mask);
+	cpumask_copy(&app->cpus_mask,  cpumask_of(smp_processor_id()));
+
+	zt->zdo = zdo;
+
+has_channel:
+	if (zdo->dh)
+		zdo->dh(zdo, zt, zt->opt_buff);
+	else
+		memcpy(zt->opt_buff, zt->zdo->hdr, zt->zdo->hdr->in_len);
+
+	put_cpu();
+
+	if (relay_fss_wakeup_app_wait(&zt->relay) == -ERESTARTSYS) {
+		struct zufs_ioc_hdr *opt_hdr = zt->opt_buff;
+
+		opt_hdr->flags |= ZUFS_H_INTR;
+
+		relay_fss_wakeup_app_wait_cont(&zt->relay);
+	}
+
+	/* __locked_zt must be kept on same cpu */
+	if (!zdo->__locked_zt)
+		/* restore cpu affinity after wakeup */
+		cpumask_copy(&app->cpus_mask, &zt->relay.cpus_allowed);
+
+	DEBUG_CPU_SWITCH(cpu);
+
+	return zt->hdr.file ? hdr->err : -EIO;
+}
+
+#ifdef CONFIG_ZUF_DEBUG
+#define MAX_ZT_SEC 7
+int __zufc_dispatch(struct zuf_root_info *zri, struct zuf_dispatch_op *zdo)
+{
+	u64 t1, t2;
+	int err;
+
+	t1 = ktime_get_ns();
+	err = _r_zufs_dispatch(zri, zdo);
+	t2 = ktime_get_ns();
+
+	if ((t2 - t1) > MAX_ZT_SEC * NSEC_PER_SEC)
+		zuf_err("zufc_dispatch(%s, [0x%x-0x%x]) took %lld sec\n",
+			zuf_op_name(zdo->hdr->operation), zdo->hdr->offset,
+			zdo->hdr->len,
+			(t2 - t1) / NSEC_PER_SEC);
+
+	return err;
+}
+#endif /* def CONFIG_ZUF_DEBUG */
+
+/* ~~~ iomap_exec && exec_buffer allocation ~~~ */
+
+struct zu_exec_buff {
+	struct zuf_special_file hdr;
+	struct vm_area_struct *vma;
+	void *opt_buff;
+	ulong alloc_size;
+};
+
+/* Do some common checks and conversions */
+static inline struct zu_exec_buff *_ebuff_from_file(struct file *file)
+{
+	struct zu_exec_buff *ebuff = file->private_data;
+
+	if (WARN_ON_ONCE(ebuff->hdr.type != zlfs_e_dpp_buff)) {
+		zuf_err("Must call ZU_IOC_ALLOC_BUFFER first\n");
+		return NULL;
+	}
+
+	if (WARN_ON_ONCE(ebuff->hdr.file != file))
+		return NULL;
+
+	return ebuff;
+}
+
+static int _zu_ebuff_alloc(struct file *file, void *arg)
+{
+	struct zufs_ioc_alloc_buffer ioc_alloc;
+	struct zu_exec_buff *ebuff;
+	int err;
+
+	err = copy_from_user(&ioc_alloc, arg, sizeof(ioc_alloc));
+	if (unlikely(err)) {
+		zuf_err("=>%d\n", err);
+		return err;
+	}
+
+	if (ioc_alloc.init_size > ioc_alloc.max_size)
+		return -EINVAL;
+
+	/* TODO: Easily Support growing */
+	/* TODO: Support global pools, also easy */
+	if (ioc_alloc.pool_no || ioc_alloc.init_size != ioc_alloc.max_size)
+		return -ENOTSUPP;
+
+	ebuff = kzalloc(sizeof(*ebuff), GFP_KERNEL);
+	if (unlikely(!ebuff))
+		return -ENOMEM;
+
+	ebuff->hdr.type = zlfs_e_dpp_buff;
+	ebuff->hdr.file = file;
+	i_size_write(file->f_inode, ioc_alloc.max_size);
+	ebuff->alloc_size =  ioc_alloc.init_size;
+	ebuff->opt_buff = vmalloc(ioc_alloc.init_size);
+	if (unlikely(!ebuff->opt_buff)) {
+		kfree(ebuff);
+		return -ENOMEM;
+	}
+
+	file->private_data = &ebuff->hdr;
+	return 0;
+}
+
+static void zufc_ebuff_release(struct file *file)
+{
+	struct zu_exec_buff *ebuff = _ebuff_from_file(file);
+
+	if (unlikely(!ebuff))
+		return;
+
+	vfree(ebuff->opt_buff);
+	ebuff->hdr.type = 0;
+	ebuff->hdr.file = NULL; /* for none-dbg Kernels && use-after-free */
+	kfree(ebuff);
+}
+
+/* ~~~~ ioctl & release handlers ~~~~ */
+static int _zu_register_fs(struct file *file, void *parg)
+{
+	struct zufs_ioc_register_fs rfs;
+	int err;
+
+	err = copy_from_user(&rfs, parg, sizeof(rfs));
+	if (unlikely(err)) {
+		zuf_err("=>%d\n", err);
+		return err;
+	}
+
+	err = zufr_register_fs(file->f_inode->i_sb, &rfs);
+	if (err)
+		zuf_err("=>%d\n", err);
+	err = put_user(err, (int *)parg);
+	return err;
+}
+
+static int _zu_break(struct file *filp, void *parg)
+{
+	struct zuf_root_info *zri = ZRI(filp->f_inode->i_sb);
+	int i, c;
+
+	zuf_dbg_core("enter\n");
+	mb(); /* TODO how to schedule on all CPU's */
+
+	for (i = 0; i < zri->_ztp->_max_zts; ++i) {
+		if (unlikely(!cpu_active(i)))
+			continue;
+		for (c = 0; c < zri->_ztp->_max_channels; ++c) {
+			struct zufc_thread *zt = _zt_from_cpu(zri, i, c);
+
+			if (unlikely(!(zt && zt->hdr.file)))
+				continue;
+			relay_fss_wakeup(&zt->relay);
+		}
+	}
+
+	if (zri->_ztp->mount.zsf.file)
+		relay_fss_wakeup(&zri->_ztp->mount.relay);
+
+	zuf_dbg_core("exit\n");
+	return 0;
 }
 
 long zufc_ioctl(struct file *file, unsigned int cmd, ulong arg)
 {
+	void __user *parg = (void __user *)arg;
+
 	switch (cmd) {
+	case ZU_IOC_REGISTER_FS:
+		return _zu_register_fs(file, parg);
+	case ZU_IOC_MOUNT:
+		return _zu_mount(file, parg);
+	case ZU_IOC_NUMA_MAP:
+		return _zu_numa_map(file, parg);
+	case ZU_IOC_INIT_THREAD:
+		return _zu_init(file, parg);
+	case ZU_IOC_WAIT_OPT:
+		return _zu_wait(file, parg);
+	case ZU_IOC_ALLOC_BUFFER:
+		return _zu_ebuff_alloc(file, parg);
+	case ZU_IOC_BREAK_ALL:
+		return _zu_break(file, parg);
 	default:
-		zuf_err("%d\n", cmd);
+		zuf_err("%d %ld\n", cmd, ZU_IOC_WAIT_OPT);
 		return -ENOTTY;
 	}
 }
@@ -47,11 +908,221 @@ int zufc_release(struct inode *inode, struct file *file)
 		return 0;
 
 	switch (zsf->type) {
+	case zlfs_e_zt:
+		zufc_zt_release(file);
+		return 0;
+	case zlfs_e_mout_thread:
+		zufc_mounter_release(file);
+		return 0;
+	case zlfs_e_pmem:
+		/* NOTHING to clean for pmem file yet */
+		/* zuf_pmem_release(file);*/
+		return 0;
+	case zlfs_e_dpp_buff:
+		zufc_ebuff_release(file);
+		return 0;
 	default:
 		return 0;
 	}
 }
 
+/* ~~~~  mmap area of app buffers into server ~~~~ */
+
+static vm_fault_t zuf_zt_fault(struct vm_fault *vmf)
+{
+	zuf_err("should not fault pgoff=0x%lx\n", vmf->pgoff);
+	return VM_FAULT_SIGBUS;
+}
+
+static const struct vm_operations_struct zuf_vm_ops = {
+	.fault		= zuf_zt_fault,
+};
+
+static int _zufc_zt_mmap(struct file *file, struct vm_area_struct *vma,
+			 struct zufc_thread *zt)
+{
+	/* VM_PFNMAP for zap_vma_ptes() Careful! */
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_ops = &zuf_vm_ops;
+
+	zt->vma = vma;
+
+	zuf_dbg_core(
+		"[0x%lx] start=0x%lx end=0x%lx flags=0x%lx file-start=0x%lx\n",
+		_zt_pr_no(zt), vma->vm_start, vma->vm_end, vma->vm_flags,
+		vma->vm_pgoff);
+
+	return 0;
+}
+
+/* ~~~~  mmap the Kernel allocated IOCTL buffer per ZT ~~~~ */
+static int _opt_buff_mmap(struct vm_area_struct *vma, void *opt_buff,
+			  ulong opt_size)
+{
+	ulong offset;
+
+	if (!opt_buff)
+		return -ENOMEM;
+
+	for (offset = 0; offset < opt_size; offset += PAGE_SIZE) {
+		ulong addr = vma->vm_start + offset;
+		ulong pfn = vmalloc_to_pfn(opt_buff +  offset);
+		pfn_t pfnt = phys_to_pfn_t(PFN_PHYS(pfn), PFN_MAP | PFN_DEV);
+		int err;
+
+		zuf_dbg_verbose("[0x%lx] pfn-0x%lx addr=0x%lx buff=0x%lx\n",
+				offset, pfn, addr, (ulong)opt_buff + offset);
+
+		err = zuf_flt_to_err(vmf_insert_mixed_mkwrite(vma, addr, pfnt));
+		if (unlikely(err)) {
+			zuf_err("zuf: zuf_insert_mixed_mkwrite => %d offset=0x%lx addr=0x%lx\n",
+				 err, offset, addr);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static vm_fault_t zuf_obuff_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct zufc_thread *zt = _zt_from_f_private(vma->vm_file);
+	long offset = (vmf->pgoff << PAGE_SHIFT) - ZUS_API_MAP_MAX_SIZE;
+	int err;
+
+	zuf_dbg_core(
+		"[0x%lx] start=0x%lx end=0x%lx file-start=0x%lx offset=0x%lx\n",
+		_zt_pr_no(zt), vma->vm_start, vma->vm_end, vma->vm_pgoff,
+		offset);
+
+	/* if Server overruns its buffer crash it dead */
+	if (unlikely((offset < 0) || (zt->max_zt_command < offset))) {
+		zuf_err("[0x%lx] start=0x%lx end=0x%lx file-start=0x%lx offset=0x%lx\n",
+			_zt_pr_no(zt), vma->vm_start,
+			vma->vm_end, vma->vm_pgoff, offset);
+		return VM_FAULT_SIGBUS;
+	}
+
+	/* We never released a zus-core.c that does not fault the
+	 * first page first. I want to see if this happens
+	 */
+	if (unlikely(offset))
+		zuf_warn("Suspicious server activity\n");
+
+	/* This faults only once at very first access */
+	err = _opt_buff_mmap(vma, zt->opt_buff, zt->max_zt_command);
+	if (unlikely(err))
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct zuf_obuff_ops = {
+	.fault		= zuf_obuff_fault,
+};
+
+static int _zufc_obuff_mmap(struct file *file, struct vm_area_struct *vma,
+			    struct zufc_thread *zt)
+{
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_ops = &zuf_obuff_ops;
+
+	zt->opt_buff_vma = vma;
+
+	zuf_dbg_core(
+		"[0x%lx] start=0x%lx end=0x%lx flags=0x%lx file-start=0x%lx\n",
+		_zt_pr_no(zt), vma->vm_start, vma->vm_end, vma->vm_flags,
+		vma->vm_pgoff);
+
+	return 0;
+}
+
+/* ~~~ */
+
+static int zufc_zt_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct zufc_thread *zt = _zt_from_f_private(file);
+
+	/* We have two areas of mmap in this special file.
+	 * 0 to ZUS_API_MAP_MAX_SIZE:
+	 *	The first part where app pages are mapped
+	 *	into server per operation.
+	 * ZUS_API_MAP_MAX_SIZE of size zuf_root_info->max_zt_command
+	 *	Is where we map the per ZT ioctl-buffer, later passed
+	 *	to the zus_ioc_wait IOCTL call
+	 */
+	if (vma->vm_pgoff == ZUS_API_MAP_MAX_SIZE / PAGE_SIZE)
+		return _zufc_obuff_mmap(file, vma, zt);
+
+	/* zuf ZT API is very particular about where in its
+	 * special file we communicate
+	 */
+	if (unlikely(vma->vm_pgoff))
+		return -EINVAL;
+
+	return _zufc_zt_mmap(file, vma, zt);
+}
+
+/* ~~~~ Implementation of the ZU_IOC_ALLOC_BUFFER mmap facility ~~~~ */
+
+static vm_fault_t zuf_ebuff_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct zu_exec_buff *ebuff = _ebuff_from_file(vma->vm_file);
+	long offset = (vmf->pgoff << PAGE_SHIFT);
+	int err;
+
+	zuf_dbg_core("start=0x%lx end=0x%lx file-start=0x%lx file-off=0x%lx\n",
+		     vma->vm_start, vma->vm_end, vma->vm_pgoff, offset);
+
+	if (unlikely(!ebuff))
+		return VM_FAULT_SIGBUS;
+
+	/* if Server overruns its buffer crash it dead */
+	if (unlikely((offset < 0) || (ebuff->alloc_size < offset))) {
+		zuf_err("start=0x%lx end=0x%lx file-start=0x%lx file-off=0x%lx\n",
+			vma->vm_start, vma->vm_end, vma->vm_pgoff,
+			offset);
+		return VM_FAULT_SIGBUS;
+	}
+
+	/* We never released a zus-core.c that does not fault the
+	 * first page first. I want to see if this happens
+	 */
+	if (unlikely(offset))
+		zuf_warn("Suspicious server activity\n");
+
+	/* This faults only once at very first access */
+	err = _opt_buff_mmap(vma, ebuff->opt_buff, ebuff->alloc_size);
+	if (unlikely(err))
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct zuf_ebuff_ops = {
+	.fault		= zuf_ebuff_fault,
+};
+
+static int zufc_ebuff_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct zu_exec_buff *ebuff = _ebuff_from_file(vma->vm_file);
+
+	if (unlikely(!ebuff))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_PFNMAP;
+	vma->vm_ops = &zuf_ebuff_ops;
+
+	ebuff->vma = vma;
+
+	zuf_dbg_core("start=0x%lx end=0x%lx flags=0x%lx file-start=0x%lx\n",
+		      vma->vm_start, vma->vm_end, vma->vm_flags, vma->vm_pgoff);
+
+	return 0;
+}
+
 int zufc_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct zuf_special_file *zsf = file->private_data;
@@ -62,6 +1133,10 @@ int zufc_mmap(struct file *file, struct vm_area_struct *vma)
 	}
 
 	switch (zsf->type) {
+	case zlfs_e_zt:
+		return zufc_zt_mmap(file, vma);
+	case zlfs_e_dpp_buff:
+		return zufc_ebuff_mmap(file, vma);
 	default:
 		zuf_err("type=%d\n", zsf->type);
 		return -ENOTTY;
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index 919b84f7478f..05ec08d17d69 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -110,6 +110,47 @@ static inline struct zuf_inode_info *ZUII(struct inode *inode)
 	return container_of(inode, struct zuf_inode_info, vfs_inode);
 }
 
+struct zuf_dispatch_op;
+typedef int (*overflow_handler)(struct zuf_dispatch_op *zdo, void *parg,
+				ulong zt_max_bytes);
+typedef void (*dispatch_handler)(struct zuf_dispatch_op *zdo, void *pzt,
+				void *parg);
+struct zuf_dispatch_op {
+	struct zufs_ioc_hdr *hdr;
+	union {
+		struct page **pages;
+		ulong *bns;
+	};
+	uint nump;
+	overflow_handler oh;
+	dispatch_handler dh;
+	struct super_block *sb;
+	struct inode *inode;
+
+	/* Don't touch zuf-core only!!! */
+	struct zufc_thread *__locked_zt;
+};
+
+static inline void
+zuf_dispatch_init(struct zuf_dispatch_op *zdo, struct zufs_ioc_hdr *hdr,
+		 struct page **pages, uint nump)
+{
+	memset(zdo, 0, sizeof(*zdo));
+	zdo->hdr = hdr;
+	zdo->pages = pages; zdo->nump = nump;
+}
+
+static inline int zuf_flt_to_err(vm_fault_t flt)
+{
+	if (likely(flt == VM_FAULT_NOPAGE))
+		return 0;
+
+	if (flt == VM_FAULT_OOM)
+		return -ENOMEM;
+
+	return -EACCES;
+}
+
 /* Keep this include last thing in file */
 #include "_extern.h"
 
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index f293e03460be..6b1fbaf24222 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -93,6 +93,123 @@
 
 #endif /*  ndef __KERNEL__ */
 
+/* first available error code after include/linux/errno.h */
+#define EZUFS_RETRY	531
+
+/* The below is private to zuf Kernel only. Is not exposed to VFS nor zus
+ * (defined here to allocate the constant)
+ */
+#define EZUF_RETRY_DONE 540
+
+/* TODO: Someone forgot i_flags & i_version for STATX_ attrs should send a patch
+ * to add them
+ */
+#define ZUFS_STATX_FLAGS	0x20000000U
+#define ZUFS_STATX_VERSION	0x40000000U
+
+/*
+ * Maximal count of links to a file
+ */
+#define ZUFS_LINK_MAX          32000
+#define ZUFS_MAX_SYMLINK	PAGE_SIZE
+#define ZUFS_NAME_LEN		255
+#define ZUFS_READAHEAD_PAGES	8
+
+/* All device sizes offsets must align on 2M */
+#define ZUFS_ALLOC_MASK		(1024 * 1024 * 2 - 1)
+
+/**
+ * zufs dual port memory
+ * This is a special type of offset to either memory or persistent-memory,
+ * that is designed to be used in the interface mechanism between userspace
+ * and kernel, and can be accessed by both.
+ * 3 first bits denote a mem-pool:
+ * 0   - pmem pool
+ * 1-6 - established shared pool by a call to zufs_ioc_create_mempool (below)
+ * 7   - offset into app memory
+ */
+typedef __u64 __bitwise zu_dpp_t;
+
+static inline uint zu_dpp_t_pool(zu_dpp_t t)
+{
+	return t & 0x7;
+}
+
+static inline ulong zu_dpp_t_val(zu_dpp_t t)
+{
+	return t & ~0x7;
+}
+
+static inline zu_dpp_t zu_enc_dpp_t(ulong v, uint pool)
+{
+	return v | pool;
+}
+
+static inline ulong zu_dpp_t_bn(zu_dpp_t t)
+{
+	return t >> 3;
+}
+
+static inline zu_dpp_t zu_enc_dpp_t_bn(ulong v, uint pool)
+{
+	return zu_enc_dpp_t(v << 3, pool);
+}
+
+/*
+ * Structure of a ZUS inode.
+ * This is all the inode fields
+ */
+
+/* See VFS inode flags at fs.h. As ZUFS support flags up to the 7th bit, we
+ * use higher bits for ZUFS specific flags
+ */
+#define ZUFS_S_IMMUTABLE 04000
+
+/* zus_inode size */
+#define ZUFS_INODE_SIZE 128    /* must be power of two */
+
+struct zus_inode {
+	__le16	i_flags;	/* Inode flags */
+	__le16	i_mode;		/* File mode */
+	__le32	i_nlink;	/* Links count */
+	__le64	i_size;		/* Size of data in bytes */
+/* 16*/	struct __zi_on_disk_desc {
+		__le64	a[2];
+	}	i_on_disk;	/* FS-specific on disc placement */
+/* 32*/	__le64	i_blocks;
+	__le64	i_mtime;	/* Inode/data Modification time */
+	__le64	i_ctime;	/* Inode/data Changed time */
+	__le64	i_atime;	/* Data Access time */
+/* 64 - cache-line boundary */
+	__le64	i_ino;		/* Inode number */
+	__le32	i_uid;		/* Owner Uid */
+	__le32	i_gid;		/* Group Id */
+	__le64	i_xattr;	/* FS-specific Extended attribute block */
+	__le64	i_generation;	/* File version (for NFS) */
+/* 96*/	union NAMELESS(_I_U) {
+		__le32	i_rdev;		/* special-inode major/minor etc ...*/
+		u8	i_symlink[32];	/* if i_size < sizeof(i_symlink) */
+		__le64	i_sym_dpp;	/* Link location if long symlink */
+		struct  _zu_dir {
+			__le64	dir_root;
+			__le64  parent;
+		}	i_dir;
+	};
+	/* Total ZUFS_INODE_SIZE bytes always */
+};
+
+/* ~~~~~ ZUFS API ioctl commands ~~~~~ */
+enum {
+	ZUS_API_MAP_MAX_PAGES	= 1024,
+	ZUS_API_MAP_MAX_SIZE	= ZUS_API_MAP_MAX_PAGES * PAGE_SIZE,
+};
+
+/* These go on zufs_ioc_hdr->flags */
+enum e_zufs_hdr_flags {
+	ZUFS_H_INTR		= (1 << 0),
+	ZUFS_H_HAS_PIGY_PUT	= (1 << 1),
+};
+
 struct zufs_ioc_hdr {
 	__s32 err;	/* IN/OUT must be first */
 	__u16 in_len;	/* How much to be copied *to* zus */
@@ -129,4 +246,178 @@ struct zufs_ioc_register_fs {
 };
 #define ZU_IOC_REGISTER_FS	_IOWR('Z', 10, struct zufs_ioc_register_fs)
 
+/* A cookie from user-mode returned by mount */
+struct zus_sb_info;
+
+/* zus cookie per inode */
+struct zus_inode_info;
+
+enum ZUFS_M_FLAGS {
+	ZUFS_M_PEDANTIC		= 0x00000001,
+	ZUFS_M_EPHEMERAL	= 0x00000002,
+	ZUFS_M_SILENT		= 0x00000004,
+	ZUFS_M_PRIVATE		= 0x00000008,
+};
+
+struct zufs_parse_options {
+	__u64 mount_flags;
+	__u32 pedantic;
+	__u32 mount_options_len;
+	char mount_options[0];
+};
+
+/* These go on  zufs_ioc_mount->hdr->operation */
+enum e_mount_operation {
+	ZUFS_M_MOUNT	= 1,
+	ZUFS_M_UMOUNT,
+	ZUFS_M_REMOUNT,
+	ZUFS_M_DDBG_RD,
+	ZUFS_M_DDBG_WR,
+};
+
+/* For zufs_mount_info->remount_flags */
+enum e_remount_flags {
+	ZUFS_REM_WAS_RO		= 0x00000001,
+	ZUFS_REM_WILL_RO	= 0x00000002,
+};
+
+/* FS specific capabilities @zufs_mount_info->fs_caps */
+enum {
+	ZUFS_FSC_ACL_ON		= 0x0001,
+	ZUFS_FSC_NIO_READS	= 0x0002,
+	ZUFS_FSC_NIO_WRITES	= 0x0004,
+};
+
+struct zufs_mount_info {
+	/* IN */
+	struct zus_fs_info *zus_zfi;
+	__u64	remount_flags;
+	__u64	sb_id;
+	__u16	num_cpu;
+	__u16	num_channels;
+	__u32	__pad;
+
+	/* OUT */
+	struct zus_sb_info *zus_sbi;
+	/* mount is also iget of root */
+	struct zus_inode_info *zus_ii;
+	zu_dpp_t _zi;
+
+	/* FS specific info */
+	__u32 fs_caps;
+	__u32 s_blocksize_bits;
+
+	/* IN - mount options, var len must be last */
+	struct zufs_parse_options po;
+};
+
+struct zufs_ddbg_info {
+	__u64 id; /* IN where to start from, OUT last ID */
+	/* IN size of buffer, OUT size of dynamic debug message */
+	__u64 len;
+	char msg[0];
+};
+
+/* mount / umount */
+struct  zufs_ioc_mount {
+	struct zufs_ioc_hdr hdr;
+	union {
+		struct zufs_mount_info zmi;
+		struct zufs_ddbg_info zdi;
+	};
+};
+#define ZU_IOC_MOUNT		_IOWR('Z', 11, struct zufs_ioc_mount)
+
+/* pmem  */
+struct zufs_cpu_set {
+	ulong bits[16];
+};
+
+struct zufs_ioc_numa_map {
+	/* Set by zus */
+	struct zufs_ioc_hdr hdr;
+
+	__u32	possible_nodes;
+	__u32	possible_cpus;
+	__u32	online_nodes;
+	__u32	online_cpus;
+
+	__u32	max_cpu_per_node;
+
+	/* This indicates that NOT all nodes have @max_cpu_per_node cpus */
+	bool	nodes_not_symmetrical;
+	__u8	__pad[19]; /* align cpu_set_per_node to next cache-line */
+
+	/* Variable size must keep last
+	 * size @possible_nodes
+	 */
+	struct zufs_cpu_set cpu_set_per_node[];
+};
+#define ZU_IOC_NUMA_MAP	_IOWR('Z', 13, struct zufs_ioc_numa_map)
+
+/* ZT init */
+enum { ZUFS_MAX_ZT_CHANNELS = 4 };
+
+struct zufs_ioc_init {
+	struct zufs_ioc_hdr hdr;
+	__u32 channel_no;
+	__u32 max_command;
+};
+#define ZU_IOC_INIT_THREAD	_IOWR('Z', 15, struct zufs_ioc_init)
+
+/* break_all (Server telling kernel to clean) */
+struct zufs_ioc_break_all {
+	struct zufs_ioc_hdr hdr;
+};
+#define ZU_IOC_BREAK_ALL	_IOWR('Z', 16, struct zufs_ioc_break_all)
+
+/* Allocate a special_file that will be a dual-port communication buffer with
+ * user mode.
+ * Server will access the buffer via the mmap of this file.
+ * Kernel will access the file via the valloc() pointer
+ *
+ * Some IOCTLs below demand use of this kind of buffer for communication
+ * TODO:
+ * pool_no is if we want to associate this buffer onto the 6 possible
+ * mem-pools per zuf_sbi. So anywhere we have a zu_dpp_t it will mean
+ * access from this pool.
+ * If pool_no is zero then it is private to only this file. In this case
+ * sb_id && zus_sbi are ignored / not needed.
+ */
+struct zufs_ioc_alloc_buffer {
+	struct zufs_ioc_hdr hdr;
+	/* The ID of the super block received in mount */
+	__u64	sb_id;
+	/* We verify the sb_id validity against zus_sbi */
+	struct zus_sb_info *zus_sbi;
+	/* max size of buffer allowed (size of mmap) */
+	__u32 max_size;
+	/* allocate this much on initial call and set into vma */
+	__u32 init_size;
+
+	/* TODO: These below are now set to ZERO. Need implementation */
+	__u16 pool_no;
+	__u16 flags;
+	__u32 reserved;
+};
+#define ZU_IOC_ALLOC_BUFFER	_IOWR('Z', 17, struct zufs_ioc_init)
+
+/* ~~~  zufs_ioc_wait_operation ~~~ */
+struct zufs_ioc_wait_operation {
+	struct zufs_ioc_hdr hdr;
+	/* maximum size is governed by zufs_ioc_init->max_command */
+	char opt_buff[];
+};
+#define ZU_IOC_WAIT_OPT		_IOWR('Z', 18, struct zufs_ioc_wait_operation)
+
+/* These are the possible operations sent from Kernel to the Server in the
+ * return of the ZU_IOC_WAIT_OPT.
+ */
+enum e_zufs_operation {
+	ZUFS_OP_NULL		= 0,
+	ZUFS_OP_BREAK		= 1,	/* Kernel telling Server to exit */
+
+	ZUFS_OP_MAX_OPT,
+};
+
 #endif /* _LINUX_ZUFS_API_H */
-- 
2.21.0

