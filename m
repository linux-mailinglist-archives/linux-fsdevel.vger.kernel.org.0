Return-Path: <linux-fsdevel+bounces-26487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D795A209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0636E28F3DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B71BAEC6;
	Wed, 21 Aug 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0tBarSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681B1B2EC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255277; cv=none; b=CkMzSTYFk0Flh6lf88m3aQmaMbpDj9wEcTIIr63woOyiYHnVBGRYrWGhGD3vzZH6tXPBQZLUC24h4RskLPuf/3qLpdeEFaeV/JQCL97gtOJ478OfMENxUHhTIZ7WRVAHQLLCZClgEwHAQYU5lI3AD/7igdT25p2P7lxu3ZcVa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255277; c=relaxed/simple;
	bh=/3yj47Hfp+aYIGBiKeBK2KYt5E2v876vvMCX+8FWM1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwbiQfJDG/3qwGmmNdRmEB2a088iVBuBJbY2CIV1XrEDa5XgYi3P6HbImCGetU83c7DSyAaE+zOjNIm6v8OzLZ08R1uYVFp5oJOuTSTqJOI+ryjERbbpvA4u+BKAUY/WqjHyEKuuHxrxjI5tGKdePQsZ2lz5kUbzCaz8wrC/iEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0tBarSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC840C32786;
	Wed, 21 Aug 2024 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255276;
	bh=/3yj47Hfp+aYIGBiKeBK2KYt5E2v876vvMCX+8FWM1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l0tBarSm9QbWx/vWUbQkYAgiXSzo1cxUcBKBxCFCdAYnTV3Dn4Hk1LlvQmEi5ckaa
	 Kk2Kcmckux/k/TlI00NgHyFvAoV4ZdmXOwHqbBFNTvgc9P7w20Qn22L9VbqdU3ldAm
	 ODOpm8N/28K/C1ax7AGcLvVreEeazoHhSdthyESoukKLLpTwHaDTmX0JLz8l95iGaF
	 Zi55VpbWHeNQ3vO+Ie1mkeDwhCgB6uwdmJNv8aeyq+TUqJUy/0S/6vNT+647T5yF6g
	 41joKWkviTYBvZjWQhO7dtzKwnDh0dGP6pR4rcWhfwoTF4jCm0l5zpUTR/bMf3GswH
	 hRQoq2hDRKjag==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:32 +0200
Subject: [PATCH RFC v2 2/6] fs: reorder i_state bits
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-2-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/3yj47Hfp+aYIGBiKeBK2KYt5E2v876vvMCX+8FWM1w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41GZ+lmG80Uza8X8KzdbM1pN/cKrnSpdnMrSjDzXL
 H8tVvGvo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIl3owMRz5ePzqJO+LG5Z3F
 C5gXtc0Rij/2afIJi+qNFoaBXPl59Qz/062sNl5iqHt4yqN6kf4jt8NTNXe9jc18e/LWVfuqotj
 /XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

so that we can use the first bits to derive unique addresses from
i_state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a5b036714d74..8525f8bfd7b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2418,28 +2418,32 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
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


