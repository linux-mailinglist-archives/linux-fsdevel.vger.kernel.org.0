Return-Path: <linux-fsdevel+bounces-60134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD3B418ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9341751D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D082EC081;
	Wed,  3 Sep 2025 08:43:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DF26CE03;
	Wed,  3 Sep 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889004; cv=none; b=WsDz0CVsCkUQpT6xdCI+yQzNiUT2pxawRbyJni1qO8F4fTNxLnpNSv5XVkQ1B9DmeGjwwtWUYnXnjnpQb0lDiQA+wZHrI7OKQWp67ADv7fi4ew9VNXmVBLhufM/mIdewjMsyzSoSCGVxGi1kCJSn8N+trVVSEflo1jHI8pa1a3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889004; c=relaxed/simple;
	bh=FeOtINI7CWDP8yDbnH17RcPFAGkecwnxp++CzSaWZko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/on4nesFnXW7bNH6dIg5S1I9GjHTq3g0TRA6GnXZu1Hera8Fu/h9kwLVES+qp2vWqL/64AK897fIdBk17TkpODUzai8WoHWznZcpBNkA9Uuxc8K//yu1ap8CwBg0/azer5Q/ukZhAL+RofeCCscCch0j5wKTVs3fDreieiqG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee868b7fedb165-1b1f7;
	Wed, 03 Sep 2025 16:39:55 +0800 (CST)
X-RM-TRANSID:2ee868b7fedb165-1b1f7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee268b7fed832e-67324;
	Wed, 03 Sep 2025 16:39:55 +0800 (CST)
X-RM-TRANSID:2ee268b7fed832e-67324
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	lorenzo.stoakes@oracle.com,
	frederic@kernel.org,
	tglx@linutronix.de,
	xu.xin16@zte.com.cn,
	mingo@kernel.org,
	superman.xpt@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] fs/proc/base.c: Fix the wrong format specifier
Date: Wed,  3 Sep 2025 16:39:47 +0800
Message-ID: <20250903083948.2536-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Use '%d' instead of '%u' for int.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b997ceef9135..6299878e3d97 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3947,7 +3947,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 		tid = task_pid_nr_ns(task, ns);
 		if (!tid)
 			continue;	/* The task has just exited. */
-		len = snprintf(name, sizeof(name), "%u", tid);
+		len = snprintf(name, sizeof(name), "%d", tid);
 		if (!proc_fill_cache(file, ctx, name, len,
 				proc_task_instantiate, task, NULL)) {
 			/* returning this tgid failed, save it as the first
-- 
2.33.0




