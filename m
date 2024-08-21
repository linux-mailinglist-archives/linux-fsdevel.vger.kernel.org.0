Return-Path: <linux-fsdevel+bounces-26486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B195A208
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7131F2285E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60B1B253C;
	Wed, 21 Aug 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYy42BsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A014E2DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255274; cv=none; b=JM1YHSgDFkNIjF/iRxhOTySTTWUkO5gq4QtvwB73twmvi5FoQZI4YYsMM2GS5vwb4X6gjUea0pIMEoCg7/CesvMOB4+4zqNOzF5h6XWL3TJIk+PEkg3D2XK4HocOP0912Tvb7Yf0oMkUZDFkRddygjxKD2EH/X1E9TJsbY80e9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255274; c=relaxed/simple;
	bh=XF9SEBq1qMuC+NzeqEU27oTFpHcRw695qJXpLUMxlVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tINCr3bYQTwAuvHWZ+M5PL5OOG1Uqb/B8gTGUFoCPjvwpHqoZSzDho5EZbt8jPkWqokJzDzK2QuFNufyaqYxiwLFIxJkQub0Gi9wnv6js838r2UUVy+GA906ELJEgwai/Qa4kjax6J5qPrLrVEf+msbztppRNxs/xOkMTTEpINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYy42BsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C93CC4AF0E;
	Wed, 21 Aug 2024 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255274;
	bh=XF9SEBq1qMuC+NzeqEU27oTFpHcRw695qJXpLUMxlVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lYy42BsQ+msJi3j1D1SAl20L+VHNHIZUwqprOVxxa3R7O4PdJbZgzaP7O85JJTfaP
	 1tcSd2C+ZMncoNaHZvDDnpAWIaLdTRiWGSkdhLrzc1Sga0RAZQ/55HfApBYdnX1j7k
	 o1GOpCGy5Q0VQBksnB982Mc0G3Qo21rYxIyqmjLmwrWTeMWsVpeq/gKupQaZpODzci
	 mg5iWdikxIeBOnOtvlou2MHDIQv+wQ5R6Hp6rxFlynNBGpLbn6iM6qcvxqwXwD9Uzt
	 pvlsywoxmhyUoo/w+LnzaHIH8AuAqT9oE8+NtW9Fj5nqOCii6CiiCeta0Bk7tW+wht
	 uL3m0IANzlXhw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:31 +0200
Subject: [PATCH RFC v2 1/6] fs: add i_state helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-1-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XF9SEBq1qMuC+NzeqEU27oTFpHcRw695qJXpLUMxlVQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41ERmPS1/4Wqk5ZXxYkZQscVNrG8XsOwYXWM2Ipfy
 7wE/esEO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSdJSRYa3D4UaBaydlkiaF
 +c/cvpvxxwGmjBCtCzP6qtbtVroSX8vw37ni/mzW1Hs7uGderGqMerbnlaOJ0uTy/dMYzpx4+U3
 clAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The i_state member is an unsigned long so that it can be used with the
wait bit infrastructure which expects unsigned long. This wastes 4 bytes
which we're unlikely to ever use. Switch to using the var event wait
mechanism using the address of the bit. Thanks to Linus for the address
idea.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c         | 10 ++++++++++
 include/linux/fs.h | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 154f8689457f..f2a2f6351ec3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -472,6 +472,16 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		inode->i_state |= I_REFERENCED;
 }
 
+struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
+					    struct inode *inode, u32 bit)
+{
+        void *bit_address;
+
+        bit_address = inode_state_wait_address(inode, bit);
+        init_wait_var_entry(wqe, bit_address, 0);
+        return __var_waitqueue(bit_address);
+}
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23e7d46b818a..a5b036714d74 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,22 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * Get bit address from inode->i_state to use with wait_var_event()
+ * infrastructre.
+ */
+#define inode_state_wait_address(inode, bit) ((char *)&(inode)->i_state + (bit))
+
+struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
+					    struct inode *inode, u32 bit);
+
+static inline void inode_wake_up_bit(struct inode *inode, u32 bit)
+{
+	/* Ensure @bit will be seen cleared/set when caller is woken up. */
+	smp_mb();
+	wake_up_var(inode_state_wait_address(inode, bit));
+}
+
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
 
 static inline unsigned int i_blocksize(const struct inode *node)

-- 
2.43.0


