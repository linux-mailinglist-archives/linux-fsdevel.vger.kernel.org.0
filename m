Return-Path: <linux-fsdevel+bounces-66296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966AC1B16A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4D7584E59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767322FF661;
	Wed, 29 Oct 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuD2vn8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D82E1EE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743683; cv=none; b=BI427rK9bT8Uy1sd/mK6xQXRhtdy2TJZamCvEZmbl22PfjabiPCo01mZr4Nkw0Yr2czlPQTLT1IQwP4F/q/SOew+dU3k4kYNV9wUCCcbsyfANVaV3ZFORqtqEJzkxZFrzQ5pgoPssrIGjHto8ef3e5zEKU7nQVTbaAJ55eMHycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743683; c=relaxed/simple;
	bh=OYU/Dje9H9FpozBAA7LNtnyEiB9c0fWO3w+NnDf2nLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzZXjxaF2zsz7XNkg03DYH3UsRZdZs9i26USwJeO1BOSB+2XxJSczDmRSLJIJIReafpJP+X81FhjVv+vYxHsoGU6w8UgMq/0oz8szi7uKxCfX6HnYlUIQsqh4lQMr2NpsWGzc2pRANaLvRvXMCc72SPzBz6hNv2ApBp4x2+0FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuD2vn8y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso1237347866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761743680; x=1762348480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKi4pskh2/O6Tl9UKo5qMtZ2dHOoVoEiKiGXfF2wGGI=;
        b=GuD2vn8yS6LzigBy68HsHw1Urh8jSWKqLBQAVC89COiX9JwNlKG6tVBY3hVCMy2OZz
         7Gk4v1z7ZilhSW3iZXDRhg/eOjJeYm55K5zWoWRo5llxyXEuruX0mlsMku/ODWLi8eem
         BI3WYOhUn6mFl+aDMgvAGwKuIwB2i6tBYIrf65A15sYQquW5tJmx89R64x7QkDXPXM6U
         HZEZk8QiNlHG9Wj+cCbpqo3g+QKFXG4qTcgYNbN/+7BjFicpB8KMNvL7KqwKM1X0nB6D
         c9T42ugcrLVkWV6zHv0bGj2h4upCI+qeiiA/fPR4GJnWCZ9LbscEQQowI6PB1kpQ7v2g
         C5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743680; x=1762348480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKi4pskh2/O6Tl9UKo5qMtZ2dHOoVoEiKiGXfF2wGGI=;
        b=nj+zZfAEBLP7BG2lPVN6AtSgWrtoHVm3m2d6V/fLzYoTQxGfbF7xCm5dKBCRwhqOvR
         ioYYw4dATafKqhntBgb9pC5s5U680FMmnQYuTNvpdtku0c+TlhjCfCgGOjNwUdbPKHLu
         GZKmNBGdWkzKmTPqV4+r8oYFEKvUqovHobhdWDkjTQ5AjV3TLgzq9Jdt+FUtrJvAnDaT
         IjDbvPtOVB1y3IBcF/J6/fuS+p92LGCU9ipTR1BU2eByFfAJKJHlEHAPYLvniFC4HbPG
         aV9ArXpSa3mluvyYyORfwN3yGjvsETkuZeKxFcrVl14Nb2lvWEeCt1wVzMKGMtf+B2fs
         IIaw==
X-Forwarded-Encrypted: i=1; AJvYcCUlqOvH0AM2H6RFgulEQUaotez1WIfptBfoUrdU3C5hf54th9NXithBLTGLh2wg4sH+9w6ns9na6k8NMybb@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrXAb9qB/Ow3pVUo2PKNr8hzCQPwUhYLXEwP55hqZv/Kdp2iC
	BG1tYh5F8KUmICf2a/Uo6/UQBO9T6LN0Yx16i/nyC/b8eGz7+l/MKMof
X-Gm-Gg: ASbGncuU9lMpgQ4jL4ZJy++yWV8d9xrbgLKQhXpC97Qo9MZO/cTpYcF414d9J3ah7ne
	ETdZOQl2301p4nwgf0Uz6/qQ3qKJCG1j/EP3Pn0sv0w1rIppwcAok+lxiQDGzhdHETzN7kUjKR4
	lep26ZEzJIqdW8GA0ThQK9EwUtXRQm364DPO5Cdn5Wnz6YINTKPWHwXdNo9VL8htyvv9yoOaB+G
	WNs/Ta9D2WXCUeuoVRMrIQxWGEFSZTlyo/zyjHsP1An2MnwwG/X9cthIl9rYhpHg1CtwtnN8XpD
	Y0Pva9YUaUDk824LQmfrkwf1G2pvm2fsiVR26a9VvxKlbNgAGfSBSvHx3Igq7NkWaRRSW/ol1yi
	47gaNfsttsf5aCImbvCyx/qMq8Msg7Fy0j2Ggc98/K056pFwsqHqtkJ4PaRiZKBL4uh2qsELPkn
	osl/Hgjklw6/b2ZhSscDz11bkOkwreQQfPuNr7UJnmlFui5s/idSxexL62974=
X-Google-Smtp-Source: AGHT+IGiT10giP2pAEdF8uoMC+sS/XjdPsElaOpA+NUH4DHVYuqRIS7aNnrU/qMYT7hyurS1akCEXQ==
X-Received: by 2002:a17:906:f58f:b0:b3d:b8c3:768d with SMTP id a640c23a62f3a-b703d2cc2c0mr253246366b.7.1761743680139;
        Wed, 29 Oct 2025 06:14:40 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm1451840566b.5.2025.10.29.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:14:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] fs: cosmetic fixes to lru handling
Date: Wed, 29 Oct 2025 14:14:28 +0100
Message-ID: <20251029131428.654761-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029131428.654761-1-mjguzik@gmail.com>
References: <20251029131428.654761-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. inode_bit_waitqueue() was somehow placed between __inode_add_lru() and
   inode_add_lru(). move it up
2. assert ->i_lock is held in __inode_add_lru instead of just claiming it is
   needed
3. s/__inode_add_lru/__inode_lru_list_add/ for consistency with itself
   (inode_lru_list_del()) and similar routines for sb and io list
   management
4. push list presence check into inode_lru_list_del(), just like sb and
   io list

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

rebased

 fs/fs-writeback.c  |  2 +-
 fs/inode.c         | 50 ++++++++++++++++++++++++----------------------
 include/linux/fs.h |  2 +-
 mm/filemap.c       |  4 ++--
 mm/truncate.c      |  6 +++---
 mm/vmscan.c        |  2 +-
 mm/workingset.c    |  2 +-
 7 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5dccbe5fb09d..c81fffcb3648 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1455,7 +1455,7 @@ static void inode_sync_complete(struct inode *inode)
 
 	inode_state_clear(inode, I_SYNC);
 	/* If inode is clean an unused, put it into LRU now... */
-	inode_add_lru(inode);
+	inode_lru_list_add(inode);
 	/* Called with inode->i_lock which ensures memory ordering. */
 	inode_wake_up_bit(inode, __I_SYNC);
 }
diff --git a/fs/inode.c b/fs/inode.c
index b5c2efebaa18..faf99d916afc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -530,23 +530,6 @@ void ihold(struct inode *inode)
 }
 EXPORT_SYMBOL(ihold);
 
-static void __inode_add_lru(struct inode *inode, bool rotate)
-{
-	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
-		return;
-	if (icount_read(inode))
-		return;
-	if (!(inode->i_sb->s_flags & SB_ACTIVE))
-		return;
-	if (!mapping_shrinkable(&inode->i_data))
-		return;
-
-	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
-		this_cpu_inc(nr_unused);
-	else if (rotate)
-		inode_state_set(inode, I_REFERENCED);
-}
-
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 					    struct inode *inode, u32 bit)
 {
@@ -584,18 +567,38 @@ void wait_on_new_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(wait_on_new_inode);
 
+static void __inode_lru_list_add(struct inode *inode, bool rotate)
+{
+	lockdep_assert_held(&inode->i_lock);
+
+	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
+		return;
+	if (icount_read(inode))
+		return;
+	if (!(inode->i_sb->s_flags & SB_ACTIVE))
+		return;
+	if (!mapping_shrinkable(&inode->i_data))
+		return;
+
+	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
+		this_cpu_inc(nr_unused);
+	else if (rotate)
+		inode_state_set(inode, I_REFERENCED);
+}
+
 /*
  * Add inode to LRU if needed (inode is unused and clean).
- *
- * Needs inode->i_lock held.
  */
-void inode_add_lru(struct inode *inode)
+void inode_lru_list_add(struct inode *inode)
 {
-	__inode_add_lru(inode, false);
+	__inode_lru_list_add(inode, false);
 }
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (list_empty(&inode->i_lru))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_dec(nr_unused);
 }
@@ -1924,7 +1927,7 @@ static void iput_final(struct inode *inode)
 	if (!drop &&
 	    !(inode_state_read(inode) & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
-		__inode_add_lru(inode, true);
+		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
@@ -1948,8 +1951,7 @@ static void iput_final(struct inode *inode)
 		inode_state_replace(inode, I_WILL_FREE, I_FREEING);
 	}
 
-	if (!list_empty(&inode->i_lru))
-		inode_lru_list_del(inode);
+	inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
 
 	evict(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a813abdcf218..33129cda3a99 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3502,7 +3502,7 @@ static inline void remove_inode_hash(struct inode *inode)
 }
 
 extern void inode_sb_list_add(struct inode *inode);
-extern void inode_add_lru(struct inode *inode);
+extern void inode_lru_list_add(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..add5228a7d97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -256,7 +256,7 @@ void filemap_remove_folio(struct folio *folio)
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	filemap_free_folio(mapping, folio);
@@ -335,7 +335,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	page_cache_delete_batch(mapping, fbatch);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	for (i = 0; i < folio_batch_count(fbatch); i++)
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..ad9c0fa29d94 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -46,7 +46,7 @@ static void clear_shadow_entries(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 }
 
@@ -111,7 +111,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 out:
 	folio_batch_remove_exceptionals(fbatch);
@@ -622,7 +622,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	filemap_free_folio(mapping, folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..bb4a96c7b682 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -811,7 +811,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		__filemap_remove_folio(folio, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
+			inode_lru_list_add(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 
 		if (free_folio)
diff --git a/mm/workingset.c b/mm/workingset.c
index 68a76a91111f..d32dc2e02a61 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -755,7 +755,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping->host != NULL) {
 		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
+			inode_lru_list_add(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 	}
 	ret = LRU_REMOVED_RETRY;
-- 
2.34.1


