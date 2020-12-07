Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F202D0F71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgLGLhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgLGLfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED3C094242;
        Mon,  7 Dec 2020 03:35:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 131so9601916pfb.9;
        Mon, 07 Dec 2020 03:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOxoYAByFgjYHcAfYN08FzgKY6QNyvq8eeqHRPrva4Q=;
        b=IJifq/wHL5++Uh9KafwXFdFhAIVbfzAETWaT0Wz412DL1zioa8ks0IHqQMobHE0lb7
         il49a16YoybvNwcEnH1LbheLRq9esiNl+KUZTTKeEYT3GykktEU9CyjsiyRRlcrL8V9i
         xjdjnm7I93RF446dlPxAOTolle3sJKf7sCBQPeMYaghlxfkhBNp+bJGbw3s+o46xRf18
         SFvcQ0hHzZ5p8+RSv8+DKLLtLxoiI57o2MK8qgH6IXd7lmwhhobC8+LpPY6VhvKxG+CC
         hFuzLfRe+F25M9UbsIsS/AdyWNtgCGjD+2gfmnfUtyTDHFpMLDYdfzABVdQIvMR60xX3
         6Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOxoYAByFgjYHcAfYN08FzgKY6QNyvq8eeqHRPrva4Q=;
        b=WpIjKRUrjstbjaJjmBIzi0qiMmbYP24njIDLy62SinlTwq9gNLNCOyGr+N9vAdvfG3
         1aHn+xI+YWAQkoHqy2mLXT234rT1nXTteRKFrIszZEv0F9sSIECIvAIZv25sS5ZcOXGh
         IsTIrPf1LtygUxfwxNG0p3/BbLIguu2Zb4tv9oUuYB12EZaV6rNiqNwvshkU16zMa8XJ
         k4L5jPNoaNUGjfIq89dTeTpQl7jC38g7+1KielYkN1aDo81MDV8cK259AeMfaW11PVkh
         NiSlxnCk3x9/OcRQHDJdOLSJ2ihcYYBHhQbScf2ei0V4RWyavSmAwnF3Q/ion8taMJQd
         +diQ==
X-Gm-Message-State: AOAM533hJB0hsk24Vc130O/6FJxfByAq0f7btPBcY9mXdCOQXmzhOwPv
        b8RIhxtgyabgcYzmu231I34=
X-Google-Smtp-Source: ABdhPJwhpFxBYkxRsLS+BV+lvSO+B7245m5N1dEnwhx2kuzLaOR+A4L9InETPPJipSBryp7sZwn4Zw==
X-Received: by 2002:a62:80ce:0:b029:19d:b280:5019 with SMTP id j197-20020a6280ce0000b029019db2805019mr15544917pfd.43.1607340908718;
        Mon, 07 Dec 2020 03:35:08 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:08 -0800 (PST)
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
Subject: [RFC V2 26/37] mm, dmem: introduce pud_special() for dmem huge pud support
Date:   Mon,  7 Dec 2020 19:31:19 +0800
Message-Id: <24c19b7db2fa3b405358489fc74a02cf648bfaf1.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

pud_special() will check both _PAGE_SPECIAL and _PAGE_DMEM bit
as pmd_special() does.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/include/asm/pgtable.h | 13 +++++++++++++
 include/linux/pgtable.h        | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 6ce85d4..9e36d42 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -281,6 +281,12 @@ static inline int pmd_special(pmd_t pmd)
 	return (pmd_val(pmd) & (_PAGE_SPECIAL | _PAGE_DMEM)) ==
 		(_PAGE_SPECIAL | _PAGE_DMEM);
 }
+
+static inline int pud_special(pud_t pud)
+{
+	return (pud_val(pud) & (_PAGE_SPECIAL | _PAGE_DMEM)) ==
+		(_PAGE_SPECIAL | _PAGE_DMEM);
+}
 #endif
 
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
@@ -516,6 +522,13 @@ static inline pud_t pud_mkdirty(pud_t pud)
 	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_DMEM
+static inline pud_t pud_mkdmem(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_SPECIAL | _PAGE_DMEM);
+}
+#endif
+
 static inline pud_t pud_mkdevmap(pud_t pud)
 {
 	return pud_set_flags(pud, _PAGE_DEVMAP);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 30342b8..0ef03ff 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1167,6 +1167,16 @@ static inline int pmd_special(pmd_t pmd)
 {
 	return 0;
 }
+
+static inline pud_t pud_mkdmem(pud_t pud)
+{
+	return pud;
+}
+
+static inline int pud_special(pud_t pud)
+{
+	return 0;
+}
 #endif
 
 #ifndef pmd_read_atomic
-- 
1.8.3.1

