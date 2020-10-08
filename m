Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6A428702B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgJHHzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgJHHyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F9C061755;
        Thu,  8 Oct 2020 00:54:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so3608934pgi.1;
        Thu, 08 Oct 2020 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=m3HbgxAAw1LnL8PrjK1o24gBOd5gcGd3+lSqErW1xWY=;
        b=XHWscIgwaSuZzQlbFX/OPJBp8f79yzfSB/JybRdJG16eDcNmJgjnc7ZrQE1TOUAQ6H
         97UMoo89Pgr0CCEL2NwB7LirEgxtSZ2yY4JB2sgMQ+ePkMXLNCmP1cnlXdP+D1yvCQjO
         mzt1xCdBaNAHwbX0XphJhhH3UK/KpkYKHehQuN8tqm1w6XF47mb+Y6Ss/QbB2O6umMiI
         dt/KydXVuix3o+JdPgYvSWbdho49YGQd4B2/nVngj8fTEUFaaribHtQZL/VTBk4sA411
         HdKlwjZ1X9x8329MGcOTUMuTUQOgl43/xOUvyRpcK/SZVrE181JZaWHIMmYkm2FKcIuL
         kBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m3HbgxAAw1LnL8PrjK1o24gBOd5gcGd3+lSqErW1xWY=;
        b=tQ3/9nLELhqkXY6SkU9exXkdfYml/k+hYQpjxuyXHZs3ETerHK2TlXxUDzetyCYHYZ
         6dOdgAFxnMDokJHnxSKHRiIdOKHacgAO7o+9zLhqmqulVXNYrB+VmdQTAMs3tqE9AJ5U
         qF/yws2yE+vpZJhVi8hdmCubfDY0ixhdZokAs/WRinS6DrwWrPeUAjOm+fX3xantNewE
         7ViAjELRwqwaQ9vY8x7DI/WqnN59DUraz1d6pQ+fF/TQpqAj0Xxg27/Q33zYkv3YmfLD
         L26L94HO4+Nw9w6+B9DK/cZEWNhiNFA4D2up5C6qJnQ80ScvVPxJiRYiG6TekY5F64Lk
         Wf5Q==
X-Gm-Message-State: AOAM533/D+s95P1M/lWuaMa/TuaV239FLsAHcMxo+CZEMK/hvxqFPA8a
        X5xlwPCOr+myUWN3RXV6yek=
X-Google-Smtp-Source: ABdhPJy4B1oPfec867V7HyuwKf/ugafGPnfGPMIKKLM3gAjTluU6/3ui2FYFXbSRkwOJFjbbiML0rw==
X-Received: by 2002:a17:90a:aa8a:: with SMTP id l10mr2570886pjq.9.1602143693663;
        Thu, 08 Oct 2020 00:54:53 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:53 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 15/35] mm: add pmd_special() check for pmd_trans_huge_lock()
Date:   Thu,  8 Oct 2020 15:54:05 +0800
Message-Id: <22298178ceab26491201b51a17f09b2283d655e8.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
index 8a8bc46a2432..b7381e5aafe5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -245,7 +245,8 @@ static inline int is_swap_pmd(pmd_t pmd)
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
index 7ff29cc3d55c..531493a0bc82 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1862,7 +1862,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
 	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+			pmd_devmap(*pmd) || pmd_special(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
-- 
2.28.0

