Return-Path: <linux-fsdevel+bounces-41730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62CA36277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A1A168FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADD267391;
	Fri, 14 Feb 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHp7C0G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28A26738A;
	Fri, 14 Feb 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548641; cv=none; b=sIf8oEIGmt4+vZnRCQ/0hO2mo9Z/7WvR5H7S0S47wsmI/dDMRsJ+iQi135Wr+IAg5uQ5TLCq6H2Wu89B6DkZ+e+e3KEJcV6acV966f5F+97aoyCX8lM0OVtoQcfpPngAoplt0RrHihMLtD0F9S4dmYVDXLd0d5M+/aOSFqQny4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548641; c=relaxed/simple;
	bh=V2WdWZtV5sJK08vSrHBslh3FN1BkfppKSS1kC9pPA18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm55XIGJPlRwVS4aeJL5hkTLFC+mawdpGAZBNkC7v/MRex0WhFMrXOvuENdWTFyVWWHyXSw76Q9o5zas0oG+2LZiVEN/S7hFO4t4aKkQd45dx3Q8VxGiZ/6QdSKI/ucYqHr8MbeMyX52qulG5/IyD7Exugqtipk8uwyGJRINZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CHp7C0G/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BtaM8vIK6fc91Qwjb0IkXbeZzTod+97mIFynOQfgp8Y=; b=CHp7C0G/XX1J8zETRZg0UPhJLK
	QZ2L7mSNY77eehE102qB0cbwVPXyeTjSQnPkLwF6eoPhvQohh1w9tJHqGBrtaDs8Ld9k32Vluw3dL
	vtC5woduSDqgT0WML3et8m8+I9YHuk6qcOYNBwfTsX+hmH044M59T7/YHYqC5qOnKWkNragqc4l+F
	Ysu6R/lTp1ryMNBcfRga5RCcwWNhiYWZy6TOfY1ULxV98y/TM6W5IZ9xlDLmTdhxkLe3E7T79EQ12
	aCRUIJI4A/Aq0fG3bLN3mJj56TLiRiRnYFRPHBOBvKUsbfDv4pqXxQijTXXQB97GRs5j1NHC67GrW
	4HrRQXjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiy40-0000000Bhxk-1ieL;
	Fri, 14 Feb 2025 15:57:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 1/7] ceph: Do not look at the index of an encrypted page
Date: Fri, 14 Feb 2025 15:57:03 +0000
Message-ID: <20250214155710.2790505-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214155710.2790505-1-willy@infradead.org>
References: <20250214155710.2790505-1-willy@infradead.org>
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

Fixes: d55207717ded (ceph: add encryption support to writepage and writepages)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c   | 5 ++++-
 fs/ceph/crypto.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f5224a566b69..80bc0cbacd7a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1356,8 +1356,11 @@ static int ceph_writepages_start(struct address_space *mapping,
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
index d0768239a1c9..e4404ef589a1 100644
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
2.47.2


