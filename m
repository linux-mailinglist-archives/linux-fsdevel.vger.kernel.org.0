Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E380061094B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 06:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJ1Ear (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 00:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1Eap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:30:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA41642E1;
        Thu, 27 Oct 2022 21:30:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b5so3818378pgb.6;
        Thu, 27 Oct 2022 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3mGMjaU3WC0W6Kb2cEN9m+o1Hz2n5stQqCfqgyEYBA=;
        b=oWu+w/Nm6awXKXWSh/7R5vCZykUEGPgYmnqPvb6rS1aGm/6sCxcXm4IBuGCcOBE0TI
         XshnG1c11I1q1OgIcTKWrKxW7LldI9kjZMgPXjquJasdO3bEPRYSKO8PZ8NxIkp+BJgw
         cCy+kHmvrpiIZQgB1aNT/W6TEFAGruN25oIz5/7ddDiNwDrDNjPe6PZ9dfeO3G4/aVEc
         7oEsv5GOoWIwacxswishkOVfwZh4SvzGGd30yWTpd8qcSle9ieQiYjD5loheackHGBrT
         wHYjbYG6cB8oxqO7bdamNorKGXFlw7+SnIsCTMSyY2dLXTwTc9Kibux/IsYKm4akj46v
         x2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3mGMjaU3WC0W6Kb2cEN9m+o1Hz2n5stQqCfqgyEYBA=;
        b=cpga7KTevhSdxukjjR/8OS4NYm1cbGXF0cuWg8y56GMJ7U37ByTbBSnoe7H/gegvKB
         d0rrHNx1m23ttscppqN1EeoGB3Eg+iRVtqwr15ic7X0RdK9wTNF95zecXNk15lo1/EJz
         Wzt0EKbGZ3PKvGc1Ygv44p0EAxwPCdzwAj9RRfFvWXPD7mv/I+Ly4N7x2niHpwvZDNoz
         NFkwrnTsN+l6emcnjHXsOhWk8It+lRrb6E5KZUr7NHGo0i33n/zMKh+Qcj5qN/i65sjQ
         C7Ye48qzMu/S/tovFb3O4zXQR1hpOMWUwmvKY9euJyd6EGYGLdyGxzOVQNTU3dcB1nnT
         jmUw==
X-Gm-Message-State: ACrzQf07FyebAlVfT5qVtHGvZDWR2Sh+hy9RecYQqd0mJONaYFM6MEXc
        Xmd+sZRKbrL70ZYRHtVdXwoTazCiO8A=
X-Google-Smtp-Source: AMsMyM78NyWkQlZQIJqKtMmZzpZ2FNMNolcQF5JYQbUqXxQLXs3XU2xcKfCnLgV84G0sm87R/uycjQ==
X-Received: by 2002:a63:e158:0:b0:464:8d6:8b91 with SMTP id h24-20020a63e158000000b0046408d68b91mr43869229pgk.124.1666931444570;
        Thu, 27 Oct 2022 21:30:44 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902b71700b00178b6ccc8a0sm1998205pls.51.2022.10.27.21.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 21:30:44 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/2] iomap: Change uptodate variable name to state
Date:   Fri, 28 Oct 2022 10:00:32 +0530
Message-Id: <82faf435c4e5748e8c6554308f13cac5bc4a8546.1666928993.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666928993.git.ritesh.list@gmail.com>
References: <cover.1666928993.git.ritesh.list@gmail.com>
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

This patch just changes the struct iomap_page uptodate & uptodate_lock
member names to state and state_lock to better reflect their purpose for
the upcoming patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ca5c62901541..255f9f92668c 100644
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
@@ -58,12 +58,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
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
+			bitmap_fill(iop->state, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -79,7 +79,7 @@ static void iomap_page_release(struct folio *folio)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(bitmap_full(iop->state, nr_blocks) !=
 			folio_test_uptodate(folio));
 	kfree(iop);
 }
@@ -110,7 +110,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +120,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iop->state)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -152,11 +152,11 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	if (bitmap_full(iop->state, i_blocks_per_folio(inode, folio)))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
@@ -451,7 +451,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!test_bit(i, iop->state))
 			return false;
 	return true;
 }
@@ -1354,7 +1354,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !test_bit(i, iop->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.37.3

