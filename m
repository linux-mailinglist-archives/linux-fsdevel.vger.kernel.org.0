Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4132073DEF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFZMXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjFZMWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:22:47 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76612D79;
        Mon, 26 Jun 2023 05:21:06 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-17-64997d6e5ce2
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
Subject: [PATCH v10 23/25] dept: Record the latest one out of consecutive waits of the same class
Date:   Mon, 26 Jun 2023 20:56:58 +0900
Message-Id: <20230626115700.13873-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe8/lPWfLyWHdThcqBhEVlXZ9oIj8EL0QURBR2Ie22kFXOmuW
        aRRYWth0lpJOTcpLLfGSNosuOllWpmWlqdNiWdnFtKlhznRbly3py8OP//95fp8enlbWsbN4
        nf6IZNBrolRYzsgHggqX6k/makOqXDMgIy0E3CMpDORXlmNouVGGoPzWKQr6Hm+GzlEXAu/z
        lzSYs1oQFH54S8Othm4EtpLTGNo+BUO7ewhDU1YqhqTiSgyt33wUOLMzKSizboVnF4oosI/3
        MmDuw3DJnET5x1cKxi2lHFgSF0BPSR4Hvg+h0NTtYMH2ZgnkXnZiqLU1MdBwt4eCtvv5GLrL
        /7DwrKGRgZYMEwsVg0UYvo1aaLC4hzh4ZS+goCrZL+r32Sg4++M3C09Mdj9dvUlB++saBHUp
        7ymwljswPHS7KKi2ZtHguf4YQU/6AAdn0sY5uHQqHUHqmWwGXv56wkKyczV4x/LxxnXkoWuI
        JsnVx4httIAhT4tEci/vLUeS695wpMB6lFSXLCbFtX0UKRx2s8Raeg4T63AmR4wD7RRxOmox
        GXzxgiONOV5m+5xw+XqtFKWLkwzLN6jlkV/yc9hDPyfHm1rrmETUJjMiGS8Kq8TmwXH6P/d6
        jFSAsbBQ7OqayKcK88Vq0xfWiOQ8LRRPFnsbH3FGxPNTBI14cSgmsMMIC8SqYgcKxAphjeis
        CJtQzhPLquz/NDJ/XNNchAKsFFaLp531OKAUhfMyMd3rwBMHM8UHJV3MBaQoQJNKkVKnj4vW
        6KJWLYtM0Ovil+2PibYi/1dZTvr23EXDLTvqkcAjVZAiZG6OVslq4mITouuRyNOqqYrpY2at
        UqHVJByXDDF7DUejpNh6NJtnVDMUK0aPaZVChOaIdFCSDkmG/y3Fy2YlomzX2QM3TT2DuWE7
        44PUFWrSPJKaZ+u4Funpx9uEK+yruR519sd3WYsM8ginYnro7UfhvzqD1dNOrG0Ne5pkT9Fu
        Eb1tEbYtuZ8SP4/4jP0Rh+/omzM6Qu2792V2fv3+08xNkdUsCQr2/AhbE20gK3d1D8+pZDLe
        d5zblBZ/cOuYiomN1IQupg2xmr8IlczpUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/xzsuv53GD0NunlaT2mSf0TxtrR8bM3+wmdHN/dSpK+4S
        ebxU1HEp06NwXZx0IZc/UNdy0YNIdEvshJhEOouLHsQd8897r70/n73+erOE3ERNY9XxiaI2
        XhmnoKWkdP2y1IWaw4WqkMevl0HOqRDwfM8gofhGBQ1t160IKm6lYOh9EAnPB/sQjDx+QkB+
        bhuCkrevCLjV0IXAXnaMhvb3fuD0uGlozj1JQ2rpDRqefh7F4Mo7g8FqWwct2WYMdUM9JOT3
        0nAuPxV74yOGIUs5Axb9XOguK2Jg9G0oNHd1UFB/vpkC+8sgKLzgoqHG3kxCw+1uDO13i2no
        qvhNQUtDEwltOUYKrvWbafg8aCHA4nEz8KzOhKEyzWv7NGrHcPzbGAWNxjovXbqJwfmiGkFt
        xhsMtooOGuo9fRiqbLkEDF95gKA76wsD6aeGGDiXkoXgZHoeCU9+NVKQ5gqDkZ/F9Mpwob7P
        TQhpVfsE+6CJFB6aeeFO0StGSKt9yQgm216hqixQKK3pxULJgIcSbOWZtGAbOMMIhi9OLLg6
        amihv7WVEZoKRsgNM7ZIw1VinDpJ1C5aHiWN+VBcQO3+MX6/8WktqUftEgOSsDy3mO8ZNmAf
        09x8vrNziPCxPxfAVxk/UAYkZQmudDzf03SfMSCWncQp+bPuBN8Pyc3lK0s7kK+WcUt417VV
        /5SzeGtl3V+NxFtXPzIjH8u5MP6Yy0FnI6kJjStH/ur4JI1SHRcWrIuNSY5X7w/ekaCxIe9u
        LIdHc26j7+2RDsSxSDFBFjKzQCWnlEm6ZI0D8Syh8JdN/pmvkstUyuQDojZhu3ZvnKhzoOks
        qZgiW7tZjJJz0cpEMVYUd4va/1fMSqbpUezl00GujfMCLm1fmtsTYNfPOc7fjFrgrJfUpLQE
        XwkcHjP5rdjkMK+bmKhfvbMxepdk/td3+MhU/fCqkg3ZR4x7Ln4svKoJjzm0JvFgbeTsQEV/
        Z9bR68Gh807cu+O6GzGhwW1C2yLSX2/J3GolWvdt6l5kUY85Dffzipb/sE40TJmqIHUxytBA
        QqtT/gH3/dofMwMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current code records all the waits for later use to track relation
between waits and events in each context. However, since the same class
is handled the same way, it'd be okay to record only one on behalf of
the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one at
least when the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 52537c099b68..cdfda4acff58 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1522,9 +1522,28 @@ static inline struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static inline struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1

