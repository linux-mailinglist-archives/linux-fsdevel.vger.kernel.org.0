Return-Path: <linux-fsdevel+bounces-26904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7095CCC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF8E2862D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C618453A;
	Fri, 23 Aug 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJXgF/hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E06136E2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417281; cv=none; b=WSKc05hEcFy1ZU/GydYY2WusGsRBXcSK8ZimZtRlskPTvj+KHXEpQgvCvdDvrLbdSB+Sk5p4xCi/t8+U2uj9TLMJQjMKQTlk+aIAgSiTsPWS6Z3PK/qmcGc2j1fmKd/L+DTaFv0lfWltcB03so0K9oTo2fK/IWvMpabvH5u2cek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417281; c=relaxed/simple;
	bh=1RT5slxrbwBkxDVq5dZF1s58WrwjB/UEkZTkg1cebts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/zVH52ih+vOnlrQR1l44isgCFuKs7ACHyUdCeRW6Cs110hKO5sK3NzOyrAG8SNFOmvoHj1XrC714nAw6X0/kzIo48UftCGaZaWqPWBtN1QdpcOlWM70JQlGd0ML1qHQw0zvF8EJlCe3ziDphHh6vmSZLI+4eMKw+NmfyIV3tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJXgF/hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD51C32786;
	Fri, 23 Aug 2024 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417280;
	bh=1RT5slxrbwBkxDVq5dZF1s58WrwjB/UEkZTkg1cebts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJXgF/hdI+6DkxbsJa6Lk2SM5KuS0gn+oynqjXPfNBYpdVwet5Xlgg/s3dUONUPZ8
	 r5vqAyqxXq1DYK0oR36krGkrAf0mGCR7nFwWlke2s7JW3vxvHQikopFpH8Y6spjJpc
	 vw8tmsRy17OQ6se+MzVieMM9MRd+nhpUJEqMdQCfUMF6cv9q/wb2E5F7LjSOS7g+XK
	 PRQ1ILbalZF7qyZ28XfWp4n9XOmfbsQ3Tu/GPRqSD2L51pS7BST3XZi+Ts9qSglvd9
	 b5LY+Clk0vrw/FkxhayYbmZF66qyadhIcD5wGaNcUUwbnU12Mt1Gu7al5WuMfAQxQW
	 OrNP5LtjrR8yQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/6] fs: reorder i_state bits
Date: Fri, 23 Aug 2024 14:47:36 +0200
Message-ID: <20240823-work-i_state-v3-2-5cd5fd207a57@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=brauner@kernel.org; h=from:subject:message-id; bh=1RT5slxrbwBkxDVq5dZF1s58WrwjB/UEkZTkg1cebts=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHnzzGJDm9GuVUx7WDIs7f35l8xq790aZ+RQ4tLv1 Hm3RuBeRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETuH2Vk2CzZ352W/dFuezrf 9tPvW4K+Naz9kZDR4HyY32rmjKafmxn+Zz7gyXfyVn1nYveX65lc4QYb99/CrlFr7opuPt6zxi2 fDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

so that we can use the first bits to derive unique addresses from
i_state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1d895b8cb801..f257f8fad7d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2417,28 +2417,32 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			i_count.
  *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
+ *
+ * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
+ * upon. There's one free address left.
  */
-#define I_DIRTY_SYNC		(1 << 0)
-#define I_DIRTY_DATASYNC	(1 << 1)
-#define I_DIRTY_PAGES		(1 << 2)
-#define __I_NEW			3
+#define __I_NEW			0
 #define I_NEW			(1 << __I_NEW)
-#define I_WILL_FREE		(1 << 4)
-#define I_FREEING		(1 << 5)
-#define I_CLEAR			(1 << 6)
-#define __I_SYNC		7
+#define __I_SYNC		1
 #define I_SYNC			(1 << __I_SYNC)
-#define I_REFERENCED		(1 << 8)
+#define __I_LRU_ISOLATING	2
+#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
+
+#define I_DIRTY_SYNC		(1 << 3)
+#define I_DIRTY_DATASYNC	(1 << 4)
+#define I_DIRTY_PAGES		(1 << 5)
+#define I_WILL_FREE		(1 << 6)
+#define I_FREEING		(1 << 7)
+#define I_CLEAR			(1 << 8)
+#define I_REFERENCED		(1 << 9)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
-#define I_WB_SWITCH		(1 << 13)
-#define I_OVL_INUSE		(1 << 14)
-#define I_CREATING		(1 << 15)
-#define I_DONTCACHE		(1 << 16)
-#define I_SYNC_QUEUED		(1 << 17)
-#define I_PINNING_NETFS_WB	(1 << 18)
-#define __I_LRU_ISOLATING	19
-#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
+#define I_WB_SWITCH		(1 << 12)
+#define I_OVL_INUSE		(1 << 13)
+#define I_CREATING		(1 << 14)
+#define I_DONTCACHE		(1 << 15)
+#define I_SYNC_QUEUED		(1 << 16)
+#define I_PINNING_NETFS_WB	(1 << 17)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)

-- 
2.43.0


