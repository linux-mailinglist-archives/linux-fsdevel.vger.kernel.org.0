Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DB7458F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGCJuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGCJtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:51 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD15212C;
        Mon,  3 Jul 2023 02:49:48 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-86-64a299b34ffc
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
Subject: [PATCH v10 rebased on v6.4 11/25] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date:   Mon,  3 Jul 2023 18:47:38 +0900
Message-Id: <20230703094752.79269-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x05nvx2bH23YbcbymInPDMsf1s9Dxox5+IOb+9FxXbn0
        aKaUpEe15fSA6+LcuvN0h4mylFKUosahjlooelrczbmKK/XPZ6+9P+/Pe+8/Piwhe0TNZlWa
        E6JWo1DLaQkp6fM1LLHlG5TLe/PmQU7GcnD+SiWh6LaFhuZbZgSWe4kYemqC4Z2rF4GnsYkA
        XV4zguKOdgLu1ToQVJjO0NDSNQ1anQM01Oel05BUcpuG1z+GMbRdzMVgtobAywsGDJXubyTo
        emgo1CVh7+jG4DaWMmBMmA+dpgIGhjsCoN7xloKKD4sg/0obDeUV9STUPuzE0PKoiAaH5S8F
        L2vrSGjOyaTgZr+Bhh8uIwFG5wADbyr1GO4ke4NSfo5S8DyzEkPKtbsYWt8/RvAk9TMGq+Ut
        DdXOXgw2ax4Bf27UIOjM6mPgbIabgcLELATpZy+S0DTynILktkDw/C6ig9YI1b0DhJBsixEq
        XHpSeGHghbKCdkZIfvKBEfTWKMFm8hdKynuwUDzkpARr6XlasA7lMkJaXysW+l+9YoS6Sx5S
        6GrV4e1++yRrlaJaFS1ql60/KAn91p5DRdjZ2JFnZUwCstNpyIfluZW8W5/NTHLT9z/UGNPc
        At5udxNjPIObx9syv3p1CUtw56bypsHG8ePpXBiflpgybiK5+fz5S/3jupRbxY86cyZC5/Lm
        O5XjHh+v/uV3FhpjGRfIt+U7Jkpk+/Ddgzv+8yz+qclOXkBSPZpSimQqTXSYQqVeuTQ0TqOK
        XXooPMyKvB9lPDW8/yEaat5ZhTgWyX2l9pPFShmliI6MC6tCPEvIZ0iTOq4qZVKlIi5e1IYf
        0Eapxcgq5MeS8pnSFa4YpYw7ojghHhPFCFE7ucWsz+wEtO1TbUBaQqAuvaFOdi3mQFD1rg2f
        UNnezY3HozUbcL7ar7jGvDveUdBV+HFOKd1R1bRVe3/x4Z0W39XhR9ZkHOxueeB556HmhC8M
        jj0TvC5VIupCzLK+FVsbWIcyZeP16ljHEld50abLp3F2w6zACKUiaosuPmJ7SQY6+npB157L
        cjIyVBHgT2gjFf8AEZjQbE0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99yX516qXW4qZndoMtdpTDQqhqFnQsw+4TO3OT+YzOzDpLE3
        UoFaW4uiYfIuoBBLggUFhbrUBvCFls3XmgoIFgIUS6Qa2ghBHMqLAYpAUVdY9uXkl9/5n/+n
        w9OKKjaK12iPSXqtKkWJZYxsT1zOJkeFRR39/hEG07loCE4XMFB5sx6D50YdgvrGLApGHu+C
        vplRBKHObhrMZR4ENQN+GhpbAwictmwM3qHPoTc4gcFddhZDztWbGHreLlDQf6GUgjr7z9Bx
        3kKBa+41A+YRDJfMOVR4/EPBnLWWA2vmOhi0XeRgYWAruAPPWGiucrPgfLERKi73Y3jgdDPQ
        emeQAu+9SgyB+k8sdLQ+YcBjKmbh+rgFw9sZKw3W4AQHT13VFNzKDbflT31koa3YRUH+nw0U
        9D6/j+BhwUsK7PXPMDQHRylw2MtomL/2GMFgyRgHeefmOLiUVYLgbN4FBro/tLGQ2x8LodlK
        /H0caR6doEmu4zhxzlQzpN0ikrsX/RzJffiCI9V2I3HYNpCrD0YoUjMZZIm9thAT+2QpR4rG
        eiky3tXFkSflIYYM9Zqpvat/k8WrpRRNmqTfsjNRlvTab2J1Pv7Eh5a7XCby4SIUwYvCt2L3
        m3l2kbGwXvT55uhFjhTWiI7i4bCX8bRwZploe9e5dLBCSBWLsvKXQoywTiwsH1/ycmGb+DFo
        4v4r/Uqsu+VaykSE/avZErTICiFW7K8I4PNIVo0+q0WRGm1aqkqTErvZkJyUrtWc2HzwSKod
        hZ/GmrFguoOmvbuakMAj5XK571SNWsGq0gzpqU1I5GllpDxn4IpaIVer0k9K+iMH9MYUydCE
        VvGM8gv57l+lRIVwSHVMSpYknaT/f0vxEVGZqCUUlefVbNSFGnTlv3zXZVtLjiZ4HGXb9s3/
        8fRQQkys5Sd/jNEvvHL9/U3L6ss/Ru6HtTHtiTr51+4+o9BTWJo1tcO5s3Py9309a4ZGdw+b
        Gz3t3tuWwS+r1KGMlXkDZriS3TDb98MN7fbh+GijdnnGHr4jeSLjr5OnA21Few/LlIwhSbV1
        A603qP4FQqFgYTADAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..fe89282c3e96 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	void			*flags;
@@ -246,6 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -263,6 +265,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1

