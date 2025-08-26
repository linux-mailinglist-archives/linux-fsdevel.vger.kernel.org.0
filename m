Return-Path: <linux-fsdevel+bounces-59255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F067B36E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A13846151D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5F362077;
	Tue, 26 Aug 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3HHfEzkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7535FC15
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222884; cv=none; b=WlCpxaa5etva3Qgv/fbumK2pS1a7sDzWMrkZdUQU4fTCT17qwdMtcSVZLtcILxWwTA3JqTm8sp2GLqualpNY4QHjizLg9gVLeIQDwFrIWNA5dXverJTXKlMNvWpg5ESTb9NLSdPE9GL5M0gAU8bUmGy8zXV7mWJWUJu27TokbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222884; c=relaxed/simple;
	bh=CuNzKVjxyDuufOSS/5V6s3orRkMFYVTHjW39NFc1+Hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY9qdj0l5dQXG0/mDK+YQFsVeYLZJUTmKayYIELp+RgA6p79/nubukHHhb1UkVPf/ORwplsFbf1qFZVMKWbF8iWxELr3/iRl8h0ui82pKM6dFLna5hu+2b5zrnx83YKs0XsvHulQVkVFYkfUiTq/2MuF1MRHnDmMoKXrLe38jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3HHfEzkm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e96c48e7101so2022802276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222881; x=1756827681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuS9znzhPZfNBukW6zcIBltpMK0Qc2fVrXDqWztTeVs=;
        b=3HHfEzkmwnZPpapwgewlimPAZvvFkiSzkOSzL9YU52LF5J37HQk2B0LmcGgVRF/27S
         Dht6wwTNQ/h3TFPqeOarbWxHB/Og4MiFKrYsFvYB5P0R7mkAMc1AELh30MzFEnW/yXlR
         g0cW0N8LmOjUCVsYFnIL7eFothNmhxDOPiv41IN4zR0oHjpg6wAN05PXz90omuSHuuIy
         iSmlRncyOnxkgdSPlpuU7eqnCoPwr3DxqtqDFJvnYH1YmuIRnc718rdabZXRslzoyA6G
         c8XxF/iNLodj8Gv1vsCnCvb4WjmskSjfvooAusRxEeeNfUS+CrAs9Qt7aN3VmkQ+Ephv
         MLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222881; x=1756827681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuS9znzhPZfNBukW6zcIBltpMK0Qc2fVrXDqWztTeVs=;
        b=AKEdmBxVOyKixpmXICcNLnu8/td1c6bXPB0e5gXJiL3q0t61gZPHmXLDxtetL2uZSo
         H0/hgb4vxKvUrBdAZBUrTTZt+ZkzOEQ27Q4a4lboO/YANV1OVt8ds8HsVnBN/KuW3QOC
         LyjBEz6PLrta7K5VDB9Sqp9i3Fo0mDGDIkXXphscQoGcEKUfSHJUOWAka2sJb2RdXEIG
         64qUsnGcrPgzGwOMa2GXETrZxcWH6EKf+jqs0FxEkwL2VOSeID/liApGIHICI85Ox3on
         n/dsVr09uKpotsOE5b5AJ4jwcBpJGseozivbV9mkmJ2+X22iOdM/tu8qQVWrV/SPHTuK
         0Z2g==
X-Gm-Message-State: AOJu0YyxfDjPY4kLLEO7Jxv59KUek7eQUVNp0jWx3a/LHnowOnNgljED
	uDzPOoaXH7vqHXi5beY8h0cFBpXEFRfAaDS9oySLSNhryo7YJq5YPqhf5bFoy86m1LOaRnWaeqd
	lZNUd
X-Gm-Gg: ASbGncug86/JU9qXAWRspkmb6Owpdkg2ifvm6zYFoYf3l/ciEXv8rr+SSEFJzDI9B17
	fRRFl0lofdCk++42+HNevcA+vUYplBkcLhkiRzi23FLQB75Za31xnHReWh6hqbzcaVbfFyKGq5e
	oO5EHb1QM5Etp6cu4pUruRqTrFAdUJ+2gn8IEY1zz6VFaB+uvlzIU5wZd0bt5DcWRSt6cXdLC/p
	rN7TpYhPnOlxPo+DTjJ09BQUyJ06VOQqUu/SSYStSng6in58IN9yiVmLlbaRS0t+LY/YhHOjyEE
	RNzi+WC7yCX0kxfp4z1fKkUCyqo/0o8D/FyypLAx8Tih2wVk9vvLFwuDQ7l0+hmLqWqTFzGbc/C
	6Vn9u41liYJrLsJ5GVULlLJL2oPZK+TpslOd7yf7CjhUBtD6FdYe2Yi+EcvKMYxrFRztFlQ==
X-Google-Smtp-Source: AGHT+IFc0KpyS4c1MEvPSJ7IghCbW/lRtiDHm2Wjw6ND0YS7erVoWnML+MpkPRFXgDeyUA9XCDmVSQ==
X-Received: by 2002:a05:6902:70c:b0:e95:3dcd:c6f3 with SMTP id 3f1490d57ef6-e953dcdc929mr11127029276.35.1756222880557;
        Tue, 26 Aug 2025 08:41:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c27b8d0sm3351304276.12.2025.08.26.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 22/54] fs: convert i_count to refcount_t
Date: Tue, 26 Aug 2025 11:39:22 -0400
Message-ID: <36a888e4cf47948c01f49ee24ede2b662075fc5e.1756222465.git.josef@toxicpanda.com>
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

Now that we do not allow i_count to drop to 0 and be used we can convert
it to a refcount_t and benefit from the protections those helpers add.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   | 2 +-
 fs/inode.c         | 9 +++++----
 include/linux/fs.h | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e16df38e0eef..eb9496342346 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3418,7 +3418,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long flags;
 
-	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
+	if (refcount_dec_not_one(&inode->vfs_inode.i_count)) {
 		iobj_put(&inode->vfs_inode);
 		return;
 	}
diff --git a/fs/inode.c b/fs/inode.c
index 1992db5cd70a..0be1c137bf1e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -236,7 +236,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_state = 0;
 	atomic64_set(&inode->i_sequence, 0);
 	refcount_set(&inode->i_obj_count, 1);
-	atomic_set(&inode->i_count, 1);
+	refcount_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
 	inode->i_ino = 0;
@@ -545,7 +545,8 @@ static void init_once(void *foo)
 void ihold(struct inode *inode)
 {
 	iobj_get(inode);
-	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
+	refcount_inc(&inode->i_count);
+	WARN_ON(icount_read(inode) < 2);
 }
 EXPORT_SYMBOL(ihold);
 
@@ -2011,7 +2012,7 @@ static void __iput(struct inode *inode, bool skip_lru)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
 
-	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+	if (refcount_dec_not_one(&inode->i_count)) {
 		iobj_put(inode);
 		return;
 	}
@@ -2031,7 +2032,7 @@ static void __iput(struct inode *inode, bool skip_lru)
 	 */
 	drop = maybe_add_lru(inode, skip_lru);
 
-	if (atomic_dec_and_test(&inode->i_count)) {
+	if (refcount_dec_and_test(&inode->i_count)) {
 		/* iput_final() drops i_lock */
 		iput_final(inode, drop);
 	} else {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 999ffea2aac1..fc23e37ca250 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -875,7 +875,7 @@ struct inode {
 	};
 	atomic64_t		i_version;
 	atomic64_t		i_sequence; /* see futex */
-	atomic_t		i_count;
+	refcount_t		i_count;
 	atomic_t		i_dio_count;
 	atomic_t		i_writecount;
 #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
@@ -3399,12 +3399,12 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
 static inline void __iget(struct inode *inode)
 {
 	iobj_get(inode);
-	atomic_inc(&inode->i_count);
+	refcount_inc(&inode->i_count);
 }
 
 static inline int icount_read(const struct inode *inode)
 {
-	return atomic_read(&inode->i_count);
+	return refcount_read(&inode->i_count);
 }
 
 extern void iget_failed(struct inode *);
-- 
2.49.0


