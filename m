Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC87822A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjHUENB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjHUENA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:13:00 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2F28CD;
        Sun, 20 Aug 2023 21:12:33 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-3b-64e2ded6c3cd
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
Subject: [RESEND PATCH v10 21/25] dept: Apply timeout consideration to hashed-waitqueue wait
Date:   Mon, 21 Aug 2023 12:46:33 +0900
Message-Id: <20230821034637.34630-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz2SbUxTZxTH9zz3tZVuN5VkV6pzaUKWsIhKZDshxi3ZB+5cfEmWmOgwckdv
        pLGgKe9sJCCIyJugAr6gASS1owxYIQtDq7UEEBEoQrAyaNbOTYkUEGmhwsRW476c/HL+//P7
        dFhC2UWFsdrkVEmfLOrUtJyUe0LqtzxyujXb7PMfQWXpNvAuFpFQ29pMg73FhKC5Iw/DdE8s
        PPLNIFgZHCagpsqOoN41RUBHrxOBxXiShtEnH8KYd46G/qoSGvKvt9Iw8nwVw2T1OQwm8x4Y
        qGjAYPU/JaFmmoYrNfk4MJ5h8BuaGDDkhoPbeJmBVdd26HeOU2CZ+BwuXZuk4Zaln4TeTjeG
        0a5aGpzNaxQM9N4jwV5ZRsGvsw00PPcZCDB45xh4aK3D0FYQEBW+fE1BX5kVQ2HjbxjGHt9E
        cLvoLwzm5nEaur0zGNrNVQS8utGDwF3uYeBUqZ+BK3nlCEpOVZMw/F8fBQWT0bCyXEt/HSN0
        z8wRQkF7hmDx1ZHC/QZe+OPyFCMU3J5ghDpzmtBujBCu35rGQv2ClxLMTWdowbxwjhGKPWNY
        mB0aYoR7F1dI4clYDd6vOiTfqZF02nRJv3VXvDzxQX4rOlHOZM5PluFc5KKKkYzluR38RYPv
        f24842eCTHOf8Q6HnwhyKPcp3172b6AjZwnu9DreOD9IB4P1XBxf2lj5tkRy4XzVyzWyGLGs
        gvuCL16OeufczJvarG8rssDafLMLBVnJRfMvXH+TQSfPnZbx18ZbyXcHG/i7RgdZgRR16IMm
        pNQmpyeJWt2OyMSsZG1mZMLxJDMKfJQhZ/WHTrRg/96GOBapQxTxG90aJSWmp2Ql2RDPEupQ
        hWrJpVEqNGJWtqQ/fkSfppNSbEjFkuqPFVG+DI2SOyqmSsck6YSkf59iVhaWi1QHY4+s2219
        hl/9WX54yWH65cC3ewfrOzzOuJ91mbbYsImRTTlrRU2pXz422aJzXvzYvSGOVryOiDTsPTqk
        OrilsGdxoeWnhL6ctu9kYnbF+Y0olOpskNTRloTfYw7/07JoCv/m6qLh7Fe7Yz65c0EZc0MM
        UZYMWfd1xFef93QtOdRqMiVR3B5B6FPEN1LS1UdNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//PdavFYS06qFSspDCyq/GCIVJRp6Dok0EEemgnXW1qW1kW
        krVZampOmlZamMoaallHP1ReEDVTu1maXbDVllSmpZnTpnaZRV9efjzPj+fTyxLqIiqA1ccf
        kkzxokFLK0nljnDL8h6XR7eyPCMMbFkrwTuaTkJRVSUNnTcqEFTWnMTQf28LvBgbRDD56AkB
        BfZOBFfdbwioaXUhqHeeoqGrbzZ0e4doaLefpcFSWkXD04EpDL35eRgq5O3wILcEQ6PvIwkF
        /TQUFliw/3zC4HOUM+BIDQaP8xIDU+5V0O7qoaD5cjsF9a+XwcUrvTTU1beT0Hrbg6HrbhEN
        rsrfFDxobSOh05ZNwfWvJTQMjDkIcHiHGHjWWIzhptW/dvr7LwruZzdiOF12C0P3q1oEDenv
        MMiVPTQ0ewcxVMt2Aiau3UPgyfnCQFqWj4HCkzkIzqblk/Dk530KrL1hMPmjiI4MF5oHhwjB
        Wn1EqB8rJoWOEl64c+kNI1gbXjNCsXxYqHaGCKV1/Vi4OuKlBLk8gxbkkTxGyPzSjYWvjx8z
        QtuFSVLo6y7AO4N2K9frJIM+STKtiIhRxj20VKHEHObocG82TkVuKhMpWJ5by5dl+Jhpprkl
        /MuXPmKaNdxCvjr7g99RsgR3ZibvHH5ETxdzuD18Vpntr0Rywbz9+28yE7GsilvHZ/5Y/W9z
        AV9xs/GvovDHcu1dNM1qLoz/5n5P5iJlMZpRjjT6+CSjqDeEhZoPxCXH64+G7k0wysj/M46U
        KdttNNq1pQlxLNLOUsUEeXRqSkwyJxubEM8SWo0qcNytU6t0YvIxyZQQbTpskMxNKJAltfNU
        23ZJMWouVjwkHZCkRMn0v8WsIiAVHT9ReCSAjX12rKll88T8O/I5UVxvjJ2lMKifvhpZOtFs
        j7ZEuT6btrZcTnqHJna/tQWtmaNYPehJHkiJHI/c2aGLiHYMkVHplh2+utwsKzdT6zRvCCzV
        JEZpckznh888n1zUYEl5P7t2Q/jFwrzFGzf1Ldo+d9/+4Nj8gyVrricYtaQ5TlwVQpjM4h/H
        eh1gLwMAAA==
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

