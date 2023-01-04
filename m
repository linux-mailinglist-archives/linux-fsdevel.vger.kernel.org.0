Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700165DEA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjADVQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbjADVPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB361CFF4;
        Wed,  4 Jan 2023 13:15:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c6so3995508pls.4;
        Wed, 04 Jan 2023 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=;
        b=YYuOdit3NxbNrQLvQKQzYy9fInjz8epNnsAie9l78qOZwItZ1q9762RHvdjHvn0w3T
         Itev/qVCegvvtOsHjlnt/i8oYcY6s8Pbft4yn8UlU5hO8ANcihMCzw6L7clWMBVNlkml
         DdVTstYmIe6uBY+QKphA7A0vNicwDIZfmnlRaGywuDcd3L/Dz6ksmUjm69PNaduiwT0y
         oDarQ2Aeh8wlIFX7joZPiMSA82+zZJyehOMhZmZgTN7kokD4EtjK7YG4/3QTFsugmOWW
         sUQ8oex28ZiETO1YVZLLNiEuF950kwCKMCnU79wH/Yyl7cH+rVKP8QdTlOWRApZ8hx1s
         Ciew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ+AsMarClzul4w07hpaKmVXDP421VTrEgQP9XGRZto=;
        b=65avntmBRV81li5g5wp4BUrKrX+lDuThyPU0XgC4OcvkU9a1yu22tNkGeTyMctAKcF
         4XJORb0v98MHaqS1a+a7Ir+DniRlWNWolv8lV2fqN6Q+G6FPjP5W9ovKO4iIKog9SUtb
         U6KoPKAiYdm8E55UOMyhZj/zlIkRiOAgsQsw1uJadSauMPhhAVeLw7aiJByITwUeoe7v
         +ygTxWff+n1oy/cO6pu9dLWqMzc0nOdGslFjmrO9Ul+lbiAOcag6h/WHH15KrfKRsF9q
         6+NoTakK7CnO6vLFB8eybX2jEEtcsGeNFiMC5CIDO89HWlr+A5w3QIs6x9F9XJJuWXIM
         mzsA==
X-Gm-Message-State: AFqh2kr6hUf+o0wbaOB/UF1pjx2AXxxKzr5FvJui78JNc4fXtdn41tW+
        pNTbbelsVAO3tQZ5E3CTx4/BNhSJ5zJn2Q==
X-Google-Smtp-Source: AMrXdXtdY5GUpRFH0/rWB1ui6dE4PdO42I8quQD8+H41n2qV43RNlBpjdfLglYXYOXUh6D0WzIQFFQ==
X-Received: by 2002:a05:6a20:429f:b0:ad:bd55:6dcf with SMTP id o31-20020a056a20429f00b000adbd556dcfmr72875976pzj.28.1672866917539;
        Wed, 04 Jan 2023 13:15:17 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:17 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v5 15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:40 -0800
Message-Id: <20230104211448.4804-16-vishal.moola@gmail.com>
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

Convert to use a folio_batch instead of pagevec. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 51e9f286f53a..cf997356d9f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1518,23 +1518,24 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct page *last_page = NULL;
-	int nr_pages;
+	int nr_folios;
 
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
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				return ERR_PTR(-EIO);
 			}
 
@@ -1565,7 +1566,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 			last_page = page;
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	return last_page;
-- 
2.38.1

