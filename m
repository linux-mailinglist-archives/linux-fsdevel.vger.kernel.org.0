Return-Path: <linux-fsdevel+bounces-71044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF1CB26DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E25FF3023B5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209D306B06;
	Wed, 10 Dec 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TCHn/qpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0C3A1C9;
	Wed, 10 Dec 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355661; cv=none; b=TXDNfvYRDjF/KVxyY82G6RpV5dOgg/zzQCpkY21xefP8kgmlzADNQEd40ceVb19NUBg+ywB4xddpOc8Zy+GTDIa9adWIu1R5FVepmDCTKh/d1ZRi+fS7aZBv3CUzHv01oLgvNl8hSiZUi8RhgBWsBWxjq63uKv5IW7JCFbz92Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355661; c=relaxed/simple;
	bh=E5w91AWzdvSwdEg82cXPRqpJgCWgk6uFICQGS7jF3rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBXVR1QayUZGkxCf1sck/UA51LQY999twM0k0uwi65NrjSYC7l6Iw8XshNSVkiRVpAUwaqOjxrTbYkDjtUl3qJV04gDSs9qUNUuXL6XTQDQF9x0AJBsbY900IIJBPe8z6Af/KcQ2gmcR9ttJDbGOlv1vPxHxEK5NaBA0o/cCEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TCHn/qpW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dJ
	4wSaOL5krmm2PnZTwaKQGWHAtv7uJq3xpcPjM15q8=; b=TCHn/qpWtmfNdJ6IVq
	6UAy9cYZOTzXQAC2uxJIzOB5ki0Y5io98Lj0uNAiG6Ok5L6mnpnsvtnPC816+FUx
	N+ejPGFMSGMFgNUyIdR12h9xTYh5/v4L/kJ/reYT+x843uzQ9MrqGBvw8830vwh9
	BJayoAZ6N08M09I0BN+X9P8mQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnrLLpLzlpnhe8Aw--.6723S3;
	Wed, 10 Dec 2025 16:31:39 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] timers/nohz: Revise a comment about broken iowait counter update race
Date: Wed, 10 Dec 2025 16:31:34 +0800
Message-Id: <20251210083135.3993562-2-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210083135.3993562-1-jackzxcui1989@163.com>
References: <20251210083135.3993562-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnrLLpLzlpnhe8Aw--.6723S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17AFW3WFy8Kr1fAw1kXwb_yoW8Wr48pF
	4DKa4FqF4UJ3W2yayxAa1vqa4rJws3Wry3Kas3Ww1IyFn8Jr1Svw1FgFWSvF1I9FWfuw42
	vFy2g3yayw4YkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRkHUDUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAuuuGk5L+vKNAAA33

Task migration during wakeup may cause /proc/stat iowait regression,
as mentioned in the commit message of Frederic Weisbecker's previous
patch. The nr_iowait statistic of rq can be decreased by remote CPU
during wakeup, leading to a sudden drop in /proc/stat iowait calculation,
while /proc/stat idle statistic experiences a sudden increase.
Excluding the hotplug scenario when /proc/stat idle statistic may
experiences a sudden decrease which is fixed in a subsequent patch,
/proc/stat idle statistic will never decrease suddenly, as there is no
logic in kernel that allows a remote CPU to increase rq nr_iowait.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8ddf74e70..4d089b290 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -812,8 +812,8 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
  * Return the cumulative idle time (since boot) for a given
  * CPU, in microseconds. Note that this is partially broken due to
  * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
+ * any synchronization. Therefore it is possible to observe sudden
+ * increases within two consecutive reads.
  *
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
-- 
2.34.1


