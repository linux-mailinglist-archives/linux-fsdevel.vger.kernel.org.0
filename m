Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC367978F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjAXMSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXMST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A237F02
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD512189A;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpgq7pkFTHUcoHIaiRiSu/kuem1wMOv/RmU/oTrzaXM=;
        b=L5tr8tRTn8Ih39ueWxHeVcb6RG7qwc+6Y4kpwDUgr8z8ZwnBquQrEy3+7co85Fuzc3q3af
        0A06Yd1euUAMny9grEcfuScNQg7Z4qtL5orNrgpmDDHBg+EGiW5WnQOK2JWlQlJs4tkBPt
        wfh1HR4fGRN+ZHD2OAI4JjZtFitw7l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpgq7pkFTHUcoHIaiRiSu/kuem1wMOv/RmU/oTrzaXM=;
        b=xgvoKj11FfWtJQ0dN33Xv1j0M+yW+z2EKFyY7E6Kn46kmnldb8ONIMynlrq1JXeEuvu0cJ
        9Cp4LLFL7y9q9RDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D81C13A06;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ss6B4fMz2PrNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33FC2A06D5; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 09/22] udf: Fold udf_block_map() into udf_map_block()
Date:   Tue, 24 Jan 2023 13:17:55 +0100
Message-Id: <20230124121814.25951-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=jack@suse.cz; h=from:subject; bh=fCCNH/2GDFZMtrrFOYavCg3Ez2Eg6VO/6hGC8KpoaS4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x0HnQ92igypy0GPXYLon5LOed9Yr2frRbYxMCC KJIjKJiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MdAAKCRCcnaoHP2RA2VRcB/ 9u//TlRrMdCXccyoetTvL2cCwuBXu89C06wrMi2sLND4bMeJR7spEzuqf4pRO62EtktGVMbMNhLoz7 NzmiDT8CNLhFiq8pTdU0S9KayBus0KZelQIDhwAp9qMKd3s7Mez91iBGRP23D4NNLog6RjQjGf5Dyk WulxSCqMBQm/S9FHolIZ/owACjcDVbGTlfun0Zf5gcvjGPiM0sbdwGBZGltNuU1zx44gXxJ72rasNp cbQ+W8GQEjFinPKbWPjGRKrjSLYcPQSz4QYKP75mF/4hJgZfWzol5lnuLs+R1fvb4aZ22T9aRRmCir /O5NB15RuhPHrU6IIpFLdQ2BJTJEJm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

udf_block_map() has now only a single caller. Fold it there.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c   | 38 ++++++++++++++------------------------
 fs/udf/udfdecl.h |  1 -
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 53d2d8fef158..e098d69991d0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -341,9 +341,21 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 
 	map->oflags = 0;
 	if (!(map->iflags & UDF_MAP_CREATE)) {
-		map->pblk = udf_block_map(inode, map->lblk);
-		if (map->pblk != 0)
+		struct kernel_lb_addr eloc;
+		uint32_t elen;
+		sector_t offset;
+		struct extent_position epos = {};
+
+		down_read(&iinfo->i_data_sem);
+		if (inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset)
+				== (EXT_RECORDED_ALLOCATED >> 30)) {
+			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
+							offset);
 			map->oflags |= UDF_BLK_MAPPED;
+		}
+		up_read(&iinfo->i_data_sem);
+		brelse(epos.bh);
+
 		return 0;
 	}
 
@@ -2293,25 +2305,3 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 
 	return etype;
 }
-
-udf_pblk_t udf_block_map(struct inode *inode, sector_t block)
-{
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	udf_pblk_t ret;
-
-	down_read(&UDF_I(inode)->i_data_sem);
-
-	if (inode_bmap(inode, block, &epos, &eloc, &elen, &offset) ==
-						(EXT_RECORDED_ALLOCATED >> 30))
-		ret = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
-	else
-		ret = 0;
-
-	up_read(&UDF_I(inode)->i_data_sem);
-	brelse(epos.bh);
-
-	return ret;
-}
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index d791458fe52a..98b4d89b4368 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -158,7 +158,6 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 extern int udf_setsize(struct inode *, loff_t);
 extern void udf_evict_inode(struct inode *);
 extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
-extern udf_pblk_t udf_block_map(struct inode *inode, sector_t block);
 extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
 			 struct kernel_lb_addr *, uint32_t *, sector_t *);
 extern int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
-- 
2.35.3

