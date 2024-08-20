Return-Path: <linux-fsdevel+bounces-26377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A397D958BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE9B1F22A65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F971BB691;
	Tue, 20 Aug 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmQ34ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E24192B83
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170054; cv=none; b=U+sZkxkTP671ctqdAO4UAF/DrJW/zvDdTy+uFV9paoldJZ+UaxwC9XtNpo2VMhnhkNiFoC5a0rQEnapcO8bfvx9tcexvTDYpcP2tTkHc8oQ3gD6SPskUbrZaQCVl3PKibMb+2XbKweALk6BnlxCF1YeRchN4CHOAgNWl3nETxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170054; c=relaxed/simple;
	bh=cgTUGY9nCB2XXnhteA5TnY+XSftnWg0S3KrFGXJg4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK74csk+Kxi8oycIK4TTf5m8EKxy7EXB/M1GDQt98imOrDJIf/rtswCUdxacwWbNNl7sGzmXGM7C20THH9WB0a3EL+12hSaJVyxqhhIEtZ40qms7/2q3OtfK4OL76jr6BkrwzSsNNpWK8lLcx812SO3Gq+3a1xSb6eQ2se49w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTmQ34ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2DC4AF13;
	Tue, 20 Aug 2024 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170053;
	bh=cgTUGY9nCB2XXnhteA5TnY+XSftnWg0S3KrFGXJg4qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTmQ34nskKtetveDymW+jLg53G5Z+FvS4KHdQHDEuq6E3K9PaWTO8pojy7DXjhfmV
	 fScjZL/1TYaSFmKRzaJzzNVQPDJlh1spCjgLn+f6jW6u9wJ4DWvHLzW9iSBC7f4Ey1
	 0iU/7JkrXWsetGCtqQnqmsrq2OudPgIiX4nnYrvatFKVPJsFTHl4pa4WvRb1QYragc
	 AFErQNPPjWWdNXskSZYp3cJOCgWtp2MA8pGjRQ6sQIwl/pyevkpzzzUr4RUPYO1Khz
	 kAyncRavBkqp1kYGpdrZunED0JUEiFoP589IgCMpOXGXSS8jxN9DKlHl1eDIWsGtx9
	 CsOM12+u8kDpA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 4/5] inode: port __I_LRU_ISOLATING to var event
Date: Tue, 20 Aug 2024 18:06:57 +0200
Message-ID: <20240820-work-i_state-v1-4-794360714829@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=brauner@kernel.org; h=from:subject:message-id; bh=cgTUGY9nCB2XXnhteA5TnY+XSftnWg0S3KrFGXJg4qU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2a+oV+Ui0n/zy71J2wIdJZKXfpjj+N9qe2Ptp9lz4 x56nO1x6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIxSWG/xFROVN/z+z7M/X4 7L0LmXfssWjR1ixVKfHSOf3+9KlopjuMDE3VJcycBv9f9ApvPcs4+9+VF5tCDBMk+6f0XZt4l2e /Ey8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d9e119b5eeef..a48b6df05139 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -511,8 +511,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
 	inode->i_state &= ~I_LRU_ISOLATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -520,13 +519,22 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
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
+		wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
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


