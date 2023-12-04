Return-Path: <linux-fsdevel+bounces-4748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02728802D43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F631F2111B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99452FC1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kx/nqCFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985931A6;
	Sun,  3 Dec 2023 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=OvGfsmYmDAUZa6ocEzDc9Q0JwNuefDI0e0GVlm7Gr0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kx/nqCFMsMCL6699FSDK+mRcHNyYAVlRU3oC2+8qyqMN9L26SojjIxxdZ+bZRVx9a
	 27voqrV2g1o2Ks7cJ3Es/9Y1+GBAlf1JoKvLDaWiFDQJTUjQcphQe/mNvxfG48X+Va
	 N6GzC/8jdzO955Vne/pm9tP+9K0k2QQc9jX2xEhc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:25 +0100
Subject: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table argument
 of handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=111769;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OvGfsmYmDAUZa6ocEzDc9Q0JwNuefDI0e0GVlm7Gr0M=;
 b=jq2zmmtAXBECFe4vLj3r1vjkTWXmPNrw5AV8CuDReYJ7wAHpn5WneJChogTrGmobgnvanHT6D
 8MKI3nivq1yDjfwDQ4CHIWhW2wVjVVSf0qzYOBVoULpAGOU8wx2aKBP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that adapt all the proc
handlers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/arm64/kernel/armv8_deprecated.c      |  2 +-
 arch/arm64/kernel/fpsimd.c                |  2 +-
 arch/s390/appldata/appldata_base.c        |  8 +--
 arch/s390/kernel/debug.c                  |  2 +-
 arch/s390/kernel/topology.c               |  2 +-
 arch/s390/mm/cmm.c                        |  6 +--
 arch/x86/kernel/itmt.c                    |  2 +-
 drivers/cdrom/cdrom.c                     |  4 +-
 drivers/char/random.c                     |  4 +-
 drivers/macintosh/mac_hid.c               |  2 +-
 drivers/net/vrf.c                         |  2 +-
 drivers/parport/procfs.c                  | 12 ++---
 fs/coredump.c                             |  2 +-
 fs/dcache.c                               |  4 +-
 fs/drop_caches.c                          |  2 +-
 fs/exec.c                                 |  4 +-
 fs/file_table.c                           |  2 +-
 fs/fs-writeback.c                         |  2 +-
 fs/inode.c                                |  4 +-
 fs/pipe.c                                 |  2 +-
 fs/quota/dquot.c                          |  2 +-
 fs/xfs/xfs_sysctl.c                       |  6 +--
 include/linux/ftrace.h                    |  4 +-
 include/linux/mm.h                        |  8 +--
 include/linux/perf_event.h                |  6 +--
 include/linux/security.h                  |  2 +-
 include/linux/sysctl.h                    | 36 +++++++-------
 include/linux/vmstat.h                    |  6 +--
 include/linux/writeback.h                 |  2 +-
 include/net/ndisc.h                       |  2 +-
 include/net/neighbour.h                   |  6 +--
 include/net/netfilter/nf_hooks_lwtunnel.h |  2 +-
 ipc/ipc_sysctl.c                          |  8 +--
 kernel/bpf/syscall.c                      |  4 +-
 kernel/delayacct.c                        |  4 +-
 kernel/events/callchain.c                 |  2 +-
 kernel/events/core.c                      |  4 +-
 kernel/fork.c                             |  2 +-
 kernel/hung_task.c                        |  4 +-
 kernel/kexec_core.c                       |  2 +-
 kernel/kprobes.c                          |  2 +-
 kernel/latencytop.c                       |  4 +-
 kernel/pid_namespace.c                    |  2 +-
 kernel/pid_sysctl.h                       |  2 +-
 kernel/printk/internal.h                  |  2 +-
 kernel/printk/printk.c                    |  2 +-
 kernel/printk/sysctl.c                    |  5 +-
 kernel/sched/core.c                       |  8 +--
 kernel/sched/rt.c                         | 12 ++---
 kernel/sched/topology.c                   |  2 +-
 kernel/seccomp.c                          |  4 +-
 kernel/stackleak.c                        |  2 +-
 kernel/sysctl.c                           | 82 +++++++++++++++----------------
 kernel/time/timer.c                       |  2 +-
 kernel/trace/ftrace.c                     |  2 +-
 kernel/trace/trace.c                      |  2 +-
 kernel/trace/trace_events_user.c          |  2 +-
 kernel/trace/trace_stack.c                |  2 +-
 kernel/umh.c                              |  2 +-
 kernel/utsname_sysctl.c                   |  2 +-
 kernel/watchdog.c                         | 15 +++---
 mm/compaction.c                           |  8 +--
 mm/hugetlb.c                              |  6 +--
 mm/page-writeback.c                       | 18 +++----
 mm/page_alloc.c                           | 22 ++++-----
 mm/util.c                                 | 12 ++---
 mm/vmstat.c                               |  4 +-
 net/bridge/br_netfilter_hooks.c           |  2 +-
 net/core/neighbour.c                      | 24 ++++-----
 net/core/sysctl_net_core.c                | 20 ++++----
 net/ipv4/devinet.c                        |  6 +--
 net/ipv4/route.c                          |  2 +-
 net/ipv4/sysctl_net_ipv4.c                | 33 +++++++------
 net/ipv6/addrconf.c                       | 27 +++++-----
 net/ipv6/ndisc.c                          |  4 +-
 net/ipv6/route.c                          |  2 +-
 net/ipv6/sysctl_net_ipv6.c                |  4 +-
 net/mpls/af_mpls.c                        |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c            | 16 +++---
 net/netfilter/nf_conntrack_standalone.c   |  2 +-
 net/netfilter/nf_hooks_lwtunnel.c         |  2 +-
 net/netfilter/nf_log.c                    |  2 +-
 net/phonet/sysctl.c                       |  2 +-
 net/rds/tcp.c                             |  4 +-
 net/sctp/sysctl.c                         | 28 +++++------
 net/sunrpc/sysctl.c                       |  6 +--
 net/sunrpc/xprtrdma/svc_rdma.c            |  2 +-
 security/apparmor/lsm.c                   |  2 +-
 security/min_addr.c                       |  2 +-
 security/yama/yama_lsm.c                  |  2 +-
 90 files changed, 306 insertions(+), 302 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index dd6ce86d4332..a3085cb68852 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -504,7 +504,7 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
 	return ret;
 }
 
-static int emulation_proc_handler(struct ctl_table *table, int write,
+static int emulation_proc_handler(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp,
 				  loff_t *ppos)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1559c706d32d..2b947031cd0e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -555,7 +555,7 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 #if defined(CONFIG_ARM64_SVE) && defined(CONFIG_SYSCTL)
 
-static int vec_proc_do_default_vl(struct ctl_table *table, int write,
+static int vec_proc_do_default_vl(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct vl_info *info = table->extra1;
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index c2978cb03b36..2bd253623be1 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -46,9 +46,9 @@
  * /proc entries (sysctl)
  */
 static const char appldata_proc_name[APPLDATA_PROC_NAME_LENGTH] = "appldata";
-static int appldata_timer_handler(struct ctl_table *ctl, int write,
+static int appldata_timer_handler(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos);
-static int appldata_interval_handler(struct ctl_table *ctl, int write,
+static int appldata_interval_handler(const struct ctl_table *ctl, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos);
 
 static struct ctl_table_header *appldata_sysctl_header;
@@ -199,7 +199,7 @@ static void __appldata_vtimer_setup(int cmd)
  * Start/Stop timer, show status of timer (0 = not active, 1 = active)
  */
 static int
-appldata_timer_handler(struct ctl_table *ctl, int write,
+appldata_timer_handler(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int timer_active = appldata_timer_active;
@@ -232,7 +232,7 @@ appldata_timer_handler(struct ctl_table *ctl, int write,
  * current timer interval.
  */
 static int
-appldata_interval_handler(struct ctl_table *ctl, int write,
+appldata_interval_handler(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int interval = appldata_interval;
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 85328a0ef3b6..bce50ca75ea7 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -954,7 +954,7 @@ static int debug_active = 1;
  * always allow read, allow write only if debug_stoppable is set or
  * if debug_active is already off
  */
-static int s390dbf_procactive(struct ctl_table *table, int write,
+static int s390dbf_procactive(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!write || debug_stoppable || !debug_active)
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 89e91b8ce842..1df3dc118696 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -600,7 +600,7 @@ static int __init topology_setup(char *str)
 }
 early_param("topology", topology_setup);
 
-static int topology_ctl_handler(struct ctl_table *ctl, int write,
+static int topology_ctl_handler(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int enabled = topology_is_enabled();
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index f8b13f247646..1d6749e095f7 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -243,7 +243,7 @@ static int cmm_skip_blanks(char *cp, char **endp)
 	return str != cp;
 }
 
-static int cmm_pages_handler(struct ctl_table *ctl, int write,
+static int cmm_pages_handler(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long nr = cmm_get_pages();
@@ -262,7 +262,7 @@ static int cmm_pages_handler(struct ctl_table *ctl, int write,
 	return 0;
 }
 
-static int cmm_timed_pages_handler(struct ctl_table *ctl, int write,
+static int cmm_timed_pages_handler(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp,
 				   loff_t *ppos)
 {
@@ -282,7 +282,7 @@ static int cmm_timed_pages_handler(struct ctl_table *ctl, int write,
 	return 0;
 }
 
-static int cmm_timeout_handler(struct ctl_table *ctl, int write,
+static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char buf[64], *p;
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9a7c03d47861..51b805c727fc 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -38,7 +38,7 @@ static bool __read_mostly sched_itmt_capable;
  */
 unsigned int __read_mostly sysctl_sched_itmt_enabled;
 
-static int sched_itmt_update_handler(struct ctl_table *table, int write,
+static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int old_sysctl;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a5e07270e0d4..d0bd64129d43 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3473,7 +3473,7 @@ static int cdrom_print_info(const char *header, int val, char *info,
 	return 0;
 }
 
-static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
+static int cdrom_sysctl_info(const struct ctl_table *ctl, int write,
                            void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
@@ -3586,7 +3586,7 @@ static void cdrom_update_settings(void)
 	mutex_unlock(&cdrom_mutex);
 }
 
-static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
+static int cdrom_sysctl_handler(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4a9c79391dee..04b224bffbdd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1606,7 +1606,7 @@ static u8 sysctl_bootid[UUID_SIZE];
  * UUID. The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
  */
-static int proc_do_uuid(struct ctl_table *table, int write, void *buf,
+static int proc_do_uuid(const struct ctl_table *table, int write, void *buf,
 			size_t *lenp, loff_t *ppos)
 {
 	u8 tmp_uuid[UUID_SIZE], *uuid;
@@ -1637,7 +1637,7 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buf,
 }
 
 /* The same as proc_dointvec, but writes don't change anything. */
-static int proc_do_rointvec(struct ctl_table *table, int write, void *buf,
+static int proc_do_rointvec(const struct ctl_table *table, int write, void *buf,
 			    size_t *lenp, loff_t *ppos)
 {
 	return write ? 0 : proc_dointvec(table, 0, buf, lenp, ppos);
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 1ae3539beff5..891047c8a110 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -182,7 +182,7 @@ static void mac_hid_stop_emulation(void)
 	mac_hid_destroy_emumouse();
 }
 
-static int mac_hid_toggle_emumouse(struct ctl_table *table, int write,
+static int mac_hid_toggle_emumouse(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = table->data;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 66f8542f3b18..14c5efd234ad 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1908,7 +1908,7 @@ static int vrf_strict_mode_change(struct vrf_map *vmap, bool new_mode)
 	return res;
 }
 
-static int vrf_shared_table_handler(struct ctl_table *table, int write,
+static int vrf_shared_table_handler(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)table->extra1;
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..efa7c90e4234 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -33,7 +33,7 @@
 #define PARPORT_MIN_SPINTIME_VALUE 1
 #define PARPORT_MAX_SPINTIME_VALUE 1000
 
-static int do_active_device(struct ctl_table *table, int write,
+static int do_active_device(const struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
@@ -70,7 +70,7 @@ static int do_active_device(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_PARPORT_1284
-static int do_autoprobe(struct ctl_table *table, int write,
+static int do_autoprobe(const struct ctl_table *table, int write,
 			void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport_device_info *info = table->extra2;
@@ -113,7 +113,7 @@ static int do_autoprobe(struct ctl_table *table, int write,
 }
 #endif /* IEEE1284.3 support. */
 
-static int do_hardware_base_addr(struct ctl_table *table, int write,
+static int do_hardware_base_addr(const struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
@@ -140,7 +140,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int do_hardware_irq(struct ctl_table *table, int write,
+static int do_hardware_irq(const struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
@@ -167,7 +167,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int do_hardware_dma(struct ctl_table *table, int write,
+static int do_hardware_dma(const struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
@@ -194,7 +194,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int do_hardware_modes(struct ctl_table *table, int write,
+static int do_hardware_modes(const struct ctl_table *table, int write,
 			     void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
diff --git a/fs/coredump.c b/fs/coredump.c
index 9d235fa14ab9..51283a671921 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -949,7 +949,7 @@ void validate_coredump_safety(void)
 	}
 }
 
-static int proc_dostring_coredump(struct ctl_table *table, int write,
+static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error = proc_dostring(table, write, buffer, lenp, ppos);
diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..0ea86ad6cedf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -174,8 +174,8 @@ static long get_nr_dentry_negative(void)
 	return sum < 0 ? 0 : sum;
 }
 
-static int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
-			  size_t *lenp, loff_t *ppos)
+static int proc_nr_dentry(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	dentry_stat.nr_dentry = get_nr_dentry();
 	dentry_stat.nr_unused = get_nr_dentry_unused();
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index b9575957a7c2..d45ef541d848 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -48,7 +48,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	iput(toput_inode);
 }
 
-int drop_caches_sysctl_handler(struct ctl_table *table, int write,
+int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
diff --git a/fs/exec.c b/fs/exec.c
index 4aa19b24f281..e3d124206020 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2145,8 +2145,8 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 
 #ifdef CONFIG_SYSCTL
 
-static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_coredump(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..bab68d672e33 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(get_max_files);
 /*
  * Handle nr_files sysctl
  */
-static int proc_nr_files(struct ctl_table *table, int write, void *buffer,
+static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
 			 size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1767493dffda..a66c9d0556dc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2379,7 +2379,7 @@ static int __init start_dirtytime_writeback(void)
 }
 __initcall(start_dirtytime_writeback);
 
-int dirtytime_interval_handler(struct ctl_table *table, int write,
+int dirtytime_interval_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/fs/inode.c b/fs/inode.c
index f238d987dec9..76cf31ef25c8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -106,8 +106,8 @@ long get_nr_dirty_inodes(void)
  */
 static struct inodes_stat_t inodes_stat;
 
-static int proc_nr_inodes(struct ctl_table *table, int write, void *buffer,
-			  size_t *lenp, loff_t *ppos)
+static int proc_nr_inodes(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	inodes_stat.nr_inodes = get_nr_inodes();
 	inodes_stat.nr_unused = get_nr_inodes_unused();
diff --git a/fs/pipe.c b/fs/pipe.c
index 804a7d789452..1dc57b4a283a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1468,7 +1468,7 @@ static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
 	return 0;
 }
 
-static int proc_dopipe_max_size(struct ctl_table *table, int write,
+static int proc_dopipe_max_size(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 58b5de081b57..d1a6511e48dc 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2887,7 +2887,7 @@ const struct quotactl_ops dquot_quotactl_sysfile_ops = {
 };
 EXPORT_SYMBOL(dquot_quotactl_sysfile_ops);
 
-static int do_proc_dqstats(struct ctl_table *table, int write,
+static int do_proc_dqstats(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int type = (unsigned long *)table->data - dqstats.stat;
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index fade33735393..2c5adc88a830 100644
--- a/fs/xfs/xfs_sysctl.c
+++ b/fs/xfs/xfs_sysctl.c
@@ -11,7 +11,7 @@ static struct ctl_table_header *xfs_table_header;
 #ifdef CONFIG_PROC_FS
 STATIC int
 xfs_stats_clear_proc_handler(
-	struct ctl_table	*ctl,
+	const struct ctl_table	*ctl,
 	int			write,
 	void			*buffer,
 	size_t			*lenp,
@@ -31,7 +31,7 @@ xfs_stats_clear_proc_handler(
 
 STATIC int
 xfs_panic_mask_proc_handler(
-	struct ctl_table	*ctl,
+	const struct ctl_table	*ctl,
 	int			write,
 	void			*buffer,
 	size_t			*lenp,
@@ -52,7 +52,7 @@ xfs_panic_mask_proc_handler(
 
 STATIC int
 xfs_deprecated_dointvec_minmax(
-	struct ctl_table	*ctl,
+	const struct ctl_table	*ctl,
 	int			write,
 	void			*buffer,
 	size_t			*lenp,
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..3e10fe61c2bf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -470,7 +470,7 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 
 extern int stack_tracer_enabled;
 
-int stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
+int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
 		       size_t *lenp, loff_t *ppos);
 
 /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
@@ -1157,7 +1157,7 @@ extern int tracepoint_printk;
 extern void disable_trace_on_warning(void);
 extern int __disable_trace_on_warning;
 
-int tracepoint_printk_sysctl(struct ctl_table *table, int write,
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos);
 
 #else /* CONFIG_TRACING */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..e95efc7bdc85 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -202,11 +202,11 @@ extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern unsigned long sysctl_overcommit_kbytes;
 
-int overcommit_ratio_handler(struct ctl_table *, int, void *, size_t *,
+int overcommit_ratio_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
+int overcommit_kbytes_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
+int overcommit_policy_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
@@ -3805,7 +3805,7 @@ extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
+int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 #endif
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5547ba68e6e4..a48c183cfbe0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1578,11 +1578,11 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
-int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
+int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
+int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int perf_event_max_stack_handler(struct ctl_table *table, int write,
+int perf_event_max_stack_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 
 /* Access to perf_event_open(2) syscall. */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..d5aca07d5e1d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -223,7 +223,7 @@ struct request_sock;
 #define LSM_UNSAFE_NO_NEW_PRIVS	4
 
 #ifdef CONFIG_MMU
-extern int mmap_min_addr_handler(struct ctl_table *table, int write,
+extern int mmap_min_addr_handler(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 56b89e5294e9..ada36ef8cecb 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -61,31 +61,31 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
-typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
+typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
-int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dobool(struct ctl_table *table, int write, void *buffer,
+int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_douintvec_minmax(struct ctl_table *table, int write, void *buffer,
+int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int proc_dou8vec_minmax(struct ctl_table *table, int write, void *buffer,
+int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
-int proc_dointvec_jiffies(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_dointvec_jiffies(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int proc_dointvec_userhz_jiffies(struct ctl_table *, int, void *, size_t *,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-int proc_dointvec_ms_jiffies(struct ctl_table *, int, void *, size_t *,
+int proc_dointvec_ms_jiffies(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-int proc_doulongvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int, void *,
+int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int, void *,
 		size_t *, loff_t *);
-int proc_do_large_bitmap(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_do_static_key(struct ctl_table *table, int write, void *buffer,
+int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 /*
@@ -243,7 +243,7 @@ extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
 bool sysctl_is_alias(char *param);
-int do_proc_douintvec(struct ctl_table *table, int write,
+int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
 				  unsigned int *valp,
@@ -293,7 +293,7 @@ static inline bool sysctl_is_alias(char *param)
 }
 #endif /* CONFIG_SYSCTL */
 
-int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
+int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 #endif /* _LINUX_SYSCTL_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..267b56b7c56a 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -17,7 +17,7 @@ extern int sysctl_stat_interval;
 #define DISABLE_NUMA_STAT   0
 extern int sysctl_vm_numa_stat;
 DECLARE_STATIC_KEY_TRUE(vm_numa_stat_key);
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
+int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
@@ -301,8 +301,8 @@ void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
 struct ctl_table;
-int vmstat_refresh(struct ctl_table *, int write, void *buffer, size_t *lenp,
-		loff_t *ppos);
+int vmstat_refresh(const struct ctl_table *, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
 
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 083387c00f0c..8dc4d16bb7c3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -344,7 +344,7 @@ extern unsigned int dirty_expire_interval;
 extern unsigned int dirtytime_expire_interval;
 extern int laptop_mode;
 
-int dirtytime_interval_handler(struct ctl_table *table, int write,
+int dirtytime_interval_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 9bbdf6eaa942..7a533d5b1d59 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -486,7 +486,7 @@ void igmp6_event_report(struct sk_buff *skb);
 
 
 #ifdef CONFIG_SYSCTL
-int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write,
+int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0d28172193fa..a44f262a7384 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -412,12 +412,12 @@ void *neigh_seq_start(struct seq_file *, loff_t *, struct neigh_table *,
 void *neigh_seq_next(struct seq_file *, void *, loff_t *);
 void neigh_seq_stop(struct seq_file *, void *);
 
-int neigh_proc_dointvec(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec(const struct ctl_table *ctl, int write,
 			void *buffer, size_t *lenp, loff_t *ppos);
-int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write,
 				void *buffer,
 				size_t *lenp, loff_t *ppos);
-int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec_ms_jiffies(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos);
 
 int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
diff --git a/include/net/netfilter/nf_hooks_lwtunnel.h b/include/net/netfilter/nf_hooks_lwtunnel.h
index 52e27920f829..cef7a4eb8f97 100644
--- a/include/net/netfilter/nf_hooks_lwtunnel.h
+++ b/include/net/netfilter/nf_hooks_lwtunnel.h
@@ -2,6 +2,6 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_SYSCTL
-int nf_hooks_lwtunnel_sysctl_handler(struct ctl_table *table, int write,
+int nf_hooks_lwtunnel_sysctl_handler(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos);
 #endif
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 55d6b9f1e508..d876f96f5992 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -16,8 +16,8 @@
 #include <linux/slab.h>
 #include "util.h"
 
-static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_ipc_dointvec_minmax_orphans(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ipc_namespace *ns =
 		container_of(table->data, struct ipc_namespace, shm_rmid_forced);
@@ -32,7 +32,7 @@ static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 	return err;
 }
 
-static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
+static int proc_ipc_auto_msgmni(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table ipc_table;
@@ -47,7 +47,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
-static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
+static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ipc_namespace *ns =
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..f13daa0916bf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5652,7 +5652,7 @@ const struct bpf_prog_ops bpf_syscall_prog_ops = {
 };
 
 #ifdef CONFIG_SYSCTL
-static int bpf_stats_handler(struct ctl_table *table, int write,
+static int bpf_stats_handler(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
@@ -5687,7 +5687,7 @@ void __weak unpriv_ebpf_notify(int new_state)
 {
 }
 
-static int bpf_unpriv_handler(struct ctl_table *table, int write,
+static int bpf_unpriv_handler(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, unpriv_enable = *(int *)table->data;
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..939c57c30a79 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,8 +44,8 @@ void delayacct_init(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
-		     size_t *lenp, loff_t *ppos)
+static int sysctl_delayacct(const struct ctl_table *table, int write,
+		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int state = delayacct_on;
 	struct ctl_table t;
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..bd5699f869c3 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -229,7 +229,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
  * Used for sysctl_perf_event_max_stack and
  * sysctl_perf_event_max_contexts_per_stack.
  */
-int perf_event_max_stack_handler(struct ctl_table *table, int write,
+int perf_event_max_stack_handler(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *value = table->data;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..cbf0f4dfa4af 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -450,7 +450,7 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
+int perf_event_max_sample_rate_handler(const struct ctl_table *table, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -474,7 +474,7 @@ int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
 
 int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
 
-int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
+int perf_cpu_time_max_percent_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..ce4b220e6ae2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3528,7 +3528,7 @@ int unshare_files(void)
 	return 0;
 }
 
-int sysctl_max_threads(struct ctl_table *table, int write,
+int sysctl_max_threads(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d2..b310a500b7b2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -238,8 +238,8 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 /*
  * Process updating of timeout sysctl
  */
-static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-				  void *buffer,
+static int proc_dohung_task_timeout_secs(const struct ctl_table *table,
+				  int write, void *buffer,
 				  size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..7bb9bf85f058 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -928,7 +928,7 @@ struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
 #ifdef CONFIG_SYSCTL
-static int kexec_limit_handler(struct ctl_table *table, int write,
+static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct kexec_load_limit *limit = table->data;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a0ee40bf66..9e160dd23e61 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -939,7 +939,7 @@ static void unoptimize_all_kprobes(void)
 
 static DEFINE_MUTEX(kprobe_sysctl_mutex);
 static int sysctl_kprobes_optimization;
-static int proc_kprobes_optimization_handler(struct ctl_table *table,
+static int proc_kprobes_optimization_handler(const struct ctl_table *table,
 					     int write, void *buffer,
 					     size_t *length, loff_t *ppos)
 {
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 781249098cb6..e09b935b822c 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -65,8 +65,8 @@ static struct latency_record latency_record[MAXLR];
 int latencytop_enabled;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sysctl_latencytop(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 3028b2218aa4..a1926cf01cfb 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -276,7 +276,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-static int pid_ns_ctl_handler(struct ctl_table *table, int write,
+static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index 2ee41a3a1dfd..a1b47ad10ebc 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -5,7 +5,7 @@
 #include <linux/pid_namespace.h>
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
-static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table,
+static int pid_mfd_noexec_dointvec_minmax(const struct ctl_table *table,
 	int write, void *buf, size_t *lenp, loff_t *ppos)
 {
 	struct pid_namespace *ns = task_active_pid_ns(current);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..19dcc5832651 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -8,7 +8,7 @@
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
-int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
+int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
 #else
 #define printk_sysctl_init() do { } while (0)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..964f0614767b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -197,7 +197,7 @@ __setup("printk.devkmsg=", control_devkmsg);
 
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
-int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
+int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char old_str[DEVKMSG_STR_MAX_SIZE];
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..187b27981111 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -11,8 +11,9 @@
 
 static const int ten_thousand = 10000;
 
-static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table,
+				int write, void *buffer, size_t *lenp,
+				loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..a36419645a62 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1813,7 +1813,7 @@ static void uclamp_sync_util_min_rt_default(void)
 		uclamp_update_util_min_rt_default(p);
 }
 
-static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
@@ -4570,7 +4570,7 @@ static void reset_memory_tiering(void)
 	}
 }
 
-static int sysctl_numa_balancing(struct ctl_table *table, int write,
+static int sysctl_numa_balancing(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4639,8 +4639,8 @@ static int __init setup_schedstats(char *str)
 __setup("schedstats=", setup_schedstats);
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sysctl_schedstats(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int err;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..a972c9601a39 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -26,9 +26,9 @@ int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rt_handler(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rr_handler(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 static struct ctl_table sched_rt_sysctls[] = {
 	{
@@ -2962,8 +2962,8 @@ static void sched_rt_do_global(void)
 	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sched_rt_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
 	static DEFINE_MUTEX(mutex);
@@ -3001,8 +3001,8 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sched_rr_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 	static DEFINE_MUTEX(mutex);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..3e3b69314e30 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -285,7 +285,7 @@ void rebuild_sched_domains_energy(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sched_energy_aware_handler(struct ctl_table *table, int write,
+static int sched_energy_aware_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, state;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index a23672674ff6..95aba3cf6b84 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2413,8 +2413,8 @@ static void audit_actions_logged(u32 actions_logged, u32 old_actions_logged,
 	return audit_seccomp_actions_logged(new, old, !ret);
 }
 
-static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
-					  void *buffer, size_t *lenp,
+static int seccomp_actions_logged_handler(const struct ctl_table *ro_table,
+					  int write, void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index b292e5ca0b7d..95e4a9332599 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -21,7 +21,7 @@
 static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
 #ifdef CONFIG_SYSCTL
-static int stack_erasing_sysctl(struct ctl_table *table, int write,
+static int stack_erasing_sysctl(const struct ctl_table *table, int write,
 			void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..d60daa4e36fc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -205,7 +205,7 @@ static int _proc_do_string(char *data, int maxlen, int write,
 	return 0;
 }
 
-static void warn_sysctl_write(struct ctl_table *table)
+static void warn_sysctl_write(const struct ctl_table *table)
 {
 	pr_warn_once("%s wrote to %s when file position was not 0!\n"
 		"This will not be supported in the future. To silence this\n"
@@ -223,7 +223,7 @@ static void warn_sysctl_write(struct ctl_table *table)
  * handlers can ignore the return value.
  */
 static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
-					   struct ctl_table *table)
+					   const struct ctl_table *table)
 {
 	if (!*ppos)
 		return false;
@@ -256,7 +256,7 @@ static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
  *
  * Returns 0 on success.
  */
-int proc_dostring(struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write)
@@ -468,7 +468,7 @@ static int do_proc_douintvec_conv(unsigned long *lvalp,
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
-static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
+static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
 		  int write, void *buffer,
 		  size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
@@ -541,7 +541,7 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 	return err;
 }
 
-static int do_proc_dointvec(struct ctl_table *table, int write,
+static int do_proc_dointvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
 			      int write, void *data),
@@ -552,7 +552,7 @@ static int do_proc_dointvec(struct ctl_table *table, int write,
 }
 
 static int do_proc_douintvec_w(unsigned int *tbl_data,
-			       struct ctl_table *table,
+			       const struct ctl_table *table,
 			       void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
@@ -639,7 +639,7 @@ static int do_proc_douintvec_r(unsigned int *tbl_data, void *buffer,
 	return err;
 }
 
-static int __do_proc_douintvec(void *tbl_data, struct ctl_table *table,
+static int __do_proc_douintvec(void *tbl_data, const struct ctl_table *table,
 			       int write, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
@@ -675,7 +675,7 @@ static int __do_proc_douintvec(void *tbl_data, struct ctl_table *table,
 	return do_proc_douintvec_r(i, buffer, lenp, ppos, conv, data);
 }
 
-int do_proc_douintvec(struct ctl_table *table, int write,
+int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
 				  unsigned int *valp,
@@ -702,7 +702,7 @@ int do_proc_douintvec(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dobool(struct ctl_table *table, int write, void *buffer,
+int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
@@ -739,7 +739,7 @@ int proc_dobool(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_dointvec(struct ctl_table *table, int write, void *buffer,
+int proc_dointvec(const struct ctl_table *table, int write, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
@@ -758,7 +758,7 @@ int proc_dointvec(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_douintvec(struct ctl_table *table, int write, void *buffer,
+int proc_douintvec(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
@@ -769,7 +769,7 @@ int proc_douintvec(struct ctl_table *table, int write, void *buffer,
  * Taint values can only be increased
  * This means we can safely use a temporary.
  */
-static int proc_taint(struct ctl_table *table, int write,
+static int proc_taint(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -864,7 +864,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  *
  * Returns 0 on success or -EINVAL on write when the range check fails.
  */
-int proc_dointvec_minmax(struct ctl_table *table, int write,
+int proc_dointvec_minmax(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct do_proc_dointvec_minmax_conv_param param = {
@@ -933,7 +933,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
  *
  * Returns 0 on success or -ERANGE on write when the range check fails.
  */
-int proc_douintvec_minmax(struct ctl_table *table, int write,
+int proc_douintvec_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct do_proc_douintvec_minmax_conv_param param = {
@@ -961,7 +961,7 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success or an error on write when the range check fails.
  */
-int proc_dou8vec_minmax(struct ctl_table *table, int write,
+int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
@@ -1004,7 +1004,7 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static int sysrq_sysctl_handler(struct ctl_table *table, int write,
+static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int tmp, ret;
@@ -1023,7 +1023,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif
 
-static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
+static int __do_proc_doulongvec_minmax(void *data, const struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
@@ -1096,7 +1096,7 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 	return err;
 }
 
-static int do_proc_doulongvec_minmax(struct ctl_table *table, int write,
+static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos, unsigned long convmul,
 		unsigned long convdiv)
 {
@@ -1120,7 +1120,7 @@ static int do_proc_doulongvec_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_minmax(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l, 1l);
@@ -1143,7 +1143,7 @@ int proc_doulongvec_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer,
@@ -1264,14 +1264,14 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
  *
  * Returns 0 on success.
  */
-int proc_dointvec_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_jiffies(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_dointvec(table,write,buffer,lenp,ppos,
 		    	    do_proc_dointvec_jiffies_conv,NULL);
 }
 
-int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct do_proc_dointvec_minmax_conv_param param = {
@@ -1297,7 +1297,7 @@ int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
@@ -1320,14 +1320,14 @@ int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_ms_jiffies(struct ctl_table *table, int write, void *buffer,
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
-static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
+static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct pid *new_pid;
@@ -1366,7 +1366,7 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_do_large_bitmap(struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
@@ -1498,85 +1498,85 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
 #else /* CONFIG_PROC_SYSCTL */
 
-int proc_dostring(struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dobool(struct ctl_table *table, int write,
+int proc_dobool(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec(struct ctl_table *table, int write,
+int proc_dointvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_douintvec(struct ctl_table *table, int write,
+int proc_douintvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_minmax(struct ctl_table *table, int write,
+int proc_dointvec_minmax(const struct ctl_table *table, int write,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_douintvec_minmax(struct ctl_table *table, int write,
+int proc_douintvec_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dou8vec_minmax(struct ctl_table *table, int write,
+int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_jiffies(const struct ctl_table *table, int write,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_ms_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_doulongvec_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_do_large_bitmap(struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -1585,7 +1585,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 #endif /* CONFIG_PROC_SYSCTL */
 
 #if defined(CONFIG_SYSCTL)
-int proc_do_static_key(struct ctl_table *table, int write,
+int proc_do_static_key(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..cb8b93fec895 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -237,7 +237,7 @@ static void timers_update_migration(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static int timer_migration_handler(struct ctl_table *table, int write,
+static int timer_migration_handler(const struct ctl_table *table, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..6334a2268acf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8213,7 +8213,7 @@ static bool is_permanent_ops_registered(void)
 }
 
 static int
-ftrace_enable_sysctl(struct ctl_table *table, int write,
+ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = -ENODEV;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..380b9cb7210a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2972,7 +2972,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
 }
 
-int tracepoint_printk_sysctl(struct ctl_table *table, int write,
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..4331d3bcae61 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2724,7 +2724,7 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
-static int set_max_user_events_sysctl(struct ctl_table *table, int write,
+static int set_max_user_events_sysctl(const struct ctl_table *table, int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..7f9572a37333 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -514,7 +514,7 @@ static const struct file_operations stack_trace_filter_fops = {
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 int
-stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
+stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
 		   size_t *lenp, loff_t *ppos)
 {
 	int was_enabled;
diff --git a/kernel/umh.c b/kernel/umh.c
index 1b13c5d34624..112d3fea3869 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -495,7 +495,7 @@ int call_usermodehelper(const char *path, char **argv, char **envp, int wait)
 EXPORT_SYMBOL(call_usermodehelper);
 
 #if defined(CONFIG_SYSCTL)
-static int proc_cap_handler(struct ctl_table *table, int write,
+static int proc_cap_handler(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 46590d4addc8..f074a92eae78 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -30,7 +30,7 @@ static void *get_uts(const struct ctl_table *table)
  *	Special case of dostring for the UTS structure. This has locks
  *	to observe. Should this be in kernel/sys.c ????
  */
-static int proc_do_uts_string(struct ctl_table *table, int write,
+static int proc_do_uts_string(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table uts_table;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 0fe72e89627d..4c48f543bcd2 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -745,8 +745,9 @@ static void proc_watchdog_update(void)
  * -------------------|----------------------------------|-------------------------------
  * proc_soft_watchdog | watchdog_softlockup_user_enabled | WATCHDOG_SOFTOCKUP_ENABLED
  */
-static int proc_watchdog_common(int which, struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_watchdog_common(int which, const struct ctl_table *table,
+				int write, void *buffer, size_t *lenp,
+				loff_t *ppos)
 {
 	int err, old, *param = table->data;
 
@@ -772,7 +773,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-static int proc_watchdog(struct ctl_table *table, int write,
+static int proc_watchdog(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
@@ -783,7 +784,7 @@ static int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-static int proc_nmi_watchdog(struct ctl_table *table, int write,
+static int proc_nmi_watchdog(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
@@ -795,7 +796,7 @@ static int proc_nmi_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-static int proc_soft_watchdog(struct ctl_table *table, int write,
+static int proc_soft_watchdog(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
@@ -805,7 +806,7 @@ static int proc_soft_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-static int proc_watchdog_thresh(struct ctl_table *table, int write,
+static int proc_watchdog_thresh(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
@@ -828,7 +829,7 @@ static int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-static int proc_watchdog_cpumask(struct ctl_table *table, int write,
+static int proc_watchdog_cpumask(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..87fe40cc76a8 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2842,8 +2842,8 @@ static void compact_nodes(void)
 		compact_node(nid);
 }
 
-static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int compaction_proactiveness_sysctl_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc, nid;
 
@@ -2872,7 +2872,7 @@ static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
  */
-static int sysctl_compaction_handler(struct ctl_table *table, int write,
+static int sysctl_compaction_handler(const struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
@@ -3183,7 +3183,7 @@ static int kcompactd_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, old;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2df21a295359..babb70d990aa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4874,7 +4874,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_sysctl_handler(const struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 
@@ -4883,7 +4883,7 @@ static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_mempolicy_sysctl_handler(const struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
@@ -4891,7 +4891,7 @@ static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_NUMA */
 
-static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
+static int hugetlb_overcommit_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ee2fd6a6af40..52f28e6f7a33 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -493,8 +493,8 @@ bool node_dirty_ok(struct pglist_data *pgdat)
 }
 
 #ifdef CONFIG_SYSCTL
-static int dirty_background_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int dirty_background_ratio_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -504,8 +504,8 @@ static int dirty_background_ratio_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int dirty_background_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int dirty_background_bytes_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -515,8 +515,8 @@ static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int dirty_ratio_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int old_ratio = vm_dirty_ratio;
 	int ret;
@@ -529,7 +529,7 @@ static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-static int dirty_bytes_handler(struct ctl_table *table, int write,
+static int dirty_bytes_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned long old_bytes = vm_dirty_bytes;
@@ -2132,8 +2132,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 /*
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
-static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int dirty_writeback_centisecs_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	unsigned int old_interval = dirty_writeback_interval;
 	int ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..5eb29269d39e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4985,7 +4985,7 @@ static char numa_zonelist_order[] = "Node";
 /*
  * sysctl handler for numa_zonelist_order
  */
-static int numa_zonelist_order_handler(struct ctl_table *table, int write,
+static int numa_zonelist_order_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	if (write)
@@ -5978,8 +5978,8 @@ postcore_initcall(init_per_zone_wmark_min)
  *	that we can call two helper functions whenever min_free_kbytes
  *	changes.
  */
-static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int min_free_kbytes_sysctl_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
 
@@ -5994,8 +5994,8 @@ static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int watermark_scale_factor_sysctl_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
 
@@ -6024,8 +6024,8 @@ static void setup_min_unmapped_ratio(void)
 }
 
 
-static int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int sysctl_min_unmapped_ratio_sysctl_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
 
@@ -6051,8 +6051,8 @@ static void setup_min_slab_ratio(void)
 						     sysctl_min_slab_ratio) / 100;
 }
 
-static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int sysctl_min_slab_ratio_sysctl_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
 
@@ -6075,7 +6075,7 @@ static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int wri
  * minimum watermarks. The lowmem reserve ratio can only make sense
  * if in function of the boot time zone sizes.
  */
-static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
+static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int i;
@@ -6096,7 +6096,7 @@ static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
  * cpu. It is the fraction of total pages in each zone that a hot per cpu
  * pagelist can have before it gets flushed back to buddy allocator.
  */
-static int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
+static int percpu_pagelist_high_fraction_sysctl_handler(const struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	struct zone *zone;
diff --git a/mm/util.c b/mm/util.c
index 744b4d7e3fae..98338ab35b68 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -818,8 +818,8 @@ int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_ratio_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -834,8 +834,8 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_policy_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -870,8 +870,8 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..a65316426012 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -74,7 +74,7 @@ static void invalid_numa_statistics(void)
 
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
+int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret, oldval;
@@ -1883,7 +1883,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(struct ctl_table *table, int write,
+int vmstat_refresh(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 74056b563b95..c284bd9c2d7a 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1048,7 +1048,7 @@ int br_nf_hook_thresh(unsigned int hook, struct net *net,
 
 #ifdef CONFIG_SYSCTL
 static
-int brnf_sysctl_call_tables(struct ctl_table *ctl, int write,
+int brnf_sysctl_call_tables(const struct ctl_table *ctl, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..8d13979c0c38 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3531,7 +3531,7 @@ EXPORT_SYMBOL(neigh_app_ns);
 #ifdef CONFIG_SYSCTL
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 
-static int proc_unres_qlen(struct ctl_table *ctl, int write,
+static int proc_unres_qlen(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int size, ret;
@@ -3566,7 +3566,7 @@ static void neigh_copy_dflt_parms(struct net *net, struct neigh_parms *p,
 	rcu_read_unlock();
 }
 
-static void neigh_proc_update(struct ctl_table *ctl, int write)
+static void neigh_proc_update(const struct ctl_table *ctl, int write)
 {
 	struct net_device *dev = ctl->extra1;
 	struct neigh_parms *p = ctl->extra2;
@@ -3583,9 +3583,9 @@ static void neigh_proc_update(struct ctl_table *ctl, int write)
 		neigh_copy_dflt_parms(net, p, index);
 }
 
-static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
-					   void *buffer, size_t *lenp,
-					   loff_t *ppos)
+static int neigh_proc_dointvec_zero_intmax(const struct ctl_table *ctl,
+					   int write, void *buffer,
+					   size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
 	int ret;
@@ -3598,7 +3598,7 @@ static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl, int write,
 						   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
@@ -3614,7 +3614,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int wr
 	return ret;
 }
 
-int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec(const struct ctl_table *ctl, int write, void *buffer,
 			size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
@@ -3624,7 +3624,7 @@ int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec);
 
-int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3634,7 +3634,7 @@ int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_jiffies);
 
-static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_userhz_jiffies(const struct ctl_table *ctl, int write,
 					      void *buffer, size_t *lenp,
 					      loff_t *ppos)
 {
@@ -3644,7 +3644,7 @@ static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec_ms_jiffies(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_ms_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3654,7 +3654,7 @@ int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_ms_jiffies);
 
-static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_unres_qlen(const struct ctl_table *ctl, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
@@ -3664,7 +3664,7 @@ static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
+static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 08a01b31be99..b5093796f196 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -91,7 +91,7 @@ static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
 	return rps_default_mask;
 }
 
-static int rps_default_mask_sysctl(struct ctl_table *table, int write,
+static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)table->data;
@@ -122,7 +122,7 @@ static int rps_default_mask_sysctl(struct ctl_table *table, int write,
 	return err;
 }
 
-static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
+static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int orig_size, size;
@@ -191,7 +191,7 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 #ifdef CONFIG_NET_FLOW_LIMIT
 static DEFINE_MUTEX(flow_limit_update_mutex);
 
-static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
+static int flow_limit_cpu_sysctl(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct sd_flow_limit *cur;
@@ -248,7 +248,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
+static int flow_limit_table_len_sysctl(const struct ctl_table *table, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int old, *ptr;
@@ -270,7 +270,7 @@ static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
 #endif /* CONFIG_NET_FLOW_LIMIT */
 
 #ifdef CONFIG_NET_SCHED
-static int set_default_qdisc(struct ctl_table *table, int write,
+static int set_default_qdisc(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char id[IFNAMSIZ];
@@ -289,7 +289,7 @@ static int set_default_qdisc(struct ctl_table *table, int write,
 }
 #endif
 
-static int proc_do_dev_weight(struct ctl_table *table, int write,
+static int proc_do_dev_weight(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	static DEFINE_MUTEX(dev_weight_mutex);
@@ -307,7 +307,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_do_rss_key(struct ctl_table *table, int write,
+static int proc_do_rss_key(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
@@ -320,7 +320,7 @@ static int proc_do_rss_key(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_BPF_JIT
-static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
+static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
@@ -353,7 +353,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 
 # ifdef CONFIG_HAVE_EBPF_JIT
 static int
-proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dointvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -364,7 +364,7 @@ proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 # endif /* CONFIG_HAVE_EBPF_JIT */
 
 static int
-proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dolongvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f8a56fe95801..bf53518cfef8 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2395,7 +2395,7 @@ static int devinet_conf_ifindex(struct net *net, struct ipv4_devconf *cnf)
 	}
 }
 
-static int devinet_conf_proc(struct ctl_table *ctl, int write,
+static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int old_value = *(int *)ctl->data;
@@ -2447,7 +2447,7 @@ static int devinet_conf_proc(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int devinet_sysctl_forward(struct ctl_table *ctl, int write,
+static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -2494,7 +2494,7 @@ static int devinet_sysctl_forward(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int ipv4_doint_and_flush(struct ctl_table *ctl, int write,
+static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7c7884110a58..adabe2aa3d8b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3408,7 +3408,7 @@ static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
 static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
-static int ipv4_sysctl_rtcache_flush(struct ctl_table *__ctl, int write,
+static int ipv4_sysctl_rtcache_flush(const struct ctl_table *__ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)__ctl->extra1;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 599244f9ad65..eef0082233e1 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -65,7 +65,7 @@ static void set_local_port_range(struct net *net, int range[2])
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_local_port_range(struct ctl_table *table, int write,
+static int ipv4_local_port_range(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net =
@@ -100,7 +100,7 @@ static int ipv4_local_port_range(struct ctl_table *table, int write,
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_privileged_ports(struct ctl_table *table, int write,
+static int ipv4_privileged_ports(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -134,7 +134,8 @@ static int ipv4_privileged_ports(struct ctl_table *table, int write,
 	return ret;
 }
 
-static void inet_get_ping_group_range_table(struct ctl_table *table, kgid_t *low, kgid_t *high)
+static void inet_get_ping_group_range_table(const struct ctl_table *table, kgid_t *low,
+					    kgid_t *high)
 {
 	kgid_t *data = table->data;
 	struct net *net =
@@ -149,7 +150,7 @@ static void inet_get_ping_group_range_table(struct ctl_table *table, kgid_t *low
 }
 
 /* Update system visible IP port range */
-static void set_ping_group_range(struct ctl_table *table, kgid_t low, kgid_t high)
+static void set_ping_group_range(const struct ctl_table *table, kgid_t low, kgid_t high)
 {
 	kgid_t *data = table->data;
 	struct net *net =
@@ -161,7 +162,7 @@ static void set_ping_group_range(struct ctl_table *table, kgid_t low, kgid_t hig
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_ping_group_range(struct ctl_table *table, int write,
+static int ipv4_ping_group_range(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct user_namespace *user_ns = current_user_ns();
@@ -196,7 +197,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipv4_fwd_update_priority(struct ctl_table *table, int write,
+static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
@@ -212,7 +213,7 @@ static int ipv4_fwd_update_priority(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_tcp_congestion_control(struct ctl_table *ctl, int write,
+static int proc_tcp_congestion_control(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net,
@@ -232,7 +233,7 @@ static int proc_tcp_congestion_control(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_tcp_available_congestion_control(struct ctl_table *ctl,
+static int proc_tcp_available_congestion_control(const struct ctl_table *ctl,
 						 int write, void *buffer,
 						 size_t *lenp, loff_t *ppos)
 {
@@ -248,7 +249,7 @@ static int proc_tcp_available_congestion_control(struct ctl_table *ctl,
 	return ret;
 }
 
-static int proc_allowed_congestion_control(struct ctl_table *ctl,
+static int proc_allowed_congestion_control(const struct ctl_table *ctl,
 					   int write, void *buffer,
 					   size_t *lenp, loff_t *ppos)
 {
@@ -285,7 +286,7 @@ static int sscanf_key(char *buf, __le32 *key)
 	return ret;
 }
 
-static int proc_tcp_fastopen_key(struct ctl_table *table, int write,
+static int proc_tcp_fastopen_key(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -356,7 +357,7 @@ static int proc_tcp_fastopen_key(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_tfo_blackhole_detect_timeout(struct ctl_table *table,
+static int proc_tfo_blackhole_detect_timeout(const struct ctl_table *table,
 					     int write, void *buffer,
 					     size_t *lenp, loff_t *ppos)
 {
@@ -371,7 +372,7 @@ static int proc_tfo_blackhole_detect_timeout(struct ctl_table *table,
 	return ret;
 }
 
-static int proc_tcp_available_ulp(struct ctl_table *ctl,
+static int proc_tcp_available_ulp(const struct ctl_table *ctl,
 				  int write, void *buffer, size_t *lenp,
 				  loff_t *ppos)
 {
@@ -388,7 +389,7 @@ static int proc_tcp_available_ulp(struct ctl_table *ctl,
 	return ret;
 }
 
-static int proc_tcp_ehash_entries(struct ctl_table *table, int write,
+static int proc_tcp_ehash_entries(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -412,7 +413,7 @@ static int proc_tcp_ehash_entries(struct ctl_table *table, int write,
 	return proc_dointvec(&tbl, write, buffer, lenp, ppos);
 }
 
-static int proc_udp_hash_entries(struct ctl_table *table, int write,
+static int proc_udp_hash_entries(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -436,7 +437,7 @@ static int proc_udp_hash_entries(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
+static int proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
@@ -451,7 +452,7 @@ static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_fib_multipath_hash_fields(struct ctl_table *table, int write,
+static int proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index aa5654d29334..6732ee1bb901 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -859,7 +859,7 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_fixup_forwarding(struct ctl_table *table, int *p, int newf)
+static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int newf)
 {
 	struct net *net;
 	int old;
@@ -927,7 +927,7 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_fixup_linkdown(struct ctl_table *table, int *p, int newf)
+static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int newf)
 {
 	struct net *net;
 	int old;
@@ -6258,7 +6258,7 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 
 #ifdef CONFIG_SYSCTL
 
-static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6283,7 +6283,7 @@ static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_mtu(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_mtu(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct inet6_dev *idev = ctl->extra1;
@@ -6327,7 +6327,7 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
+static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf)
 {
 	struct net *net;
 	int old;
@@ -6354,7 +6354,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	return 0;
 }
 
-static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6379,7 +6379,7 @@ static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6420,7 +6420,7 @@ static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6482,7 +6482,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6549,7 +6549,7 @@ static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
 }
 
 static
-int addrconf_sysctl_ignore_routes_with_linkdown(struct ctl_table *ctl,
+int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 						int write, void *buffer,
 						size_t *lenp,
 						loff_t *ppos)
@@ -6617,7 +6617,7 @@ void addrconf_disable_policy_idev(struct inet6_dev *idev, int val)
 }
 
 static
-int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
+int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 {
 	struct inet6_dev *idev;
 	struct net *net;
@@ -6650,8 +6650,9 @@ int addrconf_disable_policy(struct ctl_table *ctl, int *valp, int val)
 	return 0;
 }
 
-static int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
-				   void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl,
+					  int write, void *buffer, size_t *lenp,
+					  loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a19999b30bc0..e423b4fe0836 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1922,7 +1922,7 @@ static struct notifier_block ndisc_netdev_notifier = {
 };
 
 #ifdef CONFIG_SYSCTL
-static void ndisc_warn_deprecated_sysctl(struct ctl_table *ctl,
+static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 					 const char *func, const char *dev_name)
 {
 	static char warncomm[TASK_COMM_LEN];
@@ -1937,7 +1937,7 @@ static void ndisc_warn_deprecated_sysctl(struct ctl_table *ctl,
 	}
 }
 
-int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write, void *buffer,
+int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct net_device *dev = ctl->extra1;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..a318fba122b3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6325,7 +6325,7 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
 
 #ifdef CONFIG_SYSCTL
 
-static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
+static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 75de55f907b0..e5a4cbc3e8c3 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -30,7 +30,7 @@ static u32 rt6_multipath_hash_fields_all_mask =
 static u32 ioam6_id_max = IOAM6_DEFAULT_ID;
 static u64 ioam6_id_wide_max = IOAM6_DEFAULT_ID_WIDE;
 
-static int proc_rt6_multipath_hash_policy(struct ctl_table *table, int write,
+static int proc_rt6_multipath_hash_policy(const struct ctl_table *table, int write,
 					  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
@@ -46,7 +46,7 @@ static int proc_rt6_multipath_hash_policy(struct ctl_table *table, int write,
 }
 
 static int
-proc_rt6_multipath_hash_fields(struct ctl_table *table, int write, void *buffer,
+proc_rt6_multipath_hash_fields(const struct ctl_table *table, int write, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 832b63bb5646..c107de0b4e49 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1363,7 +1363,7 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 #define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
 	(&((struct mpls_dev *)0)->field)
 
-static int mpls_conf_proc(struct ctl_table *ctl, int write,
+static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int oval = *(int *)ctl->data;
@@ -2615,7 +2615,7 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	return -ENOMEM;
 }
 
-static int mpls_platform_labels(struct ctl_table *table, int write,
+static int mpls_platform_labels(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = table->data;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..8b7720925699 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1846,7 +1846,7 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 #ifdef CONFIG_SYSCTL
 
 static int
-proc_do_defense_mode(struct ctl_table *table, int write,
+proc_do_defense_mode(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct netns_ipvs *ipvs = table->extra2;
@@ -1873,7 +1873,7 @@ proc_do_defense_mode(struct ctl_table *table, int write,
 }
 
 static int
-proc_do_sync_threshold(struct ctl_table *table, int write,
+proc_do_sync_threshold(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct netns_ipvs *ipvs = table->extra2;
@@ -1901,7 +1901,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 }
 
 static int
-proc_do_sync_ports(struct ctl_table *table, int write,
+proc_do_sync_ports(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = table->data;
@@ -1924,7 +1924,7 @@ proc_do_sync_ports(struct ctl_table *table, int write,
 	return rc;
 }
 
-static int ipvs_proc_est_cpumask_set(struct ctl_table *table, void *buffer)
+static int ipvs_proc_est_cpumask_set(const struct ctl_table *table, void *buffer)
 {
 	struct netns_ipvs *ipvs = table->extra2;
 	cpumask_var_t *valp = table->data;
@@ -1962,7 +1962,7 @@ static int ipvs_proc_est_cpumask_set(struct ctl_table *table, void *buffer)
 	return ret;
 }
 
-static int ipvs_proc_est_cpumask_get(struct ctl_table *table, void *buffer,
+static int ipvs_proc_est_cpumask_get(const struct ctl_table *table, void *buffer,
 				     size_t size)
 {
 	struct netns_ipvs *ipvs = table->extra2;
@@ -1983,7 +1983,7 @@ static int ipvs_proc_est_cpumask_get(struct ctl_table *table, void *buffer,
 	return ret;
 }
 
-static int ipvs_proc_est_cpulist(struct ctl_table *table, int write,
+static int ipvs_proc_est_cpulist(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -2010,7 +2010,7 @@ static int ipvs_proc_est_cpulist(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipvs_proc_est_nice(struct ctl_table *table, int write,
+static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct netns_ipvs *ipvs = table->extra2;
@@ -2040,7 +2040,7 @@ static int ipvs_proc_est_nice(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipvs_proc_run_estimation(struct ctl_table *table, int write,
+static int ipvs_proc_run_estimation(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct netns_ipvs *ipvs = table->extra2;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index bb9dea676ec1..3d5284639ca8 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -527,7 +527,7 @@ EXPORT_SYMBOL_GPL(nf_conntrack_count);
 static unsigned int nf_conntrack_htable_size_user __read_mostly;
 
 static int
-nf_conntrack_hash_sysctl(struct ctl_table *table, int write,
+nf_conntrack_hash_sysctl(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 00e89ffd78f6..3d237f9cc8ee 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -25,7 +25,7 @@ static inline int nf_hooks_lwtunnel_set(int enable)
 }
 
 #ifdef CONFIG_SYSCTL
-int nf_hooks_lwtunnel_sysctl_handler(struct ctl_table *table, int write,
+int nf_hooks_lwtunnel_sysctl_handler(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int proc_nf_hooks_lwtunnel_enabled = 0;
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 2e897a9f0689..9432a6c6c140 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -403,7 +403,7 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 	{ }
 };
 
-static int nf_log_proc_dostring(struct ctl_table *table, int write,
+static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	const struct nf_logger *logger;
diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
index 0d0bf41381c2..e59d16e67376 100644
--- a/net/phonet/sysctl.c
+++ b/net/phonet/sysctl.c
@@ -48,7 +48,7 @@ void phonet_get_local_port_range(int *min, int *max)
 	} while (read_seqretry(&local_port_range_lock, seq));
 }
 
-static int proc_local_port_range(struct ctl_table *table, int write,
+static int proc_local_port_range(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2dba7505b414..d23ea8c11902 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -61,7 +61,7 @@ static atomic_t rds_tcp_unloading = ATOMIC_INIT(0);
 
 static struct kmem_cache *rds_tcp_conn_slab;
 
-static int rds_tcp_skbuf_handler(struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos);
 
 static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
@@ -683,7 +683,7 @@ static void rds_tcp_sysctl_reset(struct net *net)
 	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
-static int rds_tcp_skbuf_handler(struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos)
 {
 	struct net *net = current->nsproxy->net_ns;
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 25bdf17c7262..8317421d1b83 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -43,19 +43,19 @@ static unsigned long max_autoclose_max =
 	(MAX_SCHEDULE_TIMEOUT / HZ > UINT_MAX)
 	? UINT_MAX : MAX_SCHEDULE_TIMEOUT / HZ;
 
-static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
+static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write, void *buffer,
+static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write, void *buffer,
+static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write, void *buffer,
 				 size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
+static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
+static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_probe_interval(struct ctl_table *ctl, int write,
+static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos);
 
 static struct ctl_table sctp_table[] = {
@@ -388,7 +388,7 @@ static struct ctl_table sctp_net_table[] = {
 	{ /* sentinel */ }
 };
 
-static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
+static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -433,7 +433,7 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -461,7 +461,7 @@ static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -489,7 +489,7 @@ static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
+static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write)
@@ -499,7 +499,7 @@ static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
 	return proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 }
 
-static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
+static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -528,7 +528,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
+static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -569,7 +569,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_probe_interval(struct ctl_table *ctl, int write,
+static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 93941ab12549..672067efacef 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -40,7 +40,7 @@ EXPORT_SYMBOL_GPL(nlm_debug);
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
-static int proc_do_xprt(struct ctl_table *table, int write,
+static int proc_do_xprt(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char tmpbuf[256];
@@ -62,8 +62,8 @@ static int proc_do_xprt(struct ctl_table *table, int write,
 }
 
 static int
-proc_dodebug(struct ctl_table *table, int write, void *buffer, size_t *lenp,
-	     loff_t *ppos)
+proc_dodebug(const struct ctl_table *table, int write, void *buffer,
+	     size_t *lenp, loff_t *ppos)
 {
 	char		tmpbuf[20], *s = NULL;
 	char *p;
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f0d5eeed4c88..fb1d5432080e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -74,7 +74,7 @@ enum {
 	SVCRDMA_COUNTER_BUFSIZ	= sizeof(unsigned long long),
 };
 
-static int svcrdma_counter_handler(struct ctl_table *table, int write,
+static int svcrdma_counter_handler(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct percpu_counter *stat = (struct percpu_counter *)table->data;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4981bdf02993..2828aadcd732 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1980,7 +1980,7 @@ static int __init alloc_buffers(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static int apparmor_dointvec(struct ctl_table *table, int write,
+static int apparmor_dointvec(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!aa_current_policy_admin_capable(NULL))
diff --git a/security/min_addr.c b/security/min_addr.c
index 88c9a6a21f47..0ce267c041ab 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -29,7 +29,7 @@ static void update_mmap_min_addr(void)
  * sysctl handler which just sets dac_mmap_min_addr = the new value and then
  * calls update_mmap_min_addr() so non MAP_FIXED hints get rounded properly
  */
-int mmap_min_addr_handler(struct ctl_table *table, int write,
+int mmap_min_addr_handler(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 2503cf153d4a..9cb8e7cded56 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -429,7 +429,7 @@ static struct security_hook_list yama_hooks[] __ro_after_init = {
 };
 
 #ifdef CONFIG_SYSCTL
-static int yama_dointvec_minmax(struct ctl_table *table, int write,
+static int yama_dointvec_minmax(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table table_copy;

-- 
2.43.0


