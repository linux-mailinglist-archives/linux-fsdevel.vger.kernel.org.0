Return-Path: <linux-fsdevel+bounces-56883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65340B1CD8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8287D16D88E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650022BD024;
	Wed,  6 Aug 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bxs4OCqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EF28FAB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512656; cv=none; b=MXw3CM/Ivn4RtxcRFh4wBZd6rRlshlBPqCO0FlCFUgTPwgq2l7h4w30f+KqvsqIBxGuQghLyca9zb6sYu3qV4pL6wc8B5nJ5fn+188AmRuh6IVFsodMHuITnZ+IJal9uf28fBpgqUVU0fAYC0nIaaAwqFdobJl8auW5GK2pU+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512656; c=relaxed/simple;
	bh=zFXr2oXQU+wPk/q5XsK8v86y9WuV/IbDF9bSqLPil4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZn/DkRApeLkIIMRijFqtWA8AcawOWUQzBvoNuai7mHpgyHfQMYXRdHNK5ak0seSnfReOaSLTXSPoHWW0JrieFkDmdPmTRWKC6STZNFyVY0xyQCjpYL+FnoLwOobxSjQMhzScpVKthVBr1DygAMOiqJdq60L7p33iCVwJ1A4MiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bxs4OCqa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mTAcddqTdegcI9wUTwXmRYAU82kYQG5FuBK4SvQ8fY=;
	b=Bxs4OCqaoNQhRZeq1lzpsebWXbB3xTmZA7YvzZE/OHUxWUkoONnZfekSvGVC5vxDapglcO
	hV2xDM+Q/Z4m1pqgkVMyD3Wpxqjb9eB6pcHjJa9bKhkb0iPzFQD07vyfIz9pnIX4vA3Sio
	alx2+h5schh8i3id4140A4gtgyDO0r8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-BqD1cXXONoq46jbUZGk4Yw-1; Wed,
 06 Aug 2025 16:37:31 -0400
X-MC-Unique: BqD1cXXONoq46jbUZGk4Yw-1
X-Mimecast-MFC-AGG-ID: BqD1cXXONoq46jbUZGk4Yw_1754512649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AE618003FC;
	Wed,  6 Aug 2025 20:37:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CFD630001A2;
	Wed,  6 Aug 2025 20:37:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 03/31] netfs: Provide facility to alloc buffer in a bvecq
Date: Wed,  6 Aug 2025 21:36:24 +0100
Message-ID: <20250806203705.2560493-4-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Provide facility to allocate a series of bvecq structs and to attach
sufficient pages to that series to provide a buffer for the specified
amount of space.  This can be used to do things like creating an encryption
buffer in cifs and it can then be attached to an ITER_BVECQ iterator and
passed to a socket.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile     |   1 +
 fs/netfs/buffer.c     | 101 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   4 ++
 3 files changed, 106 insertions(+)
 create mode 100644 fs/netfs/buffer.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index b43188d64bd8..afab6603bd98 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 netfs-y := \
+	buffer.o \
 	buffered_read.o \
 	buffered_write.o \
 	direct_read.o \
diff --git a/fs/netfs/buffer.c b/fs/netfs/buffer.c
new file mode 100644
index 000000000000..1e4ed2746e95
--- /dev/null
+++ b/fs/netfs/buffer.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Buffering helpers for bvec_queues
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include "internal.h"
+
+void dump_bvecq(const struct bvecq *bq)
+{
+	int b = 0;
+
+	for (; bq; bq = bq->next, b++) {
+		printk("BQ[%u] %u/%u\n", b, bq->nr_segs, bq->max_segs);
+		for (int s = 0; s < bq->nr_segs; s++) {
+			const struct bio_vec *bv = &bq->bv[s];
+			printk("BQ[%u:%u] %10lx %04x %04x %u\n",
+			       b, s,
+			       bv->bv_page ? page_to_pfn(bv->bv_page) : 0,
+			       bv->bv_offset, bv->bv_len,
+			       page_count(bv->bv_page));
+		}
+	}
+}
+
+/**
+ * netfs_alloc_bvecq_buffer - Allocate buffer space into a bvec queue
+ * @size: Target size of the buffer.
+ * @pre_slots: Number of preamble slots to set aside
+ * @gfp: The allocation constraints.
+ */
+struct bvecq *netfs_alloc_bvecq_buffer(size_t size, unsigned int pre_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL, *p = NULL;
+	size_t count = DIV_ROUND_UP(size, PAGE_SIZE);
+	int max_segs = 32;
+
+	_enter("%zx,%zx,%u", size, count, pre_slots);
+
+	do {
+		struct page **pages;
+		int want, got;
+
+		p = kzalloc(struct_size(p, bv, max_segs), gfp);
+		if (!p)
+			goto oom;
+		if (tail) {
+			tail->next = p;
+			p->prev = tail;
+		} else {
+			head = p;
+		}
+		tail = p;
+		pages = (struct page **)&p->bv[max_segs];
+		pages -= max_segs - pre_slots;
+
+		want = umin(count, max_segs - pre_slots);
+		got = alloc_pages_bulk(gfp, want, pages);
+		if (got < want) {
+			for (int i = 0; i < got; i++)
+				__free_page(pages[i]);
+			goto oom;
+		}
+
+		tail->max_segs = max_segs;
+		tail->nr_segs = pre_slots + got;
+		for (int i = 0; i < got; i++) {
+			int j = pre_slots + i;
+			set_page_count(pages[i], 1);
+			bvec_set_page(&tail->bv[j], pages[i], PAGE_SIZE, 0);
+		}
+
+		count -= got;
+		pre_slots = 0;
+	} while (count > 0);
+
+	return head;
+oom:
+	netfs_free_bvecq_buffer(head);
+	return NULL;
+}
+EXPORT_SYMBOL(netfs_alloc_bvecq_buffer);
+
+/**
+ * netfs_free_bvecq_buffer - Free a bvec queue
+ * @bq: The start of the folio queue to free
+ *
+ * Free up a chain of bvecqs and the pages it points to.
+ */
+void netfs_free_bvecq_buffer(struct bvecq *bq)
+{
+	struct bvecq *next;
+
+	for (; bq; bq = next) {
+		for (int seg = 0; seg < bq->nr_segs; seg++)
+			__free_page(bq->bv[seg].bv_page);
+		next = bq->next;
+		kfree(bq);
+	}
+}
+EXPORT_SYMBOL(netfs_free_bvecq_buffer);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f43f075852c0..8756129b7472 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -23,6 +23,7 @@
 enum netfs_sreq_ref_trace;
 typedef struct mempool_s mempool_t;
 struct folio_queue;
+struct bvecq;
 
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
@@ -462,6 +463,9 @@ int netfs_alloc_folioq_buffer(struct address_space *mapping,
 			      struct folio_queue **_buffer,
 			      size_t *_cur_size, ssize_t size, gfp_t gfp);
 void netfs_free_folioq_buffer(struct folio_queue *fq);
+void dump_bvecq(const struct bvecq *bq);
+struct bvecq *netfs_alloc_bvecq_buffer(size_t size, unsigned int pre_slots, gfp_t gfp);
+void netfs_free_bvecq_buffer(struct bvecq *bq);
 
 /**
  * netfs_inode - Get the netfs inode context from the inode


