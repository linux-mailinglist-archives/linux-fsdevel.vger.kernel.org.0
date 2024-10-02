Return-Path: <linux-fsdevel+bounces-30636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56598CAED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F172860BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4431119A;
	Wed,  2 Oct 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IEBqPUxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C097489
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833228; cv=none; b=qvJNO/GGh8AMYiBFKu5/5Nw6WPmHcFng6oTzcDjgpi191qW2I+uNHRhfQFBKtgIlsAEo9FpwEK1XjZHpraSOf2qamYsSFGczttIAkpwNit5K5o2aTgjtdFNUCU8uO8uzgNqOz200WOPNgGjDRg/Ky0ueQjN/JCHO5Q9zoDWy8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833228; c=relaxed/simple;
	bh=+XKGTg2Fm2Vz3At0AuJQbYflFNLhbpQLe87wbKWotS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVJ6uJxiPLaCZzxjLzfk6f0nv0Rp4QlV5zj3FVbLo7L5xAjR+z03RWQtJALVLomfTSnyhWVmAxdODysDlPdjm6aJgpwqhiWqfrvu0YY5hzmg1ZWu3AxPOl8+F9PshCuCd9zzl1IgBS3bv9wQTJVCaBxNsH8yY9wefEmQmQMEWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IEBqPUxS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71971d2099cso5022195b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727833224; x=1728438024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcwJDAj1IFVpreD1ammGhtQbYCd8gl9K3mp7z+9tlY8=;
        b=IEBqPUxSztEu5nQGwcIjCoyJPHNlsPs5IJKGyi7iD8WWXdx2B38b4wbwA/qAhrL8gP
         vHAGLpGqNQJcTN9K5GMHp23RYTcsSA+xpZlSlLtcSf66qPe3knfMO/zrNtaesAtX/f6F
         3DLVkSjP8xZzL1rc8IgLB0cESFGxf7x0EQtbKL6r9af2J/ypEDdkmm37Akh9a01cPjWi
         QtMT9C64vQuQAk+d9pnsdIEgAQalYx4rJTDlVck/CHzGJuSPIkh5TBiHv/J40kZxCoWs
         q5qGC0mB0guQ03wfJ3pIbnErDfpfGDTOtwt5YC9gGiW5TtVmEMXe3g3pFSQxBYLFkyds
         kjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833224; x=1728438024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcwJDAj1IFVpreD1ammGhtQbYCd8gl9K3mp7z+9tlY8=;
        b=Q9r5P58F54FBPI8gLKZfhledbKKouYy60PfnksVuCLh/S0QP+aYCcTWG+7o+O0NPgD
         aJ3f2tUw7dIbz84U1Ig600nKV5Ej8s3gj8WiO4vM1UX9fWwiO9Dq536ggcvLIeYvtaFd
         o+sSMxU2r0sI+LNcFfvKUbi0ukhUV31buecLcW++sJ7uYO3RHo+rLWq1rGdMAk1rkyjj
         3eil1CienMAXnWWNbkX0q2qLGcqgyoh6cbrhHkCh0XXwBmbvFmddn7VubfYhDnrk2Qp0
         erWfANvbvj+yLW5aVNai09Eq9YxK8E9mI2yEet+di1eeO7bj5SFcEcCnCWIik15xGooP
         hyFA==
X-Gm-Message-State: AOJu0YxjsjqGZQlio5l9NIdSWUCmoNY9DcWc3NL5hgLfvsmuC586LV5W
	2l0vlhNJWX7bWsGa7fHMISdbERIM2RoALDnorWolWBxSZBurAsI1hYJviWYkypA+up2cJ8hQX6n
	f
X-Google-Smtp-Source: AGHT+IFa5VKdpW6OvBWszejvcA/9C9ZTu/6tm7n5XHiTdlPJ5OMaqnIPrAPaDLI1mfIM4f+OniOK5w==
X-Received: by 2002:a05:6a00:ace:b0:717:8cef:4053 with SMTP id d2e1a72fcca58-71dc5ca5780mr2190927b3a.14.1727833224360;
        Tue, 01 Oct 2024 18:40:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649c2bfsm8742445b3a.28.2024.10.01.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:40:22 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1svoLj-00Ck8Y-0N;
	Wed, 02 Oct 2024 11:40:19 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1svoLj-0000000FxGK-2Iqj;
	Wed, 02 Oct 2024 11:40:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: [PATCH 3/7] vfs: convert vfs inode iterators to super_iter_inodes_unsafe()
Date: Wed,  2 Oct 2024 11:33:20 +1000
Message-ID: <20241002014017.3801899-4-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002014017.3801899-1-david@fromorbit.com>
References: <20241002014017.3801899-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Convert VFS internal superblock inode iterators that cannot use
referenced inodes to the new super_iter_inodes_unsafe() iterator.
Dquot and inode eviction require this special handling due to
special eviction handling requirements. The special
nr_blockdev_pages() statistics code needs it as well, as this is
called from si_meminfo() and so can potentially be run from
locations where arbitrary blocking is not allowed or desirable.

New cases using this iterator need careful consideration.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 block/bdev.c     | 24 +++++++++++----
 fs/inode.c       | 79 ++++++++++++++++++++++++++----------------------
 fs/quota/dquot.c | 72 ++++++++++++++++++++++++-------------------
 3 files changed, 102 insertions(+), 73 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 33f9c4605e3a..b5a362156ca1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -472,16 +472,28 @@ void bdev_drop(struct block_device *bdev)
 	iput(BD_INODE(bdev));
 }
 
+static int bdev_pages_count(struct inode *inode, void *data)
+{
+	long	*pages = data;
+
+	*pages += inode->i_mapping->nrpages;
+	return INO_ITER_DONE;
+}
+
 long nr_blockdev_pages(void)
 {
-	struct inode *inode;
 	long ret = 0;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-
+	/*
+	 * We can be called from contexts where blocking is not
+	 * desirable. The count is advisory at best, and we only
+	 * need to access the inode mapping. Hence as long as we
+	 * have an inode existence guarantee, we can safely count
+	 * the cached pages on each inode without needing reference
+	 * counted inodes.
+	 */
+	super_iter_inodes_unsafe(blockdev_superblock,
+			bdev_pages_count, &ret);
 	return ret;
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 0a53d8c34203..3f335f78c5b2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -761,8 +761,11 @@ static void evict(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head *head)
+static bool dispose_list(struct list_head *head)
 {
+	if (list_empty(head))
+		return false;
+
 	while (!list_empty(head)) {
 		struct inode *inode;
 
@@ -772,6 +775,7 @@ static void dispose_list(struct list_head *head)
 		evict(inode);
 		cond_resched();
 	}
+	return true;
 }
 
 /**
@@ -783,47 +787,50 @@ static void dispose_list(struct list_head *head)
  * so any inode reaching zero refcount during or after that call will
  * be immediately evicted.
  */
+static int evict_inode_fn(struct inode *inode, void *data)
+{
+	struct list_head *dispose = data;
+
+	spin_lock(&inode->i_lock);
+	if (atomic_read(&inode->i_count) ||
+	    (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE))) {
+		spin_unlock(&inode->i_lock);
+		return INO_ITER_DONE;
+	}
+
+	inode->i_state |= I_FREEING;
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+	list_add(&inode->i_lru, dispose);
+
+	/*
+	 * If we've run long enough to need rescheduling, abort the
+	 * iteration so we can return to evict_inodes() and dispose of the
+	 * inodes before collecting more inodes to evict.
+	 */
+	if (need_resched())
+		return INO_ITER_ABORT;
+	return INO_ITER_DONE;
+}
+
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *next;
 	LIST_HEAD(dispose);
 
-again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
-		if (atomic_read(&inode->i_count))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (atomic_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode->i_state |= I_FREEING;
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-		list_add(&inode->i_lru, &dispose);
-
+	do {
 		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
+		 * We do not want to take references to inodes whilst iterating
+		 * because we are trying to evict unreferenced inodes from
+		 * the cache. Hence we need to use the unsafe iteration
+		 * mechanism and do all the required inode validity checks in
+		 * evict_inode_fn() to safely queue unreferenced inodes for
+		 * eviction.
+		 *
+		 * We repeat the iteration until it doesn't find any more
+		 * inodes to dispose of.
 		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	dispose_list(&dispose);
+		super_iter_inodes_unsafe(sb, evict_inode_fn, &dispose);
+	} while (dispose_list(&dispose));
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b40410cd39af..ea0bd807fed7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1075,41 +1075,51 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
+struct dquot_ref_data {
+	int	type;
+	int	reserved;
+};
+
+static int remove_dquot_ref_fn(struct inode *inode, void *data)
+{
+	struct dquot_ref_data *ref = data;
+
+	spin_lock(&dq_data_lock);
+	if (!IS_NOQUOTA(inode)) {
+		struct dquot __rcu **dquots = i_dquot(inode);
+		struct dquot *dquot = srcu_dereference_check(
+			dquots[ref->type], &dquot_srcu,
+			lockdep_is_held(&dq_data_lock));
+
+#ifdef CONFIG_QUOTA_DEBUG
+		if (unlikely(inode_get_rsv_space(inode) > 0))
+			ref->reserved++;
+#endif
+		rcu_assign_pointer(dquots[ref->type], NULL);
+		if (dquot)
+			dqput(dquot);
+	}
+	spin_unlock(&dq_data_lock);
+	return INO_ITER_DONE;
+}
+
 static void remove_dquot_ref(struct super_block *sb, int type)
 {
-	struct inode *inode;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 *  We have to scan also I_NEW inodes because they can already
-		 *  have quota pointer initialized. Luckily, we need to touch
-		 *  only quota pointers and these have separate locking
-		 *  (dq_data_lock).
-		 */
-		spin_lock(&dq_data_lock);
-		if (!IS_NOQUOTA(inode)) {
-			struct dquot __rcu **dquots = i_dquot(inode);
-			struct dquot *dquot = srcu_dereference_check(
-				dquots[type], &dquot_srcu,
-				lockdep_is_held(&dq_data_lock));
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
 
+	/*
+	 * We have to scan I_NEW inodes because they can already
+	 * have quota pointer initialized. Luckily, we need to touch
+	 * only quota pointers and these have separate locking
+	 * (dq_data_lock) so the existence guarantee that
+	 * super_iter_inodes_unsafe() provides inodes passed to
+	 * remove_dquot_ref_fn() is sufficient for this operation.
+	 */
+	super_iter_inodes_unsafe(sb, remove_dquot_ref_fn, &ref);
 #ifdef CONFIG_QUOTA_DEBUG
-			if (unlikely(inode_get_rsv_space(inode) > 0))
-				reserved = 1;
-#endif
-			rcu_assign_pointer(dquots[type], NULL);
-			if (dquot)
-				dqput(dquot);
-		}
-		spin_unlock(&dq_data_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-#ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
-- 
2.45.2


