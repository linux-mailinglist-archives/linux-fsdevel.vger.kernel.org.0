Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617964DA3D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351673AbiCOUTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOUTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:19:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4D1AD98;
        Tue, 15 Mar 2022 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647375484; x=1678911484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vuA7XbnQ6rC1+p0Fyp1Bl6T35Kp8er8BP8rVhhABkRQ=;
  b=fHwtdUZhoJ7MAL/D6Dq6W/vNcBwZCyHh5OYgonrFSpiz299HVnptC5Gy
   VU83VXAsqqfEJmNeRee6l96kL4wdAnMN3FfLTKPMhuIA+rD5xtZhckpQx
   RBg3Q9fhE+mqDlrCCkIf976U/73Lyxy1U5SI5Pq9RK0oKAbcylFW71R6q
   7owdmAH/drF82BQJktjk6zHVnCB31O3hV/gzzKzeVrQelakH9wFGxM9VC
   T5MZ1Z878kTmqQbL7ThU5XcMxr9ap4/t22g/rELC0/4iTT1tRVEY2wrff
   gQbC+Hf4v1VYr5HW66zhJOQEQinSVVFPivj6y6jrYseqb1Wf7ygozn7j2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319634461"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="319634461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="598448328"
Received: from anirudhk-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.229.227])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:18:02 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 3/3] elf: Don't write past end of notes for regset gap
Date:   Tue, 15 Mar 2022 13:17:06 -0700
Message-Id: <20220315201706.7576-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fill_thread_core_info() the ptrace accessible registers are collected
to be written out as notes in a core file. The note array is allocated
from a size calculated by iterating the user regset view, and counting the
regsets that have a non-zero core_note_type. However, this only allows for
there to be non-zero core_note_type at the end of the regset view. If
there are any gaps in the middle, fill_thread_core_info() will overflow the
note allocation, as it iterates over the size of the view and the
allocation would be smaller than that.

There doesn't appear to be any arch that has gaps such that they exceed
the notes allocation, but the code is brittle and tries to support
something it doesn't. It could be fixed by increasing the allocation size,
but instead just have the note collecting code utilize the array better.
This way the allocation can stay smaller.

Even in the case of no arch's that have gaps in their regset views, this
introduces a change in the resulting indicies of t->notes. It does not
introduce any changes to the core file itself, because any blank notes are
skipped in write_note_info().

This fix is derrived from an earlier one[0] by Yu-cheng Yu.

[0] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 fs/binfmt_elf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d61543fbd652..a48f85e3c017 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1757,7 +1757,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 				 const struct user_regset_view *view,
 				 long signr, size_t *total)
 {
-	unsigned int i;
+	unsigned int note_iter, view_iter;
 
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
@@ -1777,11 +1777,11 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 
 	/*
 	 * Each other regset might generate a note too.  For each regset
-	 * that has no core_note_type or is inactive, we leave t->notes[i]
-	 * all zero and we'll know to skip writing it later.
+	 * that has no core_note_type or is inactive, skip it.
 	 */
-	for (i = 1; i < view->n; ++i) {
-		const struct user_regset *regset = &view->regsets[i];
+	note_iter = 1;
+	for (view_iter = 1; view_iter < view->n; ++view_iter) {
+		const struct user_regset *regset = &view->regsets[view_iter];
 		int note_type = regset->core_note_type;
 		bool is_fpreg = note_type == NT_PRFPREG;
 		void *data;
@@ -1800,10 +1800,11 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		if (is_fpreg)
 			SET_PR_FPVALID(&t->prstatus);
 
-		fill_note(&t->notes[i], is_fpreg ? "CORE" : "LINUX",
+		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
 			  note_type, ret, data);
 
-		*total += notesize(&t->notes[i]);
+		*total += notesize(&t->notes[note_iter]);
+		note_iter++;
 	}
 
 	return 1;
-- 
2.17.1

