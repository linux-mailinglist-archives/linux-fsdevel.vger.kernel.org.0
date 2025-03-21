Return-Path: <linux-fsdevel+bounces-44721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C5A6BF69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE13B8A12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4C22CBEF;
	Fri, 21 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReVVc8x7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0522B8BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573669; cv=none; b=A7WnNVRKvG/0DxaGinrHuPj0imhsl4NZbct06tmGUiJoXMLt39vfVG+U+88CiHWlbUr6ndS9lsHZmYy8SwLHTRw4OsvWYGQXpohSNrKIQCBC4IAbzHKhlN+89+QTegK5WI7EIi4/tC/M4GKmZObIG0fiPgaA4UP5sqC3N2kIm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573669; c=relaxed/simple;
	bh=9ndzdhte+6JNVy/8URnQXZLHzsej+iACNbrr7M5jc8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFkcx9LoerdpJ+OObtjE4EMji8IpfQQTYpI61lAeNfJrmEonZMR2Go7HhNfLPkh4h1ovP9hRosYJVpLJ1MsZnJJopFRn4gJ82y+37lku4qIqSx2Z13dLJu5Nx60QylSImm3df/44mLcSLvCqBW86biSk6qdi3ldu5QwQxNtF3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReVVc8x7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0wLDVf11WSl4C3Uw20envF+F+Pk9F9IBIa6lbPk+B4=;
	b=ReVVc8x7glk9F3twFW+Tb76dMivjikFAN0Ad1aW82a4XQw4RPKaA8p2fldsYEM5nKvQGop
	nSMHmI6SbvegcCHcL1BMriHIYIF9oACb+/krWjRaI5zvY7lVwIDWP5JnMrF992g/ujY64c
	RWTC6UvTZptQ660AmzQH8iR4UaQOCl4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-y0Bk-TPyNnulgNwPsh9IvA-1; Fri,
 21 Mar 2025 12:14:22 -0400
X-MC-Unique: y0Bk-TPyNnulgNwPsh9IvA-1
X-Mimecast-MFC-AGG-ID: y0Bk-TPyNnulgNwPsh9IvA_1742573659
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFE271800875;
	Fri, 21 Mar 2025 16:14:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7507E1955BFE;
	Fri, 21 Mar 2025 16:14:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] iov_iter: Move ITER_DISCARD and ITER_XARRAY iteration out-of-line
Date: Fri, 21 Mar 2025 16:14:01 +0000
Message-ID: <20250321161407.3333724-2-dhowells@redhat.com>
In-Reply-To: <20250321161407.3333724-1-dhowells@redhat.com>
References: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move ITER_DISCARD and ITER_XARRAY iteration out-of-line in preparation of
adding other iteration types which will also be out-of-line.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/iov_iter.h | 77 +++-----------------------------------
 lib/iov_iter.c           | 81 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index c4aa58032faf..0c47933df517 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -17,6 +17,9 @@ typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 typedef size_t (*iov_ustep_f)(void __user *iter_base, size_t progress, size_t len,
 			      void *priv, void *priv2);
 
+size_t __iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
+			      void *priv2, iov_ustep_f ustep, iov_step_f step);
+
 /*
  * Handle ITER_UBUF.
  */
@@ -195,72 +198,6 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 	return progress;
 }
 
-/*
- * Handle ITER_XARRAY.
- */
-static __always_inline
-size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		      iov_step_f step)
-{
-	struct folio *folio;
-	size_t progress = 0;
-	loff_t start = iter->xarray_start + iter->iov_offset;
-	pgoff_t index = start / PAGE_SIZE;
-	XA_STATE(xas, iter->xarray, index);
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, ULONG_MAX) {
-		size_t remain, consumed, offset, part, flen;
-
-		if (xas_retry(&xas, folio))
-			continue;
-		if (WARN_ON(xa_is_value(folio)))
-			break;
-		if (WARN_ON(folio_test_hugetlb(folio)))
-			break;
-
-		offset = offset_in_folio(folio, start + progress);
-		flen = min(folio_size(folio) - offset, len);
-
-		while (flen) {
-			void *base = kmap_local_folio(folio, offset);
-
-			part = min_t(size_t, flen,
-				     PAGE_SIZE - offset_in_page(offset));
-			remain = step(base, progress, part, priv, priv2);
-			kunmap_local(base);
-
-			consumed = part - remain;
-			progress += consumed;
-			len -= consumed;
-
-			if (remain || len == 0)
-				goto out;
-			flen -= consumed;
-			offset += consumed;
-		}
-	}
-
-out:
-	rcu_read_unlock();
-	iter->iov_offset += progress;
-	iter->count -= progress;
-	return progress;
-}
-
-/*
- * Handle ITER_DISCARD.
- */
-static __always_inline
-size_t iterate_discard(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		      iov_step_f step)
-{
-	size_t progress = len;
-
-	iter->count -= progress;
-	return progress;
-}
-
 /**
  * iterate_and_advance2 - Iterate over an iterator
  * @iter: The iterator to iterate over.
@@ -306,9 +243,7 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
-	if (iov_iter_is_xarray(iter))
-		return iterate_xarray(iter, len, priv, priv2, step);
-	return iterate_discard(iter, len, priv, priv2, step);
+	return __iterate_and_advance2(iter, len, priv, priv2, ustep, step);
 }
 
 /**
@@ -370,9 +305,7 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
-	if (iov_iter_is_xarray(iter))
-		return iterate_xarray(iter, len, priv, priv2, step);
-	return iterate_discard(iter, len, priv, priv2, step);
+	return __iterate_and_advance2(iter, len, priv, priv2, NULL, step);
 }
 
 #endif /* _LINUX_IOV_ITER_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..33a8746e593e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1927,3 +1927,84 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
+
+/*
+ * Handle ITER_XARRAY.
+ */
+static __always_inline
+size_t iterate_xarray(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		      iov_step_f step)
+{
+	struct folio *folio;
+	size_t progress = 0;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	XA_STATE(xas, iter->xarray, index);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t remain, consumed, offset, part, flen;
+
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset = offset_in_folio(folio, start + progress);
+		flen = min(folio_size(folio) - offset, len);
+
+		while (flen) {
+			void *base = kmap_local_folio(folio, offset);
+
+			part = min_t(size_t, flen,
+				     PAGE_SIZE - offset_in_page(offset));
+			remain = step(base, progress, part, priv, priv2);
+			kunmap_local(base);
+
+			consumed = part - remain;
+			progress += consumed;
+			len -= consumed;
+
+			if (remain || len == 0)
+				goto out;
+			flen -= consumed;
+			offset += consumed;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	iter->iov_offset += progress;
+	iter->count -= progress;
+	return progress;
+}
+
+/*
+ * Handle ITER_DISCARD.
+ */
+static __always_inline
+size_t iterate_discard(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		      iov_step_f step)
+{
+	size_t progress = len;
+
+	iter->count -= progress;
+	return progress;
+}
+
+/*
+ * Out of line iteration for iterator types that don't need such fast handling.
+ */
+size_t __iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
+			      void *priv2, iov_ustep_f ustep, iov_step_f step)
+{
+	if (iov_iter_is_discard(iter))
+		return iterate_discard(iter, len, priv, priv2, step);
+	if (iov_iter_is_xarray(iter))
+		return iterate_xarray(iter, len, priv, priv2, step);
+	WARN_ON(1);
+	return 0;
+}
+EXPORT_SYMBOL(__iterate_and_advance2);


