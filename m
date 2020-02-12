Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A315AE1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgBLRHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:07:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728814AbgBLRHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAHXFz29ZqKfWinL/vfbLZE3eUCyI3Z/8yBsq8fYK5M=;
        b=DkoFj9CeEik95tkPwBYPnqs8A7Hj1pU53lwie4lmn/AgStuvQiTdoRwZW1xsr7RCBqYnMF
        L8zC5vRWUiSTXliYkhz12SV/zOO6+8mvgCw/1mGilJdtunoSJsR7tCuEUatwvfWgEIArSu
        etABeRr98hInQYd6J8z6g+hhJPX2UhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-3iXqSZYVPRmtc7AyYUbG7Q-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: 3iXqSZYVPRmtc7AyYUbG7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB896DBA3;
        Wed, 12 Feb 2020 17:07:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F8F5C1B2;
        Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B766D2257D5; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [PATCH 3/6] fs/dax.c: Start using dax_pgoff() instead of bdev_dax_pgoff()
Date:   Wed, 12 Feb 2020 12:07:30 -0500
Message-Id: <20200212170733.8092-4-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace usage of bdev_dax_pgoff() with dax_pgoff() in fs/dax.c

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..921042a81538 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -680,7 +680,7 @@ int dax_invalidate_mapping_entry_sync(struct address_=
space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
=20
-static int copy_user_dax(struct block_device *bdev, struct dax_device *d=
ax_dev,
+static int copy_user_dax(struct dax_device *dax_dev, sector_t dax_offset=
,
 		sector_t sector, size_t size, struct page *to,
 		unsigned long vaddr)
 {
@@ -689,7 +689,7 @@ static int copy_user_dax(struct block_device *bdev, s=
truct dax_device *dax_dev,
 	long rc;
 	int id;
=20
-	rc =3D bdev_dax_pgoff(bdev, sector, size, &pgoff);
+	rc =3D dax_pgoff(dax_offset, sector, size, &pgoff);
 	if (rc)
 		return rc;
=20
@@ -990,7 +990,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t =
pos, size_t size,
 	int id, rc;
 	long length;
=20
-	rc =3D bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
+	rc =3D dax_pgoff(iomap->dax_offset, sector, size, &pgoff);
 	if (rc)
 		return rc;
 	id =3D dax_read_lock();
@@ -1065,7 +1065,7 @@ int __dax_zero_page_range(struct block_device *bdev=
,
 		long rc, id;
 		void *kaddr;
=20
-		rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+		rc =3D dax_pgoff(get_start_sect(bdev), sector, PAGE_SIZE, &pgoff);
 		if (rc)
 			return rc;
=20
@@ -1087,7 +1087,6 @@ static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *da=
ta,
 		struct iomap *iomap, struct iomap *srcmap)
 {
-	struct block_device *bdev =3D iomap->bdev;
 	struct dax_device *dax_dev =3D iomap->dax_dev;
 	struct iov_iter *iter =3D data;
 	loff_t end =3D pos + length, done =3D 0;
@@ -1132,7 +1131,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, lo=
ff_t length, void *data,
 			break;
 		}
=20
-		ret =3D bdev_dax_pgoff(bdev, sector, size, &pgoff);
+		ret =3D dax_pgoff(iomap->dax_offset, sector, size, &pgoff);
 		if (ret)
 			break;
=20
@@ -1312,7 +1311,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fau=
lt *vmf, pfn_t *pfnp,
 			clear_user_highpage(vmf->cow_page, vaddr);
 			break;
 		case IOMAP_MAPPED:
-			error =3D copy_user_dax(iomap.bdev, iomap.dax_dev,
+			error =3D copy_user_dax(iomap.dax_dev, iomap.dax_offset,
 					sector, PAGE_SIZE, vmf->cow_page, vaddr);
 			break;
 		default:
--=20
2.20.1

