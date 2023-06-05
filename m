Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABF7223F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFEKzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFEKzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:55:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3510C;
        Mon,  5 Jun 2023 03:55:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2116897a12.2;
        Mon, 05 Jun 2023 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962529; x=1688554529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WupwSFXXwQFHWk6jv9cWFxx36Vr+X7GVSjDECiCjfRE=;
        b=Kg5jNqx8MyZ+zzEUQ2iY7BALh0gh6CTVSKXxAtS4uerxTHBTFVFyztr8N6z3xnqUNu
         tvyUDcs34Eck3wkiK+6ch8qt4tetTpaAHKMmud+SVBmVysNyQQoaXDDrp+zQfBxUS6m/
         zWjbf3r56f7dQvtxa+/tuWvQSy2Xm+jqZWTgCQSnA9IUURCdSdalGse6zf3CdXORWMxG
         KYrbMpSfhP1wMpmKuVCDHauzO8lufXLLfe+E/3YueuDfeulDti1ZnzEONcDC6S+sD1LK
         CmUYCff8KuKD2TOvolPVgQfB/Fy+35hlDvjURdeZXu4a5/l/AiPPkz1lksDUEm8nDbn7
         4d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962529; x=1688554529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WupwSFXXwQFHWk6jv9cWFxx36Vr+X7GVSjDECiCjfRE=;
        b=DMt+lEK5iuhZv08OELtI+sNBqgYas+LE2qoWMI7N4usQyQtE+bJkHecPGcExQRpHH1
         Gf1nJz/tV2OsQrehHKzeHIyqp4f1I2aYOk9y3KMc0qJGXLofWBmbJ2M7AKOxjAnUIvwU
         oaTotJmwDwL+8xbSGc4ftVryYquVLZpdkaxL/d8F4Cl60Tkm8cSmIXMgc6z+N3XKig1M
         OlXoxQoobGqAPK94+9fQrMOcW4UWClKDtiCQp1IFiY7IxkdMUYGTY0u1iEGns7NLc+oO
         vgNWy2sYqtpnJmAoQRrFmA96S6XTyYeby3tq5a784HCXTHxrfa1J02ffsPsIN6wH4pSb
         q/qw==
X-Gm-Message-State: AC+VfDw/XVmKWh2NUeI6rq2EjCqUZ84LFW7diqgNMfau8tqidkyF64zB
        bhRcC/VbdmiCgvParY7f5xfUwf8a5MA=
X-Google-Smtp-Source: ACHHUZ6EH7acXwk36tvkKicdhUuZu6jJpp4NbCtfjiLlqHBx+/Rmnz5nzobzokopySgRWDVDW/4fFw==
X-Received: by 2002:a05:6a20:3ca1:b0:115:5910:c82d with SMTP id b33-20020a056a203ca100b001155910c82dmr1230613pzj.43.1685962529421;
        Mon, 05 Jun 2023 03:55:29 -0700 (PDT)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm6266883plh.16.2023.06.05.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:55:29 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv7 4/6] iomap: Refactor iomap_write_delalloc_punch() function out
Date:   Mon,  5 Jun 2023 16:25:04 +0530
Message-Id: <27c39cdf2150f19d91b7118b7399177d6889a358.1685962158.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685962158.git.ritesh.list@gmail.com>
References: <cover.1685962158.git.ritesh.list@gmail.com>
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

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 54 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 136f57ccd0be..f55a339f99ec 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -894,6 +894,33 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
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
@@ -917,6 +944,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
+		int ret;
 
 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
@@ -927,26 +955,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
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

