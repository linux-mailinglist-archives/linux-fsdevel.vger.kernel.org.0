Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2A116BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfLILLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60184 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5KvYw86H8ov56Iw2bI9SEfpL4gdug7aRu06X5Br42h4=; b=LxwUJX5g63E7wK/STNqftvXICy
        +AhYPSbyecCuCMXnr0uFHNB2lbT6hfF85rP8JRslV82tRO15YVtan85RppsjEMVNDdRCqrWlxAmyx
        ehN6+/QpYIhaZwtSSDsT5y0YTOgWFt7uevIa16XQPTi5Em/KsGIevLc09IIX20qu7RemLECJOKxTD
        NRBs3av9wBnRVteeEw4QfkWYockQd9kMOI+eJD1tK4iScFk7lPryNp1weSgFyKQZ+QOiVWHgNbm8v
        CJwEeKsOZ6S62vXSvvfp6Zhasu0EtDgsfX8P2jrVkiDZXQFlbbIdDn06hGFAsLc1f7c8QsGfyeurP
        ktORyq8g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54102 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwM-0002X2-Av; Mon, 09 Dec 2019 11:10:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwL-0004dV-Qg; Mon, 09 Dec 2019 11:10:57 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/41] fs/adfs: bigdir: extract directory validation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwL-0004dV-Qg@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:57 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract the directory validation from the directory reading function as
we will want to re-use this code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_fplus.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 393921f5121e..b83a74e9ff6d 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -16,6 +16,30 @@ static unsigned int adfs_fplus_offset(const struct adfs_bigdirheader *h,
 	       pos * sizeof(struct adfs_bigdirentry);
 }
 
+static int adfs_fplus_validate_header(const struct adfs_bigdirheader *h)
+{
+	unsigned int size = le32_to_cpu(h->bigdirsize);
+
+	if (h->bigdirversion[0] != 0 || h->bigdirversion[1] != 0 ||
+	    h->bigdirversion[2] != 0 ||
+	    h->bigdirstartname != cpu_to_le32(BIGDIRSTARTNAME) ||
+	    size & 2047)
+		return -EIO;
+
+	return 0;
+}
+
+static int adfs_fplus_validate_tail(const struct adfs_bigdirheader *h,
+				    const struct adfs_bigdirtail *t)
+{
+	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
+	    t->bigdirendmasseq != h->startmasseq ||
+	    t->reserved[0] != 0 || t->reserved[1] != 0)
+		return -EIO;
+
+	return 0;
+}
+
 static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 			   unsigned int size, struct adfs_dir *dir)
 {
@@ -30,6 +54,11 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 		return ret;
 
 	dir->bighead = h = (void *)dir->bhs[0]->b_data;
+	if (adfs_fplus_validate_header(h)) {
+		adfs_error(sb, "dir %06x has malformed header", indaddr);
+		goto out;
+	}
+
 	dirsize = le32_to_cpu(h->bigdirsize);
 	if (dirsize != size) {
 		adfs_msg(sb, KERN_WARNING,
@@ -37,13 +66,6 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 			 indaddr, dirsize, size);
 	}
 
-	if (h->bigdirversion[0] != 0 || h->bigdirversion[1] != 0 ||
-	    h->bigdirversion[2] != 0 || size & 2047 ||
-	    h->bigdirstartname != cpu_to_le32(BIGDIRSTARTNAME)) {
-		adfs_error(sb, "dir %06x has malformed header", indaddr);
-		goto out;
-	}
-
 	/* Read remaining buffers */
 	ret = adfs_dir_read_buffers(sb, indaddr, dirsize, dir);
 	if (ret)
@@ -52,9 +74,8 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 	dir->bigtail = t = (struct adfs_bigdirtail *)
 		(dir->bhs[dir->nr_buffers - 1]->b_data + (sb->s_blocksize - 8));
 
-	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
-	    t->bigdirendmasseq != h->startmasseq ||
-	    t->reserved[0] != 0 || t->reserved[1] != 0) {
+	ret = adfs_fplus_validate_tail(h, t);
+	if (ret) {
 		adfs_error(sb, "dir %06x has malformed tail", indaddr);
 		goto out;
 	}
-- 
2.20.1

