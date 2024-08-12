Return-Path: <linux-fsdevel+bounces-25631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9394E6AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5FC28285D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82915C139;
	Mon, 12 Aug 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QyZtj1Pr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4C14F9CD;
	Mon, 12 Aug 2024 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444312; cv=none; b=Jjj9lW3ZhC7gK65og2m7/oUUygApgpAo9tSeJ+sWasTmr4IRQhe9P92XvaiPzUdww1+bQgzzVsC1E5GLD8ecKTuyQITyXchdkFq/uVj8NnkHz3D4BWCzwN/XhBnhEJAmzNv6OH5B5NHh2RI9gjM8kidqeM5ar2o4va+vuHYzk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444312; c=relaxed/simple;
	bh=nO1ua8P1fLZQKekRVM8T+aQ/Y58x7jcLof0tR9dciBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0jjGEJJLXAmVWkS9X6yEWv11/bfIxwk6RBZC9PPE8epDPrUxatQkV6E6bbSReqiU7d9F0hV4HF70Qhzrc9+l6Bsy7gFZ8mhME96Sqt3+e1vsb1OUXA5gIFFEP6/uUk0KwWnhT8kY/D/fK6+E5dRwE5MzZeD4oFogHWoMnk7bt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QyZtj1Pr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uOesRX6lZJAn+lSw1bGL1mB36Q9A8URJKzcyDm35ieE=; b=QyZtj1PruDgvebO+0KAztpXsSK
	6wuR6cXdLTDgn3dl6Izqa2rUUBb2RIICpyUX3gt3EJ+blwzbns5qGUJFLz773tKM2yoxaf/4Xtg/z
	Pono/EKT6qzG8SPuXNk3loJOY9AN1kbw1lSdrtcvucC1uhtghI6FalGSbX+EETRQZGs7J8nkxerMI
	U25xKl0gd8KbGDHD8jpEFXXQpOAYqI7TerOoMT8VN0FmJVp0SKIhZ2t7kXNP9SXSWVCBwvHl4bNAb
	sORj4kcI/7NpqwGb8EYOGK3SB67L9opr6cbzqGM/9XNO/K9May3SA9exVfBXlH0l3ELJ1ob/SG0rW
	xWmQ2X0g==;
Received: from 2a02-8389-2341-5b80-ee60-2eea-6f8f-8d7f.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ee60:2eea:6f8f:8d7f] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOar-0000000H1LN-1Rtp;
	Mon, 12 Aug 2024 06:31:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] xarray: add xa_set
Date: Mon, 12 Aug 2024 08:31:00 +0200
Message-ID: <20240812063143.3806677-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812063143.3806677-1-hch@lst.de>
References: <20240812063143.3806677-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a convenience wrapper or xa_store that returns an error value when
there is an existing entry instead of the old entry.  This simplifies
code that wants to check that it is never overwriting an existing
entry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/xarray.h |  1 +
 lib/xarray.c           | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115fc..8dc4e575378ca5 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -354,6 +354,7 @@ struct xarray {
 
 void *xa_load(struct xarray *, unsigned long index);
 void *xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
+int xa_set(struct xarray *, unsigned long index, void *entry, gfp_t);
 void *xa_erase(struct xarray *, unsigned long index);
 void *xa_store_range(struct xarray *, unsigned long first, unsigned long last,
 			void *entry, gfp_t);
diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94ca1..500d3405c0c8c0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1600,6 +1600,39 @@ void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL(xa_store);
 
+/**
+ * xa_set() - Store this entry in the XArray.
+ * @xa: XArray.
+ * @index: Index into array.
+ * @entry: New entry.
+ * @gfp: Memory allocation flags.
+ *
+ * After this function returns, loads from this index will return @entry.
+ * Storing into an existing multi-index entry updates the entry of every index.
+ * The marks associated with @index are unaffected unless @entry is %NULL.
+ *
+ * Context: Any context.  Takes and releases the xa_lock.
+ * May sleep if the @gfp flags permit.
+ * Return: 0 on success, -EEXIST if there already is an entry at @index, -EINVAL
+ * if @entry cannot be stored in an XArray, or -ENOMEM if memory allocation
+ * failed.
+ */
+int xa_set(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
+{
+	int error = 0;
+	void *curr;
+
+	curr = xa_store(xa, index, entry, gfp);
+	if (curr) {
+		error = xa_err(curr);
+		if (error == 0)
+			error = -ENOENT;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(xa_set);
+
 /**
  * __xa_cmpxchg() - Store this entry in the XArray.
  * @xa: XArray.
-- 
2.43.0


