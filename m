Return-Path: <linux-fsdevel+bounces-33043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00099B2A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 09:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B417F281D3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90AA192B9A;
	Mon, 28 Oct 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F2iZHnav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740D19047C;
	Mon, 28 Oct 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104917; cv=none; b=dBl6vSqBu1j1r+E95HGsuZkdfvL0T0nuSTbzPt5sXcIYmtkx2oKwN1i3PKVQ1oJbmF4m5TdUvls8j8poDQFc2d6vtO+silXoKOY74xQLkycfMs9GKenU9/PGtW2GqFdhDsDfstd4o7weSG2mJw8YNKhLlmR9MQ2Lb7EEH9lQN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104917; c=relaxed/simple;
	bh=3lhesesvIgTC2BWMdfyizldhVlm+FDeXLdW8l64uk/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESdxzJbo9LJLyEg3LrS3XYhqMVGVBoIRsMryiU6CjRk5Cz3Rr4UNjKq9GejovajukzBJmZZNNU6oxd3FLFSV43lrdWQTaYLL5bLA7lyAy2fy5+YpGTECEEVB3mMkXumnKl2UW5d/G3LMjurXhMT4nvlZaHLkf/mJ+8yq938vdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F2iZHnav; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dBo2n
	hHZYZTqdc+iAZjp5wx+onsXq9rtmCyqFUSZaVM=; b=F2iZHnavAypLPfjyOC3+H
	LQaDVjrQM9yKRfFMTYzklPwPWHgYCNJX/cWT+U28I/3uTTpV0sRDKwiaVgm0w2IF
	SCNiUVEf+H5H77P1GN+hy5CGdDFs7thG3TXaY20ayJKuaOg6RsNo5968s4R43P9Q
	fzquR6z8dwINjzPJzR4iKM=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHT9c_Th9nQYLKDw--.1205S2;
	Mon, 28 Oct 2024 16:41:36 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	sforshee@kernel.org,
	shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH v2] selftests/mount_setattr: fix idmap_mount_tree_invalid failed to run
Date: Mon, 28 Oct 2024 16:41:32 +0800
Message-Id: <20241028084132.3212598-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHT9c_Th9nQYLKDw--.1205S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4DXFW5uFW7Cr17Gw13twb_yoW5Gry3pa
	yrXanFkrWFgF17WF13A3Z5Z3WIqrsxua1UJr93Wry5AFsrCFnFqa4SkFyjqry7KFWqqrWr
	urn5X3W5JFsxtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMMKNUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYB+GJmcfRG7qawAAsM

From: zhouyuhang <zhouyuhang@kylinos.cn>

Test case idmap_mount_tree_invalid failed to run on the newer kernel
with the following output:

 #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
 # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,  sizeof(attr)) (0) ! = 0 (0)
 # idmap_mount_tree_invalid: Test terminated by assertion

This is because tmpfs is mounted at "/mnt/A", and tmpfs already
contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
returns 0 instead of -EINVAL as expected.

Ramfs does not support idmap mounts, so we can use it here to test invalid mounts,
which allows the test case to pass with the following output:

 # Starting 1 tests from 1 test cases.
 #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
 #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
 ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
 # PASSED: 1 / 1 tests passed.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
 .../testing/selftests/mount_setattr/mount_setattr_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..68801e1a9ec2 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1414,6 +1414,13 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
 	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
 
+	ASSERT_EQ(mount("testing", "/mnt/A", "ramfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/mnt/A/AA", 0777), 0);
+
+	ASSERT_EQ(mount("/tmp", "/mnt/A/AA", NULL, MS_BIND | MS_REC, NULL), 0);
+
 	open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
 				     AT_RECURSIVE |
 				     AT_EMPTY_PATH |
@@ -1433,6 +1440,8 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
 	ASSERT_EQ(expected_uid_gid(open_tree_fd, "B/b", 0, 0, 0), 0);
 	ASSERT_EQ(expected_uid_gid(open_tree_fd, "B/BB/b", 0, 0, 0), 0);
+
+	(void)umount2("/mnt/A", MNT_DETACH);
 }
 
 TEST_F(mount_setattr, mount_attr_nosymfollow)
-- 
2.27.0


