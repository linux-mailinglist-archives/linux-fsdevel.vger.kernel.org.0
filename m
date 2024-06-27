Return-Path: <linux-fsdevel+bounces-22684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9F91B038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7561F224C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912419D8BA;
	Thu, 27 Jun 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAAtSPj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A933FD;
	Thu, 27 Jun 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519461; cv=none; b=OHIBlrBchw5QAeQGISlZAN601eEqmBm9pKvIcx0RufkPfClAeAZrDP5pNmrJIo9M2BKkpniXIk+C0cB/6o7FND/P0L4Yy5kMxIMBDZFiF0vH+nHstwE5dVlsUhmrzKskt1Uyk1M3LFb3GjorSThJ4gedZOYXS4+vQ39upU3XsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519461; c=relaxed/simple;
	bh=FChDSKktOd/AYanIA7EevJUZD2WcFV4/Er++/7flXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSXusQFJxudx3Dvl4oweWVfSwvFyKllv9Qlujj4gSMliDrOLv6eOFUX10agPOLlnPw1DktlNjTQ8iYHCLToUkkZ4y60Nm3H/iWqxvZxAancK4S4IQuAr2kBKV3WqIju2IJ1IiUpMkwzZYWUk+MgFYwnp0fonOycPTcvxecU3h6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAAtSPj6; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80f6521eeddso1907639241.0;
        Thu, 27 Jun 2024 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719519458; x=1720124258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfWTtRmgo1E8I0TtuekVypKcxx4UC0A4xdyehBHx0NE=;
        b=GAAtSPj67kHLnW/X6kO0l7H1MJB9dBYL+2uIeub3S7tmQaZgEyqU+CHEnBoF4s6Dmr
         H8qRmK++yXFtcBf4L/FWGoibASdlUqsA2F8HnZ0oXfq1M9sf703+uDqAXUmyA6P0HuhB
         J0fZTsGLfS0QkgNiX4dbVAji7outloLXgnR5azLkFn644el+L9ziKXm3UKTTvys7qr6p
         25n124vgCGXMQwZmDmpwb7otzvBcxmM9Bj4vvqfaPirBOIJVzGT50iunWvN9R46suU4j
         HhN2Y76gQQOHm5+/E4lrS/57JUm46NWhFcE3OKb7zy48AqzLrWrnzPz1VQGd/5qRF0lp
         udcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719519458; x=1720124258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfWTtRmgo1E8I0TtuekVypKcxx4UC0A4xdyehBHx0NE=;
        b=ffZVDjHqICPAMqrzZKEXmtFBUonSwcavMlsLZUp1YzdPZ9wSWUJfBcKNXMy9ok/1jg
         H0aj3Iukw3G676tCK+RgAL8uydy9wF2a2QTg9X3sy5zo6ysZ01vVz5OC7nZyEo2ur9Ax
         NIQb+R7wxTEJnYgnG7HfgnNJtWKvsgcxYcBv/IHp3WvpV46CQY8AmgJ+E6iGAvG/0+Gv
         97ZD6QXfqsPYtdSQtpxduTC20JZE49uV7LB17Vt5aYkRDUG8n994jupYdT8zuGLXVmOC
         QXsel+EOW5gHqTCt+jIFyU9vJ/9dAx2JMWnAH+I/R+px7TYilsg+5PcfOKhFgkz8ESBp
         9Tyg==
X-Forwarded-Encrypted: i=1; AJvYcCW/41FEZVUmmC9wxZFSzpwcY3j4FH2vdzF/PSADULu9/dc2MeB+Z150915sYebanWAgSfr0clvZ67pLmtpWwghMXIzMSu5WRT0ursrB6MyhSQbcuUrKfoRvYlZXX0ryNcjNnbjmKYUqwOam6SN23OZ+47NHRBzMjiNz6EIjvR26zGbOVQ==
X-Gm-Message-State: AOJu0YyuDFFuyxAy5RjAUFbngYhz2vU+Mu0uFTzoxbKdAj0FPBFHz+hJ
	3n+ngbajbB9Zf2jcJDZCWB1hjUqcVsfWsDA7lOQk+7WOw1jKP/f3oM1R4A==
X-Google-Smtp-Source: AGHT+IHR0tAYDBylwArb4Spu8TCeyDyzv0vW6zgLAt6R2VTvPr0551huRj1vxUJvSv/B9E8w/0zdIw==
X-Received: by 2002:a05:6122:4592:b0:4d4:21cc:5f4f with SMTP id 71dfb90a1353d-4ef6a73950emr12317938e0c.11.1719519457919;
        Thu, 27 Jun 2024 13:17:37 -0700 (PDT)
Received: from localhost (fwdproxy-nao-115.fbsv.net. [2a03:2880:23ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e609b9asm1691706d6.106.2024.06.27.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:17:37 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	willy@infradead.org,
	david@redhat.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	viro@zeniv.linux.org.uk,
	kasong@tencent.com,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] cachestat: do not flush stats in recency check
Date: Thu, 27 Jun 2024 13:17:37 -0700
Message-ID: <20240627201737.3506959-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000f71227061bdf97e0@google.com>
References: <000000000000f71227061bdf97e0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot detects that cachestat() is flushing stats, which can sleep, in
its RCU read section (see [1]). This is done in the
workingset_test_recent() step (which checks if the folio's eviction is
recent).

Move the stat flushing step to before the RCU read section of cachestat,
and skip stat flushing during the recency check.

[1]: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/

Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
Debugged-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Fixes: b00684722262 ("mm: workingset: move the stats flush into workingset_test_recent()")
Cc: stable@vger.kernel.org # v6.8+
---
 include/linux/swap.h |  3 ++-
 mm/filemap.c         |  5 ++++-
 mm/workingset.c      | 14 +++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bd450023b9a4..e685e93ba354 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -354,7 +354,8 @@ static inline swp_entry_t page_swap_entry(struct page *page)
 }
 
 /* linux/mm/workingset.c */
-bool workingset_test_recent(void *shadow, bool file, bool *workingset);
+bool workingset_test_recent(void *shadow, bool file, bool *workingset,
+				bool flush);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
diff --git a/mm/filemap.c b/mm/filemap.c
index fedefb10d947..298485d4b992 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4248,6 +4248,9 @@ static void filemap_cachestat(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, first_index);
 	struct folio *folio;
 
+	/* Flush stats (and potentially sleep) outside the RCU read section. */
+	mem_cgroup_flush_stats_ratelimited(NULL);
+
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last_index) {
 		int order;
@@ -4311,7 +4314,7 @@ static void filemap_cachestat(struct address_space *mapping,
 					goto resched;
 			}
 #endif
-			if (workingset_test_recent(shadow, true, &workingset))
+			if (workingset_test_recent(shadow, true, &workingset, false))
 				cs->nr_recently_evicted += nr_pages;
 
 			goto resched;
diff --git a/mm/workingset.c b/mm/workingset.c
index c22adb93622a..a2b28e356e68 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -412,10 +412,12 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
  * @file: whether the corresponding folio is from the file lru.
  * @workingset: where the workingset value unpacked from shadow should
  * be stored.
+ * @flush: whether to flush cgroup rstat.
  *
  * Return: true if the shadow is for a recently evicted folio; false otherwise.
  */
-bool workingset_test_recent(void *shadow, bool file, bool *workingset)
+bool workingset_test_recent(void *shadow, bool file, bool *workingset,
+				bool flush)
 {
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
@@ -467,10 +469,16 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 
 	/*
 	 * Flush stats (and potentially sleep) outside the RCU read section.
+	 *
+	 * Note that workingset_test_recent() itself might be called in RCU read
+	 * section (for e.g, in cachestat) - these callers need to skip flushing
+	 * stats (via the flush argument).
+	 *
 	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
 	 * still needed here?
 	 */
-	mem_cgroup_flush_stats_ratelimited(eviction_memcg);
+	if (flush)
+		mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -558,7 +566,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	if (!workingset_test_recent(shadow, file, &workingset))
+	if (!workingset_test_recent(shadow, file, &workingset, true))
 		return;
 
 	folio_set_active(folio);

base-commit: a5c6fededf806aba1ff9b0f01278f7d089da5725
-- 
2.43.0


