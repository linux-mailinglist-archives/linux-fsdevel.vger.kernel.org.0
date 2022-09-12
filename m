Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870155B60CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiILS3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiILS23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264343E7E;
        Mon, 12 Sep 2022 11:26:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c24so9037238pgg.11;
        Mon, 12 Sep 2022 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iZBT3paH7ib6tLdY11ze0PGeOOPanYFCKzZa2TAf2gQ=;
        b=QkzFucHR1fupSeVgkblSK5qafJCdbSmYeMiwUIAQlaY9uethI4Pgnd1Bnj9rnWMs8/
         r3L4IeC3wfXLBQd0PODD5XEJxk5uyedAZU1m489CavS2FEDS8quz37ynfsdfhjEZm8RI
         C2ZLDnP9Pnc8XBiwTLesO6YiXLxOL2gbOGUJt2n/PEx5+mfO0etsNWI0uvIAO/uhFb6x
         lFFXBAKKaMWQvQgH39q61lrTIsM7c8YMTUcW4lDdSlXhdww3nb7o02TObqPupet5gyJk
         7RkJCEpDWHn639fPwEhJvdWuZSftDpyL+FtJODzUIbnECV1xwKcq6GxE0JKbw3aep+na
         CN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iZBT3paH7ib6tLdY11ze0PGeOOPanYFCKzZa2TAf2gQ=;
        b=7i2sZBuVsMUC3TqeLPo6rkOagoPG2jz4UIMFK1ND3D4rOu5CCSr+XYPA2/I76VlxHZ
         HSQBfqMB2du18dpuJ9XuZNIGHqnzBvbJ+ci1RqxYThQfqC72wrxYt2Koep6MlvAF9mGM
         l8JG3eUWJqVDh/QbJZGCODDdETyBAeWoaChmAEGIN0TBE50cNVif436PgxT4d7jf9jxe
         lS7KO/iXmRVzUn1R89WuB/z3aShUtOkRShNt2qkR9A46sY5urZ2NdSXR3BKdaxkXUwV8
         CzHiRpXAntHtGDUh/8DDVOktSjxw4VpBapPdxEnE+VpaNwuPfbboNsjCpa96YkfJAiuA
         Cmog==
X-Gm-Message-State: ACgBeo01aebnqzhkmsPy2VX0ZwfPQnQu39TF8JMk2yZ+D80D2bMaYdX4
        0ZY46SKWVu+IxnHgfXYWGUES87U89XnqQA==
X-Google-Smtp-Source: AA6agR5jqq4HR13QV4NjOJyLUDfVzNGQEZAmimcRy3kDhjfHX6OWAX3x1w/BfIb8s4plIHCJOjRu2Q==
X-Received: by 2002:a65:6749:0:b0:434:1f8b:cb97 with SMTP id c9-20020a656749000000b004341f8bcb97mr24158872pgu.360.1663007155026;
        Mon, 12 Sep 2022 11:25:55 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:54 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:21 -0700
Message-Id: <20220912182224.514561-21-vishal.moola@gmail.com>
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
 fs/nilfs2/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 9f4d9432d38a..1e26f32a4e36 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2143,7 +2143,7 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
 	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	pgoff_t index = 0;
 	int level, i;
@@ -2153,19 +2153,19 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	     level++)
 		INIT_LIST_HEAD(&lists[level]);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while (pagevec_lookup_tag(&pvec, btcache, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btcache, &index, (pgoff_t)-1,
+				PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh))
 					nilfs_btree_add_dirty_buffer(btree,
 								     lists, bh);
 			} while ((bh = bh->b_this_page) != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1

