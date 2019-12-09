Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22737116BF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLILKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:15 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60116 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLILKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wbYEHDejQHpBGvl1FNVGjocrvExZFG3jJF77gCRHpz0=; b=dM3fxsB83IFdWkQfrjD9II7BPp
        uzj15UCtoLIgiKJAnU2M5MJjxw3BtDPEWCgEuEoxqd90AF+e4fK7HKUI1Tgq2BsVdFoL0e1Kq1Ga9
        hmnR2pSvoDrNmnYd695tvJBlUH42brnbSu8RbPXKouiNIizAwG2kirlodbDue+k91RKl/gl8m3CrE
        N1uZFPwhUk5QxQAZMdG8x6Oz4p70n85QvpkLxBhHhWKDK90Y7PeFvNjqMyeF1DbC2YPd3r/RGPdy2
        4/0xmhPh+XRkqH0sLf2uhYESALaATSIzcGXl5hY2a609+K2x1g9+U3BUAg7HDDbKgSW8TfNuPbOVg
        k/jFkG4A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54082 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvY-0002Vg-GE; Mon, 09 Dec 2019 11:10:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvW-0004c5-HK; Mon, 09 Dec 2019 11:10:06 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/41] fs/adfs: dir: improve compiler coverage in
 adfs_dir_update
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvW-0004c5-HK@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:06 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of the ifdef, using IS_ENABLED() instead to detect whether the
code should be callable.  This allows the compiler to always parse the
following code, reducing the chances of errors being missed.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 5e5d344bae7c..931eefb2375b 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -287,14 +287,16 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 int
 adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 {
-	int ret = -EINVAL;
-#ifdef CONFIG_ADFS_FS_RW
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct adfs_dir dir;
+	int ret;
 
 	printk(KERN_INFO "adfs_dir_update: object %06x in dir %06x\n",
 		 obj->indaddr, obj->parent_id);
 
+	if (!IS_ENABLED(CONFIG_ADFS_FS_RW))
+		return -EINVAL;
+
 	if (!ops->update)
 		return -EINVAL;
 
@@ -328,7 +330,7 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 		adfs_dir_forget(&dir);
 unlock:
 	up_write(&adfs_dir_rwsem);
-#endif
+
 	return ret;
 }
 
-- 
2.20.1

