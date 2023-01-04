Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79A065DEBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbjADVQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbjADVP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC71CB3D;
        Wed,  4 Jan 2023 13:15:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so24642271pjp.1;
        Wed, 04 Jan 2023 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=;
        b=l0t6NL5SCvyD8kdyfFc7nOlzhreLq5VCcEZoAPCjS9SYlOOIdyy01o8enEBrI/r1kI
         ge7wlbNG0U5OHLin8Sv0DJ9D+P9p9F9nvhdVsVzqSo2MjhW1QMKBlTmQftWK0E3Sq3mX
         s5i3P5LahXYCAZDxiD7TON2xAC7xlyma9HMVO7+C60fEOzvSJBRZE+ygGDT49ocIptx1
         ZqodBy1UQufx3eUsdyctWHg9lneTCyK6t6QfTsYnGyQ1gnGKfPEGcEh9fBK7H9Fo86Cv
         0aWOKjYHhKUcF745lohZ9dh0iABWPhdJYkbVa6/m4X3OwsSxOaXcOBpLjiswo+OAnLFc
         jYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlC7rcv7uN/Ok17R0azuMVwGkvRCqLRr8I16XJ1l0Zg=;
        b=iyZrgJIgk/wQU4tIiWee14WNVE7aMByEFtlAHFKuM2g/qZ1RXJ6lPSHGsdlfjxUnJj
         mVGWu/OpQU5XfYyCpAJzuAKg2463dX+LRfcWJcqLjy0B8favxbNUNCKCPX8xg0qixctV
         RkQozj781yuRI2LjcsYNxH/UFJAxQWvAjdU3aXwzpB8H8c/Tn20ilfPTmHxBLVqmMvXO
         UH3o15XmhZgKj/uF0TF1f1WswWf4yjhvWJnd3qIkA2nrBAKhMvJcTYiSH0xP0Qz1CHLp
         hUMNDvuBTuWROxqxB7TrkaI+g2UlLOtMkQxtvAlm8p8h79pJzEu2wBbtYYQXWkPbBH9I
         9Uaw==
X-Gm-Message-State: AFqh2kqrO7bXAXmbd50kqfaaX1c+lZyUqfMaG4k8FIlXTQzgfaT58pXD
        QYoBiDkZTGEsiBNPs5namQETwPc6TAV8hQ==
X-Google-Smtp-Source: AMrXdXtmjSnTHrGQEHw6VbNzkxfY/pt2X9Tas5/n9E/HJyc3xHf0BuAuSYZ6Gu+13LxzPXvTYPQi8g==
X-Received: by 2002:a17:90a:7341:b0:225:f7b3:aebf with SMTP id j1-20020a17090a734100b00225f7b3aebfmr34765688pjs.30.1672866924907;
        Wed, 04 Jan 2023 13:15:24 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:24 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v5 20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:45 -0800
Message-Id: <20230104211448.4804-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). This change removes 1 call to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index b9d15c3df3cc..da6a19eede9a 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -2141,7 +2141,7 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
 	struct inode *btnc_inode = NILFS_BMAP_I(btree)->i_assoc_inode;
 	struct address_space *btcache = btnc_inode->i_mapping;
 	struct list_head lists[NILFS_BTREE_LEVEL_MAX];
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	pgoff_t index = 0;
 	int level, i;
@@ -2151,19 +2151,19 @@ static void nilfs_btree_lookup_dirty_buffers(struct nilfs_bmap *btree,
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
2.38.1

