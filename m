Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6872AB2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjFJLjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJLj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D6E1;
        Sat, 10 Jun 2023 04:39:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b025d26f4fso16342275ad.1;
        Sat, 10 Jun 2023 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397165; x=1688989165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LqXrHyMAliGHHfl145sr39mbdmvYioGfCu9qktj5nI=;
        b=HhlZubRk4/08niZvdPfzYydYXx4kCMWS9FKznmOtJm3RM53zr5q9dr5KdxGFxDX4s4
         OsOpu1l9MS+KdIqfXv+WTBf8K7tx1jqvry9KZLFAFt5fMUwmVjfvokE1fJKQ26nDg5/C
         Q1GRyL7sd6J7gy6AOIGiSrwOtS0UPz1D9mrAzTm2CIFwS4nrCMU/SLmMlXCPgxVMvdBu
         hfUWUgUslmodiF22PypMJCxiyU35K8HY7CnK1zgCoxUsnVzOwZNdjRGSQQYoTFs/1XwZ
         9eX/Z22cuvLLSxrpeRY+2c59X1BlDLGCRzqA8vWg4aD94s5XjTWv1bKckHt3QuW2LtV3
         Fb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397165; x=1688989165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LqXrHyMAliGHHfl145sr39mbdmvYioGfCu9qktj5nI=;
        b=SLgxJ+u3E2aQKIbYGBBloc8XGlJzwkuLloljgUMTd11bEzqcm/uKDu0jv0zLdFWdIs
         jHZVLyBZdr7bhdG3reEj6I+MxqwPE1bNYU8jLx4fTR4TelfJVEVk2Rw0Z5uay59RMOXi
         PFQUWV+k80yn/QlhGMMW7PPz/3snNwNv9BZez/Ppf1Mjhe8DaZz82BRYoNef5qThWxEL
         QTG1ayaUFpxzirbLeg0m+/fTz+mr7yp1fJ1W22SdLIcFnEi20Cz91BbDv4q4re10jpyu
         GKXAKwayItyu81Z49pGcaQqFMe7NBE6izsHAvJgpJM4dy4iPM6dxPcgrYqeY39Nqp0M6
         Vjyw==
X-Gm-Message-State: AC+VfDwM2S4VXAbrhePTGUdPPXAuPPPCkhhsynA1q+doNFqnVBL9FrcA
        afudXgLUM/Id23HHDabu0mOtuO7XwB8=
X-Google-Smtp-Source: ACHHUZ5I7NHj2ddnHR3pPPbkZyCTOB37ZnCj8PAT3tC6o6nx4If/+jU2mHc588RCJHIsIwSU41EHxw==
X-Received: by 2002:a17:902:ce87:b0:1ad:cba5:5505 with SMTP id f7-20020a170902ce8700b001adcba55505mr1875714plg.14.1686397165006;
        Sat, 10 Jun 2023 04:39:25 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:24 -0700 (PDT)
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
Subject: [PATCHv9 2/6] iomap: Drop ifs argument from iomap_set_range_uptodate()
Date:   Sat, 10 Jun 2023 17:09:03 +0530
Message-Id: <183fa9098b3506d945fed8a71cadeff82e03c059.1686395560.git.ritesh.list@gmail.com>
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

iomap_folio_state (ifs) can be derived directly from the folio, making it
unnecessary to pass "ifs" as an argument to iomap_set_range_uptodate().
This patch eliminates "ifs" argument from iomap_set_range_uptodate() function.

Also, the definition of iomap_set_range_uptodate() and
iomap_ifs_set_range_uptodate() functions are moved above iomap_ifs_alloc().
In upcoming patches, we plan to introduce additional helper routines for
handling dirty state, with the intention of consolidating all of "ifs" state
handling routines at one place.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 67 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 779205fe228f..e237f2b786bc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,6 +43,33 @@ static inline struct iomap_folio_state *iomap_get_ifs(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+static void iomap_ifs_set_range_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk, nr_blks);
+	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_uptodate(struct folio *folio, size_t off,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
+
+	if (ifs)
+		iomap_ifs_set_range_uptodate(folio, ifs, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
+
 static struct iomap_folio_state *iomap_ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -144,30 +171,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_ifs_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
-{
-	struct inode *inode = folio->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ifs->state_lock, flags);
-	bitmap_set(ifs->state, first, last - first + 1);
-	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
-}
-
-static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
-{
-	if (ifs)
-		iomap_ifs_set_range_uptodate(folio, ifs, off, len);
-	else
-		folio_mark_uptodate(folio);
-}
-
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -177,7 +180,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, ifs, offset, len);
+		iomap_set_range_uptodate(folio, offset, len);
 	}
 
 	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
@@ -213,7 +216,6 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_folio_state *ifs;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -231,15 +233,13 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		ifs = iomap_ifs_alloc(iter->inode, folio, iter->flags);
-	else
-		ifs = iomap_get_ifs(folio);
+		iomap_ifs_alloc(iter->inode, folio, iter->flags);
 
 	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, ifs, offset, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -276,7 +276,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, ifs, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}
 
@@ -589,7 +589,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, ifs, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -696,7 +696,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
 	flush_dcache_folio(folio);
 
 	/*
@@ -712,7 +711,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, ifs, offset_in_folio(folio, pos), len);
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
-- 
2.40.1

