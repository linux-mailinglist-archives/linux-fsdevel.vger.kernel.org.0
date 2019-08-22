Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE90898854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 02:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfHVAJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:09:56 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:41689 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfHVAJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:09:56 -0400
Received: by mail-vs1-f74.google.com with SMTP id k1so1358803vsq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pv63BqJG13E00+xwd/kF1jAWY+UxyXW33fdXaIG0kq8=;
        b=D6AQoA1ldI7Td2oaG347F6IipHY5tct5IVr+ZroY46wc2oeOBig9h8SX4dVUwbmpkk
         wJ9SvoTKVLRLyS0KQGzGDBHsHrzk7paM9h/bx2REKW+54BkeqdsWziITIIAgHqJqmgeI
         Fttd73tnUVn7lBOt4rStJQHq4ekEuATA+hFFL3ytj+VuWFykDfR4/Uv1hTrOiehHHXFq
         J6NvzzRX9hadxjvziCkeZI5JP4NdeJOigPiTCkAOOX2LJcLP/GWAjDKL+UqcTpy1wFay
         5bOjifnewYNs0sm+ha3kwdNZYvK1/4Ye3s2j1ZCKveddw1LJGk3scOM0xNfySseyHuuN
         Fa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pv63BqJG13E00+xwd/kF1jAWY+UxyXW33fdXaIG0kq8=;
        b=cVXWVR9A670F2DocHPLcMzUwmrRURjjZb4iLoQJLdn27y8PTEJhIsmwXs/un/W1Nuv
         bMfvSwMj5wVOEXhQrZ6aleNKH2BgvLyPNuJOD7EK2WuFcMk3G+rRhZINnT8IYkluYRq2
         JCaIcbUxOpQKupkZuYzYP+Cw1xqwqaxQnoqpjWyhuvawIs+KHCVL1r09kHs5DLFoNPgp
         6LzW+cFiKpOuz/pgJwMy2loXqvGf23tTtHeRwd3Ct4bkYiTbsm6yCHgrUozNcEAELBPQ
         fyMN/CG+zJC73hvKufYEKBgCe6bE22LgFg0PJDUHwmwUIpingV9ZHiSbFcpItrHBuz26
         LIUw==
X-Gm-Message-State: APjAAAWvT5w9JVnsE8qUfJQs6LJjBD/bRz2Sb5PHsO71RdbHHDX73jqB
        doixoHhqyy2pFw9JMLHHjdOkMECZ6Vo=
X-Google-Smtp-Source: APXvYqwm9+jVtbSYDQW7U2by/dHV3bsRwuVzMr7tlKUcqfS6l0SD4nj4sPXvOx6Hn1BrOVmcOdvhza1U1h0=
X-Received: by 2002:a9f:3110:: with SMTP id m16mr4238732uab.10.1566432594812;
 Wed, 21 Aug 2019 17:09:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 17:09:31 -0700
Message-Id: <20190822000933.180870-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 1/3] fuse: on 64-bit store time in d_fsdata directly
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

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dir.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f7bc06..f9c59a296568 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -24,6 +24,18 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
+#if BITS_PER_LONG >= 64
+static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+{
+	entry->d_fsdata = (void *) time;
+}
+
+static inline u64 fuse_dentry_time(struct dentry *entry)
+{
+	return (u64)entry->d_fsdata;
+}
+
+#else
 union fuse_dentry {
 	u64 time;
 	struct rcu_head rcu;
@@ -38,6 +50,7 @@ static inline u64 fuse_dentry_time(struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
+#endif
 
 /*
  * FUSE caches dentries and attributes with separate timeout.  The
@@ -242,6 +255,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	goto out;
 }
 
+#if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
 	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
@@ -254,16 +268,21 @@ static void fuse_dentry_release(struct dentry *dentry)
 
 	kfree_rcu(fd, rcu);
 }
+#endif
 
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
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
2.23.0.187.g17f5b7556c-goog

