Return-Path: <linux-fsdevel+bounces-3805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723877F8AE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951771C20D92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C41171B;
	Sat, 25 Nov 2023 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I8SiL3KL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C476B8;
	Sat, 25 Nov 2023 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700916776;
	bh=8RBixFRBTmKUrLM1q1IL2B0QZNBqk4iPlBDUCbp6lfA=;
	h=From:Subject:Date:To:Cc:From;
	b=I8SiL3KL/XYeDM0VPw9zjtesa2gYkLoHvkBcnTC3TsJr2k7NNfsoyNj+C9j9og+56
	 AkX+gId2Yz6MztTTHIohQIY9gqR9Y9xgd3/bj+gpodmrkmlSpmtGdYd1uIPeTdBMg+
	 PTaEITi9y7n3HQj7sMX05fg2kfZV8MHEYebhPjw0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/7] sysctl: constify sysctl ctl_tables
Date: Sat, 25 Nov 2023 13:52:49 +0100
Message-Id: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACHuYWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0Mz3eT8vOIS3eLK4uSSHN1UQxMzI5M0QyNL02QloJaCotS0zAqwcdF
 KQW7OSrG1tQBowj1BYwAAAA==
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=5646;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8RBixFRBTmKUrLM1q1IL2B0QZNBqk4iPlBDUCbp6lfA=;
 b=yn5sxyWjNwIg3MCvIyTri53+1hRNy7eWYmeevr24Fh4Kc7YwoBmv6NGIzQUUIsojWtpS2yIxz
 YWKOMvwkGzZBhqyeOcBcPzisZFK8vH7qkMSjnXwToIQTAgKc1b6fkec
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Problem description:

The kernel contains a lot of struct ctl_table throught the tree.
These are very often 'static' definitions.
It would be good to mark these tables const to avoid accidental or
malicious modifications.
Unfortunately the tables can not be made const because the core
registration functions expect mutable tables.

This is for two reasons:

1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
   the table. This should be fixable by only modifying the header
   instead of the table itself.
2) The table is passed to the handler function as a non-const pointer.

This series is an aproach on fixing reason 2).

Full process:

* Introduce field proc_handler_new for const handlers (this series)
* Migrate all core handlers to proc_handler_new (this series, partial)
  This can hopefully be done in a big switch, as it only involves
  functions and structures owned by the core sysctl code.
* Migrate all other sysctl handlers to proc_handler_new.
* Drop the old proc_handler_field.
* Fix the sysctl core to not modify the tables anymore.
* Adapt public sysctl APIs to take "const struct ctl_table *".
* Teach checkpatch.pl to warn on non-const "struct ctl_table"
  definitions.
* Migrate definitions of "struct ctl_table" to "const" where applicable.
 

Notes:

Just casting the function pointers around would trigger
CFI (control flow integrity) warnings.

The name of the new handler "proc_handler_new" is a bit too long messing
up the alignment of the table definitions.
Maybe "proc_handler2" or "proc_handler_c" for (const) would be better.

---
Thomas Weißschuh (7):
      sysctl: add helper sysctl_run_handler
      bpf: cgroup: call proc handler through helper
      sysctl: add proc_handler_new to struct ctl_table
      net: sysctl: add new sysctl table handler to debug message
      treewide: sysctl: migrate proc_dostring to proc_handler_new
      treewide: sysctl: migrate proc_dobool to proc_handler_new
      treewide: sysctl: migrate proc_dointvec to proc_handler_new

 arch/arm/kernel/isa.c                   |  6 +--
 arch/csky/abiv1/alignment.c             |  8 ++--
 arch/powerpc/kernel/idle.c              |  2 +-
 arch/riscv/kernel/vector.c              |  2 +-
 arch/s390/kernel/debug.c                |  2 +-
 crypto/fips.c                           |  6 +--
 drivers/char/hpet.c                     |  2 +-
 drivers/char/random.c                   |  4 +-
 drivers/infiniband/core/iwcm.c          |  2 +-
 drivers/infiniband/core/ucma.c          |  2 +-
 drivers/macintosh/mac_hid.c             |  4 +-
 drivers/md/md.c                         |  4 +-
 drivers/scsi/sg.c                       |  2 +-
 drivers/tty/tty_io.c                    |  4 +-
 fs/coda/sysctl.c                        |  6 +--
 fs/coredump.c                           |  6 +--
 fs/devpts/inode.c                       |  2 +-
 fs/lockd/svc.c                          |  4 +-
 fs/locks.c                              |  4 +-
 fs/nfs/nfs4sysctl.c                     |  2 +-
 fs/nfs/sysctl.c                         |  2 +-
 fs/notify/dnotify/dnotify.c             |  2 +-
 fs/ntfs/sysctl.c                        |  2 +-
 fs/ocfs2/stackglue.c                    |  2 +-
 fs/proc/proc_sysctl.c                   | 16 ++++---
 fs/quota/dquot.c                        |  2 +-
 include/linux/sysctl.h                  | 29 +++++++++---
 init/do_mounts_initrd.c                 |  2 +-
 io_uring/io_uring.c                     |  2 +-
 ipc/mq_sysctl.c                         |  2 +-
 kernel/acct.c                           |  2 +-
 kernel/bpf/cgroup.c                     |  2 +-
 kernel/locking/lockdep.c                |  4 +-
 kernel/printk/sysctl.c                  |  4 +-
 kernel/reboot.c                         |  4 +-
 kernel/seccomp.c                        |  2 +-
 kernel/signal.c                         |  2 +-
 kernel/sysctl-test.c                    | 20 ++++-----
 kernel/sysctl.c                         | 80 ++++++++++++++++-----------------
 lib/test_sysctl.c                       | 10 ++---
 mm/hugetlb.c                            |  2 +-
 mm/hugetlb_vmemmap.c                    |  2 +-
 mm/oom_kill.c                           |  4 +-
 net/appletalk/sysctl_net_atalk.c        |  2 +-
 net/core/sysctl_net_core.c              | 12 ++---
 net/ipv4/route.c                        | 18 ++++----
 net/ipv4/sysctl_net_ipv4.c              | 38 ++++++++--------
 net/ipv4/xfrm4_policy.c                 |  2 +-
 net/ipv6/addrconf.c                     | 72 ++++++++++++++---------------
 net/ipv6/route.c                        |  8 ++--
 net/ipv6/sysctl_net_ipv6.c              | 18 ++++----
 net/ipv6/xfrm6_policy.c                 |  2 +-
 net/mptcp/ctrl.c                        |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c          | 36 +++++++--------
 net/netfilter/nf_conntrack_standalone.c |  8 ++--
 net/netfilter/nf_log.c                  |  2 +-
 net/rds/ib_sysctl.c                     |  2 +-
 net/rds/sysctl.c                        |  6 +--
 net/sctp/sysctl.c                       | 26 +++++------
 net/sunrpc/xprtrdma/transport.c         |  2 +-
 net/sysctl_net.c                        |  5 ++-
 net/unix/sysctl_net_unix.c              |  2 +-
 net/x25/sysctl_net_x25.c                |  2 +-
 net/xfrm/xfrm_sysctl.c                  |  4 +-
 64 files changed, 280 insertions(+), 262 deletions(-)
---
base-commit: 0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
change-id: 20231116-const-sysctl-e14624f1295c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


