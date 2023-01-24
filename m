Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5937367978C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjAXMS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjAXMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E800442FC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20BFC1FE48;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htUAAaELlcI6Pt4tZkmStUv6AH5ZIxV1KiGPmMSRRbQ=;
        b=XKjrhvk1JlKsKef+m+MWK29lAAolOQuupLYalw8KMouTkRb3BRbyCulLDoUB4MO9QTRh8I
        nhodX0g81aShzEzTwed0ASRUAEWRU8BH0LTPAzMFl9OFVKZ56Y82ypAF2WLnAzg3N5haYQ
        ccvb4nJKMFYFQYjuwcPfGHdOQJUS69I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htUAAaELlcI6Pt4tZkmStUv6AH5ZIxV1KiGPmMSRRbQ=;
        b=GTF3PSHLbnjIzgEeYRBxBA4bfy1IOB87AV0H/tdF/HnXLcoupOoI81wZiZEsuHmNxB/IW+
        og/wXlCseHOCZ9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10905139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B9IJBIfMz2PoNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4007DA06D8; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 11/22] udf: Add flag to disable block preallocation
Date:   Tue, 24 Jan 2023 13:17:57 +0100
Message-Id: <20230124121814.25951-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=jack@suse.cz; h=from:subject; bh=DSZ41J9LUfigRPji09asiP/3SOiRhtVAKafdW7IE8yA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x2xIDOWNsApT+VRjtZNBXMyUV6Pqc2E+eBb3r6 j7SooImJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MdgAKCRCcnaoHP2RA2R5UCA DO0VJoEHOUe+g/RjeDKb69ySC9jX1y6nBDXf2Sa7JU0gQVFbljsDNGSw6lyJ+tjl6Upk05ZbFJAxXp 1IyhetE2Y5wRXAlQDe7F7PrwCoFbsSPpufXitwtVJlL61gdx3k0GlMVyM7kTsjacOnnegkU03bK57C hDin0wEn5JS7TE+FTInmf7KmbkwJC4Y9ru1ooQJPpeKFKo0aUzqfMaOvxrsXSQVumbYZO/uqQMyBTM aOpNedF5InQSIlwjH6MhJUCmDtwl+eisTKSa6vH6XQAnwTtFaJDNpoLcHaRtL15m5jEzwmV7DFz8Lx XRv5Xxgr9lA9dQfZwNgnFR1U6LdQMQ
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

In some cases we don't want to create block preallocation when
allocating blocks. Add a flag to udf_map_rq controlling the behavior.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5c6725a5bb88..daacb793f6f1 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -322,7 +322,8 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-#define UDF_MAP_CREATE	0x01	/* Mapping can allocate new blocks */
+#define UDF_MAP_CREATE		0x01	/* Mapping can allocate new blocks */
+#define UDF_MAP_NOPREALLOC	0x02	/* Do not preallocate blocks */
 
 #define UDF_BLK_MAPPED	0x01	/* Block was successfully mapped */
 #define UDF_BLK_NEW	0x02	/* Block was freshly allocated */
@@ -381,6 +382,14 @@ static int udf_get_block(struct inode *inode, sector_t block,
 		.iflags = create ? UDF_MAP_CREATE : 0,
 	};
 
+	/*
+	 * We preallocate blocks only for regular files. It also makes sense
+	 * for directories but there's a problem when to drop the
+	 * preallocation. We might use some delayed work for that but I feel
+	 * it's overengineering for a filesystem like UDF.
+	 */
+	if (!S_ISREG(inode->i_mode))
+		map.iflags |= UDF_MAP_NOPREALLOC;
 	err = udf_map_block(inode, &map);
 	if (err < 0)
 		return err;
@@ -808,11 +817,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 	 * block */
 	udf_split_extents(inode, &c, offset, newblocknum, laarr, &endnum);
 
-	/* We preallocate blocks only for regular files. It also makes sense
-	 * for directories but there's a problem when to drop the
-	 * preallocation. We might use some delayed work for that but I feel
-	 * it's overengineering for a filesystem like UDF. */
-	if (S_ISREG(inode->i_mode))
+	if (!(map->iflags & UDF_MAP_NOPREALLOC))
 		udf_prealloc_extents(inode, c, lastblock, laarr, &endnum);
 
 	/* merge any continuous blocks in laarr */
-- 
2.35.3

