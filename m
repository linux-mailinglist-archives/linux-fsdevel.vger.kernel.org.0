Return-Path: <linux-fsdevel+bounces-72098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17436CDE521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 05:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54307300F9CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF2248F7C;
	Fri, 26 Dec 2025 04:34:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27A800;
	Fri, 26 Dec 2025 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=221.12.31.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766723695; cv=none; b=tV1W4OrPLMASE5XwG9hxX91pkoKrv2HhBD/IIW76J4xw5wNipWj/puaEuzPJQGyw38ciCbw3UZFtFr7SQWAgL3iYxAw8ZoELqVTZn1el0uee3DyYbR01ciqE4HVCGevfqQhxXJFcFanN/LKzAx2P0IYMo9mIswmRoCdOVag3WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766723695; c=relaxed/simple;
	bh=kAflsedmPoklNnX6M7a3gucLcd5yQcWe/35MCeVdjqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aR1cOzK0Fl4NR6nXW/RwaaYJT+LHI5FoZCc7x+lV1E96qV3+1pAIN/Q4FXmFhou5d2LbBADL00GbXY0JZ+L1igMr7DHmx2xJRlEk6DHH/GKSwn2L4SESAXVcLy5X0VkLwy8eOkcy6W/q7ibtPP7OqKpKdeUuBsHBgnu1YgSDiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=221.12.31.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 5BQ4YYHG015666;
	Fri, 26 Dec 2025 12:34:34 +0800 (+08)
	(envelope-from ning.le@h3c.com)
Received: from DAG6EX08-BJD.srv.huawei-3com.com (unknown [10.153.34.10])
	by mail.maildlp.com (Postfix) with ESMTP id AB9A320051E3;
	Fri, 26 Dec 2025 12:43:26 +0800 (CST)
Received: from localhost.localdomain (10.114.186.44) by
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Fri, 26 Dec 2025 12:34:33 +0800
From: ningle <ning.le@h3c.com>
To: <corbet@lwn.net>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <zhang.chunA@h3c.com>,
        ningle <ning.le@h3c.com>
Subject: [PATCH] Subject: [PATCH] proc/stat: document uptime-based CPU utilization calculation
Date: Fri, 26 Dec 2025 12:34:09 +0800
Message-ID: <20251226043409.1063711-1-ning.le@h3c.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX08-BJD.srv.huawei-3com.com (10.153.34.10)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 5BQ4YYHG015666

Many userspace tools derive CPU utilization from /proc/stat by taking
deltas between successive samples of the per-CPU time fields and using
the sum of all field deltas as the total time window.

On systems where CPU time accounting (including idle) is tick based and
derived from jiffies (e.g. CONFIG_NO_HZ is disabled), this method is
internally consistent: both the numerator and the denominator are based
on the same tick granularity, and the sampling interval is implicitly
defined by how many ticks were accounted.

In practice, several issues show up:

  - userspace sampling timers are often configured with periods that are
    an integer multiple of the kernel tick; when the workload pattern
    has a similar period and aligns with the tick, individual ticks can
    be charged as fully busy if they hit short non-idle sections, even
    if the CPU was idle for most of that tick;

  - on CONFIG_HZ=1000 systems, a common 1 ms userspace sampling timer
    effectively samples at tick granularity; for very short or bursty
    workloads the reported utilization in a given window can differ
    significantly from the average depending on alignment;

  - scheduler delays and timer jitter can cause the actual sampling
    interval to deviate from the nominal one (e.g. 1 s), which leads to
    unstable utilization readings between consecutive samples, even if
    the underlying workload is relatively stable.

The inaccuracy and instability of short-window measurements can result
in misinterpretation of CPU load in production environments. In many
deployments, advanced tracing tools (such as eBPF-based profilers) are
not always available or desirable for continuous monitoring, so a simple
but well-defined userspace method is useful.

Modern kernels also provide:

  - wall-clock time since boot via CLOCK_BOOTTIME and /proc/uptime;
  - high-resolution CPU time accounting (including idle/iowait) when
    NOHZ and virtual CPU accounting are enabled.

Userspace can use these facilities to obtain more accurate and more
stable CPU utilization over arbitrary intervals, including short ones.

This patch extends the /proc/stat documentation with:

  - a description of the traditional jiffy-delta method and the
    assumptions under which it is appropriate;

  - a recommended pattern for using CLOCK_BOOTTIME (or /proc/uptime)
    together with idle/iowait deltas from /proc/stat on systems with
    high-resolution CPU accounting, to improve robustness of CPU
    utilization reporting in production environments;

  - a note about possible vendor-specific extensions that add an
    in-kernel timestamp to /proc/stat to reduce the impact of userspace
    scheduling latency, while documenting that upstream kernels do not
    currently expose such a field.

The patch only updates documentation and does not change any ABI.

Signed-off-by: ningle <ning.le@h3c.com>
---
 Documentation/filesystems/proc.rst | 162 +++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e..90a83c334 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1619,6 +1619,168 @@ of the possible system softirqs. The first column is the total of all
 softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
+CPU utilization and sampling interval
+-------------------------------------
+
+Many userspace tools compute CPU utilization from the ``cpu`` lines in
+``/proc/stat`` by taking deltas between two samples and using the sum
+of all CPU time deltas as the total time window. A typical
+implementation looks like::
+
+  read /proc/stat -> user1, nice1, system1, idle1, iowait1, ...
+  sleep(1)
+  read /proc/stat -> user2, nice2, system2, idle2, iowait2, ...
+
+  delta_user   = user2   - user1
+  delta_idle   = idle2   - idle1
+  delta_iowait = iowait2 - iowait1
+  delta_total  = sum(all fields2) - sum(all fields1)
+
+  utilization  = (delta_total - delta_idle - delta_iowait) / delta_total
+
+On systems where CPU time accounting (including idle) is tick based and
+derived from jiffies (for example, when CONFIG_NO_HZ is disabled),
+``delta_total`` is effectively the number of timer ticks charged to
+this CPU over the sampling interval. In that case this method is
+internally consistent: both the numerator and denominator are based on
+the same tick granularity, and the sampling interval is implicitly
+defined by how many ticks were accounted. For purely tick-based
+accounting this is a reasonable way to report utilization.
+
+This scheme has some limitations:
+
+  - the resolution of the measurement is limited by the tick interval
+    (for example, HZ=1000 gives 1ms granularity), so very short or
+    bursty workloads can be significantly distorted by how they align
+    with the timer tick;
+
+  - userspace sampling periods are often configured as integer
+    multiples of the kernel tick; if short bursts of activity happen
+    to align with the tick, entire ticks can be accounted as busy even
+    if the CPU was idle for most of the tick, which can cause large
+    deviations between short-window utilization and the long-term
+    average;
+
+  - it does not make use of higher-resolution accounting that is
+    available when NOHZ and virtual CPU accounting are enabled.
+
+Modern kernels provide primitives that userspace can use to improve CPU
+utilization estimates:
+
+  - wall-clock time since boot can be obtained from ``clock_gettime()``
+    with CLOCK_BOOTTIME, or from ``/proc/uptime``;
+
+  - when NOHZ and virtual CPU accounting (CONFIG_VIRT_CPU_ACCOUNTING_*)
+    are enabled, CPU time (including idle and iowait) is typically
+    accounted using high-resolution time sources in the scheduler and
+    accounting code, rather than relying solely on periodic timer ticks.
+    This makes idle accounting much more precise than in purely
+    jiffies-based setups.
+
+Userspace can check which accounting mode is in use, for example by
+inspecting the kernel configuration (CONFIG_NO_HZ,
+CONFIG_VIRT_CPU_ACCOUNTING_*) or, at runtime, via
+``/sys/devices/system/cpu/nohz_full`` and related interfaces. On
+systems without virtual CPU accounting and without NOHZ, CPU time is
+typically accounted purely in jiffies, and the traditional jiffy-delta
+method described above remains appropriate. On systems with
+high-resolution CPU accounting, a different pattern can provide more
+accurate results.
+
+Recommended userspace pattern with precise idle accounting
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When NOHZ and virtual CPU accounting are enabled and idle/iowait are
+accounted independently of the periodic tick, a more robust way to
+derive CPU utilization over an interval is:
+
+  - measure the elapsed wall-clock time using CLOCK_BOOTTIME (or
+    ``/proc/uptime``);
+
+  - obtain per-CPU (or global) idle and iowait counters from
+    ``/proc/stat`` at the beginning and end of the interval;
+
+  - compute the idle fraction from these counters, and treat the
+    remaining time as busy.
+
+In pseudocode::
+
+  t1 = clock_gettime(CLOCK_BOOTTIME)
+  read /proc/stat -> idle1, iowait1, user1, nice1, system1, ...
+  ...
+  t2 = clock_gettime(CLOCK_BOOTTIME)
+  read /proc/stat -> idle2, iowait2, user2, nice2, system2, ...
+
+  delta_t_ns    = t2 - t1
+  delta_idle    = (idle2 + iowait2) - (idle1 + iowait1)
+  delta_user    = user2  - user1
+  delta_nice    = nice2  - nice1
+  delta_system  = system2- system1
+
+  /* convert CPU time counters (in USER_HZ) to nanoseconds */
+  idle_ns       = delta_idle   * (NSEC_PER_SEC / USER_HZ)
+  user_ns       = delta_user   * (NSEC_PER_SEC / USER_HZ)
+  nice_ns       = delta_nice   * (NSEC_PER_SEC / USER_HZ)
+  system_ns     = delta_system * (NSEC_PER_SEC / USER_HZ)
+
+  total_window  = delta_t_ns
+  idle_window   = min_t(u64, idle_ns, total_window)
+  busy_window   = (total_window > idle_window) ?
+                  (total_window - idle_window) : 0;
+
+  /* overall CPU utilization over [t1, t2] */
+  utilization   = busy_window * 100 / total_window;
+
+  /*
+   * Optionally, distribute the busy time over user/nice/system/... in
+   * proportion to their deltas:
+   */
+  sum_nonidle_ns = user_ns + nice_ns + system_ns + ...;
+  if (sum_nonidle_ns) {
+          user_share   = busy_window * user_ns   / sum_nonidle_ns;
+          system_share = busy_window * system_ns / sum_nonidle_ns;
+          ...
+  }
+
+This approach:
+
+  - uses the actual elapsed wall-clock time (delta_t_ns) instead of a
+    nominal sleep interval, so it remains correct even if the sampling
+    task is delayed by the scheduler;
+
+  - leverages precise idle/iowait accounting when CONFIG_NO_HZ and
+    CONFIG_VIRT_CPU_ACCOUNTING_* are enabled;
+
+  - allows userspace to fall back to the traditional jiffy-based method
+    on systems where CPU time is still accounted purely in jiffies.
+
+Private extensions and in-kernel timestamps
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The scheme above relies on userspace pairing a timestamp obtained via
+CLOCK_BOOTTIME (or ``/proc/uptime``) with a read of ``/proc/stat``.
+On upstream kernels this is the recommended and portable approach.
+
+For environments that ship a custom kernel and control both kernel and
+userspace, it is also possible to reduce the impact of userspace
+scheduling latency even further by exposing an in-kernel timestamp
+directly in ``/proc/stat``. For example, a vendor-specific kernel could
+add a line such as::
+
+  timestamp_boottime <ticks_since_boot>
+
+where ``<ticks_since_boot>`` is derived from the boottime clock
+(CLOCK_BOOTTIME) and reported in the same USER_HZ units as the CPU time
+fields. The timestamp would be generated in ``show_stat()`` alongside
+the CPU counters, so that userspace can treat all values as a
+consistent snapshot taken at the same time.
+
+Such an extension can help tools compute the elapsed time window as the
+difference between two ``timestamp_boottime`` values without relying on
+separate syscalls, and can make CPU utilization accounting more robust
+on heavily loaded systems. However, any new field in ``/proc/stat`` is
+a kernel ABI change and must be introduced with care: the upstream
+kernel currently does not expose such a timestamp.
 
 1.8 Ext4 file system parameters
 -------------------------------
-- 
2.33.0


