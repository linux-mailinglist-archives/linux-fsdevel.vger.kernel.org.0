Return-Path: <linux-fsdevel+bounces-71041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8BCB26BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EEAC302D53E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602543002BB;
	Wed, 10 Dec 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PlhlATrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BA26CE1A;
	Wed, 10 Dec 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355536; cv=none; b=aMLchKG6LO3ZLFIvw/OBT6AeDVDevCniWqyxKneiPhYd33AWbU2bCkCiPyQUMIdNFlZUMvN6nR7P3FMBOr309fLaulynwBW3jVoHuk9XskD5AVqVwY453ni/EZeWOYCkP3w7iMwl3wuBSiezaLOGyyRff58zd4r7Tyiarg11vOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355536; c=relaxed/simple;
	bh=Hf658B0LkHhupv4JfuDtfgwGLfcvkujmPiARuOfCRsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nm5nGZeY/1Amz0acPyzr6PVQrDY1BzbWwymk8X7uvMT0LWIgF7/YkAlkKqaUv6iBN53kQwGVhCRzZCqKR6xC0Q+fSRgWetEDXfPuafkolW8/itCp48Wi+IH4yBKyvi2tRdBcHFgPExwiD1mtPhmUyWhWH4ilL53vUR/1kJViS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PlhlATrG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oy
	cbgmZxOQsU7O62lmMm56jd3KJRKPIIee9vEZ5RhNo=; b=PlhlATrGK84kZy3DR1
	cZacYgwAhJ/lFYYiimpl6jpGJL1pQl+Bg5jLazALV1JVysN2c2FHX6CJAzoq82az
	Ww5gDvNYIfbdadVNeFmj6yzCoYJcqwGsz+cIP3VTqwVAnAsPkbRYuUpGf+ie2dsi
	DTtzgo70b0W7tOixgC7jzGzFM=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnrLLpLzlpnhe8Aw--.6723S2;
	Wed, 10 Dec 2025 16:31:38 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] timers/nohz: Optimize /proc/stat idle/iowait fluctuation
Date: Wed, 10 Dec 2025 16:31:33 +0800
Message-Id: <20251210083135.3993562-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnrLLpLzlpnhe8Aw--.6723S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3AFW7GF1fWryUJw45GFg_yoW5JF45pF
	W5Kwn0grn7JFy7Kw4fGw4DXF1YqF4kJr13tan7GrsxAF15Ar10ywsYyFWrZFyF9FykJr15
	X3y8WryYkw45G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEMmhUUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwquuGk5L+qFewAA3I

The idle and iowait statistics in /proc/stat are obtained through
get_idle_time() and get_iowait_time(). Assuming CONFIG_NO_HZ_COMMON is
enabled, when CPU is online, the idle and iowait values use the
idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
is offline. Although /proc/stat do not print statistics of offline CPU,
it still print aggregated statistics of all possible CPUs.

ick_cpu_sched and kernel_cpustat are maintained by different logic,
leading to a significant gap. The first line of the data below shows the
/proc/stat output when only one CPU remains after CPU offline, the second
line shows the /proc/stat output after all CPUs are brought back online:

cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0

Obviously, other values do not experience significant fluctuations, while
idle/iowait statistics show a substantial decrease, which make system CPU
monitoring troublesome.

get_cpu_idle_time_us() calculates the latest cpu idle time based on
idle_entrytime and current time. When CPU is idle when offline, the value
return by get_cpu_idle_time_us() will continue to increase, which is
unexpected. get_cpu_iowait_time_us() has the similar calculation logic.
When CPU is in the iowait state when offline, the value return by
get_cpu_iowait_time_us() will continue to increase.

Introduce get_cpu_idle_time_us_offline() as the _offline variants of
get_cpu_idle_time_us(). get_cpu_idle_time_us_offline() just return the
same value of idle_sleeptime without any calculation. In this way,
/proc/stat logic can use it to get a correct CPU idle time, which remains
unchanged during CPU offline period. Also, the aggregated statistics of
all possible CPUs printed by /proc/stat will not experience significant
fluctuation when CPU hotplug.
So as the newly added get_cpu_iowait_time_us_offline().

In addition, revise a comment about broken iowait counter update race
related to the topic.

Xin Zhao (2):
  timers/nohz: Revise a comment about broken iowait counter update race
  timers/nohz: Avoid /proc/stat idle/iowait fluctuation when cpu hotplug

 fs/proc/stat.c           |  4 +++
 include/linux/tick.h     |  4 +++
 kernel/time/tick-sched.c | 58 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.34.1


