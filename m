Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70213286FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgJHHx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgJHHxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:53:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA359C061755;
        Thu,  8 Oct 2020 00:53:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i2so3580518pgh.7;
        Thu, 08 Oct 2020 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PBnE1QAo7Jwl736qTOTO4uTCYWWc54L+TMxGG3Lu6zw=;
        b=SjRXwrLX/YPbydqVxvF92oogIetb81hrvhOGQ+1tLAG6UPk0B4gA9UxrlbncFL2aFy
         WDDqiRqQoIdbh3Ov6HaZwsFfl+/2U2kL9ypMeEi5XA/zsAoymnW3Ihx9m6rveNm/p4Y8
         edaZaQCyqxKCX9MNi+StOfXIRHCagYZzBlQ+DuanG53rM/RCyghsmT1jZeNPyCQ1zQ/L
         39dV2kaOtrRdeWrZRaowzSuRQiLUUZydf20C1wl9keC92SCUpYnjJl2/1boT4L5vNYGv
         tOclGMs5RRw1B1dFU53tprCQ2YFF9df8B7d2nSwQBeem6rqCPovWCO0xTtnthGny1Cs6
         X0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PBnE1QAo7Jwl736qTOTO4uTCYWWc54L+TMxGG3Lu6zw=;
        b=Kwl0dZ6y6IGbneFE2ncos1JPee4xSLjCxVjCWnWML5eYMhnMaav5rd1LBY88N4tSVQ
         O8iYxOMBi3ZpXiE+Fgy9CwxKjoyBzjhHEzeo6oAjOWOAHlmSfAO61dEx0tIKshT0D2ds
         Hvef+cpa3RDFaDjZI9V7qSDXclUPkXJHUX3dG8Gj1phKl6m73ESPMW5m8pzkXW6jnKWw
         xK4+cMPNIGrx6Q93YTxmdntB5p9po/DUsXYb3Hmv+LboxWmC3dSF2tTNsYA27YNgcB2c
         SpsmrDlmWht1dEP3Wprkq4crokaZFafZVx9TxHJcUdl5TuAFqDrSL3RiCC8reP65ZynR
         UVrw==
X-Gm-Message-State: AOAM532jnRMoWIemlXWjI992FX1nRLWaL90S8Np1owg+GyH9bHv/g6lM
        IyXWnnbzUcyYOynH/hNRfLc=
X-Google-Smtp-Source: ABdhPJyf24CY0Eqdhy9GaPXlHYy0bP9Om/iDF3IWFI+hRiHc6/ht/JP1H29YVbI1naEd4oxhPnZquw==
X-Received: by 2002:a63:e444:: with SMTP id i4mr6354788pgk.304.1602143629582;
        Thu, 08 Oct 2020 00:53:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:53:49 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 04/35] dmem: let pat recognize dmem
Date:   Thu,  8 Oct 2020 15:53:54 +0800
Message-Id: <87e23dfbac6f4a68e61d91cddfdfe157163975c1.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

x86 pat uses 'struct page' by only checking if it's system ram,
however it is not true if dmem is used, let's teach pat to
recognize this case if it is ram but it is !pfn_valid()

We always use WB for dmem and any attempt to change this
behavior will be rejected and WARN_ON is triggered

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/mm/pat/memtype.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 8f665c352bf0..fd8a298fc30b 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -511,6 +511,13 @@ static int reserve_ram_pages_type(u64 start, u64 end,
 	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
 		enum page_cache_mode type;
 
+		/*
+		 * it's dmem if it's ram but not 'struct page' backend,
+		 * we always use WB
+		 */
+		if (WARN_ON(!pfn_valid(pfn)))
+			return -EBUSY;
+
 		page = pfn_to_page(pfn);
 		type = get_page_memtype(page);
 		if (type != _PAGE_CACHE_MODE_WB) {
@@ -539,6 +546,13 @@ static int free_ram_pages_type(u64 start, u64 end)
 	u64 pfn;
 
 	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
+		/*
+		 * it's dmem, see the comments in
+		 * reserve_ram_pages_type()
+		 */
+		if (WARN_ON(!pfn_valid(pfn)))
+			continue;
+
 		page = pfn_to_page(pfn);
 		set_page_memtype(page, _PAGE_CACHE_MODE_WB);
 	}
@@ -714,6 +728,13 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 	if (pat_pagerange_is_ram(paddr, paddr + PAGE_SIZE)) {
 		struct page *page;
 
+		/*
+		 * dmem always uses WB, see the comments in
+		 * reserve_ram_pages_type()
+		 */
+		if (!pfn_valid(paddr >> PAGE_SHIFT))
+			return rettype;
+
 		page = pfn_to_page(paddr >> PAGE_SHIFT);
 		return get_page_memtype(page);
 	}
-- 
2.28.0

