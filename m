Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF382B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfHFFje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:39:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:9169 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFje (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:39:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 22:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="164878104"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 22:39:32 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Date:   Tue,  6 Aug 2019 13:38:59 +0800
Message-Id: <20190806053859.2374-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Finally new_flags equals old vm_flags *OR* vm_flags.

It is not necessary to mask them first.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ccbdbd62f0d8..653d8f7c453c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
-		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
+		new_flags = vma->vm_flags | vm_flags;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
-- 
2.17.1

