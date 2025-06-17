Return-Path: <linux-fsdevel+bounces-51917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41321ADD279
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD939189B3C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E342ECD3F;
	Tue, 17 Jun 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mul7pjbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F62DF3C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174950; cv=none; b=tvxWvLoZ8IrMpDvXXuojxgwA+490jbdbg/xQ4pJ6iGVEa5PqgqWqH3Vdz63nsti/ttu1/KjPyqwMwumrjtTR4wr/waDRzNhRlsISZKyWa3/aE62XqyHKHXsx7hNtySB0aQDKbPxKtdISaDQn+G/UsnBBrySmZAHii15UecqiEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174950; c=relaxed/simple;
	bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+LvbVHz9DOk4Yf1q1Ah9MYnOMEHQjHkdE/i+mvY+unBVf5QS3rM6q2RS7KOoVSRRu7jEGPDQa+KQakQEHFNNU/tg5l+QlywA8m++ElqVbcPh4yIF0awu7rFfaJ/ywyyG/9I4q473635oIkz4oazOqSv4fAwtF2K+u9c3xuvib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mul7pjbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0190AC4CEE3;
	Tue, 17 Jun 2025 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750174950;
	bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mul7pjbLREmnRU7XvbIbhNuzdRDK7dGzM11q0MctJtjfHBN5UZvYSqnRPCj5Dy3if
	 yBpZKXB398hTso4mgnFBPyohMV/RI+/T5jg6p/l9SrTfIn0fUA7Rsq6MnfUITJQkAV
	 YA+BExRaA6G98r22LnZ24UVtkx91eLtph+/EK/7eaJ71x1fbbSG6tBcwuVN9Mrswq5
	 HSt+RGnq/qEjQagHXubHl/S/tmbHuP6gLjdJdGKeI0S8i6nccq2tddeIXwqqVDltZr
	 DrqmjHqFJYgM+oBAeZou2+j0nA2cBS7vWaQSNAT8RIghjtfXFy6hy5QDN7nP17+TkV
	 Q2J5ZbnM8NqOw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:42:12 +0200
Subject: [PATCH RFC 4/9] pidfs: make inodes mutable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-4-2d0df10405bb@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9txYcS84vlJEtHvuupyd92JnbxRZ+5tBudnrwbPPL
 9ZnnHmU2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRUnWGPzz8nu7mzOvcxBrU
 rFbcjDWSt9zWs6Fp/kPHz98Ucsomrmb4H32v6uQByeJMmaB/F6/aVLw607pmjp/5XVXz+9KFFYs
 D+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Prepare for allowing extended attributes to be set on pidfd inodes by
allowing them to be mutable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 9373d03fd263..ca217bfe6e40 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -892,6 +892,8 @@ static int pidfs_init_inode(struct inode *inode, void *data)
 
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE | S_ANON_INODE;
+	/* We allow to set xattrs. */
+	inode->i_flags &= ~S_IMMUTABLE;
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;

-- 
2.47.2


