Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E784A78CC42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbjH2ShV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjH2ShQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:37:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111819A;
        Tue, 29 Aug 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693334232; x=1724870232;
  h=from:to:cc:subject:date:message-id;
  bh=37xlcaOtL6KOTBNqSaqyUovRmlSDjWqMKlcT72bG2cc=;
  b=FmjSVKC2d2avRLhqJ3lZ/lA/Tm5E9vtVfUZbES2jVlVemPMwxDtTK5wO
   ywvsSqfJcuf9cEfb3G3ztwOn3/tbFZ9UzC5ARmPVA2gNVGr8O9iN5QeNN
   uZ1OdHYtrFcdLNbUE061WfSLRBkiFsSqS7COC/tb7z08JdTnrcXrq+eQG
   nxtrbyCuyR5TWPKh6eEKHuWMLAomSz76EwabV1qtp59mrCepPKPLi4GYT
   hQCgwyqBsbcqLCRD5TUvwVFIGRbd89lrFjiCiNyiRUpc/L7C30dTqqOPu
   Fp+U5004Pz4mRE3FHUtt9qxLQY9fUI7IJvwEtZ36Ju97O31jGxfIPCv42
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379213495"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="379213495"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 11:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715641490"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="715641490"
Received: from leihuan1-mobl.amr.corp.intel.com (HELO localhost.localdomain.localdomain) ([10.92.27.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 11:37:09 -0700
From:   Lei Huang <lei.huang@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     lei.huang@linux.intel.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
Date:   Tue, 29 Aug 2023 14:36:33 -0400
Message-Id: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Our user space filesystem relies on fuse to provide POSIX interface.
In our test, a known string is written into a file and the content
is read back later to verify correct data returned. We observed wrong
data returned in read buffer in rare cases although correct data are
stored in our filesystem.

Fuse kernel module calls iov_iter_get_pages2() to get the physical
pages of the user-space read buffer passed in read(). The pages are
not pinned to avoid page migration. When page migration occurs, the
consequence are two-folds.

1) Applications do not receive correct data in read buffer.
2) fuse kernel writes data into a wrong place.

Using iov_iter_extract_pages() to pin pages fixes the issue in our
test.

An auxiliary variable "struct page **pt_pages" is used in the patch
to prepare the 2nd parameter for iov_iter_extract_pages() since
iov_iter_get_pages2() uses a different type for the 2nd parameter.

Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
---
 fs/fuse/file.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bc41152..715de3b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -670,7 +670,7 @@ static void fuse_release_user_pages(struct fuse_args_pages *ap,
 	for (i = 0; i < ap->num_pages; i++) {
 		if (should_dirty)
 			set_page_dirty_lock(ap->pages[i]);
-		put_page(ap->pages[i]);
+		unpin_user_page(ap->pages[i]);
 	}
 }
 
@@ -1428,10 +1428,13 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
 		unsigned npages;
 		size_t start;
-		ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
-					*nbytesp - nbytes,
-					max_pages - ap->num_pages,
-					&start);
+		struct page **pt_pages;
+
+		pt_pages = &ap->pages[ap->num_pages];
+		ret = iov_iter_extract_pages(ii, &pt_pages,
+					     *nbytesp - nbytes,
+					     max_pages - ap->num_pages,
+					     0, &start);
 		if (ret < 0)
 			break;
 
-- 
1.8.3.1

