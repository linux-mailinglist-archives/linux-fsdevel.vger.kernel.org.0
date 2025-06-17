Return-Path: <linux-fsdevel+bounces-51939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D7ADD301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA903A4CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288D2EE5F0;
	Tue, 17 Jun 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOzx+cfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD52EE5E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175140; cv=none; b=iC7bkFtG9x+zrBFO34MjM4OpUauowo5hoHheuQokHQXxaKpA9bCMDNQ5b8hbSawnwqqjccVlG7TmOxVulE5jFZF4ctzKmbIdibFKDAaqxqxXHXsTatwC/bVnLCvKopUnP6jWxSOgHct1BWXblGSZfzkKw8nMom1+bAwCKfMIZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175140; c=relaxed/simple;
	bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmldYctTMWfN1UKsLd4D0mYxrz7KiJ87kXyYNqOd/I8O55x686jmB91xw13p8b/gsb3MZ+H7AqKiJq9cHYwRn+MEI2to+SpjEMpC4JiOFG9W+xrVMQ2huox7xs16lY25R4EiLdHYrhra2p/wBQBu5xELKHlac0a53aDASQ8qOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOzx+cfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BDFC4CEE7;
	Tue, 17 Jun 2025 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175140;
	bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eOzx+cfkOMdwz/X4w3RmwCr5/acaqJfK2UHK7ZstULcQI30LJmcjVC6iQgxf863ln
	 rC+PfpR8pWA0/HFU3YTw1ezqqhAKk4aEbdh42YxVjyF9qRERrmiGKK+3G25E28rlOX
	 PsDLpqjzZ5fNhKOSGSO8LRd5MGDKnpD7tzEGVtL0z2ejkuhNyWNY9NjRlvBhgZfQ5f
	 vFapheD7yNv+MtBD5OU2jExRmW8jp4awjlXQSbDVxG9PADVwVfTrrSerWjsRAHuebC
	 zWt8OVxJJkVh+nYUxf0jI3CiGIUjPLUd0EZzDVp4K7TnXIzMWOGJtIm0iKEowql6Xj
	 WH/OsUAZKamlw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:16 +0200
Subject: [PATCH RFC 6/7] selftests/pidfd: test extended attribute support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-6-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Vo9JV0UIUMjl0OnfHIT1TOulKdAbz8FHc1cKUQprIG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k6svj/v6c1//ft12XWW1fwLXb66Ic7g2hyTTROuh
 56eV23wp6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiAVMY/vDIXaq6Irsk9ABr
 Ri+nnfb2YwJMbbzsAX2rjD93rxcV+8HIcDngaBSvZibDnVfyT2bfnBdx+L4A869vvpd3uQYxG1b
 dYAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that extended attributes are permanent.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_xattr_test.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
index 00d400ac515b..5cf7bb0e4bf2 100644
--- a/tools/testing/selftests/pidfd/pidfd_xattr_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
@@ -94,4 +94,39 @@ TEST_F(pidfs_xattr, set_get_list_xattr_multiple)
 	}
 }
 
+TEST_F(pidfs_xattr, set_get_list_xattr_persistent)
+{
+	int ret;
+	char buf[32];
+	char list[PATH_MAX] = {};
+
+	ret = fsetxattr(self->child_pidfd, "trusted.persistent", "persistent value", strlen("persistent value"), 0);
+	ASSERT_EQ(ret, 0);
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
+	ASSERT_EQ(ret, strlen("persistent value"));
+	ASSERT_EQ(strcmp(buf, "persistent value"), 0);
+
+	ret = flistxattr(self->child_pidfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	ASSERT_EQ(strcmp(list, "trusted.persistent"), 0)
+
+	ASSERT_EQ(close(self->child_pidfd), 0);
+	self->child_pidfd = -EBADF;
+	sleep(2);
+
+	self->child_pidfd = sys_pidfd_open(self->child_pid, 0);
+	ASSERT_GE(self->child_pidfd, 0);
+
+	memset(buf, 0, sizeof(buf));
+	ret = fgetxattr(self->child_pidfd, "trusted.persistent", buf, sizeof(buf));
+	ASSERT_EQ(ret, strlen("persistent value"));
+	ASSERT_EQ(strcmp(buf, "persistent value"), 0);
+
+	ret = flistxattr(self->child_pidfd, list, sizeof(list));
+	ASSERT_GT(ret, 0);
+	ASSERT_EQ(strcmp(list, "trusted.persistent"), 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


