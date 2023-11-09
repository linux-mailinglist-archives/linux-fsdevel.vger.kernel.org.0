Return-Path: <linux-fsdevel+bounces-2648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979917E73BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F2B210EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079338F8E;
	Thu,  9 Nov 2023 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XKa2HVNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46A38DDE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:23 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2854204;
	Thu,  9 Nov 2023 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=scv5oorCJU13Z/yavLrg9Y3mxIkMMv5PMJeDsknaHgU=;
	t=1699565902; x=1700775502; b=XKa2HVNXoLNcVy6ovLVdlyADfafidgPIBBkvJLqNzVTwVFl
	8/th/JGWGudYkvn0xuM25Uj3i6tGZgpY3nHldccFvEWBSOS9hhqQ/WJ7DrkDGclCgBozijbYCN8jg
	/tguvSZqzAjgDEdM0hHlUVJg5UXA+S6XmERW/bN32d3NoFSvspgANVhy60FNh3N9YvWqkr/zLsCuu
	Lx8HINcnTq169EqJ46QlF+1XbfvMfWiP6LXPW0VL6LhDFWTS2ObiYB2g+VXYEe5OU467u+hRZGG3k
	di6iKEHpE5IEohgJPT8sg+VqIyacbzIjVxGuTjAN1H1RtEGdvAwwZvCvV0T2gaNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjD-00000001znF-3lT7;
	Thu, 09 Nov 2023 22:38:20 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 4/6] wifi: cfg80211: add locked debugfs wrappers
Date: Thu,  9 Nov 2023 22:22:56 +0100
Message-ID: <20231109222251.dc646db745f3.I52daf6c4d8f70b5c5c2de7f0918c6748f11f1e8b@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109212251.213873-7-johannes@sipsolutions.net>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add wrappers for debugfs files that should be called with
the wiphy mutex held, while the file is also to be removed
under the wiphy mutex. This could otherwise deadlock when
a file is trying to acquire the wiphy mutex while the code
removing it holds the mutex but waits for the removal.

This actually works by pushing the execution of the read
or write handler to a wiphy work that can be cancelled
using the debugfs cancellation API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  46 ++++++++++++
 net/wireless/debugfs.c | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..4ecfb06c413d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9299,4 +9299,50 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
  */
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+#ifdef CONFIG_CFG80211_DEBUGFS
+/**
+ * wiphy_locked_debugfs_read - do a locked read in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being read
+ * @buf: the buffer to fill and then read from
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy to
+ * @count: read count
+ * @ppos: read position
+ * @handler: the read handler to call (under wiphy lock)
+ * @data: additional data to pass to the read handler
+ */
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data);
+
+/**
+ * wiphy_locked_debugfs_write - do a locked write in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being written to
+ * @buf: the buffer to copy the user data to
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy from
+ * @count: read count
+ * @handler: the write handler to call (under wiphy lock)
+ * @data: additional data to pass to the write handler
+ */
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
+				   char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data);
+#endif
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 0878b162890a..40e49074e2ee 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2009	Luis R. Rodriguez <lrodriguez@atheros.com>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2023 Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -109,3 +110,162 @@ void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 	DEBUGFS_ADD(long_retry_limit);
 	DEBUGFS_ADD(ht40allow_map);
 }
+
+struct debugfs_read_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t bufsize;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_read_work(struct wiphy *wiphy,
+					   struct wiphy_work *work)
+{
+	struct debugfs_read_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->bufsize, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_read_cancel(struct dentry *dentry,
+					     void *data)
+{
+	struct debugfs_read_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data)
+{
+	struct debugfs_read_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.bufsize = bufsize,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_read_cancel,
+		.cancel_data = &work,
+	};
+
+	/* don't leak stack data or whatever */
+	memset(buf, 0, bufsize);
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	if (work.ret < 0)
+		return work.ret;
+
+	if (WARN_ON(work.ret > bufsize))
+		return -EINVAL;
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, work.ret);
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_read);
+
+struct debugfs_write_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t count;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_write_work(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct debugfs_write_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->count, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_write_cancel(struct dentry *dentry,
+					      void *data)
+{
+	struct debugfs_write_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
+				   struct file *file, char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data)
+{
+	struct debugfs_write_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.count = count,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_write_cancel,
+		.cancel_data = &work,
+	};
+
+	/* mostly used for strings so enforce NUL-termination for safety */
+	if (count >= bufsize)
+		return -EINVAL;
+
+	memset(buf, 0, bufsize);
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_write_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	return work.ret;
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_write);
-- 
2.41.0


