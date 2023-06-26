Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852E73DFC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjFZMs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjFZMsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:48:12 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDEE2974;
        Mon, 26 Jun 2023 05:47:11 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-46-64997d6c0259
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
Subject: [PATCH v10 11/25] dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
Date:   Mon, 26 Jun 2023 20:56:46 +0900
Message-Id: <20230626115700.13873-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe8/lPWfLxWGVni5UTLppF7vyQBEJQYcoKPrShS7LnXQ0NbY0
        DQIzFZspaulMLXTWWjq1tm6ms6VmLrtomq2YVlKZphnWLHNdptSXhx/PH37/58PDknIHPZ1V
        Rx0RtVFKjQJLKemAX/FizfFzqpB7r4Mg63QIeL6lUlBYacHQUlGGwHL9BAG99zfCi+F+BKOP
        n5JgyGlBUPy2k4TrjV0I7OZEDG3vJkG7ZxCDMycNw8mSSgytn7wEuHOzCSizboHmTCMBjpEe
        Cgy9GAoMJwnf+EjAiKmUAVPCXOg25zPgfbsMnF0dNNhfBcO5C24MNXYnBY23uwlou1OIocvy
        h4bmxiYKWrLSaSj/bMTwadhEgskzyMAzRxEBV5N8oj6vnYCUr79peJDu8NHFawS0v6xGUJv6
        hgCrpQNDvaefAJs1h4Sfl+8j6M4YYCD59AgDBScyEKQl51Lw9NcDGpLcq2D0RyFev0ao7x8k
        hSTbUcE+XEQJD428UJXfyQhJta8YocgaI9jMQUJJTS8hFA95aMFaegoL1qFsRtAPtBOCu6MG
        C5+fPGGEprxRauvMXdK1KlGjjhW1S9ftl0b0dGbRh11s3K+GKiYBubAeSVieW8k/SmxF/znV
        +50aY8zN512uEXKMp3BzeFv6B1qPpCzJlUzke5oamLFgMreHr7yiH2eKm8snNzvHWcat5o13
        Pv4rmM2XXXWMiyS+ffUj43iZnFvFJ7rr8JiU585I+G77jX9XTOPvmV1UJpIVoQmlSK6Oio1U
        qjUrl0TER6njloRFR1qR769Mx727b6Ohlu11iGORwk8WMitPJaeVsbr4yDrEs6Riisz/h0El
        l6mU8cdEbfQ+bYxG1NWhGSylCJAtHz6qknPhyiPiIVE8LGr/pwQrmZ6AdHnmRcpbGefPZz7r
        6aMapm4Osyx4Y62tXHjXsKLVHnpgQc2FXmOAIo4J3kZXW9b9vNXXlbJjw9J50YsC1wRWxBxs
        a/U/kx/CpFVtpct3DN0IPbS9c2P4gbCbjP/OL9c2FUvF35HTnr8Ptu19Qbv0KWf9NI+d+kQ2
        wF+Se+mu3HilQEHpIpTLgkitTvkXnAPZ7FMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xTZxgHcN9zec+hrnrWke2EXVhqjAYzwETI4yXG7AuvS6bOxBhNjNT1
        ZHS0xbTKwISEq2IRQ02giqhYtCAg6AEdINWuCFIugkBY5woZzIAoQkSLsNZthWxfnvzy/yf/
        Tw9Pq+xsBK8zHpNMRo1ejRWMYtfWnK/0GRe0sYNXVGA9Ewv+t/kMlNXXYuivq0FQ25hFwVR7
        Avw6P40g0NtHg624H8HVsREaGjtGETirsjEMPlsFQ/5ZDJ7iAgw5FfUYnrwMUuArOUdBjfwt
        dBfZKXAtTjJgm8Jw0ZZDhc5zChYd1Rw4MtfCeFUpB8GxjeAZHWah7ZKHBefTDXDhsg9Dq9PD
        QEfTOAWDLWUYRmv/YaG7o5OBfmshCzdn7BhezjtocPhnORhwlVNwKze09iLopODkm79ZeFTo
        CunabQqGfruH4H7+HxTItcMY2vzTFDTIxTT8VdmOYPzsKw7yzixycDHrLIKCvBIG+t4/YiHX
        FweBhTK8Yxtpm56lSW7DT8Q5X86QLrtImktHOJJ7/ylHyuXjpKEqilS0TlHk6pyfJXL1aUzk
        uXMcsbwaoohvuBWTmcePOdJ5PsDs+fygYptW0utSJVPM9kRF0uSIlT3q5dPeP2zmMpEXW1AY
        LwqbxPzgO2bJWFgner2L9JLDhS/FhsIJ1oIUPC1UrBQnOx9yS8VHwiGx/oZl2YywVszr9ixb
        KcSL9pbn/41GijW3XMtDYaH8Xo8dLVklxInZPjcuQopytKIaheuMqQaNTh8XbU5OSjfq0qK/
        TzHIKPQ5joygtQm9HUxwI4FH6g+UsV+c16pYTao53eBGIk+rw5UfL9i0KqVWk35CMqUcNh3X
        S2Y3+pRn1J8ov9kvJaqEHzTHpGRJOiqZ/m8pPiwiE/XM75tuLFq1vs6Pd6RSlbbfY2ylWQsT
        2UcyNu/65cfdpxKVvRUl7jXXd98pkD67PvDz3b58Q6Njiz++7nS7Y84m93KGPbLl9YoT3z1o
        ef0s1pLgdbYUr1udXOmaiWgKSAOBy0aSHp389UTX8IHSMWb/TpV2deSf+xaMHTutH97dG6lm
        zEmajVG0yaz5F7H2sVY1AwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by hashed-waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..fe89282c3e96 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -6,6 +6,7 @@
  * Linux wait-bit related types and methods:
  */
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 
 struct wait_bit_key {
 	void			*flags;
@@ -246,6 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
+	sdt_might_sleep_start(NULL);					\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
@@ -263,6 +265,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 		cmd;							\
 	}								\
 	finish_wait(__wq_head, &__wbq_entry.wq_entry);			\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1

