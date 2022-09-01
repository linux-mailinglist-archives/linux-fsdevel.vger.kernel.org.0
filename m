Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE25AA28C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiIAWHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiIAWFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:05:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F89F1B4;
        Thu,  1 Sep 2022 15:03:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u1-20020a17090a410100b001fff314d14fso354413pjf.5;
        Thu, 01 Sep 2022 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=;
        b=g6fAyp3iJgf3LzmTu5bD5zWTZ7od9i2yk9cu47djS4LzM5/vaCauETEa79FJPDbfwN
         cLdqlUh9d8nI0Nm+LbuAhIItiLNmHGfoqlGAYhSfTiRw4ljsDmSdVadB+3m2xO1TNUJa
         0nuVGnoNqQQoLmodKszRhMXSnkLvvjZ4R3brnkvtlDRm/qXRnT+DMRacWFesHhTBBNKc
         0V+89RIxZ0WLehbpnGAbTdJ5uOSPOqVqMofTzLN0E95dgYKuDPhCGssRW2KFzlTQQNsi
         D66yCF12E7iDcZecg+ujt+pmVYyoJIOMaXlKUD3A3/5c5nIgJRrzLjZgJB8I6DmUxegn
         s9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R1s+Q+mQAi/BIrt6gOgtRlGYE9v+cGNlC5URnwM67nk=;
        b=wAwheg8L5Zew79laPnd99Jfs5Ey7q4ez37ymFeptbtm7ar33QdKVPsvlmCLVC0mJ08
         aEVeEyAXc2Gu9lLaWu/qa4FJ9l/29R56HT5++KoCtT7EPtB+kr7fPtoiXsrRVGlgrnFh
         hmQAJtB/Y3YuzeTfioa4bHmcC7NexGVMPoOtoDAbdrT0PdngvU3h/aOx+bzuZvnYU1mg
         ygA3oDBkMTOTSplp6a408APy8/I4Q0IaSxA/A4FgIlyArXBsMcYWULI/147viGpdPbCA
         nCqN05G79TR3w0VQidbcCqmDwP7Y/L2Amt3ZcviF6maPQwD/LN66PVQhGnltyWxnyMlF
         7KnQ==
X-Gm-Message-State: ACgBeo0Cx3HSs7TbJLZH3yD6YVLkfF4C5SqTdGxaBo7iXjtvJ7xEbORP
        xbCMZbUYtvNaifnifZq5rIrqDwKS2e7FFA==
X-Google-Smtp-Source: AA6agR6TsbdMkmC0TPigfGG4lOziD2qdPKDR4aZqEoxc5g1boqEfjdmsGUoCDRdXOVT8V8NL8wfwag==
X-Received: by 2002:a17:90b:1bc4:b0:1fd:b913:ef58 with SMTP id oa4-20020a17090b1bc400b001fdb913ef58mr1275606pjb.220.1662069781924;
        Thu, 01 Sep 2022 15:03:01 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:03:01 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:34 -0700
Message-Id: <20220901220138.182896-20-vishal.moola@gmail.com>
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
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e95c667bdc8f..d386d913e349 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -737,20 +737,19 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	struct inode *btnc_inode = ii->i_assoc_inode;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	struct buffer_head *bh, *head;
 	unsigned int i;
 	pgoff_t index = 0;
 
 	if (!btnc_inode)
 		return;
+	folio_batch_init(&fbatch);
 
-	pagevec_init(&pvec);
-
-	while (pagevec_lookup_tag(&pvec, btnc_inode->i_mapping, &index,
-					PAGECACHE_TAG_DIRTY)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			bh = head = page_buffers(pvec.pages[i]);
+	while (filemap_get_folios_tag(btnc_inode->i_mapping, &index,
+				(pgoff_t)-1, PAGECACHE_TAG_DIRTY, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			bh = head = folio_buffers(fbatch.folios[i]);
 			do {
 				if (buffer_dirty(bh) &&
 						!buffer_async_write(bh)) {
@@ -761,7 +760,7 @@ static void nilfs_lookup_dirty_node_buffers(struct inode *inode,
 				bh = bh->b_this_page;
 			} while (bh != head);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 }
-- 
2.36.1

