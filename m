Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636182C7789
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 05:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgK2EhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 23:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgK2EhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 23:37:20 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECBC0613D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:39 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so8253275oty.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q086GncpPt5RZ5GGX1HkBX2M6Dm58Is22dESYRZ6G14=;
        b=GKb6KyglO2akYr94KQz9x9N9j9MmxWh3b3TolI1AKHUlD/+MP2xXoE8cw3rgtvFg+p
         wbhx97+fIC2JSiuKI5IOjMD+I6h1RoaVP2a3fSDGC4rz1UYMIg8TFeWlBH3KelMsrBIj
         C7U5GbKRKKGT452n2aqevAyQrXq9UZ2L9AdujGw+c/bFSYOFwmkaYT2Q3nZIaLzsGPlC
         S4ZvmqlFEYQROEeo/IMhlpdUAITwrGCqhOObYLZZapqjF+cSw6hB5qAMAB4sAEEGPfXF
         vaG7euhsSvAEnvSyYUxDrcmrAJNeb6zT+BBzjmnZCJG4a91nMkoaoFQ0YgFhvFYYZm4P
         bQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q086GncpPt5RZ5GGX1HkBX2M6Dm58Is22dESYRZ6G14=;
        b=d80rq50BgRWNKtI0uID15Tr+ndvdVPxZhHc+wLiPvk64f6PVuCEZK0zXzlVDTgaPlT
         8CABD72P8NMRUo6MIip3ZQG8jqnh/IzONH0P94vJ4ludbqr3/TUh+cDnIOu16c/UVgCs
         JzAYC5qTLtqho9sp38+2jXuBLVhB5RCM7SHdI2YHJbszLmOVjIvwtoNilWj7DIMRhw+t
         Uinq44uggBW/7ptIMQ2Rw4N1LoHGeU1wVSDY1iP2f6Pi6EZz+ud+yPCnMD+y3xStuTLi
         un0PL/ICqSw3OVnJrmzs+9FcAKw2w9KrFzcbULK1lDUESG8M09jI1DX51XVlqMOIWjma
         GrYA==
X-Gm-Message-State: AOAM533uP54jqcc9534007qYQgfU92bzCpsDuOFwnLRaXoQOlKNXb2fo
        9+zIKEqbPzpDQBKyTQL1bog/3+IRdTTcdfdaGfw5M170POs7hg==
X-Google-Smtp-Source: ABdhPJxvcLhJ4FJtXq+ZvQXqChF8Ekt+OsSPE4XGv6LMM0bnoc9AeEaH9ZTveYnFgh6A2fhDN7D0b5KaXE1cBV93ioc=
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr11388742otq.254.1606624599312;
 Sat, 28 Nov 2020 20:36:39 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sat, 28 Nov 2020 20:36:29 -0800
Message-ID: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
Subject: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from DAX_ZERO_PAGE
 to XA_ZERO_ENTRY
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DAX uses the DAX_ZERO_PAGE bit to represent holes in files. It could also use
a single entry, such as XArray's XA_ZERO_ENTRY. This distinguishes zero pages
and allows us to shift DAX_EMPTY down (see patch 2/3).

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..fa8ca1a71bbd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -77,9 +77,14 @@ fs_initcall(init_dax_wait_table);
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
 #define DAX_PMD        (1UL << 1)
-#define DAX_ZERO_PAGE    (1UL << 2)
 #define DAX_EMPTY    (1UL << 3)

+/*
+ * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
+ * definition helps with checking if an entry is a PMD size.
+ */
+#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
+
 static unsigned long dax_to_pfn(void *entry)
 {
     return xa_to_value(entry) >> DAX_SHIFT;
@@ -114,7 +119,7 @@ static bool dax_is_pte_entry(void *entry)

 static int dax_is_zero_entry(void *entry)
 {
-    return xa_to_value(entry) & DAX_ZERO_PAGE;
+    return xa_to_value(entry) & (unsigned long)XA_ZERO_ENTRY;
 }

 static int dax_is_empty_entry(void *entry)
@@ -738,7 +743,7 @@ static void *dax_insert_entry(struct xa_state *xas,
     if (dirty)
         __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);

-    if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
+    if (dax_is_zero_entry(entry) && !(flags & (unsigned long)XA_ZERO_ENTRY)) {
         unsigned long index = xas->xa_index;
         /* we are replacing a zero page with block mapping */
         if (dax_is_pmd_entry(entry))
@@ -1047,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
     vm_fault_t ret;

     *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-            DAX_ZERO_PAGE, false);
+            XA_ZERO_ENTRY, false);

     ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
     trace_dax_load_hole(inode, vmf, ret);
@@ -1434,7 +1439,7 @@ static vm_fault_t dax_pmd_load_hole(struct
xa_state *xas, struct vm_fault *vmf,

     pfn = page_to_pfn_t(zero_page);
     *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-            DAX_PMD | DAX_ZERO_PAGE, false);
+            XA_ZERO_PMD_ENTRY, false);

     if (arch_needs_pgtable_deposit()) {
         pgtable = pte_alloc_one(vma->vm_mm);
-- 
2.29.2
