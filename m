Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937D8287024
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgJHHzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgJHHzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECFCC061755;
        Thu,  8 Oct 2020 00:55:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i2so3583857pgh.7;
        Thu, 08 Oct 2020 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RHYtPFeMZWLc18KP0oQeXS/4Vq6HE5iYv+578W57cug=;
        b=lP17x+FNFFFLix4HphKfiyj2fY+SOeaElAzyliE0QDst0Kgy0VTVEi5eU1ZRuOFA+u
         yOmLDKHUfkxwdJJjroxDWyiYbTUf8BbHu1OPFam/fGmSgzw0yhmI+gRg0SPBPrPyyAUn
         OcCbLhIHO72KoDqmPcloUyiUWPsaguNmqwHAmJtvhUyoDyI2pFgZ8FDRDp8qiLMn9XXn
         1GHx99yph5JXE87p/AXyilWvNUHJZ3Ze3esClWvBHYlWBzrDXJQMCOOY9f2xYAC6nyB5
         lCSPkcQKhpY5Z3IbxanKzwHgmkVfmeKJ0XMLHQa8iHsSfOy8MShzyFupK9sh6NlNjid4
         JPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RHYtPFeMZWLc18KP0oQeXS/4Vq6HE5iYv+578W57cug=;
        b=HZCHqQYFQHFGh33+cdAPU4a/41O2nQp6kzd/htQwQRMy8+fQPhyFkGGfMQ6y2LZ7Kr
         yuKjZzDiLWexhMNthM931TUswXM+tjYidcH6Q6DYEb3Dk7ALEUHLqMpYc3KFj7vx62Af
         4ClqsVJ2Bsxj1ZyMv3LLV8t9CgTdli/RGnFYTxDhcCAG5j8a+3du0QEONCdowdOziArs
         Uuq+UVQYrLL6bIvA3g/xvq9AOo/8WBawdacoksCmn3FoZHNXVxXWS/rUOfpNDrWxqWZn
         vCKNJwxDcjoSPw21iB+RbGDA0fzwcjnDUNDTjDzW5zSY0w6FbrZ2yb+ZVI/tzGkU9fxf
         MclA==
X-Gm-Message-State: AOAM533VOpkBmwfdBXDXFTgWl4WCj7EwwpmXYnYUmJuD1VYHVYObuhQi
        Y4B69qgemB1mG5DFwgXGlDM=
X-Google-Smtp-Source: ABdhPJy8bCqYDqGzlAUHaJ2Dg6h1nj0iX25rGQODuf6Kj0hKjwHAw5+HG0Wozp7TjnTg0+x3fk+34w==
X-Received: by 2002:a17:90a:a09:: with SMTP id o9mr6435104pjo.134.1602143714612;
        Thu, 08 Oct 2020 00:55:14 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:14 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 20/35] mm: support dmem huge pmd for vmf_insert_pfn_pmd()
Date:   Thu,  8 Oct 2020 15:54:10 +0800
Message-Id: <7325d4c99cd3bbcd74fac182d06ca17f78c454a5.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
index 73af337b454e..a24601c93713 100644
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
2.28.0

