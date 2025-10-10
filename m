Return-Path: <linux-fsdevel+bounces-63704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAFBCB557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A5219E77F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347AE34BA24;
	Fri, 10 Oct 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCujioF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BE238C07
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059203; cv=none; b=fF4d2/Ds0p2gQA5Ft9Ao9sbcdJROvc3qsJK+EyPFtaYw/AZZgQ6R6+uCC9acs+oVSR/pwyg/nICN0tfUAmPgDQb1QoCJuW3236Gey0qk81hM6kxJ5/SFrweckDn3EKdyjy08rz+teVGgbG6RMX3/2gmgDViNzw0JBv7QSa4Id1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059203; c=relaxed/simple;
	bh=qqMh5neXihNma1bqqODHksMYAs2CpreAk4attEWQEuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c50JfGB2H+tOZWOJmyGQIOT9gCP5s1C6jlh9TZKouHcVfXLudTqItL9miHBveNsQwD2MpLR4qX/9S+V195cMK0ISN1wplQ3ziiCIMq/8cQKjeZzXug44t0noZzG4ywk8IBna/NSyQpaarqew3fbFdjyh5BXEfQprRwEbYgMitYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCujioF7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-334b0876195so3906540a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059200; x=1760664000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5NnfUqcWLVy127Caashokc+Ty+gAwqDLPiFwXfeq7Q=;
        b=JCujioF7S9U5iO7gpOnPbRaxbTP2IE8DwG4AX+rOh/96UgsT7HrsceM/YFotKvUi+q
         PnpzIVmruDz2xzD3PycsfrLeXf0z+765Uqtk4qkoDtWViGRbQKv3g5W6ZyAVpT26s9SA
         HhP1Y03x8CIPkxchqDaV7/GFVq4J/seQV6KgUuurfp04iI1+PS2A9cZr9gKIz0QKneRY
         sA2JbuENEPA/4ZrNMzS1wOeUMfdF/xvYW+zPbnWM0PZWnTtRmlfWdxfOa9jTMrsenpF0
         lXIlyNPPd78JBtOQl3tYPYYVB/Ney+aBbsx7zGxfMPqcS7LLrql8It6mGRAKCiknS2h4
         /XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059200; x=1760664000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5NnfUqcWLVy127Caashokc+Ty+gAwqDLPiFwXfeq7Q=;
        b=UZTkgT5IDbI0enIXwivmkXGCydpS5Md3fiaB9qYFQsieF6ruGDNkSvDopEisuyufF9
         iPyxfUHEC/FFSqUwMx/gWIFXJ1pSY9pWF+pyP81u3mMkGq2ujsoLgVZPce1P0CZLe5ZC
         t1BZ1gsnZy0tAj1+j3s5U3in9RnCewbsuGVwj214qC9VgubU3Os6hhR3O9WOARtHXf0g
         LhPIYihuudlcy78r8VSwjfwKadqEBoRm+68aFLy+J4kRiCuq5kMVj71smZZxyugfqyyy
         KcgaJK7Ci06ZIpISfknQJ/xcd2RNG4hy1T27e6ANtgtPZP69JPg2TcrRkL7lZMQjIDIk
         JWCg==
X-Forwarded-Encrypted: i=1; AJvYcCVgooamR7DK5H0veGwx3Gndu+puQMnzmh7wlw8hiJV3GFh0D7A9gtzIqzcynene9QS2eT31dG4kybyi2EfT@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWnwLppVVGhJD5NC3JqbTkA5A+XG8jAbkIUfPbxgrRwJu+eG2
	2wdKhwVRuUI+aLbT73XDHLoSCVN2FEsCPSja3fJpzZRHW6tTQPiN2HQKwWqv0gk397ALS9ZhGwq
	E8wAWmg==
X-Google-Smtp-Source: AGHT+IGUtqiuXgYovxJ9pqzet+oIg30O6HUu5Ov7PiPDZ2bQlxmJF3pLfeJkqhVr7qj3OayvX9LqFKSZH5I=
X-Received: from pjbpb8.prod.google.com ([2002:a17:90b:3c08:b0:33b:51fe:1a95])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3908:b0:335:21bf:3b99
 with SMTP id 98e67ed59e1d1-33b5139a3c6mr12252369a91.32.1760059200475; Thu, 09
 Oct 2025 18:20:00 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:45 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-3-surenb@google.com>
Subject: [PATCH 2/8] mm/cleancache: add cleancache LRU for folio aging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Once all folios in the cleancache are used to store data from previously
evicted folios, no more data can be stored there. To avoid that situation
we can drop older data and make space for new one.
Add an LRU for cleancache folios to reclaim the oldest folio when
cleancache is full and we need to store a new folio.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/cleancache.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index 0023962de024..73a8b2655def 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -19,6 +19,13 @@
  *
  *	ccinode->folios.xa_lock
  *		pool->lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *			pool->lock
  */
 
 #define INODE_HASH_BITS		6
@@ -60,6 +67,8 @@ static struct kmem_cache *slab_inode; /* cleancache_inode slab */
 static struct cleancache_pool pools[CLEANCACHE_MAX_POOLS];
 static atomic_t nr_pools = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(pools_lock); /* protects pools */
+static LIST_HEAD(cleancache_lru);
+static DEFINE_SPINLOCK(lru_lock); /* protects cleancache_lru */
 
 /*
  * Folio attributes:
@@ -130,6 +139,7 @@ static inline bool is_folio_attached(struct folio *folio)
 /*
  * Folio pool helpers.
  *	Only detached folios are stored in the pool->folio_list.
+ *	Once a folio gets attached, it's placed on the cleancache LRU list.
  *
  * Locking:
  *	pool->folio_list is accessed under pool->lock.
@@ -181,6 +191,32 @@ static struct folio *pick_folio_from_any_pool(void)
 	return folio;
 }
 
+/* Folio LRU helpers. Only attached folios are stored in the cleancache_lru. */
+static void add_folio_to_lru(struct folio *folio)
+{
+	VM_BUG_ON(!list_empty(&folio->lru));
+
+	spin_lock(&lru_lock);
+	list_add(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void rotate_lru_folio(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_move(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void delete_folio_from_lru(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_del_init(&folio->lru);
+	spin_unlock(&lru_lock);
+}
+
 /* FS helpers */
 static struct cleancache_fs *get_fs(int fs_id)
 {
@@ -316,6 +352,7 @@ static void erase_folio_from_inode(struct cleancache_inode *ccinode,
 
 	removed = __xa_erase(&ccinode->folios, offset);
 	VM_BUG_ON(!removed);
+	delete_folio_from_lru(folio);
 	remove_inode_if_empty(ccinode);
 }
 
@@ -413,6 +450,48 @@ static struct cleancache_inode *add_and_get_inode(struct cleancache_fs *fs,
 	return ccinode;
 }
 
+static struct folio *reclaim_folio_from_lru(void)
+{
+	struct cleancache_inode *ccinode;
+	unsigned long offset;
+	struct folio *folio;
+
+again:
+	spin_lock(&lru_lock);
+	if (list_empty(&cleancache_lru)) {
+		spin_unlock(&lru_lock);
+		return NULL;
+	}
+	ccinode = NULL;
+	/* Get the ccinode of the folio at the LRU tail */
+	list_for_each_entry_reverse(folio, &cleancache_lru, lru) {
+		struct cleancache_pool *pool = folio_pool(folio);
+
+		/* Find and get ccinode */
+		spin_lock(&pool->lock);
+		folio_attachment(folio, &ccinode, &offset);
+		if (ccinode && !get_inode(ccinode))
+			ccinode = NULL;
+		spin_unlock(&pool->lock);
+		if (ccinode)
+			break;
+	}
+	spin_unlock(&lru_lock);
+
+	if (!ccinode)
+		return NULL; /* No ccinode to reclaim */
+
+	if (!isolate_folio_from_inode(ccinode, offset, folio)) {
+		/* Retry if the folio got erased from the ccinode */
+		put_inode(ccinode);
+		goto again;
+	}
+
+	put_inode(ccinode);
+
+	return folio;
+}
+
 static void copy_folio_content(struct folio *from, struct folio *to)
 {
 	void *src = kmap_local_folio(from, 0);
@@ -468,14 +547,19 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
 			goto out_unlock;
 		}
+		rotate_lru_folio(stored_folio);
 	} else {
 		if (!workingset)
 			goto out_unlock;
 
 		stored_folio = pick_folio_from_any_pool();
 		if (!stored_folio) {
-			/* No free folios, TODO: try reclaiming */
-			goto out_unlock;
+			/* No free folios, try reclaiming */
+			xa_unlock(&ccinode->folios);
+			stored_folio = reclaim_folio_from_lru();
+			xa_lock(&ccinode->folios);
+			if (!stored_folio)
+				goto out_unlock;
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -487,6 +571,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
 
@@ -516,6 +601,7 @@ static bool load_from_inode(struct cleancache_fs *fs,
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
 		ret = true;
 	}
-- 
2.51.0.740.g6adb054d12-goog


