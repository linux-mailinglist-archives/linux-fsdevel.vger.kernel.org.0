Return-Path: <linux-fsdevel+bounces-25987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D459095241E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A30A289A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E11EB4AA;
	Wed, 14 Aug 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3a/u3jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F21D2F52
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668139; cv=none; b=VoGbreXKlo7KIwSBgkNEFZiGO0j1u6S8g5EC40Q2/l8UJcr1aULrWYclYTzPSsfUFFqgvPGEQF7XMH/Lv8Lf4VDRVUQaan6lxGb1KW97uI2gOHSbAZuy2YQpCSUlRtPTE3RvvZqm4BJmM32lPC/GsIvcDMEmew7RZR6tm2MWOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668139; c=relaxed/simple;
	bh=/4RHZpXKGmdLr3x2mXP5YKs8fw+5k6cV3FZeRK23GrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCsRfbBZTNGF5POBwXzvKk89ofGJj5zRz3FV3Jhx6T++svudxCUDhiD5lP/gacgjRYRV3tQKIEvAlBg1i6XHHY/0B836FNEX2agv22MNk+HDBxADfz9WeGWIjYbpRtHviFGksbPA5LMxXEwwiaY64GbUqwZd/2txT+H6GzHf0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3a/u3jj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4MNzaMiFDukGg48jovETePA3npABSpoRCz9c88nf5g=;
	b=A3a/u3jj/AEJaME6pQmEh7OFNH8wdTyvzaFBmJOYXWRgwfe7kqJgsFhi0ToLUMhyGk1wP3
	P/KUKxJ6iSR12fs7THr3HSNPYClNE5X9zwURgYh5/5a18E8prMFuJILGRJ0afGLm+LVDhR
	ZVqEoJQl0oL7mvf/lq7v0EE2xsZW+Tc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-k4Nb6-ZQNa-w-MVZAByrPQ-1; Wed,
 14 Aug 2024 16:42:11 -0400
X-MC-Unique: k4Nb6-ZQNa-w-MVZAByrPQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97CAC1954B0F;
	Wed, 14 Aug 2024 20:42:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B2041955F66;
	Wed, 14 Aug 2024 20:42:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH v2 25/25] cifs: Don't support ITER_XARRAY
Date: Wed, 14 Aug 2024 21:38:45 +0100
Message-ID: <20240814203850.2240469-26-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There's now no need to support ITER_XARRAY in cifs as netfslib hands down
ITER_FOLIOQ instead - and that's simpler to use with iterate_and_advance()
as it doesn't hold the RCU read lock over the step function.

This is part of the process of phasing out ITER_XARRAY.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsencrypt.c | 51 -------------------------------------
 fs/smb/client/smbdirect.c   | 49 -----------------------------------
 2 files changed, 100 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 991a1ab047e7..7481b21a0489 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -25,54 +25,6 @@
 #include "../common/arc4.h"
 #include <crypto/aead.h>
 
-/*
- * Hash data from an XARRAY-type iterator.
- */
-static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
-				 struct shash_desc *shash)
-{
-	struct folio *folios[16], *folio;
-	unsigned int nr, i, j, npages;
-	loff_t start = iter->xarray_start + iter->iov_offset;
-	pgoff_t last, index = start / PAGE_SIZE;
-	ssize_t ret = 0;
-	size_t len, offset, foffset;
-	void *p;
-
-	if (maxsize == 0)
-		return 0;
-
-	last = (start + maxsize - 1) / PAGE_SIZE;
-	do {
-		nr = xa_extract(iter->xarray, (void **)folios, index, last,
-				ARRAY_SIZE(folios), XA_PRESENT);
-		if (nr == 0)
-			return -EIO;
-
-		for (i = 0; i < nr; i++) {
-			folio = folios[i];
-			npages = folio_nr_pages(folio);
-			foffset = start - folio_pos(folio);
-			offset = foffset % PAGE_SIZE;
-			for (j = foffset / PAGE_SIZE; j < npages; j++) {
-				len = min_t(size_t, maxsize, PAGE_SIZE - offset);
-				p = kmap_local_page(folio_page(folio, j));
-				ret = crypto_shash_update(shash, p, len);
-				kunmap_local(p);
-				if (ret < 0)
-					return ret;
-				maxsize -= len;
-				if (maxsize <= 0)
-					return 0;
-				start += len;
-				offset = 0;
-				index++;
-			}
-		}
-	} while (nr == ARRAY_SIZE(folios));
-	return 0;
-}
-
 static size_t cifs_shash_step(void *iter_base, size_t progress, size_t len,
 			      void *priv, void *priv2)
 {
@@ -96,9 +48,6 @@ static int cifs_shash_iter(const struct iov_iter *iter, size_t maxsize,
 	struct iov_iter tmp_iter = *iter;
 	int err = -EIO;
 
-	if (iov_iter_type(iter) == ITER_XARRAY)
-		return cifs_shash_xarray(iter, maxsize, shash);
-
 	if (iterate_and_advance_kernel(&tmp_iter, maxsize, shash, &err,
 				       cifs_shash_step) != maxsize)
 		return err;
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index c946b38ca825..80262a36030f 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -2584,52 +2584,6 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
 	return ret;
 }
 
-/*
- * Extract folio fragments from an XARRAY-class iterator and add them to an
- * RDMA list.  The folios are not pinned.
- */
-static ssize_t smb_extract_xarray_to_rdma(struct iov_iter *iter,
-					  struct smb_extract_to_rdma *rdma,
-					  ssize_t maxsize)
-{
-	struct xarray *xa = iter->xarray;
-	struct folio *folio;
-	loff_t start = iter->xarray_start + iter->iov_offset;
-	pgoff_t index = start / PAGE_SIZE;
-	ssize_t ret = 0;
-	size_t off, len;
-	XA_STATE(xas, xa, index);
-
-	rcu_read_lock();
-
-	xas_for_each(&xas, folio, ULONG_MAX) {
-		if (xas_retry(&xas, folio))
-			continue;
-		if (WARN_ON(xa_is_value(folio)))
-			break;
-		if (WARN_ON(folio_test_hugetlb(folio)))
-			break;
-
-		off = offset_in_folio(folio, start);
-		len = min_t(size_t, maxsize, folio_size(folio) - off);
-
-		if (!smb_set_sge(rdma, folio_page(folio, 0), off, len)) {
-			rcu_read_unlock();
-			return -EIO;
-		}
-
-		maxsize -= len;
-		ret += len;
-		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
-			break;
-	}
-
-	rcu_read_unlock();
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
-}
-
 /*
  * Extract page fragments from up to the given amount of the source iterator
  * and build up an RDMA list that refers to all of those bits.  The RDMA list
@@ -2657,9 +2611,6 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	case ITER_FOLIOQ:
 		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
 		break;
-	case ITER_XARRAY:
-		ret = smb_extract_xarray_to_rdma(iter, rdma, len);
-		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;


