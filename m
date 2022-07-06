Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636B567FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiGFHVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGFHVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:21:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD16222B1
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 00:21:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fz10so8327512pjb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7a7Y+6jr5ZwUZ6WvwAquFeABtrF1uAciU7f+lU8n22Q=;
        b=VYDnxYFUWgFb/27vnlsD7DaTdslm8RlPJIzcwtqMS8WSPdDztdQxVz7XRr+j0BTlkC
         hVZEICODExm8q2WoBy+i3aRjR1ikJXfNq9peMjYValNZWBoyeoO54RuwaQdtaFn9aeL6
         mZUYZeo9ESiOrLq40+ElYUE6hkclH5UzFD4peXnFLDmcD7+hCCWQwgBKNZoxRMt7C3ju
         DBIVE1714vOHMx7j7idcOCnT+v3iArTUN0azjFCOcSEMXQ5IDHRFv3JsBmYLqAcXOPqu
         6wMGHVRu91eWlLNl6P1LNGduTcip7v0SsUBZdxJrlsNn+Y4O4SIbnB2NUcNVMwGkaUNd
         PTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7a7Y+6jr5ZwUZ6WvwAquFeABtrF1uAciU7f+lU8n22Q=;
        b=kqF54hY8LE4qnNHJsU3Jp4L5duS/66kzOcNZ34kT1NlOaNbyK22SlWoFL/4625MXZE
         2UaocqAfeQJ80hsBzT6EHPHN64USHDlWc4bO46BvDPskHzTZZG3HBe0OED/TsTGv41rI
         2Xw7h0ISgY5IfnQxU/hAnVaU9wUw3nrYtalgYavZwc47laMOyIiBO9843CRGBcQHUxj6
         /NTKNzbuely/luEKZ5eQqAib0fHr4ZM9rvcErCp7dXDYUeNJForNvegHMAOPd+B3XEqu
         VUO+rWXEGRrNyrAk5SjECmhIW6CaNbSbqkg2RDtOgqcmk3J9xwlMuK1YMisZCQngF1ox
         24FA==
X-Gm-Message-State: AJIora9BonvfxjQv++I/RJ3kedLl8hJ7oSL6P84q0pSXBYmLTHkUxTt0
        i8E85AziDr2VLP8KjxmwJ0/CoTUsblw2LW07
X-Google-Smtp-Source: AGRyM1sbssoOaUq1VNLIamLlJuIQG1wz7Hd+IucG1jkW2y2CFoKVN1TqDJ3CFfPt38FgT3BeWzYoJw==
X-Received: by 2002:a17:902:7582:b0:16a:307a:5965 with SMTP id j2-20020a170902758200b0016a307a5965mr46379635pll.159.1657092081080;
        Wed, 06 Jul 2022 00:21:21 -0700 (PDT)
Received: from localhost ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id ne22-20020a17090b375600b001ef899eb51fsm5780187pjb.29.2022.07.06.00.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jul 2022 00:21:20 -0700 (PDT)
Date:   Wed, 6 Jul 2022 15:21:17 +0800
From:   Jun <hljhnu@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, hljhnu@gmail.com
Subject: [RFC PATCH] exfat: optimize performance of deleting a file
Message-ID: <20220706072117.GA29711@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a large file is deleted, it's cluster bitmap is cleared.
After a bit is cleared, the buffer_head is synced.
A buffer_head can be synced many times repeatedly.
We can clear all bits first and then sync all buffer_heads.
So each buffer_head is synced only once, which significantly improves performance.

In my test, It takes about 2 minitues to delete a 5GB file without the patch.
After applying the patch, the file is deleted in almost less than 1s.

Signed-off-by: Jun <hljhnu@gmail.com>
Change-Id: I7637032db04042b8ad1ca73fe7db09d43a253255
---
 fs/exfat/balloc.c   | 28 ++++++++++++++++++++++++++--
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/fatent.c   | 45 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 579c10f57c2b..58bdfb58bf1d 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -164,7 +164,6 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
 	unsigned int ent_idx;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct exfat_mount_options *opts = &sbi->options;
 
 	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
 	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
@@ -172,7 +171,32 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
-	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
+	set_buffer_uptodate(sbi->vol_amap[i]);
+	mark_buffer_dirty(sbi->vol_amap[i]);
+}
+
+void exfat_wait_bitmap(struct inode *inode, unsigned int clu)
+{
+	int i;
+	unsigned int ent_idx;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
+	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
+	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+
+	if (IS_DIRSYNC(inode))
+		sync_dirty_buffer(sbi->vol_amap[i]);
+}
+
+void exfat_discard_cluster(struct inode *inode, unsigned int clu)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *opts = &sbi->options;
+
+	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
 
 	if (opts->discard) {
 		int ret_discard;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b8f0e829ecbd..1ecd2379022d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -409,6 +409,8 @@ int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu);
 void exfat_clear_bitmap(struct inode *inode, unsigned int clu);
+void exfat_wait_bitmap(struct inode *inode, unsigned int clu);
+void exfat_discard_cluster(struct inode *inode, unsigned int clu);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index c3c9afee7418..f39a912a7da7 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -183,19 +183,56 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
+		sbi->used_clusters -= num_clusters;
+
+		clu = p_chain->dir;
+		num_clusters = 0;
+		do {
+			exfat_wait_bitmap(inode, clu);
+			clu++;
+
+			num_clusters++;
+		} while (num_clusters < p_chain->size);
+
+		clu = p_chain->dir;
+		num_clusters = 0;
+		do {
+			exfat_discard_cluster(inode, clu);
+			clu++;
+
+			num_clusters++;
+		} while (num_clusters < p_chain->size);
+
 	} else {
 		do {
 			exfat_clear_bitmap(inode, clu);
 
 			if (exfat_get_next_cluster(sb, &clu))
-				goto dec_used_clus;
+				goto exit;
+
+			sbi->used_clusters--;
+		} while (clu != EXFAT_EOF_CLUSTER);
+
+		clu = p_chain->dir;
+		do {
+			exfat_wait_bitmap(inode, clu);
+
+			if (exfat_get_next_cluster(sb, &clu))
+				goto exit;
+
+		} while (clu != EXFAT_EOF_CLUSTER);
+
+		clu = p_chain->dir;
+		do {
+			exfat_discard_cluster(inode, clu);
+
+			if (exfat_get_next_cluster(sb, &clu))
+				goto exit;
 
-			num_clusters++;
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-dec_used_clus:
-	sbi->used_clusters -= num_clusters;
+exit:
 	return 0;
 }
 
-- 
2.36.1

