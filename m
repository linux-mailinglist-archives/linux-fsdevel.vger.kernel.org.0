Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F77A47F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjIRLGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjIRLF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D294;
        Mon, 18 Sep 2023 04:05:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7902F21AB2;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3AoJv2BI4/Yeg1oZ6DdfLHBbwEuOnZEioucjclZ6/Y=;
        b=Uf4h7o73hvBBWy0H8CPu+88GxRJcN/oV1LGJmdqMDllRbB+gR5VUw8aStuiiYFhRgEYdju
        OVX3CmkNXvYt/Jaqe5Y1JuehWrfGwklG5xC6EY/ShKW+2Ysu+SMLJkiI4G5TbgE8ApnQBs
        yJTfbYbN6pAMTfxvetGC+EJeow5BiD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3AoJv2BI4/Yeg1oZ6DdfLHBbwEuOnZEioucjclZ6/Y=;
        b=WYgm3DL0ajNKFozSyfShaisgQ/WKknxBghYuLNvjMebG7PtG/xAofBcO/vfQPwqWgmbBIA
        ejzDgezFBVF+TDDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 614122C14E;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 338E851CD14F; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/18] fs/buffer: use mapping order in grow_dev_page()
Date:   Mon, 18 Sep 2023 13:05:01 +0200
Message-Id: <20230918110510.66470-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the correct mapping order in grow_dev_page() to ensure folios
are created with the correct order.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 66895432d91f..a219b79c57ad 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1044,6 +1044,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	sector_t end_block;
 	int ret = 0;
 	gfp_t gfp_mask;
+	fgf_t fgf = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
 
 	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
 
@@ -1054,9 +1055,8 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 * code knows what it's doing.
 	 */
 	gfp_mask |= __GFP_NOFAIL;
-
-	folio = __filemap_get_folio(inode->i_mapping, index,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
+	fgf |= fgf_set_order(mapping_min_folio_order(inode->i_mapping));
+	folio = __filemap_get_folio(inode->i_mapping, index, fgf, gfp_mask);
 
 	bh = folio_buffers(folio);
 	if (bh) {
-- 
2.35.3

