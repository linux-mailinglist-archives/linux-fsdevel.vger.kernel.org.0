Return-Path: <linux-fsdevel+bounces-65891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA9C139D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78C81AA778C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F722DC33D;
	Tue, 28 Oct 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sijCbF9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838E2DAFA1;
	Tue, 28 Oct 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641210; cv=none; b=mFkZK1ob1X7wDKAav7mtjcBZh7rHpdH2mn3qaHfAPInEJrMEy8pi8lqUz1HwdDqWROiryDsvDLaF6pMfLVNXVnFUNap0HY40WGwoKvp/0Rd5eenMVonZOAef+B+xK/3CnrCUbY6Ewy3gXzwsKykURhl9/fswFVWUUBxG/mEsQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641210; c=relaxed/simple;
	bh=2e6DA30gxSXi8cjOewZa+j3/ROxol/MC+sx0d2mHTZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5EqtYBiWPGLv/OduoCu4A5ZnKt/qfXK+2xxXyywKUDtK7/IybFK357rsUE2DOBE2KXgYPONsFDvxfrU4i/IOF6GXYjbvADHAPui1I8ncVg40/LBGVWhYJk2LjA13nP2NmHVK2sAeVZr9VSNoBTsiaVTLeaegYiifSvnH9BsNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sijCbF9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE94C4CEFF;
	Tue, 28 Oct 2025 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641210;
	bh=2e6DA30gxSXi8cjOewZa+j3/ROxol/MC+sx0d2mHTZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sijCbF9Vi7FDmoS+XPuM5PQIG8yjIGkWSbyU9T1ArTM9EztOj0XYFcMjWb0O/RB6i
	 V4NG6cJC0SWokwiBiQnhUj8xadr7SgfZhvJI/IpMLdWKXZxjuwhzaN16f7Jzc56lQ9
	 VRjKjlMw2ksZ08ZYvSIh2q88840wpDpeOnv1ZQpccBYCYj7gNURGwoFw3thkk5wPgH
	 Sdiame94egeioTZgWWpt4URBQ9k07r4uZxMEKQmo9lHTEvCt2EpgDZQT2OyERIDgT3
	 pK/x4Fd3+i+xZZSG1RpiWf2A+zfONJRf9CHOcqC9G5oSeIPI6x03SsEmA3jhOYJshn
	 jxdOd9+iuZRLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:56 +0100
Subject: [PATCH 11/22] selftests/pidfd: add second supported_mask test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-11-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2e6DA30gxSXi8cjOewZa+j3/ROxol/MC+sx0d2mHTZc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB1aeeDoz6KpLzTutFQ85Ziz8zq72A+LEPMdKlfnx
 7zYfWfm7I5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJJAgz/NOfc831scntbnH5
 zQycRkunOsj/FQyaecm/Rir3q5GWrRAjQ9dHtf87D3yNKb75YML95nV+Mo+v28x0XWVkO0PPWP3
 oUkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Verify that supported_mask is returned even when other fields are
requested.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index b31a0597fbae..cb5430a2fd75 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -731,4 +731,36 @@ TEST(supported_mask_field)
 	close(pidfd);
 }
 
+/*
+ * Test: PIDFD_INFO_SUPPORTED_MASK always available
+ *
+ * Verify that supported_mask is returned even when other fields are requested.
+ */
+TEST(supported_mask_with_other_fields)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_SUPPORTED_MASK,
+	};
+	int pidfd;
+	pid_t pid;
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		pause();
+
+	ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
+
+	/* Both fields should be present */
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CGROUPID));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_SUPPORTED_MASK));
+	ASSERT_NE(info.supported_mask, 0);
+
+	/* Clean up */
+	sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	sys_waitid(P_PIDFD, pidfd, NULL, WEXITED);
+	close(pidfd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


