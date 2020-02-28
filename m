Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0584173D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1QfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:35:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgB1QfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582907723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCArjreFqVZbPsqbFRQ3irhpPhuMUp5bwav8b5wQZO4=;
        b=hfkW9mD62iGZh9fP+QWbxnxMFYfsrvVwQEGg3NCyeLP3ZxrIq5cKclE6RT4+udQKZg/Ste
        yeP1wKiN4iSapFMEix4LyhMY8y0djSKrdzWQRg133ko/zAsZUcf7mNhPsHFB5WTaMAn8rh
        vPaYQVSY6VVCjzSy4J0J1qGS7wHM0EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-910Cxq_WMlet_4ANTkp0DA-1; Fri, 28 Feb 2020 11:35:18 -0500
X-MC-Unique: 910Cxq_WMlet_4ANTkp0DA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 260361005513;
        Fri, 28 Feb 2020 16:35:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D98D90531;
        Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D93002257D8; Fri, 28 Feb 2020 11:35:10 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, david@fromorbit.com, jmoyer@redhat.com,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 6/6] dax,iomap: Add helper dax_iomap_zero() to zero a range
Date:   Fri, 28 Feb 2020 11:34:56 -0500
Message-Id: <20200228163456.1587-7-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper dax_ioamp_zero() to zero a range. This patch basically
merges __dax_zero_page_range() and iomap_dax_zero().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c               | 16 ++++++++--------
 fs/iomap/buffered-io.c |  9 +--------
 include/linux/dax.h    | 17 +++--------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 98ba3756163a..11b16729b86f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1038,10 +1038,10 @@ static vm_fault_t dax_load_hole(struct xa_state *=
xas,
 	return ret;
 }
=20
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int size)
+int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
+		   struct iomap *iomap)
 {
+	sector_t sector =3D iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
 	void *kaddr;
@@ -1052,16 +1052,17 @@ int __dax_zero_page_range(struct block_device *bd=
ev,
 	    IS_ALIGNED(size, PAGE_SIZE))
 		page_aligned =3D true;
=20
-	rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	rc =3D bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
=20
 	id =3D dax_read_lock();
=20
 	if (page_aligned)
-		rc =3D dax_zero_page_range(dax_dev, pgoff, size >> PAGE_SHIFT);
+		rc =3D dax_zero_page_range(iomap->dax_dev, pgoff,
+					 size >> PAGE_SHIFT);
 	else
-		rc =3D dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+		rc =3D dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1069,12 +1070,11 @@ int __dax_zero_page_range(struct block_device *bd=
ev,
=20
 	if (!page_aligned) {
 		memset(kaddr + offset, 0, size);
-		dax_flush(dax_dev, kaddr + offset, size);
+		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
 	dax_read_unlock(id);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__dax_zero_page_range);
=20
 static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *da=
ta,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7c84c4c027c4..6f750da545e5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -974,13 +974,6 @@ static int iomap_zero(struct inode *inode, loff_t po=
s, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
=20
-static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
-		struct iomap *iomap)
-{
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
-}
-
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
@@ -1000,7 +993,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t p=
os, loff_t count,
 		bytes =3D min_t(loff_t, PAGE_SIZE - offset, count);
=20
 		if (IS_DAX(inode))
-			status =3D iomap_dax_zero(pos, offset, bytes, iomap);
+			status =3D dax_iomap_zero(pos, offset, bytes, iomap);
 		else
 			status =3D iomap_zero(inode, pos, offset, bytes, iomap,
 					srcmap);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 71735c430c05..d7af5d243f24 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -13,6 +13,7 @@
 typedef unsigned long dax_entry_t;
=20
 struct iomap_ops;
+struct iomap;
 struct dax_device;
 struct dax_operations {
 	/*
@@ -214,20 +215,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vm=
f,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t inde=
x);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-
-#ifdef CONFIG_FS_DAX
-int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length);
-#else
-static inline int __dax_zero_page_range(struct block_device *bdev,
-		struct dax_device *dax_dev, sector_t sector,
-		unsigned int offset, unsigned int length)
-{
-	return -ENXIO;
-}
-#endif
-
+int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
+			struct iomap *iomap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
--=20
2.20.1

