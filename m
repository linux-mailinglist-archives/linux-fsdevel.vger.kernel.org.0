Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF265DEEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjADVPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjADVPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DE1DDE5;
        Wed,  4 Jan 2023 13:15:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c2so9657103plc.5;
        Wed, 04 Jan 2023 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH5uknizJ+VZ3ByJbVZj3rNFJAjGpaD6mNiQZQbwTDM=;
        b=HbtlZrradnwPMjbOnk5CSSrEWLtsrycMj6Tm30jqV76XWo9P/G6G9QfGZXA3hEuuO0
         yNLMx+3+R2fxnnyrSrsdtAH0YAmNGiTL388KwyzROfoONWg1jTa9Ux254/uWey0xofFS
         ZcN1YVGa74THrAOxSXWb1EhxG2YA/LskeaMec+FBsOyEUefqmBI414yyRv7F6qtfnFnG
         AKTzOXJ+X4W+hyL+EGENc2vkpZu+8+kQREVxb3SQSXSnUiBROYLOIlwHYGmrLdygYais
         EBeKayC0rdoQzyAgQz2uWHzmW86g0Hrl3uDZm7ONl8JUgVLCxAkjfMiNh3ua3ACkBAqv
         sniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH5uknizJ+VZ3ByJbVZj3rNFJAjGpaD6mNiQZQbwTDM=;
        b=PiHm+qGU5PiD/fenLezVaGpPhIN2EBl5I9+obaGck3ALYh0D74fnzvF3ZHfOafpwQq
         Uq2QqYrKi1OKpC1oDFOiMqpCpD/nOVtdXOPVQm91F1pCX4i5V/iuZrKHcTZC24+DXisB
         NSTqO4jBP7rEnmKIzCcE3+5jI6czfqbpEMI5tDFrkuqO4l7NTwk03qnpmOK5hjVIvhdn
         wAR2anNQBZX+LkeKsiK3iyaltQh+bIYDoHs5JLPSCZLd//hiwO12GM3epPkw0Yz/Ismi
         n8aqSgaqrRIEgMY+8c+N/Xh9Wvndk0KP0YiqZ/2LCRRDfDisgZQPB3xWhLg5MI3gSRfx
         OdKQ==
X-Gm-Message-State: AFqh2kpr6Q09KV5ZthjjxdBraCK/crWsGBsFTIC5KMksv1v6Fb329ElJ
        pomkAustyBYo77rBK/xmIDDmgOO19AaNaA==
X-Google-Smtp-Source: AMrXdXtVQz3vUnk6SvLBb/uxtWWFs3KjCzby6fY2kylk/nf26hkuu2Sk6nOiS0bo0LRTvW+QMbKhXA==
X-Received: by 2002:a17:90b:520e:b0:226:ba10:14e9 with SMTP id sg14-20020a17090b520e00b00226ba1014e9mr2765079pjb.12.1672866911945;
        Wed, 04 Jan 2023 13:15:11 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:11 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v5 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:36 -0800
Message-Id: <20230104211448.4804-12-vishal.moola@gmail.com>
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

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dde4c0458704..3e0362794e27 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1731,12 +1731,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			unsigned int *seq_id)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
-	int nr_pages;
+	int nr_folios;
 	int nwritten = 0;
 
 	if (atomic) {
@@ -1745,20 +1745,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			return PTR_ERR_OR_ZERO(last_page);
 	}
 retry:
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				ret = -EIO;
 				goto out;
 			}
@@ -1824,7 +1825,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (ret || marked)
-- 
2.38.1

