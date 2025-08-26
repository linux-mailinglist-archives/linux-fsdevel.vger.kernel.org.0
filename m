Return-Path: <linux-fsdevel+bounces-59287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449DB36EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F068E4CC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7937C10C;
	Tue, 26 Aug 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uEB6qwMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C537C0EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222930; cv=none; b=ohoTlvAIDoAW4Q3sXat2+Ls0186G46NBGbk9W+AkPGJU1EWMG5VSr6yf8Q1teOBHN8lVe9Kc/IH/ing37XW9xjSPv7YpNhc/9f36pcwQztEd7e412Lk+qh+YJ5PLqnaeyzoQYiRY0vnNwa7Z+D+gOlxt1uW1BII5+MEk3u0D9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222930; c=relaxed/simple;
	bh=rv5340q/KuN23EdeWFKic/wpgKRZ8sQ4bHsbBfl8dQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB/CknQISE8hCP2ffE2j747PqmNLNv0HJ5or3zCbye6ALFkSAzMPUm/e+XAK5nmFRPfVQqm7W6KDorQd68R0Hc8fxGQhOU7+6SGYnrFJYoy3xbKTkRqziMDrRt7y3sU6UZj6qZDQXmGGAKjf1YKSmQzEw1Y/3o+DHYWT27zkoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uEB6qwMO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b62adso50218337b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222927; x=1756827727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OxiAeJNWcBsPq9sQg5cm2vq7jTlfXU7OwhPV7MWLho=;
        b=uEB6qwMOoiEaf4moXTGIxHwzf4w5d6C9v3b0/dHzt76pW7Be9B8BH+zX3JcVMZ2W8F
         SzB3sDkTMKDpR+s3c1M2TiwQw4/z7kAoywFtjD0rMGzzQoCBldi6Lhf/J8G5iKK4m02E
         KxH2AwcJ+IUSvCjnj/Eufs/z/23yZuIA6cvcHiwZ2YNe8UP3MV2+DxBTA79McpEWU/B/
         OmGPDna+c8SN+KLPgmCsXsbH+lWMCHyWBaFBRKbVa36qgOL1Y+Zvvze7LehK886SOuKR
         chnkFzmGjNEyVPZAuMGY8mEU0+2ua4kAAIHvTiT2upz1yBNrOuFZbC+cuyz7gPp6Kz4u
         zkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222927; x=1756827727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OxiAeJNWcBsPq9sQg5cm2vq7jTlfXU7OwhPV7MWLho=;
        b=kDD5AOdDOpxJjK95Dd6ubHp1UDQsMiYw8FhNu1fAr5PN8/oNarMu8faS8xBhM5cOot
         nRVJqS441ALGNrSILvBgqavWmHovRJTK4RYHBzFs7nI/BtOwFeGJZ9Ftvsv3B2Oshnh7
         /u1eqaz3Mi+ZrdQGNP9mA/w65hdjgf40FEuBgG7ntLUAmVVUY4SwTpkp5rtOPTvc7U9R
         qA0zAkd7WVGTZC79pl1PKGpq8JAeNJyl3MRheiwQgd/hcevrnlmo1eOX2ohUaCb5InZd
         4wWcaCoKY1+wFr4wBloqvKpZv/OvrXTa2W9IWlkWdchmf8TMVT9CsGQRdN4Ps+/Z3oYn
         pF2A==
X-Gm-Message-State: AOJu0Yz3KaxI5yXxuuRVftqIVYj8DLVhSE8qJ4kNSgBY0vguNAVEIhil
	2jyWbl6V4ZWBrppVjjJHTGlLwrvqVaXqBFtVLcob6WHzPH2sw/EoAn8R4rkZeuBtEsX/1SHWG9F
	KKemX
X-Gm-Gg: ASbGnctOWNmURkAddJfy3H7izJfwxWIrtm9Ms92MRMiteePOUP9n6QQuOEAXkWQ5UcI
	ulL2JxtaXz73+hpc2WxHFWStGiaaMu7naNxyjk/vPXspr/0FUn4DnwI3S3wXv6nt5nZxl54NPcz
	/lOOAOndlaDo5jceh9S92OmeTLBqAlChD8TzQadAhjjL9eGQEov1eFdukAyXBks28k/v5h7ExmB
	f6JvUSFDzEpEgpLILf3HwnkvL/z0Eryh/16L9SEMIpVvAo/6XhTe9x3xlY7a30+VB6vpQXFh0Fm
	PXlJOWYn7hKNIzPOzGMcn1ll53DXo9ePuBfkZssdXmGOxGoASIewVk5/O2ECRvLYxdwkTdhyQb+
	Fp1xrLquC1wCZX8JTFVu8jhFjM/MNoyASEr4wBC15jx0q1IWwsfT5P0z8XGp3K6qc+eoS8g==
X-Google-Smtp-Source: AGHT+IFm8jrSmVJUD4m4cBbWsHVbb0tlfxSSSfxl1vpCVzQtcknu2bxRQqSFpPYTNF5kQR73/85h2w==
X-Received: by 2002:a05:690c:4a12:b0:721:24f7:4c54 with SMTP id 00721157ae682-72124f74e06mr44158917b3.51.1756222926465;
        Tue, 26 Aug 2025 08:42:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1751204sm25411367b3.30.2025.08.26.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 53/54] fs: remove I_LRU_ISOLATING flag
Date: Tue, 26 Aug 2025 11:39:53 -0400
Message-ID: <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode is on the LRU it has a full reference and thus no longer
needs to be pinned while it is being isolated.

Remove the I_LRU_ISOLATING flag and associated helper functions
(inode_pin_lru_isolating, inode_unpin_lru_isolating, and
inode_wait_for_lru_isolating) as they are no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 46 --------------------------------
 include/linux/fs.h               | 39 ++++++++++++---------------
 include/trace/events/writeback.h |  1 -
 3 files changed, 17 insertions(+), 69 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4f77db7aca75..77f009edd5df 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -656,49 +656,6 @@ void inode_lru_list_del(struct inode *inode)
 	}
 }
 
-static void inode_pin_lru_isolating(struct inode *inode)
-{
-	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & I_LRU_ISOLATING);
-	inode->i_state |= I_LRU_ISOLATING;
-}
-
-static void inode_unpin_lru_isolating(struct inode *inode)
-{
-	spin_lock(&inode->i_lock);
-	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
-	inode->i_state &= ~I_LRU_ISOLATING;
-	/* Called with inode->i_lock which ensures memory ordering. */
-	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
-	spin_unlock(&inode->i_lock);
-}
-
-static void inode_wait_for_lru_isolating(struct inode *inode)
-{
-	struct wait_bit_queue_entry wqe;
-	struct wait_queue_head *wq_head;
-
-	lockdep_assert_held(&inode->i_lock);
-	if (!(inode->i_state & I_LRU_ISOLATING))
-		return;
-
-	wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
-	for (;;) {
-		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
-		/*
-		 * Checking I_LRU_ISOLATING with inode->i_lock guarantees
-		 * memory ordering.
-		 */
-		if (!(inode->i_state & I_LRU_ISOLATING))
-			break;
-		spin_unlock(&inode->i_lock);
-		schedule();
-		spin_lock(&inode->i_lock);
-	}
-	finish_wait(wq_head, &wqe.wq_entry);
-	WARN_ON(inode->i_state & I_LRU_ISOLATING);
-}
-
 /**
  * inode_sb_list_add - add inode to the superblock list of inodes
  * @inode: inode to add
@@ -885,7 +842,6 @@ static void evict(struct inode *inode)
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-	inode_wait_for_lru_isolating(inode);
 
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
@@ -1030,7 +986,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	 * be under pressure before the cache inside the highmem zone.
 	 */
 	if (inode_has_buffers(inode) || !mapping_empty(&inode->i_data)) {
-		inode_pin_lru_isolating(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&lru->lock);
 		if (remove_inode_buffers(inode)) {
@@ -1042,7 +997,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(PGINODESTEAL, reap);
 			mm_account_reclaimed_pages(reap);
 		}
-		inode_unpin_lru_isolating(inode);
 		return LRU_RETRY;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 39cde53c1b3b..61113026efd5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -734,9 +734,6 @@ is_uncached_acl(struct posix_acl *acl)
  *
  * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
  *
- * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
- *			i_count.
- *
  * I_LRU		Inode is on the LRU list and has an associated LRU
  *			reference count. Used to distinguish inodes where
  *			->i_lru is on the LRU and those that are using ->i_lru
@@ -745,34 +742,32 @@ is_uncached_acl(struct posix_acl *acl)
  * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
  *			and thus is on the s_cached_inode_lru list.
  *
- * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
- * upon. There's one free address left.
+ * __I_{SYNC,NEW} are used to derive unique addresses to wait upon. There are
+ * two free address left.
  */
 
 enum inode_state_bits {
 	__I_NEW			= 0U,
-	__I_SYNC		= 1U,
-	__I_LRU_ISOLATING	= 2U
+	__I_SYNC		= 1U
 };
 
 enum inode_state_flags_t {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
-	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
-	I_DIRTY_SYNC		= (1U << 3),
-	I_DIRTY_DATASYNC	= (1U << 4),
-	I_DIRTY_PAGES		= (1U << 5),
-	I_CLEAR			= (1U << 6),
-	I_LINKABLE		= (1U << 7),
-	I_DIRTY_TIME		= (1U << 8),
-	I_WB_SWITCH		= (1U << 9),
-	I_OVL_INUSE		= (1U << 10),
-	I_CREATING		= (1U << 11),
-	I_DONTCACHE		= (1U << 12),
-	I_SYNC_QUEUED		= (1U << 13),
-	I_PINNING_NETFS_WB	= (1U << 14),
-	I_LRU			= (1U << 15),
-	I_CACHED_LRU		= (1U << 16)
+	I_DIRTY_SYNC		= (1U << 2),
+	I_DIRTY_DATASYNC	= (1U << 3),
+	I_DIRTY_PAGES		= (1U << 4),
+	I_CLEAR			= (1U << 5),
+	I_LINKABLE		= (1U << 6),
+	I_DIRTY_TIME		= (1U << 7),
+	I_WB_SWITCH		= (1U << 8),
+	I_OVL_INUSE		= (1U << 9),
+	I_CREATING		= (1U << 10),
+	I_DONTCACHE		= (1U << 11),
+	I_SYNC_QUEUED		= (1U << 12),
+	I_PINNING_NETFS_WB	= (1U << 13),
+	I_LRU			= (1U << 14),
+	I_CACHED_LRU		= (1U << 15)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index b419b8060dda..a5b73d25eda6 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -25,7 +25,6 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
 		{I_LRU,			"I_LRU"},		\
 		{I_CACHED_LRU,		"I_CACHED_LRU"}		\
 	)
-- 
2.49.0


