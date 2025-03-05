Return-Path: <linux-fsdevel+bounces-43231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8CA4FB4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0294C18832AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92402063CA;
	Wed,  5 Mar 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtNt2sXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CE86340
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169330; cv=none; b=mcBy+VFxRULUf2U6I6C/NKXwXAZvxGg4jjj24zRVD9xRwwWS0RxTIvRRgdKkJu/0trnLJvO81EXr4T7VF6N93kMSfnHf0DzRKLrre6RYjcGZ7PDl6gi3aGgLt4e+R6Dy3BN0bPAAvUyPzhE14cr5RwZrK1Q64bVXZ67waJic3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169330; c=relaxed/simple;
	bh=uwTb2pvynGcEgNzKA2n7t8TdmNS33iMLyCP94yRdyUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4Lc8MlRfqVni95WZqIB7itFa2UvSFe6fpr+KQAwuJqyGyysd5slWzHuLQOMvgu77h936MakkAO5Ha6T4v5MVBBDAEl1TOY8bJ7g0w1kYd+5+TaKlibC8DIJ/UKskvdbsT16y2qxYpDRuKeQD/EUj/QDLDHmrUJfnu1C5ufTVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtNt2sXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D224C4CEEC;
	Wed,  5 Mar 2025 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169329;
	bh=uwTb2pvynGcEgNzKA2n7t8TdmNS33iMLyCP94yRdyUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DtNt2sXyLOBOh7XfDsBrSr5C9neJThwBY9xcVLyq/QV218UjV5q8E8YDoz9AzTCMU
	 qBtnLYMrdkOWxHGLyH0YQPGS42jytRpRzAD1vpQwLgu1oO5JUobfc8MmwuMND5de4u
	 zYepzVbnz/ko0CVJRSwqOQ1uB6REn2+6XAt8qn1GQ+JPfHW+QmHTDhIeQ9lxMuLR7e
	 3zb67M9/v3AwEUW3eo37O8wTy82Ew69mekIuGlTLw+NxOhmUGCW2+kH0n4sxH7wrIy
	 PdoL0ymnKGjEuCYrdjLyOd6LYfygf1e9OqIHlxXRSk2w2OUgePw91ms57UZIAxTSql
	 pOpcGoLB9PiLA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:21 +0100
Subject: [PATCH v3 11/16] selftests/pidfd: add second PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-11-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uwTb2pvynGcEgNzKA2n7t8TdmNS33iMLyCP94yRdyUo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqh27L3aINRrPZNuwlPNy7svDY3S7TxP9+EU5Py5
 LJ3Zbje6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIXRsjw7qj0+4KFL7cY9Ia
 y3m2q2ymf1UYR3fVuujvpSIc075uNmH4n59vbnGVoUtAL/Ewk9O9T2bS2t02/qzXG1zFDor/PhX
 KBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-11-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index cc1d3d5eba59..2a5742a2a55f 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -143,4 +143,22 @@ TEST_F(pidfd_info, sigkill_exit)
 	ASSERT_FALSE(!!(info.mask & PIDFD_INFO_EXIT));
 }
 
+TEST_F(pidfd_info, sigkill_reaped)
+{
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_CGROUPID,
+	};
+
+	/* Process has already been reaped and PIDFD_INFO_EXIT hasn't been set. */
+	ASSERT_NE(ioctl(self->child_pidfd2, PIDFD_GET_INFO, &info), 0);
+	ASSERT_EQ(errno, ESRCH);
+
+	info.mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT;
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


