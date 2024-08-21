Return-Path: <linux-fsdevel+bounces-26488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48DB95A20A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9219228F691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092A1BAECE;
	Wed, 21 Aug 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mttaVOPU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9981727
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255280; cv=none; b=rbmKvejh+Xi6fWbvhEKI4GD53vnEjhLnNMNtKonHx3zlXMCOpWJ09NUYF8AoJOVZ/UTBmTUNKQyEmI0vHGmo3lhVa26ZpN4sN9AEpp1aUzxueDbGncAPGGst2Eag1zEbpGd/Y5ve6JUMk2xRAdYT5+Q1FB37M98xgY5lnNaOYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255280; c=relaxed/simple;
	bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euzVg75NSsOI5OTQNUJdrsqB3XRCiu9TwwsRLcsRVn90tRCjqoQt6KhQKclWRGLmvY1zCB4v6pDQxGf0DStRd4KMgxA4Sd2hOwC7BHEm/Nw/NI2qfOFoiRJO/AcQNOjoBPKZ2an0l3Xoh2TV775EZ0Sb2U+h2biWEkYcySLlDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mttaVOPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41528C4AF09;
	Wed, 21 Aug 2024 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255279;
	bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mttaVOPUnxRls3B++od4RR+NmunDIKemfrcGWlFL6/R0PpbemIhtg+FDs1pm8GSJj
	 RJk1CQENI21RYlgdY7HCvHjF6hLwIj5jYj7wNRJRtDIrSCURHFO6ces5OIZQsydmRo
	 1WB9wWcRHQthM+Fiiff4LD6Ty0RnE7ZFZxfyCENmojhZNY1TIjWTWv3FbuNsq/Ce5K
	 iPTRt2bFra7u+1O//QIIVxYeqPki7lLVzQVEORiLiswOVOrcUEWFSMZurCVK3rltre
	 YHnYCDZswqzZ9n5zvwJrgbwi9i5V9eIgREnfAY9S4DUcNCpLgytZdwV9Ju56jj2WVe
	 Yq5BQtCAX5V4Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:33 +0200
Subject: [PATCH RFC v2 3/6] writeback: port __I_SYNC to var event
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-3-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41EV0F9Zq+PCf/EO/zcPi9PLY3mW5nF+93O4x1ibn
 lQQJGbdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBH7fwz/fT64+WbG2i7dqpTo
 vjfd2qEtecmt206zQ2pKliz+4xj8g5FhD2vWmdRm2WIdvYfCegaaL18sK7ue6Lso5PGtG1Mffp3
 PAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port the __I_SYNC mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs-writeback.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1a5006329f6f..3619c86273a4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1389,9 +1389,7 @@ static void inode_sync_complete(struct inode *inode)
 	inode->i_state &= ~I_SYNC;
 	/* If inode is clean an unused, put it into LRU now... */
 	inode_add_lru(inode);
-	/* Waiters must see I_SYNC cleared before being woken up */
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_SYNC);
+	inode_wake_up_bit(inode, __I_SYNC);
 }
 
 static bool inode_dirtied_after(struct inode *inode, unsigned long t)
@@ -1512,17 +1510,21 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
  */
 void inode_wait_for_writeback(struct inode *inode)
 {
-	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
-	wait_queue_head_t *wqh;
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
 
-	lockdep_assert_held(&inode->i_lock);
-	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
-	while (inode->i_state & I_SYNC) {
-		spin_unlock(&inode->i_lock);
-		__wait_on_bit(wqh, &wq, bit_wait,
-			      TASK_UNINTERRUPTIBLE);
-		spin_lock(&inode->i_lock);
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
+	for (;;) {
+		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (inode->i_state & I_SYNC) {
+			spin_unlock(&inode->i_lock);
+			schedule();
+			spin_lock(&inode->i_lock);
+			continue;
+		}
+		break;
 	}
+	finish_wait(wq_head, &wqe.wq_entry);
 }
 
 /*
@@ -1533,16 +1535,17 @@ void inode_wait_for_writeback(struct inode *inode)
 static void inode_sleep_on_writeback(struct inode *inode)
 	__releases(inode->i_lock)
 {
-	DEFINE_WAIT(wait);
-	wait_queue_head_t *wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
-	int sleep;
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
+	bool sleep;
 
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	sleep = inode->i_state & I_SYNC;
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
+	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+	sleep = !!(inode->i_state & I_SYNC);
 	spin_unlock(&inode->i_lock);
 	if (sleep)
 		schedule();
-	finish_wait(wqh, &wait);
+	finish_wait(wq_head, &wqe.wq_entry);
 }
 
 /*

-- 
2.43.0


