Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79C6167DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiKBQNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKBQMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:12:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD222CDFC;
        Wed,  2 Nov 2022 09:11:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2314597pjl.3;
        Wed, 02 Nov 2022 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=;
        b=LzbfvJ+o7+PPEWAo4w8AKJBmrzmPbRkBu3ORC/K7IBEBc4H7+EY6jlr3kPMKdC+kLo
         AmeRyK5Dh8JnM5M6037m8XCwwaveHP3T1zWfXQL5PNN2l8Ar7mvAlRUfGrHxX9l4CAlx
         lo3QVGXXrSxrr9dWf3dkPnZsG+uP9YkyrIkUspxdhnyIO5H9xO3I2khrWtyjrsb3beRJ
         4OTNnGP/tYO4gLRsXwP7dLPwn1T8Eyszj0QvmzUxq1RtDQ9iIk0vaxsCgNdXJmRDiqCT
         sM3lyaFW63RiGf2IUhiE4Hi5Q9YJbodgMXUOnMDzbZK/PBDDWhOYiUrWWg5ys/RBXgc/
         FTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDRTYxfyvxtJ8nlExLPdZpgWJ/su4BLXKUXaNb8lkhE=;
        b=W2+Z41ZtdW8kROKbKYrIwMkBJx+Dyr8rM5jodneFYxJdLa5gEJFg/i8+OBX1XWoQQW
         howLvnl8d0uCFy2aqQ25mtJ6905RQfll8tdQBU1iEMLlGl5+BymWsVZcAybqGvgFuT90
         QgkqyfQh2B7KVU8JhhbDDNHS1iATYXfz+oZlVsdprwZLu1EDNiCBamiHJIcDE7Mgcv5H
         9TWDGG0L05/lUH14a+0I5DPH6PLWWVM7klVy+DvmihfzSw1iqjE8SCsAXYuA0T8NigSW
         6eRewBKtvWaq4rb1INvwT2OPcR4Jxy7MaebDdVRV6zxlQqTh+kUConKuGW2UrChAXXGm
         lKWg==
X-Gm-Message-State: ACrzQf3V3SRmir4XxPJXpodxiJnwmUYR9otpxVjThACxKjhMWrixqAjC
        RX52Tu5OPyBgFQNMJDxR2ksP2ntxKfru5w==
X-Google-Smtp-Source: AMsMyM5Gg7NNdqkkD0qRog5my+HvLc2ALPLnjteIt7psDYOA2pBRYr6Rk+9oY34/AO+uIwffHowUkA==
X-Received: by 2002:a17:902:e5cb:b0:187:2d8c:a4fa with SMTP id u11-20020a170902e5cb00b001872d8ca4famr12910612plf.151.1667405495543;
        Wed, 02 Nov 2022 09:11:35 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:35 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v4 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:27 -0700
Message-Id: <20221102161031.5820-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
index 2183e1698f8e..fe984def1b1c 100644
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

