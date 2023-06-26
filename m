Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA473E69D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjFZRgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjFZRgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:36:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302162952;
        Mon, 26 Jun 2023 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E+4oLVAPfstR5U6aMi6Troa+YNi9gddz/xau+Gpg+rc=; b=UixsKVyP80nb0Gf7F4Lg+jN462
        veiCIiZ5m1gznewobjOw1LIlCVl+NQ9bzKtGc1cy/FIFA2ZFOyC31yskGu3ZRnQRQ486TqTOhj/gr
        MYy4BGRtCU3MWPXCVKFnpYRI0SO+7rxcxT4MHuv18Sude5qsPpa5V0wVCVDJPMg+CxWSEWOj5iYYW
        AJDD8UCC+LOhQrktHVtCdUQ+V85q2O0pIp+RIDy4myAwlxwJ/KnWBqgsQgybdKyrahLZIt/KPAliX
        Z7BL5LWIbRipCNRi/kU84/66Ojv2G0K94IDEtnbMk2QxnYFxyp6hwCZ51e4XG35VOJT7z4XE1c+22
        +qrDsMow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDq7X-001vV7-Jz; Mon, 26 Jun 2023 17:35:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 05/12] pagevec: Add ability to iterate a queue
Date:   Mon, 26 Jun 2023 18:35:14 +0100
Message-Id: <20230626173521.459345-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230626173521.459345-1-willy@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a loop counter inside the folio_batch to let us iterate from 0-nr
instead of decrementing nr and treating the batch as a stack.  It would
generate some very weird and suboptimal I/O patterns for page writeback
to iterate over the batch as a stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 87cc678adc85..fcc06c300a72 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,6 +27,7 @@ struct folio;
  */
 struct folio_batch {
 	unsigned char nr;
+	unsigned char i;
 	bool percpu_pvec_drained;
 	struct folio *folios[PAGEVEC_SIZE];
 };
@@ -40,12 +41,14 @@ struct folio_batch {
 static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->i = 0;
 	fbatch->percpu_pvec_drained = false;
 }
 
 static inline void folio_batch_reinit(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
+	fbatch->i = 0;
 }
 
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
@@ -75,6 +78,21 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 	return folio_batch_space(fbatch);
 }
 
+/**
+ * folio_batch_next - Return the next folio to process.
+ * @fbatch: The folio batch being processed.
+ *
+ * Use this function to implement a queue of folios.
+ *
+ * Return: The next folio in the queue, or NULL if the queue is empty.
+ */
+static inline struct folio *folio_batch_next(struct folio_batch *fbatch)
+{
+	if (fbatch->i == fbatch->nr)
+		return NULL;
+	return fbatch->folios[fbatch->i++];
+}
+
 void __folio_batch_release(struct folio_batch *pvec);
 
 static inline void folio_batch_release(struct folio_batch *fbatch)
-- 
2.39.2

