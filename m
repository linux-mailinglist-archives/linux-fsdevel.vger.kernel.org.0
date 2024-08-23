Return-Path: <linux-fsdevel+bounces-26907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBD95CCC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F88E287CEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E3185B43;
	Fri, 23 Aug 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUG/NjTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769A2E3EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417289; cv=none; b=jpaymrdFWC1lbAA3rMxZL/QZ9i4MuXoI6ZSa2tUmJUnqBTuSBncDV39LoAgJRP19GBJdUSAKu3xLju9kmd8msQJSred0mku+pnZjiM3YL2a8U8mcYF/pfJehoX7La0tkC5+C9P6rTBzKwAPKWJz3QJEER2h031qT5lK6NUdUTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417289; c=relaxed/simple;
	bh=7OLmDZCu75NasHW+5eIp0QUqNnOIcdBetyYXHQceP14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmLrelXL2L6874X7qdwcGLi5yfVwQAGkMhm7rR/tj25bH4qz2HUZyqU7cN96msC76zvhmgg/I2rpRRCN36VmSIHsQ1diVrT9gg98p/pSJ83KhHTKm6qtw/qE0dnxyX7xzTjVKBmlg41QxPFOlDzsY1lMdRiDd+SdosLp2V9uZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUG/NjTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A51C4AF0E;
	Fri, 23 Aug 2024 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417288;
	bh=7OLmDZCu75NasHW+5eIp0QUqNnOIcdBetyYXHQceP14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUG/NjTWPKyIPAY/4nv5s0hUmDUwNQP5qufYfjcHxsu7VxZKjQjgpfd5bF6P6Nu4K
	 mIMbTH1u6NU2nAfKKiC0iE9xqkgpplE5Fa0/mDWsJ/zSjUldqUDxGfPq1vT7WqLMQ9
	 AzzedHWdRbnUGw3F+6rylLhhUqLLcnWDuy2v2ARQv0lGONx51j3VLW2MdMuZCj+ofy
	 X4H297XzHbcRgosQfLjMDW19eeBbp+BIOIu9i2yrU7SkygemxUtt5LWWfh/DJlZU+M
	 teOGu/SZ+jUfJRNbjo5MWwtyuxU937/IFrIyJZvUbC+yQbivNXzvw1pMHYURXQCB0K
	 O2yKh6I9cz8rw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/6] inode: port __I_LRU_ISOLATING to var event
Date: Fri, 23 Aug 2024 14:47:39 +0200
Message-ID: <20240823-work-i_state-v3-5-5cd5fd207a57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=brauner@kernel.org; h=from:subject:message-id; bh=7OLmDZCu75NasHW+5eIp0QUqNnOIcdBetyYXHQceP14=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHknvTD0asppsa6lLZpzXz2aeeS9++pHbS4/b4io7 NxidP7wto5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJBAkxMmy642BVvcvYMrTv q8ze5UJ7JX/OZpVZJWZgzdRtIv7hazUjw+arDRzV7nP2LO94f1PQsTTty6WO1c8Z5614n2Rsf6S 8nhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Port the __I_LRU_ISOLATING mechanism to use the new var event mechanism.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 37f20c7c2f72..8fb8e4f9acc3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -511,24 +511,35 @@ static void inode_unpin_lru_isolating(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
 	inode->i_state &= ~I_LRU_ISOLATING;
-	smp_mb();
-	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
+	/* Called with inode->i_lock which ensures memory ordering. */
+	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
 	spin_unlock(&inode->i_lock);
 }
 
 static void inode_wait_for_lru_isolating(struct inode *inode)
 {
+	struct wait_bit_queue_entry wqe;
+	struct wait_queue_head *wq_head;
+
 	lockdep_assert_held(&inode->i_lock);
-	if (inode->i_state & I_LRU_ISOLATING) {
-		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
-		wait_queue_head_t *wqh;
+	if (!(inode->i_state & I_LRU_ISOLATING))
+		return;
 
-		wqh = bit_waitqueue(&inode->i_state, __I_LRU_ISOLATING);
+	wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
+	for (;;) {
+		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
+		/*
+		 * Checking I_LRU_ISOLATING with inode->i_lock guarantees
+		 * memory ordering.
+		 */
+		if (!(inode->i_state & I_LRU_ISOLATING))
+			break;
 		spin_unlock(&inode->i_lock);
-		__wait_on_bit(wqh, &wq, bit_wait, TASK_UNINTERRUPTIBLE);
+		schedule();
 		spin_lock(&inode->i_lock);
-		WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	}
+	finish_wait(wq_head, &wqe.wq_entry);
+	WARN_ON(inode->i_state & I_LRU_ISOLATING);
 }
 
 /**

-- 
2.43.0


