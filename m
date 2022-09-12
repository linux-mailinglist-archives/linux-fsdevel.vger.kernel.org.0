Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1255B60AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiILS2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiILS01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:26:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE30422FE;
        Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d82so9421306pfd.10;
        Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=;
        b=kUSUqB8dlabq9sW6UND7hIVWrf55QnN41yW1Ws/gSxB38+4EodjnI9LsYaQN1pMaEt
         vcUQu+3f4pKT6w51/iF50tVvuObtbeMnKiwQt2oaCHK0gcXc/f2dB9h7DKEPuXJ7HWdH
         ZpLw2vnH5B7/bJKVQmKAt6vtNrGedmqEMuaUbzJZJfle4i//kAsUvgKl5LdIzfZtaNMY
         5bytt+NGi9rmXEbPiSV9YhrOUqEtjhXJLdcRdwYRyjRlbha9Ca93KomE9khZSI37XP4C
         sblgMtHoYQcnK1+RtGWvytNWIig/lb0LSKVXD+DlGvOgL2nsC+H3kq98z+0KLkWxnnHN
         pyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I3QciEP4mJX7JM2ray9Wq2x1rxYKyHsz8NamV9Ya2AE=;
        b=SU6zLIZcwipB7X+jgbZVxQ6eSDvlH76SpzNce88fXTVKLlDIP79YG/HwuZ3Thj73CJ
         tb5pZ+Yrhf4+kNSCZNQowwoiQvhFyqMdRNiFuy6xC+cajgxK+8MqFh1oqf0wItdg5gbb
         +qCXVYVgxTFDbz8LG07JGQRssGaQgoYttloELNY/PoEU3iJh6/RD8DvfZ8/ihdOYhM7/
         U8I4e+2BQBvUeigKkaIwWyDcsNQoL217LUAZnWMumXKaNQ5VTjxyw5XaisBRB1T3MiSo
         oRFEQwK6rJktoiWbM5p/za5UMKmiiOd65t/Glu7GI0zruD0FUnj0kJ9UmzJvC41SS8xV
         x3zQ==
X-Gm-Message-State: ACgBeo3ogt0pk+CqY/B/BMrrKieTYFha+Rvk00aiSyxKHW4gnEx36kje
        5ZEzg/mJUbRoRMbKwwYh5HYwJK2I+ujiLQ==
X-Google-Smtp-Source: AA6agR4xhmDo2NN925j0731w9UHbCazwEGTp4E0/3zUMlL+kHDi2lzVAs9T0G0CKuZY5yreG8GKchg==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr29359093pfi.44.1663007139855;
        Mon, 12 Sep 2022 11:25:39 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:39 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:12 -0700
Message-Id: <20220912182224.514561-12-vishal.moola@gmail.com>
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Does NOT support large
folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e06a0c478b39..a3c5eedfcf64 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1726,12 +1726,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -1740,20 +1740,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -1819,7 +1820,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (ret || marked)
-- 
2.36.1

