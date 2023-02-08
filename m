Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56CC68F169
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjBHO4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBHO43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:56:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6C12850;
        Wed,  8 Feb 2023 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=P8+rJcPo0Fi8EeQaL5ojtZrZIVY5GFF+sRbE8RbykGM=; b=jFB+zuP/GErfB3+KWN8VrM6GCP
        y+Lkp83XJ744+OM2jyf/Qmdrtb6ObhoSe5sdQ+wx0gN2/g9dJ/1iNRGIC31NbAAelMJpegYDswwC2
        u00Br5wNVOIPD4wdppYg12n4rKId3hnSJkSRpVePG9OwbnprjAUTj4uc0vRBPp7DMo1YSkqa8GADu
        eTB2K1phkytHNMgtxFiic62PKkoHRKTGH42Gm8M1JR46xKpM3ePHkuI+uniHuVbMDdP/wam/IDHIA
        fqFRMYNRoqVaDElgoSphdworh2Wkncu6YZU9KsKaiqOBMahJxVDtIsOra++HVgxXHnJ9N+HSFlePj
        p8klytRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlrp-001I3E-Ck; Wed, 08 Feb 2023 14:56:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/2] cifs: Use a folio in cifs_page_mkwrite()
Date:   Wed,  8 Feb 2023 14:56:10 +0000
Message-Id: <20230208145611.307706-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230208145611.307706-1-willy@infradead.org>
References: <20230208145611.307706-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoids many calls to compound_head() and removes calls to various
compat functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 5568a5f4bc5a..233ce38ab612 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4516,23 +4516,22 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
  * If the page is mmap'ed into a process' page tables, then we need to make
  * sure that it doesn't change while being written back.
  */
-static vm_fault_t
-cifs_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 
-	/* Wait for the page to be written to the cache before we allow it to
-	 * be modified.  We then assume the entire page will need writing back.
+	/* Wait for the folio to be written to the cache before we allow it to
+	 * be modified.  We then assume the entire folio will need writing back.
 	 */
 #ifdef CONFIG_CIFS_FSCACHE
-	if (PageFsCache(page) &&
-	    wait_on_page_fscache_killable(page) < 0)
+	if (folio_test_fscache(folio) &&
+	    folio_wait_fscache_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
-	if (lock_page_killable(page) < 0)
+	if (folio_lock_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 	return VM_FAULT_LOCKED;
 }
-- 
2.35.1

