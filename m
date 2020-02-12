Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7B15AE21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgBLRIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:08:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728410AbgBLRH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QSDN4zqZX6JQThUAoXPpSXd0mGJ9FYDGlAgc1x+IyE=;
        b=BIeKNJE9IH21MlTFoU8IdIDKPcwHbeI0WbdzAR6xD2Vf7bcsWaUkM4t/nTX+M8ykSagalO
        wwF79z5PFVHeLR8CuBnZDAGyvPJtouL6cAZNNa+4ARyMhgfBeTbgJTQPN7XZBw+dIyJeRP
        uKOWXOf5rv0wNGekUchZ65qbLnyTXuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-k3JbxwhlOA2CwoxrbWTETw-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: k3JbxwhlOA2CwoxrbWTETw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B7008017CC;
        Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20668388;
        Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AEE932257D3; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in dax_offset as argument
Date:   Wed, 12 Feb 2020 12:07:28 -0500
Message-Id: <20200212170733.8092-2-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a new helper dax_pgoff() which will replace bdev_dax_pgoff(). Diff=
erence
between two is that dax_pgoff() takes in "sector_t dax_offset" as an argu=
ment
instead of "struct block_device".

dax_offset specifies any offset into dax device which should be added to
sector while calculating pgoff.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 12 ++++++++++++
 include/linux/dax.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0aa4b6bc5101..e9daa30e4250 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -56,6 +56,18 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t=
 sector, size_t size,
 }
 EXPORT_SYMBOL(bdev_dax_pgoff);
=20
+int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t=
 *pgoff)
+{
+	phys_addr_t phys_off =3D (dax_offset + sector) * 512;
+
+	if (pgoff)
+		*pgoff =3D PHYS_PFN(phys_off);
+	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(dax_pgoff);
+
 #if IS_ENABLED(CONFIG_FS_DAX)
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..5101a4b5c1f9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -111,6 +111,7 @@ static inline bool daxdev_mapping_supported(struct vm=
_area_struct *vma,
=20
 struct writeback_control;
 int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgo=
ff);
+int dax_pgoff(sector_t dax_offset, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
 static inline bool bdev_dax_supported(struct block_device *bdev, int blo=
cksize)
--=20
2.20.1

