Return-Path: <linux-fsdevel+bounces-53968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419AAF9984
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08BA1C8428F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E612D8361;
	Fri,  4 Jul 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E8yL3vGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE362D8369
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649252; cv=none; b=JUURcE8ybjeyL73tKbQK4qrhs2NK9m6oBXSZHRIxIbI8J3X4V+Gjp0uTrgZalcMxkImFX3/QReoH2iNAuyrmdFtY7yDK0EZrhr7pPQTvyyd7s79B5s5qtEYMR9PPG8sHrMYeNHHpsIkCU71am9DTBkR09WiA7oFaCWtIreMjkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649252; c=relaxed/simple;
	bh=mF0Ld24Ox8jElEpW8jFQ9uimGtaO+xA1ABV+LLyeOKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SKPRnE/DbVdqm9+kjf3CmZWCP3H9KdUdYWM1Qt0kqZ95mvY9SMKewwzsJVXyN35uUSgV/bKBWuOSaup7+L9/XNC0UipFpIE3SeciBqdmypaMjm2mvWbKngomGjpghaVFv8w54xJBvpCJACw3unFAgVq/uBkL2gvebg+8jEdXS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E8yL3vGh; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bYgGN6cGbzXhC;
	Fri,  4 Jul 2025 19:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751649244;
	bh=K4ElhYNB/0QwQ65XpwoZgfAHS/upJtR69NR6tzwtv98=;
	h=From:To:Cc:Subject:Date:From;
	b=E8yL3vGhSNpAeI+IFC6N09PiVrBYCyT0irRxVWtqHnfenL/XPVNaU9ydKy6mm1Sw7
	 1GFhH83MNibS0rOcut2bzq27qOC44c6Td5zoTDZPBGFj4PWJBGtjaNIbHq6P/Djksm
	 qQCuuzEhZu4QlzNmRq1djFRSfEFXBMXwHvKvGxfw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bYgGN0WcKzYVZ;
	Fri,  4 Jul 2025 19:14:03 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	v9fs@lists.linux.dev,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v1] selftests/landlock: Add 9p and FUSE filesystem tests
Date: Fri,  4 Jul 2025 19:13:42 +0200
Message-ID: <20250704171345.1393451-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

FUSE is already supported but v9fs requires some fixes [1].

These tests require /mnt/test-v9fs and /mnt/test-fuse to be already
mounted.  It would be too complex to set up such mount points with the
test fixtures because of the related daemons' lifetime, but it is easy
to run these tests with check-linux.sh from landlock-test-tools [2].

Add new kernel configurations to support these two new filesystems.

Rename and update path_is_fs() to take a path as argument.

Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/cover.1743971855.git.m@maowtm.org [1]
Link: https://github.com/landlock-lsm/landlock-test-tools/pull/21 [2]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/config    |  5 +++
 tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++----
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 8fe9b461b1fd..02427db3cb7b 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,13 +1,18 @@
+CONFIG_9P_FS=y
 CONFIG_AF_UNIX_OOB=y
 CONFIG_AUDIT=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_FUSE_FS=y
 CONFIG_INET=y
 CONFIG_IPV6=y
 CONFIG_KEYS=y
 CONFIG_MPTCP=y
 CONFIG_MPTCP_IPV6=y
 CONFIG_NET=y
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_FD=y
 CONFIG_NET_NS=y
 CONFIG_OVERLAY_FS=y
 CONFIG_PROC_FS=y
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 73729382d40f..788fa030cbe3 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -176,15 +176,19 @@ static bool supports_filesystem(const char *const filesystem)
 	return res;
 }
 
-static bool cwd_matches_fs(unsigned int fs_magic)
+static bool path_is_fs(const char *path, unsigned int fs_magic)
 {
 	struct statfs statfs_buf;
 
-	if (!fs_magic)
+	if (!fs_magic || !path)
 		return true;
 
-	if (statfs(".", &statfs_buf))
-		return true;
+	/* Hack for the hostfs test because TMP_DIR doesn't exist yet. */
+	if (strcmp(path, TMP_DIR) == 0)
+		path = ".";
+
+	if (statfs(path, &statfs_buf))
+		return false;
 
 	return statfs_buf.f_type == fs_magic;
 }
@@ -5294,7 +5298,7 @@ FIXTURE_VARIANT(layout3_fs)
 {
 	const struct mnt_opt mnt;
 	const char *const file_path;
-	unsigned int cwd_fs_magic;
+	unsigned int fs_magic;
 };
 
 /* clang-format off */
@@ -5342,7 +5346,34 @@ FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
 		.flags = MS_BIND,
 	},
 	.file_path = TMP_DIR "/dir/file",
-	.cwd_fs_magic = HOSTFS_SUPER_MAGIC,
+	.fs_magic = HOSTFS_SUPER_MAGIC,
+};
+
+/*
+ * This test requires a mounted 9p filesystem e.g., with:
+ * diod -n -l 127.0.0.1:564 -e /mnt/test-v9fs-src
+ * mount.diod -n 127.0.0.1:/mnt/test-v9fs-src /mnt/test-v9fs
+ */
+FIXTURE_VARIANT_ADD(layout3_fs, v9fs) {
+	.mnt = {
+		.source = "/mnt/test-v9fs",
+		.flags = MS_BIND,
+	},
+	.file_path = TMP_DIR "/dir/file",
+	.fs_magic = V9FS_MAGIC,
+};
+
+/*
+ * This test requires a mounted FUSE filesystem e.g., with:
+ * bindfs /mnt/test-fuse-src /mnt/test-fuse
+ */
+FIXTURE_VARIANT_ADD(layout3_fs, fuse) {
+	.mnt = {
+		.source = "/mnt/test-fuse",
+		.flags = MS_BIND,
+	},
+	.file_path = TMP_DIR "/dir/file",
+	.fs_magic = FUSE_SUPER_MAGIC,
 };
 
 static char *dirname_alloc(const char *path)
@@ -5365,7 +5396,7 @@ FIXTURE_SETUP(layout3_fs)
 	char *dir_path = dirname_alloc(variant->file_path);
 
 	if (!supports_filesystem(variant->mnt.type) ||
-	    !cwd_matches_fs(variant->cwd_fs_magic)) {
+	    !path_is_fs(variant->mnt.source, variant->fs_magic)) {
 		self->skip_test = true;
 		SKIP(return, "this filesystem is not supported (setup)");
 	}
-- 
2.50.0


