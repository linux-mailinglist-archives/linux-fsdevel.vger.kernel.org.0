Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF622D0F8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgLGLfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLGLfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:12 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93DFC0613D4;
        Mon,  7 Dec 2020 03:34:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s21so9600828pfu.13;
        Mon, 07 Dec 2020 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3/DmgnhBXN4Hz69/t1CkODYALK4F+PnSmV8LC6JbSA=;
        b=i533nrfJosg5xurLfijup+2bdmgF+Al9N2r8hxZlMbkp+JC7XK4unPQu0mjh1PsG8f
         iRrrzCItR+iYj35Lj6OLsH2XeXSKTc9vtDLt82Om+/Qri/9Jof/xUBTWrvLM7VIfc1ja
         9q9N/D8Fo/wp68q/S/DtBI1xr7NXgoezjHV7qYiHhpssHLqTvReszbbS2wmGP+GVzxdM
         ChEPA2iflLd0spt7SslHX2zIfs/7DCmxkXr3kDcBaa01uerLz6FraqlK+JHb8L1qFieK
         ZeAa+v+hd0ftuYQfi4Lo/TJdTWxi9w7I6yqaeACSWEArGkEl6yRcCrp4s1/tCgml3G3i
         Pwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3/DmgnhBXN4Hz69/t1CkODYALK4F+PnSmV8LC6JbSA=;
        b=BV4safdpkUYo8IqyHDxx1vgvUCvjngEwTTzC4yskjqPFxmjPlZxfzaBYkG1X20vhIb
         OtB+cW8KUPLl2WRzWk3YEzv7xZkCejx4Egy6OzGrsm95Z35Y4PTHM+mMGKJB3u09cQ+h
         EwFtckzWbIYRD4J/PYa9Mwkisu3w61gy9bweOsfPsfFias4nOwOl0mEvNiLTlUI5Bu5G
         dl6ulWyDVlRlYcxOkoA6NZC8LZ6Qcb1bjNoJWdYabiTx5u7h0K6wHyMwXJbtriHV6oGK
         4t0LItYjf2EJVDGZK9YS7ei99J1I+32MJtFfQiqHU3+1JqQHJM47nZZG595dO4KIjKTh
         7bfg==
X-Gm-Message-State: AOAM532BhyjAWTIh4Ortvn3xrepZUOCzGj7S5Ci4wttr+hwQgN3gkBUk
        KP3zjI4uO5LvBDQVxMh8JKk=
X-Google-Smtp-Source: ABdhPJz88HczwHM2v2Saqr/8f+J+9LkiKsk1pqJ18lze4vI837EannlLkxaMIwLu/EjTW1jpYWYrvg==
X-Received: by 2002:a63:4905:: with SMTP id w5mr17941895pga.124.1607340866415;
        Mon, 07 Dec 2020 03:34:26 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:25 -0800 (PST)
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
Subject: [RFC V2 14/37] mm, dmem: differentiate dmem-pmd and thp-pmd
Date:   Mon,  7 Dec 2020 19:31:07 +0800
Message-Id: <9e1413b30d1cd4777af732e0995a7e7a03baeea6.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

A dmem huge page is ultimately not a transparent huge page. As we
decided to use pmd_special() to distinguish dmem-pmd from thp-pmd,
we should make some slightly different semantics between pmd_special()
and pmd_trans_huge(), just as pmd_devmap() in upstream. This distinction
is especially important in some mm-core paths such as zap_pmd_range().

Explicitly mark the pmd_trans_huge() helpers that dmem needs by adding
pmd_special() checks. This method could be reused in many mm-core paths.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/include/asm/pgtable.h | 10 +++++++++-
 include/linux/pgtable.h        |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index dd4aff6..6ce85d4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -259,7 +259,7 @@ static inline int pmd_large(pmd_t pte)
 /* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_DMEM)) == _PAGE_PSE;
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -275,6 +275,14 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_DMEM
+static inline int pmd_special(pmd_t pmd)
+{
+	return (pmd_val(pmd) & (_PAGE_SPECIAL | _PAGE_DMEM)) ==
+		(_PAGE_SPECIAL | _PAGE_DMEM);
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline int pmd_devmap(pmd_t pmd)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9e65694..30342b8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1162,6 +1162,11 @@ static inline pmd_t pmd_mkdmem(pmd_t pmd)
 {
 	return pmd;
 }
+
+static inline int pmd_special(pmd_t pmd)
+{
+	return 0;
+}
 #endif
 
 #ifndef pmd_read_atomic
-- 
1.8.3.1

