Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9867782281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjHUELJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjHUELI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:11:08 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC383F2;
        Sun, 20 Aug 2023 21:10:31 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-0b-64e2ded6ddcf
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
Subject: [RESEND PATCH v10 18/25] dept: Apply timeout consideration to wait_for_completion()/complete()
Date:   Mon, 21 Aug 2023 12:46:30 +0900
Message-Id: <20230821034637.34630-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG/f/PdavJYQUdMygGERRphuVbRERRHYqgG9EN2mgnHXlr3jKI
        nGkXy7BwrUzMS8ylM/VMuplhipqaaSlLTVeuqKypZW21tMxZfXn58Tzv+/B8eFlCWU3NZnXR
        8aI+WhOpouWkfGh6wWK7w6ld8r0f4OL5JeD+doaE3HIrDR23ShFYqwwYBhs2wguPC8FYWzsB
        JmMHgoKBfgKqGh0IaiypNHS+9Ycu9wgNzcZzNJwsKqfh2adxDH2XL2EolbZAa1YhhlrvexJM
        gzRcM53Ek+MDBq+5hAFzynxwWnIYGB8IgWaHnYKa3kVwNa+Phgc1zSQ03nVi6LyfS4PDOkFB
        a+NjEjouZlJQNlxIwyePmQCze4SB57X5GCrSJoNOff1NQVNmLYZTNyoxdPVUI3h45jUGyWqn
        od7twmCTjAT8LG5A4LwwxED6eS8D1wwXEJxLv0xC+68mCtL6lsHYj1x6zUqh3jVCCGm2JKHG
        k08KLYW8cC+nnxHSHvYyQr6UINgsC4WiB4NYKBh1U4JUcpYWpNFLjJAx1IWF4adPGeHxlTFS
        eNtlwlsD98pXacVIXaKoD16tlkfkTJiY2Dz50R5DJU5Br9kMJGN5LpT3VlUw//lXVgvpY5pb
        wHd3ewkfz+Tm8bbMd1QGkrMEd3oab/ncRvuMGVw4b390G/mY5Obz49XFUwcKbjl/57oB/w2d
        y5dW1E7pskldqr4/ta/klvFfBt6QvlCeOy3jpZsj/1oE8I8s3WQWUuQjvxKk1EUnRml0kaFB
        EcnRuqNBB2OiJDT5Uubj4/vuotGOHXWIY5FqukI9x6lVUprEuOSoOsSzhGqmIvD7gFap0GqS
        j4n6mAP6hEgxrg4FsqRqlmKpJ0mr5MI18eJhUYwV9f9dzMpmp6B1sa+aDwwyxz/uD16750SZ
        qSFqUy+3jm58og6o96S6epMVTUZ39s7Y8O22ednyeLM9IqBNPdwuX7t6g7S51fX5yHqZrGW3
        7YfR47fd0xMa3JMUlq3aaHQUxRR9sbwsK967ybnfmtgZts0gO7TCL33Cb1dqeqvaX/ns47R3
        UkjlDhUZF6EJWUjo4zR/AP+kE2lOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x47j12nzG4bdZsiQh/h4mIdhfccyNptms/rN/dTpit0p
        YrZOF4laoY5UerCTKz1cTenBUquUpaiFpLljaF3loYt0Hirzz3uvvd+f9/uvD0+pMpjZvDb8
        hKwPl3RqVkEr9myMWdbV69D49KTNh+TLPuAajqMhvaiAhfbCfAQFZUYMfQ1+8GLEiWCstY0C
        c0o7gmz7GwrKGnsR1OSdY6Hj/XTodA2x0JxyiYWY3CIWnvW7MfSkXsGQb/OHJ0k5GGpHP9Jg
        7mPhpjkGj8snDKMWKweW6IXgyEvjwG1fCc29XQzUZzQzUNO9FG5k9rBQXdNMQ2OFA0NHZToL
        vQV/GHjS+JiG9uQEBu4N5rDQP2KhwOIa4uB5bRaGYtP42vlvvxloSqjFcP52CYbOV1UIHsa9
        xWAr6GKh3uXEUGpLoeDnnQYEjsQBDmIvj3Jw05iI4FJsKg1tv5oYMPX4wtiPdHbrRlLvHKKI
        qfQkqRnJoklLjkgepL3hiOlhN0eybBGkNM+b5Fb3YZL91cUQm/UiS2xfr3AkfqATk8GnTzny
        +PoYTd53mvHeuQcVmzSyThsp61dsDlKEpP0xc8czFadeGUtwNHrLxyMPXhTWiL+SWugJZoVF
        4suXo9QEewkLxNKED0w8UvCUcGGqmPe5lZ0IZgrBYtej+2iCaWGh6K66M1lQCmvF8ltG/G90
        vphfXDvpe4z7tqrKyXuV4Ct+sb+jk5AiC02xIi9teGSYpNX5LjeEhkSFa08tP3wszIbGn8Zy
        1p1cgYY7/OqQwCP1NGXQXIdGxUiRhqiwOiTylNpLOee7XaNSaqSo07L+WKA+Qicb6tAcnlbP
        Uu46IAephGDphBwqy8dl/f8U8x6zo1FA+QZti49Tf3/3mWzn/rvvGvwPHV0tltNF9hkRq+Rl
        O7ZsS+pLVS2OXesZZ52nWfLjav+RQv/W4nXOwpP1YK1srF6nGfgQKu1Uia71t7sjJF3F4A1P
        Y3cT7At+vbXttbhrWGUKWBLo57U9LlHLkGtfLBbnquSMwqFt7pCGfRdy1bQhRFrpTekN0l+b
        Zs2cMAMAAA==
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

