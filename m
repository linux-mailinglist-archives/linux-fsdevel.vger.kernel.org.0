Return-Path: <linux-fsdevel+bounces-24996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D59478E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C2E1F21D85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3D1547D9;
	Mon,  5 Aug 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsWXntlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A015445B;
	Mon,  5 Aug 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852093; cv=none; b=SyZr/A8HFKpCR8/ihY1TVJrUG/skHWYkvgHQKGchynVV/g729xLoaRJi8gpHVBF4nETc04mrOjUwmUXs7uQV/WPde9aEJSU41L2QFNeunY68urfNNH5wHi2DFR1Zuy9iIW/Lo1NorK3gpHkm8o0IkZTvE5wpFfGhPY4wM+80B7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852093; c=relaxed/simple;
	bh=TxOPNzxjFixmrprA9BCD7mElgRTnYmFnsdC2eDWwCqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bo6YtoCRQg08z1SswYBCmnw0hPeTDJjHzHqVZBrV3afewx1KHYJ/bNqMzzVIjZo2NAOH8HUMRWyurqQsZx0V237NCG8CBNy4qW1XTRdbLaANxtKaI5v5EfAD7itaY7gfeARI00/elRP8FAtFKTDStWipKczA8zQXq9Fy+lb/dP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsWXntlA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso7686154a12.2;
        Mon, 05 Aug 2024 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722852091; x=1723456891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZA0bYigW3JpzWAOgGBsv7C8JuToIAwHT6lFuNhwkI8=;
        b=AsWXntlAtOzk3e7978gnTO8rE7I43yGBiZZ6MtsBV2MqsTW9zG6xAr1CyzHObmrgM8
         5YJPSPw5Z9LC/FfNgO/GCj8gei/Y6H7iyJt/E47sui1DOhHL9XYUTUi28Va+RaPLnWOa
         EgvG3LJbwuaj3MDh5NJz1fXcNNbzl/0BaqoMQmzvp0xbJrkt5rTVM5Um0Rt4C5WcpypY
         s8k0cVcFvfjLi/g0dZ+m899n4Q2nSbrQ+kY8RDn8g3JSWsv1thx92sv9OJtSAkZeQFWM
         TCxtIHtwNWaZFxA0zvuECzKAYeDl1D3bqshVeydwCWawPujHj7XTZHk2D6OSH9zU3gUB
         1bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852091; x=1723456891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZA0bYigW3JpzWAOgGBsv7C8JuToIAwHT6lFuNhwkI8=;
        b=vRQc3UdKj2ym9kmGzDpD1w7bYYnrnX6vu1Zid59n7odXNOE9r8uONbD2Lx5L5gpZNf
         Tza3h96gStpXkJGduRI6CDWsBgjf3y/pKuEnKsrZ+b4OqSjn3s1qGBcNiHnX0ms6mubz
         WU2PKrhz5QQfTcc2TTx30KQpVuKbQEYp2hOMw27yN43j+XsagOHPpMT25d3dJxM0FMDN
         xg46Da84Tmruq7SEVmqX4UhIRt7ZSogtpO5uF1TM02wruefrotRVyjQLD8E6yGDlcDnq
         YNspsoF/PItQm/BvuCWUMKObBKnrsI1Ue13ok3vIOtS36nBYKAeB8jroMNTa0o9Glvue
         v61A==
X-Forwarded-Encrypted: i=1; AJvYcCURvImSFGEtHeyt6eKbVlU1TjjFw5/7gyu7NtW8b7+P1ihZatzmeA3Ikgn3wxsxlJXqQCQrrK7LqfYSoqloasEn96H4xAb8wnJrGFOtl7YFGkZ+wR0lPumGAFbCvpPn9icAw8RQhR1Wxan53Q==
X-Gm-Message-State: AOJu0Yx23Yq16LEd/2AlIJDSY8+0l0g4vovd2eeGH202SUZGJbyg6KDC
	jn4mAptS4sMtvyYbz+C2z8wbOSgw9OMtWOmAcAksKGl7lXfXDeuY
X-Google-Smtp-Source: AGHT+IHDrgilATsoibs786tnSqRZr4BRhuEQbW7AP1ygdyPOIgcJ3Ug0VmAsnUVLI8oB+Xt3vz/1HA==
X-Received: by 2002:a17:90b:3884:b0:2cb:50ff:732e with SMTP id 98e67ed59e1d1-2cff957fe03mr12541843a91.42.1722852090662;
        Mon, 05 Aug 2024 03:01:30 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cffaf95a15sm6627132a91.15.2024.08.05.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:01:29 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Date: Mon,  5 Aug 2024 19:01:09 +0900
Message-Id: <20240805100109.14367-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implementation of new Hash Tree [PATCH v2]
------------------------------------------
Add spinlock.h and rcupdate.h in the include/linux/htree.h
Add htree_root structue to interface locking.
htree_root.ht_lock is spinlock_t to run spin_lock.
htree_root.ht_first is __rcu type to access rcu API.
Access the kernel standard API using macros.

full source:
------------
https://github.com/kernel-bz/htree.git

Manual(PDF):
------------
https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 include/linux/htree.h | 117 ++++++++++++++++++++++++++-
 lib/htree-test.c      | 182 ++++++++++++++++++++++--------------------
 lib/htree.c           |  29 ++++++-
 3 files changed, 238 insertions(+), 90 deletions(-)

diff --git a/include/linux/htree.h b/include/linux/htree.h
index c7b10c5b9bf2..c5bc2858e7fd 100644
--- a/include/linux/htree.h
+++ b/include/linux/htree.h
@@ -15,6 +15,8 @@
 #include <linux/hash.h>
 #include <linux/hashtable.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 
 /*
  size of one hash tree struct: [16]Bytes
@@ -112,6 +114,17 @@ enum ht_flags {			/* htf: htree working flags (keep order) */
 	htf_freed,
 };
 
+struct htree_root {				/* root: hash tree root */
+	spinlock_t		ht_lock;	/* lock while update */
+	struct hash_tree __rcu 	*ht_first;	/* start of the hash tree */
+};
+
+#define DEFINE_HTREE_ROOT(name)					\
+	struct htree_root name = { 				\
+		.ht_lock = __SPIN_LOCK_UNLOCKED(name.ht_lock),	\
+		.ht_first = NULL,				\
+	}
+
 #define HTREE_BITS_START	8	/* start of hash bits(default) */
 #define HTREE_BITS_END		3	/* end of hash bits */
 #define HTREE_BITS_SHIFT	3	/* shift of hash bits */
@@ -235,7 +248,7 @@ struct htree_data *ht_insert(struct htree_state *hts, struct hash_tree *htree,
 struct htree_data *ht_erase(struct htree_state *hts,
 			    struct hash_tree *htree, u64 index);
 
-enum ht_flags ht_destroy(struct htree_state *hts, struct hash_tree *htree);
+enum ht_flags ht_destroy_lock(struct htree_state *hts, struct htree_root *root);
 
 void ht_statis(struct htree_state *hts, struct hash_tree *htree,
 	       s32 *acnt, u64 *dcnt);
@@ -243,5 +256,107 @@ void ht_statis(struct htree_state *hts, struct hash_tree *htree,
 struct htree_data *ht_most_index(struct htree_state *hts, 
 				 struct hash_tree *htree);
 
+/* spin_lock API */
+#define ht_trylock(xa)          spin_trylock(&(xa)->ht_lock)
+#define ht_lock(xa)             spin_lock(&(xa)->ht_lock)
+#define ht_unlock(xa)           spin_unlock(&(xa)->ht_lock)
+#define ht_lock_bh(xa)          spin_lock_bh(&(xa)->ht_lock)
+#define ht_unlock_bh(xa)        spin_unlock_bh(&(xa)->ht_lock)
+#define ht_lock_irq(xa)         spin_lock_irq(&(xa)->ht_lock)
+#define ht_unlock_irq(xa)       spin_unlock_irq(&(xa)->ht_lock)
+#define ht_lock_irqsave(xa, flags) \
+                                spin_lock_irqsave(&(xa)->ht_lock, flags)
+#define ht_unlock_irqrestore(xa, flags) \
+                                spin_unlock_irqrestore(&(xa)->ht_lock, flags)
+#define ht_lock_nested(xa, subclass) \
+                                spin_lock_nested(&(xa)->ht_lock, subclass)
+#define ht_lock_bh_nested(xa, subclass) \
+                                spin_lock_bh_nested(&(xa)->ht_lock, subclass)
+#define ht_lock_irq_nested(xa, subclass) \
+                                spin_lock_irq_nested(&(xa)->ht_lock, subclass)
+#define ht_lock_irqsave_nested(xa, flags, subclass) \
+                spin_lock_irqsave_nested(&(xa)->ht_lock, flags, subclass)
+
+
+static inline void htree_root_alloc(struct htree_state *hts,
+		struct htree_root *root)
+{
+	rcu_assign_pointer(root->ht_first, ht_table_alloc(hts));
+}
+
+static inline struct hash_tree *htree_first_rcu(const struct htree_root *root)
+{
+	return rcu_dereference_check(root->ht_first,
+			lockdep_is_held(&root->ht_lock));
+}
+
+static inline struct hash_tree *htree_first_rcu_locked(const struct htree_root *root)
+{
+	return rcu_dereference_protected(root->ht_first,
+			lockdep_is_held(&root->ht_lock));
+}
+
+
+static inline __must_check struct htree_data *ht_insert_lock(
+		struct htree_state *hts, struct htree_root *root,
+		struct htree_data *hdata, enum ht_flags req)
+{
+	ht_lock(root);
+	hdata = ht_insert(hts, htree_first_rcu_locked(root), hdata, req);
+	ht_unlock(root);
+	return hdata;
+}
+
+static inline __must_check struct htree_data *ht_insert_lock_irq(
+		struct htree_state *hts, struct htree_root *root,
+		struct htree_data *hdata, enum ht_flags req)
+{
+	ht_lock_irq(root);
+	hdata = ht_insert(hts, htree_first_rcu_locked(root), hdata, req);
+	ht_unlock_irq(root);
+	return hdata;
+}
+
+static inline __must_check struct htree_data *ht_insert_lock_irqsave(
+		struct htree_state *hts, struct htree_root *root,
+		struct htree_data *hdata, enum ht_flags req)
+{
+	unsigned long flags;
+	ht_lock_irqsave(root, flags);
+	hdata = ht_insert(hts, htree_first_rcu_locked(root), hdata, req);
+	ht_unlock_irqrestore(root, flags);
+	return hdata;
+}
+
+static inline __must_check struct htree_data *ht_erase_lock(
+		struct htree_state *hts, struct htree_root *root, u64 index)
+{
+	struct htree_data *hdata;
+	ht_lock(root);
+	hdata = ht_erase(hts, htree_first_rcu_locked(root), index);
+	ht_unlock(root);
+	return hdata;
+}
+
+static inline __must_check struct htree_data *ht_erase_lock_irq(
+		struct htree_state *hts, struct htree_root *root, u64 index)
+{
+	struct htree_data *hdata;
+	ht_lock_irq(root);
+	hdata = ht_erase(hts, htree_first_rcu_locked(root), index);
+	ht_unlock_irq(root);
+	return hdata;
+}
+
+static inline __must_check struct htree_data *ht_erase_lock_irqsave(
+		struct htree_state *hts, struct htree_root *root, u64 index)
+{
+	unsigned long flags;
+	struct htree_data *hdata;
+	ht_lock_irqsave(root, flags);
+	hdata = ht_erase(hts, htree_first_rcu_locked(root), index);
+	ht_unlock_irqrestore(root, flags);
+	return hdata;
+}
 
 #endif	/* _LINUX_HTREE_H */
diff --git a/lib/htree-test.c b/lib/htree-test.c
index 05b60da271de..5bf862706ce2 100644
--- a/lib/htree-test.c
+++ b/lib/htree-test.c
@@ -1,6 +1,6 @@
 ﻿// SPDX-License-Identifier: GPL-2.0-only
 /*
- *  htree/htree-api.c
+ *  htree/htree-test.c
  *  Hash-Trees test codes to verify
  *
  *  Copyright(C) 2024, JaeJoon Jung <rgbi3307@gmail.com>
@@ -17,28 +17,30 @@
 	Hash Tree API flow
 	------------------
 
-	*hts = ht_hts_alloc()		//alloc hts
-	ht_hts_clear_init(hts, ...)
+	DEFINE_HTREE_ROOT(ht_root);		//define htree_root
 
-	*htree = ht_table_alloc(hts)	//alloc first(depth:0) htree
+	*hts = ht_hts_alloc();			//alloc hts
+	ht_hts_clear_init(hts, ...);
+
+	htree_root_alloc(hts, &ht_root);	//alloc first hash tree
 
 	run_loop() {
 
-		*udata = _data_alloc(index)		//alloc udata
+		*udata = _data_alloc(index);	//alloc udata
 
-		ht_insert(hts, htree, udata->hdata, ..)
-		ht_erase(hts, htree, index)
-		hdata = ht_find(hts, htree, index)
-		hdata = ht_most_index(hts, htree)
+		ht_insert_lock(hts, &ht_root, udata->hdata, ..);
+		ht_erase_lock(hts, &ht_root, index);
+		hdata = ht_find(hts, ht_root.ht_first, index);
+		hdata = ht_most_index(hts, ht_root.ht_first);
 
-		ht_statis(hts, htree, ...)
+		ht_statis(hts, ht_root.ht_first, ...);
 	}
 
-	htree_erase_all(hts, htree)	//remove all udata
+	htree_erase_all_lock(hts, &ht_root)	//remove all udata
 
-	ht_destroy(hts, htree)		//remove all htree
+	ht_destroy_lock(hts, &ht_root)		//remove all htree
 
-	kfree(hts)			//remove hts
+	kfree(hts)				//remove hts
 */
 
 
@@ -75,6 +77,8 @@
 
 #define HTREE_TEST_SCHED_CNT	200
 
+DEFINE_HTREE_ROOT(ht_root);
+
 struct data_struct {
 	/* user defined data members ... */
 	char a;
@@ -361,19 +365,19 @@ static void __htree_debug_walks_all(struct htree_state *hts,
 /**
  * htree_walks_all_debug - display to debug all indexes
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  * @index: index to find
  *
  * this function cycles through all hash tables and outputs all indexes.
  */
 static void htree_debug_walks_all(struct htree_state *hts,
-				  struct hash_tree *htree, u64 index)
+				  struct htree_root *root, u64 index)
 {
 	pr_ht_debug("[@@@@) walking: sbit:%u, dmax:%u, acnt:%d, dcnt:%llu\n\n",
 		    hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
 
 	hts->dept = 0;
-	__htree_debug_walks_all(hts, htree, index);
+	__htree_debug_walks_all(hts, htree_first_rcu(root), index);
 
 	pr_ht_debug("(@@@@] done: sbit:%u, dmax:%u, acnt:%d, dcnt:%llu\n\n",
 		    hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
@@ -381,14 +385,14 @@ static void htree_debug_walks_all(struct htree_state *hts,
 #endif	/* HTREE_DEBUG_DETAIL */
 
 /**
- * __htree_erase_all - erase udata all
+ * __htree_erase_all_lock - erase udata all
  * @hts: htree_state pointer
  * @htree: hash_tree root pointer
  * @erased: erased udata count
  *
  * this function cycles through all hash tables and erase udata all
  */
-static void __htree_erase_all(struct htree_state *hts,
+static void __htree_erase_all_lock(struct htree_state *hts,
 			     struct hash_tree *htree, u64 *erased)
 {
 	u8 bits, ncnt;
@@ -421,7 +425,7 @@ static void __htree_erase_all(struct htree_state *hts,
 			hts->dept++;
 			pnum = anum;
 			/* recursive call */
-			__htree_erase_all(hts, _next, erased);
+			__htree_erase_all_lock(hts, _next, erased);
 			anum = pnum;
 			hts->dept--;
 		} else {
@@ -431,13 +435,13 @@ static void __htree_erase_all(struct htree_state *hts,
 }
 
 /**
- * htree_erase_all -  erase udata all
+ * htree_erase_all_lock -  erase udata all
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  *
  * return: erased all udata count
  */
-static u64 htree_erase_all(struct htree_state *hts, struct hash_tree *htree)
+static u64 htree_erase_all_lock(struct htree_state *hts, struct htree_root *root)
 {
 	u64 erased = 0;
 
@@ -445,7 +449,10 @@ static u64 htree_erase_all(struct htree_state *hts, struct hash_tree *htree)
 		   hts->sbit, hts->dmax, hts->acnt, hts->dcnt);
 
 	hts->dept = 0;
-	__htree_erase_all(hts, htree, &erased);
+
+	ht_lock(root);
+	__htree_erase_all_lock(hts, htree_first_rcu_locked(root), &erased);
+	ht_unlock(root);
 
 	pr_ht_info("(~~~~] done: sbit:%u, acnt:%d, dcnt:%llu, erased:%llu\n\n",
 		   hts->sbit, hts->acnt, hts->dcnt, erased);
@@ -456,7 +463,7 @@ static u64 htree_erase_all(struct htree_state *hts, struct hash_tree *htree)
 /**
  * _htree_insert_range - insert udata to hash tree using ht_insert()
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  * @start: start index to insert
  * @end: end index to insert
  * @gap: gap between indices
@@ -466,7 +473,7 @@ static u64 htree_erase_all(struct htree_state *hts, struct hash_tree *htree)
  * if req is htf_ins, the new udata is inserted next to each other.
  * if req is htf_erase, the new udata is inserted, and old udata is erased.
  */
-static u64 _htree_insert_range(struct htree_state *hts, struct hash_tree *htree,
+static u64 _htree_insert_range(struct htree_state *hts, struct htree_root *root,
 			       u64 start, u64 end, u64 gap, enum ht_flags req)
 {
 	u64 index;
@@ -478,7 +485,7 @@ static u64 _htree_insert_range(struct htree_state *hts, struct hash_tree *htree,
 		   start, end, gap);
 	for (index = start; index <= end; index += gap) {
 		udata = _htree_data_alloc(index);
-		rdata = ht_insert(hts, htree, &udata->hdata, req);
+		rdata = ht_insert_lock(hts, root, &udata->hdata, req);
 		if (req == htf_erase && rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
 			if (udata && rdata->index == index) {
@@ -500,12 +507,12 @@ static u64 _htree_insert_range(struct htree_state *hts, struct hash_tree *htree,
 /**
  * _htree_find_range - find udata in the hash tree using ht_find()
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  * @start: start index to find
  * @end: end index to find
  * @gap: gap between indices
  */
-static u64 _htree_find_range(struct htree_state *hts, struct hash_tree *htree,
+static u64 _htree_find_range(struct htree_state *hts, struct htree_root *root,
 			     u64 start, u64 end, u64 gap)
 {
 	u64 index;
@@ -516,7 +523,7 @@ static u64 _htree_find_range(struct htree_state *hts, struct hash_tree *htree,
 	pr_ht_info("[****) finding: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
 	for (index = start; index <= end; index += gap) {
-		rdata = ht_find(hts, htree, index);
+		rdata = ht_find(hts, htree_first_rcu(root), index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
 			if (udata && rdata->index == index) {
@@ -525,6 +532,7 @@ static u64 _htree_find_range(struct htree_state *hts, struct hash_tree *htree,
 				found++;
 			}
 		}
+
 		loop++;
 		if (!(loop % HTREE_TEST_SCHED_CNT))
 			schedule();
@@ -537,23 +545,25 @@ static u64 _htree_find_range(struct htree_state *hts, struct hash_tree *htree,
 /**
  * _htree_erase_range - erase udata from hash tree using ht_erase()
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  * @start: start index to erase
  * @end: end index to erase
  * @gap: gap between indices
  */
-static u64 _htree_erase_range(struct htree_state *hts, struct hash_tree *htree,
+static u64 _htree_erase_range(struct htree_state *hts, struct htree_root *root,
 			      u64 start, u64 end, u64 gap)
 {
 	u64 index;
 	u64 loop = 0, erased = 0;
+	struct hash_tree *htree;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[----) erasing: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
 	for (index = start; index <= end; index += gap) {
-		rdata = ht_erase(hts, htree, index);
+		htree = htree_first_rcu(root);
+		rdata = ht_erase_lock(hts, root, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
 			if (udata && rdata->index == index) {
@@ -580,22 +590,24 @@ static u64 _htree_erase_range(struct htree_state *hts, struct hash_tree *htree,
 /**
  * _htree_update_range - update udata in the hash tree using ft_find()
  * @hts: htree_state pointer
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  * @start: start index to update
  * @end: end index to update
  * @gap: gap between indices
  */
-static u64 _htree_update_range(struct htree_state *hts, struct hash_tree *htree,
+static u64 _htree_update_range(struct htree_state *hts, struct htree_root *root,
 			u64 start, u64 end, u64 gap)
 {
 	u64 index;
 	u64 loop = 0, updated = 0;
+	struct hash_tree *htree;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 
 	pr_ht_info("[####) updating: [s:%llu ... e:%llu] (g:%llu)\n",
 		   start, end, gap);
 	for (index = start; index <= end; index += gap) {
+		htree = htree_first_rcu(root);
 		rdata = ht_find(hts, htree, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
@@ -630,14 +642,14 @@ static u64 _htree_update_range(struct htree_state *hts, struct hash_tree *htree,
 /**
  * _htree_statis - calculate hash tree statistics and get into hts.
  * @hts: htree_state pointer to store statistics
- * @htree: hash_tree root pointer
+ * @root: hash_tree root pointer
  */
-static void _htree_statis(struct htree_state *hts, struct hash_tree *htree)
+static void _htree_statis(struct htree_state *hts, struct htree_root *root)
 {
 	s32 acnt = 0;
 	u64 dcnt = 0;
 
-	ht_statis(hts, htree, &acnt, &dcnt);
+	ht_statis(hts, htree_first_rcu(root), &acnt, &dcnt);
 
 	if (hts->dcnt == dcnt && hts->acnt == acnt) {
 		pr_ht_info("[ OK ] statist: acnt:%d, dcnt:%llu ", acnt, dcnt);
@@ -651,8 +663,10 @@ static void _htree_statis(struct htree_state *hts, struct hash_tree *htree)
 
 /**
  * _htree_statis_info - shows information calculated by htree_statis().
+ * @hts: htree_state pointer to read statistics
+ * @root: hash_tree root pointer
  */
-static void _htree_statis_info(struct htree_state *hts, struct hash_tree *htree)
+static void _htree_statis_info(struct htree_state *hts, struct htree_root *root)
 {
 	u32 sizh = sizeof(struct hash_tree);
 	u32 sizd = sizeof(struct data_struct);
@@ -663,7 +677,7 @@ static void _htree_statis_info(struct htree_state *hts, struct hash_tree *htree)
 	u64 smem = hsum + dsum;
 
 	if (hts->asum == 0)
-		_htree_statis(hts, htree);
+		_htree_statis(hts, root);
 
 	pr_ht_stat("------------------------------------------\n");
 	pr_ht_stat(" hash start bits(sbit) :       %10d\n", hts->sbit);
@@ -692,10 +706,11 @@ static void _htree_statis_info(struct htree_state *hts, struct hash_tree *htree)
  * if sort flag is HTREE_FLAG_ASCD, root hash table has the smallest index.
  * if sort flag is HTREE_FLAG_DECD, root hash table has the largest index.
  */
-static void _htree_get_most_index(struct htree_state *hts, struct hash_tree *htree)
+static void _htree_get_most_index(struct htree_state *hts, struct htree_root *root)
 {
 	struct htree_data *hdata;
-	hdata = ht_most_index(hts, htree);
+
+	hdata = ht_most_index(hts, htree_first_rcu(root));
 	if (hdata) {
 		if (hts->sort == HTREE_FLAG_ASCD) {
 			pr_ht_stat("[MOST] smallest index:%llu\n\n", hdata->index);
@@ -708,20 +723,20 @@ static void _htree_get_most_index(struct htree_state *hts, struct hash_tree *htr
 /**
  * _htree_remove_all - remove all udata and hash trees
  *
- * before run ht_destroy(), the udata must be erased all.
- * ht_destroy() removes all hash trees, but it does not remove the udata.
+ * before run ht_destroy_lock(), the udata must be erased all.
+ * ht_destroy_lock() removes all hash trees, but it does not remove the udata.
  */
-static void _htree_remove_all(struct htree_state *hts, struct hash_tree *htree)
+static void _htree_remove_all(struct htree_state *hts, struct htree_root *root)
 {
 	/* remove all udata */
-	hts->dcnt -= htree_erase_all(hts, htree);
+	hts->dcnt -= htree_erase_all_lock(hts, root);
 	if (hts->dcnt != 0) {
 		pr_ht_warn("[WARN] erase remained acnt:%d, dcnt:%llu\n\n",
 			   hts->acnt, hts->dcnt);
 	}
 
 	/* remove all hash trees */
-	if (ht_destroy(hts, htree) == htf_ok) {
+	if (ht_destroy_lock(hts, root) == htf_ok) {
 		pr_ht_stat("[ OK ] destroy remained acnt:%d, dcnt:%llu\n\n",
 			   hts->acnt, hts->dcnt);
 	} else {
@@ -743,7 +758,6 @@ static void _htree_remove_all(struct htree_state *hts, struct hash_tree *htree)
  */
 static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 {
-	struct hash_tree *htree;
 	u64 inserted, found, erased, updated;
 	u64 dcnt, slice;
 
@@ -752,42 +766,42 @@ static u64 _htree_test_index_loop(struct htree_state *hts, u64 start, u64 end)
 	slice = (end - start) / 10 + 2;
 
 	/* first root hash tree alloc */
-	htree = ht_table_alloc(hts);
+	htree_root_alloc(hts, &ht_root);
 
-	inserted = _htree_insert_range(hts, htree, start, end, 1, htf_ins);
+	inserted = _htree_insert_range(hts, &ht_root, start, end, 1, htf_ins);
 	if (inserted != hts->dcnt) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
-	erased = _htree_erase_range(hts, htree, start, end, slice);
-	found = _htree_find_range(hts, htree, start, end, slice);
+	erased = _htree_erase_range(hts, &ht_root, start, end, slice);
+	found = _htree_find_range(hts, &ht_root, start, end, slice);
 	if (found) {
 		pr_ht_err("[FAIL] erased:%llu, found:%llu, diff:%lld\n\n",
 			  erased, found, erased - found);
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
-	inserted = _htree_insert_range(hts, htree, start, end, slice, htf_ins);
-	updated = _htree_update_range(hts, htree, start, end, slice);
+	inserted = _htree_insert_range(hts, &ht_root, start, end, slice, htf_ins);
+	updated = _htree_update_range(hts, &ht_root, start, end, slice);
 	if (inserted != updated) {
 		pr_ht_err("[FAIL] inserted:%llu, updated:%llu, diff:%lld\n\n",
 			  inserted, updated, inserted - updated);
 	}
 
-	_htree_statis(hts, htree);
-	_htree_get_most_index(hts, htree);
+	_htree_statis(hts, &ht_root);
+	_htree_get_most_index(hts, &ht_root);
 
 #ifdef HTREE_DEBUG_DETAIL
-	htree_debug_walks_all(hts, htree, 0);
+	htree_debug_walks_all(hts, &ht_root, 0);
 #endif
-	_htree_statis_info(hts, htree);
+	_htree_statis_info(hts, &ht_root);
 	dcnt = hts->dcnt;
 
-	_htree_remove_all(hts, htree);
+	_htree_remove_all(hts, &ht_root);
 
 	return dcnt;
 }
@@ -872,7 +886,6 @@ index type:<%s>, sorting type:<%s>\n", idxts[idx_type], sorts[sort_type]);
 static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 {
 	u64 i, index;
-	struct hash_tree *htree;
 	struct data_struct *udata;
 	struct htree_data *rdata;
 	u64 loop = 0, inserted = 0, erased = 0;
@@ -886,13 +899,13 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 	ht_hts_clear_init(hts, maxnr, idx_type, sort_type);
 
 	/* first root hash tree alloc */
-	htree = ht_table_alloc(hts);
+	htree_root_alloc(hts, &ht_root);
 
 	pr_ht_stat("[START) RANDOM: sbit:%u, index type:<%s>, sorting type:<%s>\n\n",
 		   hts->sbit, idxts[idx_type], sorts[sort_type]);
 
 	udata = _htree_data_alloc(check_idx);
-	rdata = ht_insert(hts, htree, &udata->hdata, htf_ins);
+	rdata = ht_insert_lock(hts, &ht_root, &udata->hdata, htf_ins);
 	inserted++;
 	loop++;
 
@@ -902,7 +915,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 			get_random_u32() : get_random_u64();
 
 		udata = _htree_data_alloc(index);
-		rdata = ht_insert(hts, htree, &udata->hdata, htf_ins);
+		rdata = ht_insert_lock(hts, &ht_root, &udata->hdata, htf_ins);
 		if (!rdata)
 			inserted++;
 		loop++;
@@ -910,9 +923,9 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 			schedule();
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
-	rdata = ht_find(hts, htree, check_idx);
+	rdata = ht_find(hts, htree_first_rcu(&ht_root), check_idx);
 	if (!rdata) {
 		pr_ht_err("[FAIL] NOT found check index:%llu\n\n", check_idx);
 	}
@@ -923,7 +936,7 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 		index = (idx_type == HTREE_FLAG_IDX32) ? 
 			get_random_u32() : get_random_u64();
 
-		rdata = ht_erase(hts, htree, index);
+		rdata = ht_erase_lock(hts, &ht_root, index);
 		if (rdata) {
 			udata = hlist_entry_safe(rdata, struct data_struct, hdata);
 			if (udata && rdata->index == index) {
@@ -938,9 +951,9 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 			schedule();
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
-	rdata = ht_find(hts, htree, check_idx);
+	rdata = ht_find(hts, htree_first_rcu(&ht_root), check_idx);
 	if (!rdata) {
 		pr_ht_info("[INFO] check index:%llu (erased)\n\n", check_idx);
 	}
@@ -949,13 +962,13 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
 		   loop, inserted, erased);
 
 #ifdef HTREE_DEBUG_DETAIL
-	htree_debug_walks_all(hts, htree, 0);
+	htree_debug_walks_all(hts, &ht_root, 0);
 #endif
 
-	_htree_get_most_index(hts, htree);
-	_htree_statis_info(hts, htree);
+	_htree_get_most_index(hts, &ht_root);
+	_htree_statis_info(hts, &ht_root);
 
-	_htree_remove_all(hts, htree);
+	_htree_remove_all(hts, &ht_root);
 
 	kfree(hts);
 }
@@ -975,7 +988,6 @@ static void _htree_test_idx_random(u8 idx_type, u8 sort_type, u64 maxnr)
  */
 static void _htree_test_index_same(u8 idx_type, u8 sort_type, u64 maxnr)
 {
-	struct hash_tree *htree;
 	u64 inserted, found;
 	const char *idxts[] = {	"64bits", "32bits" };
 	const char *sorts[] = {	"ASCD", "DECD" };
@@ -987,49 +999,49 @@ static void _htree_test_index_same(u8 idx_type, u8 sort_type, u64 maxnr)
 	ht_hts_clear_init(hts, maxnr, idx_type, sort_type);
 
 	/* first root hash tree alloc */
-	htree = ht_table_alloc(hts);
+	htree_root_alloc(hts, &ht_root);
 
 	pr_ht_stat("[START) SAME: sbit:%u, index type:<%s>, sorting type:<%s>\n\n",
 		   hts->sbit, idxts[idx_type], sorts[sort_type]);
 
 	pr_ht_stat("[loop) %llu: new index inserting(htf_ins)\n\n", maxnr);
-	inserted = _htree_insert_range(hts, htree, 0, maxnr, gap - 1, htf_ins);
+	inserted = _htree_insert_range(hts, &ht_root, 0, maxnr, gap - 1, htf_ins);
 	if (inserted != hts->dcnt) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
 	pr_ht_stat("[loop) %llu: SAME index inserting(htf_erase)\n\n", maxnr);
-	inserted = _htree_insert_range(hts, htree, 1, maxnr, gap, htf_erase);
+	inserted = _htree_insert_range(hts, &ht_root, 1, maxnr, gap, htf_erase);
 	if (inserted != 0) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
 	pr_ht_stat("[loop) %llu: SAME index inserting(htf_ins)\n\n", maxnr);
-	inserted = _htree_insert_range(hts, htree, 1, maxnr, gap, htf_ins);
+	inserted = _htree_insert_range(hts, &ht_root, 1, maxnr, gap, htf_ins);
 	if (inserted != (maxnr / gap)) {
 		pr_ht_err("[FAIL] inserted:%llu, dcnt:%llu, diff:%lld\n\n",
 			  inserted, hts->dcnt, inserted - hts->dcnt);
 	}
 
-	found = _htree_find_range(hts, htree, 0, maxnr, gap - 1);
+	found = _htree_find_range(hts, &ht_root, 0, maxnr, gap - 1);
 	if (found != (hts->dcnt - inserted)) {
 		pr_ht_err("[FAIL] dcnt:%llu, inserted:%llu, found:%llu\n\n",
 			  hts->dcnt, inserted, found);
 	}
 
-	_htree_statis(hts, htree);
+	_htree_statis(hts, &ht_root);
 
 #ifdef HTREE_DEBUG_DETAIL
-	htree_debug_walks_all(hts, htree, 0);
+	htree_debug_walks_all(hts, &ht_root, 0);
 #endif
-	_htree_get_most_index(hts, htree);
-	_htree_statis_info(hts, htree);
+	_htree_get_most_index(hts, &ht_root);
+	_htree_statis_info(hts, &ht_root);
 
-	_htree_remove_all(hts, htree);
+	_htree_remove_all(hts, &ht_root);
 
 	kfree(hts);
 }
diff --git a/lib/htree.c b/lib/htree.c
index be7b34b5d4e1..1fcdb8d69730 100644
--- a/lib/htree.c
+++ b/lib/htree.c
@@ -180,6 +180,9 @@ struct htree_data *ht_find(struct htree_state *hts,
 	struct htree_data *rdata = NULL;
 	struct hash_tree *rtree;
 
+	if (!htree)
+		return NULL;
+
 	if (_ht_find(hts, htree, index, &rdata, &rtree) == htf_find)
 		return rdata;
 	return NULL;
@@ -345,6 +348,9 @@ struct htree_data *ht_insert(struct htree_state *hts, struct hash_tree *htree,
 	struct hash_tree *rtree = NULL;
 	enum ht_flags htf;
 
+	if (!htree)
+		return NULL;
+
 	htf = _ht_find(hts, htree, hdata->index, &rdata, &rtree);
 
 	_ht_insert(hts, rtree, rdata, hdata, htf, req);
@@ -478,6 +484,9 @@ struct htree_data *ht_erase(struct htree_state *hts,
 {
 	struct htree_data *rdata = NULL;
 
+	if (!htree)
+		return NULL;
+
 	if (_ht_erase(hts, htree, &rdata, index) == htf_erase)
 		return rdata;
 
@@ -533,22 +542,31 @@ static void __ht_free_all(struct htree_state *hts,
 }
 
 /**
- * ht_destroy - public function to free hash tree
+ * ht_destroy_lock - public function to free hash tree
  * @hts: htree_state pointer
- * @htree: hash_tree pointer(root)
+ * @root: htree_tree pointer(root)
  *
  * this function removes all hash tree, but it does not remove udata.
  */
-enum ht_flags ht_destroy(struct htree_state *hts, struct hash_tree *htree)
+enum ht_flags ht_destroy_lock(struct htree_state *hts, struct htree_root *root)
 {
 	s32 acnt = 0;
 	u64 dcnt = 0;
+	struct hash_tree *htree;
 
 	if (hts->acnt == 0 && hts->dcnt == 0)
 		return htf_ok;
 
+	htree = htree_first_rcu(root);
+	if (!htree)
+		return htf_none;
+
 	hts->dept = 0;
+
+	ht_lock(root);
 	__ht_free_all(hts, htree, &acnt, &dcnt);
+	RCU_INIT_POINTER(root->ht_first, NULL);
+	ht_unlock(root);
 
 	hts->acnt -= acnt;
 	hts->dcnt -= dcnt;
@@ -556,7 +574,7 @@ enum ht_flags ht_destroy(struct htree_state *hts, struct hash_tree *htree)
 	return (hts->dept == 0 && hts->dcnt == 0 && hts->acnt == 0) ?
 		htf_ok : htf_none;
 }
-EXPORT_SYMBOL(ht_destroy);
+EXPORT_SYMBOL(ht_destroy_lock);
 
 /**
  * __ht_statis - private function to call recursively to calculate nodes
@@ -613,6 +631,9 @@ void ht_statis(struct htree_state *hts,
 	hts->dept = 0;
 	hts->dmax = 0;
 
+	if (!htree)
+		return;
+
 	__ht_statis(hts, htree, acnt, dcnt);
 }
 EXPORT_SYMBOL(ht_statis);
-- 
2.17.1


