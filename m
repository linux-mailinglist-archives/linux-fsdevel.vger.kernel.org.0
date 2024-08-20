Return-Path: <linux-fsdevel+bounces-26375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41D958BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1D282433
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281218E345;
	Tue, 20 Aug 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGrQb7E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB161B8E9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170049; cv=none; b=TRxu4KYtsqlZxx4672AbQNRcy0YJCcyrLvd70iq7foAMWr18nHz1l32I6e0Z3pgN+4Icpi6oBlt15RxvhnmuK4TAr1lIkxbtDVm7cGxzxK1UfCLTfnoQ2QS5ZTEfbuUYUxXNRMfV/FuxcvDMtRcaNEBiNwQ2NbExlve0tmkXQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170049; c=relaxed/simple;
	bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svx42b3oEnFmNqnlEOp81hUCNCh7/4r4313O/D/aWIo6CvJ9Gza/GeVIE0TsGeg5dc7pHRQY0ZVMqcY9kKfUiWlOnUsGZkN6S7UY7501m1Jqul725X28UPEcYmWcNXcjGhU8IdnyWiXGgwugrtC4gcOq1sFTZUiO3fdonEcOJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGrQb7E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDEDC4AF14;
	Tue, 20 Aug 2024 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170048;
	bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGrQb7E2o6+xqA2BKGDMlRmvHY814PiRwTd8Ht0BdvkF6HawVZ5j9mIQ5u7aDHAV8
	 qm04rio5Jj2xmr6uuj5GPelNNeCOYxqm1CLq9zsLGcFK7PI4SLs8G6P1i2QhC44ihe
	 iKCqdIyyp1WYzzV1gvvQn4JIsZdPxVdBsbSLIO2MmE0ZIj4+zkY5lCo9izmpBvPuw+
	 dpy8l5PhcAiug46cX831wbLJNaycTxjkEtotzES+oTfaYM3+wPjovbwh3QvfMHy8c3
	 vmslFv0Iky9+yMiAEToZD5bgcEj/qby0e5a29G6IDaoK0posGg4bdC+TgvN0m3vjKd
	 wYSWslz7ElmPw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/5] writeback: port __I_SYNC to var event
Date: Tue, 20 Aug 2024 18:06:55 +0200
Message-ID: <20240820-work-i_state-v1-2-794360714829@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820-work-i_state-v1-0-794360714829@kernel.org>
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=brauner@kernel.org; h=from:subject:message-id; bh=VCSkbbH6FAb5Kc1A8Ex+KDjB6tcNSXukDqw5rZQc1lI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2a9wwUVZeNJOszqRPsHbZV3/X3Qcn+G7c5crT6dBw WRVo+nzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSYcvIMKnwqV5F/qvWI61S opNmNnx4aHFvydY9bbwM13bv/155souR4VXF3p77ley1CbGrzeIu1vS+Fd/R47XGZMEOt9tL/i3 8yQwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

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


