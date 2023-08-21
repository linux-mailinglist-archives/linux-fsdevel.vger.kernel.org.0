Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1C782299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjHUEMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjHUEMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:12:33 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55135CA;
        Sun, 20 Aug 2023 21:12:03 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-5b-64e2ded78431
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
Subject: [RESEND PATCH v10 23/25] dept: Record the latest one out of consecutive waits of the same class
Date:   Mon, 21 Aug 2023 12:46:35 +0900
Message-Id: <20230821034637.34630-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTWRSG3fvsc2mx5qRD4lGMaBOjkYwK8bJi1Phg4vGuOIlRH7ShZ4aO
        BU0rWDRGkAKKYNSkFBW1gFMbKIIHH+TWdGoA6wWqNIgEiVSjEkEEbRHBC6C+rHxZ/8qX9fBz
        lLqWnsnpkw9LxmStQcMoibJ/asmfT7uDuiUVF6PhfN4SCH06RaCo0sWA/2Y5AtftDAy9jevh
        abgPweijVgpsVj+C4p7nFNxu6kbQ4DzJQNuraRAIDTDgs55hILO0koHH78YwdBVcwFAub4EH
        50oweEbeELD1MnDZlonHx1sMI44yFhzp8yDovMTCWE8s+LrbaWjojIGLV7sYqG/wEWi6E8TQ
        VlvEQLfrOw0Pmu4R8J/Pp6HifQkD78IOChyhARaeeOwYqizjouyP32hozvdgyL5+C0PgWR0C
        96kXGGRXOwN3Q30YqmUrBV9uNCIInu1nIStvhIXLGWcRnMkqIND6tZkGS9cyGP1cxKxdKd7t
        G6BES/URsSFsJ+L9EkGsufScFS3uTla0yylitXOhWFrfi8XioRAtymWnGVEeusCKuf0BLL5v
        aWHFe4WjRHwVsOHtUXuUq3SSQZ8qGRev2a9MfF1USB8ajjDnP3aTdNSmyEUKTuCXCo1lb/Fv
        zrl+n5pghp8vdHSMTHIkP0eozn9N5yIlR/E5EYLzwyNmIviDTxRO51nRBBN+nhAs+ExyEcep
        +OVCRenin85oobzKM+lRjK/lutrJczW/TBjseUkmnAKfoxDkwapfT8wQ/nd2kHNIZUdTypBa
        n5yapNUbli5KTEvWmxclHEyS0XijHMfH9t5BQ/6dXsRzSDNVtX9WUKemtammtCQvEjhKE6mK
        Gu7RqVU6bdpRyXhwnzHFIJm8KIojmumquPARnZr/R3tYOiBJhyTj7xRzipnpaPNqc8KVv0wR
        VuuqeMfxaSR2xbOxuf/Fk0Kye85y5ZZQzcP44roD63JSYrb60C5DXDjS6dq2YLBzdYuCyeq7
        Zv+Y4f43kBlodW9vNnzx+L6fmDU7wW8H+db60JNNsOfTy41h2zFLV7/Z6fXvqNnw90ZznOph
        b71nb3THsLE926shpkRt7ELKaNL+AG/veZdNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5+7q8VhGR1MsBYSqF2EVi9YEX3IU9EFMgyjcrRjjnTGlqZF
        YLk0zUVKauWqeWGZ07QtyLxhipdp3trQMpWclYmaZW611EqNvrz8eJ6H36eXwSV60otRqs4L
        apU8SkqJCNHBoKQNvYMOxWaTnoaM9M3gnL5OgL6shIKuJyYEJc+uYDDaGAy9rnEEM+2dOORk
        dSHIGxrA4VnTIIKaoqsU2D4sB7tzkgJr1g0KkgrKKOgem8WgPzsTA5P5ALTdysegzj1CQM4o
        Bbk5Sdj8+YyB21hMgzHRFxxF92iYHQoE62APCQ33rSTU9PnD3Qf9FFTXWAloqnBgYKvUUzBY
        8oeEtqYWAroydCSUfsmnYMxlxMHonKThdZ0Bg3LtvC35+28SmnV1GCQXPsXA/rYKQe319xiY
        S3ooaHCOY2AxZ+Hw61EjAsfNCRqupbtpyL1yE8GNa9kEdM41k6Dtl8HMTz21K4hvGJ/Eea3l
        Al/jMhB8az7Hv7g3QPPa2j6aN5hjeUuRH19QPYrxeVNOkjcXp1K8eSqT5tMm7Bj/paOD5lvu
        zBD8B3sOdtg7TLRdIUQp4wT1pp3hoshP+jvkuR9L43XdtUQisnmkIQ+GY7dwKYWt+AJT7Hru
        zRv3InuyaziL7hOZhkQMzqYs5Yq+tlMLxQo2kktNz0ILTLC+nCP7J5GGGEbMbuVKCzb9c/pw
        pvK6RY/HfGyuqlycS1gZ921omLiFRAa0pBh5KlVx0XJllGyj5mxkgkoZv/F0TLQZzf+M8fJs
        RgWatgXXI5ZB0mXicG+HQkLK4zQJ0fWIY3Cpp3j1jyGFRKyQJ1wU1DGn1LFRgqYerWYI6Srx
        vlAhXMKekZ8XzgrCOUH9v8UYD69ERBypro1Y2dDh23rQuUob9vaRe1KWvWxHsc/tgKCqE9Ou
        d9u9XnV1RFhOPpSlhATUV4zu37UvMXMtld6413DGVukX3+nfclxZ3n5Ml/lUmWyd89k/dbz0
        6Lbgj4/3huwsG5sLs1xac1o1HPFyZCYld/dESOrlUPu6Q6zLew89sq35uUlKaCLlgX64WiP/
        C5lDZM0vAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

