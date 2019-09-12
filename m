Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A62B15D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfILVbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 17:31:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:38897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfILVbo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:31:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 14:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176092119"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2019 14:31:41 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/3] fs/userfaultfd.c: remove a redundant check on end
Date:   Fri, 13 Sep 2019 05:31:08 +0800
Message-Id: <20190912213110.3691-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the ending vma, there is a check to make sure the end is huge page
aligned.

The *if* check makes sure vm_start < end <= vm_end. While the first half
is not necessary, because the *for* clause makes sure vm_start < end.

This patch just removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 fs/userfaultfd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 653d8f7c453c..9ce09ac619a2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1402,8 +1402,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * If this vma contains ending address, and huge pages
 		 * check alignment.
 		 */
-		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end &&
-		    end > cur->vm_start) {
+		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end) {
 			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
 
 			ret = -EINVAL;
-- 
2.17.1

