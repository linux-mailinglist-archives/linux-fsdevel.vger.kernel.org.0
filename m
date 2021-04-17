Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E087362C54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhDQALF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:11:05 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38526 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbhDQALD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:11:03 -0400
Received: by mail-pg1-f176.google.com with SMTP id w10so20248371pgh.5;
        Fri, 16 Apr 2021 17:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wd4ye9DOFIIPqeVdNRtZKClX4U/qjaiSs1TpKIYCf18=;
        b=QI2dRhWlZ8+9aV2hDtGEB8n5lp6pQiLgRVChriMLXcj35zRKXbN0gGaah30/5aOf/F
         C0xzwiESWjTpjrbxN0+fgwFAcnoMWHlDS/EwkpS+C3GjJWKvlUDG1iXNZEqlkOXb/WMM
         VL1LZGauh6PoC3TdRGeS101JWkuoAA5t4Auo5LFemZDfRP2mwKxQIdY3BonNSXoQt/T2
         w3V/MGWUhYh5js/re4qRSSqqUyrj8L/2c5bTALvd2tFDBp9nZ6+xVqdlJapg/0kYbO/V
         8CMwZ0vuNXyhyrcu21IPJ4qVmFmHD/83qpqPJ/XmSK7Hz9wIExDdMugLHcqFuau85Rj6
         zC6A==
X-Gm-Message-State: AOAM531EQJw7CHQor+HoPtP9Qr03W1J41mM9Z6/Wa0wywM1WWnm+kEuS
        AyHQbkfS29EpNrzO4p8ccyg=
X-Google-Smtp-Source: ABdhPJx6lyUAD0W0zFiF6K5OiOAwN4pIsIJ0YhlcIOLbGP3mapp1zP+udeTxNFnj7luTHy0EkrLKwg==
X-Received: by 2002:a63:a62:: with SMTP id z34mr1291596pgk.189.1618618236070;
        Fri, 16 Apr 2021 17:10:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u7sm6488160pjx.8.2021.04.16.17.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5564B41D95; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and remove kthread freezing
Date:   Sat, 17 Apr 2021 00:10:26 +0000
Message-Id: <20210417001026.23858-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to automatically handle freezing and thawing filesystems
during the kernel's suspend/resume cycle.

This is needed so that we properly really stop IO in flight without
races after userspace has been frozen. Without this we rely on
kthread freezing and its semantics are loose and error prone.
For instance, even though a kthread may use try_to_freeze() and end
up being frozen we have no way of being sure that everything that
has been spawned asynchronously from it (such as timers) have also
been stopped as well.

A long term advantage of also adding filesystem freeze / thawing
supporting during suspend / hibernation is that long term we may
be able to eventually drop the kernel's thread freezing completely
as it was originally added to stop disk IO in flight as we hibernate
or suspend.

This also removes all the superflous freezer calls on all filesystems
as they are no longer needed as the VFS now performs filesystem
freezing/thaw if the filesystem has support for it. The filesystem
therefore is in charge of properly dealing with quiescing of the
filesystem through its callbacks.

This also implies that many kthread users exist which have been
adding freezer semantics onto its kthreads without need. These also
will need to be reviewed later.

This is based on prior work originally by Rafael Wysocki and later by
Jiri Kosina.

The following Coccinelle rule was used as to remove the now superflous
freezer calls:

spatch --sp-file fs-freeze-cleanup.cocci --in-place fs/

@ has_freeze_fs @
identifier super_ops;
expression freeze_op;
@@

struct super_operations super_ops = {
    .freeze_fs = freeze_op,
};

@ remove_set_freezable depends on has_freeze_fs @
expression time;
statement S, S2;
expression task, current;
@@

(
-       set_freezable();
|
-       if (try_to_freeze())
-               continue;
|
-       try_to_freeze();
|
-       freezable_schedule();
+       schedule();
|
-       freezable_schedule_timeout(time);
+       schedule_timeout(time);
|
-       if (freezing(task)) { S }
|
-       if (freezing(task)) { S }
-       else
		{ S2 }
|
-       freezing(current)
)

@ remove_wq_freezable @
expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
identifier fs_wq_fn;
@@

(
	WQ_E = alloc_workqueue(WQ_ARG1,
-			       WQ_ARG2 | WQ_FREEZABLE,
+			       WQ_ARG2,
			       ...);
|
	WQ_E = alloc_workqueue(WQ_ARG1,
-			       WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
+			       WQ_ARG2 | WQ_ARG3,
			       ...);
|
	WQ_E = alloc_workqueue(WQ_ARG1,
-			       WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
+			       WQ_ARG2 | WQ_ARG3,
			       ...);
|
	WQ_E = alloc_workqueue(WQ_ARG1,
-			       WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
+			       WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
			       ...);
|
		WQ_E =
-		WQ_ARG1 | WQ_FREEZABLE
+		WQ_ARG1
|
		WQ_E =
-		WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
+		WQ_ARG1 | WQ_ARG3
|
	fs_wq_fn(
-		WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
+		WQ_ARG2 | WQ_ARG3
	)
|
	fs_wq_fn(
-		WQ_FREEZABLE | WQ_ARG2
+		WQ_ARG2
	)
|
	fs_wq_fn(
-		WQ_FREEZABLE
+		0
	)
)

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/btrfs/disk-io.c     |  4 +-
 fs/btrfs/scrub.c       |  2 +-
 fs/cifs/cifsfs.c       | 10 ++---
 fs/cifs/dfs_cache.c    |  2 +-
 fs/ext4/super.c        |  2 -
 fs/f2fs/gc.c           |  7 +---
 fs/f2fs/segment.c      |  6 +--
 fs/gfs2/glock.c        |  6 +--
 fs/gfs2/main.c         |  4 +-
 fs/jfs/jfs_logmgr.c    | 11 ++----
 fs/jfs/jfs_txnmgr.c    | 31 +++++----------
 fs/nilfs2/segment.c    | 48 ++++++++++-------------
 fs/super.c             | 88 ++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_log.c       |  3 +-
 fs/xfs/xfs_mru_cache.c |  2 +-
 fs/xfs/xfs_pwork.c     |  2 +-
 fs/xfs/xfs_super.c     | 14 +++----
 fs/xfs/xfs_trans_ail.c |  7 +---
 include/linux/fs.h     | 13 +++++++
 kernel/power/process.c | 15 ++++++-
 20 files changed, 175 insertions(+), 102 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9fc2ec72327f..2c718f1eaae3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2303,7 +2303,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 		struct btrfs_fs_devices *fs_devices)
 {
 	u32 max_active = fs_info->thread_pool_size;
-	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker",
@@ -2355,7 +2355,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_workqueue("btrfs_discard", WQ_UNBOUND, 1);
 
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
 	      fs_info->flush_workers &&
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 17e49caad1f9..c67c7d08fb44 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3954,7 +3954,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	struct btrfs_workqueue *scrub_workers = NULL;
 	struct btrfs_workqueue *scrub_wr_comp = NULL;
 	struct btrfs_workqueue *scrub_parity = NULL;
-	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index e0c5e860a0ee..500e245037ac 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1595,7 +1595,7 @@ init_cifs(void)
 			 CIFS_MAX_REQ);
 	}
 
-	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	cifsiod_wq = alloc_workqueue("cifsiod", WQ_MEM_RECLAIM, 0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
 		goto out_clean_proc;
@@ -1609,28 +1609,28 @@ init_cifs(void)
 
 	/* WQ_UNBOUND allows decrypt tasks to run on any CPU */
 	decrypt_wq = alloc_workqueue("smb3decryptd",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!decrypt_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsiod_wq;
 	}
 
 	fileinfo_put_wq = alloc_workqueue("cifsfileinfoput",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!fileinfo_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_decrypt_wq;
 	}
 
 	cifsoplockd_wq = alloc_workqueue("cifsoplockd",
-					 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					 WQ_MEM_RECLAIM, 0);
 	if (!cifsoplockd_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_fileinfo_put_wq;
 	}
 
 	deferredclose_wq = alloc_workqueue("deferredclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_MEM_RECLAIM, 0);
 	if (!deferredclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsoplockd_wq;
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index b1fa30fefe1f..63ecde2b106d 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -285,7 +285,7 @@ int dfs_cache_init(void)
 	int i;
 
 	dfscache_wq = alloc_workqueue("cifs-dfscache",
-				      WQ_FREEZABLE | WQ_MEM_RECLAIM, 1);
+				      WQ_MEM_RECLAIM, 1);
 	if (!dfscache_wq)
 		return -ENOMEM;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 886e0d518668..a5dc6001d20e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3578,8 +3578,6 @@ static int ext4_lazyinit_thread(void *arg)
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
-		try_to_freeze();
-
 		cur = jiffies;
 		if ((time_after_eq(cur, next_wakeup)) ||
 		    (MAX_JIFFY_OFFSET == next_wakeup)) {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8d1f17ab94d8..b0ef7fc1e381 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -36,12 +36,11 @@ static int gc_thread_func(void *data)
 
 	wait_ms = gc_th->min_sleep_time;
 
-	set_freezable();
 	do {
 		bool sync_mode, foreground = false;
 
 		wait_event_interruptible_timeout(*wq,
-				kthread_should_stop() || freezing(current) ||
+				kthread_should_stop() ||
 				waitqueue_active(fggc_wq) ||
 				gc_th->gc_wake,
 				msecs_to_jiffies(wait_ms));
@@ -53,10 +52,6 @@ static int gc_thread_func(void *data)
 		if (gc_th->gc_wake)
 			gc_th->gc_wake = 0;
 
-		if (try_to_freeze()) {
-			stat_other_skip_bggc_count(sbi);
-			continue;
-		}
 		if (kthread_should_stop())
 			break;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d616ea65c466..ec4cec005520 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1750,8 +1750,6 @@ static int issue_discard_thread(void *data)
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
 
-	set_freezable();
-
 	do {
 		if (sbi->gc_mode == GC_URGENT_HIGH ||
 			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
@@ -1764,7 +1762,7 @@ static int issue_discard_thread(void *data)
 		       wait_ms = dpolicy.max_interval;
 
 		wait_event_interruptible_timeout(*q,
-				kthread_should_stop() || freezing(current) ||
+				kthread_should_stop() ||
 				dcc->discard_wake,
 				msecs_to_jiffies(wait_ms));
 
@@ -1775,8 +1773,6 @@ static int issue_discard_thread(void *data)
 		if (atomic_read(&dcc->queued_discard))
 			__wait_all_discard_cmd(sbi, NULL);
 
-		if (try_to_freeze())
-			continue;
 		if (f2fs_readonly(sbi->sb))
 			continue;
 		if (kthread_should_stop())
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ea7fc5c641c7..e323b0895d7c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2271,14 +2271,14 @@ int __init gfs2_glock_init(void)
 	if (ret < 0)
 		return ret;
 
-	glock_workqueue = alloc_workqueue("glock_workqueue", WQ_MEM_RECLAIM |
-					  WQ_HIGHPRI | WQ_FREEZABLE, 0);
+	glock_workqueue = alloc_workqueue("glock_workqueue",
+					  WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!glock_workqueue) {
 		rhashtable_destroy(&gl_hash_table);
 		return -ENOMEM;
 	}
 	gfs2_delete_workqueue = alloc_workqueue("delete_workqueue",
-						WQ_MEM_RECLAIM | WQ_FREEZABLE,
+						WQ_MEM_RECLAIM,
 						0);
 	if (!gfs2_delete_workqueue) {
 		destroy_workqueue(glock_workqueue);
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 28d0eb23e18e..b87e7443a039 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -164,12 +164,12 @@ static int __init init_gfs2_fs(void)
 
 	error = -ENOMEM;
 	gfs_recovery_wq = alloc_workqueue("gfs_recovery",
-					  WQ_MEM_RECLAIM | WQ_FREEZABLE, 0);
+					  WQ_MEM_RECLAIM, 0);
 	if (!gfs_recovery_wq)
 		goto fail_wq1;
 
 	gfs2_control_wq = alloc_workqueue("gfs2_control",
-					  WQ_UNBOUND | WQ_FREEZABLE, 0);
+					  WQ_UNBOUND, 0);
 	if (!gfs2_control_wq)
 		goto fail_wq2;
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9330eff210e0..c9f884c88680 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2331,14 +2331,9 @@ int jfsIOWait(void *arg)
 			spin_lock_irq(&log_redrive_lock);
 		}
 
-		if (freezing(current)) {
-			spin_unlock_irq(&log_redrive_lock);
-			try_to_freeze();
-		} else {
-			set_current_state(TASK_INTERRUPTIBLE);
-			spin_unlock_irq(&log_redrive_lock);
-			schedule();
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&log_redrive_lock);
+		schedule();
 	} while (!kthread_should_stop());
 
 	jfs_info("jfsIOWait being killed!");
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 053295cd7bc6..ac5b441774c4 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2730,6 +2730,7 @@ int jfs_lazycommit(void *arg)
 	struct tblock *tblk;
 	unsigned long flags;
 	struct jfs_sb_info *sbi;
+	DECLARE_WAITQUEUE(wq, current);
 
 	do {
 		LAZY_LOCK(flags);
@@ -2776,19 +2777,11 @@ int jfs_lazycommit(void *arg)
 		}
 		/* In case a wakeup came while all threads were active */
 		jfs_commit_thread_waking = 0;
-
-		if (freezing(current)) {
-			LAZY_UNLOCK(flags);
-			try_to_freeze();
-		} else {
-			DECLARE_WAITQUEUE(wq, current);
-
-			add_wait_queue(&jfs_commit_thread_wait, &wq);
-			set_current_state(TASK_INTERRUPTIBLE);
-			LAZY_UNLOCK(flags);
-			schedule();
-			remove_wait_queue(&jfs_commit_thread_wait, &wq);
-		}
+		add_wait_queue(&jfs_commit_thread_wait, &wq);
+		set_current_state(TASK_INTERRUPTIBLE);
+		LAZY_UNLOCK(flags);
+		schedule();
+		remove_wait_queue(&jfs_commit_thread_wait, &wq);
 	} while (!kthread_should_stop());
 
 	if (!list_empty(&TxAnchor.unlock_queue))
@@ -2965,15 +2958,9 @@ int jfs_sync(void *arg)
 		}
 		/* Add anon_list2 back to anon_list */
 		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
-
-		if (freezing(current)) {
-			TXN_UNLOCK();
-			try_to_freeze();
-		} else {
-			set_current_state(TASK_INTERRUPTIBLE);
-			TXN_UNLOCK();
-			schedule();
-		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		TXN_UNLOCK();
+		schedule();
 	} while (!kthread_should_stop());
 
 	jfs_info("jfs_sync being killed");
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 686c8ee7b29c..b3f30328a991 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2534,6 +2534,8 @@ static int nilfs_segctor_thread(void *arg)
 	struct nilfs_sc_info *sci = (struct nilfs_sc_info *)arg;
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int timeout = 0;
+	DEFINE_WAIT(wait);
+	int should_sleep = 1;
 
 	sci->sc_timer_task = current;
 
@@ -2565,38 +2567,28 @@ static int nilfs_segctor_thread(void *arg)
 		timeout = 0;
 	}
 
+	prepare_to_wait(&sci->sc_wait_daemon, &wait,
+			TASK_INTERRUPTIBLE);
 
-	if (freezing(current)) {
+	if (sci->sc_seq_request != sci->sc_seq_done)
+		should_sleep = 0;
+	else if (sci->sc_flush_request)
+		should_sleep = 0;
+	else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
+		should_sleep = time_before(jiffies,
+				sci->sc_timer.expires);
+
+	if (should_sleep) {
 		spin_unlock(&sci->sc_state_lock);
-		try_to_freeze();
+		schedule();
 		spin_lock(&sci->sc_state_lock);
-	} else {
-		DEFINE_WAIT(wait);
-		int should_sleep = 1;
-
-		prepare_to_wait(&sci->sc_wait_daemon, &wait,
-				TASK_INTERRUPTIBLE);
-
-		if (sci->sc_seq_request != sci->sc_seq_done)
-			should_sleep = 0;
-		else if (sci->sc_flush_request)
-			should_sleep = 0;
-		else if (sci->sc_state & NILFS_SEGCTOR_COMMIT)
-			should_sleep = time_before(jiffies,
-					sci->sc_timer.expires);
-
-		if (should_sleep) {
-			spin_unlock(&sci->sc_state_lock);
-			schedule();
-			spin_lock(&sci->sc_state_lock);
-		}
-		finish_wait(&sci->sc_wait_daemon, &wait);
-		timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
-			   time_after_eq(jiffies, sci->sc_timer.expires));
-
-		if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
-			set_nilfs_discontinued(nilfs);
 	}
+	finish_wait(&sci->sc_wait_daemon, &wait);
+	timeout = ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		   time_after_eq(jiffies, sci->sc_timer.expires));
+
+	if (nilfs_sb_dirty(nilfs) && nilfs_sb_need_update(nilfs))
+		set_nilfs_discontinued(nilfs);
 	goto loop;
 
  end_thread:
diff --git a/fs/super.c b/fs/super.c
index 2a6ef4ec2496..9f4d7fc66d18 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1890,3 +1890,91 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb, true);
 }
 EXPORT_SYMBOL(thaw_super);
+
+#ifdef CONFIG_PM_SLEEP
+static bool super_should_freeze(struct super_block *sb)
+{
+	if (!sb->s_root)
+		return false;
+	if (!(sb->s_flags & MS_BORN))
+		return false;
+	/*
+	 * We don't freeze virtual filesystems, we skip those filesystems with
+	 * no backing device.
+	 */
+	if (sb->s_bdi == &noop_backing_dev_info)
+		return false;
+
+	/* No need to freeze read-only filesystems */
+	if (sb_rdonly(sb))
+		return false;
+
+	return true;
+}
+
+static int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
+
+	spin_unlock(&sb_lock);
+
+	atomic_inc(&sb->s_active);
+	error = freeze_locked_super(sb, false);
+	if (error)
+		atomic_dec(&sb->s_active);
+	else
+		lockdep_sb_freeze_release(sb);
+
+	spin_lock(&sb_lock);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to freeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+
+out:
+	spin_unlock(&sb_lock);
+	return error;
+}
+
+int fs_suspend_freeze(void)
+{
+	return iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
+}
+
+static int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): thawing\n", sb->s_type->name, sb->s_id);
+
+	spin_unlock(&sb_lock);
+
+	error = __thaw_super_locked(sb, false);
+	if (!error)
+		atomic_dec(&sb->s_active);
+
+	spin_lock(&sb_lock);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to unfreeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+
+out:
+	spin_unlock(&sb_lock);
+	return error;
+}
+
+int fs_resume_unfreeze(void)
+{
+	return iterate_supers_excl(fs_suspend_thaw_sb, NULL);
+}
+
+#endif
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 06041834daa3..3313514a8ab7 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1492,8 +1492,7 @@ xlog_alloc_log(
 	log->l_iclog->ic_prev = prev_iclog;	/* re-write 1st prev ptr */
 
 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM |
-				    WQ_HIGHPRI),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_HIGHPRI),
 			0, mp->m_super->s_id);
 	if (!log->l_ioend_workqueue)
 		goto out_free_iclog;
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index 34c3b16f834f..892567180b53 100644
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -294,7 +294,7 @@ int
 xfs_mru_cache_init(void)
 {
 	xfs_mru_reap_wq = alloc_workqueue("xfs_mru_cache",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 1);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 1);
 	if (!xfs_mru_reap_wq)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/xfs/xfs_pwork.c b/fs/xfs/xfs_pwork.c
index c283b801cc5d..3f5bf53f8778 100644
--- a/fs/xfs/xfs_pwork.c
+++ b/fs/xfs/xfs_pwork.c
@@ -72,7 +72,7 @@ xfs_pwork_init(
 	trace_xfs_pwork_init(mp, nr_threads, current->pid);
 
 	pctl->wq = alloc_workqueue("%s-%d",
-			WQ_UNBOUND | WQ_SYSFS | WQ_FREEZABLE, nr_threads, tag,
+			WQ_UNBOUND | WQ_SYSFS, nr_threads, tag,
 			current->pid);
 	if (!pctl->wq)
 		return -ENOMEM;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a2dab05332ac..b1ba45fdbe55 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -496,37 +496,37 @@ xfs_init_mount_workqueues(
 	struct xfs_mount	*mp)
 {
 	mp->m_buf_workqueue = alloc_workqueue("xfs-buf/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			1, mp->m_super->s_id);
 	if (!mp->m_buf_workqueue)
 		goto out;
 
 	mp->m_unwritten_workqueue = alloc_workqueue("xfs-conv/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
 	mp->m_cil_workqueue = alloc_workqueue("xfs-cil/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_UNBOUND),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_UNBOUND),
 			0, mp->m_super->s_id);
 	if (!mp->m_cil_workqueue)
 		goto out_destroy_unwritten;
 
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			XFS_WQFLAGS(WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
 	if (!mp->m_reclaim_workqueue)
 		goto out_destroy_cil;
 
 	mp->m_gc_workqueue = alloc_workqueue("xfs-gc/%s",
-			WQ_SYSFS | WQ_UNBOUND | WQ_FREEZABLE | WQ_MEM_RECLAIM,
+			WQ_SYSFS | WQ_UNBOUND | WQ_MEM_RECLAIM,
 			0, mp->m_super->s_id);
 	if (!mp->m_gc_workqueue)
 		goto out_destroy_reclaim;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);
+			XFS_WQFLAGS(0), 0, mp->m_super->s_id);
 	if (!mp->m_sync_workqueue)
 		goto out_destroy_eofb;
 
@@ -2104,7 +2104,7 @@ xfs_init_workqueues(void)
 	 * max_active value for this workqueue.
 	 */
 	xfs_alloc_wq = alloc_workqueue("xfsalloc",
-			XFS_WQFLAGS(WQ_MEM_RECLAIM | WQ_FREEZABLE), 0);
+			XFS_WQFLAGS(WQ_MEM_RECLAIM), 0);
 	if (!xfs_alloc_wq)
 		return -ENOMEM;
 
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index dbb69b4bf3ed..8289dcfe8f06 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -581,7 +581,6 @@ xfsaild(
 	unsigned int	noreclaim_flag;
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	set_freezable();
 
 	while (1) {
 		if (tout && tout <= 20)
@@ -636,19 +635,17 @@ xfsaild(
 		    ailp->ail_target == ailp->ail_target_prev &&
 		    list_empty(&ailp->ail_buf_list)) {
 			spin_unlock(&ailp->ail_lock);
-			freezable_schedule();
+			schedule();
 			tout = 0;
 			continue;
 		}
 		spin_unlock(&ailp->ail_lock);
 
 		if (tout)
-			freezable_schedule_timeout(msecs_to_jiffies(tout));
+			schedule_timeout(msecs_to_jiffies(tout));
 
 		__set_current_state(TASK_RUNNING);
 
-		try_to_freeze();
-
 		tout = xfsaild_push(ailp);
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0f4d624f0f3f..48e08397ea3b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2602,6 +2602,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
+#ifdef CONFIG_PM_SLEEP
+int fs_suspend_freeze(void);
+int fs_resume_unfreeze(void);
+#else
+static inline int fs_suspend_freeze(void)
+{
+	return 0;
+}
+static inline int fs_resume_unfreeze(void)
+{
+	return 0;
+}
+#endif
 extern bool our_mnt(struct vfsmount *mnt);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 50cc63534486..94e9c6a55fee 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -145,6 +145,16 @@ int freeze_processes(void)
 	pr_cont("\n");
 	BUG_ON(in_atomic());
 
+	pr_info("Freezing filesystems ... ");
+	error = fs_suspend_freeze();
+	if (error) {
+		pr_cont("failed\n");
+		fs_resume_unfreeze();
+		thaw_processes();
+		return error;
+	}
+	pr_cont("done.\n");
+
 	/*
 	 * Now that the whole userspace is frozen we need to disable
 	 * the OOM killer to disallow any further interference with
@@ -154,8 +164,10 @@ int freeze_processes(void)
 	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
 		error = -EBUSY;
 
-	if (error)
+	if (error) {
+		fs_resume_unfreeze();
 		thaw_processes();
+	}
 	return error;
 }
 
@@ -198,6 +210,7 @@ void thaw_processes(void)
 	pm_nosig_freezing = false;
 
 	oom_killer_enable();
+	fs_resume_unfreeze();
 
 	pr_info("Restarting tasks ... ");
 
-- 
2.29.2

