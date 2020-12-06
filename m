Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D22D028A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgLFKRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgLFKRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:17:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D1C061A52
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:17:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c79so7019663pfc.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=sDQL9F0PUFel7IRE81/3eSpUKyMdwDgTZi3UBN+42b+bU2PNE/t3ymmlZSkl6G0zUE
         NSCG35LdEVF++dP/WfDe2t2uqtwSFpsGuaN57CFdrOLHb4WjfZ3jys2v2GYv1slCoxpV
         lHGI0MzqMCRhrpIXGMhucScdPb77XwS1gVQ8DA3u+zB/gPDofVk7OR0MNcSQkNxlPfaJ
         1RyynIXs88y3N+8Tuq6M1bZWNQoh5e5Y9f2FauDg2E2dRqtshDAZubBtA0H7xFytfcsr
         bP6zs0AWlZzZkTE8tZ0EnxPaZLjkWuzOMlhnw7qO6H+KSceypFyZdtq4GtFb8oTd85Yc
         RNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=F6EXCb1Pk5xeCGkzNKHy+V3jNN1OHRviU/6mX5lKYdKJo8dgeN/kwVDyL25xUcoKiA
         xXYTMbuHZLF6M+ivbKL7+B9TlHJOHr/Tjc78zMIWMPiHYTPEUJi5zjBIQh6kryeUyfG9
         lISrMt7QMdF2N+zcJWRAU7mLZobCXYzt+OOiYnE2bW1Urca5WpIfuZ3TRIs2JO0OBAkl
         ahsSKDCwjXxGv/MwVW/+Yeig2M2IsdEjtfM6/+bJXrDvMTpqvyDf7ev5hFgs+23gldR/
         Wn13UrqT7ctd01/cd1k1oxkCP5HrTF6mZwuIL/H4n4joHB5DKvtVhaosLZt7IU8z3Mz5
         JXAw==
X-Gm-Message-State: AOAM532SUNZ/k6Y6Y/1NjNHJPOr9+LR74m/z+0d9KzAaq/Qj68wiB/gZ
        StUHijD43QyQKJtNS0jZtin2eA==
X-Google-Smtp-Source: ABdhPJwrEym39f3aZ6PyYuujbHaEjIbhRNOiqu9p7TRph3J6zvXaoYG5vwozGaIuyksCOLbrQRARnQ==
X-Received: by 2002:a62:88c3:0:b029:18c:3203:efb7 with SMTP id l186-20020a6288c30000b029018c3203efb7mr11447624pfd.33.1607249819828;
        Sun, 06 Dec 2020 02:16:59 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.16.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:16:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Date:   Sun,  6 Dec 2020 18:14:40 +0800
Message-Id: <20201206101451.14706-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22d9bd688d6d..695dedf8687a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5634,10 +5634,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

