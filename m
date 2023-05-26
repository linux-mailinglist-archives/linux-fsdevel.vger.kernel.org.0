Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F7712195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjEZH4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242581AbjEZH4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:56:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06819D;
        Fri, 26 May 2023 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5oQ2gGbUsqL42uQDz21dyQWBbUA0px4CnOLURAD/lus=; b=LdiDWYPfbsR2VwE3muTukBHf1n
        2WKuZw7xVn16RN6k6Wo9ylU0o5DsPwzzrnruYbzYdoYyEpJt744EXDXhFgaq3aPLQM0XtiDj2f8FP
        2plHBSw0sndtNX7DTHqerD4102mCieETYl1G0dRVa+cHO3vzNpp7xWDo8hVulJyMeNAOkZv4L98nW
        6TmrmiHMZRz3tMGsyF1olHjbXr53o35bSOXIQ23JnCL7T/TEVq47iBber3uY3gk1HYKtkAuea4Vam
        CYKjwRSPO0HEhImDxfLN6W/tI67qgSTWbDSI9uMVp9MT7NiJOiaImnK7AjLb+fCQHpyGYE6dCefwT
        r8p56qVA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SIj-001WZg-2T;
        Fri, 26 May 2023 07:55:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 1/8] page_flags: add is_folio_hwpoison()
Date:   Fri, 26 May 2023 00:55:45 -0700
Message-Id: <20230526075552.363524-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a helper similar to is_page_hwpoison() for folios
which tests the first head and if the folio is large any page in
the folio is tested for the poison flag.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/page-flags.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c68d67b832f..4d5f395edf03 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -883,6 +883,13 @@ static inline bool is_page_hwpoison(struct page *page)
 	return PageHuge(page) && PageHWPoison(compound_head(page));
 }
 
+static inline bool is_folio_hwpoison(struct folio *folio)
+{
+       if (folio_test_hwpoison(folio))
+               return true;
+       return folio_test_large(folio) && folio_test_has_hwpoisoned(folio);
+}
+
 /*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
-- 
2.39.2

