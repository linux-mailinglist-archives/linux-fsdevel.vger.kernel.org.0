Return-Path: <linux-fsdevel+bounces-66565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3DC24359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51183B922B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516032ED51;
	Fri, 31 Oct 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IYwDYIwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A452E092D;
	Fri, 31 Oct 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903332; cv=none; b=A7RZznLkQJO05q8XtwDvRayiXkZUYZdXxfT+/UMHnzmAV/ZZtj01TEWKF+rLyJSx8XhWcFKn86h6pkLtIX+nDiJG7lMokUBWzJTJqpPdx4SZt10zfQQyj5AGveDcY5xgkWaIGCl4ELbCyOHJQB8G2iQtjFfeipPxn4+TagRqr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903332; c=relaxed/simple;
	bh=65OeWv1EjMDC7E/eLwDPlThKen/QNw+GYNtDvKHqvBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POOWmaQI7L41rz+/YlGLzoFrd+ktBxsoT43SIuvXFvR0fyYDuRtNvxZYVaH4J55DZQTMHuF06uweJbYsVjSs3utcZZ8pECCJmA26pkxR2T43TEwVvX/ZUXGyi8G54XcuXQWpiktak3DkhsVrGNwKHlJLZkRUd2mHdCnD31iDEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IYwDYIwc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b2coAJCg92j+BeJ5vt0cc/6wfrBqktDNumrNdVrqDsQ=; b=IYwDYIwcriYDIrrFeQIzb7kO0k
	UkviU7sNtRj3uONw6ejFOURGcwB/Pqj0NT86rFkNlFVvCJ7lgjgg5Bvof3WL9JDgxV/OX45jDy/mP
	34sx/yS5GVjEvtRAqm7mwYyZY2alSd94bOWvreQq74u+v38x1P8WwQ82JWemUC4oXPL0g9ua6gTzs
	tbbChKXJNKuprtMfsVEmVlD6TSfcnlT0Yu1y232RDdmZc+izl9KcFOsr2K14/gJna8039unYSCJTJ
	THCj1aAT2X4lj4zlPOOTaYCDnS87OmqzHzLHD5sM+qaVDAefll3A7c0mJR9ptd3prCZP0Kz+kC3xQ
	mxBi6OLg==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElXb-00000005opN-384m;
	Fri, 31 Oct 2025 09:35:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/9] mempool: update kerneldoc comments
Date: Fri, 31 Oct 2025 10:34:31 +0100
Message-ID: <20251031093517.1603379-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use proper formatting, use full sentences and reduce some verbosity in
function parameter descriptions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 1c38e873e546..d7c55a98c2be 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -372,18 +372,15 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 EXPORT_SYMBOL(mempool_resize);
 
 /**
- * mempool_alloc - allocate an element from a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
- * @gfp_mask:  the usual allocation bitmask.
+ * mempool_alloc - allocate an element from a memory pool
+ * @pool:	pointer to the memory pool
+ * @gfp_mask:	GFP_* flags.
  *
- * this function only sleeps if the alloc_fn() function sleeps or
- * returns NULL. Note that due to preallocation, this function
- * *never* fails when called from process contexts. (it might
- * fail if called from an IRQ context.)
- * Note: using __GFP_ZERO is not supported.
+ * Note: This function only sleeps if the alloc_fn callback sleeps or returns
+ * %NULL.  Using __GFP_ZERO is not supported.
  *
- * Return: pointer to the allocated element or %NULL on error.
+ * Return: pointer to the allocated element or %NULL on error. This function
+ * never returns %NULL when @gfp_mask allows sleeping.
  */
 void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 {
@@ -456,11 +453,10 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
 
 /**
  * mempool_alloc_preallocated - allocate an element from preallocated elements
- *                              belonging to a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
+ *                              belonging to a memory pool
+ * @pool:	pointer to the memory pool
  *
- * This function is similar to mempool_alloc, but it only attempts allocating
+ * This function is similar to mempool_alloc(), but it only attempts allocating
  * an element from the preallocated elements. It does not sleep and immediately
  * returns if no preallocated elements are available.
  *
@@ -492,12 +488,14 @@ void *mempool_alloc_preallocated(mempool_t *pool)
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
 /**
- * mempool_free - return an element to the pool.
- * @element:   pool element pointer.
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
+ * mempool_free - return an element to a mempool
+ * @element:	pointer to element
+ * @pool:	pointer to the memory pool
+ *
+ * Returns @elem to @pool if its needs replenishing, else free it using
+ * the free_fn callback in @pool.
  *
- * this function only sleeps if the free_fn() function sleeps.
+ * This function only sleeps if the free_fn callback sleeps.
  */
 void mempool_free(void *element, mempool_t *pool)
 {
-- 
2.47.3


