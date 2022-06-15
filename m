Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E755F07E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiF1Voj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF1Voi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:44:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C51B7B2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 14:44:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 136so8070573pfy.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=TeO0t0DJhH40WIl7Vbgx7DQrmpnWJwpLVnwQgvva4x4=;
        b=KRkasxtHfuIGPlHfbWQTNG6foYVaYvPaKcOtI5HwDb2AOGP7QItQDDgNuopHUcga/H
         OLf3n7av5mB6vG9RPPSkTqynn5wLyvhrtQS9++zeNZuevyPFQD0RwmgxznqgJYXz333S
         jQot788JZnFFWnlMI++YSrPWVDDzrb+ohqODSWw6L7NVl6WNVfu6vMAYtbp6Abrdhpu8
         9kjd8KOy0/0MlZPBJsAZffSgFNZ5fhnFu+W6TPIIJq2TXYo81qIcGwAvW/pLktIHUB2u
         lzXRGaYqB/abn1lCCnC1zz8aLBgvoom000fBXqmyXUxtTEVEyLr9vHshwXQ8zomi9ECx
         BZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version;
        bh=TeO0t0DJhH40WIl7Vbgx7DQrmpnWJwpLVnwQgvva4x4=;
        b=CruT9jirsS2hK0cHd/iz3psTy5MZyJ1lHPh01L+nMLrT3xVUTHJmF6iPpFqzGneUyC
         ZkpWQ4pDraqazL7CgxiGzjFY0Ahq/FD9KqjEZT8/rp4x4l4t7Y8S+EqDg/gbiPHDxF/Z
         75iH+mqbYngWoD8EnsWx3KW+HfB8WykiZ7Pn3zc4uvhauktMePZxmHxdIoWUNEVVoMGj
         euZoZ4vnRb8DbMXlduf3nEimgUQHpTGAu5b7GMsDWddMT8lxvWkilZ27m6Se5xgbDGHg
         tGtqANIRNJCXmTIHNG3eZpn6fgBFsSeea7UscVuTqD0QY35xyOzLOQkB6LTYlc1/ql1N
         7pEA==
X-Gm-Message-State: AJIora/6FAN8fI+v/pPXETp6/0AttSfLV9Xfiyhl22FAv9P8xJ5GGYiD
        eF7XlBCTwVLIebvrTL/AuF1PpWVqmLmeJw==
X-Google-Smtp-Source: AGRyM1uLeOu44xplLd/CxLafuzCbkEBJZa98R3umT6BodvfxtgAAPRjzUEEW1sZM3M9/DYscE9bl+A==
X-Received: by 2002:a05:6a00:218c:b0:525:5236:74c with SMTP id h12-20020a056a00218c00b005255236074cmr6938808pfi.44.1656452677380;
        Tue, 28 Jun 2022 14:44:37 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id g4-20020a655944000000b003fe4da67980sm9692585pgu.68.2022.06.28.14.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:44:35 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [RESEND RFC PATCH] epoll: autoremove wakers even more aggressively
Date:   Wed, 15 Jun 2022 14:24:23 -0700
Message-ID: <xm26fsjotqda.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-14.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a process is killed or otherwise exits while having active network
connections and many threads waiting on epoll_wait, the threads will all
be woken immediately, but not removed from ep->wq. Then when network
traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
will not remove the entries from the list.

This means that the cost of the wakeup attempt is far higher than usual,
does not decrease, and this also competes with the dying threads trying
to actually make progress and remove themselves from the wq.

Handle this by removing visited epoll wq entries unconditionally, rather
than only when the wakeup succeeds - the structure of ep_poll means that
the only potential loss is the timed_out->eavail heuristic, which now
can race and result in a redundant ep_send_events attempt. (But only
when incoming data and a timeout actually race, not on every timeout)

Signed-off-by: Ben Segall <bsegall@google.com>
---
 fs/eventpoll.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e2daa940ebce..8b56b94e2f56 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1745,10 +1745,25 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 	ktime_get_ts64(&now);
 	*to = timespec64_add_safe(now, *to);
 	return to;
 }
 
+/*
+ * autoremove_wake_function, but remove even on failure to wake up, because we
+ * know that default_wake_function/ttwu will only fail if the thread is already
+ * woken, and in that case the ep_poll loop will remove the entry anyways, not
+ * try to reuse it.
+ */
+static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
+				       unsigned int mode, int sync, void *key)
+{
+	int ret = default_wake_function(wq_entry, mode, sync, key);
+
+	list_del_init(&wq_entry->entry);
+	return ret;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
  *
  * @ep: Pointer to the eventpoll context.
@@ -1826,12 +1841,19 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * chance to harvest new event. Otherwise wakeup can be
 		 * lost. This is also good performance-wise, because on
 		 * normal wakeup path no need to call __remove_wait_queue()
 		 * explicitly, thus ep->lock is not taken, which halts the
 		 * event delivery.
+		 *
+		 * In fact, we now use an even more aggressive function that
+		 * unconditionally removes, because we don't reuse the wait
+		 * entry between loop iterations. This lets us also avoid the
+		 * performance issue if a process is killed, causing all of its
+		 * threads to wake up without being removed normally.
 		 */
 		init_wait(&wait);
+		wait.func = ep_autoremove_wake_function;
 
 		write_lock_irq(&ep->lock);
 		/*
 		 * Barrierless variant, waitqueue_active() is called under
 		 * the same lock on wakeup ep_poll_callback() side, so it
-- 
2.36.1.476.g0c4daa206d-goog

