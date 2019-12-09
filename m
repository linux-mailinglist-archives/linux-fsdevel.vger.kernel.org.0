Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956E1116C03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLILLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60198 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfLILLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+gT1SrxPB1JHiiTDkyapfNf+6qTmDEk8sf0gy1QWPI=; b=Jom24ep5fiOC2k6xorTCJOTsSt
        l0R6Nh4gteCX+4kFsSxgL7NBT244A4wjL67hGMpkXpBnLLhLtBqQ7RJDI3n+n6GpL6QkWTssUYa8m
        A0s1p8CGGUEqgpo9qpMjHeMgMEMKYKDOgOiq9XpzK3Tr3C5zZyxNSQoCpUPV7kb+akgTWQPMzxX6O
        kQc3P5yaAW9MqRXDIJwpx4fKQp+o83JsBOm7LR5aEf9y1MLcq1g0/rX3zWuMcsqhFO7M0bPBlG3rT
        D+WE3VSsNr5oUDJ3ouYcIAV5jgMIo3olFnD23WWqyixuEiYqW9repxOB+7kblAXFJBNfCaFC9ORyK
        vDMNnd7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54106 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwX-0002XP-Eb; Mon, 09 Dec 2019 11:11:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwW-0004dj-24; Mon, 09 Dec 2019 11:11:08 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 34/41] fs/adfs: bigdir: calculate and validate directory
 checkbyte
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwW-0004dj-24@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:08 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reading a big directory, calculate the validate the directory
checkbyte to ensure that the directory contents are valid.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_fplus.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index a2fa416fbb6d..4ab8987962f0 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -67,6 +67,39 @@ static int adfs_fplus_validate_tail(const struct adfs_bigdirheader *h,
 	return 0;
 }
 
+static u8 adfs_fplus_checkbyte(struct adfs_dir *dir)
+{
+	struct adfs_bigdirheader *h = dir->bighead;
+	struct adfs_bigdirtail *t = dir->bigtail;
+	unsigned int end, bs, bi, i;
+	__le32 *bp;
+	u32 dircheck;
+
+	end = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries)) +
+		le32_to_cpu(h->bigdirnamesize);
+
+	/* Accumulate the contents of the header, entries and names */
+	for (dircheck = 0, bi = 0; end; bi++) {
+		bp = (void *)dir->bhs[bi]->b_data;
+		bs = dir->bhs[bi]->b_size;
+		if (bs > end)
+			bs = end;
+
+		for (i = 0; i < bs; i += sizeof(u32))
+			dircheck = ror32(dircheck, 13) ^ le32_to_cpup(bp++);
+
+		end -= bs;
+	}
+
+	/* Accumulate the contents of the tail except for the check byte */
+	dircheck = ror32(dircheck, 13) ^ le32_to_cpu(t->bigdirendname);
+	dircheck = ror32(dircheck, 13) ^ t->bigdirendmasseq;
+	dircheck = ror32(dircheck, 13) ^ t->reserved[0];
+	dircheck = ror32(dircheck, 13) ^ t->reserved[1];
+
+	return dircheck ^ dircheck >> 8 ^ dircheck >> 16 ^ dircheck >> 24;
+}
+
 static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 			   unsigned int size, struct adfs_dir *dir)
 {
@@ -107,6 +140,11 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 		goto out;
 	}
 
+	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
+		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
+		goto out;
+	}
+
 	dir->parent_id = le32_to_cpu(h->bigdirparent);
 	return 0;
 
-- 
2.20.1

