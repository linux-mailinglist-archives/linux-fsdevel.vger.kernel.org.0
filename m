Return-Path: <linux-fsdevel+bounces-26903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F695CCC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D3E1C222F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB66185B60;
	Fri, 23 Aug 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJoceh6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7F136E2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417278; cv=none; b=JOYjfMzU2Y6QOVTXq71Avg0yyTMLgQef4R07FWxAJnNqzy4roUBiiwBPpI4hgWGcQVXtrUFV2K3kSGD0RuZsY3xaTtbsqFaLoL08jVq+uJSybm897AmpM/WU9HJVP8jTk1A0RlbyyvKhrMchHA4BGPXzH+45woOTZIi6dYZsles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417278; c=relaxed/simple;
	bh=61lPVSIVWgcbJa/vf4tJiRjGajVW5ENGjIg6PqK1Lso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le2W2oPA+YRse3C40dfzCrznD7Z7Ae92k9mp9XyWlvKKnlK4hkjOeU+ElRDgPhAakzn2GYUj5sHq1G6iIpKK7uztDfSaZdhRkX6aEYaS04Of1RDMQZoG9jfdt2/rvJJEeNmKNKf8XMKRYTQtm9SmGhAS5O5veXlrwX75ZtueHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJoceh6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE2EC32786;
	Fri, 23 Aug 2024 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417278;
	bh=61lPVSIVWgcbJa/vf4tJiRjGajVW5ENGjIg6PqK1Lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJoceh6iE+jUug7tt+H5mAVdKnka92Pc20uqyoWl+cpZg1GrTmBJ/lhFX6iR3l8hu
	 t3XKKVKN1MvKMPkQtSGa9oD9BybyX5NRMUCHxAVbxpH8TX9VdFFiL8Wf3dUD/A93Qf
	 HjWKmhSBqNHBkaYZ6CluaN9fg7xOlUd9a6763201l705eLnlq84czQXNVC/Ukc/DlZ
	 JD3n5QmY7UF+H40gnkMvbSDqghplF7y0poHLqNnqSacwKD8k8x2H/CUtDHtWjcK+gH
	 qIYg4ugUvDbrZYj6uoc4FJvtcdw5s8IuyKU580xOBKpDSNjD6q0c/F/uqISyJ86nF5
	 qvkjkRiYWO61g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/6] fs: add i_state helpers
Date: Fri, 23 Aug 2024 14:47:35 +0200
Message-ID: <20240823-work-i_state-v3-1-5cd5fd207a57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=brauner@kernel.org; h=from:subject:message-id; bh=61lPVSIVWgcbJa/vf4tJiRjGajVW5ENGjIg6PqK1Lso=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHnzaY2Hmy5zk1N2CN/y8Na1/94ybr7Pbx1yzrnqf GWAoX9/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESuP2H4HytyKPns/ma2yWwc DuLce6fcVU36+yjp71vtVGHH7DNM7IwMN2M/RiodetGzV9Jw1r3Yjm4mhgvVmwPePv6kni2zn0u ZGwA=
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
 include/linux/fs.h | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 154f8689457f..877c64a1bf63 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -472,6 +472,17 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
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
+EXPORT_SYMBOL(inode_bit_waitqueue);
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23e7d46b818a..1d895b8cb801 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,21 @@ struct inode {
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
+	/* Caller is responsible for correct memory barriers. */
+	wake_up_var(inode_state_wait_address(inode, bit));
+}
+
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
 
 static inline unsigned int i_blocksize(const struct inode *node)

-- 
2.43.0


