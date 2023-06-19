Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF69734A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFSC3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFSC3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8AE47;
        Sun, 18 Jun 2023 19:29:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9b4a656deso25757811cf.0;
        Sun, 18 Jun 2023 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141751; x=1689733751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6oE7Mn3oTNCl4aJn0H7Lb1RcLZ8SJmI5NLzOO0Lx8E=;
        b=Dp/GKcOCz4/Ggu9zt2D4ELSYo3xnyrA85Kqgo4Zu0zCu4cB0cQMke154cJrMkF4wJS
         SgpiS0/iFFgFO8X2s9n1iQrUsHRZANJzqn4NP6Jwh+rIeNdYRYyeNngDpgz+OFVSm9vE
         WQeLriLXVMG8a/PiNtJifNXGZT+y07oK+2FHvbW1qruZJsXJb51z4aC255Fvnt+GDiYq
         GtDSZLAxHQi3VSXve7RIgCMlLFV9jEy6yDvqcEz35paSbQOzq2Gj43tf7+cFyWq2HRQR
         HsSX8WDtzrc3tZ+9pjnbbi+DBRmOzVNSwyUY0GbQWKBjDnINw7UyP3JNwaAx624Xffny
         7X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141751; x=1689733751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6oE7Mn3oTNCl4aJn0H7Lb1RcLZ8SJmI5NLzOO0Lx8E=;
        b=Dg/iPCivWRzkwexnT/ig6eK7NeOsOR2939ptjgtbTHC1yUllapxkm5t80OlQgtXNFO
         1wkA1ksUK0XWOYGS7gTvZG1ruW2rmGABZpa06iL6DRnB9vr38oEeyErOkPyfZVl1iYbq
         tc494326AifpQMoaU/VTiBKlYyE9E/fHgrsY941Vjwhv4lCNsjLfmoQ/Kwj7OuHm2IMT
         N7iVHPHtKbpJ0Lt0EoEMP7B+jwSCHYxFhlmerkiCcdIm9kDNC9w6FJD7Y010L47QxwlS
         Jen1E8PYYwzfMeafTNH1WV+/VarqzVAOAg5JhDU6s9u8MHguHkcHqPSS4kByTvyyKOBX
         Xuyw==
X-Gm-Message-State: AC+VfDyr4N82zn8l0GcQrIW4fJoQYAopglZiR3MDutx4MkhRnIS7UKO1
        zglc0uI7dFcqrLxav+ey57muNLglnHE=
X-Google-Smtp-Source: ACHHUZ59eyflEJNjGcQT/7rnuTLHUH2f/I8EGwcGFTQqkrf0L+Ct0DZm50AOnD1OkLcX4f33joEjwQ==
X-Received: by 2002:ac8:594d:0:b0:3ff:2179:c48d with SMTP id 13-20020ac8594d000000b003ff2179c48dmr1509843qtz.28.1687141751567;
        Sun, 18 Jun 2023 19:29:11 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:11 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv10 3/8] iomap: Add some uptodate state handling helpers for ifs state bitmap
Date:   Mon, 19 Jun 2023 07:58:46 +0530
Message-Id: <e07b1bbc48c30b00d1750d25fd1381339e25f9f7.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
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
index 3ff7688b360a..790b8413b44c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -36,6 +36,20 @@ struct iomap_folio_state {
 
 static struct bio_set iomap_ioend_bioset;
 
+static inline bool ifs_is_fully_uptodate(struct folio *folio,
+					       struct iomap_folio_state *ifs)
+{
+	struct inode *inode = folio->mapping->host;
+
+	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
+					       unsigned int block)
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

