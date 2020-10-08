Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB9287028
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgJHHzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgJHHzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6DEC061755;
        Thu,  8 Oct 2020 00:55:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r21so228945pgj.5;
        Thu, 08 Oct 2020 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kQ4dDkDLHOzlM4Ta9v469E78PD4zk8EspT9PQyARZLY=;
        b=hRkiLiH0+aLvUr+ptwCCYLTMzxyBKI3GYqDPeHrkc4hbWYiT6E/f2CqdioEdWxlKj+
         2XiFq/vp8j5rdWQq1bCva2BQQpCsf/mR9MXEyGcEdUoNqlWzSpJiOasatdzC9aTMVqHz
         WYIetmFhyOW3djjHcdFyntUg1yDkLhjuhonsw56YGUVEVwX/8duLgqSG23irVJe0XyzC
         N4fjzcLferZEl6fW/7nGIbuTgs4reXHcLDd7ev3xioemq987V0KlJv+lDJ47Sx/afilE
         JJ1aDvayWG8IeG0hedKEzoGZsVZQSiaQ3vkB95yyhMJFRWNEnRETtN7+hj8hada0icYr
         jZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kQ4dDkDLHOzlM4Ta9v469E78PD4zk8EspT9PQyARZLY=;
        b=TntB9Do/uO34omUbIFPNXnsxmE1BeE2wytW31XPUHlQY1I8XPn5XG7uI82bO1BYgzp
         BCcJRLSlzNxvJuQ4jaz1X71NupYbl/CCnR5dblwlCMKDufiYT7+DojIOYFU0H2Uc4Nya
         8q9L+GH21WmJg/2e3xIN7mFgAX5q4KhIaMmJbw7MoN6C7cTQjsWhc/Xfr5u8LiS4Een3
         kjKwz28br+xp5+Ltt9OxVGOKWLUD62cCV26K/ujyPuHc5seJ4aNPF7pzve7WisvvH6RL
         AosyoHu+683fctiE+o72HrC0yKQDKCD22yFuSm3uLrzA4j+9Q9B0k+DhxB2M0bkALfMX
         iujA==
X-Gm-Message-State: AOAM533X4HLxgDzS0al7WePZNm0q3MmTtnFdlE3F5Qr+tSTGhkEAOPKR
        keiMoGPdY1SERYSdAhxwFTQ=
X-Google-Smtp-Source: ABdhPJzSNndYJoD0AFRNoT9OVm9MNcFwGIdF5qxtt+E7GlTYxmxn9Yu2qg+zTTrOA5HQ4PGvLzk2UQ==
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr7039002pjq.197.1602143702136;
        Thu, 08 Oct 2020 00:55:02 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:01 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 17/35] mm, dmemfs: support unmap_page_range() for dmemfs pmd
Date:   Thu,  8 Oct 2020 15:54:07 +0800
Message-Id: <267ac5a8b5f650d14667559495f6028a568abdd9.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
index 531493a0bc82..73af337b454e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1636,6 +1636,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
+	} else if (pmd_special(orig_pmd)) {
+		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..2d2c0f8a966b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1178,10 +1178,12 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
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
2.28.0

