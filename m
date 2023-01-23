Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A0678422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjAWSGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjAWSGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:06:34 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90331E14
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 10:06:14 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 45FC35616BD5; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 02/20] mm: add flag to __ksm_enter
Date:   Mon, 23 Jan 2023 09:37:30 -0800
Message-Id: <20230123173748.1734238-3-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change adds the flag parameter to __ksm_enter. This allows to
distinguish if ksm was called by prctl or madvise.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/ksm.h | 6 ++++--
 mm/ksm.c            | 9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 7e232ba59b86..50e6b56092f3 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -18,13 +18,15 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
-int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
+int __ksm_enter(struct mm_struct *mm, int flag);
=20
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm=
)
 {
+	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
+		return __ksm_enter(mm, MMF_VM_MERGE_ANY);
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
-		return __ksm_enter(mm);
+		return __ksm_enter(mm, MMF_VM_MERGEABLE);
 	return 0;
 }
=20
diff --git a/mm/ksm.c b/mm/ksm.c
index dd02780c387f..d84a244fe224 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2493,8 +2493,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 			return 0;
 #endif
=20
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err =3D __ksm_enter(mm);
+		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags) &&
+		    !test_bit(MMF_VM_MERGE_ANY, &mm->flags)) {
+			err =3D __ksm_enter(mm, MMF_VM_MERGEABLE);
 			if (err)
 				return err;
 		}
@@ -2520,7 +2521,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigne=
d long start,
 }
 EXPORT_SYMBOL_GPL(ksm_madvise);
=20
-int __ksm_enter(struct mm_struct *mm)
+int __ksm_enter(struct mm_struct *mm, int flag)
 {
 	struct ksm_mm_slot *mm_slot;
 	struct mm_slot *slot;
@@ -2553,7 +2554,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	set_bit(MMF_VM_MERGEABLE, &mm->flags);
+	set_bit(flag, &mm->flags);
 	mmgrab(mm);
=20
 	if (needs_wakeup)
--=20
2.30.2

