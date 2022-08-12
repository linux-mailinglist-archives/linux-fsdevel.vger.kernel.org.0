Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956BB590972
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 02:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiHLAJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLAJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:09:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7D9FABA;
        Thu, 11 Aug 2022 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660262966; x=1691798966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dsy5j9GJ9M9Knk+/PO+G4slSOO2sVbq/4qP0MG9CW6U=;
  b=Oblv/5QaXu4i8ObtwofoT/v0uml432n6t99/qgaFDR/e0LemY5sqjQ6o
   vsQyvWCiNUg1mgXVKg1/ccr7ir349+3z6g/6F5umcpqboTyDQv3odTDCK
   OX3G5GM5u5l/BolLJen7XEhS2W+1wFi2soHtg04D4tOAPWFZe+kMwIQXm
   gqIr3sIqjwqGDFnlGQsMKDysX0XtYSchD74QHZHWm+KJIdFUpsw+0C96V
   tqgbHhinipPCHBdgT5cRrIzbt9Pq916+9uPuCBgL3I6QEaIALTQCBF9Lz
   wLkK+dZ8lFA2m8GvF1yjp5N0/HACzbqb2b5Ya7U6yDwzWWQ9gRjc9u6eP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292751787"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292751787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:09:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="634445244"
Received: from lewischa-mobl.amr.corp.intel.com (HELO localhost) ([10.212.100.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:09:25 -0700
From:   ira.weiny@intel.com
To:     Kees Cook <keescook@chromium.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/exec: Test patch for syzkaller crash
Date:   Thu, 11 Aug 2022 17:09:19 -0700
Message-Id: <20220812000919.408614-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Kees reported that it looked like the kmap_local_page() conversion in
fs/exec.c was causing a crash with the syzkaller.[1]

At first glance it appeared this was due to the lack of pagefaults not
being disabled as was done by kmap_atomic().

Unfortunately, after deeper investigation we don't see how this is a
problem.  The crash does not appear to be happening in the
memcpy_to_page() call.[2]

For testing, add back pagefault disable in copy_string_kernel() to see
if it makes syzkaller happy.  If so more investigation will need to be
done to understand exactly what is happening.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6e8e36c6ae4b11bed5643317afb66b6c3cadba8
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/exec.c?id=40d43a7507e1547dd45cb02af2e40d897c591870#n616

Cc: Kees Cook <keescook@chromium.org>
Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index b51dd14e7388..e076b228123a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -640,7 +640,9 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 		if (!page)
 			return -E2BIG;
 		flush_arg_page(bprm, pos & PAGE_MASK, page);
+		pagefault_disable();
 		memcpy_to_page(page, offset_in_page(pos), arg, bytes_to_copy);
+		pagefault_enable();
 		put_arg_page(page);
 	}
 
-- 
2.35.3

