Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3273C4F94FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiDHMCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 08:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiDHMCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:02:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB1888D3
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 05:00:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h19so8213247pfv.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Apr 2022 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fvPo7aaDG5VG3ITi2zcRGlHC3YD+uR68Dd9szGVfDjY=;
        b=Ny0WQTksmMl9Y0G+5Ykcwv0IsQ8rnw7Dy27fJZ4F7/X5DdNAuZ6xefMeUC58Sxrc2o
         vOFSPANg73HU1GE/cTfpq7pQK1ZKyk2LYqkcAB1IrTWR9Q41bxWTxH71xTK1adfwpFof
         kW88RUH5JpzQE8ELrI7Huh0qVHHXJySNkAeogZCUMngju0aUWZs/8LNDZcUy9n8rVgFZ
         Kle4SQt8wGHG9yuoOk+Wa5DDp65x6qUexWJGlmGXpzOzWZvmEYoukllCPC2voOCk3CJK
         bcsTg002ZPOnLhguHs8WR8abYh0HBDb7rXSthyNQBFktGbeNbSCchpbeezem2lvpoK7D
         vK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fvPo7aaDG5VG3ITi2zcRGlHC3YD+uR68Dd9szGVfDjY=;
        b=SUEQRUHzzw5bTI/qcA7qtxkOpiaYb8EyWJ/fCpLpkouExwyjkPeAlxYpqBepIes9yd
         st7Mp6Z2BBA17FX/EbHZh8VmbgwRoOWRsXLwNJvEJWJwjQlUxX4iMjDLWHtM1ozohl5K
         JcXUx4e78oDStaBjRk1zxLje7ek9S8WtLOpyKSaujIMiRJhCWsvzipvTuPaFEwcdmEdi
         HM4yHFyZLNxbDXLqAM5L1hY+adqj9Wth4QzlLBjKvT7qcNRmKHX2Gavxj6gz2a7/f2ZA
         USgd2d9FnVRL3iEfVw9lMtCHA0MvwoJmwjU3aXWARJX7kCa/2266uMCr8pOg96OYGsm3
         qR3g==
X-Gm-Message-State: AOAM530/88UT+3mnwLv0z/3OPYTbMZm8l024bZ7yDscImSb2oG87DUXg
        JQrUwia6+oCMXgpB562jSIs=
X-Google-Smtp-Source: ABdhPJw1axRkH4b03qWDpDfjOxLXtM1bxclZW+rOA7PkO7Mi/EuYh6pB6GnqINXqufLRfQ6cnfH4Sg==
X-Received: by 2002:a63:2cc4:0:b0:398:a2b7:469f with SMTP id s187-20020a632cc4000000b00398a2b7469fmr15299527pgs.73.1649419202866;
        Fri, 08 Apr 2022 05:00:02 -0700 (PDT)
Received: from localhost ([118.33.58.238])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm1766102pfb.217.2022.04.08.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:00:02 -0700 (PDT)
Date:   Fri, 8 Apr 2022 21:00:01 +0900
From:   Paran Lee <p4ranlee@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] writeback: expired dirty inodes can lead to a NULL
 dereference kernel panic issue in 'move_expired_inodes' function
Message-ID: <20220408120001.GA3113@DESKTOP-S4LJL03.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While tracing the null dereference kernel panic issue 

during the stress-ng(stress-ng-proc) test,

I found the inode code block that could cause 

a null dereference kernel panic. 

BUG: unable to handle kernel NULL pointer dereference at 0000000000000008

inode stack variable not initialized and not check on this code block. 

but find entry in delaying_queue. then, there was something suspicious 

temp inode loop that could cause a kernel panic in below code block.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 fs/fs-writeback.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..23a7a567e443 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1357,12 +1357,14 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 	LIST_HEAD(tmp);
 	struct list_head *pos, *node;
 	struct super_block *sb = NULL;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	int do_sb_sort = 0;
 	int moved = 0;
 
 	while (!list_empty(delaying_queue)) {
 		inode = wb_inode(delaying_queue->prev);
+		if (!inode)
+			continue;
 		if (inode_dirtied_after(inode, dirtied_before))
 			break;
 		list_move(&inode->i_io_list, &tmp);
@@ -1385,7 +1387,12 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 
 	/* Move inodes from one superblock together */
 	while (!list_empty(&tmp)) {
-		sb = wb_inode(tmp.prev)->i_sb;
+		inode = wb_inode(tmp.prev);
+		if (!inode)
+			continue;
+		sb = inode->i_sb;
+		if (!sb)
+			continue;
 		list_for_each_prev_safe(pos, node, &tmp) {
 			inode = wb_inode(pos);
 			if (inode->i_sb == sb)
-- 
2.25.1

