Return-Path: <linux-fsdevel+bounces-17478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50B8ADF03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACA12865C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158E75813;
	Tue, 23 Apr 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uagAM0++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550A4EB24;
	Tue, 23 Apr 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858981; cv=none; b=FbT6gqQzlCuggrlehgIoWan7MRQFIwudOa53G7EyLT0fAc8Xzr04i11bdsMyshUrf4utu8+wpSjB4vaQf2IZ0XqhPsMG+5SEVglOKFVGMxK3a3vmGvzFNLApb22XA6Zsqlsb3i+39CiwkemGRGhwDkLtLqOkW+ATTDhpFuuHMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858981; c=relaxed/simple;
	bh=FVysOkPE/qiRLZCuxnkxsMnTX0foyNtgrbyactsZP2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vb62sIvx12Ajrfc9PpDWX7DpEVHxYpcpcsyRoZ5bg2G84CyFQJr2KK6rD4ML/nBjTyb8Nl4n/WDfF8QemjIHo5HN2S0KcVjnyn5czK9HQXHhYk3fGOPnZcoPwm3S0VUGSumuzeRr3fcVe8C+bx5NAIssRNzQma6zJfJ4iulqk8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uagAM0++; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=FVysOkPE/qiRLZCuxnkxsMnTX0foyNtgrbyactsZP2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uagAM0++rugBquWWZc12oBXw1p0sZNjLZ2P0BRn3a7mK4KfkLqVjep/MFqJY/7LAF
	 9caAdhgcu3xO8svnWs6UiBpEw54gG1sTupswjoZ3XrmizzbipFrDAq+6AqF37skYwx
	 BR63gR5QqQWcerDyrgrTLAOjD+xHRp30erwz41hs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:46 +0200
Subject: [PATCH v3 11/11] sysctl: treewide: constify the ctl_table argument
 of handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=108174;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FVysOkPE/qiRLZCuxnkxsMnTX0foyNtgrbyactsZP2Y=;
 b=5wEbCfrcoLTsgxV7Uxepjuju0i3n3dX4eEy0jjS4qXCKmY0HYJZJRKgtvn3SvZv68yUf+15PI
 DCOFgsjg7ChC0MoGza+B8re+o9KUvCk6GNeS16w70HPuLDKhvC0QRKO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Adapt the proc_hander function signature to make it clear that handlers
are not supposed to modify their ctl_table argument.

This is a prerequisite to moving the static ctl_table structs into
.rodata.
By migrating all handlers at once a lengthy transition can be avoided.

The patch was mostly generated by coccinelle with the following script:

    @@
    identifier func, ctl, write, buffer, lenp, ppos;
    @@

    int func(
    - struct ctl_table *ctl,
    + const struct ctl_table *ctl,
      int write, void *buffer, size_t *lenp, loff_t *ppos)
    { ... }

In addition to the scripted changes some other changes are done:

* the typedef proc_handler is adapted

* the prototypes of non-static handler are adapted

* kernel/seccomp.c:{read,write}_actions_logged() and
  kernel/watchdog.c:proc_watchdog_common() are adapted as they need to
  adapted together with the handlers for type-consistency reasons

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/arm64/kernel/armv8_deprecated.c      |  2 +-
 arch/arm64/kernel/fpsimd.c                |  2 +-
 arch/s390/appldata/appldata_base.c        | 10 ++---
 arch/s390/kernel/debug.c                  |  2 +-
 arch/s390/kernel/topology.c               |  2 +-
 arch/s390/mm/cmm.c                        |  6 +--
 arch/x86/kernel/itmt.c                    |  2 +-
 drivers/cdrom/cdrom.c                     |  4 +-
 drivers/char/random.c                     |  6 +--
 drivers/macintosh/mac_hid.c               |  2 +-
 drivers/net/vrf.c                         |  2 +-
 drivers/parport/procfs.c                  | 12 +++---
 drivers/perf/arm_pmuv3.c                  |  4 +-
 drivers/perf/riscv_pmu_sbi.c              |  2 +-
 fs/coredump.c                             |  2 +-
 fs/dcache.c                               |  4 +-
 fs/drop_caches.c                          |  2 +-
 fs/exec.c                                 |  4 +-
 fs/file_table.c                           |  4 +-
 fs/fs-writeback.c                         |  2 +-
 fs/inode.c                                |  4 +-
 fs/pipe.c                                 |  2 +-
 fs/quota/dquot.c                          |  2 +-
 fs/xfs/xfs_sysctl.c                       |  6 +--
 include/linux/ftrace.h                    |  4 +-
 include/linux/mm.h                        |  8 ++--
 include/linux/perf_event.h                |  6 +--
 include/linux/security.h                  |  2 +-
 include/linux/sysctl.h                    | 34 ++++++++--------
 include/linux/vmstat.h                    |  6 +--
 include/linux/writeback.h                 |  2 +-
 include/net/ndisc.h                       |  2 +-
 include/net/neighbour.h                   |  6 +--
 include/net/netfilter/nf_hooks_lwtunnel.h |  2 +-
 ipc/ipc_sysctl.c                          |  8 ++--
 kernel/bpf/syscall.c                      |  4 +-
 kernel/delayacct.c                        |  4 +-
 kernel/events/callchain.c                 |  2 +-
 kernel/events/core.c                      |  4 +-
 kernel/fork.c                             |  2 +-
 kernel/hung_task.c                        |  6 +--
 kernel/kexec_core.c                       |  2 +-
 kernel/kprobes.c                          |  2 +-
 kernel/latencytop.c                       |  4 +-
 kernel/pid_namespace.c                    |  2 +-
 kernel/pid_sysctl.h                       |  2 +-
 kernel/printk/internal.h                  |  2 +-
 kernel/printk/printk.c                    |  2 +-
 kernel/printk/sysctl.c                    |  5 ++-
 kernel/sched/core.c                       |  8 ++--
 kernel/sched/rt.c                         | 16 ++++----
 kernel/sched/topology.c                   |  2 +-
 kernel/seccomp.c                          | 10 ++---
 kernel/stackleak.c                        |  2 +-
 kernel/sysctl.c                           | 68 +++++++++++++++----------------
 kernel/time/timer.c                       |  2 +-
 kernel/trace/ftrace.c                     |  2 +-
 kernel/trace/trace.c                      |  2 +-
 kernel/trace/trace_events_user.c          |  2 +-
 kernel/trace/trace_stack.c                |  2 +-
 kernel/umh.c                              |  2 +-
 kernel/utsname_sysctl.c                   |  2 +-
 kernel/watchdog.c                         | 12 +++---
 mm/compaction.c                           |  6 +--
 mm/hugetlb.c                              |  8 ++--
 mm/page-writeback.c                       | 18 ++++----
 mm/page_alloc.c                           | 14 +++----
 mm/util.c                                 | 12 +++---
 mm/vmstat.c                               |  4 +-
 net/bridge/br_netfilter_hooks.c           |  2 +-
 net/core/neighbour.c                      | 18 ++++----
 net/core/sysctl_net_core.c                | 20 ++++-----
 net/ipv4/devinet.c                        |  6 +--
 net/ipv4/route.c                          |  2 +-
 net/ipv4/sysctl_net_ipv4.c                | 32 +++++++--------
 net/ipv6/addrconf.c                       | 19 +++++----
 net/ipv6/ndisc.c                          |  2 +-
 net/ipv6/route.c                          |  2 +-
 net/ipv6/sysctl_net_ipv6.c                |  4 +-
 net/mpls/af_mpls.c                        |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c            | 12 +++---
 net/netfilter/nf_conntrack_standalone.c   |  2 +-
 net/netfilter/nf_hooks_lwtunnel.c         |  2 +-
 net/netfilter/nf_log.c                    |  2 +-
 net/phonet/sysctl.c                       |  2 +-
 net/rds/tcp.c                             |  4 +-
 net/sctp/sysctl.c                         | 32 +++++++--------
 net/sunrpc/sysctl.c                       |  6 +--
 net/sunrpc/xprtrdma/svc_rdma.c            |  2 +-
 security/apparmor/lsm.c                   |  2 +-
 security/min_addr.c                       |  2 +-
 security/yama/yama_lsm.c                  |  2 +-
 92 files changed, 295 insertions(+), 293 deletions(-)

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
index ebb0158997ca..98efb587ef36 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -535,7 +535,7 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 
 #if defined(CONFIG_ARM64_SVE) && defined(CONFIG_SYSCTL)
 
-static int vec_proc_do_default_vl(struct ctl_table *table, int write,
+static int vec_proc_do_default_vl(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct vl_info *info = table->extra1;
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index c2978cb03b36..91a30e017d65 100644
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
@@ -262,7 +262,7 @@ appldata_interval_handler(struct ctl_table *ctl, int write,
  * monitoring (0 = not in process, 1 = in process)
  */
 static int
-appldata_generic_handler(struct ctl_table *ctl, int write,
+appldata_generic_handler(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct appldata_ops *ops = NULL, *tmp_ops;
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
index 2597cb43f438..ca414208f899 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1604,7 +1604,7 @@ static u8 sysctl_bootid[UUID_SIZE];
  * UUID. The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
  */
-static int proc_do_uuid(struct ctl_table *table, int write, void *buf,
+static int proc_do_uuid(const struct ctl_table *table, int write, void *buf,
 			size_t *lenp, loff_t *ppos)
 {
 	u8 tmp_uuid[UUID_SIZE], *uuid;
@@ -1635,8 +1635,8 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buf,
 }
 
 /* The same as proc_dointvec, but writes don't change anything. */
-static int proc_do_rointvec(struct ctl_table *table, int write, void *buf,
-			    size_t *lenp, loff_t *ppos)
+static int proc_do_rointvec(const struct ctl_table *table, int write,
+			    void *buf, size_t *lenp, loff_t *ppos)
 {
 	return write ? 0 : proc_dointvec(table, 0, buf, lenp, ppos);
 }
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
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..accdf3ac4c1d 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1253,8 +1253,8 @@ static void armv8pmu_disable_user_access_ipi(void *unused)
 	armv8pmu_disable_user_access();
 }
 
-static int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int armv8pmu_proc_user_access_handler(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret || !write || sysctl_perf_user_access)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 82636273d726..9c9ceec3a206 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1013,7 +1013,7 @@ static void riscv_pmu_update_counter_access(void *info)
 		csr_write(CSR_SCOUNTEREN, 0x2);
 }
 
-static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
+static int riscv_pmu_proc_user_access_handler(const struct ctl_table *table,
 					      int write, void *buffer,
 					      size_t *lenp, loff_t *ppos)
 {
diff --git a/fs/coredump.c b/fs/coredump.c
index 8eae24afb3cb..b4f68117d203 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -986,7 +986,7 @@ void validate_coredump_safety(void)
 	}
 }
 
-static int proc_dostring_coredump(struct ctl_table *table, int write,
+static int proc_dostring_coredump(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error = proc_dostring(table, write, buffer, lenp, ppos);
diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..5c6ae57d0321 100644
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
index 40073142288f..ba59402194c7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2181,8 +2181,8 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 
 #ifdef CONFIG_SYSCTL
 
-static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_coredump(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..f5480473727e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -96,8 +96,8 @@ EXPORT_SYMBOL_GPL(get_max_files);
 /*
  * Handle nr_files sysctl
  */
-static int proc_nr_files(struct ctl_table *table, int write, void *buffer,
-			 size_t *lenp, loff_t *ppos)
+static int proc_nr_files(const struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..b865a3fa52f3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2413,7 +2413,7 @@ static int __init start_dirtytime_writeback(void)
 }
 __initcall(start_dirtytime_writeback);
 
-int dirtytime_interval_handler(struct ctl_table *table, int write,
+int dirtytime_interval_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..a622503a992c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -107,8 +107,8 @@ long get_nr_dirty_inodes(void)
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
index 50c8a8596b52..7dff2aa50a6d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1469,7 +1469,7 @@ static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
 	return 0;
 }
 
-static int proc_dopipe_max_size(struct ctl_table *table, int write,
+static int proc_dopipe_max_size(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 627eb2f72ef3..4c3936b8f7b6 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2917,7 +2917,7 @@ const struct quotactl_ops dquot_quotactl_sysfile_ops = {
 };
 EXPORT_SYMBOL(dquot_quotactl_sysfile_ops);
 
-static int do_proc_dqstats(struct ctl_table *table, int write,
+static int do_proc_dqstats(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int type = (unsigned long *)table->data - dqstats.stat;
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index a191f6560f98..c84df23b494d 100644
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
index 54d53f345d14..c3af2e5947aa 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -470,7 +470,7 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 
 extern int stack_tracer_enabled;
 
-int stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
+int stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
 		       size_t *lenp, loff_t *ppos);
 
 /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
@@ -1159,7 +1159,7 @@ extern int tracepoint_printk;
 extern void disable_trace_on_warning(void);
 extern int __disable_trace_on_warning;
 
-int tracepoint_printk_sysctl(struct ctl_table *table, int write,
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos);
 
 #else /* CONFIG_TRACING */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc33f8269fb5..828d97c23834 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -204,11 +204,11 @@ extern int sysctl_overcommit_memory;
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
@@ -3897,7 +3897,7 @@ extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
+int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 #endif
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..ce102aac11c0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1587,11 +1587,11 @@ extern int sysctl_perf_cpu_time_max_percent;
 
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
index 21cf70346b33..96799ff57230 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -228,7 +228,7 @@ struct request_sock;
 #define LSM_UNSAFE_NO_NEW_PRIVS	4
 
 #ifdef CONFIG_MMU
-extern int mmap_min_addr_handler(struct ctl_table *table, int write,
+extern int mmap_min_addr_handler(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 54fbec062772..aa4c6d44aaa0 100644
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
@@ -287,7 +287,7 @@ static inline bool sysctl_is_alias(char *param)
 }
 #endif /* CONFIG_SYSCTL */
 
-int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
+int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 #endif /* _LINUX_SYSCTL_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..7da26d1aea12 100644
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
+		   size_t *lenp, loff_t *ppos);
 
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 112d806ddbe4..1a54676d843a 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -350,7 +350,7 @@ extern unsigned int dirty_expire_interval;
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
index 9465b0ae470b..5d383a9a520e 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -17,8 +17,8 @@
 #include <linux/cred.h>
 #include "util.h"
 
-static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_ipc_dointvec_minmax_orphans(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ipc_namespace *ns =
 		container_of(table->data, struct ipc_namespace, shm_rmid_forced);
@@ -33,7 +33,7 @@ static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 	return err;
 }
 
-static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
+static int proc_ipc_auto_msgmni(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table ipc_table;
@@ -48,7 +48,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
-static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
+static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
 	void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ipc_namespace *ns =
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7dcd7f174bb1..93d1f856f3d4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5937,7 +5937,7 @@ const struct bpf_prog_ops bpf_syscall_prog_ops = {
 };
 
 #ifdef CONFIG_SYSCTL
-static int bpf_stats_handler(struct ctl_table *table, int write,
+static int bpf_stats_handler(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
@@ -5972,7 +5972,7 @@ void __weak unpriv_ebpf_notify(int new_state)
 {
 }
 
-static int bpf_unpriv_handler(struct ctl_table *table, int write,
+static int bpf_unpriv_handler(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, unpriv_enable = *(int *)table->data;
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index e039b0f99a0b..5cc4e0ef4128 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,8 +44,8 @@ void delayacct_init(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
-		     size_t *lenp, loff_t *ppos)
+static int sysctl_delayacct(const struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
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
index f0128c5ff278..01cc910d31f3 100644
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
index 99076dbe27d8..985bd0a5834c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3418,7 +3418,7 @@ int unshare_files(void)
 	return 0;
 }
 
-int sysctl_max_threads(struct ctl_table *table, int write,
+int sysctl_max_threads(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 1d92016b0b3c..688ab3443156 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -239,9 +239,9 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 /*
  * Process updating of timeout sysctl
  */
-static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-				  void *buffer,
-				  size_t *lenp, loff_t *ppos)
+static int proc_dohung_task_timeout_secs(const struct ctl_table *table,
+					 int write, void *buffer,
+					 size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9112d69d68b0..c0caa14880c3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -888,7 +888,7 @@ struct kimage *kexec_crash_image;
 static int kexec_load_disabled;
 
 #ifdef CONFIG_SYSCTL
-static int kexec_limit_handler(struct ctl_table *table, int write,
+static int kexec_limit_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct kexec_load_limit *limit = table->data;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 668ea401744b..fec9f6c4b0f1 100644
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
index 84c53285f499..b03af86018f4 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -65,8 +65,8 @@ static struct latency_record latency_record[MAXLR];
 int latencytop_enabled;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sysctl_latencytop(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index dc48fecfa1dc..afd7d54acb56 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -277,7 +277,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-static int pid_ns_ctl_handler(struct ctl_table *table, int write,
+static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index fe9fb991dc42..18ecaef6be41 100644
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
index 6206804d275b..6d00e89744e9 100644
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
index 3e47dedce9e5..6aaddb90149f 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -11,8 +11,9 @@
 
 static const int ten_thousand = 10000;
 
-static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table,
+					 int write, void *buffer,
+					 size_t *lenp, loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f9d32a110f9..d65f21c27304 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1835,7 +1835,7 @@ static void uclamp_sync_util_min_rt_default(void)
 		uclamp_update_util_min_rt_default(p);
 }
 
-static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
@@ -4603,7 +4603,7 @@ static void reset_memory_tiering(void)
 	}
 }
 
-static int sysctl_numa_balancing(struct ctl_table *table, int write,
+static int sysctl_numa_balancing(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4672,8 +4672,8 @@ static int __init setup_schedstats(char *str)
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
index aa4c1c874fa4..3f8c046755fd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -26,10 +26,10 @@ int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
+static int sched_rt_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
+static int sched_rr_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
 static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
@@ -2952,8 +2952,8 @@ static void sched_rt_do_global(void)
 	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sched_rt_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
 	static DEFINE_MUTEX(mutex);
@@ -2991,8 +2991,8 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
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
index 1d6eefa4032e..2b52f34dc35c 100644
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
index 7ed72723fb8a..97a3d0e81ac1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2334,7 +2334,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
 	return true;
 }
 
-static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int read_actions_logged(const struct ctl_table *ro_table, void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -2352,7 +2352,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
 	return proc_dostring(&table, 0, buffer, lenp, ppos);
 }
 
-static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
+static int write_actions_logged(const struct ctl_table *ro_table, void *buffer,
 				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];
@@ -2413,9 +2413,9 @@ static void audit_actions_logged(u32 actions_logged, u32 old_actions_logged,
 	return audit_seccomp_actions_logged(new, old, !ret);
 }
 
-static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
-					  void *buffer, size_t *lenp,
-					  loff_t *ppos)
+static int seccomp_actions_logged_handler(const struct ctl_table *ro_table,
+					  int write, void *buffer,
+					  size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 558b9d6d28d3..f64b2b3d0244 100644
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
index 62dd27752960..4d3e5cecbc88 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -256,7 +256,7 @@ static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
  *
  * Returns 0 on success.
  */
-int proc_dostring(struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write)
@@ -702,7 +702,7 @@ int do_proc_douintvec(const struct ctl_table *table, int write,
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
@@ -1121,7 +1121,7 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_minmax(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l, 1l);
@@ -1144,7 +1144,7 @@ int proc_doulongvec_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer,
@@ -1265,14 +1265,14 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
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
@@ -1298,7 +1298,7 @@ int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
@@ -1321,15 +1321,15 @@ int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_ms_jiffies(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
-static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int proc_do_cad_pid(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct pid *new_pid;
 	pid_t tmp;
@@ -1367,7 +1367,7 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_do_large_bitmap(struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
@@ -1499,85 +1499,85 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
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
@@ -1586,7 +1586,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 #endif /* CONFIG_PROC_SYSCTL */
 
 #if defined(CONFIG_SYSCTL)
-int proc_do_static_key(struct ctl_table *table, int write,
+int proc_do_static_key(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 48288dd4a102..64b0d8a0aa0f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -289,7 +289,7 @@ static void timers_update_migration(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static int timer_migration_handler(struct ctl_table *table, int write,
+static int timer_migration_handler(const struct ctl_table *table, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f783d7b279f6..db1ebe70866a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8223,7 +8223,7 @@ static bool is_permanent_ops_registered(void)
 }
 
 static int
-ftrace_enable_sysctl(struct ctl_table *table, int write,
+ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = -ENODEV;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..2e6a0b1142d3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2761,7 +2761,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
 }
 
-int tracepoint_printk_sysctl(struct ctl_table *table, int write,
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 304ceed9fd7d..a2f048c8382f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2811,7 +2811,7 @@ static int create_user_tracefs(void)
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
index 598b3ffe1522..ff1f13a27d29 100644
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
index 04e4513f2985..7282f61a8650 100644
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
index 941236828de8..6cbdd1143f06 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -974,7 +974,7 @@ static void proc_watchdog_update(void)
  * -------------------|----------------------------------|-------------------------------
  * proc_soft_watchdog | watchdog_softlockup_user_enabled | WATCHDOG_SOFTOCKUP_ENABLED
  */
-static int proc_watchdog_common(int which, struct ctl_table *table, int write,
+static int proc_watchdog_common(int which, const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old, *param = table->data;
@@ -1001,7 +1001,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-static int proc_watchdog(struct ctl_table *table, int write,
+static int proc_watchdog(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
@@ -1012,7 +1012,7 @@ static int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-static int proc_nmi_watchdog(struct ctl_table *table, int write,
+static int proc_nmi_watchdog(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
@@ -1025,7 +1025,7 @@ static int proc_nmi_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-static int proc_soft_watchdog(struct ctl_table *table, int write,
+static int proc_soft_watchdog(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
@@ -1036,7 +1036,7 @@ static int proc_soft_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-static int proc_watchdog_thresh(struct ctl_table *table, int write,
+static int proc_watchdog_thresh(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
@@ -1059,7 +1059,7 @@ static int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-static int proc_watchdog_cpumask(struct ctl_table *table, int write,
+static int proc_watchdog_cpumask(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
diff --git a/mm/compaction.c b/mm/compaction.c
index e731d45befc7..ea5957c2da39 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2955,7 +2955,7 @@ static int compact_nodes(void)
 	return 0;
 }
 
-static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
+static int compaction_proactiveness_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc, nid;
@@ -2985,7 +2985,7 @@ static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
  */
-static int sysctl_compaction_handler(struct ctl_table *table, int write,
+static int sysctl_compaction_handler(const struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
@@ -3296,7 +3296,7 @@ static int kcompactd_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
 		int write, void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, old;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8d12ce63a439..9b0834634e8b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4950,7 +4950,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_sysctl_handler(const struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 
@@ -4959,15 +4959,15 @@ static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
-			  void *buffer, size_t *length, loff_t *ppos)
+static int hugetlb_mempolicy_sysctl_handler(const struct ctl_table *table,
+			int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
 							buffer, length, ppos);
 }
 #endif /* CONFIG_NUMA */
 
-static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
+static int hugetlb_overcommit_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db5769cb12fd..b86aece672bf 100644
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
@@ -2151,8 +2151,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
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
index 33d4a1be927b..9810ea000e71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5135,7 +5135,7 @@ static char numa_zonelist_order[] = "Node";
 /*
  * sysctl handler for numa_zonelist_order
  */
-static int numa_zonelist_order_handler(struct ctl_table *table, int write,
+static int numa_zonelist_order_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	if (write)
@@ -6102,7 +6102,7 @@ postcore_initcall(init_per_zone_wmark_min)
  *	that we can call two helper functions whenever min_free_kbytes
  *	changes.
  */
-static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
+static int min_free_kbytes_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -6118,7 +6118,7 @@ static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
+static int watermark_scale_factor_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -6148,7 +6148,7 @@ static void setup_min_unmapped_ratio(void)
 }
 
 
-static int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *table, int write,
+static int sysctl_min_unmapped_ratio_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -6175,7 +6175,7 @@ static void setup_min_slab_ratio(void)
 						     sysctl_min_slab_ratio) / 100;
 }
 
-static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
+static int sysctl_min_slab_ratio_sysctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -6199,7 +6199,7 @@ static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int wri
  * minimum watermarks. The lowmem reserve ratio can only make sense
  * if in function of the boot time zone sizes.
  */
-static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
+static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int i;
@@ -6220,7 +6220,7 @@ static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
  * cpu. It is the fraction of total pages in each zone that a hot per cpu
  * pagelist can have before it gets flushed back to buddy allocator.
  */
-static int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
+static int percpu_pagelist_high_fraction_sysctl_handler(const struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	struct zone *zone;
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..958b9013d2f3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -835,8 +835,8 @@ int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_ratio_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -851,8 +851,8 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_policy_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -887,8 +887,8 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..33a032d69554 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -74,7 +74,7 @@ static void invalid_numa_statistics(void)
 
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
+int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret, oldval;
@@ -1887,7 +1887,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(struct ctl_table *table, int write,
+int vmstat_refresh(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 7948a9e7542c..0c95eb0ae8f0 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1177,7 +1177,7 @@ int br_nf_hook_thresh(unsigned int hook, struct net *net,
 
 #ifdef CONFIG_SYSCTL
 static
-int brnf_sysctl_call_tables(struct ctl_table *ctl, int write,
+int brnf_sysctl_call_tables(const struct ctl_table *ctl, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 92a01664a723..9a089e3bcd34 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3543,7 +3543,7 @@ EXPORT_SYMBOL(neigh_app_ns);
 #ifdef CONFIG_SYSCTL
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 
-static int proc_unres_qlen(struct ctl_table *ctl, int write,
+static int proc_unres_qlen(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int size, ret;
@@ -3595,7 +3595,7 @@ static void neigh_proc_update(const struct ctl_table *ctl, int write)
 		neigh_copy_dflt_parms(net, p, index);
 }
 
-static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_zero_intmax(const struct ctl_table *ctl, int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
@@ -3610,7 +3610,7 @@ static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl, int write,
 						   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
@@ -3626,7 +3626,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int wr
 	return ret;
 }
 
-int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec(const struct ctl_table *ctl, int write, void *buffer,
 			size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
@@ -3636,7 +3636,7 @@ int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec);
 
-int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3646,7 +3646,7 @@ int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_jiffies);
 
-static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_userhz_jiffies(const struct ctl_table *ctl, int write,
 					      void *buffer, size_t *lenp,
 					      loff_t *ppos)
 {
@@ -3656,7 +3656,7 @@ static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec_ms_jiffies(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_ms_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3666,7 +3666,7 @@ int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_ms_jiffies);
 
-static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_unres_qlen(const struct ctl_table *ctl, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
@@ -3676,7 +3676,7 @@ static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
+static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 903ab4a51c17..ba9842d773e3 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -94,7 +94,7 @@ static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
 	return rps_default_mask;
 }
 
-static int rps_default_mask_sysctl(struct ctl_table *table, int write,
+static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)table->data;
@@ -125,7 +125,7 @@ static int rps_default_mask_sysctl(struct ctl_table *table, int write,
 	return err;
 }
 
-static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
+static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int orig_size, size;
@@ -197,7 +197,7 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 #ifdef CONFIG_NET_FLOW_LIMIT
 static DEFINE_MUTEX(flow_limit_update_mutex);
 
-static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
+static int flow_limit_cpu_sysctl(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct sd_flow_limit *cur;
@@ -254,7 +254,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
+static int flow_limit_table_len_sysctl(const struct ctl_table *table, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int old, *ptr;
@@ -276,7 +276,7 @@ static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
 #endif /* CONFIG_NET_FLOW_LIMIT */
 
 #ifdef CONFIG_NET_SCHED
-static int set_default_qdisc(struct ctl_table *table, int write,
+static int set_default_qdisc(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char id[IFNAMSIZ];
@@ -295,7 +295,7 @@ static int set_default_qdisc(struct ctl_table *table, int write,
 }
 #endif
 
-static int proc_do_dev_weight(struct ctl_table *table, int write,
+static int proc_do_dev_weight(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	static DEFINE_MUTEX(dev_weight_mutex);
@@ -313,7 +313,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_do_rss_key(struct ctl_table *table, int write,
+static int proc_do_rss_key(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
@@ -326,7 +326,7 @@ static int proc_do_rss_key(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_BPF_JIT
-static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
+static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
@@ -359,7 +359,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 
 # ifdef CONFIG_HAVE_EBPF_JIT
 static int
-proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dointvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -370,7 +370,7 @@ proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 # endif /* CONFIG_HAVE_EBPF_JIT */
 
 static int
-proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dolongvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7592f242336b..2e6912c1fb21 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2377,7 +2377,7 @@ static int devinet_conf_ifindex(struct net *net, struct ipv4_devconf *cnf)
 	}
 }
 
-static int devinet_conf_proc(struct ctl_table *ctl, int write,
+static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int old_value = *(int *)ctl->data;
@@ -2429,7 +2429,7 @@ static int devinet_conf_proc(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int devinet_sysctl_forward(struct ctl_table *ctl, int write,
+static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -2476,7 +2476,7 @@ static int devinet_sysctl_forward(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int ipv4_doint_and_flush(struct ctl_table *ctl, int write,
+static int ipv4_doint_and_flush(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 2e29ab819967..d2e88f3e6fe8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3394,7 +3394,7 @@ static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
 static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
-static int ipv4_sysctl_rtcache_flush(struct ctl_table *__ctl, int write,
+static int ipv4_sysctl_rtcache_flush(const struct ctl_table *__ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)__ctl->extra1;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index fc4c001bf72a..4c3a03b7a0f8 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -62,7 +62,7 @@ static void set_local_port_range(struct net *net, unsigned int low, unsigned int
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_local_port_range(struct ctl_table *table, int write,
+static int ipv4_local_port_range(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = table->data;
@@ -96,7 +96,7 @@ static int ipv4_local_port_range(struct ctl_table *table, int write,
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_privileged_ports(struct ctl_table *table, int write,
+static int ipv4_privileged_ports(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -159,7 +159,7 @@ static void set_ping_group_range(const struct ctl_table *table,
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_ping_group_range(struct ctl_table *table, int write,
+static int ipv4_ping_group_range(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct user_namespace *user_ns = current_user_ns();
@@ -194,7 +194,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipv4_fwd_update_priority(struct ctl_table *table, int write,
+static int ipv4_fwd_update_priority(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
@@ -210,7 +210,7 @@ static int ipv4_fwd_update_priority(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_tcp_congestion_control(struct ctl_table *ctl, int write,
+static int proc_tcp_congestion_control(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net,
@@ -230,7 +230,7 @@ static int proc_tcp_congestion_control(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_tcp_available_congestion_control(struct ctl_table *ctl,
+static int proc_tcp_available_congestion_control(const struct ctl_table *ctl,
 						 int write, void *buffer,
 						 size_t *lenp, loff_t *ppos)
 {
@@ -246,7 +246,7 @@ static int proc_tcp_available_congestion_control(struct ctl_table *ctl,
 	return ret;
 }
 
-static int proc_allowed_congestion_control(struct ctl_table *ctl,
+static int proc_allowed_congestion_control(const struct ctl_table *ctl,
 					   int write, void *buffer,
 					   size_t *lenp, loff_t *ppos)
 {
@@ -283,7 +283,7 @@ static int sscanf_key(char *buf, __le32 *key)
 	return ret;
 }
 
-static int proc_tcp_fastopen_key(struct ctl_table *table, int write,
+static int proc_tcp_fastopen_key(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -354,7 +354,7 @@ static int proc_tcp_fastopen_key(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_tfo_blackhole_detect_timeout(struct ctl_table *table,
+static int proc_tfo_blackhole_detect_timeout(const struct ctl_table *table,
 					     int write, void *buffer,
 					     size_t *lenp, loff_t *ppos)
 {
@@ -369,7 +369,7 @@ static int proc_tfo_blackhole_detect_timeout(struct ctl_table *table,
 	return ret;
 }
 
-static int proc_tcp_available_ulp(struct ctl_table *ctl,
+static int proc_tcp_available_ulp(const struct ctl_table *ctl,
 				  int write, void *buffer, size_t *lenp,
 				  loff_t *ppos)
 {
@@ -386,7 +386,7 @@ static int proc_tcp_available_ulp(struct ctl_table *ctl,
 	return ret;
 }
 
-static int proc_tcp_ehash_entries(struct ctl_table *table, int write,
+static int proc_tcp_ehash_entries(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -410,7 +410,7 @@ static int proc_tcp_ehash_entries(struct ctl_table *table, int write,
 	return proc_dointvec(&tbl, write, buffer, lenp, ppos);
 }
 
-static int proc_udp_hash_entries(struct ctl_table *table, int write,
+static int proc_udp_hash_entries(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -434,8 +434,8 @@ static int proc_udp_hash_entries(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
-					  void *buffer, size_t *lenp,
+static int proc_fib_multipath_hash_policy(const struct ctl_table *table,
+					  int write, void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
@@ -449,8 +449,8 @@ static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_fib_multipath_hash_fields(struct ctl_table *table, int write,
-					  void *buffer, size_t *lenp,
+static int proc_fib_multipath_hash_fields(const struct ctl_table *table,
+					  int write, void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
 	struct net *net;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 96ab349e8ba4..5190acc3c4f8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6308,7 +6308,7 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 
 #ifdef CONFIG_SYSCTL
 
-static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6333,7 +6333,7 @@ static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_mtu(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_mtu(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct inet6_dev *idev = ctl->extra1;
@@ -6404,7 +6404,7 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 	return 0;
 }
 
-static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6429,7 +6429,7 @@ static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
@@ -6470,7 +6470,7 @@ static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6533,7 +6533,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6601,7 +6601,7 @@ static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
 }
 
 static
-int addrconf_sysctl_ignore_routes_with_linkdown(struct ctl_table *ctl,
+int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 						int write, void *buffer,
 						size_t *lenp,
 						loff_t *ppos)
@@ -6701,8 +6701,9 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 	return 0;
 }
 
-static int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
-				   void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl,
+					  int write, void *buffer,
+					  size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 945d5f5ca039..abcd93bee5d7 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1951,7 +1951,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 	}
 }
 
-int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write, void *buffer,
+int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct net_device *dev = ctl->extra1;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1f4b935a0e57..c8340013bf72 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6329,7 +6329,7 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
 
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
index 5d2012d1cf4a..9ed2db996ec1 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1347,7 +1347,7 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 #define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
 	(&((struct mpls_dev *)0)->field)
 
-static int mpls_conf_proc(struct ctl_table *ctl, int write,
+static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int oval = *(int *)ctl->data;
@@ -2601,7 +2601,7 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	return -ENOMEM;
 }
 
-static int mpls_platform_labels(struct ctl_table *table, int write,
+static int mpls_platform_labels(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = table->data;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 689ac521ea2d..e34879f7a2f4 100644
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
@@ -1984,7 +1984,7 @@ static int ipvs_proc_est_cpumask_get(const struct ctl_table *table,
 	return ret;
 }
 
-static int ipvs_proc_est_cpulist(struct ctl_table *table, int write,
+static int ipvs_proc_est_cpulist(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -2011,7 +2011,7 @@ static int ipvs_proc_est_cpulist(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int ipvs_proc_est_nice(struct ctl_table *table, int write,
+static int ipvs_proc_est_nice(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct netns_ipvs *ipvs = table->extra2;
@@ -2041,7 +2041,7 @@ static int ipvs_proc_est_nice(struct ctl_table *table, int write,
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
index efedd2f13ac7..a8edc3e75db9 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -409,7 +409,7 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
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
index 25bdf17c7262..3af5d7b05ae9 100644
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
-				size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write, void *buffer,
-				 size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
+				void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos);
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
index f86970733eb0..09832e4945a3 100644
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
index 6239777090c4..16568b6d589d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2029,7 +2029,7 @@ static int __init alloc_buffers(void)
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
index b6684a074a59..5b762f452977 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -435,7 +435,7 @@ static struct security_hook_list yama_hooks[] __ro_after_init = {
 };
 
 #ifdef CONFIG_SYSCTL
-static int yama_dointvec_minmax(struct ctl_table *table, int write,
+static int yama_dointvec_minmax(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table table_copy;

-- 
2.44.0


