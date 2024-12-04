Return-Path: <linux-fsdevel+bounces-36492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C249E3FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EEA2815A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26820D507;
	Wed,  4 Dec 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPY+cq7l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650F20D4FB
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330627; cv=none; b=sTemmQzlZ6T+nyguO4Srk88oHXZ5podTSLNjtWD8pr9NdMhun6rIU9IxnKlNwOfGJgtA0AubqjBC54zLrGx4Uyh6bPtYyvr+C7xuYkLhb3jAxlXwOVCEELuQ5r7EvmuRgp+i76x93369PdubbXd0y1AnbV3q6KHfE4qOC11vXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330627; c=relaxed/simple;
	bh=G7Cz+piKZ/wy9yWMrlWusi0kS9M8VqEX4Tcy3DWxucw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTMll6xZiY35UVOZ+lfbM2dGuEuWCZYSJ9GWngEaIvjuzA3LqWpk0vqLN5Gr9ItqWYcbSotwDTqYuSEyJR1tAWX7Sgiq+x+JQ7K7yR/sR8qNPmvB6DzIbio+9soCMPekJU1ZNWdo6Bn2xhrDAOcQQxzO2NPOS/vutThYzgZ2NCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPY+cq7l; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d842280932so310436d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733330624; x=1733935424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqV8LDtjjNjnDLhAXiuBFHukj0sD8bYVPKACCmhODqw=;
        b=QPY+cq7lIQOO32C+MnjvWovfXaRjPGCzEX67+V6SOobyZc5K+LKvpuRIMcGe0xEYyt
         szFMplfMAo39+PrQ2NH4FgLJ91P4eTEBL0gwhyZs3jJEK07IwUKc2YarY1DPDofM8KEK
         Syv7ZV9m4Fl0YHj0CJF2Q9X7/abEgAAZfhO/3RR8YZT9SFSZRl8HBQX4r+ipi2oRVSeJ
         fGetzRKmBkfS3a1k9cuwiM0xGa/qH3tsEFkCVgDWFweOZwGW1uj2HLeyn8/AD6V7gv1H
         GNH0sQZe+8aAJ1iKK/E2GXOehjZv1QXGavevZhM5w5vK9ffQGKVMr/o7EYt31h8sRf71
         EXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330624; x=1733935424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqV8LDtjjNjnDLhAXiuBFHukj0sD8bYVPKACCmhODqw=;
        b=McVe/T8Emch6TK0xHZBO2o3AWPhM5RSJfwZ2GppC2CpfXznimFvvvsOgh5mIG7Uh9J
         7/yoq1FuaPQjU5/lPr0BCD5SJYlmO3W6QFOvB4DtgMKQkxkIXXjFSAOCsqU71/G/qKQj
         ZFv1ZZbcelYhiWIeyLL1F+9OpWE9I2MredQDeQNjDlQiGkNrJb1JiP1H9+sJA8L6uj7i
         MNjIAddzoGY9DEGYk1KT1HtinrWxjU4V34/psh7JhQao9nUupDZ+OE0dATyPAeI0FEGL
         NlnTSQW16wpAtWNSWAeDEVGBO0yHtAIZN4EKYn78khIhQjjLzoOnUMOUj3cN0rcAhiAm
         GSrA==
X-Gm-Message-State: AOJu0YwIM/rJaoUBHJmaejpC1sDCGnhcqLf4GryXxPA+xwbyv4+GHCqY
	023FKQb3I0Oomeu+/tZje1lp1UKEsGJY31jTPEa53qNtHAq01YAGimCTz41j
X-Gm-Gg: ASbGncuIS0RebTk0/j+ARcr0rq/67UNv7kY0DoyrI3E94Q4SHhte1PFameOma8DYX8H
	9z9dGeuMv5XEva8FfX6PT0Eg614OHfLcDi2vHKKRjVUFBhuhmbctOUq25NuUE5BpODGXeSTmWSE
	Ru81a3qd1E1diU7u9zX284PvsTJdxQmmdVryYAwyWquoXvCgTcUQ4vb/Da1Vuyg1+VSNPJ1m2dW
	KwlcWNauhLDmEpumP0Z8Oy4nQd4EhI5WxI//kHjr+VdAqnAB5KhRJqhPiZRjZK7sB7qpC8IDlL4
	AQA7QC0PfDVtVEFO+IDMNz0eS3Ml4a4pa1yL+voyOso7y3Y1AHRFup5n
X-Google-Smtp-Source: AGHT+IEbiwj6oZWu4P0cmLJtLl5gGNpGDEnZXYK86LnNcbbkHlHcv4gbLLcc30Yd86baXSgb6S3LuA==
X-Received: by 2002:a05:6214:627:b0:6d8:7db7:6d88 with SMTP id 6a1803df08f44-6d8b7377ff5mr96267016d6.28.1733330624469;
        Wed, 04 Dec 2024 08:43:44 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8c271ef14sm16195606d6.22.2024.12.04.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:43:44 -0800 (PST)
From: etmartin4313@gmail.com
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: etmartin@cisco.com,
	Etienne Martineau <etmartin4313@gmail.com>
Subject: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
Date: Wed,  4 Dec 2024 11:43:16 -0500
Message-Id: <20241204164316.219105-1-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Etienne Martineau <etmartin4313@gmail.com>

If hung task checking is enabled and FUSE server stops responding for a
long period of time, the hung task timer may fire towards the FUSE clients
and trigger stack dumps that unnecessarily alarm the user.

So, if hung task checking is enabled, we should wake up periodically to
prevent it from triggering stack dumps. This patch uses a wake-up interval
equal to half the hung_task_timeout_secs timer period, which keeps overhead
low.

Without this patch, an unresponsive FUSE server can leave the FUSE clients
in D state and produce stack dumps like below when the hung task timer
expire.

 INFO: task cp:2780 blocked for more than 30 seconds.
       Not tainted 6.13.0-rc1 #4
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cat state:D stack:0 pid:2598 tgid:2598 ppid:2583 flags:0x00004006
  ......
  <TASK>
  __schedule+0x443/0x16b0
  schedule+0x2b/0x140
  request_wait_answer+0x143/0x220
  __fuse_simple_request+0xd8/0x2c0
  fuse_send_open+0xc5/0x130
  fuse_file_open+0x117/0x1a0
  fuse_open+0x92/0x2f0
  do_dentry_open+0x25d/0x5c0
  vfs_open+0x2a/0x100
  path_openat+0x2f5/0x11d0
  do_filp_open+0xbe/0x180
  do_sys_openat2+0xa1/0xd0
  __x64_sys_openat+0x55/0xa0
  x64_sys_call+0x1998/0x26f0
  do_syscall_64+0x7c/0x170
  ......
  </TASK>

Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
---
 fs/fuse/dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..29e0c9adb799 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -422,6 +423,8 @@ static void request_wait_answer(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	/* Prevent hung task timer from firing at us */
+	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
 	int err;
 
 	if (!fc->no_interrupt) {
@@ -461,7 +464,12 @@ static void request_wait_answer(struct fuse_req *req)
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
 	 */
-	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
+	if (timeout)
+		while (!wait_event_timeout(req->waitq,
+				test_bit(FR_FINISHED, &req->flags), timeout))
+			;
+	else
+		wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
 }
 
 static void __fuse_request_send(struct fuse_req *req)
-- 
2.34.1


