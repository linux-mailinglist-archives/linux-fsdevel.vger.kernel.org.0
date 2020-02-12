Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD16115AE22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgBLRIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:08:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728898AbgBLRIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFXOBK5kg+//3C1Cq5RJK/z4kqT5swnlhwxFrx47y84=;
        b=FJ4m4E/SZjFryxTLVMQJw308h/yI5Iwp7BxpaHDX7Kx2qE+zdcyUUyesQMjieSu3ITpSmU
        Nz7pSerQcfCV64fFDvmU3RMnQX84KEtHnHNcb+ZnqTB8yCOXiKngvE/cdvxJa2kKKg/1wz
        2NbmK3tk8ymOB2Tzbc+nmUTNJjiUS0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-mUGUErWkMiihwvXwGDO0Wg-1; Wed, 12 Feb 2020 12:07:54 -0500
X-MC-Unique: mUGUErWkMiihwvXwGDO0Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8EF5107ACCA;
        Wed, 12 Feb 2020 17:07:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 200F15D9E2;
        Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CAEF32257D8; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [PATCH 6/6] dax: Remove bdev_dax_pgoff() helper
Date:   Wed, 12 Feb 2020 12:07:33 -0500
Message-Id: <20200212170733.8092-7-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now there don't seem to be anyuser of bdev_dax_pgoff(). All users have be=
en
moved to dax_pgoff(). So remove this helper.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 13 -------------
 include/linux/dax.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index ee35ecc61545..371e391e6b1e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -43,19 +43,6 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
=20
-int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t si=
ze,
-		pgoff_t *pgoff)
-{
-	phys_addr_t phys_off =3D (get_start_sect(bdev) + sector) * 512;
-
-	if (pgoff)
-		*pgoff =3D PHYS_PFN(phys_off);
-	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
-		return -EINVAL;
-	return 0;
-}
-EXPORT_SYMBOL(bdev_dax_pgoff);
-
 int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t=
 *pgoff)
 {
 	phys_addr_t phys_off =3D (dax_offset + sector) * 512;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 5101a4b5c1f9..84ed0e993190 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -110,7 +110,6 @@ static inline bool daxdev_mapping_supported(struct vm=
_area_struct *vma,
 #endif
=20
 struct writeback_control;
-int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgo=
ff);
 int dax_pgoff(sector_t dax_offset, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize);
--=20
2.20.1

