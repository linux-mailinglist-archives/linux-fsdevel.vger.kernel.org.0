Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D474745090
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGBTju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjGBTjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB810E2;
        Sun,  2 Jul 2023 12:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9093560C8D;
        Sun,  2 Jul 2023 19:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A72C433C9;
        Sun,  2 Jul 2023 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326728;
        bh=BNrNWmB+JQnc92pS8WVwyQ6gfotA+7m5m3b2dj1paEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=legbWX0b21nNkQB8VT2t+6ko7If2696RxcZbBtaZbPpdnIZbIvGTpO+QKa8pNPYkG
         zjStuzjTZghPX/5+xcclbk736x4kLohyegkvb9ch2WxmLKOgThZ7kpZ7tSbHlFGpcV
         9YwITEgH21lVsfrB17w4JxPkczPnTJMP3oM/6GlojyMVHPCc4i7xH/PCczugmCujg/
         8RITpnwKqrjDpGC2B6IoI03qQpS+JzxH2cxao2Lgk3ezSQg9GyDyI5sfWS0UKgrhyw
         ufME+s/zM6BUji6w2dxgRsn2ZHEpZL13NLbRLQh3rybYNDRLrJHK+RaYUGy8RdRqbd
         Eu42ZMMEWC1qw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, willy@infradead.org, wenyang.linux@foxmail.com,
        dylany@fb.com, zhangqilong3@huawei.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 11/16] fs: use correct __poll_t type
Date:   Sun,  2 Jul 2023 15:38:10 -0400
Message-Id: <20230702193815.1775684-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Min-Hua Chen <minhuadotchen@gmail.com>

[ Upstream commit 38f1755a3e59a3f88e33030f8e4ee0421de2f05a ]

Fix the following sparse warnings by using __poll_t instead
of unsigned type.

fs/eventpoll.c:541:9: sparse: warning: restricted __poll_t degrades to integer
fs/eventfd.c:67:17: sparse: warning: restricted __poll_t degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Message-Id: <20230511164628.336586-1-minhuadotchen@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventfd.c            | 2 +-
 fs/eventpoll.c          | 2 +-
 include/linux/eventfd.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 95850a13ce8d0..6c06a527747f2 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -43,7 +43,7 @@ struct eventfd_ctx {
 	int id;
 };
 
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask)
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
 {
 	unsigned long flags;
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 266d45c7685b4..4b1b3362f697b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -536,7 +536,7 @@ static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
 #else
 
 static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
-			     unsigned pollflags)
+			     __poll_t pollflags)
 {
 	wake_up_poll(&ep->poll_wait, EPOLLIN | pollflags);
 }
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 36a486505b081..98d31cdaca400 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -40,7 +40,7 @@ struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
 struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
 __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask);
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
-- 
2.39.2

