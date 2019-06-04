Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A686234955
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfFDNt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40220 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Eo4Cxu7NKFDGjIub56vp6QM3AHeuBOBBdfoulOsHW1c=; b=EeZVZNxt2pUyZYaa7fJfrakjUp
        ry1kRCrGkj3dgvNZsYXa21yLtYMB6Bd/HjDZNCq6JZWaAE1GashWOSBnT6IURLnBfEdnqtzoWhRO8
        baZGhRdtq4UK+VWLkO+IARV5MH0vias74DmzBWvmnoa1EnhdzQtQJqTUhjwwNCfRUHB6IT9rgf7Vf
        Gg6SToVIAbKquc0KKRshipWGmC6Lbs43RI9L9h/MejCe4tkKrow/+HIVzQOsBvt9PXWTwhmb3OijS
        TprICtEnao8FBX15pV7P0Z51hRwI0ef7G0tppyCRorfd7O9tMwK9lJghor6dWb92+e/OMmAQ3OmFq
        3ky+sZTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34816 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9oc-0001at-CW; Tue, 04 Jun 2019 14:49:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9ob-00084H-Bg; Tue, 04 Jun 2019 14:49:25 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] fs/adfs: correct disc record structure
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9ob-00084H-Bg@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:25 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in some padding in the disc record structure, and add GCC
packed and aligned attributes to ensure that it is correctly
laid out.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 include/uapi/linux/adfs_fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/adfs_fs.h b/include/uapi/linux/adfs_fs.h
index 151d93e27ed4..f1a7d67a7323 100644
--- a/include/uapi/linux/adfs_fs.h
+++ b/include/uapi/linux/adfs_fs.h
@@ -29,17 +29,17 @@ struct adfs_discrecord {
     __u8  log2sharesize:4;
     __u8  unused40:4;
     __u8  big_flag:1;
-    __u8  unused41:1;
+    __u8  unused41:7;
     __u8  nzones_high;
+    __u8  reserved43;
     __le32 format_version;
     __le32 root_size;
     __u8  unused52[60 - 52];
-};
+} __attribute__((packed, aligned(4)));
 
 #define ADFS_DISCRECORD		(0xc00)
 #define ADFS_DR_OFFSET		(0x1c0)
 #define ADFS_DR_SIZE		 60
 #define ADFS_DR_SIZE_BITS	(ADFS_DR_SIZE << 3)
 
-
 #endif /* _UAPI_ADFS_FS_H */
-- 
2.7.4

