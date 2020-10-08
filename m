Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED53F287032
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgJHHzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgJHHzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F3C0613D9;
        Thu,  8 Oct 2020 00:55:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r21so230278pgj.5;
        Thu, 08 Oct 2020 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=O7KgnpfqtBbUkq2cDwxXf9kTKX6Grw9EaxzUExBq/K0=;
        b=b8NBVz8LhXuNHd+ITvEO/nDSIRbO/9WK+JDJ/Ktk2N795T1Tgth+QBzhTxqop9dY/s
         laiCXpKPS3kwHQuF7eNL68OOeQ0YHZ3kGJMKusmfdBuhJkjmk9AzebE/2Bp6pW8AS7Dd
         aeEx2fBGaD5hG56qmFpGOn0GbF7vBgNYod8nPwq1YPRPBpw8s7SZe0GWl6X1RFALUZ4j
         a7eETflyj4nJwnwKgSiQnfC/IQecHabDHGkT9OQvruDzUK72bs5rLWBgXVPrYI4HqK4m
         TetiBM5DPcwJJPC6H2GKJ47jHr0IvkLo9UA5sxztR0vk09CA4bUBGoHWcBteo0pmz0A8
         IIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=O7KgnpfqtBbUkq2cDwxXf9kTKX6Grw9EaxzUExBq/K0=;
        b=FTzbSPXTy9TRy3EV4Ho1qLj20xJaJb72jecG2Hgl5CCc9EuI9hfZJQ1wEw+gfx0+zx
         GqXf4q77qyW3cyO6IE33/nT+hwPlRwxJOgZ5q1Rksa7bMgX6c6NkAnMksFzqslJY2f4O
         6dtT85NtKSJaji3o0ZtgMeXOZKgr6D+DWMquKRLQvUaxFz6QHEPVnncVZDeMdsSm/9bQ
         q1O2akbmRYoSWPOB0FZDk9yBxE57/389ToK4KDfjn8XYLdo02rNG8ek2V84HPLY4/xtV
         0zdE4SDYn4j4E8g3fLgfOCmq4Da05uHqivw1YExJ1NurdQNNXFRLCb7KBUUOMhztydGK
         G/3g==
X-Gm-Message-State: AOAM532rc0fl3PlOHAuolaAq7dhXOBE3admF19aw9uKJ21Xu1x8YPmRt
        NX8ABmE9mEQuqd9f5jqA+7I=
X-Google-Smtp-Source: ABdhPJyleLfKb682LDA69C1U3Po3BXYpQi6U+mncLSpwR3jjSMwK/hu67zP7yA4aOc9mj30ghga09A==
X-Received: by 2002:a17:90a:7d16:: with SMTP id g22mr6887590pjl.135.1602143735614;
        Thu, 08 Oct 2020 00:55:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:35 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 25/35] mm, x86, dmem: fix estimation of reserved page for vaddr_get_pfn()
Date:   Thu,  8 Oct 2020 15:54:15 +0800
Message-Id: <edeca65717832fe02825ff87a08c3c2d95d577c7.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Fix estimation of reserved page for vaddr_get_pfn() and
check 'ret' before checking writable permission

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5fbf0c1f7433..257a8cab0a77 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -471,6 +471,10 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 		if (ret == -EAGAIN)
 			goto retry;
 
+		if (!ret && (prot & IOMMU_WRITE) &&
+		    !(vma->vm_flags & VM_WRITE))
+			ret = -EFAULT;
+
 		if (!ret && !is_invalid_reserved_pfn(*pfn))
 			ret = -EFAULT;
 	}
-- 
2.28.0

