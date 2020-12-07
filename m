Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB32D0F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgLGLgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgLGLgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:36:12 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B869C061A51;
        Mon,  7 Dec 2020 03:35:32 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so7183740pjb.3;
        Mon, 07 Dec 2020 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ve50LBxe7KPsa/afhSPdadx4mGbx0d5NNuSu5BfW+ws=;
        b=iGPfYHDT9qrLj7NFYNDa99CfU/LeTtf1xtrQ4M7/y/WnH1dn41NqjJOU3FG2cI2rI1
         h0kfX9f8shUAZZMOJgGaejDmBdM+kopryJtCrKgU0WydjatlKrXuJdW2bF7peb3YE73w
         HuxE6iS0CuXe4q7GR4g4kSkSH6FnTepRTIMRjxotGxhIeEy3ukOJoI5oZIXRy7bWfhgi
         IvKePLSYBnWHUrmlhAUkfkx96TSLs4I/L6WgpPAkzxznqxqFcO+gGTdsC/FaANWeyvGZ
         qVOLpBLEzfoJSjxHnOcThPOkYd3adliwtBA5VZ8npQ1fRXKU/uPKqTcL3sx4i7jwqU37
         jGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ve50LBxe7KPsa/afhSPdadx4mGbx0d5NNuSu5BfW+ws=;
        b=cu5oQ2xVkvv8YjCyvP/SECkAXF9FTuwciqkIffybDTP7CgTmT21VdALgVFrLa3L1Y9
         UyCsmwIP+3eUi6Kbprk/6JM63sl7EFNzi4PgiktwBGK4NMa4sMauea/u8cFz9i5ciGKi
         EkKzSmya2jVX0k0g3HvxI7J+op17lHb2xG8I5wBvSgqxF3Bbyw9B6kzvmAN8rtOjnepZ
         cprWdf/dXskV2vo5oCfcH6gcJTG1K7DBFHPff8k/CyTCaEeY8TxWbr5z0ZnECGPyI/ie
         nrr0NqTV1q+7yxhOrWlYYWU7cFfoBsmAnaIHDUiOF24HJCOidOsvSGDzkXHUnFa1OtMi
         fPlQ==
X-Gm-Message-State: AOAM532+lmkxrzAJ2ckvxqTPoMJz4PDIsTPycr1DPMnwHubielLibSqc
        LlcuUBZODobbQbMZw1pte7WtD0IsvP4=
X-Google-Smtp-Source: ABdhPJw+yEq36n4uncdVGAdYzZ2qqW7UOAZi3abFVTKDELRoe1bqIX3q7doUgLIBaZmdlgELZCPS2A==
X-Received: by 2002:a17:90b:1945:: with SMTP id nk5mr15957725pjb.30.1607340931753;
        Mon, 07 Dec 2020 03:35:31 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:31 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC V2 33/37] kvm, x86: enable record_steal_time for dmem
Date:   Mon,  7 Dec 2020 19:31:26 +0800
Message-Id: <f5a43fcef278efcf6b2e138644160cf806d5dc51.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Adjust the kvm_map_gfn while using dmemfs to enable
record_steal_time when entering the guest.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 virt/kvm/kvm_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2541a17..500b170 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
+#include <linux/dmem.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -2164,7 +2165,10 @@ static int __kvm_map_gfn(struct kvm_memslots *slots, gfn_t gfn,
 			hva = kmap(page);
 #ifdef CONFIG_HAS_IOMEM
 	} else if (!atomic) {
-		hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
+		if (is_dmem_pfn(pfn))
+			hva = __va(PFN_PHYS(pfn));
+		else
+			hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
 	} else {
 		return -EINVAL;
 #endif
@@ -2214,9 +2218,10 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 			kunmap(map->page);
 	}
 #ifdef CONFIG_HAS_IOMEM
-	else if (!atomic)
-		memunmap(map->hva);
-	else
+	else if (!atomic) {
+		if (!is_dmem_pfn(map->pfn))
+			memunmap(map->hva);
+	} else
 		WARN_ONCE(1, "Unexpected unmapping in atomic context");
 #endif
 
-- 
1.8.3.1

