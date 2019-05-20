Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915CA23999
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfETONd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47730 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732973AbfETONc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4n7Cf6NHMWiVCvI97eZlAHY7ayqB8NCcmYksoFDkGwI=; b=am7mPRxfyIcZdiTWeorFz1OyML
        ul9KcMauZrgNVXT1ZcOGoAcJlXh9C2gSw70lKzlGCFnchJ/nsb7fmD5Bcy4ya+XXewMApG9omd0j0
        QH3yJzqVSbVREV3RCukMAU2AY/sF9bxJE/9vRsu2Ty0xvFcamwoVzoaXGrazjekgEuJTB5LDwa4nB
        XUCLjkOmLg3ehZvVP203ml0MYLdPpItxQGMn4lA/L/ftj8m7hQABX9ZbvdRW4uC48BcwLyQBQNT6B
        GgwRn2colSm3pmJrwMESuXYpPK3MYWoAUAPcqXWNfb2BawoN12vrAIws2duC/g2BJMHObxzHUlLkg
        rLj34B5Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33170 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2f-0003B7-PQ; Mon, 20 May 2019 15:13:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2f-0000Lz-71; Mon, 20 May 2019 15:13:29 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] fs/adfs: move append_filetype_suffix() into
 adfs_object_fixup()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2f-0000Lz-71@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:29 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

append_filetype_suffix() is now only used in adfs_object_fixup(), so
move it there.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h | 13 -------------
 fs/adfs/dir.c  | 13 ++++++++-----
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 1097bee65fa9..804c6a77c5db 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -113,19 +113,6 @@ struct object_info {
 	__u16		filetype;
 };
 
-/* RISC OS 12-bit filetype converts to ,xyz hex filename suffix */
-static inline int append_filetype_suffix(char *buf, __u16 filetype)
-{
-	if (filetype == 0xffff)	/* no explicit 12-bit file type was set */
-		return 0;
-
-	*buf++ = ',';
-	*buf++ = hex_asc_lo(filetype >> 8);
-	*buf++ = hex_asc_lo(filetype >> 4);
-	*buf++ = hex_asc_lo(filetype >> 0);
-	return 4;
-}
-
 struct adfs_dir_ops {
 	int	(*read)(struct super_block *sb, unsigned int id, unsigned int sz, struct adfs_dir *dir);
 	int	(*setpos)(struct adfs_dir *dir, unsigned int fpos);
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 5d88108339df..51ed80ff10a5 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -42,11 +42,14 @@ void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 		obj->filetype = (__u16) ((0x000fff00 & obj->loadaddr) >> 8);
 
 		/* optionally append the ,xyz hex filetype suffix */
-		if (ADFS_SB(dir->sb)->s_ftsuffix)
-			obj->name_len +=
-				append_filetype_suffix(
-					&obj->name[obj->name_len],
-					obj->filetype);
+		if (ADFS_SB(dir->sb)->s_ftsuffix) {
+			__u16 filetype = obj->filetype;
+
+			obj->name[obj->name_len++] = ',';
+			obj->name[obj->name_len++] = hex_asc_lo(filetype >> 8);
+			obj->name[obj->name_len++] = hex_asc_lo(filetype >> 4);
+			obj->name[obj->name_len++] = hex_asc_lo(filetype >> 0);
+		}
 	}
 }
 
-- 
2.7.4

