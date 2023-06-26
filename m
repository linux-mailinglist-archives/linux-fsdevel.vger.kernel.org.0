Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0436D73DFB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFZMrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFZMrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:47:31 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB552699;
        Mon, 26 Jun 2023 05:46:38 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-35-64997d6ceff0
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
Subject: [PATCH v10 10/25] dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
Date:   Mon, 26 Jun 2023 20:56:45 +0900
Message-Id: <20230626115700.13873-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUyTZxTH97wfz/u22u1NBX2mqEsn2+ICK0aXs6mbu1h8srhkm9kStwtt
        6BvpLOCKosxoAEGhWAddsApkluJqhQ6k9cINShAUqKB0whjDgkrYkEllAcrsYB8tZjcnv5zz
        P7+rv8iqW/iVoiHjgGzK0Bk1WMkpQ0sdScaj5/TaX2dehLJTWgjPFnFQ1eDGEKivQ+C+ksfA
        xI3t8PPcJIL5W70s2MoDCKofDLNwpWMEgc+Vj6Fv7FnoD09h8JeXYDhe04Dhx0cLDATPWBmo
        87wP3aUOBloj4xzYJjBU2o4z0fGQgYizVgBnbiKMuioEWHiQAv6RAR58Q6/CuW+CGJp9fg46
        ro4y0PdDFYYR9788dHd0cRAos/Dw3WMHhkdzThac4SkB7rTaGbhcEBX9vuBj4MTMPzx0Wlqj
        dKGRgf5fmhC0FN1nwOMewNAenmTA6yln4a+LNxCMng4JUHgqIkBl3mkEJYVnOOj9u5OHguAm
        mH9Shbdtpu2TUywt8B6ivjk7R286CP2+YligBS1DArV7DlKvaz2taZ5gaPV0mKee2mJMPdNW
        gZpD/QwNDjRj+vj2bYF2nZ3nPkj4VLlFLxsN2bLptbf2KNP8TUf2X1IcbvlqCOWii4IZiSKR
        NpIxa4oZKRaxeLxeiDGWXiaDgxE2xnHSC8Rr+Y03I6XISjVLyHjX9cXQMukT8vCSazHESYnk
        REkfjrFKep3c/6NSeCpdS+outy5mFNF9U48DxVgtbSL5wTYckxLppILcdPq5pw/Pk2uuQa4U
        qezomVqkNmRkp+sMxo3JaTkZhsPJqZnpHhRtlfPowmdX0XRgZxuSRKRZqtKuOatX87rsrJz0
        NkREVhOnWv7Epler9LqcL2VT5m7TQaOc1YZWiZxmhWrD3CG9WtqrOyDvk+X9sun/KyMqVuai
        XapXZhVb848lrSKBuIiqeSxpJg8XZq7uWhf6KN73+V1ZrN9J38w++W31XkVx6dY1iUF7+5F3
        P173XucyU/qu7tT4sjd+em7zF5aX7rmur9VuD4my2b7j7eS7OxKKzMNecv6CtTe1Z4vV3Xje
        UvHnhz0J1/xfN87a+je8424o1DrjkzVcVpouZT1rytL9BxrIrrZRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe8/lPcfV5LC0DnYfRGFoBhoPZbcP0VtURGBBFDnaIVfTYjPT
        bpguqamVhlleykuspXbb/FDpZMxSp2XWxMzmMIvUMu02aWnZlPry58fz/Ph/+vO0opQN4TUJ
        iZIuQaVVYhkj27oyPUx78qo6wmKVQU5WBHh/nGWg6G4VhrY7lQiqqk9TMPBkA7waGUQw+uw5
        Dfl5bQhK33bTUN3gQWAzp2FwvQ+Edu8wBmdeJob08rsYXnwao8B9OZeCSssWaLlYRoHd18dA
        /gCGwvx0yh/9FPhMFRyYUhdCr7mAg7G3y8Dp6WChvtjJgq1rCVy95sZQa3My0PCglwLXoyIM
        nqpxFloamhhoy8lm4fZQGYZPIyYaTN5hDl7aSyi4Z/C3fRyzUZDx/Q8Ljdl2P924T0H76xoE
        dWd7KLBUdWCo9w5SYLXk0fDr5hMEvec/c3Amy8dB4enzCDLPXGbg+e9GFgzuKBj9WYTXRpP6
        wWGaGKxHiW2khCHNZSJ5WNDNEUNdF0dKLEeI1RxKymsHKFL6zcsSS8U5TCzfcjli/NxOEXdH
        LSZDra0caboyymybs0sWrZa0miRJt3R1rCzOWXP88K2A5LoLXSgV3eSMKIAXhUjxXN+dScbC
        IrGz00dPcJAwX7Rmf2CNSMbTQvlUsa/p8aQ0Xdgh9t8yT0qMsFDMyHThCZYLy8WeL4X/SueJ
        lffsk06A/17ztAxNsEKIEtPcDnwRyUrQlAoUpElIildptFHh+oNxKQma5PB9h+ItyD8c08mx
        nAfoh2uDAwk8Uk6TR8y9olawqiR9SrwDiTytDJLP+JmvVsjVqpRjku7QXt0RraR3oFk8o5wp
        37RTilUI+1WJ0kFJOizp/n8pPiAkFcXkfdlYGLjUUOsxlI9gxO/3bY5P61/FKMNcm7b7eEUn
        rzFef+qwzx0P3l28y9Rav0BYcyO1uH1N8LPA5nVFkc1CaNKcaHPfh9hL1SvkIebZ3p5FvsWn
        DiyeotMeiJuatSN5KEa2Z7bx/rg3w7P+UUHjlu7bJ5as/rr13fdQIuW+UTL6ONWyUFqnV/0F
        DodnXDQDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index a0307b516b09..ff349e609da7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
@@ -303,6 +304,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
+	sdt_might_sleep_start(NULL);						\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
@@ -318,6 +320,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 		cmd;								\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
+	sdt_might_sleep_end();							\
 __out:	__ret;									\
 })
 
-- 
2.17.1

