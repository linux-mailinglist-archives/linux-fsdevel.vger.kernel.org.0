Return-Path: <linux-fsdevel+bounces-4733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0D802D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73431F20F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63775FBE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dnPHjEVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B3107;
	Sun,  3 Dec 2023 23:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676351;
	bh=+ww9ozMh9wAF4pWHTJZYSE+udfVfSh/C+2C1r4/VF/s=;
	h=From:Subject:Date:To:Cc:From;
	b=dnPHjEVwIoAaUNrJmfgUcDTgDY+kMfYuLAXeYssKs0PP5lDHtRYa5ZQIkuwFRQ19I
	 G9VVlPqY05uo4DwJxYm6SjoQ66Xlf4PtNdI1YTREJEz4/QZG75Cny25A1SPPtSjR4m
	 fJXZxK4uWx9k+wZH5A7s7afVWeMLQP6lvu8RGh34=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Date: Mon, 04 Dec 2023 08:52:13 +0100
Message-Id: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC2FbWUC/1XMQQ6CMBCF4auQWVvTGYGAK+5hWGgd7CSmmE5FC
 eHuVuLG5f+S9y2gHIUVjsUCkSdRGUMO2hXg/Dnc2Mg1N5ClAyLWxo1Bk9FZXbobxrKmckBqKwf
 58og8yHvjTn1uL5rGOG/6hN/1B1H1D01orKm4afBi2VJruxeLqjr/9PvACfp1XT8AeYzlrQAAA
 A==
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=9179;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+ww9ozMh9wAF4pWHTJZYSE+udfVfSh/C+2C1r4/VF/s=;
 b=BIozzZhBNLoGF0P6eemlxPCmLd/ipkDabVbbZkpiglLWYk8z0bHRbPG+91EvUuA2HFcfXtAz8
 hbqU7Y6xCjwDgZn/Y14rfdrClcjKUg615vxDC7TNGIOqySyrONghN/Y
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Problem description:

The kernel contains a lot of struct ctl_table throught the tree.
These are very often 'static' definitions.
It would be good to make the tables unmodifiable by marking them "const"
to avoid accidental or malicious modifications.
This is in line with a general effort to move as much data as possible
into .rodata. (See for example[0] and [1])

Unfortunately the tables can not be made const right now because the
core registration functions expect mutable tables.

This is for two main reasons:

1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
   the table.
2) The table is passed to the handler function as a non-const pointer.

This series migrates the core and all handlers.

Structure of the series:

Patch 1-3:   Cleanup patches
Patch 4-7:   Non-logic preparation patches
Patch 8:     Preparation patch changing a bit of logic
Patch 9-12:  Treewide changes to handler function signature
Patch 13-14: Adaption of the sysctl core implementation
Patch 15:    Adaption of the sysctl core interface
Patch 16:    New entry for checkpatch
Patch 17-18: Constification of existing "struct ctl_table"s

Tested by booting and with the sysctl selftests on x86.

Note:

This is intentionally sent only to a small number of people as I'd like
to get some more sysctl core-maintainer feedback before sending this to
essentially everybody.

[0] 43a7206b0963 ("driver core: class: make class_register() take a const *")
[1] https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.com/

---
Changes in v2:
- Migrate all handlers.
- Remove intermediate "proc_handler_new" step (Thanks Joel).
- Drop RFC status.
- Prepare other parts of the tree.
- Link to v1: https://lore.kernel.org/r/20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net

---
Thomas Weißschuh (18):
      watchdog/core: remove sysctl handlers from public header
      sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
      sysctl: drop sysctl_is_perm_empty_ctl_table
      cgroup: bpf: constify ctl_table arguments and fields
      seccomp: constify ctl_table arguments of utility functions
      hugetlb: constify ctl_table arguments of utility functions
      utsname: constify ctl_table arguments of utility function
      stackleak: don't modify ctl_table argument
      sysctl: treewide: constify ctl_table_root::set_ownership
      sysctl: treewide: constify ctl_table_root::permissions
      sysctl: treewide: constify ctl_table_header::ctl_table_arg
      sysctl: treewide: constify the ctl_table argument of handlers
      sysctl: move sysctl type to ctl_table_header
      sysctl: move internal interfaces to const struct ctl_table
      sysctl: allow registration of const struct ctl_table
      const_structs.checkpatch: add ctl_table
      sysctl: make ctl_table sysctl_mount_point const
      sysctl: constify standard sysctl tables

 arch/arm64/kernel/armv8_deprecated.c      |   2 +-
 arch/arm64/kernel/fpsimd.c                |   2 +-
 arch/s390/appldata/appldata_base.c        |   8 +--
 arch/s390/kernel/debug.c                  |   2 +-
 arch/s390/kernel/topology.c               |   2 +-
 arch/s390/mm/cmm.c                        |   6 +-
 arch/x86/kernel/itmt.c                    |   2 +-
 drivers/cdrom/cdrom.c                     |   4 +-
 drivers/char/random.c                     |   4 +-
 drivers/macintosh/mac_hid.c               |   2 +-
 drivers/net/vrf.c                         |   4 +-
 drivers/parport/procfs.c                  |  12 ++--
 fs/coredump.c                             |   2 +-
 fs/dcache.c                               |   4 +-
 fs/drop_caches.c                          |   2 +-
 fs/exec.c                                 |   4 +-
 fs/file_table.c                           |   2 +-
 fs/fs-writeback.c                         |   2 +-
 fs/inode.c                                |   4 +-
 fs/pipe.c                                 |   2 +-
 fs/proc/internal.h                        |   2 +-
 fs/proc/proc_sysctl.c                     | 102 +++++++++++++++---------------
 fs/quota/dquot.c                          |   2 +-
 fs/xfs/xfs_sysctl.c                       |   6 +-
 include/linux/bpf-cgroup.h                |   2 +-
 include/linux/filter.h                    |   2 +-
 include/linux/ftrace.h                    |   4 +-
 include/linux/mm.h                        |   8 +--
 include/linux/nmi.h                       |   7 --
 include/linux/perf_event.h                |   6 +-
 include/linux/security.h                  |   2 +-
 include/linux/sysctl.h                    |  78 +++++++++++------------
 include/linux/vmstat.h                    |   6 +-
 include/linux/writeback.h                 |   2 +-
 include/net/ndisc.h                       |   2 +-
 include/net/neighbour.h                   |   6 +-
 include/net/netfilter/nf_hooks_lwtunnel.h |   2 +-
 ipc/ipc_sysctl.c                          |  12 ++--
 ipc/mq_sysctl.c                           |   2 +-
 kernel/bpf/cgroup.c                       |   2 +-
 kernel/bpf/syscall.c                      |   4 +-
 kernel/delayacct.c                        |   4 +-
 kernel/events/callchain.c                 |   2 +-
 kernel/events/core.c                      |   4 +-
 kernel/fork.c                             |   2 +-
 kernel/hung_task.c                        |   4 +-
 kernel/kexec_core.c                       |   2 +-
 kernel/kprobes.c                          |   2 +-
 kernel/latencytop.c                       |   4 +-
 kernel/pid_namespace.c                    |   2 +-
 kernel/pid_sysctl.h                       |   2 +-
 kernel/printk/internal.h                  |   2 +-
 kernel/printk/printk.c                    |   2 +-
 kernel/printk/sysctl.c                    |   5 +-
 kernel/sched/core.c                       |   8 +--
 kernel/sched/rt.c                         |  12 ++--
 kernel/sched/topology.c                   |   2 +-
 kernel/seccomp.c                          |   8 +--
 kernel/stackleak.c                        |   9 +--
 kernel/sysctl.c                           |  84 ++++++++++++------------
 kernel/time/timer.c                       |   2 +-
 kernel/trace/ftrace.c                     |   2 +-
 kernel/trace/trace.c                      |   2 +-
 kernel/trace/trace_events_user.c          |   2 +-
 kernel/trace/trace_stack.c                |   2 +-
 kernel/ucount.c                           |   4 +-
 kernel/umh.c                              |   2 +-
 kernel/utsname_sysctl.c                   |   4 +-
 kernel/watchdog.c                         |  15 +++--
 mm/compaction.c                           |   8 +--
 mm/hugetlb.c                              |  10 +--
 mm/page-writeback.c                       |  18 +++---
 mm/page_alloc.c                           |  22 +++----
 mm/util.c                                 |  12 ++--
 mm/vmstat.c                               |   4 +-
 net/ax25/sysctl_net_ax25.c                |   2 +-
 net/bridge/br_netfilter_hooks.c           |   6 +-
 net/core/neighbour.c                      |  24 +++----
 net/core/sysctl_net_core.c                |  22 +++----
 net/ieee802154/6lowpan/reassembly.c       |   2 +-
 net/ipv4/devinet.c                        |   8 +--
 net/ipv4/ip_fragment.c                    |   2 +-
 net/ipv4/route.c                          |   4 +-
 net/ipv4/sysctl_net_ipv4.c                |  35 +++++-----
 net/ipv4/xfrm4_policy.c                   |   2 +-
 net/ipv6/addrconf.c                       |  29 +++++----
 net/ipv6/ndisc.c                          |   4 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c   |   2 +-
 net/ipv6/reassembly.c                     |   2 +-
 net/ipv6/route.c                          |   2 +-
 net/ipv6/sysctl_net_ipv6.c                |  10 +--
 net/ipv6/xfrm6_policy.c                   |   2 +-
 net/mpls/af_mpls.c                        |   8 +--
 net/mptcp/ctrl.c                          |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c            |  16 ++---
 net/netfilter/nf_conntrack_standalone.c   |   4 +-
 net/netfilter/nf_hooks_lwtunnel.c         |   2 +-
 net/netfilter/nf_log.c                    |   4 +-
 net/phonet/sysctl.c                       |   2 +-
 net/rds/tcp.c                             |   4 +-
 net/sctp/sysctl.c                         |  30 ++++-----
 net/smc/smc_sysctl.c                      |   2 +-
 net/sunrpc/sysctl.c                       |   6 +-
 net/sunrpc/xprtrdma/svc_rdma.c            |   2 +-
 net/sysctl_net.c                          |   4 +-
 net/unix/sysctl_net_unix.c                |   2 +-
 net/xfrm/xfrm_sysctl.c                    |   2 +-
 scripts/const_structs.checkpatch          |   1 +
 security/apparmor/lsm.c                   |   2 +-
 security/min_addr.c                       |   2 +-
 security/yama/yama_lsm.c                  |   2 +-
 111 files changed, 427 insertions(+), 428 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231116-const-sysctl-e14624f1295c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


