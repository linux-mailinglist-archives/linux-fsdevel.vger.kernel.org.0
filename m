Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3D116C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfLILLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:42 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60240 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfLILLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s4LR7zShKHpYDFjSlBq28YtR9PUzsEWMECYeO2+fF9I=; b=KVk1GS53OAOFzYPEwg71bc5/6x
        stSHgVbLBzRL0xb1m7I5TK7sUifCexTyjkRtNq3Ezb/Iob4oJovdwHCAEdCUiaRNKgn+1pear+DDg
        By5FyK02uRPMocU2rfHF86AaAt/KBfAqif1IpeIA647yYPqhFVtJMPprwFQqgxKEfYyZzRNI6Q3ww
        1g8mhUXPkhEBoU52BnwAc7muV6jussd0O8Sl7KaRYeUOlYO8DEzVwRAUHKOPvB6yi3xdf1r/jry6i
        Pz6H1IbpnUY9xc1Jpfyx2EiEHqSugA/peVvy3/o2FFMjDKDCZx9fJTCDl9uaoTLaXRpdyPs508CvX
        01rB7uRA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49882 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGx1-0002Y9-Au; Mon, 09 Dec 2019 11:11:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGx0-0004eT-QA; Mon, 09 Dec 2019 11:11:38 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 40/41] fs/adfs: mostly divorse inode number from indirect disc
 address
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGx0-0004eT-QA@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:38 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid using the inode number as the indirect disc address, even though
these currently have the same value.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  | 1 +
 fs/adfs/dir.c   | 4 ++--
 fs/adfs/inode.c | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index c05555252fec..699c4fa8b78b 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -32,6 +32,7 @@ static inline u16 adfs_filetype(u32 loadaddr)
 struct adfs_inode_info {
 	loff_t		mmu_private;
 	__u32		parent_id;	/* parent indirect disc address	*/
+	__u32		indaddr;	/* object indirect disc address	*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
 	unsigned int	attr;		/* RISC OS permissions		*/
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index dd940f17767d..77fbd196008f 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -158,7 +158,7 @@ static int adfs_dir_read_inode(struct super_block *sb, struct inode *inode,
 {
 	int ret;
 
-	ret = adfs_dir_read(sb, inode->i_ino, inode->i_size, dir);
+	ret = adfs_dir_read(sb, ADFS_I(inode)->indaddr, inode->i_size, dir);
 	if (ret)
 		return ret;
 
@@ -372,7 +372,7 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 			break;
 		}
 	}
-	obj->parent_id = inode->i_ino;
+	obj->parent_id = ADFS_I(inode)->indaddr;
 
 unlock_relse:
 	up_read(&adfs_dir_rwsem);
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 212a56fc7911..32620f4a7623 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -20,7 +20,8 @@ adfs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh,
 		if (block >= inode->i_blocks)
 			goto abort_toobig;
 
-		block = __adfs_block_map(inode->i_sb, inode->i_ino, block);
+		block = __adfs_block_map(inode->i_sb, ADFS_I(inode)->indaddr,
+					 block);
 		if (block)
 			map_bh(bh, inode->i_sb, block);
 		return 0;
@@ -259,6 +260,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	 * for cross-directory renames.
 	 */
 	ADFS_I(inode)->parent_id = obj->parent_id;
+	ADFS_I(inode)->indaddr   = obj->indaddr;
 	ADFS_I(inode)->loadaddr  = obj->loadaddr;
 	ADFS_I(inode)->execaddr  = obj->execaddr;
 	ADFS_I(inode)->attr      = obj->attr;
@@ -353,7 +355,7 @@ int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct object_info obj;
 	int ret;
 
-	obj.indaddr	= inode->i_ino;
+	obj.indaddr	= ADFS_I(inode)->indaddr;
 	obj.name_len	= 0;
 	obj.parent_id	= ADFS_I(inode)->parent_id;
 	obj.loadaddr	= ADFS_I(inode)->loadaddr;
-- 
2.20.1

