Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF542593B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiHOUNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiHOUJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13AA83F1C;
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x10so7125110plb.3;
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/3WdeuCJ7GOu9Di/kxGE5ZGCTP43O1pORgSps3IpIM0=;
        b=pzhH71/RORsENTBh74vzN5tqqZUKFr4QVYLeRWr9RocyL7OZKiodwsp21TGAG95MnP
         dsuAJ49JcqdqnfiQ/krxHAJW/NtnLndMog8nxsvyC2oA20RPu4/6P6mDM4v7uuHosvVH
         pT5ae4HmStn9CqdvdQtc2KGE6WbjIPCG3FCvuooEIPPs6GLaeOdlD3rRWGmVbQl6FVff
         Nzqo8PGtzrW7EDcHQrvUe2tpoWaUa6xYETFR7d9fAzFnv7Bbq3TYbrJwUFNVcLqbYKyj
         NC6RjlEpmZ5pJ/nLcPtKXXEhsDM9I9HkAYhAFnuJgZuL9w1mjMSt+T8E7NreD5qk8oS0
         AZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/3WdeuCJ7GOu9Di/kxGE5ZGCTP43O1pORgSps3IpIM0=;
        b=O4mricfSToXg5JHnWXFPOBLqboRzKdSD2tkaaZV+JXZVVkT/30JGfT3FcfrBMLiJzo
         wpX6Z354eb+0/HKgeF6Onz7oKgCYP7ZrgbvL3KeksPmhWgieTnk/gR6T+YvkVrTDDkSy
         97W0tVHzGqSZViOJUALXBHp8SYrFqxoGsvhKbvlTJp6CbIaeHCJ5qB1yYZH+vOLZuuMQ
         vSTI8bBpOlNEn7RD1UoQYxOAhR8QXPvCJZJbzASdt0Mw7tkarWBJnTLE6qAih79AdEO/
         i1mip+g7c8gnZ/Ni+e8ygYEEWqVMemyTQkdlZt9R3FZ6LJQQsM7UMmKEeUsgUXPchFfs
         WkzA==
X-Gm-Message-State: ACgBeo3z2t3xDEs4BaxM1AMqkLju6sttxptHBnO0o+jxstEiSzk0hrxd
        J5ExLXqUiDSnEW1YpSrZusD8UwgGhMUNChIb
X-Google-Smtp-Source: AA6agR4ivgKsW1nGK+NgnkoWRxp99CaZs3EHTMf/igrghYYz2Hbi4Z0NHcfQ+u7S31hvnU6vrpxPBQ==
X-Received: by 2002:a17:90b:1bcf:b0:1f5:53cf:c01d with SMTP id oa15-20020a17090b1bcf00b001f553cfc01dmr30056226pjb.37.1660589760532;
        Mon, 15 Aug 2022 11:56:00 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x190-20020a6231c7000000b0052def2e20dasm6858174pfx.167.2022.08.15.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:56:00 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/7] btrfs: Convert end_compressed_writeback() to use filemap_get_folios()
Date:   Mon, 15 Aug 2022 11:54:48 -0700
Message-Id: <20220815185452.37447-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815185452.37447-1-vishal.moola@gmail.com>
References: <20220815185452.37447-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/compression.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e84d22c5c6a8..d4ebef60b3ce 100644
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
@@ -222,8 +223,7 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
-	struct page *pages[16];
-	unsigned long nr_pages = end_index - index + 1;
+	struct folio_batch fbatch;
 	const int errno = blk_status_to_errno(cb->status);
 	int i;
 	int ret;
@@ -231,24 +231,22 @@ static noinline void end_compressed_writeback(struct inode *inode,
 	if (errno)
 		mapping_set_error(inode->i_mapping, errno);
 
-	while (nr_pages > 0) {
-		ret = find_get_pages_contig(inode->i_mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		ret = filemap_get_folios(inode->i_mapping, &index, end_index,
+				&fbatch);
+
 		if (ret == 0) {
-			nr_pages -= 1;
-			index += 1;
-			continue;
+			return;
 		}
 		for (i = 0; i < ret; i++) {
+			struct folio *folio = fbatch.folios[i];
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

