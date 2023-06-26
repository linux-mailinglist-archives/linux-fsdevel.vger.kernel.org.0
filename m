Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74373DECC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjFZMTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFZMT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:19:28 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 05:19:04 PDT
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EFDA10E7;
        Mon, 26 Jun 2023 05:19:03 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c0-64997d6d15c4
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
Subject: [PATCH v10 18/25] dept: Apply timeout consideration to wait_for_completion()/complete()
Date:   Mon, 26 Jun 2023 20:56:53 +0900
Message-Id: <20230626115700.13873-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfc/lPYfObieVyREXN5vhdSo4MM/ispgYt/fDlriYaKLxcmKP
        0nDRFUFZRsKlGLkp4KBaCNaiXUNRtBi8QAmCchkC3SQIpFQgOscEqsxWGFVsWfzy5Jfn/3v+
        nx6eVjWy4bw28ZisS5Ti1VjBKCYWmtclpJ3XRHqMX0BRfiR4X51ioLymGoPzqg1B9Y0MCsbu
        fwePfOMIZrt6aDCUOBFcHBmi4UarG4HDmonh4ZMPodfrwdBRkochq7IGwx/P/RS4SospsNl/
        gM5CMwVNM88YMIxhKDNkUYHxNwUzlioOLOkRMGo1cuAfiYIOdx8LjsG1cL7ChaHB0cFA661R
        Ch7eKcfgrp5jobO1nQFnUQELVybNGJ77LDRYvB4O/mwyUXBNHyj6x++g4OS/b1loK2gK0KXr
        FPQO1CNoPDVMgb26D0OLd5yCWnsJDf/9dh/B6OkJDrLzZzgoyziNIC+7lIGeN20s6F0xMDtd
        jrdsJi3jHproa48Th8/EkN/NIrltHOKIvnGQIyZ7Mqm1riGVDWMUuTjlZYm9KgcT+1QxR3In
        eini6mvAZLK7myPt52aZ7Z/sVnytkeO1KbJuwzcHFLHGOQN3tEJxYiDjOpWOhvlcxPOiEC3e
        LE99j5dORueiEB4LK8X+/hk6yKHCZ2JtwV9sLlLwtFD5gfis/R4XDBYJB8TZzOJ5iREixO7C
        DDbISmGTmDeon3dE4VPRdq1p3gkJ7OsfmFGQVUKMmOlqxsFSUSgLESu8c+z/B0vEu9Z+phAp
        TWhBFVJpE1MSJG189PrY1ETtifUHjyTYUeCrLGn+PbfQlHNHMxJ4pF6ojFx2TqNipZSk1IRm
        JPK0OlS5eNqgUSk1UurPsu7Ifl1yvJzUjJbyjDpMudF3XKMSDkvH5DhZPirr3qcUHxKejr6t
        H8ChLa/vhtdVhK2IqiG+J759OdtUxpc9YbZlh3PkQ/eG+zc/Hc1fXvejc+fq/Wd3fiy5pfTY
        OH9XZ2Sypstt6riw5dHejT/V+dqzb5pefP84Yt9Q1lauYHKVdeT2ZF/pR0tilHW/cp7PK88U
        tR3cdWG66JevWhbE0bYv015uuqx+oWaSYqWoNbQuSXoHiDIgplEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG/Z87HTXHivPMOSVdiIKZAyP6bhqjcYn/GHVbNDHqB2nsiW0o
        oK1yMRIp1IIgCCS1CEhoMZVAvXBAA0IJF7m6IQ7SKbYMiVFRhAiU2cGmhWRf3vzyPL88n16O
        VNjoVZw2/oyoj1fplIyMkh3YlvFdXOo1dWSfZTkUXI4E30wWBaV3nAz0365G4KwzEjDWsQf+
        nB1HMPf7YxKsln4EthdeEuo6hxG4KtMZGHi5FAZ9kwz0WHIYyKi4w8CTd/MEeK4WElAt7YdH
        +XYCWvyvKbCOMVBizSAC5w0BfkcVC460MBitLGZh/kUU9Ay7aWi/3kODa2gDXCvzMNDk6qGg
        s36UgIEHpQwMOz/R8Kizm4L+glwabk3YGXg36yDB4Ztk4Y+WcgLumgJrb+ddBJin/6OhK7cl
        QDdqCBh81oigOWuEAMnpZqDdN05ArWQh4Z+bHQhG896zcPGyn4USYx6CnItXKXj8bxcNJk80
        zH0sZXZux+3jkyQ21SZh12w5hXvtAm4o9rLY1DzE4nLpLK6tjMAVTWMEtk35aCxVXWKwNFXI
        4uz3gwT2uJsYPNHXx+Luojnql2+OyrarRZ02UdR/vyNGpin+ZGVPlcmSnxlriDQ0wmUjjhP4
        zcIN8+ZsFMQx/Drh6VM/ucAhfKhQm/uKzkYyjuQrvhBedz9kF4rlfIwwl164KFF8mNCXb6QX
        WM5vEXKGTIuOwK8Vqu+2LDpBgbzxNztaYAUfLaR72ph8JCtHS6pQiDY+MU6l1UVvNMRqUuK1
        yRtPJMRJKPA4jtT5gno0M7CnDfEcUgbLI9cUqRW0KtGQEteGBI5Uhsi//GhVK+RqVco5UZ9w
        XH9WJxra0NccpVwp33tYjFHwJ1VnxFhRPCXq/28JLmhVGsrcpM6c/rn1Su/5qRUXomM77itD
        7Q1FM2+wzVSd2Rq8/knWX857JTXmc/UW7/Mfnv+dYDx4b8j9AWmsP62Oqtj6lX/wvGlgYteR
        6R+P6w8Ee3fr9sml8Oa3Zinc/GtJ2OlNddbUpAi3q0vz7e5je3MaXt4MPmE7PbrCvcx7KNRe
        lZWrpAwaVVQEqTeoPgMlG0PBNAMAAA==
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
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 32d535abebf3..15eede01a451 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1c1cd9..261807fa7118 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -100,7 +100,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1

