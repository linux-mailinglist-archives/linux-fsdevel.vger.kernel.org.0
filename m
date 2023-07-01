Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C037447C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGAHgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGAHfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FAE58;
        Sat,  1 Jul 2023 00:35:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2098845b3a.0;
        Sat, 01 Jul 2023 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196941; x=1690788941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo1Zdp1lRV/O3jeD7knI1qn5KUdKSMVI92S/6Gq9i5k=;
        b=cSXGBQpyUN9k8hqY+ufSHthOWI9WMrL4KbdPRlV6qHOtcvWbg2IzM5LCj7Bp0/qT3b
         KN1tXJWsq4KjXSBQPPd3P+okfe56u5ZkIeaXs9Dyb9xk/PLxha6BRzDJX25BA4m7aWbP
         +ojHX0c6yZl0Ihfr2DJjLoL+D9Yw/OMBE0HCu3TNC66KwPaXeuAgDbraQ/VhufpTK0q7
         aw2KyWD3Qwqv4FyuFLNGcnkUr+lL9KIjs06ID5ukC87xXhveeEMlrzZCgkjZCfyqw0zk
         nCsyhiw3JlHmVuM61RV7A3Nm+IjQufwEYpCXQyz+tHIoMkYl5nSipFWe2mzzyXZHRIxJ
         nKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196941; x=1690788941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo1Zdp1lRV/O3jeD7knI1qn5KUdKSMVI92S/6Gq9i5k=;
        b=NvMAWS6Yb1TeTQKW+/2zGkua7z/uDxg28Irq+iAInri1erUkWLL5VT9ghh5oEWIVZn
         sabsNXERsh/0NHr3vzejYK/B/oidskSPnQA16bxCGmkxAQpUUIr261LOajpZcC/PDZkX
         vRU3l/JTcXMRIiQ8HH8juVtZXHZxIwLam/qjcXfM9khIzRm+ZTefmHCsHtD96ZB6INpk
         MOF0FtZNj2Wc6uGJOLrPC9IZOsPh4ijrU4xJVzqRwldoIqIVX15Ka1IMk9BdsnPMBpKX
         ijIe+iTAx1yuU4DP/2kvzstZAQ5yTA365Y+ejol/iZekm7VKtpurpig/9QXJ4HENbgPA
         dkrA==
X-Gm-Message-State: ABy/qLbEkkMr3KSRc0iCuRT/Kx5NlASEdmZY9IOHm5cKAunBmW4roAt+
        cQwU101vIGUIAKiK0AkB4RRBPngSuoA=
X-Google-Smtp-Source: APBJJlHq7lw8rVw0u2abDpLRtNWQvayECJM44Bxs8G2NHUari9tHAZ4YWbS3bJm0HVgAcMKFzX9wHA==
X-Received: by 2002:a05:6a00:1806:b0:66b:6021:10fe with SMTP id y6-20020a056a00180600b0066b602110femr6668982pfa.31.1688196940693;
        Sat, 01 Jul 2023 00:35:40 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:40 -0700 (PDT)
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
Subject: [PATCHv11 6/8] iomap: Refactor iomap_write_delalloc_punch() function out
Date:   Sat,  1 Jul 2023 13:04:39 +0530
Message-Id: <6ff2ed87400236d947ff270f591e77b5e16a38b4.1688188958.git.ritesh.list@gmail.com>
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
index 33fc5ed0049f..6abe19c41b30 100644
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

