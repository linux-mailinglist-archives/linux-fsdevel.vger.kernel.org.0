Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C352D01A7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgLFI0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgLFI0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:26:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F670C061A51
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:25:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o4so6375341pgj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=qoRift2jV1B6a3umkUaVHUC3RdMLwR6ew6g8R0nSrZ9H3e5JTD8paUXgzqNsnFUdDp
         txMAue17NrbbuPrSnxB9L6j5TkpBu8Rbl9SNXsUV2tJ5fzr+oOLIJzvNIkGDsvyUxeOI
         GQXd7P7GEwRyywDQq5EFMjOVhvaaKNy3TCjQDPonI3Y51+fcEmhDuQ6kt4jIzrmKXRJo
         L8vswZbMmPglR6/mpjwShMGHnqmDNaKTHLF9dGdCx4sGHqZa12q6/QhjE5A6tGKjvClv
         d1tO81uQB9xdZhC6XXPffaOAihcqiNvA4glBALCf5nVfKvFN/l+F+L0Moo/th6/AN+DE
         0STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLGZC7sv5nAUpuhCShqzZAhxLbvYoPKLszNPrb+RhvY=;
        b=s4ZhfiF2ugSjxxBQtzmlNxqNEF5sV75Hp7W1Ze/Kxo601Vif3T1uUaIcHp7jceC4Bt
         gHLTb9f5zlcU6sngXSn0/szYm64Qn3GVuI5L0Pp2+ERk9f5xHzM/i86arcQ8O4f+gYAY
         XGXf87ZDihovqDiWSNtGAW9xawVMbmoo5vYEQK/JYOUGeS/onWyy0nVwc4RcTfYZkwLd
         gBDA1LRzUlPN23NMxf6NKCxz6+sylcv2obkyV4DL7dBUHN2V8YKR0qSGZ2hALhi9sVrf
         NgqcjF8OtP275x4OYEezYvqzKkNbxf3ItLmWD1WRf+l3SaZY3PtWBCBO7PuzHjircfiM
         KSHA==
X-Gm-Message-State: AOAM531JI/B1V54XiC7hb7jjGPIEjQNaw1CecVHs4udOHzzG0yyLZ7qP
        OikOV6O1uHdXGhgvZwoWCucvdw==
X-Google-Smtp-Source: ABdhPJx/0GwBWm79tEQQwiyYmG8pU+wlAB4R0dnRQOfOcHPETYvxsRxU+GZUlt7jzm2lH1hwsBwhfQ==
X-Received: by 2002:a63:1d5d:: with SMTP id d29mr14382201pgm.328.1607243134106;
        Sun, 06 Dec 2020 00:25:34 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.25.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:25:33 -0800 (PST)
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
Subject: [PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Date:   Sun,  6 Dec 2020 16:22:58 +0800
Message-Id: <20201206082318.11532-2-songmuchun@bytedance.com>
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

