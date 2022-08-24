Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75B59F05A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiHXAmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiHXAmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E6086044;
        Tue, 23 Aug 2022 17:42:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo18829866pjd.3;
        Tue, 23 Aug 2022 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qAIZUZ0pgScRmQa0duFh/+V4CGm9o36zgCrAtR/Z4DI=;
        b=oI3O32y9Nc1raAftWQD45HU0GA4593iugYPxYzJPeePQFlHLBee2vueXj2ulohnlGD
         0apI5Vd2fXUvaSfIfbhGlpXWV8qX5pAShMjdTMdoMsZPlf0qnMkxYf0Mt7om59P/zn0D
         nkf6+QPwhFNNcbPSMmPiebGNWB5Fyut9TU52gVuzsPb0lqdPHa06BWertBwZr/3AkyLF
         6G3GMlyy5cWyGBlHl/U/aIJUlygwCrZndzi8pl6TFqpKdhcY0snfUl3PeC/zdS/Z90cK
         XGmdiXzwyIPV20FBVatPpV4QZVBMlp43v26aUh+bcTSoSOOt++Szi9rUHP6iiXXqbfVr
         Ntuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qAIZUZ0pgScRmQa0duFh/+V4CGm9o36zgCrAtR/Z4DI=;
        b=arjb2gi4oHi9W4mZKS3hcPYcLkXlPYfgBBDuofSjGJ2gnN3K8RN1Uvc9xyK6a2VVsK
         rubBLFN+Ston/wzfMwQAcOidYwP4/gfhSfRdSxuUpzyhL8hgsvZw9T8fJYsoW0hyCDUR
         +AiFHH2hRCHtE+xNjdVS98qARKlyRHFRnyeA+gbAqGakOfacemqnTitbZp+gOtVHH6xK
         ke0C+aQfjG+D4Bk26iC8vevDLjRcn0K0ggJPh7JL09J/bf5mjhj2Q62SeCCcT+CH6Szl
         x8TrJdkyWT/ye8G6C2i4Y+wDoated1+sPVPcRD1hlRvg2NxEJ3Ayo8YUd8wwS932pIFc
         6eAw==
X-Gm-Message-State: ACgBeo2pMkgTy7GLLOstbL3kbYfYeCkXYr3p03TIKANTt7fqrDCAXJuV
        K4P4HMCfyENmYY+kloitVpVDS4CyN58GQ54u
X-Google-Smtp-Source: AA6agR5llaHTn279DIwEZUeEMnW3NXj8vtX5ysX6JUk/8qA8xgTynGzMRCc6FPq/y4eEsBnNCo1oEQ==
X-Received: by 2002:a17:903:22c6:b0:172:cad9:403 with SMTP id y6-20020a17090322c600b00172cad90403mr19905404plg.123.1661301768634;
        Tue, 23 Aug 2022 17:42:48 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:48 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 3/7] btrfs: Convert end_compressed_writeback() to use filemap_get_folios()
Date:   Tue, 23 Aug 2022 17:40:19 -0700
Message-Id: <20220824004023.77310-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Also this function does not care about the pages being contiguous so we
can just use filemap_get_folios() to be more efficient.

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/compression.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d9..e0f8839cdd94 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/time.h>
@@ -339,8 +340,7 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
-	struct page *pages[16];
-	unsigned long nr_pages = end_index - index + 1;
+	struct folio_batch fbatch;
 	const int errno = blk_status_to_errno(cb->status);
 	int i;
 	int ret;
@@ -348,24 +348,23 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	if (errno)
 		mapping_set_error(inode->i_mapping, errno);
 
-	while (nr_pages > 0) {
-		ret = find_get_pages_contig(inode->i_mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (ret == 0) {
-			nr_pages -= 1;
-			index += 1;
-			continue;
-		}
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		ret = filemap_get_folios(inode->i_mapping, &index, end_index,
+				&fbatch);
+
+		if (ret == 0)
+			return;
+
 		for (i = 0; i < ret; i++) {
+			struct folio *folio = fbatch.folios[i];
+
 			if (errno)
-				SetPageError(pages[i]);
-			btrfs_page_clamp_clear_writeback(fs_info, pages[i],
+				folio_set_error(folio);
+			btrfs_page_clamp_clear_writeback(fs_info, &folio->page,
 							 cb->start, cb->len);
-			put_page(pages[i]);
 		}
-		nr_pages -= ret;
-		index += ret;
+		folio_batch_release(&fbatch);
 	}
 	/* the inode may be gone now */
 }
-- 
2.36.1

