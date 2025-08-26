Return-Path: <linux-fsdevel+bounces-59247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40386B36E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264DC7C197F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C01308F3A;
	Tue, 26 Aug 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GNCRS63J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FD356905
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222875; cv=none; b=JwBSx9gmBgo1xSldqnfPJ/TdD9io9Ma1UQ+d4ublLnoPM/YgUfKrIh1F6c3JtUEtnFagbt31jfoVQnSjYb7jYh5DvjbqejDCutsMEJzt5ihwcxwe8ScrppVuFfo5xUcek/eR7nuGnWJPOaabE1nQojUugAeqMXZoRukD9Edf+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222875; c=relaxed/simple;
	bh=K/2E6jJOHKbiBNVw4qyhmvX0VNRB3Q1kRWjPnsEz6Qs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQXdk4MUCpUv6ZpXPOgNfrVKZbdrRlqIU+aVnuGArO7+m/x+5fOQgTWK5Z1qQAyqEEn1Dn3f7YFsxy95m8k8K+l1pZArynrOa38dIu1oG9eGXyQF/VdAJO5bkBWr80Lyn8ftoaR8lKRTERV+yXd0Lah62g5xSloZXDDgnXm5QHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GNCRS63J; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so4823963276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222867; x=1756827667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=GNCRS63J8a9NYmPb/q/1ShkfAfOSsgSqU7FjkpR5hdwPXCuDb/O7olFpxJAurLh7ja
         NFPV5bFN8GZFLBrDuGNaCH29F49cn2mEFXR3DMv0SWcf5ZghO0wbjAbeHvbll3C3VMC+
         cWpR5G/B9VOQsxob+no7avnfUlFBiU7nGvqYTe02GdABSzgAqmkV/izBk5L90W7k7iOr
         vLpbS2kdPwC76UrRTtxMlDiCaHzxN+M4+BPYtSQq8yVp7PYeZQmkceIpzug/pLRsVzbW
         ue6TjDDpEyqyCc3P2VaKxEK4NG1ip70Aephv2CKEENOjxXqv5PFoXhyeCRFKr2A2Kt2J
         eGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222867; x=1756827667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=Rnynt/JVEb2TYX3C9gZ02XPeKDlVycbgwTko2eUSohZP32eTGpo4HFEgZKekcoXV7S
         dvuSTrNgksf5R1eIiI99ul2ONrDHBnDR7+PyFbBFhivyimtgiFwLiRrJGkLgs+FqcRp3
         Oiv6NdIi1QcPlQLZ/ye5KLpe4wO+AYx9z/zwEpfyfxRH0DSlOICaWNjUC+q40B8U8yJM
         GHm66heVayO30NCPO6pgdg0iEGhXOTrQvPeixIhf1WfKwSiUCz/QAw6IGfjSMCB3O1yy
         gQfRjVmhNqgOfhAY8pwPaS/J0LwUuM8hrGfCI/xoBlupcSK6wLxWl6Gh58q8gKwtI77m
         R2bw==
X-Gm-Message-State: AOJu0YxOugonxgFFx33nlNkX1uFidPTmmHHx8aolUgIjFMnvGcMBdXoA
	0WxdyMXy8N0VJWomOlVTkouR9NIQNIFzuiZD/4o1/pLS+hjJeLdUYIHox1xVRyfYvRceaLOGCo0
	6e93f
X-Gm-Gg: ASbGncuGu4SHRg/RCoPCvipkz6kY2UsQrRm0XkULnva+NAyhvPO66oKr8SCsigAx0x5
	llfoGvkzdeqbD7ky5wN9+AYReByNzSlh0ZTZoIJyoCi2RU7b/RQR3V9sxGztiTbq1iCBX6vMyYk
	uhe36zBijo/Uv2MQd7mYF+iO9V+4MrNPouXnjKJzcTt4A45Tdrtae0S+1K+JNhigw6fqq7aakLw
	egNfvefyWzBAP+lQLlqvpvzJkVTSdXJIeOEXpYeo4G77h2m0YVrALfv5/U4HlLh2gQit8e2GLri
	te7Y/jeE6HjnaED4fioNvcIInarDn4mHotMeQ+NqwGrtJXBbFF0+m3qwy5/23pJCtAs7kuuBeOO
	Va+IEYaN1I0Fh6hgdCnNIXTXKdr9iJEixdtyMXJZi2UyUXDy6RsTV/G++Ybk=
X-Google-Smtp-Source: AGHT+IHgXLWIa08EKF5iBQbTPMW+F15MA8jv2gb9313joQGOaaJYJEPu1PArCNZdnFyQDIVStDqfzA==
X-Received: by 2002:a05:690c:c1a:b0:719:4421:70b2 with SMTP id 00721157ae682-71fdc2e0f12mr177717567b3.18.1756222867429;
        Tue, 26 Aug 2025 08:41:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff6edd00fsm22874937b3.10.2025.08.26.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 13/54] fs: hold an i_obj_count when we have an i_count reference
Date: Tue, 26 Aug 2025 11:39:13 -0400
Message-ID: <62383d1029eca5053a2fa320ae51f407c9ae2896.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the start of the semantic changes of inode lifetimes.
Unfortunately we have to do two things in one patch to be properly safe,
but this is the only case where this happens.

First we take and drop an i_obj_count reference every time we get an
i_count reference.  This is because we will be changing the i_count
reference to be the indicator of a "live" inode.

The second thing we do is move the life time of the memory allocation
for the inode under the control of the i_obj_count reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   |  4 +++-
 fs/fs-writeback.c  |  2 --
 fs/inode.c         | 28 +++++++++-------------------
 include/linux/fs.h |  1 +
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac00554e8479..e16df38e0eef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3418,8 +3418,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long flags;
 
-	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
+	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
+		iobj_put(&inode->vfs_inode);
 		return;
+	}
 
 	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
 	atomic_inc(&fs_info->nr_delayed_iputs);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 773b276328ec..b83d556d7ffe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2736,7 +2736,6 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
-		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2750,7 +2749,6 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
-		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/inode.c b/fs/inode.c
index b146b37f7097..ddaf282f7c25 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -527,6 +527,7 @@ static void init_once(void *foo)
  */
 void ihold(struct inode *inode)
 {
+	iobj_get(inode);
 	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
 }
 EXPORT_SYMBOL(ihold);
@@ -843,13 +844,6 @@ static void evict(struct inode *inode)
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
-
-	/*
-	 * refcount_dec_and_test must be used here to avoid the underflow
-	 * warning.
-	 */
-	WARN_ON(!refcount_dec_and_test(&inode->i_obj_count));
-	destroy_inode(inode);
 }
 
 /*
@@ -867,16 +861,8 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
-		/*
-		 * This is going right here for now only because we are
-		 * currently not using the i_obj_count reference for anything,
-		 * and it needs to hit 0 when we call evict().
-		 *
-		 * This will be moved when we change the lifetime rules in a
-		 * future patch.
-		 */
-		iobj_put(inode);
 		evict(inode);
+		iobj_put(inode);
 		cond_resched();
 	}
 }
@@ -1943,8 +1929,10 @@ void iput(struct inode *inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
 
-	if (atomic_add_unless(&inode->i_count, -1, 1))
+	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+		iobj_put(inode);
 		return;
+	}
 
 	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
 		trace_writeback_lazytime_iput(inode);
@@ -1958,6 +1946,7 @@ void iput(struct inode *inode)
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
+	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
 
@@ -1965,13 +1954,14 @@ EXPORT_SYMBOL(iput);
  *	iobj_put	- put a object reference on an inode
  *	@inode: inode to put
  *
- *	Puts a object reference on an inode.
+ *	Puts a object reference on an inode, free's it if we get to zero.
  */
 void iobj_put(struct inode *inode)
 {
 	if (!inode)
 		return;
-	refcount_dec(&inode->i_obj_count);
+	if (refcount_dec_and_test(&inode->i_obj_count))
+		destroy_inode(inode);
 }
 EXPORT_SYMBOL(iobj_put);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84f5218755c3..023ad47685be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3381,6 +3381,7 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
  */
 static inline void __iget(struct inode *inode)
 {
+	iobj_get(inode);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.49.0


