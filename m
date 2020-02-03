Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328191510A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 21:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCUA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 15:00:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgBCUAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580760054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyVtqRVDcvVlwukpNKHGSmk30mQ+dKcCiPoRcs1gr90=;
        b=IZmmEtNpeV2tXnsnR4/KWOMBqAunpqNDi04H1rDmE9eUOBEpgUuKG+JVPPls0HcDxVEYwJ
        25gjkne3wiQ1YfVJfCxNT8ef91pg6mpttE17sQydtqZExlUp74oJQ2kZ5hLM0cxoI2ubKX
        JqQakEvSxOzUXKLNdQYQ6xcC1wexugk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-RWlL7u6rOOiWrXN9E9PGSA-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: RWlL7u6rOOiWrXN9E9PGSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED2713E6;
        Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 896915D9C5;
        Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1A78F22474F; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, vishal.l.verma@intel.com, dm-devel@redhat.com
Subject: [PATCH 4/5] dax,iomap: Start using dax native zero_page_range()
Date:   Mon,  3 Feb 2020 15:00:28 -0500
Message-Id: <20200203200029.4592-5-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 35631a4d0295..1b9ba6b59cdb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1044,19 +1044,6 @@ static vm_fault_t dax_load_hole(struct xa_state *x=
as,
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
 int generic_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgof=
f,
 				unsigned int offset, size_t len)
 {
@@ -1076,31 +1063,17 @@ int __dax_zero_page_range(struct block_device *bd=
ev,
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
+	rc =3D dax_zero_page_range(dax_dev, pgoff, offset, size);
+	dax_read_unlock(id);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
=20
--=20
2.18.1

