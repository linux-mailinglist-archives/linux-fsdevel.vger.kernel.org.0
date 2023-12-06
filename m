Return-Path: <linux-fsdevel+bounces-4936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25100806750
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F21C209AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29C918AE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="z1+QzgS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF0D51
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:36 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b9b90f8708so1756715b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842796; x=1702447596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I06elknjTKgnu51XMDSSIqaWSXzJw01Bc0WUn6qADWU=;
        b=z1+QzgS4/Sbur45/4z83hrhThmyzPewSii5IGNWBp6GTVMHXan1ZgtwY9whhev+mue
         K2ZHkgYYfm6+aYG0XuukPWn5UueTuQw+vOUYlV80QZ+lUDS2TfQykJDh7HtNJsxIKz7n
         SpQtBqTgUjl8bpz5bxP9mVB+b9Hs80aof8fSZcuFhp2tLKDxIFIW3xsRkXS9AbzM0iK3
         iRZWOATKwtohJNwKyzPUz7t0hfb4AgHI9uvqRSrtknZnOo43KE/OM4nvkcLkJlDTwx7/
         hgSRB/D5Cu4dVXEoD7xo9XGHzuEhM7KIKsX0Wc1kHbOpmaAGbWLjo9U/Vw9B5ehH1kU1
         M6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842796; x=1702447596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I06elknjTKgnu51XMDSSIqaWSXzJw01Bc0WUn6qADWU=;
        b=Z76O9a8HWZtZMh98F3WFKQ5926VzvjIoWg2N499vJ6T+uC3wAD9uTOoVQTB+ztcyeg
         tez/5hB26U5SzWrvj3jd67o8guj0hwPEJiJAWuSJW1NGXVnWpscB+AkxlRGp5eNb9+gT
         mreOEVgjQhryFUL0JpVlRBexNwgXUf73jI/RsdFoeMOKtodNxlGRXWr1mxPrxxUiWJH9
         MiEin2DIa+DEzZAae68UJcdCZ4KsasklI97QzCigrEv8N4Ed2Xb7BaMnhQicQdp+1H23
         +dg+ET0rsu09GPQ80FBEY3oDXZ5/UzhdBVVxCv8R4pYLm4DQ0TY8P9GrM/bjFhllnvXS
         Nb6g==
X-Gm-Message-State: AOJu0Yzk1WLK1BVoz06YzXwk8Zllg6OxyDj2JkliFWocotGxueHa5AhB
	p+/HJYsatZeJEjywVx5o90DK+Q==
X-Google-Smtp-Source: AGHT+IHg46YrWrDsKyEzgLgbWMIe2JdBMh/jkxRdtDbsgeZCFkTPl/hq1LWU5hHHTCSeMwm3TFAgdw==
X-Received: by 2002:a05:6808:6507:b0:3b8:b063:5d82 with SMTP id fm7-20020a056808650700b003b8b0635d82mr684790oib.105.1701842795753;
        Tue, 05 Dec 2023 22:06:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm2297147pfk.99.2023.12.05.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3I-004VOr-0C;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVL-2XOR;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] selinux: use dlist for isec inode list
Date: Wed,  6 Dec 2023 17:05:34 +1100
Message-ID: <20231206060629.2827226-6-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Because it's a horrible point of lock contention under heavily
concurrent directory traversals...

  - 12.14% d_instantiate
     - 12.06% security_d_instantiate
	- 12.13% selinux_d_instantiate
	   - 12.16% inode_doinit_with_dentry
	      - 15.45% _raw_spin_lock
		 - do_raw_spin_lock
		      14.68% __pv_queued_spin_lock_slowpath


Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/dlock-list.h        |  9 ++++
 security/selinux/hooks.c          | 72 +++++++++++++++----------------
 security/selinux/include/objsec.h |  6 +--
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/include/linux/dlock-list.h b/include/linux/dlock-list.h
index 327cb9edc7e3..7ad933b8875d 100644
--- a/include/linux/dlock-list.h
+++ b/include/linux/dlock-list.h
@@ -132,6 +132,15 @@ extern void dlock_lists_add(struct dlock_list_node *node,
 			    struct dlock_list_heads *dlist);
 extern void dlock_lists_del(struct dlock_list_node *node);
 
+static inline void
+dlock_list_del_iter(struct dlock_list_iter *iter,
+		struct dlock_list_node *node)
+{
+	WARN_ON_ONCE((iter->entry != READ_ONCE(node->head)));
+	list_del_init(&node->list);
+	WRITE_ONCE(node->head, NULL);
+}
+
 /*
  * Find the first entry of the next available list.
  */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda711c6b7b..0358d7c66949 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -340,26 +340,11 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
-	struct superblock_security_struct *sbsec;
 
 	if (!isec)
 		return;
-	sbsec = selinux_superblock(inode->i_sb);
-	/*
-	 * As not all inode security structures are in a list, we check for
-	 * empty list outside of the lock to make sure that we won't waste
-	 * time taking a lock doing nothing.
-	 *
-	 * The list_del_init() function can be safely called more than once.
-	 * It should not be possible for this function to be called with
-	 * concurrent list_add(), but for better safety against future changes
-	 * in the code, we use list_empty_careful() here.
-	 */
-	if (!list_empty_careful(&isec->list)) {
-		spin_lock(&sbsec->isec_lock);
-		list_del_init(&isec->list);
-		spin_unlock(&sbsec->isec_lock);
-	}
+	if (!list_empty(&isec->list.list))
+		dlock_lists_del(&isec->list);
 }
 
 struct selinux_mnt_opts {
@@ -547,6 +532,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = d_backing_inode(root);
+	struct dlock_list_iter iter;
+	struct inode_security_struct *isec, *n;
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
@@ -570,27 +557,28 @@ static int sb_finish_set_opts(struct super_block *sb)
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(root_inode, root);
 
-	/* Initialize any other inodes associated with the superblock, e.g.
-	   inodes created prior to initial policy load or inodes created
-	   during get_sb by a pseudo filesystem that directly
-	   populates itself. */
-	spin_lock(&sbsec->isec_lock);
-	while (!list_empty(&sbsec->isec_head)) {
-		struct inode_security_struct *isec =
-				list_first_entry(&sbsec->isec_head,
-					   struct inode_security_struct, list);
+	/*
+	 * Initialize any other inodes associated with the superblock, e.g.
+	 * inodes created prior to initial policy load or inodes created during
+	 * get_sb by a pseudo filesystem that directly populates itself.
+	 */
+	init_dlock_list_iter(&iter, &sbsec->isec_head);
+	dlist_for_each_entry_safe(isec, n, &iter, list) {
 		struct inode *inode = isec->inode;
-		list_del_init(&isec->list);
-		spin_unlock(&sbsec->isec_lock);
+
+		dlock_list_del_iter(&iter, &isec->list);
+		dlock_list_unlock(&iter);
+
 		inode = igrab(inode);
 		if (inode) {
 			if (!IS_PRIVATE(inode))
 				inode_doinit_with_dentry(inode, NULL);
 			iput(inode);
 		}
-		spin_lock(&sbsec->isec_lock);
+
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sbsec->isec_lock);
+	WARN_ON_ONCE(!dlock_lists_empty(&sbsec->isec_head));
 	return rc;
 }
 
@@ -1428,10 +1416,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
-		spin_lock(&sbsec->isec_lock);
-		if (list_empty(&isec->list))
-			list_add(&isec->list, &sbsec->isec_head);
-		spin_unlock(&sbsec->isec_lock);
+		if (list_empty(&isec->list.list))
+			dlock_lists_add(&isec->list, &sbsec->isec_head);
 		goto out_unlock;
 	}
 
@@ -2548,9 +2534,10 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
+	if (alloc_dlock_list_heads(&sbsec->isec_head))
+		return -ENOMEM;
+
 	mutex_init(&sbsec->lock);
-	INIT_LIST_HEAD(&sbsec->isec_head);
-	spin_lock_init(&sbsec->isec_lock);
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
@@ -2558,6 +2545,15 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	return 0;
 }
 
+static void selinux_sb_free_security(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
+
+	if (!sbsec)
+		return;
+	free_dlock_list_heads(&sbsec->isec_head);
+}
+
 static inline int opt_len(const char *s)
 {
 	bool open_quote = false;
@@ -2841,7 +2837,7 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	u32 sid = current_sid();
 
 	spin_lock_init(&isec->lock);
-	INIT_LIST_HEAD(&isec->list);
+	init_dlock_list_node(&isec->list);
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
@@ -2920,6 +2916,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	if (rc)
 		return rc;
 
+
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = selinux_inode(inode);
@@ -7215,6 +7212,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 		      selinux_msg_queue_alloc_security),
 	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 8159fd53c3de..e0709f429c56 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/lsm_hooks.h>
 #include <linux/msg.h>
+#include <linux/dlock-list.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -45,7 +46,7 @@ enum label_initialized {
 
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
-	struct list_head list;	/* list of inode_security_struct */
+	struct dlock_list_node list;	/* list of inode_security_struct */
 	u32 task_sid;		/* SID of creating task */
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
@@ -67,8 +68,7 @@ struct superblock_security_struct {
 	unsigned short behavior;	/* labeling behavior */
 	unsigned short flags;		/* which mount options were specified */
 	struct mutex lock;
-	struct list_head isec_head;
-	spinlock_t isec_lock;
+	struct dlock_list_heads isec_head;
 };
 
 struct msg_security_struct {
-- 
2.42.0


