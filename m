Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA97A9ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjIUSsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIUSsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:48:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AFEE86D
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:48:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53348be3fe1so1030833a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695322079; x=1695926879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln8pAXov2i3W9jm1L6DymijJbQvZk3PVbO+zm8QE4Tk=;
        b=DedfHSMxJ4pHtOAMAtM3nfFWfK2RG7tFJfneIdcg8oTu0AddooUpsUyKZr59ohIgOj
         GwEDF5oHQOqlWiv4GUHX+0etOxpJaB1aIq272k+qheq3F1xA/y54RIrTXSP7WEeDJqsj
         CgSODq8EsVMe4v7Ryl5RSSCwVTLPZcPITFFzu6nBm7gSfb342sN2LiOE+SNbuVdUEUkz
         E1bS87Egu6kt4W7lORwpK1jTL50DaCLr7Q7Du0ockkm1+dBkf8Y7j8bVJm7u0qPqlWBM
         /jhd4WtEU8v8vPwoExrLd3xaduVi2p6BtdSfEjxRS6bZycSkuR2TLIt92PhOerpaK//Y
         kmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322079; x=1695926879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln8pAXov2i3W9jm1L6DymijJbQvZk3PVbO+zm8QE4Tk=;
        b=jrRAI8pdgDmqTw6yvC3+oGKJ0Db7kNIs/JwkMwl00hGhEt9L2Syayhaaiw0OxhVJxy
         vRy996H4oVgq0ZxDUhLLk98viJhSgcrJI0Lja9gJNNmKOYsHv+Qbg4PqVJnOSBwaGXGv
         nXGu134Ulbr+yvZW8rNxuFhNE9ew1aU2XsiwWTOKcYsYYVGjvs2m1d1yTrOwVphjGjoi
         DjtKZFST8WwGG+gpHT1UK9eyfwR+SE9BtR8bNWxDns4V0wAeKCtDgfQtnnWGqPmcv5Or
         wfrOzoreDvbR/zDxJ2z87QvkX28Kbm5L9vDqmDgFdfCP1LcLBN2Uxp8LAw7mMoccM0tk
         2LOA==
X-Gm-Message-State: AOJu0Yz9JFdD2pzVn17VTdg2DyzgQifvwxTm/Rbc4bCly17rYIflFU8T
        d3c3pWqsqij571aLIM2OiPaNHANRD4gRIU0aD8k=
X-Google-Smtp-Source: AGHT+IHSDm/lGTyJTnqjqg3B4/6aDvlgdKLxA2WrrHf6uT8+eulEAGpPC8J4aUHwdlDrn7eA8iqZAg==
X-Received: by 2002:a7b:c3cf:0:b0:402:f536:2d3e with SMTP id t15-20020a7bc3cf000000b00402f5362d3emr4452684wmj.14.1695283084637;
        Thu, 21 Sep 2023 00:58:04 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:58:04 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 4/4] fs/pipe: use spinlock in pipe_read() only if there is a watch_queue
Date:   Thu, 21 Sep 2023 09:57:55 +0200
Message-Id: <20230921075755.1378787-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921075755.1378787-1-max.kellermann@ionos.com>
References: <20230921075755.1378787-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If there is no watch_queue, holding the pipe mutex is enough to
prevent concurrent writes, and we can avoid the spinlock.

O_NOTIFICATION_QUEUE is an exotic and rarely used feature, and of all
the pipes that exist at any given time, only very few actually have a
watch_queue, therefore it appears worthwile to optimize the common
case.

This patch does not optimize pipe_resize_ring() where the spinlocks
could be avoided as well; that does not seem like a worthwile
optimization because this function is not called often.

Related commits:

- commit 8df441294dd3 ("pipe: Check for ring full inside of the
  spinlock in pipe_write()")
- commit b667b8673443 ("pipe: Advance tail pointer inside of wait
  spinlock in pipe_read()")
- commit 189b0ddc2451 ("pipe: Fix missing lock in pipe_resize_ring()")

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 939def02c18c..da557eff9560 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -322,14 +322,34 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->rd_wait.lock);
+
+				if (pipe_has_watch_queue(pipe)) {
+					/* if the pipe has a
+					 * watch_queue, we need
+					 * additional protection by
+					 * the spinlock because
+					 * notifications get posted
+					 * with only this spinlock, no
+					 * mutex
+					 */
+
+					spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
-				if (buf->flags & PIPE_BUF_FLAG_LOSS)
-					pipe->note_loss = true;
+					if (buf->flags & PIPE_BUF_FLAG_LOSS)
+						pipe->note_loss = true;
 #endif
-				tail++;
-				pipe->tail = tail;
-				spin_unlock_irq(&pipe->rd_wait.lock);
+					tail++;
+					pipe->tail = tail;
+					spin_unlock_irq(&pipe->rd_wait.lock);
+				} else {
+					/* without a watch_queue, we
+					 * can simply increment the
+					 * tail without the spinlock -
+					 * the mutex is enough
+					 */
+
+					pipe->tail = ++tail;
+				}
 			}
 			total_len -= chars;
 			if (!total_len)
-- 
2.39.2

