Return-Path: <linux-fsdevel+bounces-14537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E226B87D599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE131C23303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6465D491;
	Fri, 15 Mar 2024 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J6/pl2CR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421E5C8F6;
	Fri, 15 Mar 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535720; cv=none; b=HKE131LfWx/M1vJyTh5RYH7L8RFaHQmBJG+t7N4Nx2S2wpHwRfcUbTTNk1H7xixixS5MbiQcvQTKeTE3BCfD3ma2PJFtEfpc5FmsWEpjxn7d/oy3zhbNG0ScTDzF+VRyxgkay4eXSe4ecCVzM41mbpqv6GvZx2/2/50a75CVeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535720; c=relaxed/simple;
	bh=hccxx2UrNcPilqq2dEB/zO8lgaRy4vFcvfyKGNpTTKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRTeQrOAqX3X57ZgtPgD0klIC/lbR00TTXfduvF1OL0ZD3UVr/wrEBQXVXovfHf39wGWhClY8T+nZvHIm0xiBu60yy3j24/cHd/4x9ParzhMirMqwZxMgyOERlF2J/dyLbJr6EPtfsp8boG/qD+dELxfwH/JvqLRpa2SPV9lcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J6/pl2CR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535699;
	bh=hccxx2UrNcPilqq2dEB/zO8lgaRy4vFcvfyKGNpTTKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6/pl2CROMvE8X3YIh/Nk1y5EcWGa+bR5RixwrlxROwmmrbY+5Gxjshs2+d+LeX4P
	 R7PYzE8jyc+IJUlHIHnCo0kDOC38Z1BDLB95rEJH0aJyrsvJvlO/edrTGxeNzVWvqE
	 3h34bBhTZhkXyNxhw+M6ZaciGY+bBP1mJzveGq0A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:48:09 +0100
Subject: [PATCH 11/11] sysctl: treewide: constify the ctl_table argument of
 handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-sysctl-const-handler-v1-11-1322ac7cb03d@weissschuh.net>
References: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
In-Reply-To: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>, 
 Julian Anastasov <ja@ssi.bg>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Phillip Potter <phil@philpotter.co.uk>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
 Mark Rutland <mark.rutland@arm.com>, Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Biederman <ebiederm@xmission.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Balbir Singh <bsingharora@gmail.com>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Alexander Popov <alex.popov@linux.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kexec@lists.infradead.org, 
 bridge@lists.linux.dev, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=112761;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hccxx2UrNcPilqq2dEB/zO8lgaRy4vFcvfyKGNpTTKE=;
 b=Y/YcmLFIBfed1oYW4aBK76N8hTrI1Z5ECDFj9zpVN2k8qy0ZL7AtOEb4Gv2yCuvDV41iShQxU
 BFgIV3WdvyaBbT8TUPU+DDlwMiLp3XX6s3dAlneGcg2BtszsUoYjXOk
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
 arch/s390/appldata/appldata_base.c        | 10 ++--
 arch/s390/kernel/debug.c                  |  2 +-
 arch/s390/kernel/topology.c               |  2 +-
 arch/s390/mm/cmm.c                        |  6 +--
 arch/x86/kernel/itmt.c                    |  2 +-
 drivers/cdrom/cdrom.c                     |  6 +--
 drivers/char/random.c                     |  5 +-
 drivers/macintosh/mac_hid.c               |  2 +-
 drivers/net/vrf.c                         |  2 +-
 drivers/parport/procfs.c                  | 14 ++---
 drivers/perf/arm_pmuv3.c                  |  6 ++-
 drivers/perf/riscv_pmu_sbi.c              |  2 +-
 fs/coredump.c                             |  4 +-
 fs/dcache.c                               |  3 +-
 fs/drop_caches.c                          |  4 +-
 fs/exec.c                                 |  6 ++-
 fs/file_table.c                           |  3 +-
 fs/fs-writeback.c                         |  2 +-
 fs/inode.c                                |  3 +-
 fs/pipe.c                                 |  2 +-
 fs/quota/dquot.c                          |  4 +-
 fs/xfs/xfs_sysctl.c                       | 33 ++++++------
 include/linux/ftrace.h                    |  4 +-
 include/linux/mm.h                        |  8 +--
 include/linux/perf_event.h                |  6 +--
 include/linux/security.h                  |  2 +-
 include/linux/sysctl.h                    | 34 ++++++------
 include/linux/vmstat.h                    |  6 +--
 include/linux/writeback.h                 |  2 +-
 include/net/ndisc.h                       |  2 +-
 include/net/neighbour.h                   |  6 +--
 include/net/netfilter/nf_hooks_lwtunnel.h |  2 +-
 ipc/ipc_sysctl.c                          | 14 ++---
 kernel/bpf/syscall.c                      |  4 +-
 kernel/delayacct.c                        |  5 +-
 kernel/events/callchain.c                 |  2 +-
 kernel/events/core.c                      |  9 ++--
 kernel/fork.c                             |  2 +-
 kernel/hung_task.c                        |  7 +--
 kernel/kexec_core.c                       |  2 +-
 kernel/kprobes.c                          |  2 +-
 kernel/latencytop.c                       |  5 +-
 kernel/pid_namespace.c                    |  4 +-
 kernel/pid_sysctl.h                       |  2 +-
 kernel/printk/internal.h                  |  2 +-
 kernel/printk/printk.c                    |  2 +-
 kernel/printk/sysctl.c                    |  6 ++-
 kernel/sched/core.c                       | 15 +++---
 kernel/sched/rt.c                         | 20 ++++---
 kernel/sched/topology.c                   |  6 ++-
 kernel/seccomp.c                          |  7 +--
 kernel/stackleak.c                        |  5 +-
 kernel/sysctl.c                           | 88 ++++++++++++++++---------------
 kernel/time/timer.c                       |  4 +-
 kernel/trace/ftrace.c                     |  2 +-
 kernel/trace/trace.c                      |  2 +-
 kernel/trace/trace_events_user.c          |  3 +-
 kernel/trace/trace_stack.c                |  2 +-
 kernel/umh.c                              |  4 +-
 kernel/utsname_sysctl.c                   |  4 +-
 kernel/watchdog.c                         | 15 +++---
 mm/compaction.c                           | 17 +++---
 mm/hugetlb.c                              | 16 +++---
 mm/page-writeback.c                       | 27 ++++++----
 mm/page_alloc.c                           | 43 ++++++++++-----
 mm/util.c                                 | 15 +++---
 mm/vmstat.c                               |  6 +--
 net/bridge/br_netfilter_hooks.c           |  2 +-
 net/core/neighbour.c                      | 24 +++++----
 net/core/sysctl_net_core.c                | 24 +++++----
 net/ipv4/devinet.c                        |  6 +--
 net/ipv4/route.c                          |  4 +-
 net/ipv4/sysctl_net_ipv4.c                | 34 ++++++------
 net/ipv6/addrconf.c                       | 30 ++++++-----
 net/ipv6/ndisc.c                          |  5 +-
 net/ipv6/route.c                          |  4 +-
 net/ipv6/sysctl_net_ipv6.c                |  6 ++-
 net/mpls/af_mpls.c                        |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c            | 12 ++---
 net/netfilter/nf_conntrack_standalone.c   |  2 +-
 net/netfilter/nf_hooks_lwtunnel.c         |  2 +-
 net/netfilter/nf_log.c                    |  4 +-
 net/phonet/sysctl.c                       |  2 +-
 net/rds/tcp.c                             |  4 +-
 net/sctp/sysctl.c                         | 30 ++++++-----
 net/sunrpc/sysctl.c                       |  5 +-
 net/sunrpc/xprtrdma/svc_rdma.c            |  2 +-
 security/apparmor/lsm.c                   |  2 +-
 security/min_addr.c                       |  2 +-
 security/yama/yama_lsm.c                  |  2 +-
 92 files changed, 433 insertions(+), 347 deletions(-)

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
index a5e07270e0d4..2d5e4adcfc1f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3473,8 +3473,8 @@ static int cdrom_print_info(const char *header, int val, char *info,
 	return 0;
 }
 
-static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
-                           void *buffer, size_t *lenp, loff_t *ppos)
+static int cdrom_sysctl_info(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
 	char *info = cdrom_sysctl_settings.info;
@@ -3586,7 +3586,7 @@ static void cdrom_update_settings(void)
 	mutex_unlock(&cdrom_mutex);
 }
 
-static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
+static int cdrom_sysctl_handler(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 456be28ba67c..055ed0aa1de8 100644
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
@@ -1635,7 +1635,8 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buf,
 }
 
 /* The same as proc_dointvec, but writes don't change anything. */
-static int proc_do_rointvec(struct ctl_table *table, int write, void *buf,
+static int proc_do_rointvec(const struct ctl_table *table, int write,
+			    void *buf,
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
index bb95ce43cd97..5d4283c2c022 100644
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
index bd388560ed59..2349b5dfece4 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -33,8 +33,8 @@
 #define PARPORT_MIN_SPINTIME_VALUE 1
 #define PARPORT_MAX_SPINTIME_VALUE 1000
 
-static int do_active_device(struct ctl_table *table, int write,
-		      void *result, size_t *lenp, loff_t *ppos)
+static int do_active_device(const struct ctl_table *table, int write,
+			    void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[256];
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
index 23fa6c5da82c..83d12dc83313 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1253,8 +1253,10 @@ static void armv8pmu_disable_user_access_ipi(void *unused)
 	armv8pmu_disable_user_access();
 }
 
-static int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int armv8pmu_proc_user_access_handler(const struct ctl_table *table,
+					     int write,
+					     void *buffer, size_t *lenp,
+					     loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret || !write || sysctl_perf_user_access)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..9beda75e2e18 100644
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
index be6403b4b14b..3c9a9782ec05 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -988,8 +988,8 @@ void validate_coredump_safety(void)
 	}
 }
 
-static int proc_dostring_coredump(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dostring_coredump(const struct ctl_table *table, int write,
+				  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error = proc_dostring(table, write, buffer, lenp, ppos);
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 71a8e943a0fa..0118e47578c2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -174,7 +174,8 @@ static long get_nr_dentry_negative(void)
 	return sum < 0 ? 0 : sum;
 }
 
-static int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
+static int proc_nr_dentry(const struct ctl_table *table, int write,
+			  void *buffer,
 			  size_t *lenp, loff_t *ppos)
 {
 	dentry_stat.nr_dentry = get_nr_dentry();
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index b9575957a7c2..023482823ff1 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -48,8 +48,8 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	iput(toput_inode);
 }
 
-int drop_caches_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
+			       void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
 
diff --git a/fs/exec.c b/fs/exec.c
index ff6f26671cfc..1e17a798053b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2161,8 +2161,10 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 
 #ifdef CONFIG_SYSCTL
 
-static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_coredump(const struct ctl_table *table,
+					 int write,
+					 void *buffer, size_t *lenp,
+					 loff_t *ppos)
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..1d4f71072d28 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -96,7 +96,8 @@ EXPORT_SYMBOL_GPL(get_max_files);
 /*
  * Handle nr_files sysctl
  */
-static int proc_nr_files(struct ctl_table *table, int write, void *buffer,
+static int proc_nr_files(const struct ctl_table *table, int write,
+			 void *buffer,
 			 size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e4f17c53ddfc..535a1108960f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2404,7 +2404,7 @@ static int __init start_dirtytime_writeback(void)
 }
 __initcall(start_dirtytime_writeback);
 
-int dirtytime_interval_handler(struct ctl_table *table, int write,
+int dirtytime_interval_handler(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..3b5bbb70a18c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -107,7 +107,8 @@ long get_nr_dirty_inodes(void)
  */
 static struct inodes_stat_t inodes_stat;
 
-static int proc_nr_inodes(struct ctl_table *table, int write, void *buffer,
+static int proc_nr_inodes(const struct ctl_table *table, int write,
+			  void *buffer,
 			  size_t *lenp, loff_t *ppos)
 {
 	inodes_stat.nr_inodes = get_nr_inodes();
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
index dacbee455c03..b33df45426f4 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2911,8 +2911,8 @@ const struct quotactl_ops dquot_quotactl_sysfile_ops = {
 };
 EXPORT_SYMBOL(dquot_quotactl_sysfile_ops);
 
-static int do_proc_dqstats(struct ctl_table *table, int write,
-		     void *buffer, size_t *lenp, loff_t *ppos)
+static int do_proc_dqstats(const struct ctl_table *table, int write,
+			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int type = (unsigned long *)table->data - dqstats.stat;
 	s64 value = percpu_counter_sum(&dqstats.counter[type]);
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index a191f6560f98..a3ca192eca79 100644
--- a/fs/xfs/xfs_sysctl.c
+++ b/fs/xfs/xfs_sysctl.c
@@ -10,12 +10,11 @@ static struct ctl_table_header *xfs_table_header;
 
 #ifdef CONFIG_PROC_FS
 STATIC int
-xfs_stats_clear_proc_handler(
-	struct ctl_table	*ctl,
-	int			write,
-	void			*buffer,
-	size_t			*lenp,
-	loff_t			*ppos)
+xfs_stats_clear_proc_handler(const struct ctl_table *ctl,
+			     int			write,
+			     void			*buffer,
+			     size_t			*lenp,
+			     loff_t			*ppos)
 {
 	int		ret, *valp = ctl->data;
 
@@ -30,12 +29,11 @@ xfs_stats_clear_proc_handler(
 }
 
 STATIC int
-xfs_panic_mask_proc_handler(
-	struct ctl_table	*ctl,
-	int			write,
-	void			*buffer,
-	size_t			*lenp,
-	loff_t			*ppos)
+xfs_panic_mask_proc_handler(const struct ctl_table *ctl,
+			    int			write,
+			    void			*buffer,
+			    size_t			*lenp,
+			    loff_t			*ppos)
 {
 	int		ret, *valp = ctl->data;
 
@@ -51,12 +49,11 @@ xfs_panic_mask_proc_handler(
 #endif /* CONFIG_PROC_FS */
 
 STATIC int
-xfs_deprecated_dointvec_minmax(
-	struct ctl_table	*ctl,
-	int			write,
-	void			*buffer,
-	size_t			*lenp,
-	loff_t			*ppos)
+xfs_deprecated_dointvec_minmax(const struct ctl_table *ctl,
+			       int			write,
+			       void			*buffer,
+			       size_t			*lenp,
+			       loff_t			*ppos)
 {
 	if (write) {
 		printk_ratelimited(KERN_WARNING
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
index 0436b919f1c7..f047b5752a78 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -203,11 +203,11 @@ extern int sysctl_overcommit_memory;
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
@@ -3837,7 +3837,7 @@ extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
+int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 #endif
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..707d5fe5da9c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1598,11 +1598,11 @@ extern int sysctl_perf_cpu_time_max_percent;
 
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
index f249f5b9a9d7..f12d1b7d650e 100644
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
index 99ea26b16c0d..97901dae1348 100644
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
@@ -288,7 +288,7 @@ static inline bool sysctl_is_alias(char *param)
 }
 #endif /* CONFIG_SYSCTL */
 
-int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
+int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 #endif /* _LINUX_SYSCTL_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 343906a98d6e..0282aba4faa0 100644
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
index 9845cb62e40b..e58b039aa592 100644
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
index 45cb1dabce29..c40e9384fb1b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -17,8 +17,10 @@
 #include <linux/cred.h>
 #include "util.h"
 
-static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_ipc_dointvec_minmax_orphans(const struct ctl_table *table,
+					    int write,
+					    void *buffer, size_t *lenp,
+					    loff_t *ppos)
 {
 	struct ipc_namespace *ns =
 		container_of(table->data, struct ipc_namespace, shm_rmid_forced);
@@ -33,8 +35,8 @@ static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
 	return err;
 }
 
-static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_ipc_auto_msgmni(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table ipc_table;
 	int dummy = 0;
@@ -48,8 +50,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
 }
 
-static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
-	void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_ipc_sem_dointvec(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ipc_namespace *ns =
 		container_of(table->data, struct ipc_namespace, sem_ctls);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..08f92fb3cefa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5904,7 +5904,7 @@ const struct bpf_prog_ops bpf_syscall_prog_ops = {
 };
 
 #ifdef CONFIG_SYSCTL
-static int bpf_stats_handler(struct ctl_table *table, int write,
+static int bpf_stats_handler(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
@@ -5939,7 +5939,7 @@ void __weak unpriv_ebpf_notify(int new_state)
 {
 }
 
-static int bpf_unpriv_handler(struct ctl_table *table, int write,
+static int bpf_unpriv_handler(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, unpriv_enable = *(int *)table->data;
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..513791ef573d 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,8 +44,9 @@ void delayacct_init(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
-		     size_t *lenp, loff_t *ppos)
+static int sysctl_delayacct(const struct ctl_table *table, int write,
+			    void *buffer,
+			    size_t *lenp, loff_t *ppos)
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
index 724e6d7e128f..e2955e0d9f44 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -450,7 +450,8 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
+int perf_event_max_sample_rate_handler(const struct ctl_table *table,
+				       int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -474,8 +475,10 @@ int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
 
 int sysctl_perf_cpu_time_max_percent __read_mostly = DEFAULT_CPU_TIME_MAX_PERCENT;
 
-int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int perf_cpu_time_max_percent_handler(const struct ctl_table *table,
+				      int write,
+				      void *buffer, size_t *lenp,
+				      loff_t *ppos)
 {
 	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..7be1dc035fe1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3417,7 +3417,7 @@ int unshare_files(void)
 	return 0;
 }
 
-int sysctl_max_threads(struct ctl_table *table, int write,
+int sysctl_max_threads(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2fc2727d654..003f0f5cb111 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -239,9 +239,10 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 /*
  * Process updating of timeout sysctl
  */
-static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-				  void *buffer,
-				  size_t *lenp, loff_t *ppos)
+static int proc_dohung_task_timeout_secs(const struct ctl_table *table,
+					 int write,
+					 void *buffer,
+					 size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 0e96f6b24344..a6995bb89eef 100644
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
index 9d9095e81792..83771c44fc3a 100644
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
index 781249098cb6..0a5c22b19821 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -65,8 +65,9 @@ static struct latency_record latency_record[MAXLR];
 int latencytop_enabled;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sysctl_latencytop(const struct ctl_table *table, int write,
+			     void *buffer,
+			     size_t *lenp, loff_t *ppos)
 {
 	int err;
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7ade20e95232..008c32f11bbc 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -277,8 +277,8 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-static int pid_ns_ctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(current);
 	struct ctl_table tmp = *table;
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
index ca5146006b94..c96ae16ca2cd 100644
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
index c228343eeb97..2571651aa1ce 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -11,8 +11,10 @@
 
 static const int ten_thousand = 10000;
 
-static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table,
+					 int write,
+					 void *buffer, size_t *lenp,
+					 loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0621e4ee31de..ea143bb63f63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1835,8 +1835,10 @@ static void uclamp_sync_util_min_rt_default(void)
 		uclamp_update_util_min_rt_default(p);
 }
 
-static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int sysctl_sched_uclamp_handler(const struct ctl_table *table,
+				       int write,
+				       void *buffer, size_t *lenp,
+				       loff_t *ppos)
 {
 	bool update_root_tg = false;
 	int old_min, old_max, old_min_rt;
@@ -4603,8 +4605,8 @@ static void reset_memory_tiering(void)
 	}
 }
 
-static int sysctl_numa_balancing(struct ctl_table *table, int write,
-			  void *buffer, size_t *lenp, loff_t *ppos)
+static int sysctl_numa_balancing(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int err;
@@ -4672,8 +4674,9 @@ static int __init setup_schedstats(char *str)
 __setup("schedstats=", setup_schedstats);
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sysctl_schedstats(const struct ctl_table *table, int write,
+			     void *buffer,
+			     size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int err;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..3bbf29d4e110 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -26,10 +26,12 @@ int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
+static int sched_rt_handler(const struct ctl_table *table, int write,
+			    void *buffer,
+			    size_t *lenp, loff_t *ppos);
+static int sched_rr_handler(const struct ctl_table *table, int write,
+			    void *buffer,
+			    size_t *lenp, loff_t *ppos);
 static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
@@ -2953,8 +2955,9 @@ static void sched_rt_do_global(void)
 	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
-static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sched_rt_handler(const struct ctl_table *table, int write,
+			    void *buffer,
+			    size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
 	static DEFINE_MUTEX(mutex);
@@ -2992,8 +2995,9 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int sched_rr_handler(const struct ctl_table *table, int write,
+			    void *buffer,
+			    size_t *lenp, loff_t *ppos)
 {
 	int ret;
 	static DEFINE_MUTEX(mutex);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..1c582cee6144 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -285,8 +285,10 @@ void rebuild_sched_domains_energy(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-static int sched_energy_aware_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int sched_energy_aware_handler(const struct ctl_table *table,
+				      int write,
+				      void *buffer, size_t *lenp,
+				      loff_t *ppos)
 {
 	int ret, state;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index aca7b437882e..397118a24631 100644
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
@@ -2413,7 +2413,8 @@ static void audit_actions_logged(u32 actions_logged, u32 old_actions_logged,
 	return audit_seccomp_actions_logged(new, old, !ret);
 }
 
-static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
+static int seccomp_actions_logged_handler(const struct ctl_table *ro_table,
+					  int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index b292e5ca0b7d..abe530071c20 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -21,8 +21,9 @@
 static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
 #ifdef CONFIG_SYSCTL
-static int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+static int stack_erasing_sysctl(const struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos)
 {
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 93824d8a3636..e06478682bb8 100644
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
@@ -758,8 +758,8 @@ int proc_dointvec(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_douintvec(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int proc_douintvec(const struct ctl_table *table, int write, void *buffer,
+		   size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_conv, NULL);
@@ -769,7 +769,7 @@ int proc_douintvec(struct ctl_table *table, int write, void *buffer,
  * Taint values can only be increased
  * This means we can safely use a temporary.
  */
-static int proc_taint(struct ctl_table *table, int write,
+static int proc_taint(const struct ctl_table *table, int write,
 			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -864,8 +864,8 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  *
  * Returns 0 on success or -EINVAL on write when the range check fails.
  */
-int proc_dointvec_minmax(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
+int proc_dointvec_minmax(const struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct do_proc_dointvec_minmax_conv_param param = {
 		.min = (int *) table->extra1,
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
@@ -1144,7 +1144,8 @@ int proc_doulongvec_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table,
+				      int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, buffer,
@@ -1265,15 +1266,15 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
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
-			  void *buffer, size_t *lenp, loff_t *ppos)
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct do_proc_dointvec_minmax_conv_param param = {
 		.min = (int *) table->extra1,
@@ -1298,7 +1299,7 @@ int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
@@ -1321,15 +1322,17 @@ int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_ms_jiffies(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write,
+			     void *buffer,
+			     size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_ms_jiffies_conv, NULL);
 }
 
-static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int proc_do_cad_pid(const struct ctl_table *table, int write,
+			   void *buffer,
+			   size_t *lenp, loff_t *ppos)
 {
 	struct pid *new_pid;
 	pid_t tmp;
@@ -1367,7 +1370,7 @@ static int proc_do_cad_pid(struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_do_large_bitmap(struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
@@ -1499,85 +1502,86 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
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
-		  void *buffer, size_t *lenp, loff_t *ppos)
+int proc_douintvec(const struct ctl_table *table, int write,
+		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_minmax(struct ctl_table *table, int write,
-		    void *buffer, size_t *lenp, loff_t *ppos)
+int proc_dointvec_minmax(const struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
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
-		    void *buffer, size_t *lenp, loff_t *ppos)
+int proc_dointvec_jiffies(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
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
-		    void *buffer, size_t *lenp, loff_t *ppos)
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
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
-		    void *buffer, size_t *lenp, loff_t *ppos)
+int proc_doulongvec_minmax(const struct ctl_table *table, int write,
+			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table,
+				      int write,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_do_large_bitmap(struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -1586,7 +1590,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 #endif /* CONFIG_PROC_SYSCTL */
 
 #if defined(CONFIG_SYSCTL)
-int proc_do_static_key(struct ctl_table *table, int write,
+int proc_do_static_key(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ff49ddcc9800..57bece67ad0e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -289,8 +289,8 @@ static void timers_update_migration(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos)
+static int timer_migration_handler(const struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83ba342aef31..d3f77aff71c3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8217,7 +8217,7 @@ static bool is_permanent_ops_registered(void)
 }
 
 static int
-ftrace_enable_sysctl(struct ctl_table *table, int write,
+ftrace_enable_sysctl(const struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = -ENODEV;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b12f8384a36a..2ae437ca5b73 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2730,7 +2730,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
 }
 
-int tracepoint_printk_sysctl(struct ctl_table *table, int write,
+int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..00547aad3972 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2811,7 +2811,8 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
-static int set_max_user_events_sysctl(struct ctl_table *table, int write,
+static int set_max_user_events_sysctl(const struct ctl_table *table,
+				      int write,
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
index 1b13c5d34624..43bc45be8997 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -495,8 +495,8 @@ int call_usermodehelper(const char *path, char **argv, char **envp, int wait)
 EXPORT_SYMBOL(call_usermodehelper);
 
 #if defined(CONFIG_SYSCTL)
-static int proc_cap_handler(struct ctl_table *table, int write,
-			 void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_cap_handler(const struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	unsigned long cap_array[2];
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 46590d4addc8..653727aae63b 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -30,8 +30,8 @@ static void *get_uts(const struct ctl_table *table)
  *	Special case of dostring for the UTS structure. This has locks
  *	to observe. Should this be in kernel/sys.c ????
  */
-static int proc_do_uts_string(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_do_uts_string(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table uts_table;
 	int r;
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d7b2125503af..e9d0b854b587 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -769,8 +769,9 @@ static void proc_watchdog_update(void)
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
 
@@ -796,7 +797,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-static int proc_watchdog(struct ctl_table *table, int write,
+static int proc_watchdog(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
@@ -807,7 +808,7 @@ static int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-static int proc_nmi_watchdog(struct ctl_table *table, int write,
+static int proc_nmi_watchdog(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
@@ -820,7 +821,7 @@ static int proc_nmi_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-static int proc_soft_watchdog(struct ctl_table *table, int write,
+static int proc_soft_watchdog(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
@@ -831,7 +832,7 @@ static int proc_soft_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-static int proc_watchdog_thresh(struct ctl_table *table, int write,
+static int proc_watchdog_thresh(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
@@ -854,7 +855,7 @@ static int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-static int proc_watchdog_cpumask(struct ctl_table *table, int write,
+static int proc_watchdog_cpumask(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
diff --git a/mm/compaction.c b/mm/compaction.c
index 807b58e6eb68..6b8db0442365 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2950,8 +2950,11 @@ static int compact_nodes(void)
 	return 0;
 }
 
-static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int compaction_proactiveness_sysctl_handler(const struct ctl_table *table,
+						   int write,
+						   void *buffer,
+						   size_t *length,
+						   loff_t *ppos)
 {
 	int rc, nid;
 
@@ -2980,8 +2983,9 @@ static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
  */
-static int sysctl_compaction_handler(struct ctl_table *table, int write,
-			void *buffer, size_t *length, loff_t *ppos)
+static int sysctl_compaction_handler(const struct ctl_table *table, int write,
+				     void *buffer, size_t *length,
+				     loff_t *ppos)
 {
 	int ret;
 
@@ -3291,8 +3295,9 @@ static int kcompactd_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
+					       int write, void *buffer,
+					       size_t *lenp, loff_t *ppos)
 {
 	int ret, old;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b0d89ab98eaa..8b4c87820a38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4968,8 +4968,8 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
-			  void *buffer, size_t *length, loff_t *ppos)
+static int hugetlb_sysctl_handler(const struct ctl_table *table, int write,
+				  void *buffer, size_t *length, loff_t *ppos)
 {
 
 	return hugetlb_sysctl_handler_common(false, table, write,
@@ -4977,16 +4977,20 @@ static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
-			  void *buffer, size_t *length, loff_t *ppos)
+static int hugetlb_mempolicy_sysctl_handler(const struct ctl_table *table,
+					    int write,
+					    void *buffer, size_t *length,
+					    loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
 							buffer, length, ppos);
 }
 #endif /* CONFIG_NUMA */
 
-static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int hugetlb_overcommit_handler(const struct ctl_table *table,
+				      int write,
+				      void *buffer, size_t *length,
+				      loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
 	unsigned long tmp;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..e23c1e353e81 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -493,8 +493,10 @@ bool node_dirty_ok(struct pglist_data *pgdat)
 }
 
 #ifdef CONFIG_SYSCTL
-static int dirty_background_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int dirty_background_ratio_handler(const struct ctl_table *table,
+					  int write,
+					  void *buffer, size_t *lenp,
+					  loff_t *ppos)
 {
 	int ret;
 
@@ -504,8 +506,10 @@ static int dirty_background_ratio_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int dirty_background_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int dirty_background_bytes_handler(const struct ctl_table *table,
+					  int write,
+					  void *buffer, size_t *lenp,
+					  loff_t *ppos)
 {
 	int ret;
 
@@ -515,8 +519,9 @@ static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+static int dirty_ratio_handler(const struct ctl_table *table, int write,
+			       void *buffer,
+			       size_t *lenp, loff_t *ppos)
 {
 	int old_ratio = vm_dirty_ratio;
 	int ret;
@@ -529,8 +534,8 @@ static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-static int dirty_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int dirty_bytes_handler(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned long old_bytes = vm_dirty_bytes;
 	int ret;
@@ -2132,8 +2137,10 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 /*
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
-static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int dirty_writeback_centisecs_handler(const struct ctl_table *table,
+					     int write,
+					     void *buffer, size_t *length,
+					     loff_t *ppos)
 {
 	unsigned int old_interval = dirty_writeback_interval;
 	int ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..ec9171e89f58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5002,8 +5002,10 @@ static char numa_zonelist_order[] = "Node";
 /*
  * sysctl handler for numa_zonelist_order
  */
-static int numa_zonelist_order_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int numa_zonelist_order_handler(const struct ctl_table *table,
+				       int write,
+				       void *buffer, size_t *length,
+				       loff_t *ppos)
 {
 	if (write)
 		return __parse_numa_zonelist_order(buffer);
@@ -5992,8 +5994,10 @@ postcore_initcall(init_per_zone_wmark_min)
  *	that we can call two helper functions whenever min_free_kbytes
  *	changes.
  */
-static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int min_free_kbytes_sysctl_handler(const struct ctl_table *table,
+					  int write,
+					  void *buffer, size_t *length,
+					  loff_t *ppos)
 {
 	int rc;
 
@@ -6008,8 +6012,10 @@ static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-static int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int watermark_scale_factor_sysctl_handler(const struct ctl_table *table,
+						 int write,
+						 void *buffer, size_t *length,
+						 loff_t *ppos)
 {
 	int rc;
 
@@ -6038,8 +6044,11 @@ static void setup_min_unmapped_ratio(void)
 }
 
 
-static int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int sysctl_min_unmapped_ratio_sysctl_handler(const struct ctl_table *table,
+						    int write,
+						    void *buffer,
+						    size_t *length,
+						    loff_t *ppos)
 {
 	int rc;
 
@@ -6065,8 +6074,10 @@ static void setup_min_slab_ratio(void)
 						     sysctl_min_slab_ratio) / 100;
 }
 
-static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int sysctl_min_slab_ratio_sysctl_handler(const struct ctl_table *table,
+						int write,
+						void *buffer, size_t *length,
+						loff_t *ppos)
 {
 	int rc;
 
@@ -6089,8 +6100,9 @@ static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int wri
  * minimum watermarks. The lowmem reserve ratio can only make sense
  * if in function of the boot time zone sizes.
  */
-static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
-		int write, void *buffer, size_t *length, loff_t *ppos)
+static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
+					       int write, void *buffer,
+					       size_t *length, loff_t *ppos)
 {
 	int i;
 
@@ -6110,8 +6122,11 @@ static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
  * cpu. It is the fraction of total pages in each zone that a hot per cpu
  * pagelist can have before it gets flushed back to buddy allocator.
  */
-static int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
-		int write, void *buffer, size_t *length, loff_t *ppos)
+static int percpu_pagelist_high_fraction_sysctl_handler(const struct ctl_table *table,
+							int write,
+							void *buffer,
+							size_t *length,
+							loff_t *ppos)
 {
 	struct zone *zone;
 	int old_percpu_pagelist_high_fraction;
diff --git a/mm/util.c b/mm/util.c
index 669397235787..c975b805679d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -835,8 +835,9 @@ int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
-int overcommit_ratio_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_ratio_handler(const struct ctl_table *table, int write,
+			     void *buffer,
+			     size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
@@ -851,8 +852,9 @@ static void sync_overcommit_as(struct work_struct *dummy)
 	percpu_counter_sync(&vm_committed_as);
 }
 
-int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_policy_handler(const struct ctl_table *table, int write,
+			      void *buffer,
+			      size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int new_policy = -1;
@@ -887,8 +889,9 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int overcommit_kbytes_handler(const struct ctl_table *table, int write,
+			      void *buffer,
+			      size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..8e6d32af43fe 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -74,8 +74,8 @@ static void invalid_numa_statistics(void)
 
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+int sysctl_vm_numa_stat_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret, oldval;
 
@@ -1884,7 +1884,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(struct ctl_table *table, int write,
+int vmstat_refresh(const struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35e10c5a766d..86c24072544e 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1170,7 +1170,7 @@ int br_nf_hook_thresh(unsigned int hook, struct net *net,
 
 #ifdef CONFIG_SYSCTL
 static
-int brnf_sysctl_call_tables(struct ctl_table *ctl, int write,
+int brnf_sysctl_call_tables(const struct ctl_table *ctl, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1fb71107accf..fd0b9a4136a6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3538,7 +3538,7 @@ EXPORT_SYMBOL(neigh_app_ns);
 #ifdef CONFIG_SYSCTL
 static int unres_qlen_max = INT_MAX / SKB_TRUESIZE(ETH_FRAME_LEN);
 
-static int proc_unres_qlen(struct ctl_table *ctl, int write,
+static int proc_unres_qlen(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int size, ret;
@@ -3590,7 +3590,8 @@ static void neigh_proc_update(const struct ctl_table *ctl, int write)
 		neigh_copy_dflt_parms(net, p, index);
 }
 
-static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_zero_intmax(const struct ctl_table *ctl,
+					   int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
@@ -3605,7 +3606,8 @@ static int neigh_proc_dointvec_zero_intmax(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
+						   int write,
 						   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp = *ctl;
@@ -3621,7 +3623,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(struct ctl_table *ctl, int wr
 	return ret;
 }
 
-int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec(const struct ctl_table *ctl, int write, void *buffer,
 			size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
@@ -3631,7 +3633,8 @@ int neigh_proc_dointvec(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec);
 
-int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
+int neigh_proc_dointvec_jiffies(const struct ctl_table *ctl, int write,
+				void *buffer,
 				size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3641,7 +3644,8 @@ int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write, void *buffer,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_jiffies);
 
-static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_userhz_jiffies(const struct ctl_table *ctl,
+					      int write,
 					      void *buffer, size_t *lenp,
 					      loff_t *ppos)
 {
@@ -3651,7 +3655,7 @@ static int neigh_proc_dointvec_userhz_jiffies(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
+int neigh_proc_dointvec_ms_jiffies(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = proc_dointvec_ms_jiffies(ctl, write, buffer, lenp, ppos);
@@ -3661,7 +3665,8 @@ int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
 }
 EXPORT_SYMBOL(neigh_proc_dointvec_ms_jiffies);
 
-static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
+static int neigh_proc_dointvec_unres_qlen(const struct ctl_table *ctl,
+					  int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
@@ -3671,7 +3676,8 @@ static int neigh_proc_dointvec_unres_qlen(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
+static int neigh_proc_base_reachable_time(const struct ctl_table *ctl,
+					  int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 6973dda3abda..6bb2e573ede4 100644
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
@@ -254,7 +254,8 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
+static int flow_limit_table_len_sysctl(const struct ctl_table *table,
+				       int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int old, *ptr;
@@ -276,7 +277,7 @@ static int flow_limit_table_len_sysctl(struct ctl_table *table, int write,
 #endif /* CONFIG_NET_FLOW_LIMIT */
 
 #ifdef CONFIG_NET_SCHED
-static int set_default_qdisc(struct ctl_table *table, int write,
+static int set_default_qdisc(const struct ctl_table *table, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char id[IFNAMSIZ];
@@ -295,8 +296,8 @@ static int set_default_qdisc(struct ctl_table *table, int write,
 }
 #endif
 
-static int proc_do_dev_weight(struct ctl_table *table, int write,
-			   void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_do_dev_weight(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	static DEFINE_MUTEX(dev_weight_mutex);
 	int ret, weight;
@@ -313,7 +314,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_do_rss_key(struct ctl_table *table, int write,
+static int proc_do_rss_key(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
@@ -326,7 +327,8 @@ static int proc_do_rss_key(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_BPF_JIT
-static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
+static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table,
+					   int write,
 					   void *buffer, size_t *lenp,
 					   loff_t *ppos)
 {
@@ -359,7 +361,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 
 # ifdef CONFIG_HAVE_EBPF_JIT
 static int
-proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dointvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -370,7 +372,7 @@ proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 # endif /* CONFIG_HAVE_EBPF_JIT */
 
 static int
-proc_dolongvec_minmax_bpf_restricted(struct ctl_table *table, int write,
+proc_dolongvec_minmax_bpf_restricted(const struct ctl_table *table, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_ADMIN))
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7a437f0d4190..b19b18211767 100644
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
index c8f76f56dc16..4eea59e06671 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3408,8 +3408,8 @@ static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
 static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
-static int ipv4_sysctl_rtcache_flush(struct ctl_table *__ctl, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int ipv4_sysctl_rtcache_flush(const struct ctl_table *__ctl, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)__ctl->extra1;
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 363dc2a487ac..383270a2d227 100644
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
@@ -96,8 +96,8 @@ static int ipv4_local_port_range(struct ctl_table *table, int write,
 }
 
 /* Validate changes from /proc interface. */
-static int ipv4_privileged_ports(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
+static int ipv4_privileged_ports(const struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(table->data, struct net,
 	    ipv4.sysctl_ip_prot_sock);
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
@@ -369,8 +369,8 @@ static int proc_tfo_blackhole_detect_timeout(struct ctl_table *table,
 	return ret;
 }
 
-static int proc_tcp_available_ulp(struct ctl_table *ctl,
-				  int write, void *buffer, size_t *lenp,
+static int proc_tcp_available_ulp(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp,
 				  loff_t *ppos)
 {
 	struct ctl_table tbl = { .maxlen = TCP_ULP_BUF_MAX, };
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
@@ -434,7 +434,8 @@ static int proc_udp_hash_entries(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
-static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
+static int proc_fib_multipath_hash_policy(const struct ctl_table *table,
+					  int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
@@ -449,7 +450,8 @@ static int proc_fib_multipath_hash_policy(struct ctl_table *table, int write,
 	return ret;
 }
 
-static int proc_fib_multipath_hash_fields(struct ctl_table *table, int write,
+static int proc_fib_multipath_hash_fields(const struct ctl_table *table,
+					  int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c72f3b63e41d..8e9e655ed690 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6305,8 +6305,8 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 
 #ifdef CONFIG_SYSCTL
 
-static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6330,8 +6330,8 @@ static int addrconf_sysctl_forward(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_mtu(struct ctl_table *ctl, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_mtu(const struct ctl_table *ctl, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct inet6_dev *idev = ctl->extra1;
 	int min_mtu = IPV6_MIN_MTU;
@@ -6401,8 +6401,8 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 	return 0;
 }
 
-static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6426,8 +6426,8 @@ static int addrconf_sysctl_disable(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int ret;
@@ -6467,7 +6467,8 @@ static int addrconf_sysctl_proxy_ndp(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl,
+					 int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6530,7 +6531,8 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
+static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl,
+					 int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
@@ -6598,7 +6600,7 @@ static int addrconf_sysctl_stable_secret(struct ctl_table *ctl, int write,
 }
 
 static
-int addrconf_sysctl_ignore_routes_with_linkdown(struct ctl_table *ctl,
+int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 						int write, void *buffer,
 						size_t *lenp,
 						loff_t *ppos)
@@ -6698,8 +6700,10 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 	return 0;
 }
 
-static int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
-				   void *buffer, size_t *lenp, loff_t *ppos)
+static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl,
+					  int write,
+					  void *buffer, size_t *lenp,
+					  loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 945d5f5ca039..2c95a5c8bfa1 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1951,8 +1951,9 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 	}
 }
 
-int ndisc_ifinfo_sysctl_change(struct ctl_table *ctl, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
+int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write,
+			       void *buffer,
+			       size_t *lenp, loff_t *ppos)
 {
 	struct net_device *dev = ctl->extra1;
 	struct inet6_dev *idev;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1f4b935a0e57..b434636cca1c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6329,8 +6329,8 @@ static int rt6_stats_seq_show(struct seq_file *seq, void *v)
 
 #ifdef CONFIG_SYSCTL
 
-static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
-			      void *buffer, size_t *lenp, loff_t *ppos)
+static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
 	int delay;
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 888676163e90..2d19c119853f 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -30,7 +30,8 @@ static u32 rt6_multipath_hash_fields_all_mask =
 static u32 ioam6_id_max = IOAM6_DEFAULT_ID;
 static u64 ioam6_id_wide_max = IOAM6_DEFAULT_ID_WIDE;
 
-static int proc_rt6_multipath_hash_policy(struct ctl_table *table, int write,
+static int proc_rt6_multipath_hash_policy(const struct ctl_table *table,
+					  int write,
 					  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
@@ -46,7 +47,8 @@ static int proc_rt6_multipath_hash_policy(struct ctl_table *table, int write,
 }
 
 static int
-proc_rt6_multipath_hash_fields(struct ctl_table *table, int write, void *buffer,
+proc_rt6_multipath_hash_fields(const struct ctl_table *table, int write,
+			       void *buffer,
 			       size_t *lenp, loff_t *ppos)
 {
 	struct net *net;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 6dab883a08dd..7138998e29c8 100644
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
@@ -2617,7 +2617,7 @@ static int resize_platform_label_table(struct net *net, size_t limit)
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
index 0ee98ce5b816..325b9094dca1 100644
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
index 370f8231385c..7569532dbd43 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -409,8 +409,8 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 	{ }
 };
 
-static int nf_log_proc_dostring(struct ctl_table *table, int write,
-			 void *buffer, size_t *lenp, loff_t *ppos)
+static int nf_log_proc_dostring(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	const struct nf_logger *logger;
 	char buf[NFLOGGER_NAME_LEN];
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
index f65d6f92afcb..0849b4224676 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -43,19 +43,21 @@ static unsigned long max_autoclose_max =
 	(MAX_SCHEDULE_TIMEOUT / HZ > UINT_MAX)
 	? UINT_MAX : MAX_SCHEDULE_TIMEOUT / HZ;
 
-static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
+static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write, void *buffer,
+static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
+				void *buffer,
 				size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write, void *buffer,
+static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
+				 void *buffer,
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
@@ -388,7 +390,7 @@ static struct ctl_table sctp_net_table[] = {
 	{ /* sentinel */ }
 };
 
-static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
+static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -433,7 +435,7 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -461,7 +463,7 @@ static int proc_sctp_do_rto_min(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
+static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -489,7 +491,7 @@ static int proc_sctp_do_rto_max(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
+static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write)
@@ -499,7 +501,7 @@ static int proc_sctp_do_alpha_beta(struct ctl_table *ctl, int write,
 	return proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 }
 
-static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
+static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -528,7 +530,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
+static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -569,7 +571,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int proc_sctp_do_probe_interval(struct ctl_table *ctl, int write,
+static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = current->nsproxy->net_ns;
diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 93941ab12549..e3d6ceaee8fd 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -40,7 +40,7 @@ EXPORT_SYMBOL_GPL(nlm_debug);
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
-static int proc_do_xprt(struct ctl_table *table, int write,
+static int proc_do_xprt(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	char tmpbuf[256];
@@ -62,7 +62,8 @@ static int proc_do_xprt(struct ctl_table *table, int write,
 }
 
 static int
-proc_dodebug(struct ctl_table *table, int write, void *buffer, size_t *lenp,
+proc_dodebug(const struct ctl_table *table, int write, void *buffer,
+	     size_t *lenp,
 	     loff_t *ppos)
 {
 	char		tmpbuf[20], *s = NULL;
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
index 9a3dcaafb5b1..9b8d8d1b748b 100644
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
index 49dc52b454ef..8c11e3f207a8 100644
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


