Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2358278228D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjHUELf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjHUELe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:11:34 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04624ED;
        Sun, 20 Aug 2023 21:11:07 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-1b-64e2ded6ac26
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
Subject: [RESEND PATCH v10 19/25] dept: Apply timeout consideration to swait
Date:   Mon, 21 Aug 2023 12:46:31 +0900
Message-Id: <20230821034637.34630-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/xzud/Xba/Iix27BleWafYcbGfDcamxmL4eZ+03FduVLO
        ZrtTkp5UWw9oVrHrekB+2RCXU4pKiW4JaTp5SE+Ui1Me7sI/n732eX8+r33++PCU+jYzg9cb
        YySTUWvQsEpaORBQGPK8y61bnLUBMlMXg+drEg3518pZaL1ahqD8hhVDb90meD7aj2Cs+QkF
        udmtCAq7X1Nwo74LgcN+koW2ning8gyx0JCdwkL8pWssPO0bx9CZk4WhTA6FpowiDE7vBxpy
        e1m4kBuPfeUjBq+tlAObZS647ec5GO9eAg1d7Qw4Xi6Acxc7WbjraKCh/pYbQ1tVPgtd5b8Z
        aKp/RENrZhoDVwaLWOgbtVFg8wxx8MxZgKEiwSdKHPnFwMM0J4bEy9cxuF7cQVCd9AaDXN7O
        Qq2nH0OlnE3Bj+I6BO70AQ5OpXo5uGBNR5ByKoeGJz8fMpDQuQLGvuez61aR2v4hiiRUxhHH
        aAFNGotEcvv8a44kVL/kSIF8lFTag8mlu72YFA57GCKXnmGJPJzFkeQBFyaDLS0ceZQ3RpMe
        Vy7eFhSmXKOTDPpYybRo7X5l+Mc3oVEj7DFr9WfaghqZZKTgRWG5mJflpP/zg2dJlJ9ZYb7Y
        0eGd4EBhjliZ9t43r+Qp4fRk0f65mfUHU4Ut4oOrI5yfaWGu2CgPTSyohJXi/bMt1F/pbLGs
        wjnBCl9fvlOF/KwWVohfut/SfqkonFaI77yN/66YLt63d9AZSFWAJpUitd4YG6HVG5YvDDcb
        9ccWHoiMkJHvoWwnxnffQsOt22uQwCNNgGr/TLdOzWhjo80RNUjkKU2gKuhbt06t0mnNxyVT
        5D7TUYMUXYOCeFozTbV0NE6nFg5qY6TDkhQlmf6nmFfMsKCwI4a2KSGWUO8cxhxIr7aHcOun
        625+iH0HUenXA1aRijXjuKrBPCtnfeayn5/mReW9aiaH9rzYXB+f5qhrexyy2mF53DkrZjCj
        pK+9uDYopYnfaw0eDru4yHzosLAjskR173dgyd5daNpavWhL3al4lWM9YIwrTkzu2aDa6BrY
        qqGjw7VLgilTtPYPTYEwIEwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX8P3991XPs5mR8y3CQLiSmfYWYz853J/OH5H93cb7p1pd2R
        ylinQx56MokKJ5xWp/K7kIdrp4jLeqAW2Wk6hVsl5CIVrsw/7732fn8+77/eMlpZwE6TaeP2
        ifo4tU6F5Yx844rUha3tbk1Yhn0uZJ8OA+/3NAYKyqwYmkpLEFgrjBR4nqyDVwM9CIbqG2nI
        zWlCcKXjLQ0Vte0I7EVHMDR3+kOLtw+DM+cUhtSrZRhedA9T4Dp3hoISKRKeZxVS4Bj8yECu
        B0N+birlk08UDFqKObCkBIG7KI+D4Y7F4GxvZaHmopMF+5v5cOGSC8NDu5OB2ko3Bc33CzC0
        W/+w8Lz2GQNN2eks3PxciKF7wEKDxdvHwUuHmYJyk6/tWP9vFp6mOyg4du0WBS1tDxBUpb2j
        QLK2Yqjx9lBgk3Jo+HXjCQJ3Ri8HR08PcpBvzEBw6ug5BhpHnrJgcoXD0M8CvHoFqenpo4nJ
        doDYB8wMqSsUyL28txwxVb3hiFnaT2xFIeTqQw9FrnzzskQqPoGJ9O0MR072tlDkc0MDR56d
        H2JIZ0sutSlwp3ylRtRpE0T9olVR8uhP7yLj+3GiseoLk4Lq2JPITybwS4XHL9PoUcZ8sPD6
        9eAYB/CzBFv6B9+NXEbzx8cLRV/q8Wgwid8gPC7t50aZ4YOEOqlv7EHBRwiPMhvof6UzhZJy
        xxj7+XzpwX00yko+XPja8Z7JQnIzGleMArRxCbFqrS481BATnRSnTQzdvTdWQr7NWA4NZ1ei
        783rqhEvQ6oJiqhAt0bJqhMMSbHVSJDRqgDF9B8dGqVCo05KFvV7d+n360RDNZouY1RTFOu3
        iVFKfo96nxgjivGi/n9KyfympaCuRDEItmRNrmuMyUgODntf4tCFkx9TlgVGdM+5tbs8cOeO
        S4eMnuV+zbd3zB1Y8qFybdCf0DvnI4I9m9eY2BnbuytcOJl1tdWv+sjG/3bmHe4ZaYscb3Vs
        Pbs083bmgsl3R+QO4/YXbb1dExWKnFfZXQendl6+Ps9xQrRPnW0L8WdVjCFavTiE1hvUfwHo
        Dif3LwMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 02848211cef5..def1e47bb678 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1

