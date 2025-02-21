Return-Path: <linux-fsdevel+bounces-42238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B4A3F5AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1725F188E637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769520FAAD;
	Fri, 21 Feb 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2HaJpEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B6212B1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143640; cv=none; b=hlOUXtUd/Von6eBxj2nIBudjm/zvYOLHUXGyQkhg2eTIVCa54ibmefLAFbw9i1cfGAEZoHA9ufeOPiA5x3wuFWljpNcskueJ6taArOGvmUeZWgpPBHj5WhhyUNnPci/l9Gt/z8QJ1c93p2Joiuo0o5O5nYz0hFlT6adeXhhOZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143640; c=relaxed/simple;
	bh=r2N4D0GiQ07/7EMtDn1xGmcQj4DqX+f2azS2ymAhUhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hhg5+2NeETl7fMJ9QQQ4ca0z7tVow37zMiCb0gLSpN/hnsmEOEHGY9CKSB4osoPvcU5esN+6/qvofar3DkJhZ0/CfSz3OamW/0oQeP3Kx+rEioDbnzp3erj66ygK19TDK8mV1S5+viIk71OTlMIT2SOVYi0I5v0VGhDwZu0clxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2HaJpEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B389C4CEE4;
	Fri, 21 Feb 2025 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143640;
	bh=r2N4D0GiQ07/7EMtDn1xGmcQj4DqX+f2azS2ymAhUhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o2HaJpEn/YvAWWojmKyRSPYauC/EHY2vxFzz0FQ6vKsOlClgBnW97mBfmdTyFHTCb
	 cpYxkQmuntg1M7jZpDqawV+G8jQ4EAtPf7ulBk/buePv7zuv40bMhL+qw59J0qQHMd
	 x7XOqDwmxdyZ5p+DkYSWowYuMxOODxjKNh/3jYlbkEqm4XBaexqDK9cuRNcaW5/nAP
	 2WeL9yMquxfIB4X9zl4dGGY7GxVgTuYeC43mJRGFjyPu44Sx9in4KOqmIVbs+9U4gB
	 kx4Pth02b3n2QtMvrpqHw+p+Ej2K9/ty9jTLPfgkmm5MKwE2y37JsNp+ijPCvX9B7x
	 qjWZnAaLen+5Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:12 +0100
Subject: [PATCH RFC 13/16] selftests: fourth test for mounting detached
 mounts onto detached mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-13-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r2N4D0GiQ07/7EMtDn1xGmcQj4DqX+f2azS2ymAhUhw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP69Mk+wcfKF04xcb9wcGlZeeyCezn13emqx9Y8Cl
 7qHJy+FdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkWyXD/2SZvN1ntPdpFVhP
 U9ijkL79Zl7Xpmni4Y/0PuxaMUFX0Jfhf/n3qqBrAk9qw+akcUufcWG92x1/QdBIgzVKZ5+dp/8
 5NgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a test to verify that detached mounts behave correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 66eed84c6a01..0ee4e5b27c68 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1909,4 +1909,34 @@ TEST_F(mount_setattr, move_mount_detached_fail)
 	EXPECT_EQ(close(fd_tree_subdir), 0);
 }
 
+TEST_F(mount_setattr, attach_detached_mount_then_umount_then_close)
+{
+	int fd_tree = -EBADF;
+	struct statx stx;
+
+	fd_tree = sys_open_tree(-EBADF, "/mnt",
+				AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW |
+				AT_RECURSIVE | OPEN_TREE_CLOEXEC |
+				OPEN_TREE_CLONE);
+	ASSERT_GE(fd_tree, 0);
+
+	ASSERT_EQ(statx(fd_tree, "A", 0, 0, &stx), 0);
+	/* We copied with AT_RECURSIVE so /mnt/A must be a mountpoint. */
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	/* Attach the mount to the caller's mount namespace. */
+	ASSERT_EQ(move_mount(fd_tree, "", -EBADF, "/tmp/target1", MOVE_MOUNT_F_EMPTY_PATH), 0);
+
+	ASSERT_EQ(statx(-EBADF, "/tmp/target1", 0, 0, &stx), 0);
+	ASSERT_TRUE(stx.stx_attributes & STATX_ATTR_MOUNT_ROOT);
+
+	ASSERT_EQ(umount2("/tmp/target1", MNT_DETACH), 0);
+
+	/*
+	 * This tests whether dissolve_on_fput() handles a NULL mount
+	 * namespace correctly, i.e., that it doesn't splat.
+	 */
+	EXPECT_EQ(close(fd_tree), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


