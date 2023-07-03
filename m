Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88943745920
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGCJuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGCJt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:58 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B26E58;
        Mon,  3 Jul 2023 02:49:55 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-4b-64a299b4b568
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
Subject: [PATCH v10 rebased on v6.4 23/25] dept: Record the latest one out of consecutive waits of the same class
Date:   Mon,  3 Jul 2023 18:47:50 +0900
Message-Id: <20230703094752.79269-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxTH+d3H77aVLjeVZFc0sjQxJm46WdCc4EJAk3ElWXwsMb6SebVX
        aFaqK4KgWcKjMnkqbFBQslEwtaNFasEMUUhFBZEoVSoi1k4IyLC8RFul4CbF+M/JJ+d8z+ev
        r4RUXKPDJWrtMVGnFTRKLKNkE6HGtU2VNar1vf9sgpLC9eB7c5qCqgYrBuclCwJrUxYBY7fj
        4bF/HMHcvR4SDGVOBMbBZyQ0dXgQtJqzMfQOfwYu3xSGrrICDDm1DRgeeOcJcJeXEmCxfw/d
        Z2sIcMyOUmAYw3DekEMsjH8JmDXVMWDKXAVD5nMMzA9GQpenj4bWgS+h8g83huutXRR0NA8R
        0NtShcFj/Z+G7o47FDhLimion6zB4PWbSDD5phh46KgmwKZfEOW+/o+GziIHAbkXLhPgenIN
        Qdvp5wTYrX0YbvrGCWi0l5EQuHgbwVDxBAOnCmcZOJ9VjKDgVDkFPe87adC7N8DcuyocG83f
        HJ8ieX3jcb7VX03xd2s4/uq5Zwyvbxtg+Gp7Kt9oXsPXXh8jeOOMj+btdXmYt8+UMnz+hIvg
        J+/fZ/g7FXMUP+wyENuX75V9qxI16jRR93XMAVnSi6oK+ujbJelFD9qoTNQrzUdSCcdGcS3N
        ncwnHv7rbxxkzK7m+vtnySCHsV9wjUUv6Hwkk5Dsr0s48/S9xdBS9mfueXeACjLFruLyvOUo
        yHJ2I9fS4aA/SiM4i82xKJIu7EfeFS9mFOwGzl3pwUEpx56RcvorbvLjwzLuhrmfOovk1Sik
        DinU2rRkQa2JWpeUoVWnrzt0JNmOFipl+mV+XzOacf7QjlgJUobK+08aVQpaSEvJSG5HnIRU
        hslzBv9UKeQqIeOEqDvyoy5VI6a0o+USSvm5/Bv/cZWCTRSOiT+J4lFR9+lKSKThmWhj9IrI
        0fhpzAYeekfEkaSelY67jnDNeOyeuLDVoY+uNkTsCFg216f/VuD86jubt/biU2tYoWDofto5
        2XPrcJ8rM+DZlphtPzgadTBRKD3kt+2Pdp0pjvl995udV2Qxr6Jstw7U+xJePuZeJRjjjXup
        2JFL87lx2q2H91t27QvdEqKkUpKEyDWkLkX4AG/pntpOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiG977nnPe0dV2OlcwTNJnpJBjmVJLVPAnGEBP1zYxsIVGT/cHG
        noxOQGkVZcQIa0UFS8CFTyuDoh1CBW2JHyCkKREthA8tcQyPBEhlNCBszqJ8KALL/jy5ct93
        rl+PgtFc5SIVxrQTkilNn6IlKlaVEGf5uqncYdh2x7cRii5tg/CbCyzYG10E+hrqEbiacjCE
        Hu6FP2YmEcx39zJQWtyHoHrkBQNNHUMIWmt/IRAIfgb94WkC/uJ8ApaaRgJPJhYwyCWXMdS7
        90NXoQODd/YvFkpDBK6UWvDSGccw66zjwZkdBaO1FTwsjMSCf+gZB+1X/Ry0Dn4F5ZUygQet
        fhY67o1iCDTbCQy5Fjno6njMQl+RjYObUw4CEzNOBpzhaR6eeqsw3LIu2XL//cDBI5sXQ+61
        2xj6/2xB0HZhGIPb9YxAe3gSg8ddzMDc7w8RjBa84uHcpVkeruQUIMg/V8JC7/tHHFhlHcy/
        s5P4ONo+Oc1Qq+cUbZ2pYmmnQ6T3K17w1No2yNMq90nqqY2hNQ9CmFa/DnPUXXeRUPfryzzN
        e9WP6VRPD08fl82zNNhfir9f/4Nqh0FKMWZIpq07D6uSx+xl3PG3q07bnrSx2SigzENKhSh8
        IwZv3CXLTIRocWBgllnmCGGD6LGNcXlIpWCE86vE2r+7V0ZrhHRxuGuOXWZWiBIvTpSgZVYL
        28XmDi/3n/QLsf6Wd0WkXMpfvitY2WgEnSiXD5FCpKpCn9ShCGNaRqremKLbYj6anJlmPL3l
        yLFUN1p6GueZhaJ76E1grw8JCqT9VD2QVW3QcPoMc2aqD4kKRhuhtoz8ZtCoDfrMnyXTsSTT
        yRTJ7EPrFKx2rfrbQ9JhjfCj/oR0VJKOS6b/W6xQRmYj+55Nm6NaxtWxNQk5eHW3vDMrWohE
        Olf8KYdvPmYx8Z/hRtvLs8rvps6SXxsS5c0Lu1s6Nx0IBUP7749VymavRkfXr/kp3vJ53K6K
        wYaQ5+5iel5qcKThy2ZlTmFFtMzJuc+vJ+VHdM7J7Nr39aJ/pld/MC4wtU/qDbt9k1Yta07W
        x8YwJrP+I9840PEwAwAA
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

