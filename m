Return-Path: <linux-fsdevel+bounces-43068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C25A4D8FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39CA162FC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4381FECD8;
	Tue,  4 Mar 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfMqxlFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA811FCF7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081301; cv=none; b=OSOxizzSygZ47zdwfkl4366034oipqxI1gwClIarnaq2KzhvXPmmt0Gna5uTIPnnSyRevy/ttLscLSc5prwdgX0F7vAnTARI/SeI3ZaegxaGbJNpPJc0i9QSnwIhImF2MZJslYd0N4H/YY9FaPRZU6TjSZYDCIkRIfISg51YOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081301; c=relaxed/simple;
	bh=hJe53uv68cH4hf2dDpYw68f12OpI2dT1XrSeuwL+Mno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfRQM2VGA0PeCHYcTEGkvM8BIoXh4mk5ClHiNRRiiD38URf0Z5YzjUlEBopWgfaqR4nbqr+bz8gzQPjUlLVKXqcuAaPEAf2hzbaso+A2oba4LrQG70Iu2roMvgicq+pxfphCiYUZH91HvvzDVwaL25FpIwcSgk9QQArjE4XA9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfMqxlFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBCBC4CEE9;
	Tue,  4 Mar 2025 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081301;
	bh=hJe53uv68cH4hf2dDpYw68f12OpI2dT1XrSeuwL+Mno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SfMqxlFkRVzBLVHbyPUBovGb09kZO9mdYHYqaSSp57JwekPYoYykBrn2vO0nPWOLh
	 2O3wZMP3rDnHl9LLD2s8RF371aok8qzWrlOdiskdj13xLJ1gq2YX1bSSzrKSNSN4cy
	 9jJahG/ayhWz1lmFak5WjIBu6FpUCeEDTupsSGCX/T4lJaZrpEQAnKEBmcweb9Gqzg
	 Too0zw1IuHnp1uGzoOVkdFNDEX08ry/Sx/afPgPphu4a2oulPCCN4E4eff5o3oqUbZ
	 HncKd0755u/LQsCkElBvCh1e8NK5RyxmrYbZaX1IGu+bSXoZU1AyOaPmjdVRBRfvN/
	 Ig/HoLkNilI/w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:12 +0100
Subject: [PATCH v2 12/15] selftests/pidfd: add third PIDFD_INFO_EXIT
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-12-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hJe53uv68cH4hf2dDpYw68f12OpI2dT1XrSeuwL+Mno=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7X7mkF0hUjRljvvNx0MntXnoPFp5WaLlwI26rtvT
 Zm7ojN4TUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE7s5gZDiw4lX23u8PLaSq
 dt53Wl9VyLl5cef2JKUQ/qPp5uG/VW0Z/hmqLt6R8fziO5X5qwO28696K7Fcotmypzv1pNGp6Tz
 3n7EBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a selftest for PIDFD_INFO_EXIT behavior.

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


