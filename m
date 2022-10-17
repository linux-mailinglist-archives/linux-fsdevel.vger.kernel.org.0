Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60E6019EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiJQU1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJQU06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A07E80D;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q1so11430414pgl.11;
        Mon, 17 Oct 2022 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6ErMtYFOLSC+XFSDnhR16+VnHSa+A9yG2wppqURV6g=;
        b=cCPZ3LZeIepzgHQo38JmLKd16CRdo+2iAtbuM0GeXbYUQtLEwsFysyya7MYzHjocpg
         9H9ib+VuWdRu2d7bK5i8paQZGdzHkJ1SWJG7Dh0Ca6BqZhTE4s9Bd6e7ntf4YGC91R/h
         UgFC41Q0Q/xhD+8z+10ge1J4agN3xgWHAKXVd63knIgAcRcmNhj/iSTo20LpGHMF/9aA
         NbK4DCkGcpGDuZtGOnbGMumQl6ROrfsEwEfIgs8chmDRZdYYwSRrxiDodPpn4T5dlrkt
         VNzn2lVkELDr1gtJA0x7iwQCGF5ya7VDbUQisTDDlMqMXif/Z3VL8W7KPwnE+fu1FxM7
         QosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6ErMtYFOLSC+XFSDnhR16+VnHSa+A9yG2wppqURV6g=;
        b=BsUnnEUPApSrbyAN/IkmdqA6A9gtv4dXg4Vk7xvTvRBm5DckvAVVT/UY1UGUtF3bx5
         cFlN/+XQL/rkXxheuLX/QR8rdDBRJEBcFZNSQ1tg+yOE6+8HcLYuQO+XgnyVx7QkH3Fh
         dpr+1XcxRGXbpC/Yk0fyQJv6W2yfmFyRRIjKa/O1gmFXOAzSa1ElGKaqwwz9SUFEzrPP
         xBF74vZW94TWHRqbVKbXqAVNNrrtBI7YEfPtHP2p2zSC1y07rGGGxQqrHNs0w/5N6Xqg
         qpPlx5carl0v+Tz7y/9zgQ9X3COegnBZo5pzqrjHWE1QPMX2Rrnf30jzo7Ayd4Gd+uf8
         pc3w==
X-Gm-Message-State: ACrzQf3W1oPZ7P8M0Zk2H6bA9t/s2H89oA1/PtgoLbDb+LZyNJIb3DER
        zdkVoCw4LEScoTxRliZsEz8TVftfNBf2Zg==
X-Google-Smtp-Source: AMsMyM5dwvFL/LmsuIkwQu3OP5WD+EqvGKYBix16mvgoTXBrNYZig7nSszRgeBhz/RAGO3jgcp6Nrg==
X-Received: by 2002:a65:674e:0:b0:43c:3b91:236e with SMTP id c14-20020a65674e000000b0043c3b91236emr12225402pgu.510.1666038306213;
        Mon, 17 Oct 2022 13:25:06 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:05 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:40 -0700
Message-Id: <20221017202451.4951-13-vishal.moola@gmail.com>
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
preparation for the removal of find_get_pages_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e8b72336c096..a2f477cc48c7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1887,17 +1887,18 @@ static bool flush_dirty_inode(struct page *page)
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
@@ -1924,7 +1925,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
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

