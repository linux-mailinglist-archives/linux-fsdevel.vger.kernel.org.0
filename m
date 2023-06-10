Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B739F72AB33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjFJLjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFJLjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:39:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FC3AA7;
        Sat, 10 Jun 2023 04:39:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so702085ad.3;
        Sat, 10 Jun 2023 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686397172; x=1688989172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FKcoxBwK0qnW6H27wS5t14OVQv/jaudrF3qmLKf+oE=;
        b=GhZoRSiJ9D7z5xfhTIJkAE8dU7f+dlfm9hB7UfM6UzV7wFp7WjThn6zSH4VtVUMP+V
         Jbup8ulnBZePVJgjKsQWEhI0ITFfUxjPE/WbAJF+KUFlAyjrB8S6DyTw24+pRF6xP2H/
         eVsNw7zUGftXbQZEuVfig1NWgmP8fqcmayAerKJf39/tCEPJyEAbQnXaH0EYYozFXBXd
         SDAwNlmFbnJC+7OQBpoC6ZOTvgJwLvkGK91aWGHZUSIsUL77rROXeWdXJiBXLoOdxNZE
         Vxsb00W0rG1q76tWchJjGWj1+AP8WYcekY8k7uFy4cZhw9aEulyDOk1o+2i7zeJ4nR0U
         pdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686397172; x=1688989172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FKcoxBwK0qnW6H27wS5t14OVQv/jaudrF3qmLKf+oE=;
        b=asAXEKNxFtJ/JvWgufjFTF0nZvhM6TsC7lvV3miK19pi/YWDcp5nbgvjReUgH82Yo+
         yEEcxUI3iwqxvaz5+Cgv/VHDCPG6K54eU3zwlHW8TqOPFPkuxxsVjdaUvnOn/eJ35QGp
         Twb2QXaop7cZxbP9wOw4wyL7HiuHwTH2XCzpX1FZ+DkisJXrEfGPhp4UiBnw4HSbr5ka
         OpdzJnDTjipk+/cWKwsNE/vQQ0nvlx4pXYXZhpzgAi0+RSuxaDiM66XS/vWSakeUugdo
         0euOn4QkGhRl1nPzNXscUfzPQMR1zwQ0P3aMHImBA2TKvgDgSvY1KKYXMR0g40bS9FnG
         h7jA==
X-Gm-Message-State: AC+VfDyVGUINKmCAUaR8DGNapt5H1QNfLQo+y9H15z6oAQz7WBULkdaY
        DWCX4KAk9hULyfvKh7aLzcywhwQoHWQ=
X-Google-Smtp-Source: ACHHUZ5gtLIfzMbXpo3ZOCuEYnQSF/zbk5yMJwytjqy7vchASO3kgEXMl0GlwakbVnJ1dEaLLc1duQ==
X-Received: by 2002:a17:902:db0f:b0:1af:981b:eeff with SMTP id m15-20020a170902db0f00b001af981beeffmr1833274plx.64.1686397171891;
        Sat, 10 Jun 2023 04:39:31 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001aaf5dcd762sm4753698plf.214.2023.06.10.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 04:39:31 -0700 (PDT)
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
Subject: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch() function out
Date:   Sat, 10 Jun 2023 17:09:05 +0530
Message-Id: <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
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

This patch factors iomap_write_delalloc_punch() function out. This function
is resposible for actual punch out operation.
The reason for doing this is, to avoid deep indentation when we bring punch-out
of individual non-dirty blocks within a dirty folio in a later patch
(which adds per-block dirty status handling to iomap) to avoid delalloc block
leak.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 54 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 206808f6e818..1261f26479af 100644
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

