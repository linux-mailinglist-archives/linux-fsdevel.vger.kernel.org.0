Return-Path: <linux-fsdevel+bounces-37152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981559EE61E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510531687A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05432153E4;
	Thu, 12 Dec 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THknun5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB32153DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004588; cv=none; b=f5XnfUjohz5aYgzs9lKDTKQL8SL3MpAQwOB6ncUNVgT8zxkOmqOTG0bhLqkWbevPJJWRr/SOY0tuCFfQz8wGmEtySNYjGvpu3OatcvApSnWFH6x/Gq9bs9h7ybikDb6U8ZZNw7+07ZLXaoVfa6kQqmeqP5GB2d58Q7pN1VUHUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004588; c=relaxed/simple;
	bh=qV0Sv+xlrb/01s5FZpgdBuA+ON4p0+xW/V1y6x3Bcvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=de+xuqV+jtNjTgwc8m2fSl2LyykXRbHDW31XXYVruUTdKVlUlTkAFjJ2+Oy0SdSnuOhY6paO9FhBX9HsxCtj/BjTAhhyPTdpMjB7EX70M4eN3LuevQ/qZ1GIAPB9rsoCllkJH/OhfJoraQGMN1Mf3cdO1Td8MvErX5IWREN05pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THknun5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F86C4CECE;
	Thu, 12 Dec 2024 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004586;
	bh=qV0Sv+xlrb/01s5FZpgdBuA+ON4p0+xW/V1y6x3Bcvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THknun5gYnQ7mfLbBcdQAplRuuXRCnG+3JTHZfvrslEpehCT3U9iDdGkgQ2BCBOIu
	 lAISlSf1Pe0+FpVs4F/w5lLsVWMcjtlbixdDC0nO08mIz1MJdb4gXuLDWNRAcJm/rx
	 5a+OdWGVMoSEFgxbEYrILenKFHImlSb+clVFPT7SCri9VTtwescIuR6N/YO1oUna2O
	 KDFVvfqJAr5TlZ4I/Opq0RZqlOrFSvSK2+mbOygAa88M+lpHfVE0LECCLx48j17ZDk
	 9WfGnBP4t8TfPzQ+5jo45Q9y0u223Ht5/oF8FnD4/sfSS2ZWC87YbSdb2dk8+psytL
	 Ut2t2P7feXOXA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:05 +0100
Subject: [PATCH v2 6/8] fs: simplify rwlock to spinlock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-6-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qV0Sv+xlrb/01s5FZpgdBuA+ON4p0+xW/V1y6x3Bcvc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY/h3zTt/frU82bfOh/vszwm8K9OTCHl+mLNr/9qW
 Kao/xfd21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR22sYGW7kJeW3bdiflnF0
 X/nz7Pduvfv4V3ytKZE7bCVseW3dk0CG//58H4UZRdUS82M9ancpBHYtmb+l+MR3fqFfyuvtfpw
 y5QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're not taking the read_lock() anymore now that all lookup is losless.
Just use a simple spinlock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a5e1b166be9430d47c295159292cb9028b2e2339..984ec416ca7618260a38b86a16b66dcdba6e62ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,8 +78,8 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
-static DEFINE_RWLOCK(mnt_ns_tree_lock);
-static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
+static DEFINE_SPINLOCK(mnt_ns_tree_lock);
+static seqcount_spinlock_t mnt_ns_tree_seqcount = SEQCNT_SPINLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
 
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
@@ -131,14 +131,14 @@ static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
 
 static inline void mnt_ns_tree_write_lock(void)
 {
-	write_lock(&mnt_ns_tree_lock);
+	spin_lock(&mnt_ns_tree_lock);
 	write_seqcount_begin(&mnt_ns_tree_seqcount);
 }
 
 static inline void mnt_ns_tree_write_unlock(void)
 {
 	write_seqcount_end(&mnt_ns_tree_seqcount);
-	write_unlock(&mnt_ns_tree_lock);
+	spin_unlock(&mnt_ns_tree_lock);
 }
 
 static void mnt_ns_tree_add(struct mnt_namespace *ns)

-- 
2.45.2


