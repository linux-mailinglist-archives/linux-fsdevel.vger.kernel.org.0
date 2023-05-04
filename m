Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED4C6F6E29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjEDOwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjEDOvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 10:51:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABE3598;
        Thu,  4 May 2023 07:51:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643465067d1so527321b3a.0;
        Thu, 04 May 2023 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683211888; x=1685803888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfp1xXUZJdJ4qjQw95B1gOuqgTHc9Q2HKNsENhHLoQc=;
        b=AOyjb2LC0bBu0we/nhfduVCNT4rA0zw8NFHKnKqZNK1ebDBPAD/XUQ/qpGOW+3QL/X
         p1J20i1gMSiWZqSUvLT5T9L63rynUs6ytTPHcB/Z0R2Ds30TK0sEdYIr0fFagxQrUXm7
         NdxaOILou31UEA6UcOa96IhcIVRDxU0TGsEo57mhZ0idzNX76fwyXug38Z7fH2PKfN4A
         VDz8IDiDNQOBaxoPzeoq52XR03bzKvKhDeMdYS6oKnHZBJtRNWLVF7tOga1lCvFPDkio
         gtT7P6bA32t2pa5dRsHOZS+BkBOateqzZAtk9RDooFxZTzGhvtZIQpxh1prQYhv2CJjI
         pfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211888; x=1685803888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfp1xXUZJdJ4qjQw95B1gOuqgTHc9Q2HKNsENhHLoQc=;
        b=gBAAArPgBAPkeoRcf0Ugof9Uv26P/TQTzsHf95wY5bTgN/i5CT9GgQJ8iYUn5NdueN
         j3oyZY6l3DMMzL8scLIPMDv/50RfXEXpW9tGyE9/X2It8qhOnAagHGv3v01tpnKluNwQ
         M1KBqeZnit1bkS2OhT6A0WgN4xn/AvGL5UGVnFRj7RaHi2th8tqsClBVvfBfi4zo87UP
         UxhBSXIYWIydQccifaSt7OlAnofwkG2uX/e6Ya1EC9IkdmMRzP2Mu6uSN5jWN7SaE3lr
         jRFOuWRypMytsR6we8PwzN9r7SltBbha7IA2sLB8EIBJmaHw/KhcPLYBc/PFHYOXMPXW
         hIbQ==
X-Gm-Message-State: AC+VfDwCDcEakhgE35QzZVjup+n+UB8KsnosLVI06p35Z1qlwWeVpxdq
        h69fZFYkBfJouJqJ/XL9DeD9GrbbzIo=
X-Google-Smtp-Source: ACHHUZ7kZmEzTF3sX2WIs/SbhowikMonymlCtNXi20KcWeouUlGRfC2am+8V0kkzXMJiG6jzGj6k7Q==
X-Received: by 2002:a05:6a00:2386:b0:63d:2343:f9b with SMTP id f6-20020a056a00238600b0063d23430f9bmr2872788pfc.19.1683211888354;
        Thu, 04 May 2023 07:51:28 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id z192-20020a6333c9000000b0052c53577756sm3107503pgz.64.2023.05.04.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:51:28 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [RFCv4 2/3] iomap: Change uptodate variable name to state
Date:   Thu,  4 May 2023 20:21:08 +0530
Message-Id: <57994bfd33f6b4dd84adb8ea075a1974d6a5e928.1683208091.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683208091.git.ritesh.list@gmail.com>
References: <cover.1683208091.git.ritesh.list@gmail.com>
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

This patch changes the struct iomap_page uptodate & uptodate_lock
member names to state and state_lock to better reflect their purpose
for the upcoming patch. It also introduces the accessor functions for
updating uptodate state bits in iop->state bitmap. This makes the code
easy to understand on when different bitmap types are getting referred
in different code paths.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 65 ++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e43821bd1ff5..b8b23c859ecf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -25,13 +25,13 @@
 
 /*
  * Structure allocated for each folio when block size < folio size
- * to track sub-folio uptodate status and I/O completions.
+ * to track sub-folio uptodate state and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_bytes_pending;
 	atomic_t		write_bytes_pending;
-	spinlock_t		uptodate_lock;
-	unsigned long		uptodate[];
+	spinlock_t		state_lock;
+	unsigned long		state[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct folio *folio)
@@ -43,6 +43,38 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+/*
+ * Accessor functions for setting/clearing/checking uptodate bits in
+ * iop->state bitmap.
+ * nrblocks is i_blocks_per_folio() which is passed in every
+ * function as the last argument for API consistency.
+ */
+static inline void iop_set_range_uptodate(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_set(iop->state, start, len);
+}
+
+static inline void iop_clear_range_uptodate(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_clear(iop->state, start, len);
+}
+
+static inline bool iop_test_uptodate(struct iomap_page *iop, unsigned int block,
+				unsigned int nrblocks)
+{
+	return test_bit(block, iop->state);
+}
+
+static inline bool iop_uptodate_full(struct iomap_page *iop,
+				unsigned int nrblocks)
+{
+	return bitmap_full(iop->state, nrblocks);
+}
+
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 {
@@ -58,12 +90,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
 		      gfp);
 	if (iop) {
-		spin_lock_init(&iop->uptodate_lock);
+		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
-			bitmap_fill(iop->uptodate, nr_blocks);
+			iop_set_range_uptodate(iop, 0, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -79,7 +111,7 @@ static void iomap_page_release(struct folio *folio)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(iop_uptodate_full(iop, nr_blocks) !=
 			folio_test_uptodate(folio));
 	kfree(iop);
 }
@@ -99,6 +131,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	/*
 	 * If the block size is smaller than the page size, we need to check the
@@ -110,7 +143,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!iop_test_uptodate(iop, i, nr_blocks))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +153,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (iop_test_uptodate(iop, i, nr_blocks)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -151,12 +184,13 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_set_range_uptodate(iop, first, last - first + 1, nr_blocks);
+	if (iop_uptodate_full(iop, nr_blocks))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
@@ -439,6 +473,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned first, last, i;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iop)
 		return false;
@@ -451,7 +486,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!iop_test_uptodate(iop, i, nr_blocks))
 			return false;
 	return true;
 }
@@ -1652,7 +1687,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !iop_test_uptodate(iop, i, nblocks))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.39.2

