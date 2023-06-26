Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630B973DEDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFZMUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjFZMUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:20:05 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC8C39B;
        Mon, 26 Jun 2023 05:19:32 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-f4-64997d6d30d7
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
Subject: [PATCH v10 21/25] dept: Apply timeout consideration to hashed-waitqueue wait
Date:   Mon, 26 Jun 2023 20:56:56 +0900
Message-Id: <20230626115700.13873-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee7Lc2+rNTdV5yMum2nCJBoVGCwn0RD3wXBntmzJ1A9bjDT0
        RhqhmlZ5S4ggRRQpEQZUgUwsWyHQibaQoFDFIm8iUpUwJIUALiJCYbK1oYK4FrMvJ7+c88/v
        fPnztPI+G85rdWckvU6dosJyRu5db9mty76miSrrlkFJURT4/r3IQHWTDYP7ZiMCW3MuBTNd
        CfCnfw7B8sAgDeZyN4Ibk2M0NHePI3DWn8fw/K8NMORbwNBXfhlDXm0ThqezKxR4KkopaLR/
        B/1XLBR0BKYZMM9gqDLnUcHxmoKAtYEDa04ETNVXcrAyGQ1948MsOEd3wbVfPRjanX0MdLdO
        UfD8bjWGcdsHFvq7exlwl5hY+GPegmHWb6XB6lvg4FlHDQW3jEHRmxUnBRf+WWWhx9QRpN9u
        UzD0og3BvYsTFNhtwxg6fXMUOOzlNLyr60IwVezlIL8owEFVbjGCy/kVDAy+72HB6ImD5aVq
        fGCf2Dm3QItGR7ro9Ncw4iMLEe9UjnGi8d4oJ9bYz4qO+p1ibfsMJd5Y9LGiveESFu2LpZxY
        6B2iRM9wOxbnnzzhxN6ry8wPn/4k36+RUrRpkn5vfKI8+XFeEzpdzGX87TFROWiSLUQ8T4RY
        0l8eWYhka+h+Y+JCjIUdZGQkQId4k7CdOEyvgnE5Twu168h078O10EbhCBkpGGdDzAgRZHrQ
        iEOsEL4izRMTzEfp56TxVseaSBbctz22oBArhThy3uPCISkRCmTklevjZyJsJQ/qR5grSFGD
        whqQUqtLS1VrU2L3JGfqtBl7kk6l2lGwVtbslZ9b0aL7RxcSeKRar4j67KpGyarTDJmpLkR4
        WrVJ8cmSWaNUaNSZWZL+1HH92RTJ4ELbeEa1RRHjT9cohRPqM9JJSTot6f+/UrwsPAdlzfo7
        q3pelh5aXQzMhr1wv+1pIXsjChib4nrCutG0smx6e2S649uEgfASb+y7DV8e8Ma3HMwqy6uN
        +Ho++e77w4+SwvSXMppzVXX7Cnd9sWXb0VTz7+cM5JfEmCH8fdsOU9/mioHIQ8JyzLGx6Mpw
        +zexE3EHP7xExdcXumx3rPIiFWNIVkfvpPUG9X+WuxbJUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe97L826rxcuyerErC5HsooHGgSQKujwUhX2IqIxc7SWXOm1T
        S6Hwsm7abEpmXiqbsYZay+kHK1eiZS5LLcUspjiJzEsa2iRTs2n05fDjnP/5ffpLaIWZ9ZVo
        tPGiTquKVmIZI9u/JX1DzPl8dZDRvh6yrwWB5+cVBops5RhaH5UhKK9KpaD/1W74OD6EYPJd
        Cw15ua0I7rm7aKhq6EbgsKZhaPuyENo9IxicuZkY0ktsGN4PTlHguplDQZl9HzSZzBTUTvQx
        kNePoTAvnfKObxRMWEo5sKT4Qa+1gIMp9yZwdnewUH/byYLj8zrIv+PCUONwMtBQ3UtB29Mi
        DN3lMyw0NTQy0JptZOHhsBnD4LiFBotnhIMPtcUUPDZ4bQNTDgoujf1h4bWx1kv3Kyho//QM
        wfMrPRTYyzsw1HuGKKi059Lw+8ErBL1Z3zm4eG2Cg8LULASZF28y0DL9mgWDKwQmfxXhbaGk
        fmiEJobKs8QxXsyQN2aBPCno4ojh+WeOFNsTSKU1gJTU9FPk3qiHJfbSq5jYR3M4kvG9nSKu
        jhpMhpubOdJ4a5IJW3FEFqoWozWJoi5wa4Qs8m26DcVlced+uIxUCnKzGUgqEfhgoXXAyM0y
        5v2Fzs4JepZ9+NVCpfGrNyOT0HzJfKGv8eVcaBF/UOi83D33zPB+Ql+LAc+ynN8sVPX0MP+k
        q4Syx7VzIql3/+ytGc2ygg8R0lx12IRkxWheKfLRaBNjVJrokI36qMgkrebcxpOxMXbkbY7l
        /FR2NfrZtrsO8RKkXCAPWnlLrWBVifqkmDokSGilj3zJrzy1Qq5WJSWLutjjuoRoUV+HlkkY
        5VL5nkNihII/pYoXo0QxTtT9v1ISqW8KIhnX7x5YOqYeP/N1JXSNvuhI2+L2tsA2dkGfPGyr
        DgyJ53t2FcZVnG5vCsZW4wnT6WPhgjo/PKpv+VpTQoInM3Q6OQu7tCaF23p3RhomXRZ0I/Co
        /wXf3wZnwUBOwOBen2+GL22pO9eETYfuWOxk5pXOrGWV4cGHcxZvDy+yKBl9pGpTAK3Tq/4C
        5Kvx3TUDAAA=
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
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index fe89282c3e96..3ef450d9a7c5 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -247,7 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1

