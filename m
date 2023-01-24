Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E101F679791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjAXMSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjAXMST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1137F0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 294E31FE49;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvVQ7ivB1pfL459eXGObvMwgerzTX7YhI+zVj0o6Re4=;
        b=tZCfKHwt+sxrPwunZqZgjl4Tq3UbqLhMJglbhR+Z4AcJWYLiUxK3WNza7PmSGaErvswFS6
        Jb4/eITHR9+7JRbwhTiOUbA5l7tIf+4xLiKXGb0eweG6PoErrThl/s1DH4dIjZTN7ddkOf
        WqpA57cwuZWN2qSDw9NHUAH/rj4NSe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvVQ7ivB1pfL459eXGObvMwgerzTX7YhI+zVj0o6Re4=;
        b=VnkPt2SjFVcgG5wttqZCFADebgqC14Ni20x2S6sWBUwiP/4Y+q0O11PeKSH+7ZD5biVOK2
        Z6Qsi8cfl2kKjRDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18EBF13A04;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6DNTBYfMz2PpNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4CEBBA06E2; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 13/22] udf: Fold udf_getblk() into udf_bread()
Date:   Tue, 24 Jan 2023 13:17:59 +0100
Message-Id: <20230124121814.25951-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=jack@suse.cz; h=from:subject; bh=wH/dV+bDpVEl8+ezd55LRPKIH6DdZmDKbjBpS9Q/yzo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x3pGSn6fbN1XZtcgN1H13KvZRm0+d4PmZ5U1s5 Gw64XDKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MdwAKCRCcnaoHP2RA2e/NCA DZdLtJh/5/KazHGjiH2byLX1/oJgg52LW15alWr/dvm/Dza9nsMSzwj4CxUsYQxNA34GTLXLnFh4Kk vqzSausoD/MHnUOr4PxfGiQr8ovrMj1iTVMonGfCdixQ0Y/psLlozWdZATrtqyPYPuj4n0tTuVgknZ QRjYVjJVZCZTktvbCij0zOobn7ZceKD7LgK24dn8Uw81eUtrzsRunSLBwJqh00hJ57r/eGdtDXbw5E c2MiAjLERIy0gKnJZmU7Nt0vmwPHvDyN+IzNuf39mL3SXJMp9BiEQCyekhXY8dbdKif5O5DzVow5qu Yl2sum/7QpnGw39uXeQRVuzoDI1bzj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

udf_getblk() has a single call site. Fold it there.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4e6b855ffd02..4554d1e54eb3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -401,31 +401,6 @@ static int udf_get_block(struct inode *inode, sector_t block,
 	return 0;
 }
 
-static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
-				      int create, int *err)
-{
-	struct buffer_head *bh;
-	struct udf_map_rq map = {
-		.lblk = block,
-		.iflags = create ? UDF_MAP_CREATE : 0,
-	};
-
-	*err = udf_map_block(inode, &map);
-	if (!*err && map.oflags & UDF_BLK_MAPPED) {
-		bh = sb_getblk(inode->i_sb, map.pblk);
-		if (map.oflags & UDF_BLK_NEW) {
-			lock_buffer(bh);
-			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-			set_buffer_uptodate(bh);
-			unlock_buffer(bh);
-			mark_buffer_dirty_inode(bh, inode);
-		}
-		return bh;
-	}
-
-	return NULL;
-}
-
 /* Extend the file with new blocks totaling 'new_block_bytes',
  * return the number of extents added
  */
@@ -1140,10 +1115,28 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 			      int create, int *err)
 {
 	struct buffer_head *bh = NULL;
+	struct udf_map_rq map = {
+		.lblk = block,
+		.iflags = create ? UDF_MAP_CREATE : 0,
+	};
 
-	bh = udf_getblk(inode, block, create, err);
-	if (!bh)
+	*err = udf_map_block(inode, &map);
+	if (*err || !(map.oflags & UDF_BLK_MAPPED))
+		return NULL;
+	
+	bh = sb_getblk(inode->i_sb, map.pblk);
+	if (!bh) {
+		*err = -ENOMEM;
 		return NULL;
+	}
+	if (map.oflags & UDF_BLK_NEW) {
+		lock_buffer(bh);
+		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		mark_buffer_dirty_inode(bh, inode);
+		return bh;
+	}
 
 	if (bh_read(bh, 0) >= 0)
 		return bh;
-- 
2.35.3

