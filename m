Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2144E28705A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgJHH5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgJHHzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55784C061755;
        Thu,  8 Oct 2020 00:55:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so3330846pfk.2;
        Thu, 08 Oct 2020 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GAQmo3emgE7wGALCr56xbTRFWPok3r8JHn097oLTrgo=;
        b=feR3Hp4Mm0c11NezfLW8RmQ4nPtConWWWECi6vPDapgIc/SYfqzk1dmw2SvgMuHvkv
         spxvknKBvJBMPz0sV+Zd6yiR/GVE76Qc0zVt4ora65VHgmvWOEOoLtu+fWeoUqbkZFQF
         ZE7oR4PsRgqLQ5y/ReaMWKS2S4khTxfXyEPHBiKhA6MqGPxwmJ+At0ncMzUWgikHZ59U
         Jccx0kkt1U7OEylV2ok/m/AZt9s1UtU2NPlVDVs4FsWZtlC4V6N4cz+J9rE5u379tHKf
         yA1KVQR2wDwRXA7XpsJEyKe3piteYnWd9gG0vtRbL48dqdsrBJ65xUI6IYRFPz/EenIj
         VAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GAQmo3emgE7wGALCr56xbTRFWPok3r8JHn097oLTrgo=;
        b=K3JeW0Y/ywY/J7OOnkTBIq7NdforhYMjmTJSKldL47ksX7HRYG46cViOmCLGxIYfC3
         Y/OJB9EE5BZ0Lex71qeLEELCHPlADf/YaQ/fQM/I3l9gMBDs0mHWI33VFXWGQaPjbMSh
         afo9KUxhWMJmKIqaFs0qKNq68MpYNOBeBhqTq1b1GfkWBi2Zc+knOngB8vB9ddK9wp2/
         dFneJLvTD9Z3E7tLotmxc9oMEWvfhFhG0RlKJq4ll/QeUsNI5GPSeEGEi+rsa6VA5Fpx
         //6qGr+HZr6EZ4SCPYLl49tc0fDhFu95VZ4rwCt5DfSHZc3BhzLcSNGIFXgQjCQ0WNVM
         QiUg==
X-Gm-Message-State: AOAM532e6gpc6YmTQ2qeaVYPcHtd1Uu+TsmmACJMF3ZKcL+kAjOs80gE
        NdF0FURDrBnzYJSYFQBJPp0=
X-Google-Smtp-Source: ABdhPJzmgKs9G1dEB0PWPDBmnTSeOR/fYfsVYYngL49TYYKJ8bmnoC2kfQISr+E1jQmIAcBcwTnBXg==
X-Received: by 2002:a17:90a:7d16:: with SMTP id g22mr6886600pjl.135.1602143718936;
        Thu, 08 Oct 2020 00:55:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:18 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 21/35] mm: support dmem huge pmd for follow_pfn()
Date:   Thu,  8 Oct 2020 15:54:11 +0800
Message-Id: <5c508795a2f262e80cc3855853eba4042c863a3f.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

follow_pfn() will get pfn of pmd if huge pmd is encountered.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/memory.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2d2c0f8a966b..ca42a6e56e9b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4644,15 +4644,23 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	int ret = -EINVAL;
 	spinlock_t *ptl;
 	pte_t *ptep;
+	pmd_t *pmdp = NULL;
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return ret;
 
-	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
+	ret = follow_pte_pmd(vma->vm_mm, address, NULL, &ptep, &pmdp, &ptl);
 	if (ret)
 		return ret;
-	*pfn = pte_pfn(*ptep);
-	pte_unmap_unlock(ptep, ptl);
+
+	if (pmdp) {
+		*pfn = pmd_pfn(*pmdp) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		spin_unlock(ptl);
+	} else {
+		*pfn = pte_pfn(*ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(follow_pfn);
-- 
2.28.0

