Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B979155F91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 21:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGU1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 15:27:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22367 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727114AbgBGU1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581107232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRFXE7puySntB2ELG7GLw8rNfKMNE1YHxPkTRCp2eg4=;
        b=do/KRMI5XAZO/Tay2hkI+ySXbt7wUX0qI26xF3PZOKt5eZDEgCaX9elvirPiFLmLo5BJF0
        pwgA/fRBhAsjSIZWz8GHL1oTexhijE6RllIhuHITWTkQgAwHWUO2zs8ZfJfLgrSxdxZ5CK
        GGjwTBCf1TPSYFgTxcR+kGDiw5C9I1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-_XqowsZpP6C-Qv1eiDMicw-1; Fri, 07 Feb 2020 15:27:07 -0500
X-MC-Unique: _XqowsZpP6C-Qv1eiDMicw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CBDC8010EF;
        Fri,  7 Feb 2020 20:27:06 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A196100164D;
        Fri,  7 Feb 2020 20:27:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A5C232257D8; Fri,  7 Feb 2020 15:27:02 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, vishal.l.verma@intel.com, vgoyal@redhat.com
Subject: [PATCH v3 6/7] dax,iomap: Start using dax native zero_page_range()
Date:   Fri,  7 Feb 2020 15:26:51 -0500
Message-Id: <20200207202652.1439-7-vgoyal@redhat.com>
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of calling block device interface for zeroing in iomap dax
zeroing path and use dax native zeroing interface instead.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 45 +++++++++------------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..6757e12b86b2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1044,48 +1044,21 @@ static vm_fault_t dax_load_hole(struct xa_state *=
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
-
-		return blkdev_issue_zeroout(bdev, start_sector,
-				size >> 9, GFP_NOFS, 0);
-	} else {
-		pgoff_t pgoff;
-		long rc, id;
-		void *kaddr;
+	pgoff_t pgoff;
+	long rc, id;
=20
-		rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
-		if (rc)
-			return rc;
+	rc =3D bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	if (rc)
+		return rc;
=20
-		id =3D dax_read_lock();
-		rc =3D dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
-		if (rc < 0) {
-			dax_read_unlock(id);
-			return rc;
-		}
-		memset(kaddr + offset, 0, size);
-		dax_flush(dax_dev, kaddr + offset, size);
-		dax_read_unlock(id);
-	}
-	return 0;
+	id =3D dax_read_lock();
+	rc =3D dax_zero_page_range(dax_dev, (pgoff << PAGE_SHIFT) + offset, siz=
e);
+	dax_read_unlock(id);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
=20
--=20
2.20.1

