Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2EA2F27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 07:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfH3FpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 01:45:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40286 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfH3FpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:45:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so5821548otb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 22:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xuuSwgJWCqcDc1AbsIjp7yN/mRhhcSgBhiJdsYZVCA=;
        b=GI1KfcM4GYbh05OZLb000/qx2D4gy8snqMb4Nhu0mPHzjXiIQGXvxjYUu8geuOgkEB
         W+7KNsA2w9g1tN5YyxSNCuuG/SgM0+hEqdr7pO0ovTrxikZ55cXaGkJLeiAX9ICEef0S
         MkaShiZ1rT5cIDvil50XfiJD2diLLxqwk+So/ITlpV4VnZpykUPf78Qk/8IghjPUNAYx
         s7NMYkKy2G7zYAM5ZRu/zmDYl3w2FlqcK3Vu6ES8cPh9nOPsb7sS3nqZVr7jcXJbcOtz
         OrTpNN/50fQWFlzosGaObZK0aVCbv7wFfdFYqtHdIiRcjVPagMNnLydCj5TMZLfIsa0L
         PiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xuuSwgJWCqcDc1AbsIjp7yN/mRhhcSgBhiJdsYZVCA=;
        b=TfQZAkB0osL1j599fjlKsgvZhNkpGIIl8TsMO+Yf4ZC+6XsVYG8AkCY9MTB3/goKEz
         JbrM+SrzygaHFu0Efihd7jWmNI+4dfva5HMzIbiEd3fYQXNWAYWXsEdpXPorVgFa7sDD
         FVFmBVGmql7vSSRA2Dy4dBkIv9DuMbqtxnZWZf760WCGz6OT8az+fNtKFvRQnGqWFKDG
         ClpUq1NdVRFJg6PO+ETxfufzBq/D6b21fJq4iIiZBeweWqERF4TSU+WOgea99zuKYgF7
         SSAmUrHzxH0JYxZI/RGVZlqx+cGRKGUgMsPmpXCTk3FJBBHDL/k5i8KSWejBvEShPhXs
         RJuQ==
X-Gm-Message-State: APjAAAXykO9YTfeGS9Gn5Hn2I4xGjtSTiXj/azIgSfCGYkmS4iMqMJWj
        YFzKQDRY64jIhr+zPpqSGraJ4mbPeDKCCg==
X-Google-Smtp-Source: APXvYqzGUyuAkVpBq01B1WkMHWncGpb/6RmallypNCRKvbAeHOKYuZlwyLICrAHdHcpk3ucJyNP5ug==
X-Received: by 2002:a9d:6852:: with SMTP id c18mr11051720oto.218.1567143905919;
        Thu, 29 Aug 2019 22:45:05 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id l14sm1310424oii.27.2019.08.29.22.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:45:04 -0700 (PDT)
From:   hev <r@hev.cc>
To:     linux-fsdevel@vger.kernel.org
Cc:     e@80x24.org, Heiher <r@hev.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/epoll: fix the edge-triggered mode for epoll itself
Date:   Fri, 30 Aug 2019 13:44:57 +0800
Message-Id: <20190830054457.5445-1-r@hev.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Heiher <r@hev.cc>

The structure of event pools:
 efd[2]:
 {
     sfd[0] (EPOLLIN)
 }

 efd[1]:
 {
     efd[2] (EPOLLIN)
 }

 efd[0]:
 {
     efd[2] (EPOLLIN | EPOLLET)
 }

When sfd[0] to be readable:
 * the epoll_wait(efd[0], ..., 0) should return efd[2]'s events on first call,
   and returns 0 on next calls, because efd[2] is added in edge-triggered mode.
 * the epoll_wait(efd[1], ..., 0) should returns efd[2]'s events on every calls
   until efd[2] is not readable (epoll_wait(efd[2], ...) => 0), because efd[1]
   is added in level-triggered mode.
 * the epoll_wait(efd[2], ..., 0) should returns sfd[0]'s events on every calls
   until sfd[0] is not readable (read(sfd[0], ...) => EAGAIN), because sfd[0]
   is added in level-triggered mode.

 #include <stdio.h>
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>

 int main(int argc, char *argv[])
 {
 	int sfd[2];
 	int efd[3];
 	int nfds;
 	struct epoll_event e;

 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
 		goto out;

 	efd[0] = epoll_create(1);
 	if (efd[0] < 0)
 		goto out;

 	efd[1] = epoll_create(1);
 	if (efd[1] < 0)
 		goto out;

 	efd[2] = epoll_create(1);
 	if (efd[2] < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[0], &e) < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, efd[2], &e) < 0)
 		goto out;

 	e.events = EPOLLIN | EPOLLET;
 	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], &e) < 0)
 		goto out;

 	if (write(sfd[1], "w", 1) != 1)
 		goto out;

 	nfds = epoll_wait(efd[0], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[0], &e, 1, 0);
 	if (nfds != 0)
 		goto out;

 	nfds = epoll_wait(efd[1], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[1], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[2], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[2], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	close(efd[1]);
 	close(efd[0]);
 	close(sfd[0]);
 	close(sfd[1]);

 	printf("SUCC\n");
 	return 0;

 out:
 	printf("FAIL\n");
 	return -1;
 }

Signed-off-by: hev <r@hev.cc>
Cc: Eric Wong <e@80x24.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/eventpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f5011fac..a44cb27c636c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -672,6 +672,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 {
 	__poll_t res;
 	int pwake = 0;
+	int nwake = 0;
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
@@ -685,6 +686,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	if (!ep_locked)
 		mutex_lock_nested(&ep->mtx, depth);
 
+	if (!depth || list_empty(&ep->rdllist))
+		nwake = 1;
+
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -739,7 +743,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	list_splice(&txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
 
-	if (!list_empty(&ep->rdllist)) {
+	if (nwake && !list_empty(&ep->rdllist)) {
 		/*
 		 * Wake up (if active) both the eventpoll wait list and
 		 * the ->poll() wait list (delayed after we release the lock).
-- 
2.23.0

