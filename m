Return-Path: <linux-fsdevel+bounces-70235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2CC93E3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 14:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08CFA4E1A69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118730E0E6;
	Sat, 29 Nov 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VrwWIPfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8B23ABB0;
	Sat, 29 Nov 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423372; cv=none; b=h++4P/IIfFd8gpSEpZ98rfpunw+h7lwXWTBv7ERjSD3Qr7aOUWDeeh3+a+aayCVQtRfLWXdpM9ZjsXrBC2JboV79oXjSSVkOIRRpw1eoQxnJvD3pB5H/tHdngcp7Faf3sbYhkyQzXpqe6L7o1RmQt5L5R0UQ4LK7WgMRLQBll6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423372; c=relaxed/simple;
	bh=E5w91AWzdvSwdEg82cXPRqpJgCWgk6uFICQGS7jF3rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXWzYmgKjhSey41kvPQtshqRd2jCl6KSAe1MeW7C7uDMIDJTmrESbbx8KLoCiX+waD98NB6g6H9VBEAvYOFG8YpVB4Skq6UJutnA2qIkiJmdHQOwRkWhi/ACqPlwhgHviiwShfzK7sYVLX51oA8WlEYFNowW28IpgzfXT2Ayiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VrwWIPfH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dJ
	4wSaOL5krmm2PnZTwaKQGWHAtv7uJq3xpcPjM15q8=; b=VrwWIPfHtTuprgv+Fo
	21TBVnRnEdKwFQNDDBiKu9A/TmRxV7j2iO7IC05NbNCO6RSXXl7A2I6L9qhkUiY/
	C+U6UuKOF8TDu9g5y8rFsEb9fanFJGkDqcKplSH1GaJMVvoLJDULwQwmTjRKL/lY
	vsmWE0/uuW5EVmlKVGPi3PtZw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnRXeg9ipp3CIeFw--.27069S3;
	Sat, 29 Nov 2025 21:35:30 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] timers/nohz: Revise a comment about broken iowait counter update race
Date: Sat, 29 Nov 2025 21:35:25 +0800
Message-Id: <20251129133526.1460119-2-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251129133526.1460119-1-jackzxcui1989@163.com>
References: <20251129133526.1460119-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnRXeg9ipp3CIeFw--.27069S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17AFW3WFy8Kr1fAw1kXwb_yoW8Wr48pF
	4DKa4FqF4UJ3W2yayxAa1vqa4rJws3Wry3Kas3Ww1IyFn8Jr1Svw1FgFWSvF1I9FWfuw42
	vFy2g3yayw4YkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uj1vsUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiGREVCmkq7nW-TwAAs-

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


