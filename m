Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701A73DFA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFZMqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjFZMqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:46:08 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C2171700;
        Mon, 26 Jun 2023 05:44:59 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-0f-64997d6bb058
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
Subject: [PATCH v10 08/25] dept: Apply sdt_might_sleep_{start,end}() to PG_{locked,writeback} wait
Date:   Mon, 26 Jun 2023 20:56:43 +0900
Message-Id: <20230626115700.13873-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxSH97733vdeCjU3Bd1VyDBNjBGVocHtJC5mCdHdJTPRbEuMxo/O
        3o1KQW3la9OEj2IUKQqRFpGYUkxFwA+KS0Qp6ZBPGdhJUxlWMpiACEiGFi10aovxn5Mn53d+
        z1+HoxROZgWnSTsm6dJUWiWR0bLpiKr12hMX1AktHZFQUpQAvlenaKi8UU/Adb0OQf2tXAwT
        7d/Ao7kpBAu9Dygwl7kQVA0/oeBWxxACR00egf6nS8DtmyHQXXaGQH71DQJ/TQYweE2lGOrs
        26HnnBWD0z9Og3mCwEVzPg6OZxj8tloWbDmrYKSmgoXA8AboHvIw4BhcCxcueQk0O7pp6Lg9
        gqH/TiWBofp3DPR0dNHgKjEycO2FlcDknI0Cm2+GhYdOC4abhqDoecCB4eTLtwx0Gp1ButyA
        wf33XQQtp/7BYK/3ELjnm8LQaC+jYP5KO4KR4mkWCor8LFzMLUZwpsBEw4P/OxkweDfBwptK
        8vVm8d7UDCUaGjNFx5yFFu9bBbGp4gkrGloGWdFiTxcba+LE6uYJLFbN+hjRXnuaiPbZUlYs
        nHZj0etpJuKLvj5W7CpfoHfE7JZ9pZa0mgxJ9/mWA7LkXtcoORKQZ50/ayI56HF4IQrjBD5R
        mHz5nP3I46NWEmLCrxYGBvxUiKP4lUKjcYwpRDKO4qvDhfGutsVCJP+T8K+rH4WY5lcJvVMl
        OMRyfpMwbypHH6SxQt1N56IojP9CuPundXGvCN7keVtJSCrw5jDBb3hMPhSWC3/UDNDnkNyC
        PqlFCk1aRqpKo02MT85O02TFHzycakfBv7KdCOy5jWZd37cinkPKCHnCZ+VqBaPK0GentiKB
        o5RR8mVvzGqFXK3K/lXSHd6vS9dK+lYUzdHKT+Ub5zLVCv4X1TEpRZKOSLqPKebCVuSgq7An
        NyoyPaat5bXJWPqqrrjzd+HgsDtru2P8Tso+NU76sW+soHvnWcOVpIicmIaKXZk/PHRsfZpY
        tHA/+sDof4fmjSm+8KZYXN0wtia2abDot8i+ywoVtzxRHxe/5OSXlr3uo+1JHm9+j2ddPvk2
        T7s0Ojdm27Ofv6tgOEcbPn5dSeuTVRviKJ1e9R5ycJ/5UwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjH957Le0qxy0lFPTqnS51ZZBFhse6JM8YPZr4xbDFmusuHSbce
        pVIKaRHFRINcRJGqRblaZylLR7jJDiRjozWEm1S51EHASyVSdQhWSdQ2VOqldfHLk1/+/39+
        nx4ZrbSzy2Q6Q5ZoNGj0Kixn5N9+lb827UiVNnG8+kuwlCRC4MUJBqyXGzF4mhsQNLYdo2C6
        dxuMB/0I5geHaago8yCombxLQ1vfBAJXXR6GkQcfwmhgFoO77BSG/NrLGG48DlPgLS+loEH6
        Bq6ftVPQGZpioGIaw4WKfCpyHlEQctRz4MhdDb66ag7Ck0ngnhhjofuimwXX7c+h6jcvBqfL
        zUBfu4+CkX+sGCYa37Bwva+fAY/FzELTUzuGx0EHDY7ALAf/dtooaCmI2GbCLgqOP3/NwlVz
        Z4R+/5OC0VsdCK6cuEeB1DiGoTvgp6BVKqPh5R+9CHynn3BQWBLi4MKx0whOFZYzMPzqKgsF
        XjXMz1nxlk2k2z9Lk4LWg8QVtDHkml0gf1ff5UjBldscsUkHSGtdPKl1TlOk5lmAJVL9SUyk
        Z6UcKX4yShHvmBOTp0NDHOmvnGd2fPyTfJNW1OuyReO6zSny1EHPQ5wZVhw6f6Yc56I7scUo
        Ribw64Wph3YcZcx/Jty8GaKjHMd/IrSa/2OLkVxG87WxwlR/DxctFvK/CPc9IyjKDL9aGPRb
        qCgreLXwsrwS/S9dKTS0dL4TxfAbhI4B+7tcGdnkebvwWSS3oQ/qUZzOkJ2u0enVCaa01ByD
        7lDCrxnpEop8juNI2NKOXoxs60K8DKkWKBJXVGqVrCbblJPehQQZrYpTLJ6r0CoVWk3OYdGY
        scd4QC+autBHMka1RLH9ezFFye/TZIlpopgpGt+3lCxmWS4aSFYHDUf/muxJWOw7Gbtf/vMi
        5L+03rrUuXtjafV3w+Z17r13JGeob3NvyhqDNZ7ZRWe0+7L5zMPNs492fpHfFDTua1k18+kc
        tlUWZZKU2sRdWR2K5EmlPrnwR3fJD2vZ0f1Q8vXMraI9XE2b2Zen3hrbU5Q1d2m5pVSQTP5z
        KsaUqkmKp40mzVu761OUNQMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by PG_{locked,writeback} waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/filemap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..adc49cb59db6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -42,6 +42,7 @@
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
 #include <linux/migrate.h>
+#include <linux/dept_sdt.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1215,6 +1216,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
+static struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
+static struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1226,6 +1230,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	if (bit_nr == PG_locked)
+		sdt_might_sleep_start(&PG_locked_map);
+	else if (bit_nr == PG_writeback)
+		sdt_might_sleep_start(&PG_writeback_map);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1327,6 +1336,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 */
 	finish_wait(q, wait);
 
+	sdt_might_sleep_end();
+
 	if (thrashing) {
 		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
-- 
2.17.1

