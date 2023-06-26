Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32CD73DE9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFZMOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFZMOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:14:03 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87E5AE7D;
        Mon, 26 Jun 2023 05:13:56 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-b7-64997d6b4fa4
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
Subject: [PATCH v10 03/25] dept: Add single event dependency tracker APIs
Date:   Mon, 26 Jun 2023 20:56:38 +0900
Message-Id: <20230626115700.13873-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf1CLcRzHfZ8f32eN8ZjwiKMbnZOTOD8+0Tn+4XHOHefOH/kjYw+NVSya
        cp0oLlESNapztZjUYrb8rCVLafJjqcu46TROUukuNpvmxwr/fO51n/fr3p9/PiJSWk+HiJQJ
        BwR1glwlw2JKPDBOt2Bv2kVFZG2ODM6ejgT3tywKSm4YMNivVyEw1BwloLdpHbzy9CMYfvaC
        BG2BHUFZ91sSapq7EFgqjmFo/zAeOtyDGGwFpzBklN/A0NbnJ8BZmE9AlWkjtObpCGjw9VCg
        7cVQrM0gAuMTAT59JQP69DBwVRQx4O9eBLauThosb+bDxUtODHUWGwXNd10EtN8vwdBl+E1D
        a3MLBfazOTRUf9Fh6PPoSdC7Bxl42VBKgDEzUPTZbyHgxNdfNDzOaQjQ5ZsEdLyuRVCf9Y4A
        k6ETQ6O7nwCzqYCEH1ebELhyBxg4ftrHQPHRXASnjhdS8OLnYxoynUth2FuCV6/kG/sHST7T
        rOEtnlKKf6Lj+HtFbxk+s/4Nw5eaDvLminC+vK6X4MuG3DRvqjyJedNQPsNnD3QQvLOzDvNf
        nj9n+JYLw9SmGTHiaIWgUiYL6oWrtovjrHlF9L5XUw95tLPSUYc0GwWJOHYJ5zrzlfrP72x+
        NMKYncs5HD5yhIPZUM6c85HORmIRyZaP5XpaHjEjwSR2PdfTaB2VKDaM++hrH2UJu5Trbr7y
        r3QWV2VsGN0Hscu42qe60QPSgHPMacV/nXNBnOM685encQ8rHFQekpSiMZVIqkxIjpcrVUsi
        4lISlIcidibGm1Dgq/Rp/m130ZB9ixWxIiQbJ4mceUEhpeXJSSnxVsSJSFmwZIpXq5BKFPKU
        VEGdGKs+qBKSrGi6iJJNlSz2aBRSdrf8gLBXEPYJ6v8pIQoKSUfzHKppUakWV2Jf1Azjrpjw
        87He4kQ71XNnTWf+zepV0ZwipHjt7bRH25YbFf2bbiWnr7g0cUJv1q6oW61Tgp86vRmTnRGa
        2NA57zeEaWziNoxnj0nVSKor9+/3thjnHhloa61tela449u1mh2b93zPNdf9yI4mDI3MPfHW
        BSsfOA7LqKQ4+aJwUp0k/wNpr8oFUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxjF/d/X0llz0xG5Y1G0GcOAQ1iGeSKgftK/RhdjTEYWDXT2ZnQU
        NK10YGJSoRBEqEACRUADFCqBMrA1BpWa2spL5xtKQUcqEbLJUISotFKpYsH45eSXc07O8+UR
        kdImOlKkzDkhqHPkKhkjpsQ/Jxf+kHXqvCKh5VwYVJYlgG++hIKGLgsDQ391ILBcOU3AdN9u
        eOyfQbB47wEJxuohBE0TT0m40j+OwN5WwMDwv2vA45tjwF19loFCUxcDD18GCfDWVBHQYd0P
        dyqaCXAEpigwTjNQbywkQvI/AQFzOwtmXTRMttWxEJxIBPf4KA2uC24a7GNxcP6il4Feu5uC
        /p5JAoavNzAwblmi4U7/IAVDleU0dM42M/DSbybB7Jtj4ZGjkYBufWjtRdBOQPHbjzQMlDtC
        1HKZAM8/NxDcLHlGgNUyyoDLN0OAzVpNwvtLfQgmDa9YKCoLsFB/2oDgbFENBQ8+DNCg9ybB
        4kIDszMFu2bmSKy3/Ynt/kYK/93M42t1T1msvznG4kZrLra1xWJT7zSBm974aGxtP8Ng65sq
        Fpe+8hDYO9rL4Nn791k8WLtIHVj3qzhFIaiUWkG9ZXuGONNZUUcffxyR5zdG6ZBHWorCRDz3
        E//MHUTLzHAx/JMnAXKZw7kNvK38OV2KxCKSM33FTw3eZpeDr7k9/JTLuVKiuGj+eWB4hSVc
        Ej/R30p9Ho3iO7odK34Yt5W/cbd55YA01CnwOpkKJG5Eq9pRuDJHmy1XqpLiNVmZ+TnKvPij
        x7KtKPQ45lPByh40P7zbiTgRkq2WJKyvVUhpuVaTn+1EvIiUhUvWLhgVUolCnn9SUB9LV+eq
        BI0TfSuiZBGSvb8IGVLud/kJIUsQjgvqLykhCovUodi0vGtLuTFzNZ0v3g6sNhlHdqSm93Tp
        Du3TJr7b44n9LxkVbWjTL8UdNHw83HJA67b0FqRs3FTcao2xRbYmrh3Zdj1iNmXsmyO1S7tU
        aTjuj/KoluiFNIf/+w9lCXeNI7c6CjcZqr5LGtcN1Zzb7BIf4q+GVxiI+tSo34p/fL3ddFJG
        aTLlibGkWiP/BA+c/uo0AwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wrapped the base APIs for easier annotation on wait and event. Start
with supporting waiters on each single event. More general support for
multiple events is a future work. Do more when the need arises.

How to annotate (the simplest way):

1. Initaialize a map for the interesting wait.

   /*
    * Recommand to place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Recommand to place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..12a793b90c7e
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1

