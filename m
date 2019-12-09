Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6E116C04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLILLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:17 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60206 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfLILLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pfTWHo80db8C8jZVLr2XdPVXqjbTeypJOK8+VLH2vgc=; b=e2gIhr0EeRuzge7ZBxon4jF8/f
        WRKjrtqp9zyPYku+GnwzzbyMhhxT+2PeXNMWGvYsnhOkIENnvuiRRSdV3lRR6g8GzRMfUrLXyPgW/
        osPTh8eyX0LBt0pFJHB8JhRzq5KzeEyWTdzd/LIzQGu5fxYwPut3HxrIQQ3M0SdDrCGPGH/bN9VtF
        8nxhoDmatnHSJWIfovExR8mexdA9+UnxMl+OqQx6cdpdmQtWacasfqk2FmB+2n2pA//4T/HNPjqCV
        M7Hz0QTgPmZyTGzA4RZ1tlZricrFwCWR21VEWIiUUqccGP6fx0H5zIaJZQV4b+wVP0C3eC+AtOCgS
        GJ9JEkeQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54110 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwb-0002XZ-OC; Mon, 09 Dec 2019 11:11:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwb-0004dq-6L; Mon, 09 Dec 2019 11:11:13 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 35/41] fs/adfs: bigdir: implement directory update support
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwb-0004dq-6L@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:13 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement big directory entry update support in the same way that we
do for new directories.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_fplus.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4ab8987962f0..48ea299b6ece 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -120,7 +120,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 	}
 
 	dirsize = le32_to_cpu(h->bigdirsize);
-	if (dirsize != size) {
+	if (size && dirsize != size) {
 		adfs_msg(sb, KERN_WARNING,
 			 "dir %06x header size %X does not match directory size %X",
 			 indaddr, dirsize, size);
@@ -226,9 +226,61 @@ static int adfs_fplus_iterate(struct adfs_dir *dir, struct dir_context *ctx)
 	return 0;
 }
 
+static int adfs_fplus_update(struct adfs_dir *dir, struct object_info *obj)
+{
+	struct adfs_bigdirheader *h = dir->bighead;
+	struct adfs_bigdirentry bde;
+	int offset, end, ret;
+
+	offset = adfs_fplus_offset(h, 0) - sizeof(bde);
+	end = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
+
+	do {
+		offset += sizeof(bde);
+		if (offset >= end) {
+			adfs_error(dir->sb, "unable to locate entry to update");
+			return -ENOENT;
+		}
+		ret = adfs_dir_copyfrom(&bde, dir, offset, sizeof(bde));
+		if (ret) {
+			adfs_error(dir->sb, "error reading directory entry");
+			return -ENOENT;
+		}
+	} while (le32_to_cpu(bde.bigdirindaddr) != obj->indaddr);
+
+	bde.bigdirload    = cpu_to_le32(obj->loadaddr);
+	bde.bigdirexec    = cpu_to_le32(obj->execaddr);
+	bde.bigdirlen     = cpu_to_le32(obj->size);
+	bde.bigdirindaddr = cpu_to_le32(obj->indaddr);
+	bde.bigdirattr    = cpu_to_le32(obj->attr);
+
+	return adfs_dir_copyto(dir, offset, &bde, sizeof(bde));
+}
+
+static int adfs_fplus_commit(struct adfs_dir *dir)
+{
+	int ret;
+
+	/* Increment directory sequence number */
+	dir->bighead->startmasseq += 1;
+	dir->bigtail->bigdirendmasseq += 1;
+
+	/* Update directory check byte */
+	dir->bigtail->bigdircheckbyte = adfs_fplus_checkbyte(dir);
+
+	/* Make sure the directory still validates correctly */
+	ret = adfs_fplus_validate_header(dir->bighead);
+	if (ret == 0)
+		ret = adfs_fplus_validate_tail(dir->bighead, dir->bigtail);
+
+	return ret;
+}
+
 const struct adfs_dir_ops adfs_fplus_dir_ops = {
 	.read		= adfs_fplus_read,
 	.iterate	= adfs_fplus_iterate,
 	.setpos		= adfs_fplus_setpos,
 	.getnext	= adfs_fplus_getnext,
+	.update		= adfs_fplus_update,
+	.commit		= adfs_fplus_commit,
 };
-- 
2.20.1

