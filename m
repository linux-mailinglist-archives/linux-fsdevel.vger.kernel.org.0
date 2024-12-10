Return-Path: <linux-fsdevel+bounces-36985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCF9EBB4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1611680EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBF22D4CA;
	Tue, 10 Dec 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnzDYCuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062522B5A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864293; cv=none; b=AcJJTNKP9pI4YjkblH4i14rvs3z9xQV8UdE1SuX/YSk0YjUBHa7Mkw/qxYlFjFV9qh/xLYVLsDeHa4UepzWhMzRd7F2ZjBmfNgazf0bmsKTLAIuGBb3PCFGZtKGIyzFeyKDPGiPGf+tlgFre3QdavWr5aWPlfE4AvA8piom+Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864293; c=relaxed/simple;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EShXw+How1y11seo5NoX4g6JhKn2VPpeUbkfUw8o2uSsVzIwaPgFnnzel2gFwfMPn+vFF1yimKJHLe2rR7hIWYARZjFbpsL+WTFVQW5/32qsxeGqYttG+Rv9bB0s00n+5U03b36VtUFX3Jlxigaq0WQ3nc+gb7C3VFqPZNu9JSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnzDYCuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4103C4CEDF;
	Tue, 10 Dec 2024 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864292;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnzDYCuS2VN/QrE5TV6e6YPL+ZT5bR5VlsT59ajlvW87ws8PJo8IeYFoasEEJq0w0
	 Ihd56wt3xXjE/MiF6PocLR2u//aRwyCHXc17Lc855hYT1EmXolAmdTBAMsU+T+PqLB
	 EPL8LGdtY1GLiJT7SSHJyKN3CV24qHTL0Lws8oZ2THmbJ6ZLDuaysNFalyge098hSB
	 QpN6seamiQxu0QclU0b4042+sxC1YhaYacGVFBwG5UkITkXj/5ZHZQOsRFyDAOYIPS
	 4yODoegVCmp3fHpE6TnPMzyguA+1MOw2sD86ppDOAA6Dxzs8VNfbG+U5JNnCF5xUXr
	 fQjJnZ5xQZSYA==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] fs: add mount namespace to rbtree late
Date: Tue, 10 Dec 2024 21:57:58 +0100
Message-ID: <20241210-work-mount-rbtree-lockless-v1-2-338366b9bbe4@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org; h=from:subject:message-id; bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHrA5/8yzVZ+Mp57tnHNs/TJ91XIJ7V1DgOo6dooeZC 883urzO7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIWl6G/6VFjJztnXWscvMF s18kdO1jTjisxZC183r0D8aKEO/SJwz//TVueTe9fj/t9cxWk9KZWyOOcQl8b2kIWrP06f5/mSs XcgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

There's no point doing that under the namespace semaphore it just gives
the false impression that it protects the mount namespace rbtree and it
simply doesn't.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3dbe6a7ab6b1c77c2693cc75941da89fa921048..10fa18dd66018fadfdc9d18c59a851eed7bd55ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3983,7 +3983,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	mnt_ns_tree_add(new_ns);
 	namespace_unlock();
 
 	if (rootmnt)
@@ -3991,6 +3990,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (pwdmnt)
 		mntput(pwdmnt);
 
+	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
 

-- 
2.45.2


