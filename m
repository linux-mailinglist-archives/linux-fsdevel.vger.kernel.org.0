Return-Path: <linux-fsdevel+bounces-2646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27657E73B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49987B211E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982938F85;
	Thu,  9 Nov 2023 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KUznzj3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D138DD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:22 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8103C30;
	Thu,  9 Nov 2023 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/3x7Uzb2xVsM+qPa/s6ahfiXYwxF7KgqrBu++ys4yuQ=;
	t=1699565902; x=1700775502; b=KUznzj3vFood3m4qndr+0Z80B26ACVzpDau6qD8FaPG4vyw
	azKhDI/pUxt5lc/NGA8irE4Cdnrw/ZAKAYuDRtt/4LNJgBMdL7oUzJR63AubskA9uGPAROo6IiMtZ
	2Pn2Ojmw4PDyF3Tk4HntXkax+8MUv/rlavzyBtENs1n4AIWe8VZbXjjnRJahgDfpzayaKJDoM3paN
	pI6zRcnH6kpYDuQpjETJP7CHdl28yUMPzH8wuWhX/5irb0MW2ZmzYLoahgox/UARVARH8j7OEbTxq
	JESXEl0lQkQPNbO9TvcPAQbyoVXoKbr9ioprsH+ibNFakONbac0H8PbJtr+U5W5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjC-00000001znF-3teS;
	Thu, 09 Nov 2023 22:38:19 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 3/6] debugfs: add API to allow debugfs operations cancellation
Date: Thu,  9 Nov 2023 22:22:55 +0100
Message-ID: <20231109222251.e6ade2190ef4.If54cd017d5734024e7bee5e4a237e17244050480@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109212251.213873-7-johannes@sipsolutions.net>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In some cases there might be longer-running hardware accesses
in debugfs files, or attempts to acquire locks, and we want
to still be able to quickly remove the files.

Introduce a cancellations API to use inside the debugfs handler
functions to be able to cancel such operations on a per-file
basis.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c       | 82 +++++++++++++++++++++++++++++++++++++++++
 fs/debugfs/inode.c      | 23 +++++++++++-
 fs/debugfs/internal.h   |  5 +++
 include/linux/debugfs.h | 19 ++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e499d38b1077..f6993c068322 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -109,6 +109,8 @@ int debugfs_file_get(struct dentry *dentry)
 		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
 				 &fsd->key, 0);
 #endif
+		INIT_LIST_HEAD(&fsd->cancellations);
+		spin_lock_init(&fsd->cancellations_lock);
 	}
 
 	/*
@@ -151,6 +153,86 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+/**
+ * debugfs_enter_cancellation - enter a debugfs cancellation
+ * @file: the file being accessed
+ * @cancellation: the cancellation object, the cancel callback
+ *	inside of it must be initialized
+ *
+ * When a debugfs file is removed it needs to wait for all active
+ * operations to complete. However, the operation itself may need
+ * to wait for hardware or completion of some asynchronous process
+ * or similar. As such, it may need to be cancelled to avoid long
+ * waits or even deadlocks.
+ *
+ * This function can be used inside a debugfs handler that may
+ * need to be cancelled. As soon as this function is called, the
+ * cancellation's 'cancel' callback may be called, at which point
+ * the caller should proceed to call debugfs_leave_cancellation()
+ * and leave the debugfs handler function as soon as possible.
+ * Note that the 'cancel' callback is only ever called in the
+ * context of some kind of debugfs_remove().
+ *
+ * This function must be paired with debugfs_leave_cancellation().
+ */
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation)
+{
+	struct debugfs_fsdata *fsd;
+	struct dentry *dentry = F_DENTRY(file);
+
+	INIT_LIST_HEAD(&cancellation->list);
+
+	if (WARN_ON(!d_is_reg(dentry)))
+		return;
+
+	if (WARN_ON(!cancellation->cancel))
+		return;
+
+	fsd = READ_ONCE(dentry->d_fsdata);
+	if (WARN_ON(!fsd ||
+		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return;
+
+	spin_lock(&fsd->cancellations_lock);
+	list_add(&cancellation->list, &fsd->cancellations);
+	spin_unlock(&fsd->cancellations_lock);
+
+	/* if we're already removing wake it up to cancel */
+	if (d_unlinked(dentry))
+		complete(&fsd->active_users_drained);
+}
+EXPORT_SYMBOL_GPL(debugfs_enter_cancellation);
+
+/**
+ * debugfs_leave_cancellation - leave cancellation section
+ * @file: the file being accessed
+ * @cancellation: the cancellation previously registered with
+ *	debugfs_enter_cancellation()
+ *
+ * See the documentation of debugfs_enter_cancellation().
+ */
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation)
+{
+	struct debugfs_fsdata *fsd;
+	struct dentry *dentry = F_DENTRY(file);
+
+	if (WARN_ON(!d_is_reg(dentry)))
+		return;
+
+	fsd = READ_ONCE(dentry->d_fsdata);
+	if (WARN_ON(!fsd ||
+		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return;
+
+	spin_lock(&fsd->cancellations_lock);
+	if (!list_empty(&cancellation->list))
+		list_del(&cancellation->list);
+	spin_unlock(&fsd->cancellations_lock);
+}
+EXPORT_SYMBOL_GPL(debugfs_leave_cancellation);
+
 /*
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a4c77aafb77b..2cbcc49a8826 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -247,6 +247,7 @@ static void debugfs_release_dentry(struct dentry *dentry)
 		lockdep_unregister_key(&fsd->key);
 		kfree(fsd->lock_name);
 #endif
+		WARN_ON(!list_empty(&fsd->cancellations));
 	}
 
 	kfree(fsd);
@@ -754,8 +755,28 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	lock_map_acquire(&fsd->lockdep_map);
 	lock_map_release(&fsd->lockdep_map);
 
-	if (!refcount_dec_and_test(&fsd->active_users))
+	/* if we hit zero, just wait for all to finish */
+	if (!refcount_dec_and_test(&fsd->active_users)) {
 		wait_for_completion(&fsd->active_users_drained);
+		return;
+	}
+
+	/* if we didn't hit zero, try to cancel any we can */
+	while (refcount_read(&fsd->active_users)) {
+		struct debugfs_cancellation *c;
+
+		spin_lock(&fsd->cancellations_lock);
+		while ((c = list_first_entry_or_null(&fsd->cancellations,
+						     typeof(*c), list))) {
+			list_del_init(&c->list);
+			spin_unlock(&fsd->cancellations_lock);
+			c->cancel(dentry, c->cancel_data);
+			spin_lock(&fsd->cancellations_lock);
+		}
+		spin_unlock(&fsd->cancellations_lock);
+
+		wait_for_completion(&fsd->active_users_drained);
+	}
 }
 
 static void remove_one(struct dentry *victim)
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index c7d61cfc97d2..5f279abd9351 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -8,6 +8,7 @@
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
 #include <linux/lockdep.h>
+#include <linux/list.h>
 
 struct file_operations;
 
@@ -29,6 +30,10 @@ struct debugfs_fsdata {
 			struct lock_class_key key;
 			char *lock_name;
 #endif
+
+			/* lock for the cancellations list */
+			spinlock_t cancellations_lock;
+			struct list_head cancellations;
 		};
 	};
 };
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..c9c65b132c0f 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -171,6 +171,25 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos);
 
+/**
+ * struct debugfs_cancellation - cancellation data
+ * @list: internal, for keeping track
+ * @cancel: callback to call
+ * @cancel_data: extra data for the callback to call
+ */
+struct debugfs_cancellation {
+	struct list_head list;
+	void (*cancel)(struct dentry *, void *);
+	void *cancel_data;
+};
+
+void __acquires(cancellation)
+debugfs_enter_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation);
+void __releases(cancellation)
+debugfs_leave_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation);
+
 #else
 
 #include <linux/err.h>
-- 
2.41.0


