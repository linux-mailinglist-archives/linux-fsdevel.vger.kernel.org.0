Return-Path: <linux-fsdevel+bounces-30633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51D98CAE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C451F2156A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF12D528;
	Wed,  2 Oct 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vWYaAS7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990265227
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833226; cv=none; b=krO9kxvEk2gJVrO5CNZ1Qb/7Mimmyn1v1bFj0zVTgiP//Sl9QvVxEvaK9vcDqr2aLdaaIkEYAnEIgxoy8q7kyZUAhRbPd0J7XxA4rZM3Vsfd6H1RQwDg6fvVrRtdJ8Ca3l02hTBGnlK52AdLGL/JQJucm5uYQ2jvjpBh2/l5R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833226; c=relaxed/simple;
	bh=x4VXB9HOsPl6CApEgyrJMBzKsAJyIhcNcEvpxp9sYPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmuGcswT33thYiF0PsVun7QPGYJZ5WgQBKW9RLarCT6i9txBORk0nHofJywZq6SdmIr4qBVlWGmsnA11+U55EEn0oK+/D06RYzVPOqkvY7gUocQGDrN/PKG+as7hJSBh/4vXVXgQUcOTwtIXpW/vc4w0QsxxGrLFaT6YSYFd+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vWYaAS7d; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso4670003a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727833224; x=1728438024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78eie/LLOelu1UXuQO5bRLoa7IK7mnMlbWGf/OPUPFU=;
        b=vWYaAS7d9j8okrBpmU4GGWbrYQRf4NnvKU4CmfbnPbfM0VjLM5v1w4eTykDHwTm9ri
         hZUFN6vXvTZwqJ47FgaMtgApfeqiWiKxSIQGJc5GhllA5jcTKdWMFJoVKaB/acz9IZ9m
         m5rnqhpcB8idMf/vJLjNtVnlN69lb2qXrzFJG1xaTtzUnuWnVG3LTZaRtthdXrG75L3t
         fJtozMHSjtAeL5YbVkFHZKiE45RNCBZvlzbXbshsIpF0R/jB1IEfofE71yXMTA7YNq8O
         oKTmz/XUwCcRJhn9i3EPGTOxUZvYGkQIF0PNQvr24HuibkFS5VOcisg6nyAc0kZdkQu1
         vaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833224; x=1728438024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78eie/LLOelu1UXuQO5bRLoa7IK7mnMlbWGf/OPUPFU=;
        b=fAg3yK1b8bVzjJrd80PqkkB34gqPxCah65rSnyosAdwofZfkfONm3RuUT8rrUsLhHJ
         c8ihM89ic1bMfy7rKZCtC4WElbt00DelGFgQrRtngW1WPutbJ2JqlTczkwdC2l1enOCa
         AUOguJdkno9ODno6cMiQ7JhjpswHawvoyMf6tlwXqnX5JCQp6zkXnM2awvEul3RdMFXJ
         zSiOQCAv7QnNR6kfsfKdAZ928cqw8UVTLoyZxWRpUoO0e9mohGzxeE8ET5URiKkI9mbU
         9woT5db92vD/F5BsS2YDEuLSSbEsd17hbatuW4lBKAfjvm8kQV9S9lxibiP7mtuHM3BY
         pmoQ==
X-Gm-Message-State: AOJu0YzrkgtnogxlwSz2kL1swyYstgf3FiHFeSDNexyaSdrUWHUiiGJj
	Q3TAPIqXA4zxjQi3eYi4LzSQ1338Q/VranXMORyuwjgmVrLSIWjLXtFBvCp411QFb99rjtLBCoh
	J
X-Google-Smtp-Source: AGHT+IGe1/8W+T6DPLuQCgARfncRvysLkH9GHOcsLNaf6AkJBBkqfdn93VL2stU4zGFnBlbPjsCQgw==
X-Received: by 2002:a17:90a:f284:b0:2d8:d58b:52c8 with SMTP id 98e67ed59e1d1-2e1846b764cmr2159859a91.19.1727833223881;
        Tue, 01 Oct 2024 18:40:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8cda33sm329076a91.44.2024.10.01.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:40:22 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1svoLj-00Ck8T-0I;
	Wed, 02 Oct 2024 11:40:19 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1svoLj-0000000FxGG-297f;
	Wed, 02 Oct 2024 11:40:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: [PATCH 2/7] vfs: add inode iteration superblock method
Date: Wed,  2 Oct 2024 11:33:19 +1000
Message-ID: <20241002014017.3801899-3-david@fromorbit.com>
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

Add a new superblock method for iterating all cached inodes in the
inode cache.

This will be used to replace the explicit sb->s_inodes iteration,
and the caller will supply a callback function and a private data
pointer that gets passed to the callback along with each inode that
is iterated.

There are two iteration functions provided. The first is the
interface that everyone should be using - it provides an valid,
unlocked and referenced inode that any inode operation (including
blocking operations) is allowed on. The iterator infrastructure is
responsible for lifecycle management, hence the subsystem callback
only needs to implement the operation it wants to perform on all
inodes.

The second iterator interface is the unsafe variant for internal VFS
use only. It simply iterates all VFS inodes without guaranteeing
any state or taking references. This iteration is done under a RCU
read lock to ensure that the VFS inode is not freed from under
the callback. If the operation wishes to block, it must drop the
RCU context after guaranteeing that the inode will not get freed.
This unsafe iteration mechanism is needed for operations that need
tight control over the state of the inodes they need to operate on.

This mechanism allows the existing sb->s_inodes iteration models
to be maintained, allowing a generic implementation for iterating
all cached inodes on the superblock to be provided.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/internal.h      |   2 +
 fs/super.c         | 105 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  12 ++++++
 3 files changed, 119 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 37749b429e80..7039d13980c6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -127,6 +127,8 @@ struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 int sb_init_dio_done_wq(struct super_block *sb);
+void super_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
+		void *private_data);
 
 /*
  * Prepare superblock for changing its read-only state (i.e., either remount
diff --git a/fs/super.c b/fs/super.c
index a16e6a6342e0..20a9446d943a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -167,6 +167,111 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+/**
+ * super_iter_inodes - iterate all the cached inodes on a superblock
+ * @sb: superblock to iterate
+ * @iter_fn: callback to run on every inode found.
+ *
+ * This function iterates all cached inodes on a superblock that are not in
+ * the process of being initialised or torn down. It will run @iter_fn() with
+ * a valid, referenced inode, so it is safe for the caller to do anything
+ * it wants with the inode except drop the reference the iterator holds.
+ *
+ */
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		void *private_data, int flags)
+{
+	struct inode *inode, *old_inode = NULL;
+	int ret = 0;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		spin_lock(&inode->i_lock);
+		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		/*
+		 * Skip over zero refcount inode if the caller only wants
+		 * referenced inodes to be iterated.
+		 */
+		if ((flags & INO_ITER_REFERENCED) &&
+		    !atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&sb->s_inode_list_lock);
+		iput(old_inode);
+
+		ret = iter_fn(inode, private_data);
+
+		old_inode = inode;
+		if (ret == INO_ITER_ABORT) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(old_inode);
+	return ret;
+}
+
+/**
+ * super_iter_inodes_unsafe - unsafely iterate all the inodes on a superblock
+ * @sb: superblock to iterate
+ * @iter_fn: callback to run on every inode found.
+ *
+ * This is almost certainly not the function you want. It is for internal VFS
+ * operations only. Please use super_iter_inodes() instead. If you must use
+ * this function, please add a comment explaining why it is necessary and the
+ * locking that makes it safe to use this function.
+ *
+ * This function iterates all cached inodes on a superblock that are attached to
+ * the superblock. It will pass each inode to @iter_fn unlocked and without
+ * having performed any existences checks on it.
+
+ * @iter_fn must perform all necessary state checks on the inode itself to
+ * ensure safe operation. super_iter_inodes_unsafe() only guarantees that the
+ * inode exists and won't be freed whilst the callback is running.
+ *
+ * @iter_fn must not block. It is run in an atomic context that is not allowed
+ * to sleep to provide the inode existence guarantees. If the callback needs to
+ * do blocking operations it needs to track the inode itself and defer those
+ * operations until after the iteration completes.
+ *
+ * @iter_fn must provide conditional reschedule checks itself. If rescheduling
+ * or deferred processing is needed, it must return INO_ITER_ABORT to return to
+ * the high level function to perform those operations. It can then restart the
+ * iteration again. The high level code must provide forwards progress
+ * guarantees if they are necessary.
+ *
+ */
+void super_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
+		void *private_data)
+{
+	struct inode *inode;
+	int ret;
+
+	rcu_read_lock();
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		ret = iter_fn(inode, private_data);
+		if (ret == INO_ITER_ABORT)
+			break;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	rcu_read_unlock();
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index eae5b67e4a15..0a6a462c45ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2213,6 +2213,18 @@ enum freeze_holder {
 	FREEZE_MAY_NEST		= (1U << 2),
 };
 
+/* Inode iteration callback return values */
+#define INO_ITER_DONE		0
+#define INO_ITER_ABORT		1
+
+/* Inode iteration control flags */
+#define INO_ITER_REFERENCED	(1U << 0)
+#define INO_ITER_UNSAFE		(1U << 1)
+
+typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		void *private_data, int flags);
+
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
-- 
2.45.2


