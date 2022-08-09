Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E00C58D209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 04:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiHICdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHICdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:33:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA518E32;
        Mon,  8 Aug 2022 19:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660012428; x=1691548428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DcvovoVmdksGZwiTR1O+x3IyDAP+vKNhNIIHB5O4qlY=;
  b=aGncczsdNhHTiFNVD1hCdACi/QIr/R+fJty7qOeBDrwle8r9Pc99g6Hb
   UcmhKVhj/Gs/aurxBizzWB+ayqynnCyOZDnhdnSVNEkbGaIwIs8Zb2YcD
   zk8AfcsJAXLyCqK3PGgMwHsyyt6BCW6jbv54E5XtBCzx7zyt8ik+rZQ0f
   tZ8MQwajePoFNJN7uPmQvCQlzqdk0tzemH0EJXUN6Q8TnCRWoLDB28qyD
   jA+FcjLaPSUU/x1Sdu6/MfCeFMBa5fOPDKKPXiDni1KYbXy2SaWns/97H
   ojBAAKqj6BD9wQBM6eLk7PFpdnxBJkpLi0oyE6QAAoREX3ikKYi6sj6Yq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="290742538"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="290742538"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 19:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="932311003"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 19:33:46 -0700
From:   shaoqin.huang@intel.com
To:     linux-mm@kvack.org, willy@infradead.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] filemap: Convert page_endio() to use a folio
Date:   Tue,  9 Aug 2022 10:32:56 +0800
Message-Id: <20220809023256.178194-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Replace three calls to compound_head() with one.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 mm/filemap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..cb740a6b7227 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1633,24 +1633,26 @@ EXPORT_SYMBOL(folio_end_writeback);
  */
 void page_endio(struct page *page, bool is_write, int err)
 {
+	struct folio *folio = page_folio(page);
+
 	if (!is_write) {
 		if (!err) {
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
+			folio_clear_uptodate(folio);
+			folio_set_error(folio);
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 	} else {
 		if (err) {
 			struct address_space *mapping;
 
-			SetPageError(page);
-			mapping = page_mapping(page);
+			folio_set_error(folio);
+			mapping = folio_mapping(folio);
 			if (mapping)
 				mapping_set_error(mapping, err);
 		}
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(page_endio);
-- 
2.30.2

