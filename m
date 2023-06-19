Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEAA734A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFSC3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFSC3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC3E4D;
        Sun, 18 Jun 2023 19:29:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666eef03ebdso503249b3a.1;
        Sun, 18 Jun 2023 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141762; x=1689733762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYZjaySF9JoUvT+4F61KVWv6hVHnaw6nITF7B1RwW2Q=;
        b=GznOkpzisZDETZz2EGPGiRV87zD3UEIWZTafxCLV8Wh9UMl+ZYgFGCKbrSCGm2wdJf
         9UYsxiTrEm4Kb6L8J8jb1Afd1M6pdM7lbNi30Pxgt5q2+AyvG9aN6AVfxeYraDxQJrJ8
         9ysuggk9l9F5CAXmMNE4carjIZg1tACcUNcKUqMYBJsQruwlanweyEMGQqcZY7nbP5m8
         YwMvvHo8AoYNofpmSC9vPDHkBbyZ3QVDrKcc7Ejz41uN1eQF+Y27FvsTwv0ZJagGYXEw
         7WJtf+72IrhRu6/Q5K1T9CNiSlVBHPXdGvLQJUu0axAUmm+Fbg11bhXuTjwZ390h61o3
         xp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141762; x=1689733762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYZjaySF9JoUvT+4F61KVWv6hVHnaw6nITF7B1RwW2Q=;
        b=TaCQxtQus24gl2NcyMz/o8DUb7yosZKHHDM2L8ABq9f0nyEIQGwVoAtjtLabTL211C
         WFFE6sL+huAV2ils3LetbyQ602MC9PMYLNnGCen2jD1UaId6uZVzEu/RIesdbNwLsisu
         shqeQ2mvBcF2/38bcP/fgsCXovkcvLyAkd9pQr+T+6uBbd2qUBBL4Nxb/sTaogPNlhzX
         9pRVF4aRerUNe93xbZJtdsvRlDI/+J+66h+o/8bDRUviFoScSlrpi4B6ZJ0OsurwMuqV
         gYY/rd4Z4kBNAsEspJmz9i93VnBBgTlH+3G6EFg77midRWvb3opIyFtMUE050y7vYUww
         WEJg==
X-Gm-Message-State: AC+VfDwgOYnsvfMJFU6kh9TuhlDt/qJzfZNIGQnHJjj1CpaTOGvyfmip
        ymjU0bmtZCaYp4j3tBF3Y4YqRrr387o=
X-Google-Smtp-Source: ACHHUZ7z+dXHOphk2XXW6H2JNWA8xIcju4RWXI7suk4uHY2NamCGpeaBzP6TkrcK6MmUwGn9tlU6jQ==
X-Received: by 2002:a05:6a00:21c2:b0:666:ada0:4b01 with SMTP id t2-20020a056a0021c200b00666ada04b01mr5195831pfj.32.1687141761726;
        Sun, 18 Jun 2023 19:29:21 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:21 -0700 (PDT)
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
Subject: [PATCHv10 6/8] iomap: Refactor iomap_write_delalloc_punch() function out
Date:   Mon, 19 Jun 2023 07:58:49 +0530
Message-Id: <1b7e89f65fbee7cc0b1909f136d40552e68d9829.1687140389.git.ritesh.list@gmail.com>
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

This patch factors iomap_write_delalloc_punch() function out. This function
is resposible for actual punch out operation.
The reason for doing this is, to avoid deep indentation when we bring
punch-out of individual non-dirty blocks within a dirty folio in a later
patch (which adds per-block dirty status handling to iomap) to avoid
delalloc block leak.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e03ffdc259c4..2d79061022d8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -882,6 +882,32 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
+		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
+		iomap_punch_t punch)
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
+			return ret;
+	}
+	/*
+	 * Make sure the next punch start is correctly bound to
+	 * the end of this data range, not the end of the folio.
+	 */
+	*punch_start_byte = min_t(loff_t, end_byte,
+				folio_pos(folio) + folio_size(folio));
+
+	return ret;
+}
+
 /*
  * Scan the data range passed to us for dirty page cache folios. If we find a
  * dirty folio, punch out the preceeding range and update the offset from which
@@ -905,6 +931,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
+		int ret;
 
 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -915,26 +942,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
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
-					folio_pos(folio) + folio_size(folio));
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

