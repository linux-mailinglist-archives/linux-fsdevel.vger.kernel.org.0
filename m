Return-Path: <linux-fsdevel+bounces-26905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD495CCC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260DB1C2346F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFB185956;
	Fri, 23 Aug 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkKsAJBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812F185B5C
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417283; cv=none; b=a0p4IrqUS9+vq1zc4uya9YFpPQ4CiKKerlQT9l/XQSTe6bS9ZwgSgdR5Cx/2ewXa/jq+PuHrZJfHO0lxPumVRWbG+eNdmtKWzhyK6e+mSqF941vFGn9NrKCyGKWj5Lu0/mASdRZa2hZkvRg0ZP3kLU5IgXnCABMhn2b/gBhLdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417283; c=relaxed/simple;
	bh=ZbrlJqiOhEXVHhy6EovBOTYkE8EmF/LU3ZtCoLkwGlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrNtYg84wA44K72VBN0VYTU/MWPXqt3SqLJ/ab40uQLpqaPqYAGYFIg/QuYuy0D15x97rpMBoJnq9x4t7w8kSV2hVoYj7oFNAXcL94VkGwd5k/dG70N4kN4dA0fK+imr98xbPyJHiCv5kYMzrCzYJo+4kVThTH7wJjh67iy4gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkKsAJBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA7AC4AF09;
	Fri, 23 Aug 2024 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417283;
	bh=ZbrlJqiOhEXVHhy6EovBOTYkE8EmF/LU3ZtCoLkwGlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkKsAJBLEW6/oDgMBRp4v+BtqydOwI4AC46S2XSlDPKiJ8voe8PzmsrkddlsT8rZ0
	 ujtp9PdJYY7G2Py0t6xialKQBu2P5EzyZszCR2PxSMe0l4lLcN7+p/O+unUsjpbiE7
	 x7etbaiyf7EcELXwEJC40GCRZItxzrXIyBOBPuy6eK+YT4I1kpHGhnn5LqHOaD2bVK
	 FnrqCnTXSoh02+s5PaZIl1daquwnbpY1FKEZFiMxYOibnmkqbhs4VwtJa4ASlJxWNH
	 2I+9pS7SyP4Wpxp3nHnsDdxnYdmxwlAA/W3EenZJEDUNE3yseuC0ab2HzmukNqWP5g
	 1fB8ULusSWHLA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/6] inode: port __I_SYNC to var event
Date: Fri, 23 Aug 2024 14:47:37 +0200
Message-ID: <20240823-work-i_state-v3-3-5cd5fd207a57@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=brauner@kernel.org; h=from:subject:message-id; bh=ZbrlJqiOhEXVHhy6EovBOTYkE8EmF/LU3ZtCoLkwGlY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHlb3XuR89fNsyJ/z8d5nd9xccq1BW/k+Nms2NZyN +dWqf9a3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCREz8YGd5Mi+X0XCjamMml YhC98Vhbv8HkO81d84syDIPZ2aI/KDEy3H7zV/Dj602SKx5f/LyAe+P9+TfcdTQnPagyynmxyOF VIx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Port the __I_SYNC mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs-writeback.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1a5006329f6f..d8bec3c1bb1f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1386,12 +1386,13 @@ static void requeue_io(struct inode *inode, struct bdi_writeback *wb)
 
 static void inode_sync_complete(struct inode *inode)
 {
+	assert_spin_locked(&inode->i_lock);
+
 	inode->i_state &= ~I_SYNC;
 	/* If inode is clean an unused, put it into LRU now... */
 	inode_add_lru(inode);
-	/* Waiters must see I_SYNC cleared before being woken up */
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_SYNC);
+	/* Called with inode->i_lock which ensures memory ordering. */
+	inode_wake_up_bit(inode, __I_SYNC);
 }
 
 static bool inode_dirtied_after(struct inode *inode, unsigned long t)
@@ -1512,17 +1513,25 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
  */
 void inode_wait_for_writeback(struct inode *inode)
 {
-	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
-	wait_queue_head_t *wqh;
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
+
+	assert_spin_locked(&inode->i_lock);
+
+	if (!(inode->i_state & I_SYNC))
+		return;
 
-	lockdep_assert_held(&inode->i_lock);
-	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
-	while (inode->i_state & I_SYNC) {
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
+	for (;;) {
+		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+		/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
+		if (!(inode->i_state & I_SYNC))
+			break;
 		spin_unlock(&inode->i_lock);
-		__wait_on_bit(wqh, &wq, bit_wait,
-			      TASK_UNINTERRUPTIBLE);
+		schedule();
 		spin_lock(&inode->i_lock);
 	}
+	finish_wait(wq_head, &wqe.wq_entry);
 }
 
 /*
@@ -1533,16 +1542,20 @@ void inode_wait_for_writeback(struct inode *inode)
 static void inode_sleep_on_writeback(struct inode *inode)
 	__releases(inode->i_lock)
 {
-	DEFINE_WAIT(wait);
-	wait_queue_head_t *wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
-	int sleep;
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
+	bool sleep;
+
+	assert_spin_locked(&inode->i_lock);
 
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	sleep = inode->i_state & I_SYNC;
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
+	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+	/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
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


