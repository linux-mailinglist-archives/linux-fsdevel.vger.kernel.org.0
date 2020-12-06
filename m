Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660BA2D01B0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgLFI04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgLFI0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:26:55 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98AC08E860
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:26:00 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f1so5496788plt.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=kiHdmCDIlr4NkTd1dvaUQ6aOss/IHgJnkituhfu1gcpJQgbf7Gnh47zFIIuLjAn5WF
         HrQvfe9hmrfB147HA91725LflAnp+r6nObX1wa3n+L8aI+Z4QW5BjHzWcYmakrYhzATf
         1GcX6bmCmkh/BfjUn2POt7kPfjIVxmGUXCRD8/ixacwPB8i4XjAoNPg9ONLbEbwO+LfU
         AtDDTKPHv02yb4GBFy5fRF2n+UwO/ynMPO84tCnj5ndtad7Hf6q/B66EMzaUp8LKShkI
         Y6Z4v+8AAdczX96Fg5AiiwHncBAKMiKWMN5gfa7lyufOZKCylkoSol6Uj314+ZpYWLOf
         R31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=D5GUPCOa0pAQpeQt/UGT7OLflv9b1MZEoDC6FpDxGxgQLbO77YJdIgO4oMbACie+L0
         sBixt9YjYUM5PX1l86LNLdQAdYFrkRak3spYRt0rcpeW5peBSPwyDVeyAS6SEeiJc2p3
         OapGvxq4C2U08leRDOlSoXVt49UTxpWs1nNkMD0sKbPwc3hBRN6b41e4ixWznenP2Df/
         +9uVXXDN/z8RgPxJmbx325Wlml0Cg3eculfdc6xfUKTuFEwZdjV/mqCDd1WfvTHiT8au
         HR/o6KVp+VxgEuE4uaHrRuQdO/dUKXSrtBicC3rZzPqJ2dbgZCnfKv83MceLw/338Fru
         W0CA==
X-Gm-Message-State: AOAM5325+yPf4jh7ntoFR9BWyYPg4L7OBuEhQW+ee2fxzjnYdwjYGjCI
        BDMNTrR/GNVlWJm9fmxuJ8c+DA==
X-Google-Smtp-Source: ABdhPJxawxtVKmQeLtWgxwm+Tul2LcUf3UQH7wTkUkMdjFsdOI4DAFaYs10GDsNGpXutVBopPqd7VA==
X-Received: by 2002:a17:90a:7c44:: with SMTP id e4mr11359489pjl.138.1607243159347;
        Sun, 06 Dec 2020 00:25:59 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.25.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:25:58 -0800 (PST)
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
Subject: [PATCH 2/9] mm: memcontrol: fix NR_ANON_THPS account
Date:   Sun,  6 Dec 2020 16:23:01 +0800
Message-Id: <20201206082318.11532-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
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

