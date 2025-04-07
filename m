Return-Path: <linux-fsdevel+bounces-45852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27BA7DA77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DECA16F576
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E6235347;
	Mon,  7 Apr 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvYDptvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC1230BE3
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019693; cv=none; b=YKzZX7RPvWWEV9nWn+4u1ogOBUVguZS4h/rxwuv4zV9XxTzl8v7GdkwMeXHiEFptTeuEykXy22+xHvuCbglsviIhPkXmVoEDHSHn/xFDwNdAEhW2EqaKzgKnnI6EH4cWYjleS94wuTUTrIOz7i788zgRCjMQMXBKMXO538W4K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019693; c=relaxed/simple;
	bh=DXlx/3Lt1kFti0JEDO90iwULh4FPbpKzGHeQy9Zsv90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdQwvtHuMcxZCPioEe9HG5fAwumUKhLWn1ld6WuY6tuzUbVKaRgyxw1uq6n0pckL6w2cTu8J8UGKTm6DVgTMQkZlVzO6MJgfgDpi4DfoCBJbYlLfuDMa5H3NIvNLHOfKEE9YmCgOB7sZ5Ro+bTUe2vjjyi1KKnaIr6VmJZXzgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvYDptvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B9DC4CEE9;
	Mon,  7 Apr 2025 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019693;
	bh=DXlx/3Lt1kFti0JEDO90iwULh4FPbpKzGHeQy9Zsv90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvYDptvMLtgYR1O4WxRF+biNe9hFgZsxW7xU6gjkrmfLc3NHXCjWfAJdU0ujmQeo4
	 2Ml/WMDfHSEbD1kSr1q88cCmhBk+WLhWXMkV89hfvkcqFUZABjWS+5rqohevXHI2OE
	 rfkNn+wMpnIB8GY8FBVFWnOczcs0XEy82uq7+f7ZGb4ja/wjITfig2tzka2wNOypV3
	 y5mwYMMaaxv9Gt9X4fF0MbmXDRYc/kUSnsXU4JvP2qj0/9HxLOwjME3qqk2vxII9Ws
	 yNPZHnLz98mf7tmTs+Ey1Iiyq4tfXYRNDqV8WssqDlVpUVXIcCDt//aKUfA5fO3GLc
	 RzpTYz7hoY8cQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:20 +0200
Subject: [PATCH 6/9] selftests/filesystems: add first test for anonymous
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-6-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DXlx/3Lt1kFti0JEDO90iwULh4FPbpKzGHeQy9Zsv90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnDdO8N++cbWZe/T2Q+IbqmMYn8V2hXKt54jddEN/
 eyar9YSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ/Jjhn+Hl3e9DduWf+e5y
 KHJb1/bE/ZNNXiw7taZuWv6aRU929isyMqy0+Gpc/bL/YIjuruDgYysOOFvfEVF0fjlJjC9FKDt
 gOgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that anonymous inodes cannot be chown()ed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore     |  1 +
 tools/testing/selftests/filesystems/Makefile       |  2 +-
 .../selftests/filesystems/anon_inode_test.c        | 26 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 828b66a10c63..7afa58e2bb20 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -2,3 +2,4 @@
 dnotify_test
 devpts_pts
 file_stressor
+anon_inode_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 66305fc34c60..b02326193fee 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
new file mode 100644
index 000000000000..f2cae8f1ccae
--- /dev/null
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/stat.h>
+
+#include "../kselftest_harness.h"
+#include "overlayfs/wrappers.h"
+
+TEST(anon_inode_no_chown)
+{
+	int fd_context;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_LT(fchown(fd_context, 1234, 5678), 0);
+	ASSERT_EQ(errno, EOPNOTSUPP);
+
+	EXPECT_EQ(close(fd_context), 0);
+}
+
+TEST_HARNESS_MAIN
+

-- 
2.47.2


