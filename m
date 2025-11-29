Return-Path: <linux-fsdevel+bounces-70236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5CC93E48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 414A64E30B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43130F959;
	Sat, 29 Nov 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bWZqT2QL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA225A322;
	Sat, 29 Nov 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423375; cv=none; b=DIewtSwGq7/THMvUfQ6IXwQD0UfOEdhRMVT0ArhWtHSB2DoWojilKjoPvrfVhf6bXI8Pvym2klg3aNPOFruOFXrdw3442d7L2SrZUyNC4k5fHBC9aVWWhoJjKhZnSwD3kOOxWtno8MINqmt4pX5O6wGfz4VD0dJfl+P/MPTlUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423375; c=relaxed/simple;
	bh=bqUouxPdYqLzTmEx0qpR8dnSZmNbQg1OgmBgiIU1An4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak9fi65YWNz4a8h1+i6aXaDWT8ApvVI+/VkdKwlv4u5mvd2mw5SNTfk20aSPrDogYn3nd1sOof0XupMHFlNBBE5rm+qOq2ZXHKltshB4cl58E1pdSXohyTRSsR4VposPy9CJTCg2Fak8fE39NCkMl/fhUP/y+42W7RtyM6KPiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bWZqT2QL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hD
	p+Z32muw4VGzyfu9HvjGO6EK32TdujvXW3E6yECew=; b=bWZqT2QLevAauTU1sZ
	9rrqlS6Ps9o64SHib4R/yIpegTdyjCQKevsQ2VNJ99V2ncTQ1fARhkyy0P1XaU2L
	z05wlic54RzY/ZuSAU3YiLXAbGzZAu7j52SeOpWwNd+EfxudCqSVvWxwPMTTmln9
	jViJ5Mezb9xQtGJ9rmRSAIvbk=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnRXeg9ipp3CIeFw--.27069S2;
	Sat, 29 Nov 2025 21:35:29 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Optimize /proc/stat idle/iowait fluctuation
Date: Sat, 29 Nov 2025 21:35:24 +0800
Message-Id: <20251129133526.1460119-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnRXeg9ipp3CIeFw--.27069S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKF1rAw48AF4DAFyrtF47Jwb_yoW8Jr4fpF
	45Kw1Fg3ZxJr1agw4fC3WkXFy5trs7JFy3tF17Ww4DAF15tr1UuwsYkFWrta4ruFWxWrs5
	uF1UWry3Ga1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKhFziUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibggVCmkq7yul4QAAs6

The idle and iowait statistics in /proc/stat are obtained through
get_idle_time and get_iowait_time. Assuming CONFIG_NO_HZ_COMMON is
enabled, when CPU is online, the idle and iowait values use the
idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
is offline. It will cause idle/iowait fluctuation in the aggregated
statistics print by /proc/stat.
Introduce get_cpu_idle_time_us_raw and get_cpu_iowait_time_us_raw, so that
/proc/stat logic can use them to get the last raw value of idle_sleeptime
and iowait_sleeptime from tick_cpu_sched without any calculation when CPU
is offline. It avoids /proc/stat idle/iowait fluctuation when cpu hotplug.
In addition, revise a comment about broken iowait counter update race
related to the topic.

Xin Zhao (2):
  timers/nohz: Revise a comment about broken iowait counter update race
  timers/nohz: Avoid /proc/stat idle/iowait fluctuation when cpu hotplug

 fs/proc/stat.c           |  4 ++++
 include/linux/tick.h     |  4 ++++
 kernel/time/tick-sched.c | 50 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.34.1


