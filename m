Return-Path: <linux-fsdevel+bounces-44998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7FA6FF04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE147A55AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8C2857F1;
	Tue, 25 Mar 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXHVR37B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CA25A2A0;
	Tue, 25 Mar 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905573; cv=none; b=PbOYDN4UXO5UFlr88bNL+emUT1hOyjG2X17rsiXTjLxqercHJ9fOWyXrlwHOUVB5IaUBzLH19Sm0b4nspzwniNko3aBGs3McRQQQfYuGfuWWxZWsqwTRzyz15N+n1DLFFJrzeefcLjIGtZYRFArP64b7fWxcvGy3CZVfa/J3jjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905573; c=relaxed/simple;
	bh=yrVg1aQo8nvzx1orbzCiGBpDINXbK2p/bzc74O/ZG7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpxTMCcj04DsTcesaA056UJfqKRw3AVdLwk6VTdznUeWKDzb3c5l8o1/fMONEj9Hs6NZuwbQoXbK2769ZgmmNhhg20cpi5pflCH5VrZvnnXOHDqy/eew8+Px0XPctfXQUB6lnH1if/zWcj8F1Wd1zcgKL2JOBWLiUNnAf8RjpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXHVR37B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA822C4CEE9;
	Tue, 25 Mar 2025 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905572;
	bh=yrVg1aQo8nvzx1orbzCiGBpDINXbK2p/bzc74O/ZG7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXHVR37BYjtnP226wRmqGD/+5q9LGrYaanpzXXOav8r/BHJV5tQivSCfdRSIzthse
	 8trpo5JD1iz/5OecDTcnupCBJBQX33vaw/hAbD4qk4LeJVqvqHHpw9NHBT1ZFlMkn0
	 uCFXCw3w+yxAMYAhQHMWBx2FPCBEyeY1A19l2GvG5jVXNeDCNpsZ+dZy8FBqDa7uo/
	 Zsma4xcYZbwnzagW4sOr51uBOwZp+LjobLSp/6HGruAVKHWCA8RItDHKa1cnmepcuH
	 KTSRJuNlahXURYcKWJr2ZhoKXLWH1u/JzJrtINfTgSwDQFMRVa5eB4TERwwIW5IXtr
	 Utc6YiuHqvQsA==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 39/43] rv64ilp32_abi: sysinfo: Adapt sysinfo structure to lp64 uapi
Date: Tue, 25 Mar 2025 08:16:20 -0400
Message-Id: <20250325121624.523258-40-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The RISC-V 64ilp32 ABI leverages LP64 uapi and accommodates LP64
ABI userspace directly, necessitating updates to the sysinfo
struct's unsigned long and array types with u64.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 fs/proc/loadavg.c             | 10 +++++++---
 include/linux/sched/loadavg.h |  4 ++++
 include/uapi/linux/sysinfo.h  | 20 ++++++++++++++++++++
 kernel/sched/loadavg.c        |  4 ++++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
index 817981e57223..643e06de3446 100644
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -13,14 +13,18 @@
 
 static int loadavg_proc_show(struct seq_file *m, void *v)
 {
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+	unsigned long long avnrun[3];
+#else
 	unsigned long avnrun[3];
+#endif
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
 	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
-		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
-		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
-		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
+		LOAD_INT((ulong)avnrun[0]), LOAD_FRAC((ulong)avnrun[0]),
+		LOAD_INT((ulong)avnrun[1]), LOAD_FRAC((ulong)avnrun[1]),
+		LOAD_INT((ulong)avnrun[2]), LOAD_FRAC((ulong)avnrun[2]),
 		nr_running(), nr_threads,
 		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
index 83ec54b65e79..8f2d6a827ee9 100644
--- a/include/linux/sched/loadavg.h
+++ b/include/linux/sched/loadavg.h
@@ -13,7 +13,11 @@
  *    11 bit fractions.
  */
 extern unsigned long avenrun[];		/* Load averages */
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+extern void get_avenrun(unsigned long long *loads, unsigned long offset, int shift);
+#else
 extern void get_avenrun(unsigned long *loads, unsigned long offset, int shift);
+#endif
 
 #define FSHIFT		11		/* nr of bits of precision */
 #define FIXED_1		(1<<FSHIFT)	/* 1.0 as fixed-point */
diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
index 435d5c23f0c0..cd29a3d3cd10 100644
--- a/include/uapi/linux/sysinfo.h
+++ b/include/uapi/linux/sysinfo.h
@@ -5,6 +5,25 @@
 #include <linux/types.h>
 
 #define SI_LOAD_SHIFT	16
+
+#if (__riscv_xlen == 64) && (__BITS_PER_LONG == 32)
+struct sysinfo {
+	__s64 uptime;		/* Seconds since boot */
+	__u64 loads[3];		/* 1, 5, and 15 minute load averages */
+	__u64 totalram;		/* Total usable main memory size */
+	__u64 freeram;		/* Available memory size */
+	__u64 sharedram;	/* Amount of shared memory */
+	__u64 bufferram;	/* Memory used by buffers */
+	__u64 totalswap;	/* Total swap space size */
+	__u64 freeswap;		/* swap space still available */
+	__u16 procs;	   	/* Number of current processes */
+	__u16 pad;	   	/* Explicit padding for m68k */
+	__u64 totalhigh;	/* Total high memory size */
+	__u64 freehigh;		/* Available high memory size */
+	__u32 mem_unit;		/* Memory unit size in bytes */
+	char _f[20-2*sizeof(__u64)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
+};
+#else
 struct sysinfo {
 	__kernel_long_t uptime;		/* Seconds since boot */
 	__kernel_ulong_t loads[3];	/* 1, 5, and 15 minute load averages */
@@ -21,5 +40,6 @@ struct sysinfo {
 	__u32 mem_unit;			/* Memory unit size in bytes */
 	char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
 };
+#endif
 
 #endif /* _LINUX_SYSINFO_H */
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b856a2..f1f5abc64dea 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -68,7 +68,11 @@ EXPORT_SYMBOL(avenrun); /* should be removed */
  *
  * These values are estimates at best, so no need for locking.
  */
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+void get_avenrun(unsigned long long *loads, unsigned long offset, int shift)
+#else
 void get_avenrun(unsigned long *loads, unsigned long offset, int shift)
+#endif
 {
 	loads[0] = (avenrun[0] + offset) << shift;
 	loads[1] = (avenrun[1] + offset) << shift;
-- 
2.40.1


