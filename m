Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009D6783D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjAWR71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAWR71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:59:27 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713502CFC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:59:25 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 4EC195616BD9; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 04/20] mm: invoke madvise for all vmas in scan_get_next_rmap_item
Date:   Mon, 23 Jan 2023 09:37:32 -0800
Message-Id: <20230123173748.1734238-5-shr@devkernel.io>
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

If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
over all the vmas and enable ksm if possible. For the vmas that can be
ksm enabled this is only done once.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 83796328574c..967eda719fab 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1013,6 +1013,7 @@ static int unmerge_and_remove_all_rmap_items(void)
=20
 			mm_slot_free(mm_slot_cache, mm_slot);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
 		} else
 			spin_unlock(&ksm_mmlist_lock);
@@ -2243,6 +2244,17 @@ static struct ksm_rmap_item *get_next_rmap_item(st=
ruct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
=20
+static bool vma_ksm_mergeable(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_MERGEABLE)
+		return true;
+
+	if (test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
+		return true;
+
+	return false;
+}
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2319,8 +2331,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_it=
em(struct page **page)
 		goto no_vmas;
=20
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_ksm_mergeable(vma))
 			continue;
+		if (!(vma->vm_flags & VM_MERGEABLE)) {
+			unsigned long flags =3D vma->vm_flags;
+
+			/* madvise failed, use next vma */
+			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &fla=
gs))
+				continue;
+			/* vma, not supported as being mergeable */
+			if (!(flags & VM_MERGEABLE))
+				continue;
+
+			vma->vm_flags =3D flags;
+		}
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address =3D vma->vm_start;
 		if (!vma->anon_vma)
@@ -2389,6 +2413,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 		mm_slot_free(mm_slot_cache, mm_slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
--=20
2.30.2

