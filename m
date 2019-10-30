Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60376E9917
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 10:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ3JVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 05:21:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:56870 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:21:19 -0400
Received: from [172.16.24.163] (helo=snorch.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <ptikhomirov@virtuozzo.com>)
        id 1iPkAG-0003hv-3T; Wed, 30 Oct 2019 12:21:16 +0300
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] fs/ppoll: skip excess EINTR if we never sleep
Date:   Wed, 30 Oct 2019 12:21:02 +0300
Message-Id: <20191030092102.871-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If while calling sys_ppoll with zero timeout we had received a signal,
we do return -EINTR.

FMPOV the -EINTR should specify that we were interrupted by the signal,
and not that we have a pending signal which does not interfere with us
at all as we were planning to return anyway. We can just return 0 in
these case.

I understand that it is a rare situation that signal comes to us while
in poll with zero timeout, but that reproduced somehow on VZ7 kernel on
CRIU tests.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/select.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 53a0c149f528..54d523e3de7f 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -873,7 +873,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 {
 	poll_table* pt = &wait->pt;
 	ktime_t expire, *to = NULL;
-	int timed_out = 0, count = 0;
+	int timed_out = 0, no_timeout = 0, count = 0;
 	u64 slack = 0;
 	__poll_t busy_flag = net_busy_loop_on() ? POLL_BUSY_LOOP : 0;
 	unsigned long busy_start = 0;
@@ -881,10 +881,10 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 	/* Optimise the no-wait case */
 	if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
 		pt->_qproc = NULL;
-		timed_out = 1;
+		no_timeout = 1;
 	}
 
-	if (end_time && !timed_out)
+	if (end_time && !no_timeout)
 		slack = select_estimate_accuracy(end_time);
 
 	for (;;) {
@@ -921,10 +921,10 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 		pt->_qproc = NULL;
 		if (!count) {
 			count = wait->error;
-			if (signal_pending(current))
+			if (!no_timeout && signal_pending(current))
 				count = -ERESTARTNOHAND;
 		}
-		if (count || timed_out)
+		if (count || timed_out || no_timeout)
 			break;
 
 		/* only if found POLL_BUSY_LOOP sockets && not out of time */
-- 
2.21.0

