Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F20745944
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGCJuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjGCJt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:57 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1FE4BE;
        Mon,  3 Jul 2023 02:49:53 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-1b-64a299b4ca43
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
Subject: [PATCH v10 rebased on v6.4 20/25] dept: Apply timeout consideration to waitqueue wait
Date:   Mon,  3 Jul 2023 18:47:47 +0900
Message-Id: <20230703094752.79269-21-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P1eXksIxOCRUjK4wuVtpL9yjofAm6fBAyqtEOOZpm07x0
        Ic1puVKyWOal2qbMpZY1DTJTluWti1mNXGaSYhfLtbK2nNPKGX15+fE8PL9PL0vIaqkZrCou
        UdTEKdRyWkJKnIHGhTUFJuWSz0WhkHd2Cbh/niahuKqSho4bFQgqa9IxDDRthk7PIALf02cE
        5Os7EBh73xJQ09yDoN5ykoaX/UFgd7toaNOfoSGjpIqG519GMXRfPI+hwroFHp8zYbB5P5KQ
        P0BDUX4GHj+fMHjN5QyY00Khz1LIwGhvOLT1vKKgvmsBFFzppuFefRsJzXf6MLy8W0xDT+Uf
        Ch43t5LQkZdDwfWvJhq+eMwEmN0uBl7YDBhuasdFWT9+U9CSY8OQVXoLg/11HYKG0+8wWCtf
        0fDAPYih2qonYKSsCUFfrpOBzLNeBorScxGcybxIwrOxFgq03RHgGy6m168UHgy6CEFbnSzU
        ewyk8MjEC7WFbxlB29DFCAbrYaHaEiaU3BvAgnHITQnW8mxasA6dZwSd046Fr+3tjNB6yUcK
        /fZ8vDVkp2S1UlSrkkTN4rV7JTGG7y4q/jaTcnlAnYa0tA4FsDy3nM9y6RgdYidYrw33xzQ3
        j3c4vISfg7nZfHXOB0qHJCzBnZrMW749ndhO4Xbz+mwL6WeSC+Vr655TfpZykXxhlxb/88/i
        K27aJkQB4/n74VzkZxkXwXcX9NB+Kc9dCODLHOnMv8F0/r7FQZ5DUgOaVI5kqrikWIVKvXxR
        TGqcKmXRvoOxVjT+UObjo9F30FDHjkbEsUgeKHUcNSpllCIpITW2EfEsIQ+WZvReVcqkSkXq
        EVFzcI/msFpMaEQhLCmfJl3qSVbKuP2KRPGAKMaLmv8tZgNmpKGZ3zuL44Pmt09NnJUH22SR
        I56N+1d37S4X2+csDFtz+8nm+7vG1hH2DSuOrfQtrlMf1w/WnfBlJoJv+x+j7RDv1D+sckp8
        1rFNpSdq31y/JmkxSdelHWUvVPRnZ0+ZHeVtjZirCJMkhxs/yH8t+2Tu3NCmCYoqiWSaWne+
        S1kV7ZGTCTGK8DBCk6D4CxOfu69MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxgG4L3vOec9h47iSUe2EzHTdFGjiw4WWZ4FZ/jnmxnFHxq/EqXa
        E6mWj7TSibqsjoqKgEBSkIJa0NQK+HVA5wcQUkK1GhRGwxgpjZBu2oBWHSV04CZdsj9Prtx3
        cv96BEZTzy0UDHmHZFOezqglKla1KaN4VXtdkz614noSVJWlQnTqFAsNN1oJ9F9vQdDafhxD
        uHc9/DY9iWC27xkDtfZ+BI1jowy0e4MIOt0/ExgMJYE/GiHgs58hUHzpBoGBiTkMgZpqDC3K
        RnhS2YShO/aChdowgfraYjx/XmKIuZp5cFmXwrjbwcPcWBr4gkMc9Jz3cdA58iXUXQgQ6Oj0
        seC9O45h8H4DgWDrvxw88T5iob+qnINrr5sITEy7GHBFIzz82u3EcNM2v1by1z8cPCzvxlBy
        +RYG/+8PEHSdeo5BaR0i0BOdxNCm2Bn4+0ovgvGKVzycKIvxUH+8AsGZEzUsPHv/kANbIB1m
        ZxpIZgbtmYww1Nb2A+2cdrL0cZNE7zlGeWrrGuGpUymkbe6V9FJHGNPGd1GOKs2nCVXeVfO0
        9JUf09dPn/L00blZlob8tXjzop2qtXrZaLDIpq/WZatynG8jXMFt/vD5sNGKbKQUCYIkrpHs
        trRSlCAQcbk0PBxj4k4Wl0ht5X9ypUglMOLJjyX3mz4SLz4Rd0v20242blZcKt17MMDFrRa/
        kRwjNhy3JC6WWm52/zeUMJ//MVOB4taI6VKgLkgqkcqJPmpGyYY8S67OYExfbT6YU5RnOLx6
        X36uguZfxvXjXNVdNDW43oNEAWkT1cNHG/UaTmcxF+V6kCQw2mR18dhFvUat1xUdkU35e0yF
        RtnsQSkCq/1M/f02OVsj7tcdkg/KcoFs+r/FQsJCK+rYzmd/+8XU2O7exmOh54o1K3ONEFo2
        6svKVD5dsS2xK+WnBZUHet9zBrpKP/vmTp+y6BerumrL3kDGnQmLY+ZxamK1ZkflUMmGwmDA
        U7AYq7d+Hrq6I99bMuA4W7bL8XX6dE312mX6cU34O2nnvpSI721Z0hFv1rqY09Lv9yw5oGXN
        Obq0lYzJrPsA5RcDsy4DAAA=
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

