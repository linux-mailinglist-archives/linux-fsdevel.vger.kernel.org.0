Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9559A9E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbiHTAGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244364AbiHTAGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B0CE4A8;
        Fri, 19 Aug 2022 17:06:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w29so51201pfj.3;
        Fri, 19 Aug 2022 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=pwu75EvHca3VZc4E4my+47PYvKCdwgwwkawHwqsLMUw=;
        b=E3S9ekC1ltLzioHmVWptBNnM60tb5cABtcyn4UW+0EVGNrLYBz/llI/lNM0WTHOunx
         G6843qB+Q/slcwMbMnq23CwRH4+6PFwC6alMxqp5OwWaL6MO+cutThjmid6YQSpPoMo2
         9nSnSmzRyWSiMvE/G+VnOnAhtn8oKzW3yRvmdUo3dMgJYr3kDL6AL2lvZcRDcVHQlg5L
         2GnyAxppsV23R+RxuT7/R7T7pr+wEettep+UpikfYFxjPnYuKRPdmt5kcdD+b3J0io2e
         5TPK41xhq5VGeV68ihSGm8y8PIIEMFEIVgjudVPm4vhLP1RwwT6S71O4CAGMBV2sD+eb
         +kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=pwu75EvHca3VZc4E4my+47PYvKCdwgwwkawHwqsLMUw=;
        b=GwDYFQzgfjajeXz8VLS8PwsdtGDT6ff7inRT6YfmKtII1dVg1kuS6ORuvOfh53e+tM
         e+7UML/zhchXfQz79f/KPvfiyAny0EJ9lnt8Gia+Oi0FXKTtHTuDZRC2WlyIOHznFTtd
         n6EL1VSPDPYD022kZV8uY5ff9dhvmw/D6oNM+bqMBFrceL28/qb8xK3gl9JORhGIRkx4
         GKuhDTLJVDivEzNJiWLtvMH8P7Mdokw+JQy1BXaPrHGH6v2UM0wuVW93eKEr23Qv0daX
         S/fif/oa4m70PFbC3IdvTyNo+CeW7FkTDyr/xF+xRnP4itltPZagDDOic83Ok7bGXYYO
         DH3Q==
X-Gm-Message-State: ACgBeo2c1bg9dxXItKEZK0Qa+58H2vau+/SsfyumgMlXkZ3sZ40AUqRX
        CzL+bZyq6eO7IjbMRsj8U6s=
X-Google-Smtp-Source: AA6agR7VpyKN7jgP4RTp4sXFQmqgTILVUNX3CJvgdniBXjIQUhK61QhJ2a8u4YLvM11hYlGjTFmgVg==
X-Received: by 2002:a63:2b02:0:b0:41d:9b5e:7d69 with SMTP id r2-20020a632b02000000b0041d9b5e7d69mr8008112pgr.165.1660953969540;
        Fri, 19 Aug 2022 17:06:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b0052c7ff2ac74sm4090819pfc.17.2022.08.19.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/7] kernfs: Skip kernfs_drain_open_files() more aggressively
Date:   Fri, 19 Aug 2022 14:05:48 -1000
Message-Id: <20220820000550.367085-5-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c             |  3 ++-
 fs/kernfs/file.c            | 51 +++++++++++++++++++++++++------------
 fs/kernfs/kernfs-internal.h |  1 +
 3 files changed, 38 insertions(+), 17 deletions(-)

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
index 7060a2a714b8..b510589af427 100644
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
@@ -574,6 +577,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 	}
 
 	list_add_tail(&of->list, &on->files);
+	if (kn->flags & KERNFS_HAS_RELEASE)
+		on->nr_to_release++;
 
 	mutex_unlock(mutex);
 	return 0;
@@ -606,8 +611,12 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 		return;
 	}
 
-	if (of)
+	if (of) {
+		WARN_ON_ONCE((kn->flags & KERNFS_HAS_RELEASE) && !of->released);
+		if (of->mmapped)
+			on->nr_mmapped--;
 		list_del(&of->list);
+	}
 
 	if (list_empty(&on->files)) {
 		rcu_assign_pointer(kn->attr.open, NULL);
@@ -766,6 +775,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
 		 */
 		kn->attr.ops->release(of);
 		of->released = true;
+		of_on(of)->nr_to_release--;
 	}
 }
 
@@ -790,25 +800,30 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
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
@@ -820,13 +835,17 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
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

