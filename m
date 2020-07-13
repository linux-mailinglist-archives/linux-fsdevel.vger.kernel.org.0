Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6513E21A35D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGIPSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgGIPST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84048C08C5DC;
        Thu,  9 Jul 2020 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=x1dPU4y5+oIPdLnTVoNGnpiKxmsvGEiS+3fcih4adcs=; b=r9EZLh4LXCHoDbJ9eLr0xpc5LG
        gkY3J254j+Tljd7WMnkXTL+vJvTH4nFvceNeMCc0YK++DoYc0qFHoKOQqyEmJZCvbQmkxIyqfQkro
        ZIIrjGuCBtWoefbTzayhMDHLCe6lBmJeCIY4mle5CTwI0uOG9wzqQgWEm2+YEV0/Vml1++rRoxwyL
        9s2sCCNj2y4Xjn43Im909vSxZKrHTKsu/V834TBF9tTmQAYxXO7Gdc9CHlcaUEVI8+j8P9PtNRqmF
        tDBukhYZS+3ezBzzm14xjOduOxk2ym4eKNLNL5qT2w4NELGvfeVO4Kkt5KGtEeXStsf3lw9cGvj39
        vt0CV3cQ==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJV-0005Jw-JZ; Thu, 09 Jul 2020 15:18:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/17] init: remove the bstat helper
Date:   Thu,  9 Jul 2020 17:17:58 +0200
Message-Id: <20200709151814.110422-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only caller of the bstat function becomes cleaner and simpler when
open coding the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.h    | 10 ----------
 init/do_mounts_md.c |  8 ++++----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 0bb0806de4ce2c..7513d1c14d13fe 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -20,16 +20,6 @@ static inline int create_dev(char *name, dev_t dev)
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
-static inline u32 bstat(char *name)
-{
-	struct kstat stat;
-	if (vfs_stat(name, &stat) != 0)
-		return 0;
-	if (!S_ISBLK(stat.mode))
-		return 0;
-	return stat.rdev;
-}
-
 #ifdef CONFIG_BLK_DEV_RAM
 
 int __init rd_load_disk(int n);
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index b84031528dd446..359363e85ccd0b 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -138,9 +138,9 @@ static void __init md_setup_drive(void)
 			dev = MKDEV(MD_MAJOR, minor);
 		create_dev(name, dev);
 		for (i = 0; i < MD_SB_DISKS && devname != NULL; i++) {
+			struct kstat stat;
 			char *p;
 			char comp_name[64];
-			u32 rdev;
 
 			p = strchr(devname, ',');
 			if (p)
@@ -150,9 +150,9 @@ static void __init md_setup_drive(void)
 			if (strncmp(devname, "/dev/", 5) == 0)
 				devname += 5;
 			snprintf(comp_name, 63, "/dev/%s", devname);
-			rdev = bstat(comp_name);
-			if (rdev)
-				dev = new_decode_dev(rdev);
+			if (vfs_stat(comp_name, &stat) == 0 &&
+			    S_ISBLK(stat.mode))
+				dev = new_decode_dev(stat.rdev);
 			if (!dev) {
 				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
 				break;
-- 
2.26.2

