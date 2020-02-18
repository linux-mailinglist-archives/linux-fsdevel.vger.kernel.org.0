Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FD163561
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBRVtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:49:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbgBRVtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582062545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3A/bE5M304IMLJrwnJ9LyWGdI9w9dAyP1ptcoHPK04=;
        b=SG/l3cnr9hH/o5yzaDZ1mlj8a9/aS04lKijkMpFs5ziwOUq+R3KIA8fR3/u+5Gl2gVq/UO
        1eCBLhz/K4pY2UcZsVI0pC1GOy21mUYJEI5QHVxbUG9Ep9tPeQzlFVYWuwwrNz4AkcpZrI
        grdOoLDB/86YPuI7FWkGSj7vVOXNvWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-lKwINEcDMf6UbT6OcDik8A-1; Tue, 18 Feb 2020 16:49:00 -0500
X-MC-Unique: lKwINEcDMf6UbT6OcDik8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C437101FC60;
        Tue, 18 Feb 2020 21:48:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A09E19756;
        Tue, 18 Feb 2020 21:48:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C717F2257DA; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 8/8] dax,iomap: Add helper dax_iomap_zero() to zero a range
Date:   Tue, 18 Feb 2020 16:48:41 -0500
Message-Id: <20200218214841.10076-9-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 fs/dax.c               | 12 ++++++------
 fs/iomap/buffered-io.c |  9 +--------
 include/linux/dax.h    | 17 +++--------------
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f8ae0a9984fa..4be581009db5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1038,23 +1038,23 @@ static vm_fault_t dax_load_hole(struct xa_state *=
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
 	pgoff_t pgoff;
 	long rc, id;
+	sector_t sector =3D iomap_sector(iomap, pos & PAGE_MASK);
=20
-	rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	rc =3D bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
=20
 	id =3D dax_read_lock();
-	rc =3D dax_zero_page_range(dax_dev, (pgoff << PAGE_SHIFT) + offset, siz=
e);
+	rc =3D dax_zero_page_range(iomap->dax_dev, (pgoff << PAGE_SHIFT) + offs=
et,
+				 size);
 	dax_read_unlock(id);
 	return rc;
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
index 93a663c26d6a..7b681acfc522 100644
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
@@ -213,20 +214,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vm=
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

