Return-Path: <linux-fsdevel+bounces-26374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47584958BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FF91C21DA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB591B86C7;
	Tue, 20 Aug 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIb3T/oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1481AD9D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170047; cv=none; b=EXMXg6244CJEFh7rnlOu89fm35AhhEzxpMAhtZGoJPY8Ya8raZ5BkB/gD/0wrMu8OZlQ4t1V9Q83gFFwVl02wfUQQK9mn8zmdAkpq7cOzkRlefnj6YwC5WS723StE2m63mtJHJWKlnm6LBcBTJGtFe01x8kPXG8h0Dx3TASFjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170047; c=relaxed/simple;
	bh=wfrOhSbGNbWhAZAXg1FilaXtrweZe6ZJJcqAlAoMrMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaW8wsrgqaDUQ/SOfcVQ3F261O2RNrFQFzzyiM2CqZ051YzOAXmzln9AZmB9uY8QP5XScYNQ4zu217vzseE/jEDu+aiqzQGG8fxVc0l/XvEMW58NvLdjwgZDK6ReRC6ST8PEq3cdnXJnqJQ6xI1+RKXloWN8WqS80zhVYCquU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIb3T/oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A9C4AF0F;
	Tue, 20 Aug 2024 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170046;
	bh=wfrOhSbGNbWhAZAXg1FilaXtrweZe6ZJJcqAlAoMrMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIb3T/oCyaM4iwAcyDp9gelOVRTlpMZ/6y9K5W3hQ6uLN1mNaSx7U/DDgBPQMDY0q
	 fmZ390PRYCDN8ZqsaPUoP8MXTHi+rDb51Bkhpw2VJmh/EFwGFfwA2oTFmH4628UXls
	 qccWtTflq18yqyClbUy/B1+woEUhU6XAyTSWMQLLFa2bDEf22TbAF2cn+xoy9cW0ew
	 4EMiNUDkpP3V7gFrRIy57jfAsVQu9hZZ3JAZNGzY0m7nxBLibHaDLDbv4kccGKFTZg
	 LM8K9Bx023aFdRHyLhKQg/xask7TD5Jm0DnLcNdRfra5zWRgtHBQNtriaIyughQWJJ
	 poSYtd9/TeFXg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 1/5] fs: add i_state helpers
Date: Tue, 20 Aug 2024 18:06:54 +0200
Message-ID: <20240820-work-i_state-v1-1-794360714829@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=brauner@kernel.org; h=from:subject:message-id; bh=wfrOhSbGNbWhAZAXg1FilaXtrweZe6ZJJcqAlAoMrMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2a+gVbq9IU2aj9OH85GDX+eUZXsO3m3q1NvXYloTy WNi4H2qo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIK/xj+SrBPbGSo1OAR2FHn 06RTYlVocWemycr48w8W+FQFv3PbzPBPpfj9Fp8ww8TNnfcEOjyXv3mtNPF/vNXR8ssLD+wwD1z DCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The i_state member is an unsigned long so that it can be used with the
wait bit infrastructure which expects unsigned long. This wastes 4 bytes
which we're unlikely to ever use. Switch to using the var event wait
mechanism using the address of the bit. Thanks to Linus for the address
idea.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c         | 11 +++++++++++
 include/linux/fs.h | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 154f8689457f..d0f614677798 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -472,6 +472,17 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		inode->i_state |= I_REFERENCED;
 }
 
+struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
+					    struct inode *inode, int bit);
+{
+        struct wait_queue_head *wq_head;
+        void *bit_address;
+
+        bit_address = inode_state_wait_address(inode, __I_SYNC);
+        init_wait_var_entry(wqe, bit_address, 0);
+        return __var_waitqueue(bit_address);
+}
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23e7d46b818a..f854f83e91af 100644
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
+					    struct inode *inode, int bit);
+
+static inline void inode_wake_up_bit(struct inode *inode, unsigned int bit)
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


