Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A8724149
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjFFLoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjFFLoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:44:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B89A6;
        Tue,  6 Jun 2023 04:44:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-542c54455e7so1730462a12.1;
        Tue, 06 Jun 2023 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686051851; x=1688643851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNbebm9Jn9SSTfoHqa42ibdq4MoOmRy6HfaX/BXkaq4=;
        b=p+JPDG51wIC2CASS5zqyko+6fomX+2lI6FHRpYzfIiZ9MveF+QGNm0LMFu5kKFiuD5
         CoeSDDWGrWwDfY48ZNZfJ/N6vu8mrLdLfgN0LBAGZXRa7tRv6iR0ut0NSfU4HASxcCuo
         pw2Gk7snKwAAWnPYQTliGYIdnhgj4pNjaSpytMk8IJcAtI4qk9qrIwHozBA0w2ZZl9tU
         UEhphfYUhNJYwNR4ybfIyGH3BbmLtscVpF34XNPlC26lJ7/K+nRUJDdNrSqUF2N5hFFF
         dDkUcuFUjTNVe5Kgo+21EniPUxfH+fs3/d83b4lv0lMyAkHzlYGxqSxTlhGuf6FWdNBv
         J6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051851; x=1688643851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNbebm9Jn9SSTfoHqa42ibdq4MoOmRy6HfaX/BXkaq4=;
        b=a+dUEmTYxUum3Pow3H/Bj+ButILzbPAiRMYi8H3z+tngRY7mI25KMkcGTQYh9GjBvC
         aqQ1ZKsYfIpJVtb0DnMA5V7NLU/sFSC8tk7xxKzJc7p65pK3Vkw4NKxOOEVI4NX1mJdm
         zpBmBge1/O2Ro49nO9AF9fumsYPocviE7h6GFyBGEJpUQTba1E0oMZ7Ox4VkUdoGPwe6
         OF/DOy9u2mb+Bpf+i5TQ4RYA4g+9xuufQ8jyD+/huf7ClZVtw/ctFlN9CZzbVlrJe/S9
         oW/u9ys3EyMZaHjtJmAxXUsO9YxPQo6mwuQ21coEEti2InLoFl4KvsGPyXRnPjRGhyJv
         pvzw==
X-Gm-Message-State: AC+VfDxoriZZv0yYoQQoTYSZcNWkqdKw/EQi+0n48Ja8RjST2KZy8eMZ
        Mg5Ecu4MB7X4+CbPh+vjHVZ/dNqwK9M=
X-Google-Smtp-Source: ACHHUZ7S87oCH5408p8y/uQg2HAQTMqjRciIbtZjPRxmQKZXRGcrxaOO6e6D6LcK1LONqSiLorLr+g==
X-Received: by 2002:a17:903:1250:b0:1b0:4680:3f with SMTP id u16-20020a170903125000b001b04680003fmr681164plh.41.1686051850946;
        Tue, 06 Jun 2023 04:44:10 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm8325120plb.202.2023.06.06.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:44:10 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv8 3/5] iomap: Refactor iomap_write_delalloc_punch() function out
Date:   Tue,  6 Jun 2023 17:13:50 +0530
Message-Id: <ee74cd3dfb34ec321f70ee67c3a5d1f40fdc585f.1686050333.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686050333.git.ritesh.list@gmail.com>
References: <cover.1686050333.git.ritesh.list@gmail.com>
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

This patch moves iomap_write_delalloc_punch() out of
iomap_write_delalloc_scan(). No functionality change in this patch.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 54 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 08f2a1cf0a66..89489aed49c0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -888,6 +888,33 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
+		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
+		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
+{
+	int ret = 0;
+
+	if (!folio_test_dirty(folio))
+		return ret;
+
+	/* if dirty, punch up to offset */
+	if (start_byte > *punch_start_byte) {
+		ret = punch(inode, *punch_start_byte,
+				start_byte - *punch_start_byte);
+		if (ret)
+			goto out;
+	}
+	/*
+	 * Make sure the next punch start is correctly bound to
+	 * the end of this data range, not the end of the folio.
+	 */
+	*punch_start_byte = min_t(loff_t, end_byte,
+				  folio_next_index(folio) << PAGE_SHIFT);
+
+out:
+	return ret;
+}
+
 /*
  * Scan the data range passed to us for dirty page cache folios. If we find a
  * dirty folio, punch out the preceeding range and update the offset from which
@@ -911,6 +938,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
+		int ret;
 
 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -921,26 +949,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			continue;
 		}
 
-		/* if dirty, punch up to offset */
-		if (folio_test_dirty(folio)) {
-			if (start_byte > *punch_start_byte) {
-				int	error;
-
-				error = punch(inode, *punch_start_byte,
-						start_byte - *punch_start_byte);
-				if (error) {
-					folio_unlock(folio);
-					folio_put(folio);
-					return error;
-				}
-			}
-
-			/*
-			 * Make sure the next punch start is correctly bound to
-			 * the end of this data range, not the end of the folio.
-			 */
-			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
+						 start_byte, end_byte, punch);
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return ret;
 		}
 
 		/* move offset to start of next folio in range */
-- 
2.40.1

