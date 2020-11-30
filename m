Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4472C87B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgK3PVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgK3PVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A2C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:12 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so10273019pgb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=ZjgH0vr+7SnQsHcGa2K/AiAuo7pJtkSwgWtJ++8mJ2N5dpvx4/q685PNvhcPi2L4RH
         zFqwO9fa0PZR53uIZxgbwWomp0bb+gwW+M0LnTiAdcqN2Q4Tt2XVUs+9Dk0QZFvzzoiF
         9g4nQSo6Jyu0zrA7kF1DrDaVrzm3y6zUMZ7QVrtPujRAD+1WRi9xBGRW1rC+CFtvp2WJ
         sWszVSoUAnOMDq/t6yIZ/EewSR2lsiYjvv/3iPi30y9MJU19LbuhfIcXTphhMiKAqrg2
         D9DlSAWK4DROV+/PKZvKzx1pF3xpR1IgUoEmV05vYOLbTqAhByvCExHRdsEN2B9Jygsh
         7Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=RNwfg6ewozi/U7n8ElsXz0lfev8734n+n74hzEEz773SAzPjeknC8WoSownmElilqr
         x+qAJFc7clMKcs8MQxqRBajlIN3uF3ewDElT2y0lPVs+w6J/1KyIN/Naghljsb9KLwfm
         atuqjzAoHQoMNLXP/FGlrPC3vosaCkAXKq3RR0uLGrMoJxLxK48y0fALk/YkZzKRiIUV
         /mulWd+eo4ol3uIahYFDHuiGNS8GkYwSxjckkDJAqXe5PTGsfd7/as+ewEFYQea54iqd
         O9batQc04kCEOs/VhcTJDW+nGsv+V18sBi82Pt2ujKwW7y6YFjBbRBUICbf+yVojUrPQ
         4V2Q==
X-Gm-Message-State: AOAM53158NNyazIRWWCbQkRbGNN7evDZatCNxyfcKp+u7EwTPUaVTsRO
        GLG3tYa4MZHH/m5T3tJatTlBUA==
X-Google-Smtp-Source: ABdhPJyhD8o0jzVpPs+toSeNAsFByTmDI0pdIsUlVpAmaWm//ETZis2DFWTt1ieO0wvLlKMNFBzcgA==
X-Received: by 2002:a05:6a00:13a4:b029:18b:cfc9:1ea1 with SMTP id t36-20020a056a0013a4b029018bcfc91ea1mr19086071pfg.25.1606749612267;
        Mon, 30 Nov 2020 07:20:12 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:20:11 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 05/15] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Mon, 30 Nov 2020 23:18:28 +0800
Message-Id: <20201130151838.11208-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the later patch, we can use the free_vmemmap_page() to free the
unused vmemmap pages and initialize a page for vmemmap page using
via prepare_vmemmap_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..239e3cc8f86c 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
 void get_page_bootmem(unsigned long info, struct page *page,
 		      unsigned long type);
 void put_page_bootmem(struct page *page);
+
+static inline void free_vmemmap_page(struct page *page)
+{
+	VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
+
+	/* bootmem page has reserved flag in the reserve_bootmem_region */
+	if (PageReserved(page)) {
+		unsigned long magic = (unsigned long)page->freelist;
+
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
+			put_page_bootmem(page);
+		else
+			WARN_ON(1);
+	}
+}
+
+static inline void prepare_vmemmap_page(struct page *page)
+{
+	unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
+
+	get_page_bootmem(section_nr, page, SECTION_INFO);
+	mark_page_reserved(page);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.11.0

