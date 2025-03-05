Return-Path: <linux-fsdevel+bounces-43234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08DBA4FB50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEEF188DC5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B812063E5;
	Wed,  5 Mar 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anF5O6ax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE42063DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169336; cv=none; b=JF6gWIYttg1AksHg4NSjgATl5yuSSXIqvobxFvW70Y0yGmQdoGDo6cYfIGymF5mdWv+ZuMDsjin7k1G1sAEBQ3AuN6RwtARF8RuBJ5B8LmHfbx3xoI4YDES6DXhcd7RRbB7SzcatI1o1CsX6g6velv1oB9c93LcSczo99y3igpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169336; c=relaxed/simple;
	bh=09cygfBWafKS4lAMkHha117hVNJDUvnJJYHRqyPblAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKKcHb+jCPdUTwuGknMubCgwvB6QZOltiMySlgBng9eiH0qWSxvhKls5zWA5QCLL04WVDOlgzdBIwQSzJnyk9MWhBSUErG8v3ZdAfyOo6KB9R/jyvafBeWmAv3FrZqvWjEtWgQJCBY5R8g0El/BGMPIIZjfZL2SPK6n7E/XwTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anF5O6ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8470AC4CEE2;
	Wed,  5 Mar 2025 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169336;
	bh=09cygfBWafKS4lAMkHha117hVNJDUvnJJYHRqyPblAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anF5O6ax9UhrVbvRCvjAVOIDpH9u/r834e5Y5YM+1d8RA1mkxwkkayohMRVRJN01s
	 RoR5UqolM6GuDBQQm6muLSQubDlpwjO37uW9tukQ9BrYpznjPhrbvlf39mmgBEh4D0
	 UJQqtQuobgCxU8TMIkiYh55p0ieio7PRtqi2dqlGG3ZR3J81m/Lv0YJx/bGygyK/bu
	 +THr/tKduY/CzFnXEaG5velZigHHyCRW/U5Vb1jxgiL3GGZoPq5nfzILgb8sG8ZFTO
	 EVvVDBwJNE/e+1AXjz0HofQE44q3wajZ5PKXYye3SdHvukB/smCcRLxtC6sg0rOHm9
	 nRmY2bJd1PaUg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:24 +0100
Subject: [PATCH v3 14/16] selftests/pidfd: add fifth PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-14-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org;
 h=from:subject:message-id; bh=09cygfBWafKS4lAMkHha117hVNJDUvnJJYHRqyPblAo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqRlpoVs6I0yMDnzg7Jw1L2S6c8PZPDJReuxao1Q
 YXXeGltRwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ07jH8eD2LlWny+h+BCw14
 n//XvsTFytS0oTa6R51B7/MEWddcRobf6Us/Oupd3KAYdiXxy9E5jKcj6hw3hXx9/sDT9PzdZyk
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-14-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 0d0af4c2a84d..16e4be2364df 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -195,4 +195,27 @@ TEST_F(pidfd_info, success_reaped)
 	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
 }
 
+TEST_F(pidfd_info, success_reaped_poll)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
+	};
+	struct pollfd fds = {};
+	int nevents;
+
+	fds.events = POLLIN;
+	fds.fd = self->child_pidfd2;
+
+	nevents = poll(&fds, 1, -1);
+	ASSERT_EQ(nevents, 1);
+	ASSERT_TRUE(!!(fds.revents & POLLIN));
+	ASSERT_TRUE(!!(fds.revents & POLLHUP));
+
+	ASSERT_EQ(ioctl(self->child_pidfd2, PIDFD_GET_INFO, &info), 0);
+	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


