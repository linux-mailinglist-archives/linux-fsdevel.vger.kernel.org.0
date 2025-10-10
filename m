Return-Path: <linux-fsdevel+bounces-63705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF778BCB55D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53B5035491F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8B24A047;
	Fri, 10 Oct 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nh5EllIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202223BF9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059205; cv=none; b=bXH7InvqmOZf3WFdmvG1swWVZQg6rDDASqlYarIftIrF7XgP5M2xQ8Jcll40T8SyEGSLsNldfcVaUGCzN3nc/cN0sBe9BumLQE352fesFg2Jn2wYJ7ScoFo9u7UrCQXDLKe9+2jyorROc988sSyF775OmCPW/Se6N8MS2Th0nEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059205; c=relaxed/simple;
	bh=B/QFPXniGwEFGN4sNohbRDTRW/JKndUEcycvqtnTGMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sGPb2YsxIQaNLPnAMeRI3j6kMGpSEMtGFXnAJehN6gj4+oRqXo1bqpIq/qbFaWN2xosxQxdiEiaB9EoZWQ/RUFUsovjAU6kl1L0AL75npKPc8qs2n62C8lsTt8bF4vLdBwN8xRPt0piAtc0rVD0Nw11YpwU7k/MrXdXckMkfT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nh5EllIq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3023514a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059203; x=1760664003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfFmaAKl937kSaDktiPuEwSl7VxkpxzCXx+g6sFaHjQ=;
        b=Nh5EllIqzXs9BFjaNGglTDUbfKAr8u8Xu3LkPIG4yCuKwkExy7mwfckEIaVzq5pKMb
         Dtc0q0UI10Yl3tlIaeGsP5z8hZaSuBsfMFzijhbAwvBKz2fm/FzaTGZjsitUdZA/AFMy
         JnS1OuSnXmoeVi5rFJN3usCU10tYg6Du8dduaDGcIURAGwPhmGzkyA4FGhP6IKm6ZKBH
         +z8VwcNOxbcSnm/P+tA/6ULN6JVDmg30rdQ3uKqJm6P6R9ljywpLUKGxqnFZ+pPfp6+j
         Sdl+J4yv7+RQW0nLsCMcb4HPkuLxkqtl8biXQ/OdjGQJ2GAswadmwcnjnR0k2Nm1/zMo
         udpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059203; x=1760664003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfFmaAKl937kSaDktiPuEwSl7VxkpxzCXx+g6sFaHjQ=;
        b=YdHUtnyXACC6Y+gCLrOQjb8mnXpX4dMMbkTALOLyVHummzlmrkmheAhx4WLMCOVj/D
         1mSuiW/OE8EoWMtmZDLMrpbubVEKTjbaMWe9pDpykh6NjewKgIEqZg+RzQdVOaDxtzwE
         eRsGQ40/YeikMn8MkUfyt8uEPKgPniB4covsXs+HdCpLgWxM0jf5/h2OtXiZOyBfR17Z
         n5OQ2X4CkqLlJltNaam6zumlShzDxrX5nUO5nu4Wk6QIw14AdpfhR+6p/AkrLZsZyhWY
         LNoGFtpKRmIroxdKFBRsAjSVp5PBVb3cBoOR+3U0IVGD5UhpyWjAdP0QDLiHxfH/mTEg
         6W2A==
X-Forwarded-Encrypted: i=1; AJvYcCWB7xglk1F3lLZzeqIckt+YBitbpLmoWrNvTsHX8myyLqaPpwZeEUp6h4zr9ByY1fjhlOtdOmktjeXgE1aO@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmrKZTBCS0IjAj7Gct3RZGXlqW9qbTKXWrN6Zz8PzDZEszUce
	1tGpv20wL0M2xCuIHBVE3le0Ws6i5rYr/u8aS50t8mkQpeJWXQbMXfe+af/l8L7X8o+Nl0tfPjD
	jEnzmwA==
X-Google-Smtp-Source: AGHT+IFjOaBKWzMfb/TvgcjiAKDwb9C3QEg3GiheZ0wej2yAwCBPTptgb70zWp2JQn59IyW7GzdntSOdWLc=
X-Received: from pjbsr7.prod.google.com ([2002:a17:90b:4e87:b0:32e:e06a:4668])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e07:b0:339:f09b:d372
 with SMTP id 98e67ed59e1d1-33b513b4c91mr13745970a91.23.1760059202712; Thu, 09
 Oct 2025 18:20:02 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:46 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-4-surenb@google.com>
Subject: [PATCH 3/8] mm/cleancache: readahead support
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
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Restore pages from the cleancache during readahead operation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/cleancache.h | 17 +++++++++++
 mm/cleancache.c            | 59 ++++++++++++++++++++++++++++++++++++++
 mm/readahead.c             | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
index 458a7a25a8af..28b6d7b25964 100644
--- a/include/linux/cleancache.h
+++ b/include/linux/cleancache.h
@@ -11,6 +11,7 @@
 
 #define CLEANCACHE_KEY_MAX	6
 
+struct cleancache_inode;
 
 #ifdef CONFIG_CLEANCACHE
 
@@ -24,6 +25,14 @@ bool cleancache_invalidate_folio(struct address_space *mapping,
 bool cleancache_invalidate_inode(struct address_space *mapping,
 				 struct inode *inode);
 
+struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping,
+			    struct inode *inode,
+			    unsigned long count);
+void cleancache_end_inode_walk(struct cleancache_inode *ccinode);
+bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+				   struct folio *folio);
+
 /*
  * Backend API
  *
@@ -53,6 +62,14 @@ static inline bool cleancache_invalidate_folio(struct address_space *mapping,
 static inline bool cleancache_invalidate_inode(struct address_space *mapping,
 					       struct inode *inode)
 		{ return false; }
+static inline struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
+			    unsigned long count)
+		{ return NULL; }
+static inline void cleancache_end_inode_walk(struct cleancache_inode *ccinode) {}
+static inline bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+						 struct folio *folio)
+		{ return false; }
 static inline int cleancache_backend_register_pool(const char *name)
 		{ return -EOPNOTSUPP; }
 static inline int cleancache_backend_get_folio(int pool_id, struct folio *folio)
diff --git a/mm/cleancache.c b/mm/cleancache.c
index 73a8b2655def..59b8fd309619 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -813,6 +813,65 @@ bool cleancache_invalidate_inode(struct address_space *mapping,
 	return count > 0;
 }
 
+struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
+			    unsigned long count)
+{
+	struct cleancache_inode *ccinode;
+	struct cleancache_fs *fs;
+	int fs_id;
+
+	if (!inode)
+		return ERR_PTR(-EINVAL);
+
+	fs_id = mapping->host->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return ERR_PTR(-EINVAL);
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return NULL;
+
+	ccinode = find_and_get_inode(fs, inode);
+	if (!ccinode) {
+		put_fs(fs);
+		return NULL;
+	}
+
+	return ccinode;
+}
+
+void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
+{
+	struct cleancache_fs *fs = ccinode->fs;
+
+	put_inode(ccinode);
+	put_fs(fs);
+}
+
+bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+				   struct folio *folio)
+{
+	struct folio *stored_folio;
+	void *src, *dst;
+	bool ret = false;
+
+	xa_lock(&ccinode->folios);
+	stored_folio = xa_load(&ccinode->folios, folio->index);
+	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
+		src = kmap_local_folio(stored_folio, 0);
+		dst = kmap_local_folio(folio, 0);
+		memcpy(dst, src, PAGE_SIZE);
+		kunmap_local(dst);
+		kunmap_local(src);
+		ret = true;
+	}
+	xa_unlock(&ccinode->folios);
+
+	return ret;
+}
+
 /* Backend API */
 /*
  * Register a new backend and add its folios for cleancache to use.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3a4b5d58eeb6..6f4986a5e14a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/cleancache.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/readahead.h>
@@ -146,12 +147,66 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
+static inline bool restore_from_cleancache(struct readahead_control *rac)
+{
+	XA_STATE(xas, &rac->mapping->i_pages, rac->_index);
+	struct cleancache_inode *ccinode;
+	struct folio *folio;
+	unsigned long end;
+	bool ret = true;
+
+	int count = readahead_count(rac);
+
+	/* Readahead should not have started yet. */
+	VM_BUG_ON(rac->_batch_count != 0);
+
+	if (!count)
+		return true;
+
+	ccinode = cleancache_start_inode_walk(rac->mapping, rac->mapping->host,
+					      count);
+	if (!ccinode)
+		return false;
+
+	end = rac->_index + rac->_nr_pages - 1;
+	xas_for_each(&xas, folio, end) {
+		unsigned long nr;
+
+		if (xas_retry(&xas, folio)) {
+			ret = false;
+			break;
+		}
+
+		if (!cleancache_restore_from_inode(ccinode, folio)) {
+			ret = false;
+			break;
+		}
+
+		nr = folio_nr_pages(folio);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		rac->_index += nr;
+		rac->_nr_pages -= nr;
+		rac->ra->size -= nr;
+		if (rac->ra->async_size >= nr)
+			rac->ra->async_size -= nr;
+	}
+
+	cleancache_end_inode_walk(ccinode);
+
+	return ret;
+}
+
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct folio *folio;
 	struct blk_plug plug;
 
+	/* Try to read all pages from the cleancache */
+	if (restore_from_cleancache(rac))
+		return;
+
 	if (!readahead_count(rac))
 		return;
 
-- 
2.51.0.740.g6adb054d12-goog


