Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA334DCEB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 20:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiCQTWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 15:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiCQTWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:22:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987EF217C4B;
        Thu, 17 Mar 2022 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647544854; x=1679080854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QU6YvTP+bB5yf7tpy5uOwiY93U+qrXGuI90qWlAUTcw=;
  b=WSYTJoOskNidVDMHVX0S6fATLMED0LqKWMYDYeldza9JcNkO5G5UVQfH
   5JH0/PIqACk8YM2mNpLBODSb/PJFvZ2OH1Ql0YFnQWrniD1zVduPsKRss
   I54QN9TiZE4rMWc3br/tvkTcdS+HFAItlAV/s+Dozk/mSARcOwsYT3avD
   Md+G6zkpqntmgL3JQv4qgcbNCAC6BA2DUgDhocWNIUjZrLCXiboplXykV
   hSDqQVUP2t7I/G8CDakqLFFf/78oKkDmufhdzJbHZ2I5Sm3RmxuY7aYHv
   fl3Ii5AV6x6HMJO4qLyM/HvYizmdLt9A1cUWHAYOlWMwSvEsZeRVuD/rD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257150095"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257150095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="691054864"
Received: from awyatt-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.178.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 12:20:52 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 3/3] elf: Don't write past end of notes for regset gap
Date:   Thu, 17 Mar 2022 12:20:13 -0700
Message-Id: <20220317192013.13655-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

In case, the allocation logic between fill_note_info() and
fill_thread_core_info() ever diverges from the usage logic, warn and skip
writing any notes that would overflow the array.

This fix is derrived from an earlier one[0] by Yu-cheng Yu.

[0] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Warn and break out of the note collecting loop if the allocation would
   overflow. Note: I tweaked it slightly to do break instead of continue
   and to do it before SET_PR_FPVALID(). (Kees)

 fs/binfmt_elf.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d61543fbd652..7899b42700b4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1755,9 +1755,9 @@ static void do_thread_regset_writeback(struct task_struct *task,
 
 static int fill_thread_core_info(struct elf_thread_core_info *t,
 				 const struct user_regset_view *view,
-				 long signr, size_t *total)
+				 long signr, struct elf_note_info *info)
 {
-	unsigned int i;
+	unsigned int note_iter, view_iter;
 
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
@@ -1771,17 +1771,17 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
 		  PRSTATUS_SIZE, &t->prstatus);
-	*total += notesize(&t->notes[0]);
+	info->size += notesize(&t->notes[0]);
 
 	do_thread_regset_writeback(t->task, &view->regsets[0]);
 
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
@@ -1797,13 +1797,17 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		if (ret < 0)
 			continue;
 
+		if (WARN_ON_ONCE(note_iter >= info->thread_notes))
+			break;
+
 		if (is_fpreg)
 			SET_PR_FPVALID(&t->prstatus);
 
-		fill_note(&t->notes[i], is_fpreg ? "CORE" : "LINUX",
+		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
 			  note_type, ret, data);
 
-		*total += notesize(&t->notes[i]);
+		info->size += notesize(&t->notes[note_iter]);
+		note_iter++;
 	}
 
 	return 1;
@@ -1883,7 +1887,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	 * Now fill in each thread's information.
 	 */
 	for (t = info->thread; t != NULL; t = t->next)
-		if (!fill_thread_core_info(t, view, siginfo->si_signo, &info->size))
+		if (!fill_thread_core_info(t, view, siginfo->si_signo, info))
 			return 0;
 
 	/*
-- 
2.17.1

