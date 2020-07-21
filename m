Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EF2285AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgGUQaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgGUQ2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0EC061794;
        Tue, 21 Jul 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H1k4IbX7Cdi4TcmpDofJ7UHs3moalFNWToOeNyCFxRc=; b=Hqg/HT2fLvykoBAK6Jckh9zCh0
        kAvY2WP4BU2YvrNihBf5BR4v6TogXgs9MamN09n1TRW6z/u+8QnRlrdbKVupDFTpjMyN0e73g7OqG
        y5CtkLmCvTSF37J3uoLyZcFv3GbkeFoJMkq8aT2TJluI8tjn9y0SU/KkRiOuoyq0dauk4uvXW4x6z
        T/Tzv7ElW+nG4rQ2t/8dlUb+iFu0jWRdcwr/p3g+7utavEkMxRHOhTnNUP+6IDAMbvOoBGAP5obmM
        tbFbFeNpNziJ8ZwzoaeYzLhsAGv4YqKMGqnSblpMYIKgHWVnqfDPft7p3AVpGOBpvZASBRXG2IzRJ
        Rc3nrspw==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv7z-0007S7-8C; Tue, 21 Jul 2020 16:28:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 06/24] md: open code vfs_stat in md_setup_drive
Date:   Tue, 21 Jul 2020 18:28:00 +0200
Message-Id: <20200721162818.197315-7-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of passing a kernel pointer to vfs_stat by relying on the
implicit set_fs(KERNEL_DS) in md_setup_drive, just open code the
trivial getattr, and use the opportunity to move a little bit more
code from the caller into the new helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-autodetect.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 14b6e86814c061..1e8f1df257a112 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -8,6 +8,7 @@
 #include <linux/raid/detect.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
+#include <linux/namei.h>
 #include "md.h"
 
 /*
@@ -119,6 +120,23 @@ static int __init md_setup(char *str)
 	return 1;
 }
 
+static void __init md_lookup_dev(const char *devname, dev_t *dev)
+{
+	struct kstat stat;
+	struct path path;
+	char filename[64];
+
+	if (strncmp(devname, "/dev/", 5) == 0)
+		devname += 5;
+	snprintf(filename, 63, "/dev/%s", devname);
+
+	if (!kern_path(filename, LOOKUP_FOLLOW, &path) &&
+	    !vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_NO_AUTOMOUNT) &&
+	    S_ISBLK(stat.mode))
+		*dev = new_decode_dev(stat.rdev);
+	path_put(&path);
+}
+
 static void __init md_setup_drive(struct md_setup_args *args)
 {
 	char *devname = args->device_names;
@@ -138,21 +156,14 @@ static void __init md_setup_drive(struct md_setup_args *args)
 	}
 
 	for (i = 0; i < MD_SB_DISKS && devname != NULL; i++) {
-		struct kstat stat;
-		char *p;
-		char comp_name[64];
 		dev_t dev;
+		char *p;
 
 		p = strchr(devname, ',');
 		if (p)
 			*p++ = 0;
-
 		dev = name_to_dev_t(devname);
-		if (strncmp(devname, "/dev/", 5) == 0)
-			devname += 5;
-		snprintf(comp_name, 63, "/dev/%s", devname);
-		if (vfs_stat(comp_name, &stat) == 0 && S_ISBLK(stat.mode))
-			dev = new_decode_dev(stat.rdev);
+		md_lookup_dev(devname, &dev);
 		if (!dev) {
 			pr_warn("md: Unknown device name: %s\n", devname);
 			break;
-- 
2.27.0

