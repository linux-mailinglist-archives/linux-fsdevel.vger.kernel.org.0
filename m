Return-Path: <linux-fsdevel+bounces-65884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B7C1397B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C0E3ABE12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2D2DCF52;
	Tue, 28 Oct 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk7DvoA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7C18B47D;
	Tue, 28 Oct 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641178; cv=none; b=H0QndVqnIP6QeK8L2vRlx0KV4VLKX9OrVyt1U3t/qQNsJESWKvGfzBDE0A9loLnLdV5cYFU2qfIJk9R+20OxPI7KitM8SnmcxxHEnGGoKfVfaq7SgLHdx9uaOZYfkTlGASB2mPgLXDb+LCUjFF9trbQ4CYWJdYwfBZMUEeWvbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641178; c=relaxed/simple;
	bh=xLaA3mHVs1PMWvjVhO98eDYbhDOhetr0dEi8bwXPzZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTBApQ7Ayb4E5Z/oTXcu85r9KjW65YyO85e4mY5kbHFYTpjqKNzLue+OCjb7nf6C/eiXj/tkD4vFwCGGJZLQZFTmt5Hn9pm66ZWmPX7x9r0ITWSqlYO+lcHZjU+2Y6ccC7FhlZyrTHeZNVdLb1BHxlrCDjGuCurUZboR6gZJDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk7DvoA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C3C4CEE7;
	Tue, 28 Oct 2025 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641177;
	bh=xLaA3mHVs1PMWvjVhO98eDYbhDOhetr0dEi8bwXPzZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mk7DvoA6EhCNm1jFYTvCH3G5KY7t1ywC9Vd7qKgNddwPRDmdZZUZz8CobWfys8fee
	 ifnwRDEed7xhcCaBxqeSQqLjLPWRMwd6dm4sd8oIEplhzvn0HnOje6Vumb9ZEN/qbq
	 LvcVIgcpBwVa+4GaQ/O/Mxn7E4rrNJjDkXvIr4FPcH/w3Ug7cWWKeWwr4Af9UvCmu4
	 Fyedkf7nEkuZHg8cf6qWBxxNE7zgb4titNMig9fU1HfFrmY5L5wxHbPTJC4wUNdSEU
	 qPvGELV82guJrt8bkYdoelNTHMasMAnjHPdSYRhOYukAd/SBJWPw+6++jNu2UNJH1L
	 nLpWacEvINoyw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:49 +0100
Subject: [PATCH 04/22] pidfs: add missing BUILD_BUG_ON() assert on struct
 pidfd_info
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-4-ca449b7b7aa0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xLaA3mHVs1PMWvjVhO98eDYbhDOhetr0dEi8bwXPzZc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2s68rPfbujfu9VE8Ee8dZr86cmb900/dFsxhXBL
 ZNmO+Vf7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIJB+GPxxcybprV7BIZqqv
 WSORN/Pf0p9ruFW13ylypZvr7+pWqGD4pya0d8biZzvsvgm43g3QSOHM2Vr+yvLuWQ9njYZW3k/
 LmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Validate that the size of struct pidfd_info is correctly updated.

Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c0f410903c3f..7e4d90cc74ff 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -306,6 +306,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	const struct cred *c;
 	__u64 mask;
 
+	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
+
 	if (!uinfo)
 		return -EINVAL;
 	if (usize < PIDFD_INFO_SIZE_VER0)

-- 
2.47.3


