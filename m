Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7228701F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgJHHzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJHHzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32CAC0613D7;
        Thu,  8 Oct 2020 00:55:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so2377986plo.1;
        Thu, 08 Oct 2020 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=c062z9g3gnR/I/VUW1enDVKC1CGF86sFMeBq5UIH9yE=;
        b=YMmnkQY3sdDOJ3lcgij0sPB7c7ws9B6hcVk1g8V14rp2oxxDebPKq+JUdKAtN4cxzs
         ebywEZ0+hJZUFFVGTNaWRqx5PueuG6qdWRvf+CDAP0N1zQ5wCM5HyFDkbjFskuP5YA+r
         QGSHPQj2HIxoU578u/gHISDs1ANCxD42EDBnZe44TL3/1MnICrEC1x0rU2Us0scHsDf3
         jCPWqUl0bbvjvaim6QqJSf2svvXMY5Rk0pWiakSCe3BU3akz8vFMtljZHwUl9Xq4qkN7
         jZikO0yA8kldHbQHXVbc7yb5OlzxOwIvcOYDOBFJpaDjNHlMmAEBHrKBD6zY1zQ5MlGn
         ZSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=c062z9g3gnR/I/VUW1enDVKC1CGF86sFMeBq5UIH9yE=;
        b=A5xjseC8YoHBBuJG62CjlwSD/bZR/8KWkljFGHFICCvPxEOA0iokWW9eZ5DLZ6oZO/
         QkuZMUPUM6utNBfbDU95CGgghjWOYh/RMjq/IN7/KMB80pEzBNsMKQ2wD9Yr2/P9SYAk
         hb7KO+zc/kpgYiUAywlw3YXZmriv7pMmwSBhv8YK1vsA46+MXsQR+gpDaIHMshE36u0S
         nIJKIV6rxpxUWPbGlovWAIR4ZRPNHSiBjfP58n6kAT5zFvlensliJ7BPRs9jsIX/Nmmp
         dZb1wNM8vjs/EQmMLqZVPfNP0901CfUfVGvxsnFMadO6oxAI8/tMRxbphJLLz0AdDs2L
         E0pg==
X-Gm-Message-State: AOAM530F6r5OL3+FesqlY1Y/NQFnUyox499DT8wKbLlLBIcmE1C7AMFb
        CjCJujF4Kb6SsZ4puWuUJieP4CiqDquopQ==
X-Google-Smtp-Source: ABdhPJyK3jBEUk5kmaNd3EMLrw1C6cs+jFaf0qoSfvtLS36XRmTpxY9vYJHnrbHwlszIGh7v3DmGQw==
X-Received: by 2002:a17:902:a9cc:b029:d3:77f7:3ca9 with SMTP id b12-20020a170902a9ccb02900d377f73ca9mr6536321plr.75.1602143706251;
        Thu, 08 Oct 2020 00:55:06 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:05 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 18/35] mm: follow_pmd_mask() for dmem huge pmd
Date:   Thu,  8 Oct 2020 15:54:08 +0800
Message-Id: <25a50b534bb73164dcad1be1f7b9c48756445c3a.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

While follow_pmd_mask(), dmem huge pmd should be recognized and return
error pointer of '-EEXIST' to indicate that proper page table entry exists
in pmd special but no corresponding struct page, because dmem page means
non struct page backend. We update pmd if foll_flags takes FOLL_TOUCH.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/gup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..726ffc5b0ea9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -380,6 +380,42 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 	return -EEXIST;
 }
 
+static struct page *
+follow_special_pmd(struct vm_area_struct *vma, unsigned long address,
+		   pmd_t *pmd, unsigned int flags)
+{
+	spinlock_t *ptl;
+
+	if (flags & FOLL_DUMP)
+		/* Avoid special (like zero) pages in core dumps */
+		return ERR_PTR(-EFAULT);
+
+	/* No page to get reference */
+	if (flags & FOLL_GET)
+		return ERR_PTR(-EFAULT);
+
+	if (flags & FOLL_TOUCH) {
+		pmd_t _pmd;
+
+		ptl = pmd_lock(vma->vm_mm, pmd);
+		if (!pmd_special(*pmd)) {
+			spin_unlock(ptl);
+			return NULL;
+		}
+		_pmd = pmd_mkyoung(*pmd);
+		if (flags & FOLL_WRITE)
+			_pmd = pmd_mkdirty(_pmd);
+		if (pmdp_set_access_flags(vma, address & HPAGE_PMD_MASK,
+					  pmd, _pmd,
+					  flags & FOLL_WRITE))
+			update_mmu_cache_pmd(vma, address, pmd);
+		spin_unlock(ptl);
+	}
+
+	/* Proper page table entry exists, but no corresponding struct page */
+	return ERR_PTR(-EEXIST);
+}
+
 /*
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
@@ -564,6 +600,12 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			return page;
 		return no_page_table(vma, flags);
 	}
+	if (pmd_special(*pmd)) {
+		page = follow_special_pmd(vma, address, pmd, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
 	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pmd_val(pmdval)), flags,
-- 
2.28.0

