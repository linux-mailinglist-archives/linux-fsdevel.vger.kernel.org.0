Return-Path: <linux-fsdevel+bounces-79389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJyVClY+qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:14:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B320121D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1B731E6CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F43BD635;
	Wed,  4 Mar 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZMvukIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB403B4EA8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633110; cv=none; b=YO6R7c2B8rM98zEcZsBUwmTeMiw8bFabntC4uHpCxv7Oq3qrDD86KVqU/i7cIdsFcJpfg8wbjVGNsO5zWAEDtDdyYdyFgVmejiBvbZIgYs1yl+3PC9j9sXYGZBta8hRdi8E2tr202FNhatmWGqkw3wSELVzOJSTtPy9Uof4qXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633110; c=relaxed/simple;
	bh=57dWZEhyDFUlzqKRV/6JCGGq4V/AfRANMCP2O6+NUPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2PT5ueyAtJNXqNziPE0to4iELLkGW9JI1Cu3VwnEDu8rLMWI1P2h7c2MVDEHJXTOzlmv++4nCGHmTeGSY7OlmvssZd+/3XP/0bTIsqkhVb5paq9mXDDG5eL7R6OGE9N3GwbIixyA1H0KuQdCRXKcISqtXYHAW6+MaPKxzG7DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZMvukIF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FdAONutYZfTMq21H+B5hhNlT9a5FjHMqQE+GvjNNa4=;
	b=UZMvukIFgzxJR8D6XSjtO5Y3WRGgamZ5uDttL0JO1Yso7FVJqwGybeOMFsUf79F0YMQlEB
	EpWC3THhRmVAU7ekUnX3kFC1b7c4FNcJb8V733RhUS1X9efF2Jo1O74xBx+JP9Qcip+AnF
	rmts59qJFYQAVuqGvFFHtLq5Tp1MyUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-n0yev59CP2GCuS8n3IxcAg-1; Wed,
 04 Mar 2026 09:05:05 -0500
X-MC-Unique: n0yev59CP2GCuS8n3IxcAg-1
X-Mimecast-MFC-AGG-ID: n0yev59CP2GCuS8n3IxcAg_1772633103
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C0021956094;
	Wed,  4 Mar 2026 14:05:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A882D1958DC2;
	Wed,  4 Mar 2026 14:04:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>
Subject: [RFC PATCH 12/17] netfs: Remove netfs_alloc/free_folioq_buffer()
Date: Wed,  4 Mar 2026 14:03:19 +0000
Message-ID: <20260304140328.112636-13-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 815B320121D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79389-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,samba.org:email,manguebit.org:email]
X-Rspamd-Action: no action

Remove netfs_alloc/free_folioq_buffer() as these have been replaced with
netfs_alloc/free_bvecq_buffer().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir_edit.c         |  1 -
 fs/netfs/misc.c           | 98 ---------------------------------------
 fs/smb/client/smb2ops.c   |  1 -
 fs/smb/client/smbdirect.c |  1 -
 include/linux/netfs.h     |  4 --
 5 files changed, 105 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index ef9066659438..ebe8cfd050a9 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -10,7 +10,6 @@
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/iversion.h>
-#include <linux/folio_queue.h>
 #include "internal.h"
 #include "xdr_fs.h"
 
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index ab142cbaad35..a19724389147 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,104 +8,6 @@
 #include <linux/swap.h>
 #include "internal.h"
 
-#if 0
-/**
- * netfs_alloc_folioq_buffer - Allocate buffer space into a folio queue
- * @mapping: Address space to set on the folio (or NULL).
- * @_buffer: Pointer to the folio queue to add to (may point to a NULL; updated).
- * @_cur_size: Current size of the buffer (updated).
- * @size: Target size of the buffer.
- * @gfp: The allocation constraints.
- */
-int netfs_alloc_folioq_buffer(struct address_space *mapping,
-			      struct folio_queue **_buffer,
-			      size_t *_cur_size, ssize_t size, gfp_t gfp)
-{
-	struct folio_queue *tail = *_buffer, *p;
-
-	size = round_up(size, PAGE_SIZE);
-	if (*_cur_size >= size)
-		return 0;
-
-	if (tail)
-		while (tail->next)
-			tail = tail->next;
-
-	do {
-		struct folio *folio;
-		int order = 0, slot;
-
-		if (!tail || folioq_full(tail)) {
-			p = netfs_folioq_alloc(0, GFP_NOFS, netfs_trace_folioq_alloc_buffer);
-			if (!p)
-				return -ENOMEM;
-			if (tail) {
-				tail->next = p;
-				p->prev = tail;
-			} else {
-				*_buffer = p;
-			}
-			tail = p;
-		}
-
-		if (size - *_cur_size > PAGE_SIZE)
-			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
-				     MAX_PAGECACHE_ORDER);
-
-		folio = folio_alloc(gfp, order);
-		if (!folio && order > 0)
-			folio = folio_alloc(gfp, 0);
-		if (!folio)
-			return -ENOMEM;
-
-		folio->mapping = mapping;
-		folio->index = *_cur_size / PAGE_SIZE;
-		trace_netfs_folio(folio, netfs_folio_trace_alloc_buffer);
-		slot = folioq_append_mark(tail, folio);
-		*_cur_size += folioq_folio_size(tail, slot);
-	} while (*_cur_size < size);
-
-	return 0;
-}
-EXPORT_SYMBOL(netfs_alloc_folioq_buffer);
-
-/**
- * netfs_free_folioq_buffer - Free a folio queue.
- * @fq: The start of the folio queue to free
- *
- * Free up a chain of folio_queues and, if marked, the marked folios they point
- * to.
- */
-void netfs_free_folioq_buffer(struct folio_queue *fq)
-{
-	struct folio_queue *next;
-	struct folio_batch fbatch;
-
-	folio_batch_init(&fbatch);
-
-	for (; fq; fq = next) {
-		for (int slot = 0; slot < folioq_count(fq); slot++) {
-			struct folio *folio = folioq_folio(fq, slot);
-
-			if (!folio ||
-			    !folioq_is_marked(fq, slot))
-				continue;
-
-			trace_netfs_folio(folio, netfs_folio_trace_put);
-			if (folio_batch_add(&fbatch, folio))
-				folio_batch_release(&fbatch);
-		}
-
-		netfs_stat_d(&netfs_n_folioq);
-		next = fq->next;
-		kfree(fq);
-	}
-
-	folio_batch_release(&fbatch);
-}
-EXPORT_SYMBOL(netfs_free_folioq_buffer);
-#endif
-
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 76baf21404df..7223a8deaa58 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -13,7 +13,6 @@
 #include <linux/sort.h>
 #include <crypto/aead.h>
 #include <linux/fiemap.h>
-#include <linux/folio_queue.h>
 #include <uapi/linux/magic.h>
 #include "cifsfs.h"
 #include "cifsglob.h"
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 682df21c5ad2..8ffb5d1eba62 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -6,7 +6,6 @@
  */
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/folio_queue.h>
 #define __SMBDIRECT_SOCKET_DISCONNECT(__sc) smbd_disconnect_rdma_connection(__sc)
 #include "../common/smbdirect/smbdirect_pdu.h"
 #include "smbdirect.h"
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a48f03e85b6a..e49cb8ffb811 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -467,10 +467,6 @@ int netfs_start_io_direct(struct inode *inode);
 void netfs_end_io_direct(struct inode *inode);
 
 /* Buffer wrangling helpers API. */
-int netfs_alloc_folioq_buffer(struct address_space *mapping,
-			      struct folio_queue **_buffer,
-			      size_t *_cur_size, ssize_t size, gfp_t gfp);
-void netfs_free_folioq_buffer(struct folio_queue *fq);
 void dump_bvecq(const struct bvecq *bq);
 struct bvecq *netfs_alloc_bvecq(size_t nr_slots, gfp_t gfp);
 struct bvecq *netfs_alloc_bvecq_buffer(size_t size, unsigned int pre_slots, gfp_t gfp);


