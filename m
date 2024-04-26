Return-Path: <linux-fsdevel+bounces-17870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3518B31FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EB4285A60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166F13C90A;
	Fri, 26 Apr 2024 08:08:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E013C3D2;
	Fri, 26 Apr 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118895; cv=none; b=LSUB00E7/JSDljiSJM0Eet0ykj/JjfD2WFPaG+oC39zjBWHnHrYmOYpn0/5npgHs5i/XR6WDj4cWDOipvlgEJnvRyh6XmU0q+55A8Lpso6V7SlbqW13+H+De5+ikXZ3EfGZd8/7r4YsZGG9E3D7IJExIBmqeBepfZfm5aIc3xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118895; c=relaxed/simple;
	bh=3xfRicWnDi/w4UfU1YIn3STeRnJyS+kGHjQyZiewljk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8mdx1sxXBv+GT5JqtvIhKlwV0ApA7Y1wFZt4K8F4WbTdLnXoop7Gyw48rgEnwTfUSrxMVqgh8Ae2nxLU/x32QlFMo1ABBW52x5Db643kB8Brkrl7BPv/Xqsh255iCgjc1BkmRm6m+HwmZPVXlhXJs+lwhUNHGki/cmYdE0PsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43Q86Ale090356;
	Fri, 26 Apr 2024 16:06:10 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VQlbP0QkYz2Nhclv;
	Fri, 26 Apr 2024 16:03:29 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 26 Apr 2024 16:06:08 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC: <jack@suse.cz>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <cmllamas@google.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <jing.xia@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Fri, 26 Apr 2024 16:05:48 +0800
Message-ID: <20240426080548.8203-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 43Q86Ale090356

Now, the epoll only use wake_up() interface to wake up task.
However, sometimes, there are epoll users which want to use
the synchronous wakeup flag to hint the scheduler, such as
Android binder driver.
So add a wake_up_sync() define, and use the wake_up_sync()
when the sync is true in ep_poll_callback().

Co-developed-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 fs/eventpoll.c       | 5 ++++-
 include/linux/wait.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 882b89edc52a..9b815e0a1ac5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up(&ep->wq);
+		if (sync)
+			wake_up_sync(&ep->wq);
+		else
+			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..2b322a9b88a2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
-- 
2.25.1


