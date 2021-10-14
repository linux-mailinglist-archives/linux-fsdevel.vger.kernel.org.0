Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6D42E1EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhJNTSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhJNTSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:18:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11498C061764;
        Thu, 14 Oct 2021 12:16:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso5514516pjb.1;
        Thu, 14 Oct 2021 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7d34DBjXA/Fd4Uftw43Y/yrb2taV05XTSK85g4O7S0=;
        b=S/LjEHeI18KKjxMqJyEtb1mXXlmXPnmxe755hFPmOBqRG4bZLO+/sDrU6mr7/p8SRF
         2f7UZQ3Mra0CSW2l4Zg0/LMSxTsEoPiQzAhJwajs6xEkrKTyhQYWamzZeieiaBbC+L9/
         /0LSGCLxGvJTtXMsBDSM9GW18UeezC1ySt4LpWRMaqh6wl1P0UmaNWmAZr2xH5QdLZd+
         czuIqobXkOdo/U9fJdbsUusAMD/Axa0gRY4DEDqMS3Cl7Js0BqV4oe+0IA9Zoli7Gm+q
         1QMJdy9INA/bhEvpMn5Z1bPqi61p6iKt1VWrdgzS8IibNDxgSyb6/5NDLe7f15b5Wy+I
         54cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7d34DBjXA/Fd4Uftw43Y/yrb2taV05XTSK85g4O7S0=;
        b=fEihuUJgTOML93v3RoCH7HC/dHNYcaPg1hEeKJlgSygWWpNyR0VNRrLs8SkA7QghhQ
         P+IwsZVYrpx7+utFhYGOsYvrNhS7xSxjEoZGtGqScvu+TNrhQMRH9QWrTDBH92qhnQ43
         n1lvMapYNUeW+bFlBhdjUg4qn32rjSn5G7A0QU6X1SlNwNKWwBYq9Ng+Qpoa+bpyald8
         1fR7npt/D8ccuiSeoIAF+EQySZiduRHIr7p7DPGFZL0i9vQvdLv14+noUrYt4aeU9XLl
         inIQmvgGzLw+zqEh+uXJKpsmTAj9rTLVrQ8raEkNqwO3bHzDWJ0WGtxQuy0BB/gCxpkX
         K51A==
X-Gm-Message-State: AOAM531GOBBwsOJRqdPigahLVQidfjJR/PwgfECUj8WHAJn2EO1PboDj
        VsrrR2pwMs28y+i3sVEfj6ZpR8b52y0dsw==
X-Google-Smtp-Source: ABdhPJwT4W8hhIyeely0XsKuzpQZ/liQr5lwe5HK4dqxxAyHYaMP7muP81Q4o7Zbi9ta+gKijzD13A==
X-Received: by 2002:a17:90b:30d8:: with SMTP id hi24mr22154129pjb.62.1634238994680;
        Thu, 14 Oct 2021 12:16:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x129sm3253922pfc.140.2021.10.14.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:16:33 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 6/6] mm: hwpoison: handle non-anonymous THP correctly
Date:   Thu, 14 Oct 2021 12:16:15 -0700
Message-Id: <20211014191615.6674-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
support for tmpfs and read-only file cache has been added.  They could
be offlined by split THP, just like anonymous THP.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memory-failure.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f5eab593b2a7..3db738c02ab2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1443,14 +1443,11 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 static int try_to_split_thp_page(struct page *page, const char *msg)
 {
 	lock_page(page);
-	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+	if (unlikely(split_huge_page(page))) {
 		unsigned long pfn = page_to_pfn(page);
 
 		unlock_page(page);
-		if (!PageAnon(page))
-			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
-		else
-			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
+		pr_info("%s: %#lx: thp split failed\n", msg, pfn);
 		put_page(page);
 		return -EBUSY;
 	}
-- 
2.26.2

