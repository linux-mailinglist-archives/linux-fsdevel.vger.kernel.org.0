Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6D17962B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgCDRB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:01:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729733AbgCDQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6J5XCx0kMPd1dVsDnBHHYs7u5PYfcv7KGfFAmsKVQE=;
        b=T5Wz4jgfA+OA+NuhHEDdtBzVGRQqr0r/xDdsP9pIAZzajmg12slfSeQRJ3+1VTDN5r4oZj
        /4weajiEBx8PFXaZYlRxp/4j9x8smCZJLET8u+jajsSovgH9QyLJKR8Onq157SmepmnJow
        cf1IWnEtbPaxwxhS1qQx3hhMIZn5flc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-1ZgCRd3bPSKznatq-Wu17g-1; Wed, 04 Mar 2020 11:59:12 -0500
X-MC-Unique: 1ZgCRd3bPSKznatq-Wu17g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B5C8017CC;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99AE960C84;
        Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3C45D2257D4; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 02/20] dax: Create a range version of dax_layout_busy_page()
Date:   Wed,  4 Mar 2020 11:58:27 -0500
Message-Id: <20200304165845.3081-3-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs device has a range of memory which is mapped into file inodes
using dax. This memory is mapped in qemu on host and maps different
sections of real file on host. Size of this memory is limited
(determined by administrator) and depending on filesystem size, we will
soon reach a situation where all the memory is in use and we need to
reclaim some.

As part of reclaim process, we will need to make sure that there are
no active references to pages (taken by get_user_pages()) on the memory
range we are trying to reclaim. I am planning to use
dax_layout_busy_page() for this. But in current form this is per inode
and scans through all the pages of the inode.

We want to reclaim only a portion of memory (say 2MB page). So we want
to make sure that only that 2MB range of pages do not have any
references  (and don't want to unmap all the pages of inode).

Hence, create a range version of this function named
dax_layout_busy_page_range() which can be used to pass a range which
needs to be unmapped.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 66 ++++++++++++++++++++++++++++++++-------------
 include/linux/dax.h |  6 +++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..fde92bb5da69 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -558,27 +558,20 @@ static void *grab_mapping_entry(struct xa_state *xa=
s,
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
=20
-/**
- * dax_layout_busy_page - find first pinned page in @mapping
- * @mapping: address space to scan for a page with ref count > 1
- *
- * DAX requires ZONE_DEVICE mapped pages. These pages are never
- * 'onlined' to the page allocator so they are considered idle when
- * page->count =3D=3D 1. A filesystem uses this interface to determine i=
f
- * any page in the mapping is busy, i.e. for DMA, or other
- * get_user_pages() usages.
- *
- * It is expected that the filesystem is holding locks to block the
- * establishment of new mappings in this address_space. I.e. it expects
- * to be able to run unmap_mapping_range() and subsequently not race
- * mapping_mapped() becoming true.
+/*
+ * Partial pages are included. If end is 0, pages in the range from star=
t
+ * to end of the file are inluded.
  */
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_busy_page_range(struct address_space *mapping,
+					loff_t start, loff_t end)
 {
-	XA_STATE(xas, &mapping->i_pages, 0);
 	void *entry;
 	unsigned int scanned =3D 0;
 	struct page *page =3D NULL;
+	pgoff_t start_idx =3D start >> PAGE_SHIFT;
+	pgoff_t end_idx =3D end >> PAGE_SHIFT;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+	loff_t len, lstart =3D round_down(start, PAGE_SIZE);
=20
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -589,6 +582,22 @@ struct page *dax_layout_busy_page(struct address_spa=
ce *mapping)
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
=20
+	/* If end =3D=3D 0, all pages from start to till end of file */
+	if (!end) {
+		end_idx =3D ULONG_MAX;
+		len =3D 0;
+	} else {
+		/* length is being calculated from lstart and not start.
+		 * This is due to behavior of unmap_mapping_range(). If
+		 * start is say 4094 and end is on 4096 then we want to
+		 * unamp two pages, idx 0 and 1. But unmap_mapping_range()
+		 * will unmap only page at idx 0. If we calculate len
+		 * from the rounded down start, this problem should not
+		 * happen.
+		 */
+		len =3D end - lstart + 1;
+	}
+
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
 	 * elevated page count in the iteration and wait, or
@@ -601,10 +610,10 @@ struct page *dax_layout_busy_page(struct address_sp=
ace *mapping)
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 0);
+	unmap_mapping_range(mapping, start, len, 0);
=20
 	xas_lock_irq(&xas);
-	xas_for_each(&xas, entry, ULONG_MAX) {
+	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
 		if (unlikely(dax_is_locked(entry)))
@@ -625,6 +634,27 @@ struct page *dax_layout_busy_page(struct address_spa=
ce *mapping)
 	xas_unlock_irq(&xas);
 	return page;
 }
+EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+
+/**
+ * dax_layout_busy_page - find first pinned page in @mapping
+ * @mapping: address space to scan for a page with ref count > 1
+ *
+ * DAX requires ZONE_DEVICE mapped pages. These pages are never
+ * 'onlined' to the page allocator so they are considered idle when
+ * page->count =3D=3D 1. A filesystem uses this interface to determine i=
f
+ * any page in the mapping is busy, i.e. for DMA, or other
+ * get_user_pages() usages.
+ *
+ * It is expected that the filesystem is holding locks to block the
+ * establishment of new mappings in this address_space. I.e. it expects
+ * to be able to run unmap_mapping_range() and subsequently not race
+ * mapping_mapped() becoming true.
+ */
+struct page *dax_layout_busy_page(struct address_space *mapping)
+{
+	return dax_layout_busy_page_range(mapping, 0, 0);
+}
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
=20
 static int __dax_invalidate_entry(struct address_space *mapping,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..4fd4f866a4d3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -139,6 +139,7 @@ int dax_writeback_mapping_range(struct address_space =
*mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
=20
 struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, l=
off_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -169,6 +170,11 @@ static inline struct page *dax_layout_busy_page(stru=
ct address_space *mapping)
 	return NULL;
 }
=20
+static inline struct page *dax_layout_busy_page_range(struct address_spa=
ce *mapping, pgoff_t start, pgoff_t nr_pages)
+{
+	return NULL;
+}
+
 static inline int dax_writeback_mapping_range(struct address_space *mapp=
ing,
 		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
--=20
2.20.1

