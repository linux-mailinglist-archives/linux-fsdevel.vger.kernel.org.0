Return-Path: <linux-fsdevel+bounces-42237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CDA3F59F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A07C86345D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7417212B05;
	Fri, 21 Feb 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ampFzA+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8C211A34
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143639; cv=none; b=s0pc6Qsx26mG5NO9YXrd5bC8E6cT4EumcqCVkPbNwyb45CVv3aDPc3PS7BXegLhG1XYLuvQQj6cm3tB/S4paVVUV7Gknghs1oa12qjueQR8m/IDdpORfq/2bldYYj1QyHY0sSoXfXPxID8A9DYhwCL4gBf6jp6Gt230e1TCBEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143639; c=relaxed/simple;
	bh=IdaZHoyqspeQIqWiK2q6Mp1xak8pva5nTXBx5vOkmFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9AgieRBuPue1lKJzbQGlvHUaEwuxz0q1iOdbbSA/IEACwm0+OYirTd4jUxdUhSRGnRAuh9ep1UOqHjH7BO+/Hk8mKDZ8F6h/UwzlxdmOm6bxcyMEOc+zk6tezRT+oN/vIVyyD3C9IplqVHgtJ1gXPvG82AZWTCbis1yiEK69a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ampFzA+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C61C4CED6;
	Fri, 21 Feb 2025 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143638;
	bh=IdaZHoyqspeQIqWiK2q6Mp1xak8pva5nTXBx5vOkmFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ampFzA+JdNXLBUrDMqtUAnKF37H3zwcuPJ8/6GujxU21eaoBSatzuYM2KeBZ4DM86
	 ADozZaaPyu++VO4OMi4jjqVN17qRfVnTHVpUDUqhwjtmlxu9VLNcNvledUz4FE8uc+
	 Pld+qjdkpGttgc2EbtOlKSxwUJxaXi7Wakb/MIJEJT7/o7CpV6hZDDDLnVq4F0hvnN
	 j3EfL6+tFWPSWS8Eb+GwyGHANCEIueBT/opRyW5YB/JDmzRr76dtHrzFNV2SlxfJUo
	 ekqi0i32eXmQbALKKB+hzDbLAuly/LbBm7RczsyRy8A4J+0gsvFCGqUwDz7/a85Rrx
	 4I54I2UWzmKcA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:11 +0100
Subject: [PATCH RFC 12/16] selftests: third test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-12-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IdaZHoyqspeQIqWiK2q6Mp1xak8pva5nTXBx5vOkmFs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP79SWgj3zqe78uvmrbzsctlTzwfrRH2c6v8tL8+L
 6seW6SLdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkjSbDP8MDKbsz1j+ZaKfZ
 vvjuZo0nluHr2Fj2mihHLVqreHo6syzD/3rvbwp3uy4fKkleXr11U+Xx7dfkf3Q6SEZceKlyd8W
 6uxwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 082fdf19a9be..66eed84c6a01 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1878,4 +1878,35 @@ TEST_F(mount_setattr, mount_detached_mount_on_detached_mount_and_attach)
 	EXPECT_EQ(close(fd_tree_subdir), 0);
 }
 
+TEST_F(mount_setattr, move_mount_detached_fail)
+{
+	int fd_tree_base = -EBADF, fd_tree_subdir = -EBADF;
+	struct statx stx;
+
+	fd_tree_base = sys_open_tree(-EBADF, "/mnt",
+				     AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_base, 0);
+
+	/* Attach the mount to the caller's mount namespace. */
+	ASSERT_EQ(move_mount(fd_tree_base, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	ASSERT_EQ(statx(fd_tree_base, "A", 0, 0, &stx), 0);
+	ASSERT_FALSE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	fd_tree_subdir = sys_open_tree(-EBADF, "/tmp/B",
+				       AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				       OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree_subdir, 0);
+	ASSERT_EQ(statx(fd_tree_subdir, "BB", 0, 0, &stx), 0);
+	ASSERT_FALSE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	/* Not allowed to move an attached mount to a detached mount. */
+	ASSERT_NE(move_mount(fd_tree_base, "", fd_tree_subdir, "", MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	EXPECT_EQ(close(fd_tree_base), 0);
+	EXPECT_EQ(close(fd_tree_subdir), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


