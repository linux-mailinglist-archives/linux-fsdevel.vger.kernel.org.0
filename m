Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6101334956
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfFDNte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40226 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfFDNte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8qV22UV5t6M1PJzPlSI7KZGYvDaLa0P8xyN8BS5Hlto=; b=kk6dknMugjv2oH45To8DVcyFrY
        0I3D4TM10IWwOXoYxU+AHJvZXu4CUdv1iJrIw+xJicg7oB5Ym1QtG57d+Qn1aLpInJy9bFKofL39W
        4kq6abOfjH2iFzLnEMfjltDGgiQ8KeYy1lQz+69+rX6ZhVhe3UUbjV4+PquDeg7uhRa9wQDvgU3qZ
        0xJtsuoKTGSD0N899CcRhzari9vuZ6C/iZx8uuWWZI4H2AigVLGLk05TFBcj3KuuUioTpzeG9LM4y
        +BlxEHu0E+LywprHZPXN/ec4yC7DtqOdzaToJYejUi0U/Pfs+AdD1TNq2q0GTqREz8aPKSXa8bi60
        hdW5mzNA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:34304 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9oh-0001b0-Mg; Tue, 04 Jun 2019 14:49:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9og-00084O-S2; Tue, 04 Jun 2019 14:49:31 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] fs/adfs: add helper to get discrecord from map
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9og-00084O-S2@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:30 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to get the disc record from the map, rather than open
coding this in adfs_fill_super().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      | 10 ++++++++--
 fs/adfs/dir_f.c     |  1 -
 fs/adfs/dir_fplus.c |  1 -
 fs/adfs/map.c       |  1 -
 fs/adfs/super.c     |  3 +--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 804c6a77c5db..5a72a0ea03bd 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 
@@ -18,8 +19,6 @@
 
 #include "dir_f.h"
 
-struct buffer_head;
-
 /*
  * adfs file system inode data in memory
  */
@@ -195,3 +194,10 @@ __adfs_block_map(struct super_block *sb, unsigned int object_id,
 
 	return adfs_map_lookup(sb, object_id >> 8, block);
 }
+
+/* Return the disc record from the map */
+static inline
+struct adfs_discrecord *adfs_map_discrecord(struct adfs_discmap *dm)
+{
+	return (void *)(dm[0].dm_bh->b_data + 4);
+}
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 033884541a63..811f36aaa700 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -9,7 +9,6 @@
  *
  *  E and F format directory handling
  */
-#include <linux/buffer_head.h>
 #include "adfs.h"
 #include "dir_f.h"
 
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 97b9f28f459b..12ab34dad815 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include "adfs.h"
 #include "dir_fplus.h"
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 6935f05202ac..5f2d9d775305 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/buffer_head.h>
 #include <asm/unaligned.h>
 #include "adfs.h"
 
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 7e099a7a4eb1..75000165f4d1 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -9,7 +9,6 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/buffer_head.h>
 #include <linux/parser.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
@@ -469,7 +468,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	sb->s_op = &adfs_sops;
 
-	dr = (struct adfs_discrecord *)(asb->s_map[0].dm_bh->b_data + 4);
+	dr = adfs_map_discrecord(asb->s_map);
 
 	root_obj.parent_id = root_obj.file_id = le32_to_cpu(dr->root);
 	root_obj.name_len  = 0;
-- 
2.7.4

