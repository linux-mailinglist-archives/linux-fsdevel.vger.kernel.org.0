Return-Path: <linux-fsdevel+bounces-43232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FBEA4FB4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F7C1889FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3342066FF;
	Wed,  5 Mar 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOfyB2eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDD01D6DAA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169332; cv=none; b=kvwZ4VU7R8+eU6G03sDVRiYIkHJ8TM42xnPjfiZYSUUXhSDLYnVAONA1sR2lnNqqTqqlw/cI6KpYsq3pxJ5YHcjIy1Fl/bxeuhz8BYKkdG9/ZXwPSLNvvqDYj65JZFhb2Xb4giFwvPovn6PhmU0Tql/iYFaYFKtUIRlvHb9bqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169332; c=relaxed/simple;
	bh=oP9IhwdJs11Q5YuvhKDWEh1JtMVkn6DkC7RkvocNVOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWR7OH6cFqAPZ7zDVI0E7Bsg7YMDWPorsmaEleoARSvx+vZtaasZ8A7loryLLDHl4dmgBQwTNtr/UHuo/rfo4Uutkwtxy7t4Lm5IiFQpTw+MdpqommKYuWVyaZI70DoIfw5l96MBqg2adpV20kgflyZxV1mkBtTHVXD2Rz2s8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOfyB2eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF86C4CEE2;
	Wed,  5 Mar 2025 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169331;
	bh=oP9IhwdJs11Q5YuvhKDWEh1JtMVkn6DkC7RkvocNVOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NOfyB2eBCFr9aghrZXDdSavu5XJaTh5DcyqNhI3zj5KBiuMZkPOq1ftT+hJKo8RqD
	 6tl6m8ly4TlWdO7B6Iy7qjqrpO9q8ZcnJUhNiFLh+/LX95o98183AUZlOChke/49Vw
	 /qJYAGinL/tBpaVNrygXNrPqeJbzfss3FF+m9oymyyOzJUu6ZdWasrvssfuSwrxwmf
	 zYKDMHBFmY9ZxzyhBEGynvzP/5QowdDpbXS1tcnJ+whYSjskyGmdFBINpoWtr8Jk86
	 nww89b0LG2eoblKi0kWwlu2ROFtVLexg8q6olgCvxY/WffThtmrYUuO5Vj4+6jkRWk
	 lEY2N6SFWVMmw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:22 +0100
Subject: [PATCH v3 12/16] selftests/pidfd: add third PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-12-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oP9IhwdJs11Q5YuvhKDWEh1JtMVkn6DkC7RkvocNVOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqx9nhqqsaLy6LKJqndsbNennVf0HFvK8fpvc7ch
 TGKbhN1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSJs7wz/KIwcr+gmesCcdM
 yyLsV7dzeBVnidik63H1H2/y3agaz/A/wDQnPds0tNnl6v1lGl0+y43S38x4eMfscy/nSWvJjaF
 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-12-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 2a5742a2a55f..2917e7a03b31 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -161,4 +161,20 @@ TEST_F(pidfd_info, sigkill_reaped)
 	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
 }
 
+TEST_F(pidfd_info, success_exit)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+	};
+
+	/* Process has exited but not been reaped so this must work. */
+	ASSERT_EQ(ioctl(self->child_pidfd3, PIDFD_GET_INFO, &info), 0);
+
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
+	ASSERT_EQ(ioctl(self->child_pidfd3, PIDFD_GET_INFO, &info), 0);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CREDS));
+	/* Process has exited but not been reaped, so no PIDFD_INFO_EXIT information yet. */
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


