Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC928700D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgJHHyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgJHHyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AFC0613D2;
        Thu,  8 Oct 2020 00:54:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x5so2372554plo.6;
        Thu, 08 Oct 2020 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=j2YZZCvtQrFkPVWDuwpwq7+KzOOQJEvUrhZvKk1fjMk=;
        b=ecFJwkfjeUhG6Ewb8+CxFWrP9cOyAEta2DZv8zhYOyGy3Q0qE4Mpwd6+BobicUOsmj
         1wM+GyB01Xqf0tLzmC7m18rtkgstQQQsXIYh19vScyOTtPfnkzmvkRWBC+8jd5aDeaCx
         ntfkwO/fJ8k0UwhZOr2kYUmulX96oykExS1XJ8vxkyUtoyRajHf1UFP1Ir1VERT9/l+M
         ZZ8nNMimh6xTU/vZ6jf8rTfp1fLzzk7rLaVzhzygoThnTRU0vGG2IDednS2eoWuNeSxk
         XXogKMADQrgX6uSMTpJ7XaAZ81TximYoBC9VePUa2DQ8ZDnThdYUyFXg6eAeniix5U+C
         T8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=j2YZZCvtQrFkPVWDuwpwq7+KzOOQJEvUrhZvKk1fjMk=;
        b=T2RRHhCPtWc5POSNt1ciIPtbjRgwUl2TFFcdq0nSr/vg39BPS6tGYpxUCFx9GH0CwM
         TbLpL5nP+zd8otyubMXgXnpWSQg8W7lHG+JJuiu/UCQ05cn7vZhTXChgZ9e7WvjDzgGT
         WCEyoyUZzxwWHT/guI2fRPZi3l/ceFihSpOyJ0HGwKnrWtgDYSu/viz7MR2OZjssiKK4
         bHWku/ipJyILyDbvuTKMD5aWF3cz+AFoHwLiUGpJkhWOKnRe6fpyaAf3QqCU4DEDsYat
         jQkk4j0L5EwScHWpZl8uSS5uSW9nbXJr8s2qkv0Lt7GJGnb10yheYCPW24iSwH9gjuGj
         jMXg==
X-Gm-Message-State: AOAM532wBgxxF3zUvks06qrQWzW3z7Of8wXNOqBzJzH+SAdQ/65t6C0V
        zNRuUBCgRJ0of02Q33lGado=
X-Google-Smtp-Source: ABdhPJzREbTGVLK3lHXufvOTN8YIq/D7sgMqNQp77hhr15+N41wNgFbuZMgu0HCr6gW/c1hx19Y0AQ==
X-Received: by 2002:a17:902:8d8f:b029:d0:cc02:8527 with SMTP id v15-20020a1709028d8fb02900d0cc028527mr6504505plo.33.1602143684225;
        Thu, 08 Oct 2020 00:54:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:43 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 13/35] mm, dmem: introduce PFN_DMEM and pfn_t_dmem
Date:   Thu,  8 Oct 2020 15:54:03 +0800
Message-Id: <8c193bcb9cfd7ccce174bc4bbc9c4f5239c1f5ed.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Introduce PFN_DMEM as a new pfn flag for dmem pfn, define it
by setting (BITS_PER_LONG_LONG - 6) bit.

Introduce pfn_t_dmem() helper to recognize dmem pfn.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/pfn_t.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d9148221e9a..c6c0f1f84498 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -11,6 +11,7 @@
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
  *		 get_user_pages
+ * PFN_DMEM - pfn references a dmem page
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
@@ -18,13 +19,15 @@
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
 #define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
 #define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
+#define PFN_DMEM (1ULL << (BITS_PER_LONG_LONG - 6))
 
 #define PFN_FLAGS_TRACE \
 	{ PFN_SPECIAL,	"SPECIAL" }, \
 	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
 	{ PFN_SG_LAST,	"SG_LAST" }, \
 	{ PFN_DEV,	"DEV" }, \
-	{ PFN_MAP,	"MAP" }
+	{ PFN_MAP,	"MAP" }, \
+	{ PFN_DMEM,	"DMEM" }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
@@ -128,4 +131,16 @@ static inline bool pfn_t_special(pfn_t pfn)
 	return false;
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
+
+#ifdef CONFIG_ARCH_HAS_PTE_DMEM
+static inline bool pfn_t_dmem(pfn_t pfn)
+{
+	return (pfn.val & PFN_DMEM) == PFN_DMEM;
+}
+#else
+static inline bool pfn_t_dmem(pfn_t pfn)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_PTE_DMEM */
 #endif /* _LINUX_PFN_T_H_ */
-- 
2.28.0

