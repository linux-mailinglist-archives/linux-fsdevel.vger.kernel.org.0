Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362B5FF74E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJNX6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNX6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CFAB836
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791893; x=1697327893;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6C7Qe8Q1GJpUot5lHXs4yvkjjX4IgtewPJJUoytmac=;
  b=E3PtXa9nJtt3AtuIvPKPplQQhtGlf/iW1B5m9a44Ul6jWyRKKxq6WoOH
   eskoFEaf/SKo3LUebFUFFvPgoIAc3tfrMuXEDew4bdR8xwFR4aqSCVJNe
   +kCdqWB9BRm6WinTgk0QkOeJh9Jtm1yKUNnvTvZs72F3hbxIvEdeEdEIe
   Or4sCcXzsNAIlD5sxdsaB5yF+7VDTokJwKXrkfdGQxMHworJDv5f6eknU
   l6cn1778XAVphJccVt8l1rhVKqqr4tpln65fAz09usMPSDL2ZqNw53cWl
   tN3APzDziMsTo1qtBrGR5q/4H90BSu/mq2rh1X5go5gV/w/u7nC3JPikv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="306580615"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="306580615"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113423"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113423"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:08 -0700
Subject: [PATCH v3 12/25] fsdax: Cleanup dax_associate_entry()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:58:07 -0700
Message-ID: <166579188791.2236710.2590200540568819339.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass @vmf to drop the separate @vma and @address arguments to
dax_associate_entry(), use the existing DAX flags to convey the @cow
argument, and replace the open-coded ALIGN().

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 73e510ca5a70..48bc43c0c03c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -406,8 +406,7 @@ static struct dev_pagemap *folio_pgmap(struct folio *folio)
  */
 static vm_fault_t dax_associate_entry(void *entry,
 				      struct address_space *mapping,
-				      struct vm_area_struct *vma,
-				      unsigned long address, bool cow)
+				      struct vm_fault *vmf, unsigned long flags)
 {
 	unsigned long size = dax_entry_size(entry), index;
 	struct folio *folio;
@@ -416,9 +415,9 @@ static vm_fault_t dax_associate_entry(void *entry,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return 0;
 
-	index = linear_page_index(vma, address & ~(size - 1));
+	index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
 	dax_for_each_folio(entry, folio, i)
-		if (cow) {
+		if (flags & DAX_COW) {
 			dax_mapping_set_cow(folio);
 		} else {
 			WARN_ON_ONCE(folio->mapping);
@@ -992,8 +991,7 @@ static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		ret = dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				cow);
+		ret = dax_associate_entry(new_entry, mapping, vmf, flags);
 		if (ret)
 			goto out;
 		/*

