Return-Path: <linux-fsdevel+bounces-65646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF4C0B329
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6542C3BB191
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396992FF161;
	Sun, 26 Oct 2025 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEjYeajO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52E26A0B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510984; cv=none; b=SJca2+CxmLpq8nsbPOIQYzjOQSObSk7mqXrrAJOpL+upIkS5NzxcF6zbGkHlibToqu/qGb9SzNECCVbUuZevNwH54xRat2ZxL9qxtyASjLEwhWCVrl3wxEEdY+sji2RuZOfAAIsF7UahbLaWxKVwQaHMSQ3SVz1zxvWssjnqlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510984; c=relaxed/simple;
	bh=QdobSCFFDwZco5H10+mCZIVaLZD/bxvZhAPtHu84mSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nT8b0oesR5K+6IGujI132vzAgyQorJsFp2Ji1M5nV+Ml34OY5ob8ujk76F5BvteyPpil2ZlitRNPdIYkxpnxzPbHSHc+2ZYEfHhCGhmt2OkhsxD17cqbbTY4fQ52IJNWwxPtxZjY5M1EkDDlFlWHL9AQSUPjrr3DR/RNvEOolFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEjYeajO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso2421892a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510982; x=1762115782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjcuHpYYcQHcLMxflMYQWhRGNmSrL1U/STCZpS9nknA=;
        b=vEjYeajO3IgfKZ963vKoCuZ9klq3xlcHp8hTa1/3XLR6caQFql4lBhTbK9VJEYuvjp
         Y6rAYB+lW0a1CaUG2BWN1+PKu3nSj0Cgqo5/haFuKalvDeEi7ajZfgfMQnq81hrkCs0x
         +ScsxiXKYL66IT9swxjCmrfmWW06IAxSgatvcZKVc7fE1szTjpUnHuEomrpVJxOp2jF+
         GykRSNH1dXjAFQX4NvM/Kfb/Tod7Jh2MwCz57LYUvUpEzfl8Upei2QgChQqsUp0vF070
         UXjavm2PjmmazZ5DXTvT42u2OTnMWvObmDQ/AoGyH4zEG/5taVaSDeGjoJei7UZk4wRc
         1U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510982; x=1762115782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjcuHpYYcQHcLMxflMYQWhRGNmSrL1U/STCZpS9nknA=;
        b=HuoM64uRa3bgibStXKuW2WIFTvW29W8xb2xveqlfs6A4ekTMOb9UglMki0NISsOCP+
         f8O1doQJt6RMiKSP32ATyHn4dWsamCSivx8LSy1gxZT3+TfX+/tNi+Uj+cMx6yszQgcx
         2b3PxnMyBjte2TtItsoRdyXyRB6ipAcf1hrMpeqioQ3ragcic1w6J1fU216hmESZTuGy
         Pwp3uMH7FAXnHVqRnL9FORWt4544DpyIM6citba49GcbGS+v6m4rfNVOuhYPmqsimHaT
         SMuxc0hPy1BP+/lOhhGN41XRJkTDNstjSeDatQPJM4aEOqu3o5PI/WdbI6s5nm0ZflPU
         550Q==
X-Forwarded-Encrypted: i=1; AJvYcCURvVbTYV8wF5jrJGgXVnIae0uhumkB2OJ79zJIQtfT+kwT68qRVyQsFd7OsTAXG2TL1o/wJps9g0wn9VoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyKj/hces4xqU9B7GPum7iWZWKfNFUk4pOmNjfejwiXrnNdf1xx
	lBZtKHBGTAJNMx7+SBbJziWFTXBIyrhT+kq/xRGkh4iY2kLjW2wqLSy/zcN6vlnDisEz1euLcn8
	UzOOJVg==
X-Google-Smtp-Source: AGHT+IGjcHCIP4ct/x+2y/THOCKsvE9F5w9jWhI/lZb7MjaZDIeaamZd+nSYaoL2Nf3TsDz920cb3q85adE=
X-Received: from pjb3.prod.google.com ([2002:a17:90b:2f03:b0:33e:34c2:1e17])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3942:b0:336:bfce:3b48
 with SMTP id 98e67ed59e1d1-33bcf87f431mr47241846a91.9.1761510981924; Sun, 26
 Oct 2025 13:36:21 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:06 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-4-surenb@google.com>
Subject: [PATCH v2 3/8] mm/cleancache: readahead support
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
 include/linux/cleancache.h | 13 +++++++++
 mm/cleancache.c            | 58 ++++++++++++++++++++++++++++++++++++++
 mm/readahead.c             | 54 +++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
index 419faa183aba..75361d1cfe3f 100644
--- a/include/linux/cleancache.h
+++ b/include/linux/cleancache.h
@@ -11,6 +11,7 @@
 
 #define CLEANCACHE_KEY_MAX	6
 
+struct cleancache_inode;
 
 #ifdef CONFIG_CLEANCACHE
 
@@ -21,6 +22,11 @@ bool cleancache_store_folio(struct inode *inode, struct folio *folio);
 bool cleancache_restore_folio(struct inode *inode, struct folio *folio);
 bool cleancache_invalidate_folio(struct inode *inode, struct folio *folio);
 bool cleancache_invalidate_inode(struct inode *inode);
+struct cleancache_inode *
+cleancache_start_inode_walk(struct inode *inode, unsigned long count);
+void cleancache_end_inode_walk(struct cleancache_inode *ccinode);
+bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+				   struct folio *folio);
 
 /*
  * Backend API
@@ -50,6 +56,13 @@ static inline bool cleancache_invalidate_folio(struct inode *inode,
 		{ return false; }
 static inline bool cleancache_invalidate_inode(struct inode *inode)
 		{ return false; }
+static inline struct cleancache_inode *
+cleancache_start_inode_walk(struct inode *inode, unsigned long count)
+		{ return NULL; }
+static inline void cleancache_end_inode_walk(struct cleancache_inode *ccinode) {}
+static inline bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+						 struct folio *folio)
+		{ return false; }
 static inline int cleancache_backend_register_pool(const char *name)
 		{ return -EOPNOTSUPP; }
 static inline int cleancache_backend_get_folio(int pool_id, struct folio *folio)
diff --git a/mm/cleancache.c b/mm/cleancache.c
index 3acf46c0cdd1..6be86938c8fe 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -799,6 +799,64 @@ bool cleancache_invalidate_inode(struct inode *inode)
 	return count > 0;
 }
 
+struct cleancache_inode *
+cleancache_start_inode_walk(struct inode *inode, unsigned long count)
+{
+	struct cleancache_inode *ccinode;
+	struct cleancache_fs *fs;
+	int fs_id;
+
+	if (!inode)
+		return ERR_PTR(-EINVAL);
+
+	fs_id = inode->i_sb->cleancache_id;
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
index 3a4b5d58eeb6..878cc8dfa48e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/cleancache.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/readahead.h>
@@ -146,12 +147,65 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
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
+	ccinode = cleancache_start_inode_walk(rac->mapping->host, count);
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
2.51.1.851.g4ebd6896fd-goog


