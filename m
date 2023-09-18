Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC87A47E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjIRLGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjIRLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D814102;
        Mon, 18 Sep 2023 04:05:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F12721AAE;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sO3vom66G3v5wN0Rdlws4SQilffG/SX/AZnhq8li8s0=;
        b=cj8Xl1vQV0GmNA9HBXj8qCFC/7Y3exTb67ZcPO94wqHHvTrAZ/dB1kK1qT6l5mP1JwBQ4J
        usw1tv6VgKf8IcXVvgCQOZsIKdukqXuDAPHAEfoaoAkgmjaGvwy/mEf5Mlr/yUjfLPh0Kj
        tyD0jeT+/Fvc/hDcQtHzmoAqYmUXuc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sO3vom66G3v5wN0Rdlws4SQilffG/SX/AZnhq8li8s0=;
        b=piMdi4Fsth+ZBmMAKv2Q8dM0wTMAQce5SwRLodipTLgzMORWiDmU7WzMTnR9V1Eq1Y4u5E
        gc7ZlULoKZUZdDBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id F104D2C146;
        Mon, 18 Sep 2023 11:05:16 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 01FB851CD143; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/18] block/buffer_head: introduce block_{index_to_sector,sector_to_index}
Date:   Mon, 18 Sep 2023 13:04:55 +0200
Message-Id: <20230918110510.66470-4-hare@suse.de>
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

Introduce accessor functions block_index_to_sector() and block_sector_to_index()
to convert the page index into the corresponding sector and vice versa.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/buffer_head.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 4ede47649a81..55a3032f8375 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -277,6 +277,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size);
 void block_commit_write(struct page *page, unsigned int from, unsigned int to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
+
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
@@ -449,6 +450,22 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 
 bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 
+static inline sector_t block_index_to_sector(pgoff_t index, unsigned int blkbits)
+{
+	if (PAGE_SHIFT < blkbits)
+		return (sector_t)index >> (blkbits - PAGE_SHIFT);
+	else
+		return (sector_t)index << (PAGE_SHIFT - blkbits);
+}
+
+static inline pgoff_t block_sector_to_index(sector_t block, unsigned int blkbits)
+{
+	if (PAGE_SHIFT < blkbits)
+		return (pgoff_t)block << (blkbits - PAGE_SHIFT);
+	else
+		return (pgoff_t)block >> (PAGE_SHIFT - blkbits);
+}
+
 #ifdef CONFIG_BUFFER_HEAD
 
 void buffer_init(void);
-- 
2.35.3

