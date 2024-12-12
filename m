Return-Path: <linux-fsdevel+bounces-37246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C39EFFCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C2A1887526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17191DE89B;
	Thu, 12 Dec 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip1o5Q1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8171DE88E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044649; cv=none; b=HyYXJbFlbIV9kRdfSqGVY8vMOe/oPBZUb7eKW0Y6evWj8cJMQ0HGvFavXmoZvMqgfvvYCr+S34ES9IvvJRBd7HhMnw8WID6RXKLdtVlLkuSKkMiTgQGMZbcHivv362BbFljJGNvi49ze+d0N9poL6wn/KH2Mr/JfUXaTpbrL/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044649; c=relaxed/simple;
	bh=gM6o0lv+1MLCmUBeH1yTGRFwLBiTyVZcGD7SSx/p5vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOEHS1X6K0Vh+DW/hp87kWlVVAhS/cA7eAnM3NEesm8HbvDyv0fEdv611VnvKArVuPWoj+NB6Gw39zWQYdbe0ja3Y1wtLPMgLbuYrnirgJM1bGEz/XPxh/zHPQWYp4UcRkTVZlsiNWVKuzmPpkxcsVQH5QN+ptEvHgPozEhSWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip1o5Q1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E24C4CED0;
	Thu, 12 Dec 2024 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044648;
	bh=gM6o0lv+1MLCmUBeH1yTGRFwLBiTyVZcGD7SSx/p5vM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ip1o5Q1CLA76KNTGbKjLx9ln+gaPV6MLSY7CrUaFyR8SNVUbkRPd9UP1CjFbOQ6oF
	 wg/Ko4s/E5Kg+S0BHv4byOxGUvdjqOq03IxR7Dp4sazfhncCaY7O+SjTj1SO0hHbPr
	 9zEJpes7wMCAbVvd1lSIlKlcKtLzqGG7GpSVKSLLPY7ITgSveuawbLvKp4mFfRILPP
	 1dZ5nKYJTt4jxLXDC6EkUDhVPKC/lilUW6lDvSK8JMx5THe2XtrSrW/BytAEipjm69
	 Pwiv/k4l3D5DoUJPM3Ezm4SIe3D9SCS5ncsYiNxc4RvLY0DVajHHWi+ZUw0z6zOTcT
	 wtflRcSuicV/w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:45 +0100
Subject: [PATCH v3 06/10] fs: simplify rwlock to spinlock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-6-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gM6o0lv+1MLCmUBeH1yTGRFwLBiTyVZcGD7SSx/p5vM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9/qa8lZFtLneHxfhdXpZ0dcNieEvlAQLHhd+Ds8Z
 ZXgvIvSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxYWD4K3TTUlHkbdjaPdIv
 8ljnsR71ePK6OKZVl2dr3dd9/ByWMxkZfr3+KP5p1+cPPTYum+oeeerd5L9e8+WRktic6xGPjp0
 x4gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're not taking the read_lock() anymore now that all lookup is
lockless. Just use a simple spinlock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 71509309652315e5aa9c6b16d13de678bf1c98b3..966dcd27c81cc877837eca747babe0bc31aaf922 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,8 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
-static DEFINE_RWLOCK(mnt_ns_tree_lock);
-static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
+static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
@@ -131,14 +130,12 @@ static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
 
 static inline void mnt_ns_tree_write_lock(void)
 {
-	write_lock(&mnt_ns_tree_lock);
-	write_seqcount_begin(&mnt_ns_tree_seqcount);
+	write_seqlock(&mnt_ns_tree_lock);
 }
 
 static inline void mnt_ns_tree_write_unlock(void)
 {
-	write_seqcount_end(&mnt_ns_tree_seqcount);
-	write_unlock(&mnt_ns_tree_lock);
+	write_sequnlock(&mnt_ns_tree_lock);
 }
 
 static void mnt_ns_tree_add(struct mnt_namespace *ns)
@@ -163,7 +160,7 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
 
 static void mnt_ns_release(struct mnt_namespace *ns)
 {
-	lockdep_assert_not_held(&mnt_ns_tree_lock);
+	lockdep_assert_not_held(&mnt_ns_tree_lock.lock);
 
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
@@ -228,11 +225,11 @@ static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
 
 	guard(rcu)();
 	do {
-		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
+		seq = read_seqbegin(&mnt_ns_tree_lock);
 		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
 		if (node)
 			break;
-	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
+	} while (read_seqretry(&mnt_ns_tree_lock, seq));
 
 	if (!node)
 		return NULL;

-- 
2.45.2


