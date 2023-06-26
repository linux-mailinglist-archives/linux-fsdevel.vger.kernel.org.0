Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D0273DFAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFZMrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFZMrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:47:07 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C04B19AB;
        Mon, 26 Jun 2023 05:46:04 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-22-64997d6ca48a
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
Subject: [PATCH v10 09/25] dept: Apply sdt_might_sleep_{start,end}() to swait
Date:   Mon, 26 Jun 2023 20:56:44 +0900
Message-Id: <20230626115700.13873-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHeZ732mrdmw7mCxI1TTqNi4BOyDFeE018P0g02cwWXKbN+iLd
        Cmi5iYkLl7ooF4MmpQgNwaIdoTiw1YhCkRUtIAoVEZEUJrCIKIhhtrEUxcL0y8kv55z/73w5
        LCG/TUWwmpR0UZei0ipoKSmdWmperz15QR0zVh8J54piwPv2NAmm+joa3H9ZEdRdy8UwcXcP
        PPFNIgg86CHAaHAjuDgyRMA11zACR00eDY/+XQZ93mkaOg2FNORX19Pw8NUcBk/peQxWWzx0
        lZgxtPrHSTBO0FBhzMfB8gKD31LLgCVHCaM15QzMjWyAzuF+ChyD38CFSg8NzY5OElyNoxge
        3TLRMFw3T0GXq4ME97liCq68NtPwymchwOKdZqC3tQpDgz4oejnnwPDHfx8oaC9uDdKlqxj6
        njYhaDn9DIOtrp+GNu8kBrvNQMDsn3cRjJ6dYuBUkZ+BityzCApPlZLQ876dAr0nFgLvTPTO
        LULb5DQh6O1ZgsNXRQr3zLxws3yIEfQtg4xQZcsQ7DXrhOrmCSxcnPFSgq32DC3YZs4zQsFU
        HxY8/c208Lq7mxE6ygLk/sgE6Va1qNVkirro7YelSd1Fbuaoiz1+wzFI5aAeugBJWJ7bxI+9
        NzCf2WV9gReY5tbwAwN+YoFDudW8vfg5VYCkLMFVL+HHO+4sBr7k4vneD/mLAZJT8o+H+hel
        Mi6O95cMfTqwirc2tC6KJMF+030zWmA5F8vneZyfdgol/Evrgf85nP+7ZoAsQbIqFFKL5JqU
        zGSVRrspKik7RXM86pfUZBsKvpXl5NzBRjTj/s6JOBYplspiVpap5ZQqMy072Yl4llCEyr56
        Z1TLZWpV9glRl3pIl6EV05xoBUsqlss2+rLUcu6IKl38TRSPirrPU8xKInJQ5NO9T7btCEED
        87FLriuVksth8/pLMduzUq9aykqls6HWZ8dMUZZdo/F3lF8bm9Ymfmu8v/uHxPZAwk/k1uUZ
        gSttlF56/Ud5w0j5G9900ZbNFRnhcbsyf620Jvzzc+N4kyk84nePs/R7aa79i/b0kDCmAna0
        UAZu2+rojan7EvOxgkxLUm1YR+jSVB8BZG24cFIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG/Z/L/xxXq9MadSi6MLDAsDRSXlAqCvIQFEFE0Zda7ZCreWnz
        kpFhaVFeQgVbpZZOW+Isa4uydGJaUzPn0qVmU9IiM29dnLVmlyn15eXH8/D8Pr0sKTPQS1h1
        TLyojVFqFFhCSXaGpwVpUq6qgssmEeRmBYN78gIFhVWVGBx3TAgq758hYPhZJHRPjSLwtrWT
        oM93ICgZ6CPhvq0fgbX8LIbO9/PA6Z7A0JKfiSGttArDy5FpAlyX8wgwmXdAa46BgHrPEAX6
        YQwF+jTCdz4S4DFWMGBMDYDB8msMTA+EQEt/Fw2NRS00WHvXwNXrLgy11hYKbNWDBHQ+LsTQ
        X/mHhlZbMwWO3Gwabo8bMIxMGUkwuicY6KgvJuBuus/2adpKwPlvv2loyq73Udk9ApyvaxDU
        XXhLgLmyC0Oje5QAizmfhJ+3niEYvDTGwLksDwMFZy4hyDx3mYL2X000pLtCwfujEG+OEBpH
        J0gh3ZIkWKeKKeG5gRceXetjhPS6XkYoNicIlvJAobR2mBBKvrppwVxxEQvmr3mMkDHmJARX
        Vy0Wxu12Rmi+4qV2LdsviVCJGnWiqF238aAkyp7lYOJs7ImH1l46FbXjDOTP8twG3mb6SMww
        5lbzPT0ecobl3Erekv2BzkASluRK5/BDzU+ZmWIht4Pv+J02O6C4AP5VX9esSMqF8Z6cvn/S
        Fbzpbv2syN+X17wwoBmWcaH8WVcDzkGSYuRXgeTqmMRopVoTulZ3LCo5Rn1i7eHYaDPyfY4x
        ZTq3Gk12RjYgjkWKudLg5VdUMlqZqEuObkA8Syrk0kU/9CqZVKVMPilqYw9oEzSirgEtZSnF
        Yun2veJBGXdEGS8eE8U4Ufu/JVj/Jano1J4jbc4nJrmf6svTPe8ipaex/UnHsuN+u29UJ916
        u95u5J0F+w6POTSqi+FFYd1SpW4+tW1VCXpg+V6Vv2BiizdWP2dyG24LZAt/Hd26arzW+oiP
        3v5ivvwxn+DdtzVQPbcnr3OvJORnkV11+mZQWPObAH2Q4fPqpk2HWoczN1YoKF2UMiSQ1OqU
        fwGlIlRlNQMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

