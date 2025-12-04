Return-Path: <linux-fsdevel+bounces-70699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50940CA4EFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 19:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA4E318209A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 18:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5092328D82F;
	Thu,  4 Dec 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KNz5yGZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3C1DE894;
	Thu,  4 Dec 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872519; cv=none; b=HkZGXFP3XZYIigYfbDlJVHUwopPsdUfhnGEA8W9iKVH8LMftjrWzqfavZsR41/afDF3cf6ofAA6/T6yg1GcWVlPmTvJXq00WfyRxa4R5O1zdgpvcUw1OtTfaI0zhYThgs1txG2dMGECJEBrURvu5oM3NmU0n5B5vTHKAbx3KcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872519; c=relaxed/simple;
	bh=iBs8oqNylS20BNIma8UQOztYSzouNkvhiyuPEdaXm5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rx6CCqSymjo0Z2tE0Vq8xvUHfO6SV9rpg347TPxYdWDMFYl7vrR2HZXZ5+xP3Q5sz+ncpep51zdk9e/tlaRHbQlvtmJedRaVqA8IQwUmKjPOoTENnPOq6vHSdhJvzeAPZmDDKHxCORtHQOMipfi3ntLgANBptPk8lP3eDOwgD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KNz5yGZ1; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mh
	wdKbyds6+IQJbw5pYLFT3OJ2yNIIBki/DuDL13smY=; b=KNz5yGZ1Vz6R043kBP
	ON1z12+I6GC1RxrL8oMX01glgs9nDfRpMcMa5hWmeIE6vY/EuCgD7TTmrxlYt+Av
	N4m5dIpaL3/G2qenn6vqJG+cnKUF09okoQCMEj+z6RQQbU7PM4lNdP7vHdhvIpoQ
	JmbimgoYLDsq0Kc/Adl1ojBhk=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3XzUZ0TFpfsQREw--.21082S2;
	Fri, 05 Dec 2025 02:21:13 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: mingo@kernel.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	jackzxcui1989@163.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] timers/nohz: Avoid /proc/stat idle/iowait fluctuation when cpu hotplug
Date: Fri,  5 Dec 2025 02:21:13 +0800
Message-Id: <20251204182113.1518271-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aS4FztjNAwVNfoUk@gmail.com>
References: <aS4FztjNAwVNfoUk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzUZ0TFpfsQREw--.21082S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF17Cr1DtrW7ArW5Gr4xXrb_yoW7Cw4UpF
	W7tw40qr4DWFyjg3yIkw1jqrySgrs7AF9xKwn7KFZYyF45Xr1xGr48tryUuFyxuas7Zr1a
	v3y2gryxA398KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKg4agUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiGQYaCmkxzNpdXgAAsC

Dear Ingo,
    Sorry for reply late, working on another urgent task recently.


On Mon, 1 Dec 2025 22:17:02 +0100 Ingo Molnar <mingo@kernel.org> wrote:

> > The idle and iowait statistics in /proc/stat are obtained through
> > get_idle_time and get_iowait_time. Assuming CONFIG_NO_HZ_COMMON is
> > enabled, when CPU is online, the idle and iowait values use the
> > idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
> > use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
> > is offline. Although /proc/stat do not print statistics of offline CPU,
> > it still print aggregated statistics for all possible CPUs.
> > tick_cpu_sched and kernel_cpustat are maintained by different logic,
> > leading to a significant gap. The first line of the data below shows the
> > /proc/stat output when only one CPU remains after CPU offline, the second
> > line shows the /proc/stat output after all CPUs are brought back online:
> > 
> > cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
> > cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0
> 
> Yeah, that outlier indeed looks suboptimal, and there's 
> very little user-space tooling can do to detect it. I 
> think your suggestion, to use the 'frozen' values of an 
> offline CPU, might as well be the right approach.

Thanks.

> What value is printed if the CPU was never online, is 
> it properly initialized to zero?

I've done the experiment printing the values of tick_sched in secondary_start_kernel
just before executing set_cpu_online. It is confirmed that variables in tick_sched
structure, such as idle_active and idle_entrytime, are all 0, tick_sched variable is
a per-CPU variable defined at the beginning of tick-sched.c, named tick_cpu_sched.
Like other global variables, if per-CPU variables are not explicitly initialized to
specific value, they will be set to 0 by default.



> So why not just use the get_cpu_idle_time_us() and 
> get_cpu_iowait_time_us() values unconditionally, for 
> all possible_cpus?
> 
> The raw/non-raw distinction makes very little sense in 
> this context, the read_seqlock_retry loop will always 
> succeed after a single step (because there are no 
> writers), so the behavior of the full get_cpu_idle/iowait_time_us()
> functions should be close to the _raw() variants.
> 
> Patch would be much simpler that way.

Perhaps I didn't choose a good name; using the word "raw" indeed evokes thoughts of
preventing deadlocks in sequential locking. My original intention was to differentiate
from the logic of calculating:

delta = ktime_sub(now, ts->idle_entrytime);

in get_cpu_sleep_time_us, which adds this delta to the returned idle time.


If we use the original get_cpu_sleep_time_us interface directly, the calculation logic
still run even when the CPU is offline. The following four lines show the tick_sched
corresponding to CPU 3 during its offline period:

[  897.136535] zhaoxin:get_cpu_idle_time_us_raw(3)=823703591,get_cpu_idle_time_us(3)=842938736
[  897.136540] zhaoxin:cpu[3]tick_sched info:[idle_active:1][idle_entrytime:877900502450]
[  935.501687] zhaoxin:get_cpu_idle_time_us_raw(3)=823703591,get_cpu_idle_time_us(3)=881303888
[  935.501694] zhaoxin:cpu[3]tick_sched info:[idle_active:1][idle_entrytime:877900502450]

As above, values obtained from get_cpu_idle_time_us_raw remain constant, while values
from get_cpu_idle_time_us continue to increase.

Since the CPU is already offline, the statistics for any CPU might stop increasing as well?

The following /proc/stat statistics are 'just before the CPU went offline' and 'just after
bringing all CPUs back online', all CPUs are offline except CPU0:

'just before the CPU went offline':
cpu  444829 5 254942 6833361 782 49798 20514 0 0 0
cpu0 68788 1 54126 636019 202 10827 3059 0 0 0
cpu1 58191 0 30832 303281 24 6896 1677 0 0 0
cpu2 7770 0 8268 380039 31 1826 1022 0 0 0
cpu3 7954 0 7476 381024 30 1776 976 0 0 0
cpu4 8319 0 6557 382425 48 1713 805 0 0 0
cpu5 8526 0 5791 383103 37 1681 811 0 0 0
cpu6 22202 0 10746 361746 37 1872 729 0 0 0
cpu7 35019 0 23848 330534 32 3873 1757 0 0 0
cpu8 35065 1 23654 330980 16 3859 1690 0 0 0
cpu9 1065 0 4302 395611 48 1290 861 0 0 0
cpu10 38462 0 12500 362772 19 1879 801 0 0 0
cpu11 37863 0 11913 363654 26 1843 567 0 0 0
cpu12 37717 0 10885 364177 25 1792 845 0 0 0
cpu13 37338 0 10219 365103 32 1763 646 0 0 0
cpu14 14212 0 10272 370534 34 1818 1384 0 0 0
cpu15 1677 0 7933 391188 51 1501 1557 0 0 0
cpu16 9744 0 5015 375124 21 1687 708 0 0 0
cpu17 14908 0 10597 356039 61 1894 611 0 0 0

'just after bringing all CPUs back online':
cpu  447782 5 257163 6861054 797 50101 20624 0 0 0
cpu0 70102 1 55738 661461 215 11111 3163 0 0 0
cpu1 58283 0 30873 303386 26 6897 1677 0 0 0
cpu2 7869 0 8301 380147 31 1828 1022 0 0 0
cpu3 8063 0 7510 381130 30 1777 976 0 0 0
cpu4 8417 0 6594 382540 48 1714 805 0 0 0
cpu5 8605 0 5849 383217 37 1682 811 0 0 0
cpu6 22300 0 10779 361869 37 1874 730 0 0 0
cpu7 35105 0 23897 330659 32 3874 1757 0 0 0
cpu8 35168 1 23694 331102 16 3860 1690 0 0 0
cpu9 1154 0 4338 395750 48 1291 862 0 0 0
cpu10 38565 0 12527 362908 19 1880 801 0 0 0
cpu11 37956 0 11943 363799 26 1844 567 0 0 0
cpu12 37835 0 10901 364316 25 1793 845 0 0 0
cpu13 37410 0 10278 365250 32 1764 646 0 0 0
cpu14 14326 0 10291 370686 34 1819 1385 0 0 0
cpu15 1767 0 7964 391349 51 1502 1560 0 0 0
cpu16 9860 0 5036 375275 21 1688 708 0 0 0
cpu17 14989 0 10641 356203 61 1895 611 0 0 0

As we can see, current implementation of cpu statistics come to a halt when cpu offline.


So, can we keep the current patch as it is, or use a different name, such as get_cpu_idle_time_us_halt?


--
Xin Zhao


