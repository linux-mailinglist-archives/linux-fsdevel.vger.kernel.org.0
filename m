Return-Path: <linux-fsdevel+bounces-45855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F4A7DA66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FD1188C24D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E752356BF;
	Mon,  7 Apr 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luWk8Dx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A9230BF4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019703; cv=none; b=AFUGd2Eb5drwtMpO0YPF21Tp6Jrq4LHMpLe8HEp4eYjGmgSnlj+vuqpBdfLuGIwX392sGdCPhmE+X/NawlNLDnV4rR6M1fOnkI9+KtfXET20ZwOK8ziM67lVvURTRXlRdrtju26EwxMQhGJX8ozEs4x4NAX/mAhQidaLoJu1Ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019703; c=relaxed/simple;
	bh=IPngv6k4HTtp0L0AG/j88z5uovfA3r+o6pDR1kDrBHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSWCJEcNeMPAuYDuZL2U3m871V7/81ztniQspwivhtgDjCY/f9MUtI55UmbT8IcuIiROag6jC7cUbryzf5j8AMUgCXgVNkYDDPL0skmeHEuufT/DsdiPdPeLXUhbGLXdgoMKwC5hpLtpLpiQSxbsk7KjSSssdqc77xr68q6W19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luWk8Dx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9BEC4CEE7;
	Mon,  7 Apr 2025 09:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019703;
	bh=IPngv6k4HTtp0L0AG/j88z5uovfA3r+o6pDR1kDrBHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=luWk8Dx5v3NFNJIrB3nVvtAhqD4XvHLOEoOj6K+tCqvKNAD99D4AQudzSrz3SlzW5
	 t+HfScEKWJNAEcKyNXGiklzL5mRpmonTBaO4GhTya4VC5s/9ETTS7hcATgorA+Bs+k
	 mFoJqiKByC3B6sWeF3alIeN00WWG9jcrZxEocOP6+8l/0dylsqi5Nc5CqfpDs7Ul8P
	 wa960HBsgaUHXKmjv4CHKaIhjmuz/4OlO1FK2XM12idxNpnbI9xX/nPTHlOdkt7H0p
	 ycX8PesH5jUOZL1zSqJdnC8Dl+Omxe2XLaFd70ME4KDKo3Py/Z2Su3maimTY2t/FqB
	 /Kk9Z62w3bPZQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:23 +0200
Subject: [PATCH 9/9] selftests/filesystems: add fourth test for anonymous
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-9-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IPngv6k4HTtp0L0AG/j88z5uovfA3r+o6pDR1kDrBHI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnC9YWMrE3eVxm1zXR61iPpPFhtjTnFLfhObwnQjM
 rDqiFRxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESS3zL8lTrL8sf9SYIQX0nI
 i1/PN1/+JL3xkKE7xxGN6p8zHBpnHGJk+HM61/vJ/69++48onjRQ1DqSuOGC33b+hAvHjCfUvfr
 8hRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that anonymous inodes cannot be open()ed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/anon_inode_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 486496252ddd..e8e0ef1460d2 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -48,5 +48,22 @@ TEST(anon_inode_no_exec)
 	EXPECT_EQ(close(fd_context), 0);
 }
 
+TEST(anon_inode_no_open)
+{
+	int fd_context;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_GE(dup2(fd_context, 500), 0);
+	ASSERT_EQ(close(fd_context), 0);
+	fd_context = 500;
+
+	ASSERT_LT(open("/proc/self/fd/500", 0), 0);
+	ASSERT_EQ(errno, ENXIO);
+
+	EXPECT_EQ(close(fd_context), 0);
+}
+
 TEST_HARNESS_MAIN
 

-- 
2.47.2


