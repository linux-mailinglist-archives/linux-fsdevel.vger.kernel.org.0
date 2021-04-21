Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3D3670F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbhDURLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbhDURK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:10:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFFC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=riMbLxw2r4RiaTtRATmPTEzYmfnmNmX+iILWHRdofk8=; b=kYzzfpS9qMfm3u2wuPejOVzA4q
        B3HjgMsHPW2RQzVAfg+cwo17XH3QDAcPKsQ9BcHNxWhWXpCqnwiHxgzUfzNL3bblI2rl2DiItBCm9
        JS62eMopWshmPAr1/hxLl8ExR7TDpRJkIW3ZXGgcyoTdgyo4AHjhodQ1Zdhxlv6U0arrxGqbjT+1o
        g/95DYdCdfYPsxed4mqsd5IHIopa7wCf5TWlqfrZsl1HoBfnQ7fNEHpIlcYpqW7ji9+NDo9TQOvml
        f8g2+fQrDy0MPUq2zExL4HhSqk/axr1ZUeBrVufrdr4rQsQ15JRa+XITqp0vH1orxjCISacbDW4Vm
        Hi9nf2cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZGLu-00Go3P-V2; Wed, 21 Apr 2021 17:09:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2] mm/readahead: Handle ractl nr_pages being modified
Date:   Wed, 21 Apr 2021 18:09:23 +0100
Message-Id: <20210421170923.4005574-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Filesystems are not currently permitted to modify the number of pages
in the ractl.  An upcoming patch to add readahead_expand() changes that
rule, so remove the check and resync the loop counter after every call
to the filesystem.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index f02dbebf1cef..d589f147f4c2 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -198,8 +198,6 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
-		BUG_ON(index + i != ractl->_index + ractl->_nr_pages);
-
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch
@@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
 
@@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 					gfp_mask) < 0) {
 			put_page(page);
 			read_pages(ractl, &page_pool, true);
+			i = ractl->_index + ractl->_nr_pages - index - 1;
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
-- 
2.30.2

