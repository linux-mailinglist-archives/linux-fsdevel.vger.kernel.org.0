Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464647458E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGCJt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjGCJtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:49 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FA76BE;
        Mon,  3 Jul 2023 02:49:46 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-56-64a299b25f73
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
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 08/25] dept: Apply sdt_might_sleep_{start,end}() to PG_{locked,writeback} wait
Date:   Mon,  3 Jul 2023 18:47:35 +0900
Message-Id: <20230703094752.79269-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ732mr1TSXbKySoXcgSzVAZmBO8xJgsPl5jtsQPmmzr1nej
        GVTSAgJqBCmgyEUxWJHiSjG1gw5ZSxYRqR1G5BJqHQ1DU8koTMcEUbQotzFg8uXkl/M/5/fp
        z1PKW0w4r9WlSHqdOlHFymn5yDLrJ65yq2ZjxwAPFwo3QujNGRrMNxws+OpqETgasjEM3dsF
        f4wPI5jqekCBqcyHoKr/CQUNrX0Imu2nWegeXA7+0CgL7WXnWMipvsHCw+fTGAKXSjHUOvdD
        53krBs/EMxpMQyxUmHLw3Pgbw4SthgNbVhQE7Vc4mO7fBO19PQw0P14P5VcDLNxubqeh9WYQ
        Q/ctMwt9jlkGOlvbaPBdKGLg5xdWFp6P2yiwhUY5+N1jwVBvnBPlvf6XgftFHgx5137B4H/U
        hMB95k8MTkcPC3dDwxhczjIKJq/fQxAsHuEgt3CCg4rsYgTnci/R8GDmPgPGQBxMvTOzO+LJ
        3eFRihhdx0jzuIUmHVaRNF55whGj+zFHLM5U4rKvI9W3hzCpGgsxxFlzliXOsVKOFIz4MXnh
        9XKk7fIUTQb9Jnww4rB8q0ZK1KZJ+g3bv5YnVMz6qeQZRXplz0dZKLC0AMl4UYgVvdketMiz
        pzupeWaFj8Xe3okFDhPWiK6ip0wBkvOUkL9UtL/sYueDlYJeLKmrX2BaiBJNz/zMPCuEOLHQ
        PfVeulqsrfcsiGTCZvGvd8ULe+XcTaC8j52XikK+TDzb2Ij/f1gl/mbvpc8jhQUtqUFKrS4t
        Sa1NjI1OyNBp06O/PZrkRHONsp2cPnITjfm+aEECj1TLFL3HqzRKRp1myEhqQSJPqcIUOf0/
        apQKjTojU9If/UqfmigZWlAET6s+VMSMH9Mohe/VKdIPkpQs6RdTzMvCs9AH0QWf79u8OzhJ
        7SzOjPyma8/Ffe2p3+V43Y0HVjAPt7w6NdnzKsborvOWtJ5qiKzc0l048HZ6pcaQ989gaf7O
        t/tnkz+ToirS9h6JRNvkKTHk1xMHrpW+3GZuk+5sCBPuxFLr1wbzTuw2h4fKZNyXOn/T8g6d
        5dBPb+I/bYp7lNvlU9GGBPWmdZTeoP4PmcZHNU0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe99zznvmbHFYVgctqoUEXUwh7aEb9clDVCQEXSBytVMub7Wp
        aTe0qZm3VLBlzlKrKWqlsw928ZKiaZJarmUyR1ppomWZW81LpkZfHn78/39+nx4JJTcw7hJ1
        WISoCVOGKIiUlu7doltvyilUecf9WAeZqd5gH0uiwfCwjEDHg1IEZY/iMAw2+sM7xzCCiVft
        FOizOxAU9PZQ8KjJhqC6+DKBzk8LwGwfIdCSnUJAd+chgddDkxis17MwlJr2QGtGIYY65wAN
        +kECuXodnjlfMDiNJSwYYz2hr/gmC5O9PtBiszDQkNfCQHX3Wsi5ZSXwrLqFhqaqPgydTwwE
        bGXTDLQ2NdPQkZnGwP1vhQSGHEYKjPYRFt7U5WMoj5+xJf78w8CLtDoMiXcrMJjfP0VQk/QB
        g6nMQqDBPoyh0pRNwXhRI4K+9K8sJKQ6WciNS0eQknCdhvapFwzEW31h4reB7NgiNAyPUEJ8
        5Vmh2pFPCy8LeeHxzR5WiK/pZoV8U6RQWbxGuPNsEAsFo3ZGMJVcJYJpNIsVkr+asfCtrY0V
        mm9M0MInsx7vW3pYulUlhqijRM2G7YHSoNxpM3V6ShadZ1kVi6yuychFwnMb+enLrdQsE241
        39XlnGM3bgVfmdbPJCOphOKuuPLF31+R2WIhp+GvPSifY5rz5PUDZmaWZZwvn1ozgf5Jl/Ol
        5XVzIhfOj//8O30ul89srDk2koGk+WheCXJTh0WFKtUhvl7a4KCYMHW01/HwUBOa+RnjxcnM
        KjTW6V+POAlSzJd1nS9QyRlllDYmtB7xEkrhJtP13lbJZSplzDlRE35UExkiauuRh4RWLJHt
        OiAGyrmTyggxWBRPi5r/LZa4uMciv/TG/QG3kpOOuW4iHvd0207qd7/c6TEe0JyZMXXkuOWg
        1DIaWes6vvbQqCEj/PHCgrbn9x0/lGeKzEubPT9uDi7dTVXUXlokum93rDrhIldPRjvsFyo2
        Bp/I/Whpt833SVwmH+pPcFRtyMk65VjsjZ3h2oGpiF9vx1IO9p/rCfBfqaC1QUqfNZRGq/wL
        uvVjgC8DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by PG_{locked,writeback} waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/filemap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 83dda76d1fc3..eed64dc88e43 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -44,6 +44,7 @@
 #include <linux/migrate.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
+#include <linux/dept_sdt.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1219,6 +1220,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
+static struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
+static struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1230,6 +1234,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	if (bit_nr == PG_locked)
+		sdt_might_sleep_start(&PG_locked_map);
+	else if (bit_nr == PG_writeback)
+		sdt_might_sleep_start(&PG_writeback_map);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1331,6 +1340,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 */
 	finish_wait(q, wait);
 
+	sdt_might_sleep_end();
+
 	if (thrashing) {
 		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
-- 
2.17.1

