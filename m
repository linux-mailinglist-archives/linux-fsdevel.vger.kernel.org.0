Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022992D82E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 00:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437454AbgLKXvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 18:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437450AbgLKXuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:50:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9CC061794
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b26so7987591pfi.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/zLlE1HqYOZl9IXLJTP7CuZ7MNbdJD471ehmkskJT8=;
        b=a7v7vwVEapF3Atw01f5jFpo2wEaIf9dJYcxfQjf0qoEARoR6t8L3DkeAWU5Tb1/tXl
         jpSesdTmvjL2hFz/5HCcsnJJJWoeJRLa7UQxjOYG9TX84mv4iE2cAzNYeGJfxJfb0CCI
         RbLMZ/7BHgtnf3PMcTP6S/os2DaMWu1nNBXag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/zLlE1HqYOZl9IXLJTP7CuZ7MNbdJD471ehmkskJT8=;
        b=PfHvvcuKEvR3XNqAPD8D8ho+JdBMztvSw7o9npE8duSr2CImiOQMB7JQkvhKJ6SU35
         qMuM8rkw28eTH+xEaig6a2BUCmRfr+ZjGqIp1uUXFr5pQYUE9CW5XR6ioyjb5yNbOgtC
         OvI00sKz4mqIdnSV/m3gDzfv/1s6JVEnx2QuVjuLHXX/FXwYzleetw3GzWBgx02ZymSv
         HUMNdenhHVx/A8UEbEg2EYa6Qy6u8j52ldFRPFrwME3WK5P8A5Ja90Kc7GlMVMuR1xM+
         VfSINTtgmgwZbyGHc8ocB/2MmXpj4IHJRZXh2uOSM+eSizSSG3qYGm/ynPU4QZReP3DT
         8q7A==
X-Gm-Message-State: AOAM532XuD3W2D0DQh1qKf36YR/J2TF5bxxSoa17SeDuhB4vhubEV3O+
        ZGQf1lcnfQH+AHLaBWTgdM648g==
X-Google-Smtp-Source: ABdhPJzYFXaxW0VI+SQ09PRMjVjZ+vQInLognGAQxiAz7aqPF+ejOnRuUw5kEBj/hUZ5lE2jhgFFhw==
X-Received: by 2002:a63:f348:: with SMTP id t8mr14057748pgj.425.1607730611264;
        Fri, 11 Dec 2020 15:50:11 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b12sm11324641pft.114.2020.12.11.15.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:50:10 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/3] errseq: Add errseq_counter to allow for all errors to be observed
Date:   Fri, 11 Dec 2020 15:50:00 -0800
Message-Id: <20201211235002.4195-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211235002.4195-1-sargun@sargun.me>
References: <20201211235002.4195-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the challenges presented with the current errseq method is that it
is impossible for an observer to determine whether or not an error has
occurred since the last error if the last error has not been marked as
"seen". The reason is because the counter is not incremented on every
error, only on each seen -> unseen transition.

One of the reasons for this is that adding an additional 32-bits to each
errseq_t is suboptimal, and having to pay for the cost of doing a cmpxchg
on every error is not ideal either. Instead this introduces a new structure
- errseq_counter, which is meant to be on superblocks, or other objects
that have far fewer instances. A subscriber can then use the combination of
a counter and errseq to determine if an error has occurred.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/buffer.c             |  2 +-
 fs/super.c              |  1 +
 fs/sync.c               |  3 +-
 include/linux/errseq.h  | 14 ++++++++
 include/linux/fs.h      |  6 ++--
 include/linux/pagemap.h |  2 +-
 lib/errseq.c            | 78 +++++++++++++++++++++++++++++++----------
 7 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 23f645657488..dc787834b7a9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1156,7 +1156,7 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 	rcu_read_lock();
 	sb = READ_ONCE(bh->b_bdev->bd_super);
 	if (sb)
-		errseq_set(&sb->s_wb_err, -EIO);
+		errseq_counter_set(&sb->s_wb_err, -EIO);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
diff --git a/fs/super.c b/fs/super.c
index 98bb0629ee10..542c61929c37 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -211,6 +211,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_user_ns = get_user_ns(user_ns);
 	init_rwsem(&s->s_umount);
 	lockdep_set_class(&s->s_umount, &type->s_umount_key);
+	INIT_ERRSEQ_COUNTER(&s->s_wb_err);
 	/*
 	 * sget() can have s_umount recursion.
 	 *
diff --git a/fs/sync.c b/fs/sync.c
index 1373a610dc78..a3bd9ca5052a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -172,7 +172,8 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
-	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+	ret2 = errseq_check_and_advance(&sb->s_wb_err.errseq,
+					&f.file->f_sb_err);
 
 	fdput(f);
 	return ret ? ret : ret2;
diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..35818c484290 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -5,8 +5,22 @@
 #ifndef _LINUX_ERRSEQ_H
 #define _LINUX_ERRSEQ_H
 
+#include <linux/atomic.h>
+
 typedef u32	errseq_t;
+struct errseq_counter {
+	errseq_t	errseq;
+	/* errors are only incremented if the errseq has not been seen */
+	atomic_t	errors;
+};
+
+static inline void INIT_ERRSEQ_COUNTER(struct errseq_counter *counter)
+{
+	counter->errseq = 0;
+	atomic_set(&counter->errors, 0);
+}
 
+errseq_t errseq_counter_set(struct errseq_counter *counter, int err);
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e..127860fb938a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1510,8 +1510,8 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
-	/* per-sb errseq_t for reporting writeback errors via syncfs */
-	errseq_t s_wb_err;
+	/* per-sb errseq_counter for reporting writeback errors via syncfs */
+	struct errseq_counter s_wb_err;
 
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
@@ -2718,7 +2718,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
  */
 static inline errseq_t file_sample_sb_err(struct file *file)
 {
-	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err);
+	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err.errseq);
 }
 
 extern int vfs_fsync_range(struct file *file, loff_t start, loff_t end,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d5570deff400..1779eee01e34 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -56,7 +56,7 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 
 	/* Record it in superblock */
 	if (mapping->host)
-		errseq_set(&mapping->host->i_sb->s_wb_err, error);
+		errseq_set(&mapping->host->i_sb->s_wb_err.errseq, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..d555e7fc18d2 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -41,23 +41,9 @@
 /* The lowest bit of the counter */
 #define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
 
-/**
- * errseq_set - set a errseq_t for later reporting
- * @eseq: errseq_t field that should be set
- * @err: error to set (must be between -1 and -MAX_ERRNO)
- *
- * This function sets the error in @eseq, and increments the sequence counter
- * if the last sequence was sampled at some point in the past.
- *
- * Any error set will always overwrite an existing error.
- *
- * Return: The previous value, primarily for debugging purposes. The
- * return value should not be used as a previously sampled value in later
- * calls as it will not have the SEEN flag set.
- */
-errseq_t errseq_set(errseq_t *eseq, int err)
+static errseq_t __errseq_set(errseq_t old, errseq_t *eseq, int err)
 {
-	errseq_t cur, old;
+	errseq_t cur;
 
 	/* MAX_ERRNO must be able to serve as a mask */
 	BUILD_BUG_ON_NOT_POWER_OF_2(MAX_ERRNO + 1);
@@ -68,8 +54,6 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 	 * also don't accept zero here as that would effectively clear a
 	 * previous error.
 	 */
-	old = READ_ONCE(*eseq);
-
 	if (WARN(unlikely(err == 0 || (unsigned int)-err > MAX_ERRNO),
 				"err = %d\n", err))
 		return old;
@@ -105,8 +89,66 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 	}
 	return cur;
 }
+
+/**
+ * errseq_set - set a errseq_t for later reporting
+ * @eseq: errseq_t field that should be set
+ * @err: error to set (must be between -1 and -MAX_ERRNO)
+ *
+ * This function sets the error in @eseq, and increments the sequence counter
+ * if the last sequence was sampled at some point in the past.
+ *
+ * Any error set will always overwrite an existing error.
+ *
+ * Return: The previous value, primarily for debugging purposes. The
+ * return value should not be used as a previously sampled value in later
+ * calls as it will not have the SEEN flag set.
+ */
+errseq_t errseq_set(errseq_t *eseq, int err)
+{
+	errseq_t old = READ_ONCE(*eseq);
+
+	return __errseq_set(old, eseq, err);
+}
 EXPORT_SYMBOL(errseq_set);
 
+/**
+ * errseq_counter_set - set an errseq_counter for later reporting
+ * @counter: errseq_counter that should be set
+ * @err: error to set (must be between -1 and -MAX_ERRNO)
+ *
+ * This function follows same semantics as errseq_set(), but if the error
+ * has not been seen, it will increment the errors, allowing a subscriber to
+ * determine is any errors have occurred since they sampled the errseq_counter.
+ *
+ * Return: The same value as errseq_set
+ */
+errseq_t errseq_counter_set(struct errseq_counter *counter, int err)
+{
+	errseq_t new, old;
+
+	old = READ_ONCE(counter->errseq);
+	new = __errseq_set(old, &counter->errseq, err);
+
+	if (new == old) {
+		/*
+		 * When the observer checks if counters is incremented, then
+		 * will then retrieve the error from the errseq itself,
+		 * therefore we have to ensure that the error in errseq is
+		 * visible before errors is incremented.
+		 *
+		 * If errors and errseq ar both read, a read barrier is required
+		 * to preserve this ordering.
+		 */
+		smp_mb__before_atomic();
+		atomic_inc(&counter->errors);
+	}
+
+	return new;
+}
+EXPORT_SYMBOL(errseq_counter_set);
+
+
 /**
  * errseq_sample() - Grab current errseq_t value.
  * @eseq: Pointer to errseq_t to be sampled.
-- 
2.25.1

