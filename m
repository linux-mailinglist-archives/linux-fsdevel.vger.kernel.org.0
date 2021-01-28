Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9510307051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhA1HE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhA1HEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:04:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0FC06174A;
        Wed, 27 Jan 2021 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L1GVgJTGJz2vYfvVJItC7NjEGvu6/5cWeE52+Ma6Voo=; b=r/jF8prmHsSip06R58R9sPeY96
        ERqFUNTj6IUuU0ZPqqmKkyJyYWuHeObqmzlUv/ERzmSbX2Wpcggp4IceRC65H4y7VLHpmEtlp0YcQ
        Nl+4jonJ76J3Kmy8/9stxV0i8dlXd/e5LIW9ufSmPSw08FJv1mzIyRqGiCrUFHt9FK4sTzBVcs7M3
        6cc62PUrQHW+UKDujHzdx/kKkpQ91/IN2mEk7XVnm4SEh391P6WUiYJDxaTFVN0tGxNKni+MfwxlB
        /5BpJmB3McZVXMBjjbNhn5rA7vf66Zh3UYAWSCz+9lXHanuBIiPkSo0Lb9uForPMJUaKksQk37CV5
        mdK027tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lc-00846A-Hf; Thu, 28 Jan 2021 07:04:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/25] mm: Add folio_pgdat
Date:   Thu, 28 Jan 2021 07:03:41 +0000
Message-Id: <20210128070404.1922318-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just a convenience wrapper for callers with folios; pgdat can
be reached from tail pages as well as head pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f20504017adf..7d787229dd40 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1503,6 +1503,11 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 	return NODE_DATA(page_to_nid(page));
 }
 
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-- 
2.29.2

