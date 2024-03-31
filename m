Return-Path: <linux-fsdevel+bounces-15814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21229893603
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 23:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526231C209F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AD614830D;
	Sun, 31 Mar 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wNeiWuvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0B26AEA
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711921958; cv=none; b=oL3HWujjD7mo/Jva91vslyb3CnXt/Zx8Hpl3w2pr/w9miJS47N19AdUCE3xULoKaE1loBLJoVZi0lvKLiHq07acy0XUUSV63c78ZRdMBdcMk+HVicQpKfr7E2yi5BGEXRmqnesOzph/goa5KOedjg2qHHLcalvkJOYmzbrH5i7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711921958; c=relaxed/simple;
	bh=a1yuNjirfzCDT8p10gptCV5tGIyVncM2Ly8rl7WozZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9p1GZLLPiXDyYAgCZ7E8xyfULgBfSI6MRtiBAKKW4dDoq6D03t0M7y1JRbY8/6j69wf/lAp1huxbPac0IPUJXsWr26NLHoyhEpLOj6rk5xmOvGy8BZsBUSDnq40n+93HHnAi5AnLyyP3f/5jI2IXRUZS6ZfhpWCvlQeTkgFgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wNeiWuvk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711921952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LbTM6z4O4ddB2DBalGZNJXOW+Auim1CCzY1dURojKkQ=;
	b=wNeiWuvkrmSePVd2qHFA3OX3QAFboe7W9LFWlGFCtjP2CCTN5bUDfr08gIiRh7/+azgiwY
	+2IbTy8XqqIyKsEpluZItSJGC3MjlBvnIAjaTlSmjRH/FeKs9xNSDgxVX5CdXRg/1pWF07
	k4TCYioXa5tHgPG0+fRioDBcfJw6P5o=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Mitchell Augustin <mitchell.augustin@canonical.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-stable@vger.kernel.org
Subject: [PATCH] aio: Fix null ptr deref in aio_complete() wakeup
Date: Sun, 31 Mar 2024 17:52:12 -0400
Message-ID: <20240331215212.522544-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

list_del_init_careful() needs to be the last access to the wait queue
entry - it effectively unlocks access.

Previously, finish_wait() would see the empty list head and skip taking
the lock, and then we'd return - but the completion path would still
attempt to do the wakeup after the task_struct pointer had been
overwritten.

Fixes: 71eb6b6b0ba9 fs/aio: obey min_nr when doing wakeups
Cc: linux-stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAHTA-ubfwwB51A5Wg5M6H_rPEQK9pNf8FkAGH=vr=FEkyRrtqw@mail.gmail.com/
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9cdaa2faa536..0f4f531c9780 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1202,8 +1202,8 @@ static void aio_complete(struct aio_kiocb *iocb)
 		spin_lock_irqsave(&ctx->wait.lock, flags);
 		list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
 			if (avail >= curr->min_nr) {
-				list_del_init_careful(&curr->w.entry);
 				wake_up_process(curr->w.private);
+				list_del_init_careful(&curr->w.entry);
 			}
 		spin_unlock_irqrestore(&ctx->wait.lock, flags);
 	}
-- 
2.43.0


