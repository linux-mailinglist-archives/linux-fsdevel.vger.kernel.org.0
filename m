Return-Path: <linux-fsdevel+bounces-13578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC368715C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 07:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8202838C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DAA7BAE1;
	Tue,  5 Mar 2024 06:19:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42346521
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619569; cv=none; b=h7NTM11XOgOLmBZoKbmelNJZhAn+9Hlu2u9rCm1ylyvrRVi0sN/WdRWqvp3nzbFaCoF0oksdhA7TjxAdbR091WWOwvdpsQRYqrLh8DFe7gcg4aOXA0T3J7h0Ctws0+Gr/nY9kVypDqiURvFkcymDs2AFRiU/Mzr8gb23VJIptH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619569; c=relaxed/simple;
	bh=38M49hfMKXVFlrH0a9ab/47+5l8sxGZsJqTwlmiE8Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYhGnviJktJ+0g/ocD6fEvG4SC2TvmFo59H0nbhZ0Yv9N4+z8Ckolk4gofkOCpQDJsiuRpTFn3DsquHi9na2uE86Inbn+FV/DTh2d3Lo1ahKZGUlbt0vxbQL6pUer5d2At6imrDhnNr49xx7v2UdSP81isk0+Sqr5O0z+ZXmmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp68t1709619502t4d4a2x3
X-QQ-Originating-IP: T4meermmu+Ia16GQlx4rAkN8+eYxGQS4m90DnYdgQQ4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Mar 2024 14:18:20 +0800 (CST)
X-QQ-SSF: 01400000000000I0I000000A0000000
X-QQ-FEAT: D6RqbDSxuq6SxoEj7CmFJfWTRkHADiM76myAN76saUXr4MH4srEsZpra4E6qP
	0VRtz1U/oc0nbCygPhxhCOx4YdqgTwYX2//XO43nWQ7JVxWPxdnlnxLKXnj5LUuTuISJMvU
	pC98DFbDKtblZiC7FZ4nuMkkvKuP5cAqoZqkrkQN/F66InDNBmV4PID3PDSfJbC4LaHrUln
	+4TWsZJzrGjOl1a/x+lmSKu6jlw++7vJceynOcZUkzGjsbAB2wmmmA3ElO4kqafnulu2Hep
	SX3Zb82KgBwAG28H7PdgugEwobvDIvtCpyGOxc1ASzZg1LlYrfynFNkcKYHwxbTst3Aag0I
	0Bi/r3PqIZf3pQk0yQbKoIeGR7eZNItjO3ajwVHFv96XOoaUBqsU7GjDMrMwuvRdZGUUts2
	Of+wxOK1zTZtJtxCV9Ef8hMZzOBRVUhq
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3790458545057705600
From: Winston Wen <wentao@uniontech.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Trivedi <t.vivek@samsung.com>,
	Orion Poplawski <orion@nwra.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Winston Wen <wentao@uniontech.com>
Subject: [PATCH] fanotify: allow freeze when waiting response for permission events
Date: Tue,  5 Mar 2024 14:18:04 +0800
Message-ID: <BD33543C483B89AB+20240305061804.1186796-1-wentao@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1

This is a long-standing issue that uninterruptible sleep in fanotify
could make system hibernation fail if the usperspace server gets frozen
before the process waiting for the response (as reported e.g. [1][2]).

A few years ago, there was an attempt to switch to interruptible sleep
while waiting [3], but that would lead to EINTR returns from open(2)
and break userspace [4], so it's been changed to only killable [5].

And the core freezer logic had been rewritten [6][7] in v6.1, allowing
freezing in uninterrupted sleep, so we can solve this problem now.

[1] https://lore.kernel.org/lkml/1518774280-38090-1-git-send-email-t.vivek@samsung.com/
[2] https://lore.kernel.org/lkml/c1bb16b7-9eee-9cea-2c96-a512d8b3b9c7@nwra.com/
[3] https://lore.kernel.org/linux-fsdevel/20190213145443.26836-1-jack@suse.cz/
[4] https://lore.kernel.org/linux-fsdevel/d0031e3a-f050-0832-fa59-928a80ffd44b@nwra.com/
[5] https://lore.kernel.org/linux-fsdevel/20190221105558.GA20921@quack2.suse.cz/
[6] https://lore.kernel.org/lkml/20220822114649.055452969@infradead.org/
[7] https://lore.kernel.org/lkml/20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com/

Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 fs/notify/fanotify/fanotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1e4def21811e..285beaf5bc09 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -228,8 +228,10 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	ret = wait_event_killable(group->fanotify_data.access_waitq,
-				  event->state == FAN_EVENT_ANSWERED);
+	ret = wait_event_state(group->fanotify_data.access_waitq,
+				  event->state == FAN_EVENT_ANSWERED,
+				  TASK_KILLABLE|TASK_FREEZABLE);
+
 	/* Signal pending? */
 	if (ret < 0) {
 		spin_lock(&group->notification_lock);
-- 
2.43.0


