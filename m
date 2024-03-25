Return-Path: <linux-fsdevel+bounces-15196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F788A634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135F7B3AE32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CC15250A;
	Mon, 25 Mar 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDn+FI1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D293154449;
	Mon, 25 Mar 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355736; cv=none; b=UTYIpNJiIJh5CZljilPOQ33VtBpC/bPTtg0/1XuwPbNthhxHbGj+SH0eB2TjAvrSySV+UQkLItVKTosEBFIL/okmkVFpL9yNK1Dyznh2QrDpalwIKEByifQktV99zhL0Ez4lBHPtX5OY3o4mRoSMGuMWom6q5LhMhEBrDgFoDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355736; c=relaxed/simple;
	bh=y59cd9WcJC4gK4HZjgpG4z/0FSdH1Dwax+LQaSel8+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfUZbikwmpbXr0Ivzlg1miwM9rLtP8QlekbMqsngZTCJuPNcuvtuYW+vjOHSjT4uZbxzgocHn0HoyLQq/qYDtrTNXyGb5W879iYrp7KfPcyHQmIJrjuDyfwNwqnc/4L9R6F9s1R9JWwa/N3kEBKadLlPIyQbhdI8w7Vw6DIDmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDn+FI1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6BFC433C7;
	Mon, 25 Mar 2024 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711355735;
	bh=y59cd9WcJC4gK4HZjgpG4z/0FSdH1Dwax+LQaSel8+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDn+FI1STZ/g3WJA/OZUrjJ7wdIdu72tXUh5B0Dx1Er6R8Wbwr4ITxNyZM534YU6C
	 itMiYTHWJgXoYwkx2HI6UD3BS4XwHOsJPcG+BnRakKwmgFD+4bebjE7JuamFB2UuH/
	 75DczSOiRbqcnhiOvDElqXe7pPy3MpnDM4UkZTVjGd6+KmyFPXjIzXYlRKKCBidHZH
	 Ghl583dYq+1e3jwOlk8kADZPl6ATk4OCH/zzxe18sV7UQLac3oZsVe1xwD8yenf7x1
	 Ika9B1qqhdt3rUKK7TD9Zmy6Kw9ujcSdvZwdnLCPlGS6dD7q6gT+AUy46vRHK87/qU
	 7UPoVwR2xEr1A==
From: Christian Brauner <brauner@kernel.org>
To: Johan Hovold <johan@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	ntfs3@lists.linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	regressions@lists.linux.dev
Subject: [PATCH 1/2] ntfs3: serve as alias for the legacy ntfs driver
Date: Mon, 25 Mar 2024 09:34:36 +0100
Message-ID: <20240325-hinkriegen-zuziehen-d7e2c490427a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852; i=brauner@kernel.org; h=from:subject:message-id; bh=ASW+F5BIMFmdhYm8IeYvSAIs5mRF1/bUC6XpI1O2tso=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQxmst5B8oFGGdO+sjXXHt28ov6LXerHsw2+BB5XSHl7 fF890DmjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlodzEyfNdsc91zcd16n1ab jcxV3v4S8+JrLI8xKrtdZbpeXvGSn5HhxfX9Di/OeNzgPFpT8WaV9guR/7NmCqRHv8xIc7B2tDP lAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Johan Hovold reported that removing the legacy ntfs driver broke boot
for him since his fstab uses the legacy ntfs driver to access firmware
from the original Windows partition.

Use ntfs3 as an alias for legacy ntfs if CONFIG_NTFS_FS is selected.
This is similar to how ext3 is treated.

Fixes: 7ffa8f3d3023 ("fs: Remove NTFS classic")
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey,

This is so far compile tested. It would be great if someone could test
this. @Johan?

Thanks!
Christian
---
 fs/ntfs3/Kconfig |  9 +++++++++
 fs/ntfs3/super.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index cdfdf51e55d7..7bc31d69f680 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -46,3 +46,12 @@ config NTFS3_FS_POSIX_ACL
 	  NOTE: this is linux only feature. Windows will ignore these ACLs.
 
 	  If you don't know what Access Control Lists are, say N.
+
+config NTFS_FS
+	tristate "NTFS file system support"
+	select NTFS3_FS
+	select BUFFER_HEAD
+	select NLS
+	help
+	  This config option is here only for backward compatibility. NTFS
+	  filesystem is now handled by the NTFS3 driver.
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9df7c20d066f..8d2e51bae2cb 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1798,6 +1798,35 @@ static struct file_system_type ntfs_fs_type = {
 	.kill_sb		= ntfs3_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
+
+#if IS_ENABLED(CONFIG_NTFS_FS)
+static struct file_system_type ntfs_legacy_fs_type = {
+	.owner			= THIS_MODULE,
+	.name			= "ntfs",
+	.init_fs_context	= ntfs_init_fs_context,
+	.parameters		= ntfs_fs_parameters,
+	.kill_sb		= ntfs3_kill_sb,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+};
+MODULE_ALIAS_FS("ntfs");
+
+static inline void register_as_ntfs_legacy(void)
+{
+	int err = register_filesystem(&ntfs_legacy_fs_type);
+	if (err)
+		pr_warn("ntfs3: Failed to register legacy ntfs filesystem driver: %d\n", err);
+}
+
+static inline void unregister_as_ntfs_legacy(void)
+{
+	unregister_filesystem(&ntfs_legacy_fs_type);
+}
+#else
+static inline void register_as_ntfs_legacy(void) {}
+static inline void unregister_as_ntfs_legacy(void) {}
+#endif
+
+
 // clang-format on
 
 static int __init init_ntfs_fs(void)
@@ -1832,6 +1861,7 @@ static int __init init_ntfs_fs(void)
 		goto out1;
 	}
 
+	register_as_ntfs_legacy();
 	err = register_filesystem(&ntfs_fs_type);
 	if (err)
 		goto out;
@@ -1849,6 +1879,7 @@ static void __exit exit_ntfs_fs(void)
 	rcu_barrier();
 	kmem_cache_destroy(ntfs_inode_cachep);
 	unregister_filesystem(&ntfs_fs_type);
+	unregister_as_ntfs_legacy();
 	ntfs3_exit_bitmap();
 
 #ifdef CONFIG_PROC_FS
-- 
2.43.0


