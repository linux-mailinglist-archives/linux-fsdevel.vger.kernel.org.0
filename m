Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AAC40B707
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhINSiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhINSix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:38:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A297C061764;
        Tue, 14 Sep 2021 11:37:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j16so197328pfc.2;
        Tue, 14 Sep 2021 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yprth0nsSrttMIWYc9OKOWe+bft4LdAzLPFBmBWUobY=;
        b=kvvcClInUIG9SRN8aa+z1bR/Pc+UNmTjmjVVAtD2xIqPk47pROSY/f0CSvTRGyYci1
         NuEppMVsjGtD/RELsrt0o1bMAdlrYJOnF8+uO285BnIi7c6TeVSibj/kB05I1evFrmuo
         qwaTYKmipY7nIfdjaRVcfxwJ/y+tlLJrv4ntSajPKY9pj1MKVEzhsUeD0nn2BlGJzAFL
         Yt5PB0KqXOUi1opqLZwVQ9iHL5M3wLIdiQCJKdJ/bFxTbCDnwG6ParQRC7AchD/mBeDw
         8BQoPQU1iQltx438xfOnGjqq8dQ3V5m5PZxMHacSKO/d/D4DZKUqeQ0/AZZuwVxNr1Zv
         yBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yprth0nsSrttMIWYc9OKOWe+bft4LdAzLPFBmBWUobY=;
        b=fffmylzCZMDGTAQxD5QSkJnwgH1sGZekYliQoaFIEjdN4ZLR2r6uMKrZDdP0iGyJVc
         kd3Pvi1Gfr5UbOLaRQaKPUDAaEddYMl+0TzJTxyaL41xsnm2V8h3CC13PTVg7Q8cZiXo
         h+tsDC33utmJ70wxnS7z8/Cq6xo/EnsbTqdnobk3T4O8Rd/fTFvefP4P7OLHmOL5QFxd
         gImhLGRltNfXoxqfuEX6UHdoduHeFcSB/5fBsaxeyIIaKfLlOHF3cfDKhsFblJdK9TAo
         Wle/vX1VmBTeUsDde6PObGEDHXYMVr1bPqvYGhpF0xGHu73nU9qJzaks0K8JSYaRpJbT
         90bw==
X-Gm-Message-State: AOAM532oXsHecZl2gr8SY406Il7j1zFw7eQV9wVtto1rsva/lSORODA0
        yteRT2GmnM6U8FivhQTrSoM=
X-Google-Smtp-Source: ABdhPJzG/S59EV7n4OKhsdYA4k/qedVimHWvPxBnASOQFFBJgdUHomIzqVIxDQbzmk/JcfRKhIQ6iw==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr6077555pff.49.1631644655029;
        Tue, 14 Sep 2021 11:37:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y3sm12003965pge.44.2021.09.14.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:37:34 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: khugepaged: check if file page is on LRU after locking page
Date:   Tue, 14 Sep 2021 11:37:16 -0700
Message-Id: <20210914183718.4236-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210914183718.4236-1-shy828301@gmail.com>
References: <20210914183718.4236-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The khugepaged does check if the page is on LRU or not but it doesn't
hold page lock.  And it doesn't check this again after holding page
lock.  So it may race with some others, e.g. reclaimer, migration, etc.
All of them isolates page from LRU then lock the page then do something.

But it could pass the refcount check done by khugepaged to proceed
collapse.  Typically such race is not fatal.  But if the page has been
isolated from LRU before khugepaged it likely means the page may be not
suitable for collapse for now.

The other more fatal case is the following patch will keep the poisoned
page in page cache for shmem, so khugepaged may collapse a poisoned page
since the refcount check could pass.  3 refcounts come from:
  - hwpoison
  - page cache
  - khugepaged

Since it is not on LRU so no refcount is incremented from LRU isolation.

This is definitely not expected.  Checking if it is on LRU or not after
holding page lock could help serialize against hwpoison handler.

But there is still a small race window between setting hwpoison flag and
bump refcount in hwpoison handler.  It could be closed by checking
hwpoison flag in khugepaged, however this race seems unlikely to happen
in real life workload.  So just check LRU flag for now to avoid
over-engineering.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc579f724..bdc161dc27dc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1808,6 +1808,12 @@ static void collapse_file(struct mm_struct *mm,
 			goto out_unlock;
 		}
 
+		/* The hwpoisoned page is off LRU but in page cache */
+		if (!PageLRU(page)) {
+			result = SCAN_PAGE_LRU;
+			goto out_unlock;
+		}
+
 		if (isolate_lru_page(page)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
-- 
2.26.2

