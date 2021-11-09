Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29AE44A86E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbhKIIgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhKIIgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CBBC061764;
        Tue,  9 Nov 2021 00:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/UOhk+aCjmw4IcKFQxJFjUhaacfvQMsVGHtw6Oh0pgU=; b=rdR1iIJUysmE8nRJhVw9bNqNcp
        8echW5oA/94avlJbwg/FA9CdiX+4EB8Uscv9tIdbDEZPSzHUThgHJr/VpORs7fHOLVLmbHm6FSnCa
        c3p/0Zwb54leaozWprP8d+hr4t/bdbofDGxBNHnWcwDsiNHBK9RcdMfr1C2NIWBAUUKVlg4d4xG0q
        C/5EaO5wXfo4kT/HsbD82Gju/ex+0pI9PnUZVuRzsDnTqPqkyx5F5yZMJ3ULme8b0+IcHCSeBcVzA
        2Ix9scM8foqKqTHFSUXzLvvhTp+JKBiBJkvU/icgDP2UGaG4sBE31/3zDeOGp9n6KHXlBemoMny1o
        X75Qcpug==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZD-000ryI-IK; Tue, 09 Nov 2021 08:33:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
Date:   Tue,  9 Nov 2021 09:32:43 +0100
Message-Id: <20211109083309.584081-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/Kconfig        | 4 ----
 drivers/nvdimm/Kconfig     | 2 +-
 drivers/s390/block/Kconfig | 2 +-
 fs/fuse/Kconfig            | 2 +-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d2834c2cfa10d..954ab14ba7778 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config DAX_DRIVER
-	select DAX
-	bool
-
 menuconfig DAX
 	tristate "DAX: direct access to differentiated memory"
 	select SRCU
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index b7d1eb38b27d4..347fe7afa5830 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -22,7 +22,7 @@ if LIBNVDIMM
 config BLK_DEV_PMEM
 	tristate "PMEM: Persistent memory block device support"
 	default LIBNVDIMM
-	select DAX_DRIVER
+	select DAX
 	select ND_BTT if BTT
 	select ND_PFN if NVDIMM_PFN
 	help
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index d0416dbd0cd81..e3710a762abae 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -5,7 +5,7 @@ comment "S/390 block device drivers"
 config DCSSBLK
 	def_tristate m
 	select FS_DAX_LIMITED
-	select DAX_DRIVER
+	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 40ce9a1c12e5d..038ed0b9aaa5d 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -45,7 +45,7 @@ config FUSE_DAX
 	select INTERVAL_TREE
 	depends on VIRTIO_FS
 	depends on FS_DAX
-	depends on DAX_DRIVER
+	depends on DAX
 	help
 	  This allows bypassing guest page cache and allows mapping host page
 	  cache directly in guest address space.
-- 
2.30.2

