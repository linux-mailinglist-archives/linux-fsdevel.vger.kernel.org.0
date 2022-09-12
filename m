Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7375B60B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiILS2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiILS1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:27:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DA443E7F;
        Mon, 12 Sep 2022 11:25:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t65so9064459pgt.2;
        Mon, 12 Sep 2022 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hkB3nPg8Yb1a3uLKkDYOcB6rFmk073rmN4f+nAIJxVY=;
        b=UEt2/Q/Oo5ijG233MiDR4kuzcD4ucoPvmML0LjHbFk/LPVBSnALsoVuDCqKHbvw9vX
         VixOEDcnrMPrQbX1XljTmiMIKiFRrqyNEDXmKVXNALqzeVbn7/MgDWA9xkv0KPRCXp0p
         408DUS1wks2aaCWGo/kMwkBWN2e6O+VnPY6XWuLOkgvfdj9fAmE+dyVvef+wQH7jGJvH
         htQyCTMfty+Po4+SNi6z6D4xn0VOOPJIP+zN6uD1FT6VHfgrmkbKco9evf/2Rsd0CtY1
         Xv7/ZLXQ7ab8fn4CeYL2+AnhI9l4IG6cJwb3XobGRrVIM+YLezYnAYcrge6PsJT7YkeC
         O1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hkB3nPg8Yb1a3uLKkDYOcB6rFmk073rmN4f+nAIJxVY=;
        b=de9tY1fvxMAnpYve7mefzIjMr5xTmqAjZ42DVjT+47cOMosEsdPbfRTL0poZ9uSJbg
         +KfYOyC4FGJpPg0lT5csRq2533fyFuQrGWpaT9YsL/Ig74C+/ta90Bk964v3L6Plgwpy
         aM+p+EGZtuIZOtg3TeQSiTFuHu5AQmnCOIRg13ETbfDMs4K4Se/5d8wMIPuSCteg7UUK
         4T2PhTE2GOQLXog3o1Yw+ukVvKD8R/zbAtp1jQlDxMIDjIG0SDTKZIbjYBgxeTshq1D4
         M86WeOtSPwEhyu+EapkhuWXj8cCds232al14ZgbmAG0nIweUUXXhHdoicrrOmsE/fW5O
         SoHQ==
X-Gm-Message-State: ACgBeo1j23CVH35SfFgM4BhSLA4fX7t5nZ+giHGxgbJ4naSDWdBE/aUz
        erPBCUJn9Z6/B6NZechM/acQ/rsgxcW+vA==
X-Google-Smtp-Source: AA6agR76VK0fhJY06rRB9O/74EC9jPDGexQjCF0wz9rjn05u4fkrPxFd+Wi7GS6Jp+kdQ29h/HsxpA==
X-Received: by 2002:a63:554a:0:b0:42b:e4a4:ec86 with SMTP id f10-20020a63554a000000b0042be4a4ec86mr24313638pgm.47.1663007152911;
        Mon, 12 Sep 2022 11:25:52 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:52 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:20 -0700
Message-Id: <20220912182224.514561-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index c3f3484c4412..6f2ca279d230 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -737,20 +737,19 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	struct inode *btnc_inode = ii->i_assoc_inode;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
 	if (!btnc_inode)
 		return;
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
-
-	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btnc_inode->i_mapping, &index,
+				(pgoff_t)-1, PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh) &&
 						!buffer_async_write(bh)) {
@@ -761,7 +760,7 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 				bh = bh->b_this_page;
 			} while (bh != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

