Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043126019DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiJQU2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJQU06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC357E808;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l4so11810743plb.8;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gcylt+Ee3nnIcC1CSrxmmqTpju5LE3+AXEIgm+aVs4=;
        b=ifFTeoUYIX/JHROqieyQ+/nPZoHo4/h5Ny8eP9EcCFh4S+Q1mIxlVXZQkSCwUAkgYA
         9KrR3+3Jqghr6crVnV6qXc5INX2cac8uDEOB4CkIBlX0YCJi7H6Fc3sAhQA7ybel8BgX
         radNlmHPnhi7yvSSHyVufNNIAoVGamFUYc8iB4p+0wU5MtiC9yP8hS5HKsQycm9b8YNg
         n9WVwFdcyw3e06Lf+T1d5fsIQ+OcxptTreSC0TvliItMIby1Vv9slyllHJAtXAWTKffh
         /zK+Jo5uR/RaB3yHi8HAR+9ZGb6Gmx42SHZYRFWpxY5gPcUdKQ7weGZ54ycWpGG932Ob
         xFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gcylt+Ee3nnIcC1CSrxmmqTpju5LE3+AXEIgm+aVs4=;
        b=v+catqrNJ3+tsmvGxAK/CBebo9+AjUQlcNpF6XfvzOn2jE9r6WYDYoHJVXwAZm5hQQ
         57d7OASFTQIaf9jwUJ2BDFQO6fqOQ2GmmDloCjSjffdPV9I/2K7yuvaLUXAneZvVoKme
         Yg7rpNQMUuw/7amwGgMnAjBljPD3BNNUvxuwjaxJ8t2zuxPRZDvtg1NBmYGMAoypL5me
         WUqHdDgKtI+fnXTYd7jt0Mk/LvlqWcJtJNGX5YT2SmW5SeA6ri1SRmmJRWiRB1IyC/Xc
         IUbg1/U3XHS1vrLrX7I18TC2z04pL/uoC1hZmfF8eFEs2hJ+GwIr6iwkvRXhVhRERD+8
         2t/g==
X-Gm-Message-State: ACrzQf1EWNthdGmfUbv+u+K7q+FajXvW8c8wnpMSQkZGcX55uVonCUYm
        mDWP8zwobKPpBIOjE0gJJGiSRIeQ9oijpw==
X-Google-Smtp-Source: AMsMyM55mBmGZvh6IbugVkyMm24ikb9Ki4AcME5alKIBbSUj7cUwzp+XBBbkyaoL4qf34WBmEzkofQ==
X-Received: by 2002:a17:903:2306:b0:185:43a2:3d1c with SMTP id d6-20020a170903230600b0018543a23d1cmr13740880plh.154.1666038304993;
        Mon, 17 Oct 2022 13:25:04 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:04 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:39 -0700
Message-Id: <20221017202451.4951-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
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
---
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 983572f23896..e8b72336c096 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1728,12 +1728,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -1742,20 +1742,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -1821,7 +1822,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (ret || marked)
-- 
2.36.1

