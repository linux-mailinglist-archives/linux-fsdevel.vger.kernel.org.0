Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192CE5A3BED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiH1FFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiH1FFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCE8186C5;
        Sat, 27 Aug 2022 22:04:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so5287079pfb.12;
        Sat, 27 Aug 2022 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=/LPn7aalHmp/2iD5MLAhQSPlff03IOrgv7wz2wRKcqA=;
        b=BZ1VflWxPW2X+YEesXUHtT5mtVMxtXjkTwvqI9qliG3q/q83+rYwvvrAPv50FB26v2
         KUxZgmIPV8COkevn+iLhbeDSjNNupSbWAlxEyI4v6a4Poxcj8gWY/ltk37h/V5ILZ9TL
         a35WvPDajj1VmYDI/07w+QRGUlXTsQOikqCWrIh3Jo2rPMpdXh3JrQX9srY7gtWCRHg1
         P2G5FD7NowZYCsuxjnaS9WAe9gM0ncMQIYTvhj/+dUZ4dWW9jYVcg9IHomkuzAzcoHg/
         dFmKtLVxEJIcvispuQ/xZJasOd/rY/QsPCjlUQj2TbX1g6HRK+vmBnSnV/wQ1F0LQXBf
         idlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=/LPn7aalHmp/2iD5MLAhQSPlff03IOrgv7wz2wRKcqA=;
        b=OmuhOwRJeCwRV3AafPxdd73YwYc7f4xAuABolFML2qqcuom+hiPhi1ER3bMZpluD27
         e3WziEeAXO+hbmXzo8vdSFHvAP3kGcyTyvXl2eF3W3xlidoWoGqMnsNB/EFDqDGnY1YZ
         h0Wnxk6dC/nBgFdZmBtQbtp2fYP6GEKmX9cK4c84Agy0daLChRenycIPF0Akq9uyUMX+
         KaZP3XrMPEClrpfo4UGf1j8Tr0xbgOnPkoBU0DE0tY+HGesUdtj2puAcP4/VhmRT5Xcb
         QLBSiHiqlGUlF5jstdUKxXI54rmL/NwwAUVeVVpX75YiCPYdxf73BGEF85wcx9JwE7hG
         vlgw==
X-Gm-Message-State: ACgBeo2hrdUOfRAciIHx2tosybx1CVCGSp58e+s9ES6frU2pTn+mmMx8
        aJEAggjLXs0WwtTUvCH7hyc=
X-Google-Smtp-Source: AA6agR5nkPX3xkuaB55/VdFS/j6dEvSXZPk3u4tWtHHJGcR6gEP00um5unKFCQFsWFeiuggNn3JG9A==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id s185-20020a632cc2000000b0041c681d60d2mr8918924pgs.502.1661663098385;
        Sat, 27 Aug 2022 22:04:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ce14-20020a17090aff0e00b001faee47021bsm4165970pjb.9.2022.08.27.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/9] kernfs: Skip kernfs_drain_open_files() more aggressively
Date:   Sat, 27 Aug 2022 19:04:35 -1000
Message-Id: <20220828050440.734579-5-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
References: <20220828050440.734579-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Track the number of mmapped files and files that need to be released and
skip kernfs_drain_open_file() if both are zero, which are the precise
conditions which require draining open_files. The early exit test is
factored into kernfs_should_drain_open_files() which is now tested by
kernfs_drain_open_files()'s caller - kernfs_drain().

This isn't a meaningful optimization on its own but will enable future
stand-alone kernfs_deactivate() implementation.

v2: Chengming noticed that on->nr_to_release was leaking after ->open()
    failure. Fix it by telling kernfs_unlink_open_file() that it's called
    from the ->open() fail path and should dec the counter. Use kzalloc() to
    allocate kernfs_open_node so that the tracking fields are correctly
    initialized.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/dir.c             |  3 +-
 fs/kernfs/file.c            | 65 +++++++++++++++++++++++++------------
 fs/kernfs/kernfs-internal.h |  1 +
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1cc88ba6de90..8ae44db920d4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -489,7 +489,8 @@ static void kernfs_drain(struct kernfs_node *kn)
 		rwsem_release(&kn->dep_map, _RET_IP_);
 	}
 
-	kernfs_drain_open_files(kn);
+	if (kernfs_should_drain_open_files(kn))
+		kernfs_drain_open_files(kn);
 
 	down_write(&root->kernfs_rwsem);
 }
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 7060a2a714b8..9ab6c92e02da 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,6 +23,8 @@ struct kernfs_open_node {
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
+	unsigned int		nr_mmapped;
+	unsigned int		nr_to_release;
 };
 
 /*
@@ -527,6 +529,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 
 	rc = 0;
 	of->mmapped = true;
+	of_on(of)->nr_mmapped++;
 	of->vm_ops = vma->vm_ops;
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
@@ -562,7 +565,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 
 	if (!on) {
 		/* not there, initialize a new one */
-		on = kmalloc(sizeof(*on), GFP_KERNEL);
+		on = kzalloc(sizeof(*on), GFP_KERNEL);
 		if (!on) {
 			mutex_unlock(mutex);
 			return -ENOMEM;
@@ -574,6 +577,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	list_add_tail(&of->list, &on->files);
+	if (kn->flags & KERNFS_HAS_RELEASE)
+		on->nr_to_release++;
 
 	mutex_unlock(mutex);
 	return 0;
@@ -584,6 +589,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
  *
  *	@kn: target kernfs_node
  *	@of: associated kernfs_open_file
+ *	@open_failed: ->open() failed, cancel ->release()
  *
  *	Unlink @of from list of @kn's associated open files. If list of
  *	associated open files becomes empty, disassociate and free
@@ -593,7 +599,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
  *	None.
  */
 static void kernfs_unlink_open_file(struct kernfs_node *kn,
-				 struct kernfs_open_file *of)
+				    struct kernfs_open_file *of,
+				    bool open_failed)
 {
 	struct kernfs_open_node *on;
 	struct mutex *mutex;
@@ -606,8 +613,16 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		return;
 	}
 
-	if (of)
+	if (of) {
+		if (kn->flags & KERNFS_HAS_RELEASE) {
+			WARN_ON_ONCE(of->released == open_failed);
+			if (open_failed)
+				on->nr_to_release--;
+		}
+		if (of->mmapped)
+			on->nr_mmapped--;
 		list_del(&of->list);
+	}
 
 	if (list_empty(&on->files)) {
 		rcu_assign_pointer(kn->attr.open, NULL);
@@ -734,7 +749,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 	return 0;
 
 err_put_node:
-	kernfs_unlink_open_file(kn, of);
+	kernfs_unlink_open_file(kn, of, true);
 err_seq_release:
 	seq_release(inode, file);
 err_free:
@@ -766,6 +781,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 		 */
 		kn->attr.ops->release(of);
 		of->released = true;
+		of_on(of)->nr_to_release--;
 	}
 }
 
@@ -782,7 +798,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 		mutex_unlock(mutex);
 	}
 
-	kernfs_unlink_open_file(kn, of);
+	kernfs_unlink_open_file(kn, of, false);
 	seq_release(inode, filp);
 	kfree(of->prealloc_buf);
 	kfree(of);
@@ -790,25 +806,30 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-void kernfs_drain_open_files(struct kernfs_node *kn)
+bool kernfs_should_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
-	struct kernfs_open_file *of;
-	struct mutex *mutex;
-
-	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
-		return;
+	bool ret;
 
 	/*
-	 * lockless opportunistic check is safe below because no one is adding to
-	 * ->attr.open at this point of time. This check allows early bail out
-	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
-	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
-	 * check under kernfs_open_file_mutex_ptr(kn) will ensure bailing out if
-	 * ->attr.open became NULL while waiting for the mutex.
+	 * @kn being deactivated guarantees that @kn->attr.open can't change
+	 * beneath us making the lockless test below safe.
 	 */
-	if (!rcu_access_pointer(kn->attr.open))
-		return;
+	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
+	ret = on && (on->nr_mmapped || on->nr_to_release);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void kernfs_drain_open_files(struct kernfs_node *kn)
+{
+	struct kernfs_open_node *on;
+	struct kernfs_open_file *of;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
@@ -820,13 +841,17 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	list_for_each_entry(of, &on->files, list) {
 		struct inode *inode = file_inode(of->file);
 
-		if (kn->flags & KERNFS_HAS_MMAP)
+		if (of->mmapped) {
 			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+			of->mmapped = false;
+			on->nr_mmapped--;
+		}
 
 		if (kn->flags & KERNFS_HAS_RELEASE)
 			kernfs_release_file(kn, of);
 	}
 
+	WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
 	mutex_unlock(mutex);
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3ae214d02d44..fc5821effd97 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -157,6 +157,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
  */
 extern const struct file_operations kernfs_file_fops;
 
+bool kernfs_should_drain_open_files(struct kernfs_node *kn);
 void kernfs_drain_open_files(struct kernfs_node *kn);
 
 /*
-- 
2.37.2

