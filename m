Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246672AB31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjFJLjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjFJLja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B660E1;
        Sat, 10 Jun 2023 04:39:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b065154b79so12848165ad.1;
        Sat, 10 Jun 2023 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397168; x=1688989168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YnkMLxxMAoajrg82W2zOCJjIzJLeLgSUkRYuvBlmSw=;
        b=DBh0Cz4A/1cNPfsBbq0Lpttiu7TeTC/k03ZVSjNboQYZ15peg6J4za/6b0qi1DrHXR
         9uUgA3f6kxhcbd3EhmEPIo6WILtcdWYwtrKdmfEWNBQ8ZYE/Ts2iEVv3632wQTU8bpOj
         yDqJvov84WwebEJHP0NwdSKqDuZHCpwjMFZ7kqpyibmjACzrY1QySpAPc2vOCqZ3TQ2J
         C/TNw2+gkPy2qrCUjE3cyZthGse0lqmWqLvYX/jmh5MN57GYyegkU3AQyXKgEdCvR69o
         MDpTAFUJglyxOo3/A+Gn+HHyeVoJh7NsITOXWwSkqSjbrGy3AiFRlEN+WTxi2Kou6nzg
         OUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397168; x=1688989168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YnkMLxxMAoajrg82W2zOCJjIzJLeLgSUkRYuvBlmSw=;
        b=IDJS7wwOHT+lK53K99kpRVwwybs+3cMheHslxjwBkaDYov3UOMzfaggxZp9snfxwQx
         i12iYKq3RivsIobpM+kPFfYvLahTipy/u1iKr7W1qsVGuWLIScN6YogvJXjbb/m5MY7t
         kl03nJdebfeYerSgHNEuzli8B32rJc2OuxJftqgzSvBjekGENFcREcnd124vmQnDE40u
         tw2tlmyQUCWqhplzjlyEwd4wCRTbK9r5W0KU0M9Aalqi75gN2cBuYeLKtQ/XypvdMCjg
         ZFKTDY0bC0GZQ/5S3N0dojqGydc2xRXWoQ+nfbark5HYHoAvvVQXI4guDZSS/rfGYN0j
         3rIg==
X-Gm-Message-State: AC+VfDznaKeAUrIjpWaDJQFyWATkGFf8ozrVuS6XJ8rd98sS9dM7VSHc
        cZMqeYnhHOLZ8I4lgG87/KtTavNqQcI=
X-Google-Smtp-Source: ACHHUZ43CvmsE1DiKGey7OF4xIlx9gfg7GbzGmYGbBSep3CGLvhU8NywX3amXBmD7YY2EVtDosWKYw==
X-Received: by 2002:a17:902:cecd:b0:1b1:82a6:7c82 with SMTP id d13-20020a170902cecd00b001b182a67c82mr1667907plg.27.1686397168455;
        Sat, 10 Jun 2023 04:39:28 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:28 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv9 3/6] iomap: Add some uptodate state handling helpers for ifs state bitmap
Date:   Sat, 10 Jun 2023 17:09:04 +0530
Message-Id: <606c3279db7cc189dd3cd94d162a056c23b67514.1686395560.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686395560.git.ritesh.list@gmail.com>
References: <cover.1686395560.git.ritesh.list@gmail.com>
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

This patch adds two of the helper routines iomap_ifs_is_fully_uptodate()
and iomap_ifs_is_block_uptodate() for managing uptodate state of
ifs state bitmap.

In later patches ifs state bitmap array will also handle dirty state of all
blocks of a folio. Hence this patch adds some helper routines for handling
uptodate state of the ifs state bitmap.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e237f2b786bc..206808f6e818 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,6 +43,20 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+static inline bool iomap_ifs_is_fully_uptodate(struct folio *folio,
+					       struct iomap_folio_state *ifs)
+{
+	struct inode *inode = folio->mapping->host;
+
+	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool iomap_ifs_is_block_uptodate(struct iomap_folio_state *ifs,
+					       unsigned int block)
+{
+	return test_bit(block, ifs->state);
+}
+
 static void iomap_ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
@@ -54,7 +68,7 @@ static void iomap_ifs_set_range_uptodate(struct folio *folio,
 
 	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
-	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
+	if (iomap_ifs_is_fully_uptodate(folio, ifs))
 		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
@@ -99,14 +113,12 @@ static struct iomap_folio_state *iomap_ifs_alloc(struct inode *inode,
 static void iomap_ifs_free(struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio_detach_private(folio);
-	struct inode *inode = folio->mapping->host;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!ifs)
 		return;
 	WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(ifs->state, nr_blocks) !=
+	WARN_ON_ONCE(iomap_ifs_is_fully_uptodate(folio, ifs) !=
 			folio_test_uptodate(folio));
 	kfree(ifs);
 }
@@ -137,7 +149,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, ifs->state))
+			if (!iomap_ifs_is_block_uptodate(ifs, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -147,7 +159,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, ifs->state)) {
+			if (iomap_ifs_is_block_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -451,7 +463,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, ifs->state))
+		if (!iomap_ifs_is_block_uptodate(ifs, i))
 			return false;
 	return true;
 }
@@ -1627,7 +1639,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (ifs && !test_bit(i, ifs->state))
+		if (ifs && !iomap_ifs_is_block_uptodate(ifs, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.40.1

