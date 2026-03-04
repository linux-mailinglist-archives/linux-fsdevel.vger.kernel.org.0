Return-Path: <linux-fsdevel+bounces-79388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOEsGqxCqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:33:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D02018F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59BC316C649
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6153BA25A;
	Wed,  4 Mar 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXSZv1h0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC83B4E9F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633107; cv=none; b=p9j1bpsgr7zW37X3azGLb6Edt+5JtLCVCJhxhMzAknn0O58K/6UFLLFaxDgzADuwdy5Zcid6PgKWKOncsu2rS+WQo4pffzFeqNIlA7J78YsuPt1twzLjG2TAvGwDYzZkCPqIng6Qxq/dEwEswQPrxSsPq0yVXnUrVyK17pJbAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633107; c=relaxed/simple;
	bh=6rmUXwRPi/9deMgHZ/4BLEmdII9DkKGjuMVzFhZqJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUAYf8lu8OgdNYTPgJCyJZ6B1Zak/SZq5dh4FOZ4/5T7Bws3omMu4Pfsab8XOILR9yK6LahKzAdZNF/yHvrPh0Wz+r1zTbkSZC2eT1YFckJ8beBzcvLQIrc9HTaLvuvmmJS/DuWn4N/zdFn+SLmSEm8Rqg7QP3/ZeVutkez69/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXSZv1h0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx8pwT7ge+YPd/TZGpnf3p6bgkYOOp5xdZ3o7PjHdZY=;
	b=gXSZv1h09FWP8MA/2qbqsHVBarNBU8MlpoFO9SCcl9rCakYEshck8FZXQyrcMjKhsLHuve
	aZ0ushIUUZXOhvgM0rLBdnnTtjfnZ1ZOVf1cLzJH4T1FJNHrnuKA8yS3pKh0ViG+6NzYa0
	ey0Z+4k8rwpZGVq9NcAj8L8jC9oxsdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-2Cpe5SxAPcK2ILBk9xIC2A-1; Wed,
 04 Mar 2026 09:04:59 -0500
X-MC-Unique: 2Cpe5SxAPcK2ILBk9xIC2A-1
X-Mimecast-MFC-AGG-ID: 2Cpe5SxAPcK2ILBk9xIC2A_1772633097
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E65161956094;
	Wed,  4 Mar 2026 14:04:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 969BA195608E;
	Wed,  4 Mar 2026 14:04:51 +0000 (UTC)
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
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>
Subject: [RFC PATCH 11/17] cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_rdma()
Date: Wed,  4 Mar 2026 14:03:18 +0000
Message-ID: <20260304140328.112636-12-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: B36D02018F0
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
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79388-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,samba.org:email,talpey.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email]
X-Rspamd-Action: no action

netfslib now only presents an bvecq queue and an associated ITER_BVECQ
iterator to the filesystem, so it isn't going to see ITER_KVEC, ITER_BVEC
or ITER_FOLIOQ iterators.  So remove that code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 165 --------------------------------------
 1 file changed, 165 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 0c6262010cd2..682df21c5ad2 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -3142,162 +3142,6 @@ static bool smb_set_sge(struct smb_extract_to_rdma *rdma,
 	return true;
 }
 
-/*
- * Extract page fragments from a BVEC-class iterator and add them to an RDMA
- * element list.  The pages are not pinned.
- */
-static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
-					struct smb_extract_to_rdma *rdma,
-					ssize_t maxsize)
-{
-	const struct bio_vec *bv = iter->bvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	ssize_t ret = 0;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		size_t off, len;
-
-		len = bv[i].bv_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		len = min_t(size_t, maxsize, len - start);
-		off = bv[i].bv_offset + start;
-
-		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
-			return -EIO;
-
-		ret += len;
-		maxsize -= len;
-		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
-}
-
-/*
- * Extract fragments from a KVEC-class iterator and add them to an RDMA list.
- * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
- * The pages are not pinned.
- */
-static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
-					struct smb_extract_to_rdma *rdma,
-					ssize_t maxsize)
-{
-	const struct kvec *kv = iter->kvec;
-	unsigned long start = iter->iov_offset;
-	unsigned int i;
-	ssize_t ret = 0;
-
-	for (i = 0; i < iter->nr_segs; i++) {
-		struct page *page;
-		unsigned long kaddr;
-		size_t off, len, seg;
-
-		len = kv[i].iov_len;
-		if (start >= len) {
-			start -= len;
-			continue;
-		}
-
-		kaddr = (unsigned long)kv[i].iov_base + start;
-		off = kaddr & ~PAGE_MASK;
-		len = min_t(size_t, maxsize, len - start);
-		kaddr &= PAGE_MASK;
-
-		maxsize -= len;
-		do {
-			seg = min_t(size_t, len, PAGE_SIZE - off);
-
-			if (is_vmalloc_or_module_addr((void *)kaddr))
-				page = vmalloc_to_page((void *)kaddr);
-			else
-				page = virt_to_page((void *)kaddr);
-
-			if (!smb_set_sge(rdma, page, off, seg))
-				return -EIO;
-
-			ret += seg;
-			len -= seg;
-			kaddr += PAGE_SIZE;
-			off = 0;
-		} while (len > 0 && rdma->nr_sge < rdma->max_sge);
-
-		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
-			break;
-		start = 0;
-	}
-
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
-}
-
-/*
- * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
- * list.  The folios are not pinned.
- */
-static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
-					  struct smb_extract_to_rdma *rdma,
-					  ssize_t maxsize)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	unsigned int slot = iter->folioq_slot;
-	ssize_t ret = 0;
-	size_t offset = iter->iov_offset;
-
-	BUG_ON(!folioq);
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		if (WARN_ON_ONCE(!folioq))
-			return -EIO;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (offset < fsize) {
-			size_t part = umin(maxsize, fsize - offset);
-
-			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
-				return -EIO;
-
-			offset += part;
-			ret += part;
-			maxsize -= part;
-		}
-
-		if (offset >= fsize) {
-			offset = 0;
-			slot++;
-			if (slot >= folioq_nr_slots(folioq)) {
-				if (!folioq->next) {
-					WARN_ON_ONCE(ret < iter->count);
-					break;
-				}
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
-
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	iter->iov_offset = offset;
-	iter->count -= ret;
-	return ret;
-}
-
 /*
  * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
  * list.  The folios are not pinned.
@@ -3373,15 +3217,6 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	int before = rdma->nr_sge;
 
 	switch (iov_iter_type(iter)) {
-	case ITER_BVEC:
-		ret = smb_extract_bvec_to_rdma(iter, rdma, len);
-		break;
-	case ITER_KVEC:
-		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
-		break;
-	case ITER_FOLIOQ:
-		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
-		break;
 	case ITER_BVECQ:
 		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
 		break;


