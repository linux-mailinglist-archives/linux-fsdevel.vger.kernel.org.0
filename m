Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0E2D0F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgLGLfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLGLfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51896C061A52;
        Mon,  7 Dec 2020 03:34:30 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i3so6028315pfd.6;
        Mon, 07 Dec 2020 03:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0y+XXlhGalJMcAfPtOZoEyFt4J5WODB5ittFdj4EUc=;
        b=rWRkAEepoZ2AAXIS01SYEF9ocTxtc5cj/PFyxRiP37W7nq7Baq7lKLqQ1sovJAs//a
         d1zGmvUF7iz+BGuUZQV/x3/OWgGxZ4E7wXvRZkhRUY/MccWgFzrVjp+JaxSQpMhgj3S/
         ETYvw6meqsHRfGqjL0+qIm9fYduavZsTZkx11ljgBhgD+PZktQFe4FiX8UwISy1teSLt
         x10aQxM2etDIKPUlcc+xzqN2U3igNRSiFUiFiZ7DWpXSC1epub1tWNPs1sKaUeVMftWu
         g19anHRd+XMhMmIs4xMVQKHWUmqjfinlCw5B+IgBh6gxXvlvHMT+PYd+rjI2vYOikyBZ
         Ym4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0y+XXlhGalJMcAfPtOZoEyFt4J5WODB5ittFdj4EUc=;
        b=GKK+wFsRmHek6h+RycX/otK+WdB76cfnGkG372DdTy+YEYKIgQbkCd29t3CqoDS6Zd
         932OrL8Nx/XSyva+XgRX4K5BQQtfUnByUHy/XjeSE5tpfePUf7v/a8ntrv4Min0UayyZ
         Px7NN9vN2gu1Yc8e8l3f/+rJZcclW9OrwgbdoduJ0W4KcEe7a+4rewqTeKzGn0RILlDt
         NWDwqCYrg4qYEGfv/xn3ESYhtMzBJV9k3lC4xBbXIMxFq+Gw1Bp3z/1BZwCbsTBULSGw
         JaZHPCn7L6EYZimhbELOn+dpKu1FHcgeRhK6ERNyJ5JBXEtQzBu2MhYSOsDyh4a0tedr
         /Q6Q==
X-Gm-Message-State: AOAM530L63VBVTDXFrKO6//CNceOqU8nyQ4RKbU3H/54DpGV90I9Jk2S
        Ins1dPf8+9nDOOaqYUanNL0=
X-Google-Smtp-Source: ABdhPJxxb4HMiIpDPIafiIQODWbFpWWDR0MIcugLliMblGl9ynQK2cghFVJD2Y7Luh2Xq+P1vMYFgw==
X-Received: by 2002:a63:a551:: with SMTP id r17mr2997461pgu.13.1607340869896;
        Mon, 07 Dec 2020 03:34:29 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:29 -0800 (PST)
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
Subject: [RFC V2 15/37] mm: add pmd_special() check for pmd_trans_huge_lock()
Date:   Mon,  7 Dec 2020 19:31:08 +0800
Message-Id: <789d8a9a23887c20e4966b6e1c9b52a320ab87af.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

As dmem-pmd had been distinguished from thp-pmd, we need to add
pmd_special() such that pmd_trans_huge_lock could fetch ptl
for dmem huge pmd and treat it as stable pmd.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/huge_mm.h | 3 ++-
 mm/huge_memory.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa9..2514b90 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -242,7 +242,8 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)
+		|| pmd_devmap(*pmd) || pmd_special(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9474dbc..31f9e83 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1890,7 +1890,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
 	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+			pmd_devmap(*pmd) || pmd_special(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
-- 
1.8.3.1

