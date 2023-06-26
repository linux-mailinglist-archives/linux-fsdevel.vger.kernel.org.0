Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA773DEE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjFZMUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjFZMUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:20:05 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8E13E53;
        Mon, 26 Jun 2023 05:19:28 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-e3-64997d6d0714
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 20/25] dept: Apply timeout consideration to waitqueue wait
Date:   Mon, 26 Jun 2023 20:56:55 +0900
Message-Id: <20230626115700.13873-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTWRSGZ5/LPqfVmmMlelSik0Y00ahoxKyo8TLRuOdhZlDfvASrPUK1
        VNIiiNERsRoHxAiRAtqZlEsqAgq2qCiUYBEEUUElWEklUq8dQBRtBenotEZfVr78a/3f0+Jp
        ZQM7jdfqkyWDXq1TYTkjHxxfNF9/qFAT/cKMIOdkNPg/nmDAUlWJofNSBYLKmiMU+JrXw+PA
        AIKxex005Od1Iijqe0pDTUsvAmdZBoZHLyZAl38IQ1teFoajJVUYHvQHKfCYcymosP8G7aeL
        KWgcfc1Avg/DufyjVGi8oWDUVs6BLT0KvGVnOQj2LYK23m4WnD3zoPAfD4Z6ZxsDLbVeCh7d
        sGDorfzKQntLKwOdOdksXHxbjKE/YKPB5h/i4GGjlYJqU0j0b9BJwfEPX1i4nd0YotLLFHQ9
        qUPQcOIZBfbKbgxN/gEKHPY8Gj6fb0bgPTXIwbGToxycO3IKQdYxMwMd/91mweSJgbERC169
        nDQNDNHE5EglzoCVIXeKRXL97FOOmBp6OGK17yOOsrmkpN5HkaJhP0vs5X9hYh/O5UjmYBdF
        PN31mLy9f58jrQVjTGzkZvkKjaTTpkiGhSu3yxOs74fYpCvc/r99unRkwplIxovCErHgeDX3
        gz8XDbJhxsIc0e0epcMcIfwsOrJfhXI5Twsl48TXrbe+FSYJv4vvex6HjnieEaJEc/CXcKwQ
        lopNroHv/pliRXXjN48slNfdLUZhVgoxYobHhcNOUciSia/On/lemCreLHMzp5HCin4qR0qt
        PiVRrdUtWZCQptfuX7Bzb6Idhb7Kdii4pRYNd25yIYFHqvGK6BkFGiWrTjGmJbqQyNOqCMXk
        kXyNUqFRpx2QDHvjDPt0ktGFpvOMaopicSBVoxTi1cnSHklKkgw/thQvm5aOYhLdq0YueimX
        OcPE/8HdvdqzkR6bfTDJV9NxuDfe8uFC7MTd1/5Mbs5MuVEbzNO2L5tpiXu3NWpNqXHHE/ev
        u/wrNqU6vDnpCatzJsVfnRiHm6sKxedrbm6z1Qk1nyakvazNiMwiazf0n/kyf1bkV39fvOS7
        HKGxrssNzJ4KpbJYFWNMUC+aSxuM6v8BdImIxFEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/xxXi9OSOhjdFhYVlV2UF4qIvngKkvpSYDdXO+VoW7aZ
        aWRZrjJNUclLpjU1lsxVNgssXY1Z6rpaMy2bktJtpdnFDS/L2qK+vPx4noffp5clZUY6jFVp
        E0WdVqGWYwkliVmZvkiTel4Z0XQ6HPLORoB3MIOC0usWDK3XqhFYbh4nwPMgGjp8fQhGnzwj
        oaigFUF5TxcJN5u6EdiqTmBwvZsIbd4BDM6CLAzpldcxPP/iJ8BdmE9AtXUDPMqtIMA+/JGC
        Ig+GC0XpROB8ImDYZGbAlBYOvVUlDPh7loKzu52GxjInDbbOhXD+ohtDg81JQVNdLwGuO6UY
        ui2/aXjU1EJBa142DVe/VmD44jORYPIOMPDCbiSgxhCwffbbCDj1c4yG5mx7gC7fIKDtdT2C
        uxlvCbBa2jE0evsIqLUWkDBy5QGC3px+Bk6eHWbgwvEcBFknCyl49quZBoM7EkaHSvGaVUJj
        3wApGGoPCTafkRIeVvDC7ZIuRjDc7WQEo/WgUFu1QKhs8BBC+Q8vLVjNZ7Bg/ZHPCJn9bYTg
        bm/AwtenTxmhpXiU2jg9VrJKKapVSaJuyeo4Sbzx+wCdcItJLvOo05ABZ6IQludW8CPl/XSQ
        MTePf/VqmAxyKDeLr83+EMglLMlVjuc/ttxngsVkLob/3tkRGLEsxYXzhf61wVjKRfGNjr5/
        zpl8dY39ryckkNc/rkBBlnGR/Am3A+ciiRGNM6NQlTZJo1CpIxfr98WnaFXJi3fv11hR4G9M
        qf68OjToinYgjkXyCdKIGcVKGa1I0qdoHIhnSXmodMpQkVImVSpSDou6/Tt1B9Wi3oGmsZR8
        qnT9FjFOxu1VJIr7RDFB1P1vCTYkLA3FTlhvZtkCza51rs1HoqJjLh5w0TXnjmrndEXVDDab
        O9q3f54KL9GbnDHnpSnLX0/37dH7difEWu8ZjJna3Cuu+cfqw4qrrm6wvDclzvZ1zq2fsWz+
        ZVmMbNuSmSNZYWO/G0pS3+2waOx14bu2ZWf8mr3s28jWtcuH8j3cppWTpC/j5JQ+XrF0AanT
        K/4AG6vq3jMDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ff349e609da7..aa1bd964be1e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -304,7 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1

