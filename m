Return-Path: <linux-fsdevel+bounces-62095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9245B83FB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B7F4A7438
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CE2F9980;
	Thu, 18 Sep 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9+pAn2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B22882CE;
	Thu, 18 Sep 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190325; cv=none; b=Djbc89TgOtlqUHMyx7CXPyvM6aeTtFj39rj6DN4eulJ3dSyL4OTmFdpm3XriABkyyAmxWDApd4bzBk+pN5QpuSbtaONC+i3yqF2UYuUVzTK6svvWtxU0Y12r+PR1iq2Luwn8yetwoiYGQF9Osp0HJUfg9+wcqU1Vgv/iB8iTyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190325; c=relaxed/simple;
	bh=/sTZR3BClhCuVNNW87kZu8f75t/rIIcDUmwTG0o8auM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBsU/YWRyezGliitT2caLn+7FCBZ9QBIyl9OIh3KzNf5STQF16NAgFu2poQqozgTyR+O/rfoq47r2lLRy6/4ls2v0mRDlK5LqQbObxSZRHm0mv9kGxQ69KQjEAzmjc5/62RkScXmkpgJwQcRwxV8dmd732T6JgRzt8/adlw5kW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9+pAn2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4CAC4CEFC;
	Thu, 18 Sep 2025 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190324;
	bh=/sTZR3BClhCuVNNW87kZu8f75t/rIIcDUmwTG0o8auM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9+pAn2fnvTUZkPCVpHusRFwIzcM4KqyFONGUjWRLl3RMGE4cVivfTfCohGZfq/Rd
	 anD8DIBP9QPeX/qxDhQbgqOuHumbeFnRlhKKnybK3zW+/UDdc6W9gJrqpF3QIX2Ozp
	 jeDJOx/SEdOdfrXnMNX6IQ3gBcHf7Wwx5zSe3k3HGJQqoC71g/F1koQNRybunfh4/g
	 6nINc27S8xHyCKWJE4+ZQXN/W6GDIyG5ySPw7ereCrSTkaI/3TIBt+MIABt6ZU+Szv
	 tgiKZpRtgfn9zyzuMvcRDJtn5q3ILysC32O/in/wgsu5BL2hwcBL4Yml1GSOeJVWwq
	 24KG8IeWLd2uA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:47 +0200
Subject: [PATCH 02/14] mnt: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-2-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/sTZR3BClhCuVNNW87kZu8f75t/rIIcDUmwTG0o8auM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvX07tI4dYm3wu36Wde/957bpWGeaXm1LzXYzM7Ag
 0f408enHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5tJSRYYta8lvThv3LNsgH
 GXD/litVOmax74zHmjCjKaaPgj+d+8Dwv6bv+caGc4kXFO3qb9au3RSf8fZU8wzWzyudWTbeVr9
 8iRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     | 2 +-
 fs/namespace.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 76bf863c9ae2..79c85639a7ba 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -143,7 +143,7 @@ static inline void detach_mounts(struct dentry *dentry)
 
 static inline void get_mnt_ns(struct mnt_namespace *ns)
 {
-	refcount_inc(&ns->ns.count);
+	ns_ref_inc(ns);
 }
 
 extern seqlock_t mount_lock;
diff --git a/fs/namespace.c b/fs/namespace.c
index 03bd04559e69..8cc04e0e64da 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2111,7 +2111,7 @@ struct mnt_namespace *get_sequential_mnt_ns(struct mnt_namespace *mntns, bool pr
 		 * the mount namespace and it might already be on its
 		 * deathbed.
 		 */
-		if (!refcount_inc_not_zero(&mntns->ns.count))
+		if (!ns_ref_get(mntns))
 			continue;
 
 		return mntns;
@@ -6080,7 +6080,7 @@ void __init mnt_init(void)
 
 void put_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!refcount_dec_and_test(&ns->ns.count))
+	if (!ns_ref_put(ns))
 		return;
 	namespace_lock();
 	emptied_ns = ns;

-- 
2.47.3


