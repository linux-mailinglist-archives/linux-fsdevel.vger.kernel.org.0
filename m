Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25795AA274
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiIAWGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiIAWE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:04:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192694EE3;
        Thu,  1 Sep 2022 15:03:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj6so281229pjb.1;
        Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=;
        b=gUm8S346I3K4ORq4miRaGKQWrBRZuwaXck/yvUpzoYTdcWhN98CW9jDruatqJgoZRb
         Qr7AVjxZmulo+5f9KMRw7o9SzO4VVVP0E6R5Fgix1Tba0Tyc9gA4/EjPT0MKD3o3ubc2
         vB47B4Wkmo9W5esV3vAFQYuGkm6R+OQ7uA08pjBivhfS8LGFryls97UPR15F7iPOmvl2
         dHyicbyty/5LQkxTuojwAF90zrZpQJynSNJ5hxss6FcgzCzxI5JO1ptQdUHVZCAWmElB
         t+fwz3It0ogWy5Uf628XzRjlYTQ/0YWnLDjVYm3aDd4wv+omRXtHPDbeL0giXBfgWA+5
         lhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hDptbc18eb98tE8iQjyPGn696c4/GhyznW32HiLxniE=;
        b=fdUPOIjX00ia/qkl1DzD/lKyKo4poV5x5CPk1IdjLjO0iUJelGS1JfYycouihyLVxB
         hLTfajDcP2zoVo4WXYnRv0vCEKhg5jaPO1V+AFlYbcOyLwKKerthX4J0Ww5mTry1gy2G
         9JjGoxTNnFXy3G82yM07SouEC0Oq2OACpLUiO1HPIZHb8ugJ0WelOhcWiT7GdhyMCnXU
         q71IG3fdvZaruxfSs8hkE7FcduWV/GoUdnaO1cEd3wI5/LCgex0UNGyxNgEj74SJ7vTs
         GfJZGts6FQVnvejSwHPI8uIpK+EsZg2fnIQKkrIAGyQLv7u9pNVRQkHB7OcKBoYCQOQP
         RrmQ==
X-Gm-Message-State: ACgBeo1M54NjdZRvkd3A5jKSmu4F93ilF+fVyNzE4Ev5o/65jLFBE+r1
        EAd7C3AZMligxx71yRINgqZoieTAPYBQTg==
X-Google-Smtp-Source: AA6agR5IeTCiSE25gUAjMIUlyuAb/ATe40085kNlIdR9XrP9KH+/bi+PEVrsNM55mfWzwEZYZhZwXQ==
X-Received: by 2002:a17:90a:8581:b0:1fd:62e0:67cc with SMTP id m1-20020a17090a858100b001fd62e067ccmr1336794pjn.144.1662069783338;
        Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:03:03 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:35 -0700
Message-Id: <20220901220138.182896-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

