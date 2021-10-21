Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A74436208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJUMrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJUMrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D3C061749
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LC7mRcFEYrQtFmIVnfiPrgBMPLuCs796AzRXNvRQVCk=; b=4sANb6B4HPdEWzSF690I7qe2PU
        Jo02Sb4Xcno0v2wXF6XqSgFRoH+l43ZY492oJPU0XKW6QrRiwG8TqtsqQW+YSyhnnkuD0Zf4U8+1q
        57XnTKACiv7WXb9ejHYoIsyLBGwZ//f++i+cEHDPZF243+p2au2kO9IFf50HDUNRAtv0YrgQ/r6+H
        YHvld8VcNphO6+OMG1FTF0nTNg9wTUftEFZMcbEs34z0k+C01FqyCPLcyrZDXpawa+jQxS+rQ7ROC
        /RgJ6kWcLvifQHNifULbHiE5C7wNgLKcrlLl9ZakzjCkk6YwpzVlt6PbhogsWgi1s66/FYQT9K3K2
        JMlcOp3Q==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXRG-007Wyx-5f; Thu, 21 Oct 2021 12:44:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 3/5] fs: explicitly unregister per-superblock BDIs
Date:   Thu, 21 Oct 2021 14:44:39 +0200
Message-Id: <20211021124441.668816-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021124441.668816-1-hch@lst.de>
References: <20211021124441.668816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new SB_I_ flag to mark superblocks that have an ephemeral bdi
associated with them, an unregister it when the superblock is shut down.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c         | 3 +++
 include/linux/fs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index bcef3a6f4c4b5..3bfc0f8fbd5bc 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -476,6 +476,8 @@ void generic_shutdown_super(struct super_block *sb)
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
 	if (sb->s_bdi != &noop_backing_dev_info) {
+		if (sb->s_iflags & SB_I_PERSB_BDI)
+			bdi_unregister(sb->s_bdi);
 		bdi_put(sb->s_bdi);
 		sb->s_bdi = &noop_backing_dev_info;
 	}
@@ -1562,6 +1564,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	}
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi;
+	sb->s_iflags |= SB_I_PERSB_BDI;
 
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd20..226de651f52e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1443,6 +1443,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
+#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
 
 /* Possible states of 'frozen' field */
 enum {
-- 
2.30.2

