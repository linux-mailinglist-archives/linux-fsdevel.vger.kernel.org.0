Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7716D173D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1QfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:35:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgB1QfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582907719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uF73TsNF//51mQf3fGKRZkcAMlRdpaY4fScPXJg7B4Y=;
        b=G1PQ94xnEjYp3S82IMLC07I7H1k3sY24H+FOtun6RaSbKI0PJxIcPArdG/ZfC2au+XjaOd
        anNUvFGwsIGcIzBdcy2JQPfiv6ukPzwJ10BlrTNHz1Xpcjo/8LNcne9lmmW2t8XOMd9pqv
        JyDd9fIYFeq/MJo90uohNF+k6EhWOjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-euXnVwzsMjmjcQORKlk1sA-1; Fri, 28 Feb 2020 11:35:15 -0500
X-MC-Unique: euXnVwzsMjmjcQORKlk1sA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E4A08017CC;
        Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC5E90F5B;
        Fri, 28 Feb 2020 16:35:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D486E2257D7; Fri, 28 Feb 2020 11:35:10 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, david@fromorbit.com, jmoyer@redhat.com,
        dm-devel@redhat.com
Subject: [PATCH v6 5/6] dax: Use new dax zero page method for zeroing a page
Date:   Fri, 28 Feb 2020 11:34:55 -0500
Message-Id: <20200228163456.1587-6-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new dax native zero page method for zeroing page if I/O is page
aligned. Otherwise fall back to direct_access() + memcpy().

This gets rid of one of the depenendency on block device in dax path.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 53 +++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..98ba3756163a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1038,47 +1038,40 @@ static vm_fault_t dax_load_hole(struct xa_state *=
xas,
 	return ret;
 }
=20
-static bool dax_range_is_aligned(struct block_device *bdev,
-				 unsigned int offset, unsigned int length)
-{
-	unsigned short sector_size =3D bdev_logical_block_size(bdev);
-
-	if (!IS_ALIGNED(offset, sector_size))
-		return false;
-	if (!IS_ALIGNED(length, sector_size))
-		return false;
-
-	return true;
-}
-
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
-		sector_t start_sector =3D sector + (offset >> 9);
+	pgoff_t pgoff;
+	long rc, id;
+	void *kaddr;
+	bool page_aligned =3D false;
=20
-		return blkdev_issue_zeroout(bdev, start_sector,
-				size >> 9, GFP_NOFS, 0);
-	} else {
-		pgoff_t pgoff;
-		long rc, id;
-		void *kaddr;
=20
-		rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
-		if (rc)
-			return rc;
+	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
+	    IS_ALIGNED(size, PAGE_SIZE))
+		page_aligned =3D true;
+
+	rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	if (rc)
+		return rc;
=20
-		id =3D dax_read_lock();
+	id =3D dax_read_lock();
+
+	if (page_aligned)
+		rc =3D dax_zero_page_range(dax_dev, pgoff, size >> PAGE_SHIFT);
+	else
 		rc =3D dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
-		if (rc < 0) {
-			dax_read_unlock(id);
-			return rc;
-		}
+	if (rc < 0) {
+		dax_read_unlock(id);
+		return rc;
+	}
+
+	if (!page_aligned) {
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
-		dax_read_unlock(id);
 	}
+	dax_read_unlock(id);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
--=20
2.20.1

