Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343FF1F9752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgFOMzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgFOMxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D5C061A0E;
        Mon, 15 Jun 2020 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mwNQ+ZPrHLyvZ8H22M9evW5mu6OkuaBWEuSC8HmI3Yw=; b=MKZ3MRb6eizzLANnEeT0A3L4uv
        KbgrodVreifddBjcCAPaTgPo6rPnSjfTpUfupeKPqvQi7Y0TzyhonyfKXoWSGXR2OcHH8PwpScj50
        dhNCnizJdiP9/RjPl4Es4xTSagvBWR18L1NrgTlQZIyHiQhZGtLx75mTS985gr15fF3aIfvZi/NZc
        RH8roztMt+Y7AZ+b9xUn5HA0M1lsrc8OTzTcnX1ARFlqShzcrw/KgO+AwG6Mf6DLcUoijc3AOo3Fx
        08IYTfRauTsYBIpFU57wJpEKFm64hRdRcPWSkHWM1OWbnctwji1bCynCQ0RcgR3IHaDNgt9ivCv9O
        FKmd7gIw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocU-0000tH-RQ; Mon, 15 Jun 2020 12:53:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/16] initrd: remove the BLKFLSBUF call in handle_initrd
Date:   Mon, 15 Jun 2020 14:53:16 +0200
Message-Id: <20200615125323.930983-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
References: <20200615125323.930983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
ramdisk, which was completely different behavior compared to all other
drivers.  But this magic overload got removed in commit ff26956875c2
("brd: remove support for BLKFLSBUF"), so this call is entirely
pointless now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d72beda824aa79..e4f88e9e1c0839 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -115,21 +115,12 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = ksys_open("/dev/root.old", O_RDWR, 0);
 		if (error == -ENOENT)
 			printk("/initrd does not exist. Ignored.\n");
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		ksys_umount("/old", MNT_DETACH);
-		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
-		if (fd < 0) {
-			error = fd;
-		} else {
-			error = ksys_ioctl(fd, BLKFLSBUF, 0);
-			ksys_close(fd);
-		}
-		printk(!error ? "okay\n" : "failed\n");
 	}
 }
 
-- 
2.26.2

