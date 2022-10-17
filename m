Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBD601A41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJQU2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJQU1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:27:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37077DF6F;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 67so12111231pfz.12;
        Mon, 17 Oct 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=;
        b=Qk4yM75otecrzeUngFuKVCGaeUXfETNaFI0p6N/nABjpdCTLoTvjKNLJZ9OllX2bwP
         +U+4YR9Pv2UlaBNn4Ln/tBqDVA5+5H9uo8/ty5z3YSkoXkt/t+1/eR8X1FXv4Ci+T49/
         wSVeFfxPMGrcmtuVOElrygDRrVNHoyFvAO+52XX8XFX3fZxBUKvCeAeRlBBlvxD+jYUA
         hW/fboSfjF2JsTe1GHEut4uWvlw1NT8ZvKkfI2RSo40rbSyNsY3uBQc7Sbd/6dY7EIEd
         1BRYOETZSIBmP7Zq93eqEum+LCrtx8kl0OnMaxT9yXrWMw3yXtWBRbeDNWR3Teap7EmM
         YJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjCPDi1AZDHrB7VlRdP/cqyMu6n+VbdajeULasyuImU=;
        b=GnQ/qLgZIcDrHc8ZAzeCAzEj1xM09bz3XXJI2WN3MOq19yZcuE1yiA7/T5uCof1588
         wOwIOx4USWzeM8hHmaxDPXPleC8YAveRTELc+JQr7d9bAKoH7as3eVROhnF6BrhWX54g
         At61z+I01OIE2qZ/B5NzkeM45M+1HRRQvS9veqKj1+nrpyhtl0aaA7CWwYExlgIaGCgW
         lIOkitEn1qTbk72CJUUlf+CMF+NTCgExHJJeFdtecZD586tJ2wIIku+A8ZthFYZpZ3aw
         jCZu3eAoqczWDndyaZi7Iqoa+CIgXMiDbSD8uQUCCzW3ZvKWyK2MnP2kbqUe0lFwQa/z
         hQhg==
X-Gm-Message-State: ACrzQf2PwoarJMefj74RyE2f1Z8AP9t7cIr0OLVaYEI/4T9rAVTXZLEc
        ts0tgsjjX3ac2QUqpj5+53mgEFmh2sKHfw==
X-Google-Smtp-Source: AMsMyM4ObH7Ae50qNEBFYILKD/38ZVBDIyWh1WqZ5jC4uO0xoFWyIhzUJ8Q8K2qEcR3Aa5uaxx2opA==
X-Received: by 2002:a05:6a00:194e:b0:566:5da:ea67 with SMTP id s14-20020a056a00194e00b0056605daea67mr14416761pfk.77.1666038312970;
        Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:47 -0700
Message-Id: <20221017202451.4951-20-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

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
2.36.1

