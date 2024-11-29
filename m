Return-Path: <linux-fsdevel+bounces-36120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB55A9DBF45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C1B227BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6731586FE;
	Fri, 29 Nov 2024 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQe0kAs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25C1547FF;
	Fri, 29 Nov 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859476; cv=none; b=MQT1SNzZfZluoM0FUyVeK4xF1Tx3E/PDtrNvwe4tWdUcn1G3BdGo3YdR9xWqaPmEbb5WMNgZhZzvi5Y+D7IC+4dZR0JPSeMJgbLmg/KdFZJzanN+q55zvM21elpQ0cRGAzhhgB4tIWciEFM4NwiDcL9LM/btAeMcexgPH+EbNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859476; c=relaxed/simple;
	bh=Mo7AaEyggumGpBesl6r/leiOUwc/0DwY7vPrbKdhupk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9Kz++v3HM04+iE3fapiDRlIPmqRfkQxsc3ACtT6EK3YLGi/wcCoW/iiZv5B94dfQyA8DQYI+qdDhTTVT0Xw29pYoBmhzZXhJqqt0ndcl3/bEwPbZcheUqAHguKFeOYq7yeHX0NCPuquunZv0XP+QrrSIVCKtkniV4TPBiDp2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQe0kAs0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9osMA2BWyr113bhiYGTMNySakfScKek4ObQ9ddCkgzs=; b=UQe0kAs0+02ehYdvpAScpGxVHK
	4jEt3FxJidT7jWXeUCbtWbDXcqVv33bL1Du+U3GsCktrjvsB27FdvpnB3aNBRnJR20gT8GxZLMjxQ
	hW7XJlYlW9okA35joiMkD5bE5rBMf+gyWc/Ixsqn0UmG4VWkCk0shDH1IrO1Qa2XBM4+msjjzZPV8
	KNy1Hl76vWjcb34N1mamDgJNmMiVMdDUz5Sea0BS99BW+l41hd7ca9HBzH0N/IOOHeJcNWPutkmlU
	ez4Qo49bv2B9tsFMwplQjOkfjlC8tVq+tlgzH7dAofaVy6qlhp4JK5yQp7WAX5kD0OYjcn3rwCKFl
	RXlvsvGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bS8-0lg6;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 1/5] ceph: Do not look at the index of an encrypted page
Date: Fri, 29 Nov 2024 05:50:52 +0000
Message-ID: <20241129055058.858940-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129055058.858940-1-willy@infradead.org>
References: <20241129055058.858940-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the pages array contains encrypted pages, we cannot look at
page->index because that field is uninitialised.  Instead, use the new
ceph_fscrypt_pagecache_folio() to get the pagecache folio and look at
the index of that.

Fixes: 4de77f25fd85 (ceph: use osd_req_op_extent_osd_iter for netfs reads)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c   | 5 ++++-
 fs/ceph/crypto.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4c82348fe1e6..284a6244fcdf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1346,8 +1346,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 			memset(data_pages + i, 0,
 			       locked_pages * sizeof(*pages));
 		} else {
+			struct folio *folio;
+
 			BUG_ON(num_ops != req->r_num_ops);
-			index = pages[i - 1]->index + 1;
+			folio = ceph_fscrypt_pagecache_folio(pages[i - 1]);
+			index = folio->index + 1;
 			/* request message now owns the pages array */
 			pages = NULL;
 		}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 47e0c319fc68..7d75c4874aa8 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -280,6 +280,13 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
 }
 #endif /* CONFIG_FS_ENCRYPTION */
 
+static inline struct folio *ceph_fscrypt_pagecache_folio(struct page *page)
+{
+	if (fscrypt_is_bounce_page(page))
+		page = fscrypt_pagecache_page(page);
+	return page_folio(page);
+}
+
 static inline loff_t ceph_fscrypt_page_offset(struct page *page)
 {
 	return page_offset(ceph_fscrypt_pagecache_page(page));
-- 
2.45.2


