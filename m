Return-Path: <linux-fsdevel+bounces-42088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F9A3C53F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5273173D47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFA1FF1DB;
	Wed, 19 Feb 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3aJgm8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFD1FF1AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983237; cv=none; b=YRzJMpr2Tyq7GzWWGLKTzy4Rs+/PVrYZpuD1Ds+wmvRfrobOx10Qa4rkaO3yZTV9uCmoJ/ocI2YCWsNCw9kzxQUq10UMQPY99FD7ofBDgM6yR2wpDr7a6frZxqC9b+VqmQkLWkdA1PjXGRzc3uwrR8McGacHbJagsP3JDQIiOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983237; c=relaxed/simple;
	bh=orMNLViW9VTdDNmc79yiPw1GaHmbQr6xQ8Q5nB4MXCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKnoh2EsLC0QN/R37pWi/wCv2zf1aJAfp2QJy4uYyttggr689PVaKIIshNOCKyY/XqU+DUjygfiS8qwv1/Ep/1NaQLUaitPaZm0DIMkIirZG4cnlnHMFawimJkpqwooE0EzwPHkF9WyV9SKoNexn2ywSzGbCEqRI4fIVIj/jzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3aJgm8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3914C4CED1;
	Wed, 19 Feb 2025 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739983236;
	bh=orMNLViW9VTdDNmc79yiPw1GaHmbQr6xQ8Q5nB4MXCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m3aJgm8BpxuHM784DRktBhLNPZJ36Y7rGkj/TIt99Nsp0vv1qxBpF4zFscrRFYGE4
	 YbmYaD5hBBnKgADTGZizkTz9AXP1GG2jlc1/R4P2ED7pv0lA+dCDdP6WkZOwZs5a6c
	 9AuHdpxZJjaA0ScJeeOp63mKuZMY8Q+XuLBWZSD/V5adx626/xt1w2+3gNKngJGyIe
	 NsPb6WIqe4Qk67u4MLURpNE7o7/1VoMiYivOvZDNAdy1xtO1HQyo3/B4N4MBWqZedA
	 0zjDm/THzcBAZsiPWys/51hYYH6g2l7gWmQa+XPGZAy1o5lcSO5wKUEP5JkaUG60ZG
	 Bez7pXr0HhKvg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Feb 2025 17:40:29 +0100
Subject: [PATCH 2/2] selftests/nsfs: add ioctl validation tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-work-nsfs-v1-2-21128d73c5e8@kernel.org>
References: <20250219-work-nsfs-v1-0-21128d73c5e8@kernel.org>
In-Reply-To: <20250219-work-nsfs-v1-0-21128d73c5e8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=brauner@kernel.org;
 h=from:subject:message-id; bh=orMNLViW9VTdDNmc79yiPw1GaHmbQr6xQ8Q5nB4MXCs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv42yYoTD5EePern7lqk3he67FVNfLCB2cevzEputSz
 35lMmz60lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAnCTDRkZnmadn+vx0aJV7Kes
 1SbNZd/mXsvbmjuPdZtE3PZjEcqBCxgZrq92cXh7bg6DYl3Sh8wl37e6ez9Xf7dwZ2Ie98ZLqzf
 mcQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add simple tests to validate that non-nsfs ioctls are rejected.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
index 457cf76f3c5f..a3d8015897e9 100644
--- a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
+++ b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
@@ -3,6 +3,8 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
+#include <linux/auto_dev-ioctl.h>
+#include <linux/errno.h>
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
@@ -146,4 +148,16 @@ TEST_F(iterate_mount_namespaces, iterate_backward)
 	}
 }
 
+TEST_F(iterate_mount_namespaces, nfs_valid_ioctl)
+{
+	ASSERT_NE(ioctl(self->fd_mnt_ns[0], AUTOFS_DEV_IOCTL_OPENMOUNT, NULL), 0);
+	ASSERT_EQ(errno, ENOTTY);
+
+	ASSERT_NE(ioctl(self->fd_mnt_ns[0], AUTOFS_DEV_IOCTL_CLOSEMOUNT, NULL), 0);
+	ASSERT_EQ(errno, ENOTTY);
+
+	ASSERT_NE(ioctl(self->fd_mnt_ns[0], AUTOFS_DEV_IOCTL_READY, NULL), 0);
+	ASSERT_EQ(errno, ENOTTY);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


