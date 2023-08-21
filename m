Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772F6782253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjHUEHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjHUEHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:07:00 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4129A2;
        Sun, 20 Aug 2023 21:06:57 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-7c-64e2ded5515b
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
Subject: [RESEND PATCH v10 09/25] dept: Apply sdt_might_sleep_{start,end}() to swait
Date:   Mon, 21 Aug 2023 12:46:21 +0900
Message-Id: <20230821034637.34630-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe597gtXa66dmc/EOG1iTFhkanw52YYxmdEn2TQmmzHqB71b
        r6NaQMubLFmCUsAp+MKCqIApoLWBKtLqVsBiRQHRAHVFBIZMKlGJRTZcGZVOV3z5cvLLOf/z
        +/QXWW0tN1s0JKaopkTFqOMlLA1PK1t0r9+vX9zQFwvH8xZD8J+DGEqq7Tx4L1YhsF/ez8BQ
        0zq4PxZAMNHWwUJRoRdB2cADFi439yNw2w7w4BucDp3BER5aCw/zkFVRzcPdZ2EG+k4UMFDl
        WA93jpUz4Ak9wVA0xENxURYTGU8ZCFkrBbBmLgC/7bQA4YEl0NrfxYG79xM4daaPh6vuVgzN
        Lj8DvroSHvrtrzm403wLg/d4PgcXnpfz8GzMyoI1OCLA7x4LA5fMEVHOi1cctOR7GMg5W8NA
        Z089goaDDxlw2Lt4uBEMMOB0FLLw8nwTAv+RYQGy80ICFO8/guBw9gkMHf+1cGDuWw4T4yX8
        6s/ojcAIS83OdOoes2B6u5zQ2tMPBGpu6BWoxZFKnbYYWnF1iKFlo0GOOip/5qljtECgh4Y7
        Gfq8vV2gt05OYDrYWcRsjN4qfaFXjYY01fTpqh1SfHueV9jTLO77zd3LZaIO/hCKEom8jNQ2
        XePes9n8JzvJvLyQdHeH3vBMeR5x5j+OZCSRlXOnEttfbZFnUfxA/pa4Tq2fzGB5AfHV9OBJ
        1sgrSN3r4nf+j0nVJc8bT1Rk76ivQ5OslZeTvwce4beZo1HE5frqLX9Ertu68TGksaAplUhr
        SExLUAzGZbHxGYmGfbHfJyU4UKRQ1p/C21xo1PtNI5JFpJum2THHr9dySlpyRkIjIiKrm6mJ
        /ndAr9XolYwfVVPSdlOqUU1uRNEi1s3SLB1L12vlH5QUdbeq7lFN76+MGDU7E+1uqc7ntqzN
        Ls0t2XnAGyc9DOz88o+aXeUxF0M1K9p+yZZW4rlpcbn1cVM2bLq7d+N3gSuDbQ0ZBRNnw75V
        53S5SZasr+d5zWt+JbtSnefCI+MEBz8fv/IofQY7v0y5+Vh5hbevvfBhxyLRZ9/cJSWtHO/J
        MXpQhURKU5aytK5dh5PjlSUxrClZ+R8RW41iTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ77SqXmpqDcgEZXY0ycr5HqSVRiYgiPJk4TTRb94OjWq20s
        L2mViVEDUhB5i5gACmgQXUVgChfNEClpIIBVgSrMASvV1kZF0SpSFEGxmO3LyS//c/6/T4en
        VOVMJG9IPCSZErVGNaugFT9tyFjxt9urW91yMgIK81ZDYCybhvIbtSw4r9cgqL2ZjmG4PQ7+
        GR9BMNnVQ0FJkRPBJc8QBTc73AhsVSdZ6PXNgb6AnwVHUS4LGZdvsPDw9RQGV/FZDDXydrh/
        phKDfeIFDSXDLJSVZODgeIlhwlrNgTVtCXirSjmY8qwBh/sxA20XHAzYBn+E8xddLDTbHDR0
        NHox9DaVs+CunWbgfsddGpyF+Qz8+baShdfjVgqsAT8Hj+wVGOosQVvWh68MdObbMWRdqcfQ
        N3AHQUv2Uwxy7WMW2gIjGBrkIgo+X21H4C14w0Fm3gQHZekFCHIzi2no+dLJgMWlgclP5ezm
        DaRtxE8RS8PvxDZeQZN7lSK5XTrEEUvLIEcq5MOkoWoZudw8jMml0QBD5OrTLJFHz3Ik500f
        Jm+7uzly99wkTXx9JXjn/L2KjTrJaEiRTKti4hX67jwnl9zBH/nLNsikoR42B4XwohAtWixP
        qBlmhaVif//Edw4XFokN+c+ZHKTgKeHUbLHqXVewwPNhwm6x8fz2mRtaWCL21g/QM6wU1olN
        02X/OReKNXX2756QYC7faUIzrBI04nvPM/oMUlSgWdUo3JCYkqA1GDUrzQf1qYmGIyt/S0qQ
        UfBnrMenChvRWG9cKxJ4pA5Vxs/36lSMNsWcmtCKRJ5ShyujPnp0KqVOm3pUMiX9YjpslMyt
        KIqn1RHKbT9L8SrhgPaQdFCSkiXT/1vMh0SmIeHWg6vpxWH79p/yy5YF7T3O9OVtsTGaW6/m
        7TDpY/Sx5A9j67nIop2fOyV6cfHW9e8L5iYbNc1dvtmzjs2lY0PfRe//t/TX7LVjD8Iqo9w/
        XCdhD3V7TuBnGtsuMdQxZH26aXTVNbtv3Ytkn7d/yyJXtmt8Ojo2aY9l0NnlGYjwq2mzXrtm
        GWUya78BjoQ5KS8DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by swaits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..02848211cef5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 #include <asm/current.h>
 
 /*
@@ -161,6 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
+	sdt_might_sleep_start(NULL);					\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
@@ -176,6 +178,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 		cmd;							\
 	}								\
 	finish_swait(&wq, &__wait);					\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1

