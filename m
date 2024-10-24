Return-Path: <linux-fsdevel+bounces-32720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB09AE172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BE71C22224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469EF1BFE10;
	Thu, 24 Oct 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YFIJTi2K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83111166F06;
	Thu, 24 Oct 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763457; cv=none; b=AYBHwfHYOZoB9hOQQQPGiDEsShvQ0oTxgJRlRzT5wOStsDC6kps+9mp8Cl0F8vxeIZR8bLXN2QpCIrRlmE2l7g+wRwcgPbyzUwnrcREc+u5+lWtsjuWC9bahwiNgVSx12npKIhITenhYwPdCv+qfMJdHROpfCWRX1PI1LOxaAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763457; c=relaxed/simple;
	bh=VFDE1tHi17lScaNlZuPKqEJsg42bx6ZgcU0VKpO8BkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8AxLT6IcJwL/K0ZVXvAW43Yw/pcMYjIaw4/EipLIlgx6uepmAmGNlcrHEywLswz3izQ+mBJWroZim1nlWA4Gracdn4XZUyemOTvzseSOqLZfG7DpvPbb2+dD+6d9Kx1lMaY1euegkvD4aIBJGKJJI2I6FdwFhHr2A215w3ZCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YFIJTi2K; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uktMf
	MyMgHHjf+RcAZFlbgUfr7tyC8vBRpGrG/gVjDo=; b=YFIJTi2KQPQhTn3q+CpZQ
	wEVdb94Gb8iSxspJ6ku/snLGGtvSzUIlRymC0pmGRaagRk/vfrwuwo7RFkKDrkhl
	uKw4d664+YpnRHaPW0nQaboF041ayiGuPK9Qh39SEUqWWGfH+54dnxbFYpXodaXx
	YNpxO3yOjWJeS7ohw9dgcg=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n+JmGBpn1XkfBA--.21511S2;
	Thu, 24 Oct 2024 17:50:31 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	sforshee@kernel.org,
	shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] selftests/mount_setattr: fix idmap_mount_tree_invalid failed to run
Date: Thu, 24 Oct 2024 17:50:13 +0800
Message-Id: <20241024095013.1213852-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n+JmGBpn1XkfBA--.21511S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1xJw17Kry3Aw4UJFW8JFb_yoW8Zw1DpF
	WrXFnFkrWSgF12gF17A3Z5Z3WIqrZxZa17Gr93Wry5AFsrGrn2qa4SkFyjqry2kFyjqrWr
	Zrn3Xw15XFsIyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_DGOUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiRRiCJmcaEJ6T6AAAsx

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

Ramfs is mounted at "/mnt/B" and does not support idmap mounts.
So we can use "/mnt/B" instead of "/mnt/A" to make the test run
successfully with the following output:

 # Starting 1 tests from 1 test cases.
 #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
 #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
 ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
 # PASSED: 1 / 1 tests passed.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..54552c19bc24 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1414,7 +1414,7 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
 	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
 
-	open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/B",
 				     AT_RECURSIVE |
 				     AT_EMPTY_PATH |
 				     AT_NO_AUTOMOUNT |
-- 
2.27.0


