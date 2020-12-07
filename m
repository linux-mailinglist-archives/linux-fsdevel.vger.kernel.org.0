Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA22D0F45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgLGLf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgLGLf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080FC061A51;
        Mon,  7 Dec 2020 03:34:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so8640487pga.9;
        Mon, 07 Dec 2020 03:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irx3d3NJeQeYfZPwYnMd1dXXT7HLdVgOj1onbLngswY=;
        b=eJYAcqAfXe8LOuaHKdKllKlDVNqxancjE8M5qAXrhETqb6j0v9x0H6NmUSzw8StI14
         J2rM/AstiKHgOTM5AVfKtlpjtk+Fy+75hlmDPxd9jG4tEq1SyKQGWIYTm7uq/2uxcFlg
         W65vIQCLcSGlLabBaPbAuQhsHwJbWDWT8I5hWT/k/rJ7sxp6PR9YsdF4n62gC431AOpJ
         aIaVvanL5902eANwLRH1qq5hk7Snj3uV5PeZ7O6x1IM11CDxzRxpQlAinRhXhnHtReTC
         Trs4VME+idkpV6820spwytsexIK78pl4wM0D44rVyvONHPP9rysLFUxoF40Jm3dYeJDg
         jyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irx3d3NJeQeYfZPwYnMd1dXXT7HLdVgOj1onbLngswY=;
        b=OdS9NvdLbukiIbZilS71U0WElWLNygdBtboFgvJfrDYM8xZl0BRw2MXFeHcAiLfKkr
         Pse3wJVMiDrZXI3RxpAKqSWzIeYN/zRDc4TS9e81e1wzFUswNugfophM9HLLmiLGSI+g
         WiiyOUrZztL1TyNLCLfCPrianaLWW93aARzqXcA3q/WdY5yR6Vyb5VJA0fB6dkdTx4Ho
         /JBtoRnsN8o2z8VrsbSvXX8BIFTotp96iUKkeBIH68h5et51A5A6oYeOeVvigWcq6vZ9
         bV31G8M3xD3sEE8qRaR49b1DcsT5YZnN+1SQ3aAwwlojlwaAgi+OczCsNkGlIEd0bkF+
         yUTA==
X-Gm-Message-State: AOAM531kz5LLAVjNZITm/fNuA62p7vcGweqNvehHilS/CbcR/tZai42G
        yD6ydOrcR5lD0y8/r3qmZPA=
X-Google-Smtp-Source: ABdhPJy7T+zOWSaaaUAy9bCSHgKA4JkL2mqiQ0XfQp/lTQid14KX+alS2W1IiCRqphNjeXsYneYbLA==
X-Received: by 2002:a17:902:7b97:b029:d8:ec6e:5c28 with SMTP id w23-20020a1709027b97b02900d8ec6e5c28mr15836888pll.40.1607340887900;
        Mon, 07 Dec 2020 03:34:47 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:47 -0800 (PST)
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
Subject: [RFC V2 20/37] mm: support dmem huge pmd for vmf_insert_pfn_pmd()
Date:   Mon,  7 Dec 2020 19:31:13 +0800
Message-Id: <d9a59ce61973e9fcf562311f02614a5f9d124937.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Since vmf_insert_pfn_pmd will BUG_ON non-pmd-devmap, we make pfn dmem pass
the check.

Dmem huge pmd will be marked with _PAGE_SPECIAL and _PAGE_DMEM, so that
follow_pfn() could recognize it.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a818ec..6e52d57 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -781,6 +781,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
+	else if (pfn_t_dmem(pfn))
+		entry = pmd_mkdmem(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -827,7 +829,7 @@ vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 	 * can't support a 'special' bit.
 	 */
 	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
+			!pfn_t_devmap(pfn) && !pfn_t_dmem(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-- 
1.8.3.1

