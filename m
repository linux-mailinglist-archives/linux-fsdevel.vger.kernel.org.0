Return-Path: <linux-fsdevel+bounces-45854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF58A7DA5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074AE7A3162
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611F23534F;
	Mon,  7 Apr 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPnbCTv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97972356AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019700; cv=none; b=AodFdpQRQUshpt/Va/eJCG1iCXvGrPIw9iUFdxQ43Cbut+bGNcGyAoNRpqEEZFpqztb+s6ugVoVEZ2AKOlRLHPqpBdNP8njF+TT1HKGktxi5jcZmc7hQYuJSz0wyoFSCp+XT7j34uHtrIuUpvI3dg4V5AdGTQss9OvwJxXYNTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019700; c=relaxed/simple;
	bh=kZPcfW8JMlXp9ABl1x0b8khi6Vqs+G4O4SAC9RIrQyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ev8rR2p9SHQAmbZ4YKNzWQXclo7WGIkWf1A5TOAqrU6E1v1jek2qitZWS4nMfuvhtba5Hv81CQqDoR/IwK6F7A8qppXOM70s/wc8mFTOik8dyzys0rs3+nzR9dG9jXHYMripcX1hTKE2LgL8JwRaDrOssbhwFC0z37UvlgOuqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPnbCTv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C938C4CEDD;
	Mon,  7 Apr 2025 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019700;
	bh=kZPcfW8JMlXp9ABl1x0b8khi6Vqs+G4O4SAC9RIrQyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cPnbCTv6TLWveq8XBbosoXskBzsS3NeJDOVU9hQn3sMRwPzqiZO81IOikhKBX/qRe
	 FfOuPPMod6W7vxfYRs4HVHtJPDND76Swezuc81EbbRKI4wBs5rQHQZNAapjoyPy7Xa
	 lMohhqlfOaDRLL0EILdf+tVlNozPqq+kc6zNRxnxTa0Mk1GKOxYwvTg+AwGQ6oMzAI
	 LmidEfYEbEKuap4FuWsny33aa6VB3YcavJ4lDlCgZY4gSId5tHFQv0DSkXSZ7fDkCT
	 p+tuNXPwyQB1UGfxOhACAyzhpP1LNN9oYL3LXX980ocChjGG+AJcXKgXKdM+qYsXVd
	 0ECQdfZmPe7Bg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:22 +0200
Subject: [PATCH 8/9] selftests/filesystems: add third test for anonymous
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-8-53a44c20d44e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kZPcfW8JMlXp9ABl1x0b8khi6Vqs+G4O4SAC9RIrQyU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnA9QS1kvvlNmRtKucd3RnlXeohvPRtScFjiS8wVk
 /QNq4yfdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE9RLD/0zd28v21bYa6Fnk
 qVptjJptcW7GB7eC3k+8Z15s9JtbKc7IcL3a/2vjk7kZjmea74pM097o3nv71T076wvLVT36+/T
 yWAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that anonymous inodes cannot be exec()ed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/anon_inode_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 7c4d0a225363..486496252ddd 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -35,5 +35,18 @@ TEST(anon_inode_no_chmod)
 	EXPECT_EQ(close(fd_context), 0);
 }
 
+TEST(anon_inode_no_exec)
+{
+	int fd_context;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	ASSERT_EQ(errno, EACCES);
+
+	EXPECT_EQ(close(fd_context), 0);
+}
+
 TEST_HARNESS_MAIN
 

-- 
2.47.2


