Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD1653E1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiLVKQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiLVKQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13E6479
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8641E4504;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0nGbOvNXrbr0L7puljLzPnbZHHS9uUvQyAtSaFZMTo=;
        b=tZwP9xGZPzFld8XmWiWG/ebD8a2YJE1XBrevRdfPyL4PG4YB5aYUaozSK1aj7j3nbg4fDF
        XyoAJmh8AQAnYGXoCepC+2A5X6hC1QiSh1xGHCZlPYDC5rmU5zHdnhQ/ibpnDWTTi8fDnU
        g3jgCvWILnTOho/AF9sqw1JLIPH0Y10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0nGbOvNXrbr0L7puljLzPnbZHHS9uUvQyAtSaFZMTo=;
        b=r9YZyYv9C4LBlmkOmmecDuU8csxUNtf4B7EKvtLgtE8MOkXmrnR5TjS4o6qLQLUAcO8Msz
        0/+JC6WWViUvmVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F3131391A;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EG+/Fm4upGMsWwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16DD0A0736; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] udf: Handle error when adding extent to a file
Date:   Thu, 22 Dec 2022 11:16:00 +0100
Message-Id: <20221222101612.18814-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; i=jack@suse.cz; h=from:subject; bh=9MgG21OefY4ia2mEWbI6seab3vZrzr+uMEedOhqns9Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5g6V3PRRheOzBRgHhuU2L3Ai7CfHsbjDmigRzA 4k4sE32JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuYAAKCRCcnaoHP2RA2cKDCA DgkHdnSNSROfHMWJfMcrYKAyad7E9Y2Xb6/5it1bYKdBMr+6NNk2Y1iyfaHvcQUX7qLl9oGxfEnEIb DDtQ5QhqXaGbS3e2Hp5UowrpdFq3O+WtwLbVTC3UvlWMR9Ough158Ez77DXps70BKnBl5YDFn76Kqy Al5BLDpAilaimh4KbUrhjY7MXMuSmO1B2b5utOkT0k0Z9sKAYxYPRM7/KXu9/T8kV2HSW1lYXUgGo4 uIx1P2bOiWkK86T2KtFBrqGqKZ+Fbhrxwhtqz8iVw/mKXVkVG80USoo4P0pFmxFqWO6xSWng+wzH5p TmqqUWKYxGAhD+LBvByTPNbrY/J1VQ
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

When adding extent to a file fails, so far we've silently squelshed the
error. Make sure to propagate it up properly.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 09417342d8b6..15b3e529854b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -57,15 +57,15 @@ static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
 static int udf_alloc_i_data(struct inode *inode, size_t size);
 static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
-static int8_t udf_insert_aext(struct inode *, struct extent_position,
-			      struct kernel_lb_addr, uint32_t);
+static int udf_insert_aext(struct inode *, struct extent_position,
+			   struct kernel_lb_addr, uint32_t);
 static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
 			      struct kernel_long_ad *, int *);
 static void udf_prealloc_extents(struct inode *, int, int,
 				 struct kernel_long_ad *, int *);
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
-static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
-			       int, struct extent_position *);
+static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
+			      int, struct extent_position *);
 static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 static void __udf_clear_extent_cache(struct inode *inode)
@@ -795,7 +795,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	/* write back the new extents, inserting new extents if the new number
 	 * of extents is greater than the old number, and deleting extents if
 	 * the new number of extents is less than the old number */
-	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	if (*err < 0)
+		goto out_free;
 
 	newblock = udf_get_pblock(inode->i_sb, newblocknum,
 				iinfo->i_location.partitionReferenceNum, 0);
@@ -1063,21 +1065,30 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	}
 }
 
-static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
-			       int startnum, int endnum,
-			       struct extent_position *epos)
+static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
+			      int startnum, int endnum,
+			      struct extent_position *epos)
 {
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int err;
 
 	if (startnum > endnum) {
 		for (i = 0; i < (startnum - endnum); i++)
 			udf_delete_aext(inode, *epos);
 	} else if (startnum < endnum) {
 		for (i = 0; i < (endnum - startnum); i++) {
-			udf_insert_aext(inode, *epos, laarr[i].extLocation,
-					laarr[i].extLength);
+			err = udf_insert_aext(inode, *epos,
+					      laarr[i].extLocation,
+					      laarr[i].extLength);
+			/*
+			 * If we fail here, we are likely corrupting the extent
+ 			 * list and leaking blocks. At least stop early to
+			 * limit the damage.
+			 */
+			if (err < 0)
+				return err;
 			udf_next_aext(inode, epos, &laarr[i].extLocation,
 				      &laarr[i].extLength, 1);
 			start++;
@@ -1089,6 +1100,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
+	return 0;
 }
 
 struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
@@ -2107,12 +2119,13 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	return etype;
 }
 
-static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
-			      struct kernel_lb_addr neloc, uint32_t nelen)
+static int udf_insert_aext(struct inode *inode, struct extent_position epos,
+			   struct kernel_lb_addr neloc, uint32_t nelen)
 {
 	struct kernel_lb_addr oeloc;
 	uint32_t oelen;
 	int8_t etype;
+	int err;
 
 	if (epos.bh)
 		get_bh(epos.bh);
@@ -2122,10 +2135,10 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
 	brelse(epos.bh);
 
-	return (nelen >> 30);
+	return err;
 }
 
 int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
-- 
2.35.3

