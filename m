Return-Path: <linux-fsdevel+bounces-50765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2536DACF561
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5701893FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8CE279351;
	Thu,  5 Jun 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwoGqZl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C511F7060
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144637; cv=none; b=BatVYccQq6fI0k4P2N0zvlNw6sKig/FPkHO5UOQLgnmBQfqUaodGPIy1pGa4aZ9tB4T9w+ZyfLerInf77F/PM7KqiYDDdGXd1xUTnk9psjcchrOSR9atbqYMw/6iNI3WpPfVMoQJVmUlpHTsyopWxF2oACaR2Y5qOl3jLlfu6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144637; c=relaxed/simple;
	bh=EIRRIF8i0/M20s8HRgta8LgA9KtKK7xLjFvJWHT1MBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pq7QGrscehOS1gua1XSb3cIGP1uCKG5v6C50fb0IzgD36BMlFFKDgGTvgkcMJYp5swRp5JBVfTKtkRMvonl97RHqDmOCi/GOWz6RvLTwG5CiB5C/gnuGJ6ot33t5VGj3vFmk3EeFBh2G6t2FFNktRp6uOHFqpB5jX6I9loYFQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwoGqZl9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTpTW2nIC4902tCIzfelfKD0ln8h1LJjLK+MmPY4A60=;
	b=PwoGqZl9IllIgvVFRWKZCp3SAjBbTXGjhQdgH7U9nq3g6ehH2n8nI3ncq6fzWNmV+gMx58
	4dmWesUItBwRp7va/Na8N9qSrANIjRw91CRQPEH1TJfUwlkI+9GESgtn7BLmXMpn/4wadz
	vyzuyYiBpyLR0cqqPmBBu74JdW5yz/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-KMfKJ7yiOuWxhR-EamJ4nA-1; Thu,
 05 Jun 2025 13:30:31 -0400
X-MC-Unique: KMfKJ7yiOuWxhR-EamJ4nA-1
X-Mimecast-MFC-AGG-ID: KMfKJ7yiOuWxhR-EamJ4nA_1749144630
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A856180036E;
	Thu,  5 Jun 2025 17:30:30 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F63C30002C0;
	Thu,  5 Jun 2025 17:30:29 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] filemap: add helper to look up dirty folios in a range
Date: Thu,  5 Jun 2025 13:33:52 -0400
Message-ID: <20250605173357.579720-3-bfoster@redhat.com>
In-Reply-To: <20250605173357.579720-1-bfoster@redhat.com>
References: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a new filemap_get_folios_dirty() helper to look up existing dirty
folios in a range and add them to a folio_batch. This is to support
optimization of certain iomap operations that only care about dirty
folios in a target range. For example, zero range only zeroes the subset
of dirty pages over unwritten mappings, seek hole/data may use similar
logic in the future, etc.

Note that the helper is intended for use under internal fs locks.
Therefore it trylocks folios in order to filter out clean folios.
This loosely follows the logic from filemap_range_has_writeback().

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..fb83ddf26621 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -941,6 +941,8 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
+unsigned filemap_get_folios_dirty(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 
 /*
  * Returns locked page at given index in given cache, creating it if needed.
diff --git a/mm/filemap.c b/mm/filemap.c
index bada249b9fb7..d28e984cdfd4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2334,6 +2334,48 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 
+unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
+			pgoff_t end, struct folio_batch *fbatch)
+{
+	XA_STATE(xas, &mapping->i_pages, *start);
+	struct folio *folio;
+
+	rcu_read_lock();
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
+		if (xa_is_value(folio))
+			continue;
+		if (folio_trylock(folio)) {
+			bool clean = !folio_test_dirty(folio) &&
+				     !folio_test_writeback(folio);
+			folio_unlock(folio);
+			if (clean) {
+				folio_put(folio);
+				continue;
+			}
+		}
+		if (!folio_batch_add(fbatch, folio)) {
+			unsigned long nr = folio_nr_pages(folio);
+			*start = folio->index + nr;
+			goto out;
+		}
+	}
+	/*
+	 * We come here when there is no page beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a page at index -1 but that is
+	 * already broke anyway.
+	 */
+	if (end == (pgoff_t)-1)
+		*start = (pgoff_t)-1;
+	else
+		*start = end + 1;
+out:
+	rcu_read_unlock();
+
+	return folio_batch_count(fbatch);
+}
+EXPORT_SYMBOL(filemap_get_folios_dirty);
+
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fail
  * a _large_ part of the i/o request. Imagine the worst scenario:
-- 
2.49.0


