Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07F2D0F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLGLfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbgLGLfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:21 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A7C0613D3;
        Mon,  7 Dec 2020 03:34:41 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so9618883pfu.1;
        Mon, 07 Dec 2020 03:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/DFMWcoqrBGhrdQgSqqomqzF7zS5T+kFvHPOchokBk=;
        b=R9NM+LrICITDCSs61NAJazJcQQLLZOkAyWgF91yroQ30cXHAJppkpODFQHCiPkKmQn
         Di7C72F9xbWBRqscYUPkTutsiEPfArp2uJQhUJMFrFwCQvS74l6dGAFEUlRjW/Ws/WLb
         i25GvziBXB93UcCddRs/vcJrzZtwz/5Tc+/VbAAIFz9dRUGeAp5DTeSbJkdcv7XB2Gwx
         3sN5hKnAOKf+OmoM35ez+biBZKuU9mmCC3Z0vH8q0qPs6i2+ilvJACrd43BNKlUYdfn+
         zXXNnE5OgQCQ2GjXJLLtVka3prnPTyUz7X2Y7d5VNYlzQNmiGKs5m0h9G1bEKMENRYYK
         JILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/DFMWcoqrBGhrdQgSqqomqzF7zS5T+kFvHPOchokBk=;
        b=AM33PIsfFtMVq/9u+0wAHHrcqcwwQJsk0RurgnP0Odxco1X7+UVwSkBXe3JSVd2pGu
         UCRBcGA6IMswvlsRJcWKGQ/zXDpgksu3kmASpR26GJY1FaT1c7oaPcIg/zUfsH8cpeYP
         5rbLi4Ums9MzE+wV2Zg8iWlI1TNPCtnYKb1woUmG+xV0BDxR5KIVQzERYDlFPTulMX3l
         dmDzj5vh39uKM3d5ZHNGdxZu1uTvz/ZfGq7O7kaXKX26RR+VdzO49WhTE4lcQt6oreHS
         My9BzgqsPd+7HbeU0PcAPByYGZhmOzIdpFF71izW76mwdN2MYHMt3KDDq6yRRftuDddL
         5gmw==
X-Gm-Message-State: AOAM533e9Dz2Fr+qhkMaWOs6rw2lLa8rqdGO1rLXfnGqS5E+ItNxgLgX
        tIBcbEM42dZY4TfDie7Vxpk=
X-Google-Smtp-Source: ABdhPJwpLJSMFHHVuzFaNJtee4l+tKxhbMqfSGyZXpTjn8Xdsw0wr9LXWXlJyzhmY0qsdp5ekgOemg==
X-Received: by 2002:aa7:928c:0:b029:19a:de9d:fb11 with SMTP id j12-20020aa7928c0000b029019ade9dfb11mr15718593pfa.21.1607340880960;
        Mon, 07 Dec 2020 03:34:40 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:39 -0800 (PST)
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
Subject: [RFC V2 18/37] mm: follow_pmd_mask() for dmem huge pmd
Date:   Mon,  7 Dec 2020 19:31:11 +0800
Message-Id: <1401155e1db8221b892fb935204ad2d358c2808f.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 98eb8e6..ad1aede 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -387,6 +387,42 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 	return -EEXIST;
 }
 
+static struct page *
+follow_special_pmd(struct vm_area_struct *vma, unsigned long address,
+		   pmd_t *pmd, unsigned int flags)
+{
+	spinlock_t *ptl;
+
+	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
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
@@ -571,6 +607,12 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
1.8.3.1

