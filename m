Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A8287033
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgJHHzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgJHHzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DAEC0613DC;
        Thu,  8 Oct 2020 00:55:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c6so2363443plr.9;
        Thu, 08 Oct 2020 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=baP6qc0YYj+DmTYY1P4mAyPBjNnkQzpG/qxwTfH16NY=;
        b=HlUSHDav+EhjoX8LnlxBqvY2+riyA8I6hOwYOI9ZJa/Jg3ppNe1yOU9rIeK4RDmlYN
         SVOsNko6yENO0fWa1FL+DZrDXX/SSwYM1px2al6NBrI9MFDU3W5ieC193pUPoxS1uIjC
         l66JFsudPvUe3au7r25G8o/B+VK68M/JLPfSUMtEIY33LHZGmas/Ti+9HjdibhPfV4p2
         n+mhbbVmU3u7bUVALqw5c13vM4iB3tYsDQd4gFG+WZVV4WzRY3OOIInNUSfwq53rUULB
         Dfa+9yhFNGbVm9jAMW4Zwhb8UZKQRWIoi13rBQcLeNh5pt+OKYyBAaNe8xEgZgd94yqj
         Gy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=baP6qc0YYj+DmTYY1P4mAyPBjNnkQzpG/qxwTfH16NY=;
        b=pKvNJlfbztP7CcAXjypCwptx3vHXvTfMHrfnYAmDOIeIBBtgbghe1NfnMan1NLeuuX
         8Xrgp0S97qtJOdd04Rq1Rj1qHbJmXlRFJiYXZe/Xw7qMVuDcljw4FBIfr2yuEMTeS97h
         Z4zk76AeMr0RdVAwUJdoepZ25ONfRFtbSzbNYRtt/BSepSn263Mwvkjo5yUqrAOViedz
         llgOFUa3I74xFQot9vJFl1Htx6D1vumQ0I6mspJ6k1qtZ+JniAdf9u0QSGEDaoo9lS8F
         C33EIbayvEItblBgRyNOjTiQX1Z2Ipa44Nz84jhARicdcwNUcUK5fV94Zlz7WlpNuaI6
         b17A==
X-Gm-Message-State: AOAM533Ub0zZMqBLRXxQbBgBK2L9EVXX27ZRN19rPA2fVGBijnss5So6
        zlse3HGWLioVeBGIKy4GaAc=
X-Google-Smtp-Source: ABdhPJxwJ8nEIz12OEqiqat5/gJAm4Dlr4Kznc/XMa50UHEHUR3Q+1dDpcKPk4ntPTyCjt7vpb0t9A==
X-Received: by 2002:a17:902:7d8d:b029:d3:95b9:68ed with SMTP id a13-20020a1709027d8db02900d395b968edmr6433338plm.28.1602143739775;
        Thu, 08 Oct 2020 00:55:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:39 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 26/35] mm, dmem: introduce pud_special()
Date:   Thu,  8 Oct 2020 15:54:16 +0800
Message-Id: <fe540330d8d38f745541e3a37d8b34dc17847574.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
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
index e29601cad384..313fb4fd6645 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -282,6 +282,12 @@ static inline int pmd_special(pmd_t pmd)
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
@@ -517,6 +523,13 @@ static inline pud_t pud_mkdirty(pud_t pud)
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
index 1fe8546c0a7c..50f27d61f5cd 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1139,6 +1139,16 @@ static inline int pmd_special(pmd_t pmd)
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
2.28.0

