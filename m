Return-Path: <linux-fsdevel+bounces-26490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E95A20C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7D128F678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C61BAEDC;
	Wed, 21 Aug 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU+wjdmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBF1BAED5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255284; cv=none; b=WuAVfVGOfrqUe2p7tyJfUs/FfVeiB5HrgUA9MzwiMQr1SnDzSFa3PFWjuwltR/Tv2cslgftSnuZRdAxaMo3bQlonAR58vKdGe9ezzvoFaRar8tMcdBea6G4dzecEsrCQp5zILyPyjtvU5KNC6xdA8HHJmWPf+NxiwIu2Fj804lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255284; c=relaxed/simple;
	bh=DS5/a6JJFN2bMggpCIXfeUIF6WxzMYj2BLKMWGxSV04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eo5Im9Lbbh4q+Op6bVxPGE3TzCE54OxMZkpmfhJNbeNxjYii2o4e2Svl3KqC4m2VQn2YTjSQzXHLz12WuUbJHKqHYcW3GF+Vtd0DjFqUCfQTyMCovNvKQ4/6XtXDBwbbDH/ve2H8D4Hr0GiqBmofhYnAfmq79ZuMiDw7HMisyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU+wjdmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13424C32786;
	Wed, 21 Aug 2024 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255283;
	bh=DS5/a6JJFN2bMggpCIXfeUIF6WxzMYj2BLKMWGxSV04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NU+wjdmiJ6tia1sCp3gP8tK7V1roxtApcLvyGReL7jz/wf19ofND0M4lMlPYlpPBd
	 h2XqxiPX5VVR3VcGZCp9AHtzwPRnmL4VJuFQme0xL2GVBAf+sHgJJtmqwJodR/6PrI
	 7netSY/+OZx9BHLAiBncHYCgjlC6ujEbGylNyx/9R0uuHXAzXsVk4uuz3zGQe2xT7X
	 sGleSodpnbqhVEIrhBjIRuvzEo94gLKpZVPhccySyWZHp0XmJL3jO9fTkcmEGw6jSU
	 jqBX+jTErHbTTj4YLCbH18CdG175Zy29RBBMjnyzbYwxBgFjbHDYqJE35BNBHwJSiB
	 D6a6bRr8O6WBA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:35 +0200
Subject: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-5-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DS5/a6JJFN2bMggpCIXfeUIF6WxzMYj2BLKMWGxSV04=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41FViMqPUv0gcDH9w5OJP1ryF0Q0K3p85v94aeWSu
 H3tjT39HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZE8nwT2f/Sibbqo1ar7QP
 r0qfY863rnL1zRtKmx3y3glJ8xt7HmT4X/Td37X2j9cz/jbOXx5esnt3H1mmItZxSmPh2RMb9Br
 z+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d18e1567c487..c8a5c63dc980 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -510,8 +510,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
 	inode->i_state &= ~I_LRU_ISOLATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -519,13 +518,22 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
 	if (inode->i_state & I_LRU_ISOLATING) {
-		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
-		wait_queue_head_t *wqh;
-
-		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
-		spin_unlock(&inode->i_lock);
-		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
-		spin_lock(&inode->i_lock);
+		struct wait_bit_queue_entry wqe;
+		struct wait_queue_head *wq_head;
+
+		wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
+		for (;;) {
+			prepare_to_wait_event(wq_head, &wqe.wq_entry,
+					      TASK_UNINTERRUPTIBLE);
+			if (inode->i_state & I_LRU_ISOLATING) {
+				spin_unlock(&inode->i_lock);
+				schedule();
+				spin_lock(&inode->i_lock);
+				continue;
+			}
+			break;
+		}
+		finish_wait(wq_head, &wqe.wq_entry);
 		WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	}
 }

-- 
2.43.0


