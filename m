Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE529DFC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbgJ2BE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgJ1WGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:06:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CAC0613CF;
        Wed, 28 Oct 2020 15:06:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r7so512215qkf.3;
        Wed, 28 Oct 2020 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Je1s1kkyt4+Sk3cNzvubNo1nCKh/m8Vq6dPCfCCBkyo=;
        b=dTSxd0AlKUrqznvkilblmcag8TGcwXnQBOUYPH+YjyDnYpqa5l79kWv9xtGnlcfEg4
         0h5+E7FcTSYl+PVNOwTzsxfEQK9z/MTfFaaAGoVb7SHz8W0AOfRu5XBwLWJnZS00oDuG
         jS+fZzamMtUJESkP7okgED5M2/zgKkFH7lKRQt42ekyoBWWf/NVYpG4DYN6AQoGVEk7S
         2iY1R/7VKt7a1ek/S4+4A35gFqGqi3Bi0Q76oVC9NxjlFmQ2t6NocI6yXOLzUFh/LAfx
         bYOjASOli5G9ToeVw0qmW7EhMy9jJ9tNJ3taNIocb7GkYt1U28X8IH4znWmzH6zCySdb
         XtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Je1s1kkyt4+Sk3cNzvubNo1nCKh/m8Vq6dPCfCCBkyo=;
        b=V6roh5IzEl/4KDMGeQi5h6hRWAGlhWiJ6FpUUB9qrrLtiHm0L1Ho4laXXNwFCUg/oP
         bcv5+KPV+rUMfZakvlL2ZIy7GGlQ2Cu+jZxHM74CVydaGH1R4fduePrPnTPgSfKrdu+z
         HYU/FvQvNRhBJrnacqIFbjEdZqF+l84WntULPlYxDmkfn//6PiQxv57ZHwNeolDUOoHd
         j6mLRt4dThgcCDNTTXTmAxzH/b0DxHSwmwAspuHbSraynAvcoviV+iaE6Oa95M280km1
         KTiYIhPy7+ibtVwNLECsTNEg8h/FwszRL6S6kILeqjCffJRaFytxhDo+R4yF37cBB2K/
         6jfw==
X-Gm-Message-State: AOAM531INlC+mkbUG/ECva/kpgjr0gjhf0spup+MmJkazvcBHdiU3QHf
        VgJy29CIR5Rb1aXnoznnU2T7XturmuA=
X-Google-Smtp-Source: ABdhPJyuSBJ63bwvwJqI/Z4pLE6IUxC6rQn1z+b1IwljXAlCJSfx04tsV2xM9z1LqB4BaN4eT5eu7g==
X-Received: by 2002:aed:2982:: with SMTP id o2mr73310qtd.73.1603908137202;
        Wed, 28 Oct 2020 11:02:17 -0700 (PDT)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id o2sm65054qkk.121.2020.10.28.11.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:02:16 -0700 (PDT)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, Soheil Hassas Yeganeh <soheil@google.com>,
        Guantao Liu <guantaol@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH 2/2] epoll: add a selftest for epoll timeout race
Date:   Wed, 28 Oct 2020 14:02:02 -0400
Message-Id: <20201028180202.952079-2-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201028180202.952079-1-soheil.kdev@gmail.com>
References: <20201028180202.952079-1-soheil.kdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

Add a test case to ensure an event is observed by at least one
poller when an epoll timeout is used.

Signed-off-by: Guantao Liu <guantaol@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index d979ff14775a..8f82f99f7748 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -3282,4 +3282,99 @@ TEST(epoll60)
 	close(ctx.epfd);
 }
 
+struct epoll61_ctx {
+	int epfd;
+	int evfd;
+};
+
+static void *epoll61_write_eventfd(void *ctx_)
+{
+	struct epoll61_ctx *ctx = ctx_;
+	int64_t l = 1;
+
+	usleep(10950);
+	write(ctx->evfd, &l, sizeof(l));
+	return NULL;
+}
+
+static void *epoll61_epoll_with_timeout(void *ctx_)
+{
+	struct epoll61_ctx *ctx = ctx_;
+	struct epoll_event events[1];
+	int n;
+
+	n = epoll_wait(ctx->epfd, events, 1, 11);
+	/*
+	 * If epoll returned the eventfd, write on the eventfd to wake up the
+	 * blocking poller.
+	 */
+	if (n == 1) {
+		int64_t l = 1;
+
+		write(ctx->evfd, &l, sizeof(l));
+	}
+	return NULL;
+}
+
+static void *epoll61_blocking_epoll(void *ctx_)
+{
+	struct epoll61_ctx *ctx = ctx_;
+	struct epoll_event events[1];
+
+	epoll_wait(ctx->epfd, events, 1, -1);
+	return NULL;
+}
+
+TEST(epoll61)
+{
+	struct epoll61_ctx ctx;
+	struct epoll_event ev;
+	int i, r;
+
+	ctx.epfd = epoll_create1(0);
+	ASSERT_GE(ctx.epfd, 0);
+	ctx.evfd = eventfd(0, EFD_NONBLOCK);
+	ASSERT_GE(ctx.evfd, 0);
+
+	ev.events = EPOLLIN | EPOLLET | EPOLLERR | EPOLLHUP;
+	ev.data.ptr = NULL;
+	r = epoll_ctl(ctx.epfd, EPOLL_CTL_ADD, ctx.evfd, &ev);
+	ASSERT_EQ(r, 0);
+
+	/*
+	 * We are testing a race.  Repeat the test case 1000 times to make it
+	 * more likely to fail in case of a bug.
+	 */
+	for (i = 0; i < 1000; i++) {
+		pthread_t threads[3];
+		int n;
+
+		/*
+		 * Start 3 threads:
+		 * Thread 1 sleeps for 10.9ms and writes to the evenfd.
+		 * Thread 2 calls epoll with a timeout of 11ms.
+		 * Thread 3 calls epoll with a timeout of -1.
+		 *
+		 * The eventfd write by Thread 1 should either wakeup Thread 2
+		 * or Thread 3.  If it wakes up Thread 2, Thread 2 writes on the
+		 * eventfd to wake up Thread 3.
+		 *
+		 * If no events are missed, all three threads should eventually
+		 * be joinable.
+		 */
+		ASSERT_EQ(pthread_create(&threads[0], NULL,
+					 epoll61_write_eventfd, &ctx), 0);
+		ASSERT_EQ(pthread_create(&threads[1], NULL,
+					 epoll61_epoll_with_timeout, &ctx), 0);
+		ASSERT_EQ(pthread_create(&threads[2], NULL,
+					 epoll61_blocking_epoll, &ctx), 0);
+
+		for (n = 0; n < ARRAY_SIZE(threads); ++n)
+			ASSERT_EQ(pthread_join(threads[n], NULL), 0);
+	}
+
+	close(ctx.epfd);
+	close(ctx.evfd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.29.0.rc2.309.g374f81d7ae-goog

