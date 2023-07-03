Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B931B74593C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGCJud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjGCJt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:57 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2A2618D;
        Mon,  3 Jul 2023 02:49:53 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-2b-64a299b4f274
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
Subject: [PATCH v10 rebased on v6.4 21/25] dept: Apply timeout consideration to hashed-waitqueue wait
Date:   Mon,  3 Jul 2023 18:47:48 +0900
Message-Id: <20230703094752.79269-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SbWyLaxjH3ffzulp5UhMPEi9N5MQwnHByEcQH4UYkEt+OBE/0OdacbpPO
        ZiOS0WFmq5l0tTdbi55mqzOn25wdNme2dMyMOqsp68q6HSz2IqOjNqMlfLnyy/9/Xb9PF0+p
        rjOzeG3iAVmfKOnUrIJWDEZbl9QUWjXLJlyL4WzOMgi+y6KhpMrBgvvPSgSOmqMY+l2b4PHo
        AIKx9gcUmE1uBJaebgpqWvwIGuzHWOjomwKe4DALrabTLBguVrHw8PU4Bl9BPoZK5zZoy7Ni
        aAy9pMHcz0Kx2YDD4xWGkK2CA1vGAgjYizgY71kOrf5OBhqeLoLCCz4W6htaaWipC2DouF7C
        gt/xmYG2ljs0uM/mMnBlyMrC61EbBbbgMAf/NZZjuJoZFp14O8HA7dxGDCcu/YXB8+QGgptZ
        zzE4HZ0sNAcHMFQ7TRR8/MOFIGAc5OB4ToiD4qNGBKePF9Dw4NNtBjJ9K2HsQwm7fjVpHhim
        SGb1QdIwWk6Tu1aR/FPUzZHMm085Uu5MIdX2WHKxvh8Ty0iQIc6KUyxxjuRzJHvQg8nQ/fsc
        uXN+jCZ9HjPePvtXxRqNrNOmyvql6/Yo4u8ZqtB+I5f2xpeLM1APk42ieFFYIXocl39wW30f
        jjAr/CR6vSEqwjHCPLE690V4R8FTwsnJov1NOxsppgmyGGjupyNMCwtEk98SznleKfwieo/F
        fHPOFSuvNn71RIXj/z8YUYRVwkrRV+hnI05ROBMlZl/7m/t2MFO8ZffSeUhZjiZVIJU2MTVB
        0upWxMWnJ2rT4vYmJThR+KNsR8Z31qER944mJPBIHa30HrZoVIyUmpye0IREnlLHKA09ZRqV
        UiOlH5L1Sbv1KTo5uQnN5mn1DOXPowc1KmGfdED+XZb3y/rvLeajZmUgab6l2P52beneOUUp
        pXU1TXuS1jIPddcWZmjsl+sWdtg2XihJ6lzlcLl630/O8ew0u4XmR5sLdi3qGpsUv2Vrml+M
        U+m7/p0I3ru0r7coYUqWqda+4WN0+yMpUFaYnjf3XGto46GyZ1pjrbd0yDK967eplZs2kytt
        G/KDq6fyt84Z1HRyvLQ8ltInS18ABizWgE0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSX0xTZxjG+b5zzncOddWTUrcTxEyboIlGhCjmTZRpdqEnS1h2YaLxYqOx
        J9IABVtEmZoArX+xDZAAQxgrldQKbEDBhM2ihCpaUSlSEbF2gyDaiGCUklZQ187s5s0vz/Pk
        d/VylKKBSeS0ukJJr1PnqoiMln2/3bipu86mSa3xroTKC6kQmj9LQ0N7GwHvH60I2rpLMQRv
        7YHHCzMIFu8PUVBb7UXQNPGMgu6BAIJeRxmBkanl4AvNEfBUlxMwXmonMPxqCYO/pgpDqzMT
        BitsGPoiL2ioDRKorzXi6HmJIWJvYcFekgyTjossLE2kgScwyoD7Vw8DveMboa7RT8DV66Fh
        oGcSw8hfDQQCbZ8YGBy4Q4O30szA77M2Aq8W7BTYQ3MsPOyzYugwRW2n331k4La5D8Pp5k4M
        vifXEFw/+w8GZ9soAXdoBkOXs5qC95dvIZi0vGbh1IUIC/WlFgTlp2poGPpwmwGTPx0Www1k
        13bRPTNHiaauo2LvgpUW79oE8c+Lz1jRdH2cFa3OI2KXY4N4yRXEYtPbECM6W84R0fm2ihXP
        v/ZhcfbBA1a888siLU75avEPSQdkOzRSrrZI0m/+JkuWfc/Yjgos7LE3fjMuQRPMeRTPCfxW
        YdA1hWNM+PXC2FiEirGSXyN0maejGxlH8WeWCY4390msSOAlYdIdpGNM88lCdaApmnOcnN8m
        jJUpPzu/Flo7+v7zxEfj52ELirGCTxf8dQFSgWRWFNeClFpdUZ5am5ueYsjJLtZpj6UczM9z
        oujP2E8uVfag+ZE9/YjnkOoL+djxJo2CURcZivP6kcBRKqXcOPGbRiHXqIt/lvT5P+mP5EqG
        frSKo1Vfyb/bJ2Up+EPqQilHkgok/f8t5uITS9CgOeHb3esG+CthOqxu3PLji/dlB+JqtP22
        HRnj7lCpJ+Nd5Zf6ly3L/z7DVeXPFu6+TDL8hx+dWPLtX1Fmmd572GY7lzK+4pq9NOnKqqGd
        /pHUlfFh02rv2uEbQVf3FrbZmjR8VfO0omB1TkJmeUdkaufNE4mu1NFpHbNV71C6O1W0IVud
        toHSG9T/AuhAtaAvAwAA
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
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index fe89282c3e96..3ef450d9a7c5 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -247,7 +247,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1

