Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345D6826AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjAaIkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 03:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjAaIkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:40:01 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A95E2C669
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 00:39:56 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 31 Jan 2023 17:39:55 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: max.byungchul.park@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 31 Jan 2023 17:39:55 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: max.byungchul.park@gmail.com
From:   Byungchul Park <max.byungchul.park@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com
Subject: [PATCH v9 01/25] llist: Move llist_{head,node} definition to types.h
Date:   Tue, 31 Jan 2023 17:39:30 +0900
Message-Id: <1675154394-25598-2-git-send-email-max.byungchul.park@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1675154394-25598-1-git-send-email-max.byungchul.park@gmail.com>
References: <1675154394-25598-1-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

llist_head and llist_node can be used by very primitives. For example,
Dept for tracking dependency uses llist things in its header. To avoid
header dependency, move those to types.h.

Signed-off-by: Byungchul Park <max.byungchul.park@gmail.com>
---
 include/linux/llist.h | 8 --------
 include/linux/types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d..99cc3c3 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a..b12a444 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -187,6 +187,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
-- 
1.9.1

