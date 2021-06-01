Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F13974B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFAN5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234017AbhFAN5V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96034613AE;
        Tue,  1 Jun 2021 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622555740;
        bh=YzbBUwDeMWGiT0AR2Br7M/QG3lE0r08fL1CqkfOI1Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLMMrzseo+qKcvcJP7MxC9jTVFWdC93fXZeH5LMSuMV41JHqmfqeqsJbVf8K+mp17
         uu6vT4YbTNQZqJ4bftJvrztPmX0WyaOjTAFgFoJpUT+TWCI960HSNtLbdb/W/SVNsC
         dJJSH54ypc6hpJTAUBVyrQDXosIkLO39zkYOM5gTvqazL7tHXrW2U0k1HKRcRfJYjC
         bd9CbosVBE4/ZTjkpu4vTGRz/jnI/3VOOKfSaSwTsyqIXVy6LECGCuqdXtRyCz6naU
         QWrRHwoQHWIfu1Dg2fFr+tKCFVLm0tIcneM8x+wEuHnrdcKEaCquWWVqSEqqAaTn2J
         BNYfqSHbOlqhw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Ross Zwisler <zwisler@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/2] tests: test MOUNT_ATTR_NOSYMFOLLOW with mount_setattr()
Date:   Tue,  1 Jun 2021 15:55:15 +0200
Message-Id: <20210601135515.126639-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601135515.126639-1-brauner@kernel.org>
References: <20210601135515.126639-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4769; h=from:subject; bh=cpwDOoxglal5Bq5peEgodqurmQKN4mTuqs3drqG2Izc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRss3HQTOZ9Me1x3jzD+U0tWyLat0w2+PTj27XPqstjJG7M XRCs3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAReUuGv5KXT85I+FVyp2Wj3IW4ey sUXf6XvInov/NbXUOmxEiCRYKR4fZXN16u8pQFeyZFaXsUX1mUq7sxO2/T1K1OGooT522r4wMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add tests to verify that MOUNT_ATTR_NOSYMFOLLOW is honored.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Mattias Nissler <mnissler@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ross Zwisler <zwisler@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../mount_setattr/mount_setattr_test.c        | 88 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 4e94e566e040..f31205f04ee0 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -136,6 +136,10 @@ struct mount_attr {
 #define MOUNT_ATTR_IDMAP 0x00100000
 #endif
 
+#ifndef MOUNT_ATTR_NOSYMFOLLOW
+#define MOUNT_ATTR_NOSYMFOLLOW 0x00200000
+#endif
+
 static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
 				    struct mount_attr *attr, size_t size)
 {
@@ -235,6 +239,10 @@ static int prepare_unpriv_mountns(void)
 	return 0;
 }
 
+#ifndef ST_NOSYMFOLLOW
+#define ST_NOSYMFOLLOW 0x2000 /* do not follow symlinks */
+#endif
+
 static int read_mnt_flags(const char *path)
 {
 	int ret;
@@ -245,9 +253,9 @@ static int read_mnt_flags(const char *path)
 	if (ret != 0)
 		return -EINVAL;
 
-	if (stat.f_flag &
-	    ~(ST_RDONLY | ST_NOSUID | ST_NODEV | ST_NOEXEC | ST_NOATIME |
-	      ST_NODIRATIME | ST_RELATIME | ST_SYNCHRONOUS | ST_MANDLOCK))
+	if (stat.f_flag & ~(ST_RDONLY | ST_NOSUID | ST_NODEV | ST_NOEXEC |
+			    ST_NOATIME | ST_NODIRATIME | ST_RELATIME |
+			    ST_SYNCHRONOUS | ST_MANDLOCK | ST_NOSYMFOLLOW))
 		return -EINVAL;
 
 	mnt_flags = 0;
@@ -269,6 +277,8 @@ static int read_mnt_flags(const char *path)
 		mnt_flags |= MS_SYNCHRONOUS;
 	if (stat.f_flag & ST_MANDLOCK)
 		mnt_flags |= ST_MANDLOCK;
+	if (stat.f_flag & ST_NOSYMFOLLOW)
+		mnt_flags |= ST_NOSYMFOLLOW;
 
 	return mnt_flags;
 }
@@ -368,8 +378,13 @@ static bool mount_setattr_supported(void)
 FIXTURE(mount_setattr) {
 };
 
+#define NOSYMFOLLOW_TARGET "/mnt/A/AA/data"
+#define NOSYMFOLLOW_SYMLINK "/mnt/A/AA/symlink"
+
 FIXTURE_SETUP(mount_setattr)
 {
+	int fd = -EBADF;
+
 	if (!mount_setattr_supported())
 		SKIP(return, "mount_setattr syscall not supported");
 
@@ -412,6 +427,11 @@ FIXTURE_SETUP(mount_setattr)
 
 	ASSERT_EQ(mount("testing", "/tmp/B/BB", "devpts",
 			MS_RELATIME | MS_NOEXEC | MS_RDONLY, 0), 0);
+
+	fd = creat(NOSYMFOLLOW_TARGET, O_RDWR | O_CLOEXEC);
+	ASSERT_GT(fd, 0);
+	ASSERT_EQ(symlink(NOSYMFOLLOW_TARGET, NOSYMFOLLOW_SYMLINK), 0);
+	ASSERT_EQ(close(fd), 0);
 }
 
 FIXTURE_TEARDOWN(mount_setattr)
@@ -1421,4 +1441,66 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 	ASSERT_EQ(expected_uid_gid(open_tree_fd, "B/BB/b", 0, 0, 0), 0);
 }
 
+TEST_F(mount_setattr, mount_attr_nosymfollow)
+{
+	int fd;
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_NOSYMFOLLOW,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	fd = open(NOSYMFOLLOW_SYMLINK, O_RDWR | O_CLOEXEC);
+	ASSERT_GT(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags = old_flags;
+	expected_flags |= ST_NOSYMFOLLOW;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	fd = open(NOSYMFOLLOW_SYMLINK, O_RDWR | O_CLOEXEC);
+	ASSERT_LT(fd, 0);
+	ASSERT_EQ(errno, ELOOP);
+
+	attr.attr_set &= ~MOUNT_ATTR_NOSYMFOLLOW;
+	attr.attr_clr |= MOUNT_ATTR_NOSYMFOLLOW;
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags &= ~ST_NOSYMFOLLOW;
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	fd = open(NOSYMFOLLOW_SYMLINK, O_RDWR | O_CLOEXEC);
+	ASSERT_GT(fd, 0);
+	ASSERT_EQ(close(fd), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.27.0

