Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFF2D0F29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgLGLej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgLGLei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A422C0613D3;
        Mon,  7 Dec 2020 03:34:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w6so9617930pfu.1;
        Mon, 07 Dec 2020 03:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTgCCtK3neklBBZP7ALPG1Lf4m1ypdSzhK8xGX8aX9M=;
        b=SMiGuwjR9VTZexC3BrV+8B6agmZASS9JEaHnUZ2E1SWgJbsxMfQOcftyniDMaI4UtS
         HqH6yx1ijBUM+P9SqB+YEbgYrBhqCjmLdV5Rg7vXsyZ5jaSaXRaZJmc3Yjxq+eEZG4oV
         nX66/M0q5EhEDZF9/LBmyncihaCPD6I2LGmGewQmo7Ga9FfsB0ouuSEkUUjD6lxI+caB
         D6bY535ziVmj3fxBixW3OY+kJ46tqvHPAMERQCF66rPJh2efyUOOl5tjzf+zzNRblBCI
         Xb2Fj9L2Eaf0AdeetZGtjqVgVV4QkTfvH80QfKPg+23LmZ8AusMLBfv6lkdZ/XnKYpIr
         aHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTgCCtK3neklBBZP7ALPG1Lf4m1ypdSzhK8xGX8aX9M=;
        b=lQMXEqI8Az+Vd4vTC4KROMF4iGJIBVQRJTu7cT9MT0YYypNifIfwU4LP609D+R/sOy
         fGZrZgXi8tPepprVItAhxnLOeeopak52JUkIOls8Ue29hH2vHbmbjhn/8RF3fRHTIi2X
         7hYKZ967Q1v0aRkVd8/Gp/n0DUxQ9oeD0kmi0uhHVplAmaOfMm14D29lhoqi2OreA14g
         1hyfGSUCERWGjxRFM1lLWLUyUJNdBdNOdQJZNv4O5Fv9U5L2Rbsr+MskxfFR/kVwHaHL
         L/YcqwJoYCllOb+GYVtZinQNUo/OvAerkW2p71Pl88Vsmbtn+NyI5PmVSAw9Pii6JIV6
         VC2A==
X-Gm-Message-State: AOAM530j2SaSL8r9Kb9DfFwvzw7MDJ5NcncJYvZHcChb5yWvAskcMEYZ
        /ggmBAv56tP5FPFvhFIdQyI=
X-Google-Smtp-Source: ABdhPJzkG6zV67FqF8oje1zqM80ZaXke6YmOfj+FEi4/qDBrNc9iaM3WstHda8DEvRc0vm268vDR+g==
X-Received: by 2002:a63:445c:: with SMTP id t28mr17760750pgk.373.1607340862967;
        Mon, 07 Dec 2020 03:34:22 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:22 -0800 (PST)
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
Subject: [RFC V2 13/37] mm, dmem: introduce PFN_DMEM and pfn_t_dmem
Date:   Mon,  7 Dec 2020 19:31:06 +0800
Message-Id: <e0da248a3c9eab661f9302ea153be286874634da.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2d91482..c6c0f1f 100644
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
1.8.3.1

