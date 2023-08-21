Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52797782260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHUEIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHUEIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:08:12 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3379197;
        Sun, 20 Aug 2023 21:07:30 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-9b-64e2ded5b3e2
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
Subject: [RESEND PATCH v10 11/25] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date:   Mon, 21 Aug 2023 12:46:23 +0900
Message-Id: <20230821034637.34630-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/fXR3PLuYhP29rTRE18ZmZ38vDZmw2I39wcw/d1OEiZTPR
        CSUqErnZVXZOXdKTWaprKf3SKDp1Uq27GqIfXC5Ohbvwz2evvT97vz7/fBhcVkbOZlTq44JG
        rYiSUxJCMuiTu6St265c9m4tpF9eBs5vFwnQFZkoaHlQgMD06CwG/bWboX10AMHYi2YcsjJb
        EOTYunB4VNeNwGw8R0Fr31SwOIcpaMxMoSAxr4iCV5/HMei8kYFBgbgNmtJyMahyfSAgq5+C
        21mJmHt8xMBlyKfBkOAPdmM2DeO2EGjsbiPB3BEEt+50UlBhbiSgrtSOQWuZjoJu028Smuoa
        CGhJTyWhcCiXgs+jBhwMzmEaXlfpMXiodYuSRn6RUJ9ahUHS3WIMLG/LEVRe7MFANLVRUOMc
        wKBEzMTh571aBPYrgzScv+yi4fbZKwhSzt8goHmingRtZxiM/dBR61bxNQPDOK8tOcmbR/UE
        /zyX459kd9G8trKD5vXiCb7EGMjnVfRjfI7DSfJi/iWKFx0ZNJ88aMH4oZcvab7h5hjB91my
        sB1+EZLVSiFKFStolq7ZL4n80JVOHrUycRPPntAJyEolIy+GY5dzKf1D+H8uzxFJD1NsAGe1
        uibz6ewCriT1vTuXMDh7wZszfnkxWfZlldy7zmTawwTrz93/2kR4WMqu4Fwjun8H5nMFD6sm
        RV7uXCwvQx6WsWHcV1sv4ZFybKIX195rIP8WZnFPjVYiDUn1aEo+kqnUsdEKVdTy4Mh4tSou
        +MCRaBG5P8pwenxvKXK07KxGLIPkPtL9c+xKGamIjYmPrkYcg8unS/2+25QyqVIRf0rQHNmn
        ORElxFQjP4aQz5SGjp5UythDiuPCYUE4Kmj+bzHGa3YCMvlrw2FOUlDztwA8tLQyQhoSqr7W
        8bZYsssctiVu5fP1u3tDM2SF8/Yuaui431cZ9Cl86wx7evCZ7d4zIn66vKObfNTrvSHlahHn
        OGPXX1toUTlm9mzbs/FC65vr9aSuxzb3oFQ7MoE+5R+oSNuw4vFYe/gx587emk2Lf0zzzcsJ
        khMxkYqQQFwTo/gD5JDsxU0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/fnY5nJ+tRVnZbQ+ZHm+wzzGxmnhlmptn8mI57pqPS7irO
        Zi79UmSdSUpxFSd1yHMNueIU1Wn94ELU3XRMmiPJHafCnfHPe6+9P/u8/nozuKycDGNUyamC
        OlmRKKckhGTTisyFz50u5RKPOQr0p5aA59sJAspumijouVGLwFSfgcHw43Xw0utGMN7ZjUNx
        UQ+CikEHDvWtTgRN1ccpsL+bBr2eEQpsRScpyKy6ScHTjxMYDJw7g0GtuBE6CisxsPqGCCge
        puBCcSbmjw8Y+Iw1NBh1UeCqLqVhYjAGbM4XJLSU20hoer0ASi4OUNDYZCOg9a4LA/u9Mgqc
        pt8kdLS2E9CjLyDh+udKCj56jTgYPSM0PLMaMKjL8ttyxn6R0FZgxSDn8i0Mel9ZENw/8QYD
        0fSCghaPGwOzWITDz6uPEbhOf6Ih+5SPhgsZpxGczD5HQPdkGwlZA7Ew/qOMWr2Cb3GP4HyW
        +RDf5DUQ/JNKjm8oddB81v3XNG8Q03hzdTRf1TiM8RVfPSQv1uRRvPj1DM3nf+rF+M9dXTTf
        fn6c4N/1FmObZ2+XrFQKiap0Qb14VbwkYcihJ1P6mMOTjxpoHeqj8lEQw7FLOUuFSAaYYudy
        fX0+PMAh7BzOXPDe30sYnM2dylV/6fz7MINVcv0D+XSACTaKuzbaQQRYyi7jfGNl/6SRXG2d
        9a8oyN+LlnsowDI2lhsdfEsUIokBTalBIark9CSFKjF2keZAgjZZdXjR3oNJIvKPxnh0Qn8X
        fbOva0Ysg+TB0vjZLqWMVKRrtEnNiGNweYg0/PugUiZVKrRHBPXB3eq0REHTjMIZQh4qXb9N
        iJex+xSpwgFBSBHU/68YExSmQ7mqJDZ1w50GZSnuNaz2llxtvG1cFfRgvrtfl7fVIY2caW4e
        qt07fUy3w7IrrSH8d3Dw0kdr7Ieu5O5/kDHv4fI9Cy6ZDAqrQV8SkXPslb3buTPC9nI7td5c
        oN0ZysyNS88zzLg+K3+tNsJR6LMwYdn1c8iFm+K65WcnI8O3uFtH5YQmQRETjas1ij8RsZMA
        MAMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

