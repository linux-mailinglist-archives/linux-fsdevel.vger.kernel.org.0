Return-Path: <linux-fsdevel+bounces-58650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA96B30650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB23A5B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60C3128DB;
	Thu, 21 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T8JgXSD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9352E88B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807638; cv=none; b=Xywu2adbZlmm6v5PWcl2I7JI/6vBwg/rIt/nvC8LsQ3JJpQEvB/x/wreVrTNvZuTd1+luFxt+Zea6l3wpVOusZLkuJy6ncGOGGTACiHA6FMJJuADEaFrWU0fCjAbCW1VAA6E0IKqWFp9tB+g4NkwwuHOyHcuz6rn42yq9kqPUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807638; c=relaxed/simple;
	bh=VctpFBGHU9fl50Cab/W04C4aV+TEyk9wQpprZfPFgXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhhPORK0aRQhMtm5whiJby63DFD4nC11DiE+cNcAolsaAAW8Qi/coqbUsRYlsEqLFlEVAojLhZ7GWC8qQth3KM5C6JlvUElpIg7xw80ZxLpSUTAZ3bUvhT2ZkcwiwwLtHbleRDDSEvGcaJieIqTSUjGFlmmHewiaPM78QdaOZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T8JgXSD/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504db9so11645997b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807635; x=1756412435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0oLPRCL+kdVKzhAc+n1SeA8IVQ5ey7MG0Wg13YWNIA=;
        b=T8JgXSD/o2VK0weC7b1D3uiTxvOfmJve1MLg2r5DoJ+tk/FJ7MkhB+4uDjCgMjM4Ie
         zzhTzZyy9F9gTA8Dt5Q0+wNqkgv7haP4VTKAzAG4ubOQqR31MilZnOIegBZoBdo0KSwC
         C9rfz7vp4EHdllshZ9suAmPLDVqBqRUvrstyxYmmgecuy/ETXwtd8uQVRS7Lp8d4PkOs
         gbX8v1BqE72gjr3ulTLV+u6wpyFcYOTSSEJC6LoUWlAcW2PMXtEvaRfEPQCByDXajyf6
         hhF0PV76iuRcNdAD8uS8Bi9WDcLI/zKcIYm/oFgldP/6ZRJgQK1XLkbmsJ6gBIdrpdpS
         te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807635; x=1756412435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0oLPRCL+kdVKzhAc+n1SeA8IVQ5ey7MG0Wg13YWNIA=;
        b=fh81x7Kgd0o14+VqjNmiyw036Avyjtqy44FMEq8GRmCG2zad+4BvpCKlPLQvIjEqeH
         Qq2zdppCVyI3X71P9QW7sWVF8vcQreC/Uc5MGAmPNlbCCeYUQ4LYAvwERkKR46B1Q7HK
         x14fmO6kP9ZgTKbth59YBuhtaWSrT3obmyx6mqY2Nz/VAR18F3IjxJBkGh6ys2XDPqrs
         w/p9CQ8Jcrm1mE4x/5D0fwhkY7jEMtR9bfcIFDXvFJAcxt9zvOCiyAd1ROplXvFHQMd/
         qtou9CUyIewZb4EZV/9HgpyPBxf1p7GDKKMf2ytWw3C5Cwk5MRyu8SG/irj/hGsyLuv/
         2pLw==
X-Gm-Message-State: AOJu0YzmGfl3O3IcAsV0mwJ7+sN/N3EqBpiu8Agin0+XTvQsTAQm/0kE
	MI8TW0SRJ6d7ehp0njvT4ApWoe+555UxRKX9QFjVfo6ydf52gUJxIrM4PUXSwvjUIeFSJhCtyfs
	5pAwdvp+Meg==
X-Gm-Gg: ASbGncu2r4I2OOGzGT/AIdCcGSxk1XsIgKjWxiVy04prUgnLeSHweIsLLh29SJHnAIh
	GxdMAJA2ukQnHiIsz0eBr0hebPGQAyJgud4vv3QLeQwdohZIjRMFH1pFod8p7AWH4DtYT8kWBA8
	7yIm/zi7427N0kDWrEyXlZhtTnfE86CxNLyEk9b+tU+F5vpBUOu/KvNbJFzAcuIIX4HlgV1EZ/f
	Ch6UAtyFbVMG7gIS8gBjx7GDDT+NEHueVArPXqxtO3yj8QZBLKMRTUeeEe9r+HCQsqD1e14uZRp
	x+mPucjbANj8TUrdzSwogz6Djrg63GOgMHAktjqJORNeF8XouEgn2xKrwXkw1pNHZ9axZa/kwn1
	EVKqwMcDVo1Ar4Tt06HyFfTFIMzjW5487uwaHChY5u9j/BrGyg4yT7JdKlqFx/NPgZrqvoA==
X-Google-Smtp-Source: AGHT+IELGOXi/q8OA+QNnctJTP5cMeQZFEV3W0NZvU/VyAsp5aF1Tkq9N/xrCeUTy6X6MIsWCpH29A==
X-Received: by 2002:a05:690c:6413:b0:71f:c7ae:fb80 with SMTP id 00721157ae682-71fdc3cf564mr6421167b3.30.1755807634852;
        Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c1dda5fsm58714d50.4.2025.08.21.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 13/50] fs: add an I_LRU flag to the inode
Date: Thu, 21 Aug 2025 16:18:24 -0400
Message-ID: <16c9c4ffea05cdf819d002eb0f65a90a23cb019b.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will be adding another list for the inode to keep track of inodes
that are being cached for other reasons. This is necessary to make sure
we know which list the inode is on, and to differentiate it from the
private dispose lists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 7 +++++++
 include/linux/fs.h               | 6 ++++++
 include/trace/events/writeback.h | 3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 814c03f5dbb1..94769b356224 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -545,6 +545,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		iobj_get(inode);
+		inode->i_state |= I_LRU;
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -574,7 +575,11 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (!(inode->i_state & I_LRU))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		inode->i_state &= ~I_LRU;
 		iobj_put(inode);
 		this_cpu_dec(nr_unused);
 	}
@@ -955,6 +960,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	    (inode->i_state & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
+		inode->i_state &= ~I_LRU;
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -991,6 +997,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode->i_state & I_NEW);
 	inode->i_state |= I_FREEING;
+	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b2048fd9c300..509e696a4df0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,11 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_LRU		Inode is on the LRU list and has an associated LRU
+ *			reference count. Used to distinguish inodes where
+ *			->i_lru is on the LRU and those that are using ->i_lru
+ *			for some other means.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -780,6 +785,7 @@ enum inode_state_bits {
 	INODE_BIT(I_DONTCACHE),
 	INODE_BIT(I_SYNC_QUEUED),
 	INODE_BIT(I_PINNING_NETFS_WB),
+	INODE_BIT(I_LRU),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..486f85aca84d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_LRU,			"I_LRU"}		\
 	)
 
 /* enums need to be exported to user space */
-- 
2.49.0


