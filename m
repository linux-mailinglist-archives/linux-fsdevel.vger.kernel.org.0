Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14777447C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjGAHf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGAHfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:34 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6646199;
        Sat,  1 Jul 2023 00:35:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b07d97180dso2596490fac.3;
        Sat, 01 Jul 2023 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196931; x=1690788931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h43LX+LAxBuBFFPVFB6jb55GjVMsi0wQAMdNCc2VO9c=;
        b=liWGhQ2v8DPvK9VsakBQEjHmzX9rAAbdkJn80DOpWpqIJw+GG+YwOgSYPMlJotIKlF
         8mkex3g6fZ+ji75QN2Bdu8DpIkqCGer/8KslL7KtknU5ua74UlumtYNg0us0ZmvQiSZo
         0lv16NVoBl5zlkbtu1ghEwKQ5UpHCdSd0LilMS3X27taQjRflG2qffPM8XJ6Zkr/70+C
         xfHQBp5wBf/sYa+iXbanD9LRbuEpf4QDoWhAhLYWbBdEbeEfbp5tFC0iky4fmWrQnGTp
         BLxIX7AG3xWdrYbR4Cnvj7CG7gBM8/Mu5UDUan6Sg4eIj02nYVYYXRzBD8//+9tl912B
         Bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196931; x=1690788931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h43LX+LAxBuBFFPVFB6jb55GjVMsi0wQAMdNCc2VO9c=;
        b=Hu7nnVfTPWY6/EaemV21dpheoi3YOglan83FIT11Pt8FEjxh3jCKeKDRwsOspw15m3
         7nzjg5NShUpekc8e3EcthzoSiUXBld0Ei0AwQV1NP/I3q1WifWyqVeEcsES5rLLpIToL
         AD2IebmElkSsK5y6E6TNQxLioeD2Y5eTItM5dDHZqiSWyyXkq5qoTYjYAjmp9Byxghg3
         OAFng9m1ufcboFBkWgw10oTiK8ux/MbXscJ4WxRidSstH4oZixiYQZ9c9Cu8DcjUaqvk
         i3eoq+MtrmJlFLn+HknHgUzXFV9dhwy1xJFe65CoRerdlpsqs/MVQi02a/dgJ8U83gmv
         yImA==
X-Gm-Message-State: ABy/qLZbvyWduG0o/8nHAA4RQW9TYr/ckEfUydN8EAb0pFn94r1JPZ8U
        x4uzsQ7cKE0NGVOdQP9z53Hh+vi/SLY=
X-Google-Smtp-Source: APBJJlFWKBxoN+23envHRckVO/mfIK0JVzTCgPA3WMbuIvcdcqKQgBouVfJWhSME8BwlHyvFI6ryug==
X-Received: by 2002:a05:6870:bacf:b0:1b0:2c0d:9aee with SMTP id js15-20020a056870bacf00b001b02c0d9aeemr7565267oab.14.1688196931454;
        Sat, 01 Jul 2023 00:35:31 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:30 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv11 3/8] iomap: Add some uptodate state handling helpers for ifs state bitmap
Date:   Sat,  1 Jul 2023 13:04:36 +0530
Message-Id: <04ba7f53e55649a908943b6c7c27ef333d47c71f.1688188958.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1688188958.git.ritesh.list@gmail.com>
References: <cover.1688188958.git.ritesh.list@gmail.com>
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

This patch adds two of the helper routines ifs_is_fully_uptodate()
and ifs_block_is_uptodate() for managing uptodate state of "ifs" state
bitmap.

In later patches ifs state bitmap array will also handle dirty state of all
blocks of a folio. Hence this patch adds some helper routines for handling
uptodate state of the ifs state bitmap.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3ff7688b360a..e45368e91eca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -36,6 +36,20 @@ struct iomap_folio_state {
 
 static struct bio_set iomap_ioend_bioset;
 
+static inline bool ifs_is_fully_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs)
+{
+	struct inode *inode = folio->mapping->host;
+
+	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
+		unsigned int block)
+{
+	return test_bit(block, ifs->state);
+}
+
 static void ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
@@ -47,7 +61,7 @@ static void ifs_set_range_uptodate(struct folio *folio,
 
 	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
-	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
+	if (ifs_is_fully_uptodate(folio, ifs))
 		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
@@ -92,14 +106,12 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 static void ifs_free(struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio_detach_private(folio);
-	struct inode *inode = folio->mapping->host;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!ifs)
 		return;
 	WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(ifs->state, nr_blocks) !=
+	WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
 			folio_test_uptodate(folio));
 	kfree(ifs);
 }
@@ -130,7 +142,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, ifs->state))
+			if (!ifs_block_is_uptodate(ifs, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -140,7 +152,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, ifs->state)) {
+			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -444,7 +456,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, ifs->state))
+		if (!ifs_block_is_uptodate(ifs, i))
 			return false;
 	return true;
 }
@@ -1620,7 +1632,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (ifs && !test_bit(i, ifs->state))
+		if (ifs && !ifs_block_is_uptodate(ifs, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.40.1

