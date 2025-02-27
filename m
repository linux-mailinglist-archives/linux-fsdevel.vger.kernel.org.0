Return-Path: <linux-fsdevel+bounces-42742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD21A4739B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35F01712A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 03:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DE1D63E5;
	Thu, 27 Feb 2025 03:36:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418F1D63DB;
	Thu, 27 Feb 2025 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627360; cv=none; b=aFhZOHuGC/gw2RKHJBPIPgU8hm+dssOqfVeDF0WHMCdG/nFSctlDSoUlAjx6DkeNTUwgbObW+U0pZDUaMaH2tksAkhhxbm5tepAWIu2r8oXV7vuDqr3qPWE8x0nPUuj7ryAbD9IB/NKZdZznDdRqZwGeTGbSKgxAIJI/Mlue+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627360; c=relaxed/simple;
	bh=SisSBkFHeaL54JhY/xgJRhAaEfZtwxJkVul944nCfxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AysH+LujCxg4FcWLIFlfy1LpRGfoD05osg8jak3uocJLs62WgTCvmvAitMjMrnw5urGkyH+l6KgIBbg1+0UKp/npK1+2Hqoe+REK4p7kfP8Fa6X1lusdKkFr4QKSHBJPTI7dFuU4nlkaJ5AFInDFBhDTYuiprXQZ7zMpBmsbWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from fedora41.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltACXGQ1D3b9n_vAJAA--.414S2;
	Thu, 27 Feb 2025 11:34:32 +0800 (CST)
From: Lin Feng <linf@wangsu.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	soheil@google.com,
	linf@wangsu.com
Subject: [PATCH] epoll: simplify ep_busy_loop by removing always 0 argument
Date: Thu, 27 Feb 2025 11:34:12 +0800
Message-ID: <20250227033412.5873-1-linf@wangsu.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:SyJltACXGQ1D3b9n_vAJAA--.414S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rtrW3Gw47Zr43WFWruFg_yoW8Cw48pF
	4UKr4aqFWftrn2yrsxJF48ZFnIgwn3G39rAr45C3sxCa18tw15ZF97try5ZF1rGryvvr1Y
	va1jyay7urW3CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
	8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8GwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	fUwwZ2DUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Commit 00b27634bc471("epoll: replace gotos with a proper loop") refactored
ep_poll and always feeds ep_busy_loop with a time_out value of 0, nonblock
mode for ep_busy_loop has sunk since, IOW nonblock mode checking has been
taken over by ep_poll itself, codes snipped:

static int ep_poll(struct eventpoll *ep...
{
...
    if (timed_out)
        return 0;

    eavail = ep_busy_loop(ep, timed_out);
...
}

Given this fact codes can be simplified a bit for ep_busy_loop.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7c0980db77b3..1fc770270ab8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -438,7 +438,7 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
  *
  * we must do our busy polling with irqs enabled
  */
-static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
+static bool ep_busy_loop(struct eventpoll *ep)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 	u16 budget = READ_ONCE(ep->busy_poll_budget);
@@ -448,7 +448,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 		budget = BUSY_POLL_BUDGET;
 
 	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
+		napi_busy_loop(napi_id, ep_busy_loop_end,
 			       ep, prefer_busy_poll, budget);
 		if (ep_events_available(ep))
 			return true;
@@ -560,7 +560,7 @@ static void ep_resume_napi_irqs(struct eventpoll *ep)
 
 #else
 
-static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
+static inline bool ep_busy_loop(struct eventpoll *ep)
 {
 	return false;
 }
@@ -2047,7 +2047,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		if (timed_out)
 			return 0;
 
-		eavail = ep_busy_loop(ep, timed_out);
+		eavail = ep_busy_loop(ep);
 		if (eavail)
 			continue;
 
-- 
2.48.1


