Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8054F745945
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGCJui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGCJt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:57 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2943DD;
        Mon,  3 Jul 2023 02:49:53 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-3b-64a299b4365d
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
Subject: [PATCH v10 rebased on v6.4 22/25] dept: Apply timeout consideration to dma fence wait
Date:   Mon,  3 Jul 2023 18:47:49 +0900
Message-Id: <20230703094752.79269-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SbUxTZxiGfd9zzntOCzVnlbij/tA0Mzo/8GOgT5xxJvvhq5lGs+mykaiN
        PZNqqaYoirgMpSqCBZFAAesGZZQGEPWAEac1DCdfRulGw6pDNvBjEIsoUmIFphQz/zy5ct+5
        r1+PwGivcdMFo3mfbDHrTTqiZtX9kSULawudhsVNb2Ih59RiCA6ls+C4UEXAW12JoKr2CIa+
        W2vgz+EAgpE7bQzY87wISrofMFDb2IXA4z5KoP3RZPAFBwi05GUSSCu9QOD3p6MYOvPPYKhU
        1sPt004M9aF/WbD3EThrT8PjpxdDyFXBgyt1NvS4i3gY7V4CLV0dHHjuz4fCHzsJXPe0sNBY
        14Oh/RcHga6qNxzcbmxmwZtj4+D8MyeBp8MuBlzBAR7+qC/GcNE6Ljr+8j8Ommz1GI7/fAmD
        7941BDfS/8GgVHUQuBkMYKhR8hh4XX4LQU9WPw/HToV4OHskC0HmsXwW2saaOLB2xsLIKwdZ
        vYLeDAww1FpzgHqGi1na6pTo1aIHPLXeuM/TYmU/rXHPo6XX+zAtGQxyVKk4SagyeIanGf0+
        TJ/dvcvT5oIRlj7y2fHGGd+qVxpkkzFJtixatV0dP+j9De1tFw76R3rZVFTJZyCVIIkx0glv
        1nu2/d2Gw0zEOZLfH2LCHCXOkmpsT7gMpBYY8USE5H5+h4SLKeJWyfO4dWLAirOlsivVEwON
        uEzKz84l76QzpcqL9RO5ajx//CoLhVkrxkqdhV0kLJXEXJV05fIQfjeYJv3q9rOnkaYYTapA
        WqM5KUFvNMVExyebjQejd+xJUND4S7m+H42rQ4PeLxuQKCBdpMafUmLQcvqkxOSEBiQJjC5K
        k9b9k0GrMeiTD8mWPdss+01yYgOaIbC6DzVLhw8YtOJO/T55tyzvlS3/t1hQTU9Fjo8DZVEJ
        YvYL7YKIT23KR9khK6xasaw1d/65sWmbA5qCLzzfbF5XMeoq2/QXcpz7Sh2y52zL5CI9RamF
        zT/M7f1EVT6Hy384K8K5PFqOCq6dKsREm00dH/iU18+/i/vs8+qkr3eLxrFdMw8zJ9PWHX4J
        NCV9aO2Lpqkb7sVtqUtR69jEeP2SeYwlUf8WgJPvAE4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTdxzF/f3uvb97qVbvOpLdoAbThCyiU0nG8k18zMyoPxV1/5n4Go29
        G42lYItV3FxQqgIK8gggUrZStRLoRFuysc2yhpcUQ0FpsCPIgPgiIihaYgc+AOM/J5+ck3P+
        OgKjquCiBJ0hTTYaNHo1UbCKHaszv6grs2tX/R5aBAXnVkHoVRYL1longa5rNQicdScwDLds
        hnsTIwgmOzoZKC3uQlA5eJ+ButZ+BJ6qkwS6H8yHQGiMgK/4LIHMS7UE7jydwtBXUoihxrUd
        bufbMXjDj1koHSZQXpqJp+UJhrCjmgdHRgwMVV3kYWowDnz9PRw0Vfg48PQug7Jf+gjc9PhY
        aK0fwtD9l5VAv/MdB7db21joKsjl4LdRO4GnEw4GHKExHu56bRiuW6bXTr98y8GtXC+G05dv
        YAj8+zeChqwBDC5nD4Gm0AgGt6uYgf+vtiAYynvGw6lzYR7KT+QhOHuqhIXON7c4sPTFw+Rr
        K1m/mjaNjDHU4j5CPRM2lrbbJfrnxfs8tTT08tTmOkzdVbH00s1hTCvHQxx1VWcT6hov5GnO
        swCmo34/T9suTLL0QaAUf7tot2KNVtbrzLJx5bpERdJ4VzNK7RaOBiefsBmohs9BEYIkfinl
        /teJZ5iIn0vBYJiZ4UhxieTOfcTlIIXAiGfmSlXPO8hM8Km4X/I8bJ8tsGKMdOWPa7MFpfiV
        VHK+iHwYjZZqrntn/Yhp/+HrPDTDKjFe6ivrJ/lIYUNzqlGkzmBO1uj08StMB5PSDbqjKw6k
        JLvQ9Gkcx6cK6tGr7s2NSBSQep4y+GOlVsVpzKb05EYkCYw6Upk5+KtWpdRq0o/JxpTvjIf1
        sqkRLRRY9WfKrbvkRJX4gyZNPijLqbLxY4qFiKgMZE00Lx0oth/CC2M2tHib1i2OXmBLCAcM
        Zqd+SnzHD9Q2b/vHr3dvuZfzUwubEJ26MexYVpTv3x/8ein9hrjbbmQlxG7qjfP/3MxbGnlt
        4MXK55e3+BqWPz6e31N4Nduasq/ekbR9bP6e9dnBI8G7FWnS2k8Gdrfv7RjdWW7/XlukZk1J
        mrhYxmjSvAe7+XJlMAMAAA==
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
consideration to dma fence wait.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index ad2d7a94c868..ab10b228a147 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -783,7 +783,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -887,7 +887,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
-	sdt_might_sleep_start(NULL);
+	sdt_might_sleep_start_timeout(NULL, timeout);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
-- 
2.17.1

