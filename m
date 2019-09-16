Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED0B44BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 01:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfIPX4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 19:56:55 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33051 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfIPX4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:56:54 -0400
Received: by mail-pg1-f201.google.com with SMTP id a13so828582pgw.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nv3cd1IYe218SOJZ3rC1Ee+aio0oZ4eC7xZJKuNaKOc=;
        b=e9oyZttDjlw6tCTjIe9uniqS4kOdfIabqbhx1chZejA60M5S0NDjV/PsGhbqgYK7ef
         GAb7Lcq3xoymFXFpjBooWkO09+zmZAckg3+B3WBtTOJ0d0FtLICRIWKxD1VgUWPm6n+S
         eD5y9Ikk6kYgR7JrBVRjRPaQaWncrXsx/5ea4BzV8zEyprpxiExn0bfMdmhiQUPQrke6
         tcUz5kFzHuFVaKcq8rButlqvmJgi3v2ZloJdouSkRQMlF7lLww2PfeueFbsSoj5h978F
         UHoCywQaikvMielqyOYIQ7NlEFhdEH1Cjtk0Nhvj/ZMjMAlJ0yxuOkPKlYKCpHNW9qFb
         njZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nv3cd1IYe218SOJZ3rC1Ee+aio0oZ4eC7xZJKuNaKOc=;
        b=Um4CJmn5ui0JBO1Mn6xdG+Lf6Z77wfhXcjOxRtfWLmj5f2GxhqNhV2YLgRZf7jdwIh
         X6dG06zvIUV1rbc4oTTZCCJqcsFDftxPDG8PGZhZ1G+gQeIBgnsvXPhP9AxccWva2t8u
         hPguRXGYARRR5ewJWhLZb9HNvOFiye89ecnhzHOdwXSSxJP5joMJ32k1Meuu87sXOEmU
         8FxQvlJrmjkiIVQ3mpSpfoGiWVC5URAcIuLG2Ch6nhyeDqNeQT3dbKJhnP2lp8Y4VRRH
         2VlH262p0SXRKJvtYK5x+9NJNttIe1lTkM1UHHjPVEd0NKyIXqDltcrvYaYe0SmaldyB
         EGxg==
X-Gm-Message-State: APjAAAUqJelqK9+ef8wDaO1KaaiE0gpD2Ccd7HHTJ5x28qyRuwpU/v6x
        5h0c/vjvtwPlOGJ4HNc9B3GRZEe3hXI=
X-Google-Smtp-Source: APXvYqz+hphq3WGD6WehGtvk6AFKKPR4czIFl0zAfO/NuPMCoLT4QWM5pH4oEkWl3FGInOapFrpl6SFIi4s=
X-Received: by 2002:a63:d608:: with SMTP id q8mr722520pgg.422.1568678212226;
 Mon, 16 Sep 2019 16:56:52 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:56:41 -0700
Message-Id: <20190916235642.167583-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v3 1/2] fuse: on 64-bit store time in d_fsdata directly
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implements the optimization noted in f75fdf22b0a8 ("fuse: don't use
->d_time"), as the additional memory can be significant. (In particular,
on SLAB configurations this 8-byte alloc becomes 32 bytes). Per-dentry,
this can consume significant memory.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
v3:
 reapplied on fuse/for-next, droping the fuse_request_alloc refactor
 it was already done :) (and account new per-file alloc)

 fs/fuse/dir.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ba0a175d7578..58557d4817e9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -24,11 +24,34 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
+#if BITS_PER_LONG >= 64
+static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
+{
+	entry->d_fsdata = (void *) time;
+}
+
+static inline u64 fuse_dentry_time(const struct dentry *entry)
+{
+	return (u64)entry->d_fsdata;
+}
+
+#else
 union fuse_dentry {
 	u64 time;
 	struct rcu_head rcu;
 };
 
+static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
+{
+	((union fuse_dentry *) dentry->d_fsdata)->time = time;
+}
+
+static inline u64 fuse_dentry_time(const struct dentry *entry)
+{
+	return ((union fuse_dentry *) entry->d_fsdata)->time;
+}
+#endif
+
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
@@ -47,12 +70,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 		spin_unlock(&dentry->d_lock);
 	}
 
-	((union fuse_dentry *) dentry->d_fsdata)->time = time;
-}
-
-static inline u64 fuse_dentry_time(const struct dentry *entry)
-{
-	return ((union fuse_dentry *) entry->d_fsdata)->time;
+	__fuse_dentry_settime(dentry, time);
 }
 
 /*
@@ -258,6 +276,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	goto out;
 }
 
+#if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
 	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
@@ -270,6 +289,7 @@ static void fuse_dentry_release(struct dentry *dentry)
 
 	kfree_rcu(fd, rcu);
 }
+#endif
 
 static int fuse_dentry_delete(const struct dentry *dentry)
 {
@@ -279,13 +299,17 @@ static int fuse_dentry_delete(const struct dentry *dentry)
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
+#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
+#endif
 };
 
 const struct dentry_operations fuse_root_dentry_operations = {
+#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
+#endif
 };
 
 int fuse_valid_type(int m)
-- 
2.23.0.237.gc6a4ce50a0-goog

