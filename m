Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE170A4B89
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfIAUIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:08:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbfIAUIt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:08:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2210B07B;
        Sun,  1 Sep 2019 20:08:48 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/15] iomap: Introduce CONFIG_FS_IOMAP_DEBUG
Date:   Sun,  1 Sep 2019 15:08:22 -0500
Message-Id: <20190901200836.14959-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901200836.14959-1-rgoldwyn@suse.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

To improve debugging abilities, especially invalid option
asserts.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/Kconfig            |  3 +++
 include/linux/iomap.h | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..4bed5df9b55f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -19,6 +19,9 @@ if BLOCK
 
 config FS_IOMAP
 	bool
+config FS_IOMAP_DEBUG
+	bool "Debugging for the iomap code"
+	depends on FS_IOMAP
 
 source "fs/ext2/Kconfig"
 source "fs/ext4/Kconfig"
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..209b6c93674e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -18,6 +18,17 @@ struct page;
 struct vm_area_struct;
 struct vm_fault;
 
+#ifdef CONFIG_FS_IOMAP_DEBUG
+#define iomap_assert(expr) \
+	if(!(expr)) { \
+		printk( "Assertion failed! %s,%s,%s,line=%d\n",\
+#expr,__FILE__,__func__,__LINE__); \
+		BUG(); \
+	}
+#else
+#define iomap_assert(expr)
+#endif
+
 /*
  * Types of block ranges for iomap mappings:
  */
-- 
2.16.4

