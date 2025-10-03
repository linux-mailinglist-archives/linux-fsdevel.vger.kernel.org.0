Return-Path: <linux-fsdevel+bounces-63368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4ABB7111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138611AE1BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C51F4295;
	Fri,  3 Oct 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT/UDRYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3D1F4C8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498963; cv=none; b=Ep31E/VrmHheFuCB+sMJZy7q18PmxhMNI8wQvyoE/LCc6wcWHEbwt8n34uOwKUvrNYZoMN1lN9IVvWbPdN86Sd8x1kIfiJfDZOqPYLwLkZzHIa2knH0dbZ3y8jyIYZNJERc8okk8TBQUBpd2D11+9vQOEbWuxCmwsyu5N2I+RZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498963; c=relaxed/simple;
	bh=GBAPEZFKXaP2PWh8kbeBdkUunm32ZdiFRGCNba9zXCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMQP9FDKj5HkjjQ7WCwgWk4Y6xG1PuRcQ+5hCcomkakMBym80ts8ZJfrX2egCf+KucapNFLs68SYjqGtv5QgZUUZDbpNLBrt9t+es8KxROP5UQTbKAAz1451fgwFwH+qj725MysNTfc0YW9IACH+i4N+Hl5BbO7D+z5wEwQN1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT/UDRYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759498961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhaOcNHmb7LPmZ0Qghy3zkBE++ecIdVtQmAjZ928Tfs=;
	b=jT/UDRYl1zQVksNc89atby4im7j5hC9R9MgGXCaHFZskzpKnw5Aiyg5OVdK1CbP5iWDhi3
	EXRia91AjAS1fekzzRYR6B/Tabr2NRaNmYS1wJRqGr13ZTQwxZxczYdyNC+2sO4Zv4ZgBl
	44jIfFY6sfiTHK/AMMgUqb8j9MrjATY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-Jb_DkJH6NRKWU0-g9B8PGg-1; Fri,
 03 Oct 2025 09:42:35 -0400
X-MC-Unique: Jb_DkJH6NRKWU0-g9B8PGg-1
X-Mimecast-MFC-AGG-ID: Jb_DkJH6NRKWU0-g9B8PGg_1759498954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 497A1195605C;
	Fri,  3 Oct 2025 13:42:34 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC51B19560B1;
	Fri,  3 Oct 2025 13:42:32 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	brauner@kernel.org
Subject: [PATCH v5 1/7] filemap: add helper to look up dirty folios in a range
Date: Fri,  3 Oct 2025 09:46:35 -0400
Message-ID: <20251003134642.604736-2-bfoster@redhat.com>
In-Reply-To: <20251003134642.604736-1-bfoster@redhat.com>
References: <20251003134642.604736-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 185644e288ea..0b471f0eb940 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -977,6 +977,8 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
+unsigned filemap_get_folios_dirty(struct address_space *mapping,
+		pgoff_t *start, pgoff_t end, struct folio_batch *fbatch);
 
 struct folio *read_cache_folio(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
diff --git a/mm/filemap.c b/mm/filemap.c
index a52dd38d2b4a..db9f2dac9c54 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2348,6 +2348,64 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 }
 EXPORT_SYMBOL(filemap_get_folios_tag);
 
+/**
+ * filemap_get_folios_dirty - Get a batch of dirty folios
+ * @mapping:	The address_space to search
+ * @start:	The starting folio index
+ * @end:	The final folio index (inclusive)
+ * @fbatch:	The batch to fill
+ *
+ * filemap_get_folios_dirty() works exactly like filemap_get_folios(), except
+ * the returned folios are presumed to be dirty or undergoing writeback. Dirty
+ * state is presumed because we don't block on folio lock nor want to miss
+ * folios. Callers that need to can recheck state upon locking the folio.
+ *
+ * This may not return all dirty folios if the batch gets filled up.
+ *
+ * Return: The number of folios found.
+ * Also update @start to be positioned for traversal of the next folio.
+ */
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
+	 * We come here when there is no folio beyond @end. We take care to not
+	 * overflow the index @start as it confuses some of the callers. This
+	 * breaks the iteration when there is a folio at index -1 but that is
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
+
 /*
  * CD/DVDs are error prone. When a medium error occurs, the driver may fail
  * a _large_ part of the i/o request. Imagine the worst scenario:
-- 
2.51.0


