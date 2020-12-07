Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A32D0F80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLGLfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLGLfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D3C0613D1;
        Mon,  7 Dec 2020 03:34:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2so5721926pfq.5;
        Mon, 07 Dec 2020 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3L3i0S6/nYZYxaW9mSnagt8eN+myZy0Uq4CS77lTAc=;
        b=M9bgqlb46kjnGVIXaRr/XrGDP6bC/rLRPYv7m3v/0Tiu7JDV84U0SZvFNZ7h9g0mEN
         bBxITDw2c/WSRAvLCXDehd3vLLN3xOZRGtx8xAdqFPlUtgf0NDSnl/cm4DQU6HYdhqnj
         XIE3zBNV6Shsi00GD7rhQ9OGpYBEFRA6EJNcBupMSM4kBJ3vqmJbFJ17uokCJLONmFvj
         j4aheVme/XXOMbJUFyX8F9Y/uo/0tsBnYn38LCXo3jZ2xdS+c3YRz1/eIOr1BvC5G/96
         NWHaYdsbBaoLmjFo6L3oHM36BEKSsWUTu6v9jm+USREYts6euWqrB7FGFAV22r22MwIS
         C6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3L3i0S6/nYZYxaW9mSnagt8eN+myZy0Uq4CS77lTAc=;
        b=PIpOLtjXtrNPln++qskdsOI2faEjIOAYIbcM60aI4+bzQ5uV3y9FTQvj8z/JlrFB1v
         7Dn56AMP+MY7hFCQvhhJ16CdoJFybYFW/ZsDphqvk/UVxSnj7Sc3+ZOIpFNwnawq+pKe
         bPWRyFljNwBiGYVchd5bB6cQCYQt7HIBoPll2B9Xtp/KtGQZen+hxDgzbT8vdpG/I4OC
         9PM3PxDrTQBgTNKVrfkwoI/v3BFrgKXsbpZDn2lKah8DXQl+0follkBySq9IQC0MrDeI
         uvuwtKrvezj0UF36hvGuzL6q7aXaGSA6ODZx0wcclYxUw521r3hIBcsu06fcsqxqatWR
         hnNg==
X-Gm-Message-State: AOAM5323SpCsAN/2yxKnJxaLH9uAulB+zMY8sZpGn5w0pqyMsYlLtjue
        EJXqIAbPawFXlDZ9zqN7jj4=
X-Google-Smtp-Source: ABdhPJxAoj+fbea/saUCeXAmigtbj1zZV+shVlXg+5snAfgXq3xCMvRxVvmTAbjuFi907z6lXAIqyA==
X-Received: by 2002:a63:494f:: with SMTP id y15mr17974005pgk.364.1607340877090;
        Mon, 07 Dec 2020 03:34:37 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:36 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 17/37] mm, dmemfs: support unmap_page_range() for dmemfs pmd
Date:   Mon,  7 Dec 2020 19:31:10 +0800
Message-Id: <e892eddd8beefeddb2b5f7de37f8213e171e72d7.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It is required by munmap() for dmemfs mapping.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/huge_memory.c | 2 ++
 mm/memory.c      | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31f9e83..2a818ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1664,6 +1664,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
+	} else if (pmd_special(orig_pmd)) {
+		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
diff --git a/mm/memory.c b/mm/memory.c
index c48f8df..6b60981 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1338,10 +1338,12 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE)
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
+			pmd_devmap(*pmd) || pmd_special(*pmd)) {
+			if (next - addr != HPAGE_PMD_SIZE) {
+				VM_BUG_ON(pmd_special(*pmd));
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
-			else if (zap_huge_pmd(tlb, vma, pmd, addr))
+			} else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
 			/* fall through */
 		}
-- 
1.8.3.1

