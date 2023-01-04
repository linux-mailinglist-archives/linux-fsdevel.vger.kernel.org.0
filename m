Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCA65DED7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbjADVQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbjADVPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FABF1CFF4;
        Wed,  4 Jan 2023 13:15:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n4so37232333plp.1;
        Wed, 04 Jan 2023 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=;
        b=JiIf52J13fF3RZdd/gu8czce51QuNDKyRmp/RhQBZpiZeU3XEs1WalfwDAIkQP3i1h
         7oaEZjWzR8v45uiToP37QSjLBQ6hFoKkzsu//TvxJBpZZTHSu/Ti+0DB14c/uViJpKft
         LemnBJAU1yNQKcrmO0+Bqi75NqwYHFoh6HrWlcKcA9N4lX0TdQaGXSiQJygzjTysgH/H
         Ppdlz/iLT+f5FltAthrg93ciA4z+S+CmoY6IExMFrN5abl65NskD8ykG3req494jeVOI
         SIJLZug6nx7VJLjV0ukQMkHOfmOMT4MrYPY4bGDi0laktjz8hyQhgyGhNDvAUwE+FMju
         93bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLGgwLr/csaNeBIMYfbH9zx9j3AdiWGm09ROWOa5iAY=;
        b=1cjUiRXnhvMAJDbZAri51xhDDNN2vSXcEpvRIZ17gpmgb7D4qxLTZLG1ixxERZi/ei
         wZlWXJnYrJKZYBSz9p/Zi/KEQPoaw0lHeHLUcIzMPtYkGrHWrUTHe0gL5KIxRmQBzZur
         GqcTUJecroyCdLGSSI/agW10VOxVtCVAsMElQmfvV8JQZVylKUK5Oje1ZDwX9W6SOtE+
         GCLOg78a+d9VaEUYWS5WS4ZSu05MDxTVt7XdsA2ck+DEIprnjSTbI9j5Wv4xB79A2hdO
         7dg931wMsIrrUVk5P/y4auZFPCmyhr7CDX8cQIYyhdmDI7oVqZYz/mvjWPgPBnfyzj2m
         SLmw==
X-Gm-Message-State: AFqh2kqk5UQIqtB0v/hbu84d/6lKRLYSEBvepmUsigbBGdBmcYzX8aMh
        b58aBaTjNawm8CYvmKWMODGILh3hfeiWkg==
X-Google-Smtp-Source: AMrXdXs7s+m/7nsrgJ9l/mJQIpEV7Y/DeAKat3L22TbeUL9zUgX6QTynjS3828Iu+F7/uHuvxs7fOw==
X-Received: by 2002:a17:90b:794:b0:219:64ca:49a0 with SMTP id l20-20020a17090b079400b0021964ca49a0mr53526904pjz.22.1672866923492;
        Wed, 04 Jan 2023 13:15:23 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:23 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v5 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:44 -0800
Message-Id: <20230104211448.4804-20-vishal.moola@gmail.com>
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
 fs/nilfs2/segment.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 8866af742a49..da56a9221277 100644
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
2.38.1

