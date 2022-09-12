Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632A15B609C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiILS1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiILS0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:26:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2942ACC;
        Mon, 12 Sep 2022 11:25:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so8994968pjh.3;
        Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
        b=mWsacKaljX8MUV8CQf+x9uPNXb4nwg1rqOzW988jKdDxldx2xBwpPizg4HUE3CpOyS
         CZXKfwZl7d7TRsEdibF4COy3CHTtCs9fDbuwKy/fifVJ1Wgwc7dTVk3A2qlzYF1+YqrM
         8u30URko72IeT67j4F37ylnRUZD/Skd/5ByQpr+0jX44vN/bWC2IRka7MCfENYbM9JYD
         72jwWqsS26F/r5BLgNzt2vuVnEfeh6py/P+5GlgXdd1rz/SFRFcCTDhHk5S6n46zAnHH
         K7NUMpASIWQTy8dJGAcYZr2Qd5aoXAfuyQB26U7wlP0wc30bz0T/it+tBSb7KpRupXtm
         b44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VVDEDDCx2d1u9kTxOO3+HYn0Qu0jVDr1kjF69+koZKM=;
        b=I8hTB9JeeYWuC4JXXTGyWtffLNJmTixj6i7xmPk6yEaDNH12TriyhaEGlOLzo8ex56
         TRy7tnZVEbG/fmQXOwicOcmwbF2wRzpKa12hCvKjzLhpZICO/lxPJQ4obWx8dVt1ju/b
         Ym9DFkqAQ2QrAx0sEFk+zmStsTBcZsnAqJVz4nGlQHqoMVwIUS/pdOi5vtw0o3/IYU2K
         PU7938thK5VhIQ9j+UsC9W2tPMNJI9aMpPieYhIR3MAScp597SAgyjYiOB7FVafssi0A
         Q9zbCwbkgl9jbK9qT1oV5SAVN4JALfRKMyZOPxfAxuoLDXFybtUi6w+Rtx/NpjCZNZzB
         Ao1Q==
X-Gm-Message-State: ACgBeo28lbh0rSpyhQ0PXUEDDSiRqrkFXOs5QHFs3zuXd8itKsK7eplJ
        /Dhlg5Ehbu6Pz2tAk877q+RbZnL8e/IqVQ==
X-Google-Smtp-Source: AA6agR7Qn6iVYbgKVLaA7RNhUe092kC4wO4XsubL7Ck/d+hPPUL2KMeZ8CoC2zBbBJEanU/9uLdUng==
X-Received: by 2002:a17:902:f549:b0:177:f7ca:c870 with SMTP id h9-20020a170902f54900b00177f7cac870mr20847770plf.4.1663007141405;
        Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:41 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:13 -0700
Message-Id: <20220912182224.514561-13-vishal.moola@gmail.com>
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
of find_get_pages_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a3c5eedfcf64..c2b54c58392a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1885,17 +1885,18 @@ static bool flush_dirty_inode(struct page *page)
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
+					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+					&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 
 			if (!IS_DNODE(page))
 				continue;
@@ -1922,7 +1923,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			}
 			unlock_page(page);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

