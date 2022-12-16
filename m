Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8BE64EDE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiLPP1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLPP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FFB654EB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 697695D119;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdGMObIF3RiZ9i2Q0uVQAOtTgVzqOxN2LNMLyab/ZGw=;
        b=ir/ihiQh3dXPa1cK+pprn9ErIw7I0jFPJiWrM8w2lZGLqtv2ZxHta9jW/zuz6kFgBnE6vD
        kgh6mv0Z3j+btvXc6DqGtxtvdsOTusbnjHQgi5g0Lo85pNSUH6KVvYy5XPzptB5G0IQHbI
        CqGW6TJa++LEum6+4ogv7ZpeVNfhllY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdGMObIF3RiZ9i2Q0uVQAOtTgVzqOxN2LNMLyab/ZGw=;
        b=TDs3r6G9/dytOY4npVfZAKVUso3s017lWET8cSpVAGx20aq5+PYiOj+Uox6slChqdUDRnz
        arRJnbE9+aRZJ3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C1321390B;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 897XDUaOnGPYCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2D4EA076B; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 09/20] udf: Convert empty_dir() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:13 +0100
Message-Id: <20221216152656.6236-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; i=jack@suse.cz; h=from:subject; bh=FKHwsFkBLm34kr3dF97qTPbDX+J8b23On9VoCxoavhs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2dxbk5CyT3af0ZY3eYoQn7MNo7xUff/rY2fbkW 5UdRjQCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNnQAKCRCcnaoHP2RA2WZaB/ 94vN3yCg+QqVG1CNfx/igvvYsCKLpwLGQeKg9gUDUfe8+cY0qj6uidhYgVGL0fc3RYu9wP6T+IgxCa UBKaV+ywEZDb3XTtCVB1np9GSJrtEV7Rw1WC3fjFWurWw6v1Mxp8OQq1EmwQ5zJRy2GT6VkwNIN+FM hF6YziWgz5/pR40rNJ+XJB9drkAe/BqScELXA/4kbkqNNFUKknFCtjI62Q70CQMz4fX+XeKP6UFPlX AavEL1Vuv9VZcSPY3+7MZMNMgFPMimFuKWOVDu0mt28LFZBHC0Odddu0pMM7GA81FapI16P3rjenyp SmNtsQV60pj3L01mDEULBqR8bGHuWf
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

Convert empty_dir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 68 +++++++-------------------------------------------
 1 file changed, 9 insertions(+), 59 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 812786050617..964ac7d4e274 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -869,69 +869,19 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 static int empty_dir(struct inode *dir)
 {
-	struct fileIdentDesc *fi, cfi;
-	struct udf_fileident_bh fibh;
-	loff_t f_pos;
-	loff_t size = udf_ext0_offset(dir) + dir->i_size;
-	udf_pblk_t block;
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
-	sector_t offset;
-	struct extent_position epos = {};
-	struct udf_inode_info *dinfo = UDF_I(dir);
-
-	f_pos = udf_ext0_offset(dir);
-	fibh.soffset = fibh.eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
-
-	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		fibh.sbh = fibh.ebh = NULL;
-	else if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits,
-			      &epos, &eloc, &elen, &offset) ==
-					(EXT_RECORDED_ALLOCATED >> 30)) {
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
-			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
-				epos.offset -= sizeof(struct short_ad);
-			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
-				epos.offset -= sizeof(struct long_ad);
-		} else
-			offset = 0;
-
-		fibh.sbh = fibh.ebh = udf_tread(dir->i_sb, block);
-		if (!fibh.sbh) {
-			brelse(epos.bh);
-			return 0;
-		}
-	} else {
-		brelse(epos.bh);
-		return 0;
-	}
-
-	while (f_pos < size) {
-		fi = udf_fileident_read(dir, &f_pos, &fibh, &cfi, &epos, &eloc,
-					&elen, &offset);
-		if (!fi) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
-			return 0;
-		}
+	struct udf_fileident_iter iter;
+	int ret;
 
-		if (cfi.lengthFileIdent &&
-		    (cfi.fileCharacteristics & FID_FILE_CHAR_DELETED) == 0) {
-			if (fibh.sbh != fibh.ebh)
-				brelse(fibh.ebh);
-			brelse(fibh.sbh);
-			brelse(epos.bh);
+	for (ret = udf_fiiter_init(&iter, dir, 0);
+	     !ret && iter.pos < dir->i_size;
+	     ret = udf_fiiter_advance(&iter)) {
+		if (iter.fi.lengthFileIdent &&
+		    !(iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED)) {
+			udf_fiiter_release(&iter);
 			return 0;
 		}
 	}
-
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	brelse(epos.bh);
+	udf_fiiter_release(&iter);
 
 	return 1;
 }
-- 
2.35.3

