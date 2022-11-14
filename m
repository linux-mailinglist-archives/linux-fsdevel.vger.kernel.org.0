Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8C6281FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiKNOID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiKNOH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C12BB1C;
        Mon, 14 Nov 2022 06:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47823B80F99;
        Mon, 14 Nov 2022 14:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8059CC433B5;
        Mon, 14 Nov 2022 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434869;
        bh=eFZw+QMDM4Sj8o/aPmQH7Ff5PVKB/hSAVhajcVyZKNc=;
        h=From:To:Cc:Subject:Date:From;
        b=hdaLw7nalqNMflq8RCX7oHHpyjM3L/qPbEFa+QtG4nCI0SSlN1z+5eXyGY99CigLu
         HyM9OYh1mcYRnEWvAD6HKCcQHnt61My/6cnIMfPDs/CE0BipVmr4pXTTWeCY3Ch0Hr
         j+aRkxHCzV85GoYF19xIlcFcLbe1QGqfRA3ZRfJlbCePh7rR32/ATuFYOhIq5rFRqs
         7sORNivfoFs5yyTxzdB0ix84EOahwktGqL39U2GxDpKCTba+UTwixEfnnwVjqhnJU3
         gHOTJSsmN/+61xemSSJvrYD9SQp65YURx3JphPSQxm63gcw01slAzcT+jjRvBrjybJ
         ZVXrcatcgeY+g==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, xiubli@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [RFC PATCH] filelock: new helper: vfs_file_has_locks
Date:   Mon, 14 Nov 2022 09:07:47 -0500
Message-Id: <20221114140747.134928-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph has a need to know whether a particular file has any locks set on
it. It's currently tracking that by a num_locks field in its
filp->private_data, but that's problematic as it tries to decrement this
field when releasing locks and that can race with the file being torn
down.

Add a new vfs_file_has_locks helper that will scan the flock and posix
lists, and return true if any of the locks have a fl_file that matches
the given one. Ceph can then call this instead of doing its own
tracking.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 37 insertions(+)

Xiubo,

Here's what I was thinking instead of trying to track this within ceph.
Most inodes never have locks set, so in most cases this will be a NULL
pointer check.

diff --git a/fs/locks.c b/fs/locks.c
index 5876c8ff0edc..c7f903b63a53 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2672,6 +2672,42 @@ int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 }
 EXPORT_SYMBOL_GPL(vfs_cancel_lock);
 
+/**
+ * vfs_file_has_locks - are any locks held that were set on @filp?
+ * @filp: open file to check for locks
+ *
+ * Return true if are any FL_POSIX or FL_FLOCK locks currently held
+ * on @filp.
+ */
+bool vfs_file_has_locks(struct file *filp)
+{
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+	bool ret = false;
+
+	ctx = smp_load_acquire(&locks_inode(filp)->i_flctx);
+	if (!ctx)
+		return false;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+		if (fl->fl_file == filp) {
+			ret = true;
+			goto out;
+		}
+	}
+	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
+		if (fl->fl_file == filp) {
+			ret = true;
+			break;
+		}
+	}
+out:
+	spin_unlock(&ctx->flc_lock);
+	return ret;
+}
+EXPORT_SYMBOL(vfs_file_has_locks);
+
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..e4d0f1fa7f9f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
 extern int vfs_test_lock(struct file *, struct file_lock *);
 extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
+bool vfs_file_has_locks(struct file *file);
 extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
 extern void lease_get_mtime(struct inode *, struct timespec64 *time);
-- 
2.38.1

