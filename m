Return-Path: <linux-fsdevel+bounces-3810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256927F8AEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4922815E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE610942;
	Sat, 25 Nov 2023 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C5/1UkII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B586EB;
	Sat, 25 Nov 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700916777;
	bh=mk4ERGiQ+ypiwZ7Vl9VU2ZoRpbYUovn98lDDkerN23g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C5/1UkIIZUzU7N1C0adLmL3MG0a3j3bQOeRKu1fnGfpd5QJ76rmxy/zK5h24j4YK8
	 nyR+l0GDzybZxTNvA0OoC1HNsqr2iYGfq+xxmGYXnYMBPKusxr4nEp/i86yAIC7f/z
	 CAm0ajvc/nBpY3ORl9yKVeVqMHUMnj+Olz74lHPs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 25 Nov 2023 13:52:56 +0100
Subject: [PATCH RFC 7/7] treewide: sysctl: migrate proc_dointvec to
 proc_handler_new
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-7-5e881b0e0290@weissschuh.net>
References: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=68724;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mk4ERGiQ+ypiwZ7Vl9VU2ZoRpbYUovn98lDDkerN23g=;
 b=lHQ6ZePvtOVNnKOXAjR8OXxKIqtERzkT2DbnzPSkYj4CdH/1ATyWQAzFof8QUXlnJafzGpYcC
 zMy/c7XxzdnCRMEq6G5809QqLaGykaCe6yrClDPi1Jq3V7kilwTfyRS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

proc_handler_new() prevents the handler function from modifying the
ctl_table which then can be put into .rodata.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/arm/kernel/isa.c                   |  6 +--
 arch/csky/abiv1/alignment.c             |  8 ++--
 arch/powerpc/kernel/idle.c              |  2 +-
 arch/s390/kernel/debug.c                |  2 +-
 crypto/fips.c                           |  2 +-
 drivers/char/hpet.c                     |  2 +-
 drivers/char/random.c                   |  4 +-
 drivers/infiniband/core/iwcm.c          |  2 +-
 drivers/infiniband/core/ucma.c          |  2 +-
 drivers/macintosh/mac_hid.c             |  4 +-
 drivers/md/md.c                         |  4 +-
 drivers/scsi/sg.c                       |  2 +-
 drivers/tty/tty_io.c                    |  2 +-
 fs/coda/sysctl.c                        |  6 +--
 fs/coredump.c                           |  4 +-
 fs/devpts/inode.c                       |  2 +-
 fs/lockd/svc.c                          |  2 +-
 fs/locks.c                              |  4 +-
 fs/nfs/nfs4sysctl.c                     |  2 +-
 fs/nfs/sysctl.c                         |  2 +-
 fs/notify/dnotify/dnotify.c             |  2 +-
 fs/ntfs/sysctl.c                        |  2 +-
 fs/proc/proc_sysctl.c                   |  2 +-
 fs/quota/dquot.c                        |  2 +-
 include/linux/sysctl.h                  |  2 +-
 init/do_mounts_initrd.c                 |  2 +-
 io_uring/io_uring.c                     |  2 +-
 ipc/mq_sysctl.c                         |  2 +-
 kernel/acct.c                           |  2 +-
 kernel/locking/lockdep.c                |  4 +-
 kernel/printk/sysctl.c                  |  4 +-
 kernel/reboot.c                         |  2 +-
 kernel/signal.c                         |  2 +-
 kernel/sysctl-test.c                    | 20 ++++-----
 kernel/sysctl.c                         | 62 ++++++++++++++--------------
 lib/test_sysctl.c                       |  8 ++--
 mm/hugetlb.c                            |  2 +-
 mm/oom_kill.c                           |  4 +-
 net/appletalk/sysctl_net_atalk.c        |  2 +-
 net/core/sysctl_net_core.c              | 12 +++---
 net/ipv4/route.c                        | 18 ++++-----
 net/ipv4/sysctl_net_ipv4.c              | 38 ++++++++---------
 net/ipv4/xfrm4_policy.c                 |  2 +-
 net/ipv6/addrconf.c                     | 72 ++++++++++++++++-----------------
 net/ipv6/route.c                        |  8 ++--
 net/ipv6/sysctl_net_ipv6.c              | 18 ++++-----
 net/ipv6/xfrm6_policy.c                 |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c          | 36 ++++++++---------
 net/netfilter/nf_conntrack_standalone.c |  8 ++--
 net/netfilter/nf_log.c                  |  2 +-
 net/rds/ib_sysctl.c                     |  2 +-
 net/rds/sysctl.c                        |  6 +--
 net/sctp/sysctl.c                       | 26 ++++++------
 net/sunrpc/xprtrdma/transport.c         |  2 +-
 net/unix/sysctl_net_unix.c              |  2 +-
 net/x25/sysctl_net_x25.c                |  2 +-
 net/xfrm/xfrm_sysctl.c                  |  4 +-
 57 files changed, 226 insertions(+), 226 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index 905b1b191546..f2a089e487a2 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -22,19 +22,19 @@ static struct ctl_table ctl_isa_vars[] = {
 		.data		= &isa_membase, 
 		.maxlen		= sizeof(isa_membase),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	}, {
 		.procname	= "portbase",
 		.data		= &isa_portbase, 
 		.maxlen		= sizeof(isa_portbase),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	}, {
 		.procname	= "portshift",
 		.data		= &isa_portshift, 
 		.maxlen		= sizeof(isa_portshift),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index e5b8b4b2109a..e3ef2cad2713 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -306,28 +306,28 @@ static struct ctl_table alignment_tbl[5] = {
 		.data = &align_kern_enable,
 		.maxlen = sizeof(align_kern_enable),
 		.mode = 0666,
-		.proc_handler = &proc_dointvec
+		.proc_handler_new = &proc_dointvec
 	},
 	{
 		.procname = "user_enable",
 		.data = &align_usr_enable,
 		.maxlen = sizeof(align_usr_enable),
 		.mode = 0666,
-		.proc_handler = &proc_dointvec
+		.proc_handler_new = &proc_dointvec
 	},
 	{
 		.procname = "kernel_count",
 		.data = &align_kern_count,
 		.maxlen = sizeof(align_kern_count),
 		.mode = 0666,
-		.proc_handler = &proc_dointvec
+		.proc_handler_new = &proc_dointvec
 	},
 	{
 		.procname = "user_count",
 		.data = &align_usr_count,
 		.maxlen = sizeof(align_usr_count),
 		.mode = 0666,
-		.proc_handler = &proc_dointvec
+		.proc_handler_new = &proc_dointvec
 	},
 };
 
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 30b56c67fa61..c2ebd558c9c0 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -103,7 +103,7 @@ static struct ctl_table powersave_nap_ctl_table[] = {
 		.data		= &powersave_nap,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 85328a0ef3b6..eb5535710386 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -969,7 +969,7 @@ static struct ctl_table s390dbf_table[] = {
 		.data		= &debug_stoppable,
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO | S_IWUSR,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "debug_active",
diff --git a/crypto/fips.c b/crypto/fips.c
index d492f23bf53b..d082685301aa 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -47,7 +47,7 @@ static struct ctl_table crypto_sysctl_table[] = {
 		.data		= &fips_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "fips_name",
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 9c90b1d2c036..d2ba7dcbf8e8 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -707,7 +707,7 @@ static struct ctl_table hpet_table[] = {
 	 .data = &hpet_max_freq,
 	 .maxlen = sizeof(int),
 	 .mode = 0644,
-	 .proc_handler = proc_dointvec,
+	 .proc_handler_new = proc_dointvec,
 	 },
 };
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4a9c79391dee..0b2f01f89478 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1649,14 +1649,14 @@ static struct ctl_table random_table[] = {
 		.data		= &sysctl_poolsize,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "entropy_avail",
 		.data		= &input_pool.init_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "write_wakeup_threshold",
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 0301fcad4b48..b9257465f8a8 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -109,7 +109,7 @@ static struct ctl_table iwcm_ctl_table[] = {
 		.data		= &default_backlog,
 		.maxlen		= sizeof(default_backlog),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..2148fc1a04fa 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -69,7 +69,7 @@ static struct ctl_table ucma_ctl_table[] = {
 		.data		= &max_backlog,
 		.maxlen		= sizeof max_backlog,
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 1ae3539beff5..dc992d16067a 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -227,14 +227,14 @@ static struct ctl_table mac_hid_files[] = {
 		.data		= &mouse_button2_keycode,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "mouse_button3_keycode",
 		.data		= &mouse_button3_keycode,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index c94373d64f2c..df1ec9e16689 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -295,14 +295,14 @@ static struct ctl_table raid_table[] = {
 		.data		= &sysctl_speed_limit_min,
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO|S_IWUSR,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "speed_limit_max",
 		.data		= &sysctl_speed_limit_max,
 		.maxlen		= sizeof(int),
 		.mode		= S_IRUGO|S_IWUSR,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86210e4dd0d3..e85d25602d9e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1648,7 +1648,7 @@ static struct ctl_table sg_sysctls[] = {
 		.data		= &sg_big_buff,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 };
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a7bcc22fdae9..ad929011a68d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3608,7 +3608,7 @@ static struct ctl_table tty_table[] = {
 		.data		= &tty_ldisc_autoload,
 		.maxlen		= sizeof(tty_ldisc_autoload),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index a247c14aaab7..f59959ee8dcc 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -20,21 +20,21 @@ static struct ctl_table coda_table[] = {
 		.data		= &coda_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "hard",
 		.data		= &coda_hard,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "fake_statfs",
 		.data		= &coda_fake_statfs,
 		.maxlen		= sizeof(int),
 		.mode		= 0600,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{}
 };
diff --git a/fs/coredump.c b/fs/coredump.c
index 733cb795f678..62747af9a417 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -965,7 +965,7 @@ static struct ctl_table coredump_sysctls[] = {
 		.data		= &core_uses_pid,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "core_pattern",
@@ -979,7 +979,7 @@ static struct ctl_table coredump_sysctls[] = {
 		.data		= &core_pipe_limit,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c830261aa883..c786a3f2c1c2 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -67,7 +67,7 @@ static struct ctl_table pty_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
 		.data		= &pty_count,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{}
 };
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 90ea8cd382d3..6b0fd89990dc 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -473,7 +473,7 @@ static struct ctl_table nlm_sysctls[] = {
 		.data		= &nsm_local_state,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/fs/locks.c b/fs/locks.c
index 46d88b9e222c..c99faee56d7d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -100,7 +100,7 @@ static struct ctl_table locks_sysctls[] = {
 		.data		= &leases_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #ifdef CONFIG_MMU
 	{
@@ -108,7 +108,7 @@ static struct ctl_table locks_sysctls[] = {
 		.data		= &lease_break_time,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif /* CONFIG_MMU */
 	{}
diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index e776200e9a11..2270bbe81e07 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -32,7 +32,7 @@ static struct ctl_table nfs4_cb_sysctls[] = {
 		.data = &nfs_idmap_cache_timeout,
 		.maxlen = sizeof(int),
 		.mode = 0644,
-		.proc_handler = proc_dointvec,
+		.proc_handler_new = proc_dointvec,
 	},
 	{ }
 };
diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index f39e2089bc4c..57cf00765062 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -27,7 +27,7 @@ static struct ctl_table nfs_cb_sysctls[] = {
 		.data		= &nfs_congestion_kb,
 		.maxlen		= sizeof(nfs_congestion_kb),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 1cb9ad7e884e..6d1662ce7998 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -27,7 +27,7 @@ static struct ctl_table dnotify_sysctls[] = {
 		.data		= &dir_notify_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{}
 };
diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 174fe536a1c0..d1d308ef5479 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -26,7 +26,7 @@ static struct ctl_table ntfs_sysctls[] = {
 		.data		= &debug_msgs,		/* Data pointer and size. */
 		.maxlen		= sizeof(debug_msgs),
 		.mode		= 0644,			/* Mode, proc handler. */
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{}
 };
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 742a99540f2b..b7e104b6f7ea 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1134,7 +1134,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler_new == proc_dostring) ||
 		    (entry->proc_handler_new == proc_dobool) ||
-		    (entry->proc_handler == proc_dointvec) ||
+		    (entry->proc_handler_new == proc_dointvec) ||
 		    (entry->proc_handler == proc_douintvec) ||
 		    (entry->proc_handler == proc_douintvec_minmax) ||
 		    (entry->proc_handler == proc_dointvec_minmax) ||
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 58b5de081b57..4f5d93ac9caa 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2966,7 +2966,7 @@ static struct ctl_table fs_dqstats_table[] = {
 		.data		= &flag_print_warnings,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 	{ },
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2dfaf718a21b..58e9ddbbe828 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -69,7 +69,7 @@ typedef int proc_handler_new(const struct ctl_table *ctl, int write,
 int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(struct ctl_table *table, int write, void *buffer,
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 425f4bcf4b77..8504e84ffc78 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -27,7 +27,7 @@ static struct ctl_table kern_do_mounts_initrd_table[] = {
 		.data           = &real_root_dev,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ed254076c723..0b91e6eed0f3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -171,7 +171,7 @@ static struct ctl_table kernel_io_uring_disabled_table[] = {
 		.data		= &sysctl_io_uring_group,
 		.maxlen		= sizeof(gid_t),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{},
 };
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index ebb5ed81c151..478306e997c6 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -25,7 +25,7 @@ static struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_queues_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "msg_max",
diff --git a/kernel/acct.c b/kernel/acct.c
index 986c8214dabf..007b9c08b0a9 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -82,7 +82,7 @@ static struct ctl_table kern_acct_table[] = {
 		.data           = &acct_parm,
 		.maxlen         = 3*sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..ea14dd786d82 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -85,7 +85,7 @@ static struct ctl_table kern_lockdep_table[] = {
 		.data           = &prove_locking,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 #endif /* CONFIG_PROVE_LOCKING */
 #ifdef CONFIG_LOCK_STAT
@@ -94,7 +94,7 @@ static struct ctl_table kern_lockdep_table[] = {
 		.data           = &lock_stat,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 #endif /* CONFIG_LOCK_STAT */
 	{ }
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..009f5a9c7b75 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -26,7 +26,7 @@ static struct ctl_table printk_sysctls[] = {
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "printk_ratelimit",
@@ -40,7 +40,7 @@ static struct ctl_table printk_sysctls[] = {
 		.data		= &printk_ratelimit_state.burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "printk_delay",
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 69681100d884..9881f2ef5a21 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1274,7 +1274,7 @@ static struct ctl_table kern_reboot_table[] = {
 		.data           = &C_A_D,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/kernel/signal.c b/kernel/signal.c
index 47a7602dfe8d..d3c8f1150005 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4809,7 +4809,7 @@ static struct ctl_table signal_debug_table[] = {
 		.data		= &show_unhandled_signals,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 #endif
 	{ }
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 6ef887c19c48..a79878ba7fc6 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -25,7 +25,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 		.data		= NULL,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -75,7 +75,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 		 */
 		.maxlen		= 0,
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -118,7 +118,7 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -152,7 +152,7 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -187,7 +187,7 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -218,7 +218,7 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -247,7 +247,7 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -277,7 +277,7 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -309,7 +309,7 @@ static void sysctl_test_api_dointvec_write_single_less_int_min(
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
@@ -347,7 +347,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 		.data		= &data,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE_HUNDRED,
 	};
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c76668f47bcc..c02c98246621 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
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
@@ -739,7 +739,7 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_dointvec(struct ctl_table *table, int write, void *buffer,
+int proc_dointvec(const struct ctl_table *table, int write, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
@@ -1510,7 +1510,7 @@ int proc_dobool(const struct ctl_table *table, int write,
 	return -ENOSYS;
 }
 
-int proc_dointvec(struct ctl_table *table, int write,
+int proc_dointvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -1621,7 +1621,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &panic_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #ifdef CONFIG_PROC_SYSCTL
 	{
@@ -1645,7 +1645,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &print_fatal_signals,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #ifdef CONFIG_SPARC
 	{
@@ -1660,14 +1660,14 @@ static struct ctl_table kern_table[] = {
 		.data		= &stop_a_enabled,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "scons-poweroff",
 		.data		= &scons_pwroff,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_SPARC64
@@ -1676,7 +1676,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_tsb_ratio,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_PARISC
@@ -1685,7 +1685,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &pwrsw_enabled,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW
@@ -1694,7 +1694,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &unaligned_enabled,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_STACK_TRACER
@@ -1712,14 +1712,14 @@ static struct ctl_table kern_table[] = {
 		.data		= &ftrace_dump_on_oops,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "traceoff_on_warning",
 		.data		= &__disable_trace_on_warning,
 		.maxlen		= sizeof(__disable_trace_on_warning),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "tracepoint_printk",
@@ -1806,7 +1806,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &show_unhandled_signals,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 	{
@@ -1823,7 +1823,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &panic_on_oops,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "panic_print",
@@ -1837,14 +1837,14 @@ static struct ctl_table kern_table[] = {
 		.data		= (void *)&ngroups_max,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cap_last_cap",
 		.data		= (void *)&cap_last_cap,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
@@ -1852,7 +1852,7 @@ static struct ctl_table kern_table[] = {
 		.data           = &unknown_nmi_panic,
 		.maxlen         = sizeof (int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 #endif
 
@@ -1863,7 +1863,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_panic_on_stackoverflow,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #if defined(CONFIG_X86)
@@ -1872,35 +1872,35 @@ static struct ctl_table kern_table[] = {
 		.data		= &panic_on_unrecovered_nmi,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "panic_on_io_nmi",
 		.data		= &panic_on_io_nmi,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "bootloader_type",
 		.data		= &bootloader_type,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "bootloader_version",
 		.data		= &bootloader_version,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "io_delay_type",
 		.data		= &io_delay_type,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #if defined(CONFIG_MMU)
@@ -1909,7 +1909,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &randomize_va_space,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #if defined(CONFIG_S390) && defined(CONFIG_SMP)
@@ -1918,7 +1918,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &spin_retry,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
@@ -1936,7 +1936,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &no_unaligned_warning,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_RT_MUTEXES
@@ -1945,7 +1945,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &max_lock_depth,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_PERF_EVENTS
@@ -1960,14 +1960,14 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_perf_event_paranoid,
 		.maxlen		= sizeof(sysctl_perf_event_paranoid),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "perf_event_mlock_kb",
 		.data		= &sysctl_perf_event_mlock,
 		.maxlen		= sizeof(sysctl_perf_event_mlock),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "perf_event_max_sample_rate",
@@ -2200,7 +2200,7 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(vdso_enabled),
 #endif
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index de42e3d99912..cb8475f3b23e 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -84,28 +84,28 @@ static struct ctl_table test_table[] = {
 		.data		= &test_data.int_0002,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "int_0003",
 		.data		= &test_data.int_0003,
 		.maxlen		= sizeof(test_data.int_0003),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "match_int",
 		.data		= &match_int_ok,
 		.maxlen		= sizeof(match_int_ok),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "boot_int",
 		.data		= &test_data.boot_int,
 		.maxlen		= sizeof(test_data.boot_int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..338a7afe28ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4942,7 +4942,7 @@ static struct ctl_table hugetlb_table[] = {
 		.data		= &sysctl_hugetlb_shm_group,
 		.maxlen		= sizeof(gid_t),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "nr_overcommit_hugepages",
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde34a..9cb0d478df81 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -713,14 +713,14 @@ static struct ctl_table vm_oom_kill_table[] = {
 		.data		= &sysctl_oom_kill_allocating_task,
 		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "oom_dump_tasks",
 		.data		= &sysctl_oom_dump_tasks,
 		.maxlen		= sizeof(sysctl_oom_dump_tasks),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{}
 };
diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..9a18254f8875 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -31,7 +31,7 @@ static struct ctl_table atalk_table[] = {
 		.data		= &sysctl_aarp_retransmit_limit,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "aarp-resolve-time",
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 03f1edb948d7..c596de00e553 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -433,7 +433,7 @@ static struct ctl_table net_core_table[] = {
 		.data		= &netdev_max_backlog,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "netdev_rss_key",
@@ -492,7 +492,7 @@ static struct ctl_table net_core_table[] = {
 		.data		= &netdev_tstamp_prequeue,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "message_cost",
@@ -506,14 +506,14 @@ static struct ctl_table net_core_table[] = {
 		.data		= &net_ratelimit_state.burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "optmem_max",
 		.data		= &sysctl_optmem_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tstamp_allow_data",
@@ -577,14 +577,14 @@ static struct ctl_table net_core_table[] = {
 		.data		= &netdev_budget,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "warnings",
 		.data		= &net_msg_warn,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "max_skb_frags",
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..51958c4a3eef 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3428,14 +3428,14 @@ static struct ctl_table ipv4_route_table[] = {
 		.data		= &ipv4_dst_ops.gc_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "max_size",
 		.data		= &ip_rt_max_size,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		/*  Deprecated. Use gc_min_interval_ms */
@@ -3472,42 +3472,42 @@ static struct ctl_table ipv4_route_table[] = {
 		.data		= &ip_rt_redirect_load,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "redirect_number",
 		.data		= &ip_rt_redirect_number,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "redirect_silence",
 		.data		= &ip_rt_redirect_silence,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "error_cost",
 		.data		= &ip_rt_error_cost,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "error_burst",
 		.data		= &ip_rt_error_burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "gc_elasticity",
 		.data		= &ip_rt_gc_elasticity,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
@@ -3541,7 +3541,7 @@ static struct ctl_table ipv4_route_netns_table[] = {
 		.data       = &init_net.ipv4.ip_rt_min_advmss,
 		.maxlen     = sizeof(int),
 		.mode       = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ },
 };
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index f63a545a7374..726494d5a6d7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -474,14 +474,14 @@ static struct ctl_table ipv4_table[] = {
 		.data		= &sysctl_tcp_max_orphans,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "inet_peer_threshold",
 		.data		= &inet_peer_threshold,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "inet_peer_minttl",
@@ -509,7 +509,7 @@ static struct ctl_table ipv4_table[] = {
 		.data		= &sysctl_tcp_low_latency,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 #ifdef CONFIG_NETLABEL
 	{
@@ -517,28 +517,28 @@ static struct ctl_table ipv4_table[] = {
 		.data		= &cipso_v4_cache_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cipso_cache_bucket_size",
 		.data		= &cipso_v4_cache_bucketsize,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cipso_rbm_optfmt",
 		.data		= &cipso_v4_rbm_optfmt,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cipso_rbm_strictvalid",
 		.data		= &cipso_v4_rbm_strictvalid,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif /* CONFIG_NETLABEL */
 	{
@@ -588,7 +588,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.tcp_death_row.sysctl_max_tw_buckets,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "icmp_echo_ignore_all",
@@ -647,7 +647,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_icmp_ratemask,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "ping_group_range",
@@ -821,7 +821,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_base_mss,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "tcp_min_snd_mss",
@@ -846,7 +846,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_probe_threshold,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "tcp_probe_interval",
@@ -868,14 +868,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_igmp_max_memberships,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "igmp_max_msf",
 		.data		= &init_net.ipv4.sysctl_igmp_max_msf,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 #ifdef CONFIG_IP_MULTICAST
 	{
@@ -966,7 +966,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tcp_retries1",
@@ -1018,14 +1018,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_max_syn_backlog,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tcp_fastopen",
 		.data		= &init_net.ipv4.sysctl_tcp_fastopen,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "tcp_fastopen_key",
@@ -1185,7 +1185,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_max_reordering,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tcp_dsack",
@@ -1261,14 +1261,14 @@ static struct ctl_table ipv4_net_table[] = {
 		.data		= &init_net.ipv4.sysctl_tcp_limit_output_bytes,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tcp_challenge_ack_limit",
 		.data		= &init_net.ipv4.sysctl_tcp_challenge_ack_limit,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "tcp_min_tso_segs",
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index c33bca2c3841..166528c3d768 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -150,7 +150,7 @@ static struct ctl_table xfrm4_policy_table[] = {
 		.data           = &init_net.xfrm.xfrm4_dst_ops.gc_thresh,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3aaea56b5166..b18facff1d31 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6705,28 +6705,28 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_ra,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_redirects",
 		.data		= &ipv6_devconf.accept_redirects,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "autoconf",
 		.data		= &ipv6_devconf.autoconf,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "dad_transmits",
 		.data		= &ipv6_devconf.dad_transmits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "router_solicitations",
@@ -6762,7 +6762,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.force_mld_version,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "mldv1_unsolicited_report_interval",
@@ -6785,49 +6785,49 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.use_tempaddr,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "temp_valid_lft",
 		.data		= &ipv6_devconf.temp_valid_lft,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "temp_prefered_lft",
 		.data		= &ipv6_devconf.temp_prefered_lft,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "regen_max_retry",
 		.data		= &ipv6_devconf.regen_max_retry,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "max_desync_factor",
 		.data		= &ipv6_devconf.max_desync_factor,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "max_addresses",
 		.data		= &ipv6_devconf.max_addresses,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_defrtr",
 		.data		= &ipv6_devconf.accept_ra_defrtr,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ra_defrtr_metric",
@@ -6842,21 +6842,21 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_ra_min_hop_limit,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_min_lft",
 		.data		= &ipv6_devconf.accept_ra_min_lft,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_pinfo",
 		.data		= &ipv6_devconf.accept_ra_pinfo,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ra_honor_pio_life",
@@ -6873,7 +6873,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_ra_rtr_pref,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "router_probe_interval",
@@ -6888,14 +6888,14 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_ra_rt_info_min_plen,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_rt_info_max_plen",
 		.data		= &ipv6_devconf.accept_ra_rt_info_max_plen,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #endif
@@ -6911,7 +6911,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_source_route,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	{
@@ -6919,14 +6919,14 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.optimistic_dad,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{
 		.procname	= "use_optimistic",
 		.data		= &ipv6_devconf.use_optimistic,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 #ifdef CONFIG_IPV6_MROUTE
@@ -6935,7 +6935,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.mc_forwarding,
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 	{
@@ -6950,42 +6950,42 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.accept_dad,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "force_tllao",
 		.data		= &ipv6_devconf.force_tllao,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "ndisc_notify",
 		.data		= &ipv6_devconf.ndisc_notify,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "suppress_frag_ndisc",
 		.data		= &ipv6_devconf.suppress_frag_ndisc,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "accept_ra_from_local",
 		.data		= &ipv6_devconf.accept_ra_from_local,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "accept_ra_mtu",
 		.data		= &ipv6_devconf.accept_ra_mtu,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "stable_secret",
@@ -6999,7 +6999,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.use_oif_addrs_only,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ignore_routes_with_linkdown",
@@ -7013,21 +7013,21 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.drop_unicast_in_l2_multicast,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "drop_unsolicited_na",
 		.data		= &ipv6_devconf.drop_unsolicited_na,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "keep_addr_on_down",
 		.data		= &ipv6_devconf.keep_addr_on_down,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 
 	},
 	{
@@ -7035,7 +7035,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.seg6_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	{
@@ -7043,7 +7043,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.seg6_require_hmac,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 	{
@@ -7051,7 +7051,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data           = &ipv6_devconf.enhanced_dad,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{
 		.procname	= "addr_gen_mode",
@@ -7081,7 +7081,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.rpl_seg_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ioam6_enabled",
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..62313c74d2fe 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6350,14 +6350,14 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_max_size,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler_new	=	proc_dointvec,
 	},
 	{
 		.procname	=	"gc_thresh",
 		.data		=	&ip6_dst_ops_template.gc_thresh,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler_new	=	proc_dointvec,
 	},
 	{
 		.procname	=	"flush",
@@ -6392,7 +6392,7 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler_new	=	proc_dointvec,
 	},
 	{
 		.procname	=	"mtu_expires",
@@ -6406,7 +6406,7 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.data		=	&init_net.ipv6.sysctl.ip6_rt_min_advmss,
 		.maxlen		=	sizeof(int),
 		.mode		=	0644,
-		.proc_handler	=	proc_dointvec,
+		.proc_handler_new	=	proc_dointvec,
 	},
 	{
 		.procname	=	"gc_min_interval_ms",
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 888676163e90..f3ecdd13fdb4 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -103,7 +103,7 @@ static struct ctl_table ipv6_table_template[] = {
 		.data		= &init_net.ipv6.sysctl.idgen_retries,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "idgen_delay",
@@ -140,28 +140,28 @@ static struct ctl_table ipv6_table_template[] = {
 		.data		= &init_net.ipv6.sysctl.max_dst_opts_cnt,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "max_hbh_opts_number",
 		.data		= &init_net.ipv6.sysctl.max_hbh_opts_cnt,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "max_dst_opts_length",
 		.data		= &init_net.ipv6.sysctl.max_dst_opts_len,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "max_hbh_length",
 		.data		= &init_net.ipv6.sysctl.max_hbh_opts_len,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "fib_multipath_hash_policy",
@@ -186,7 +186,7 @@ static struct ctl_table ipv6_table_template[] = {
 		.data		= &init_net.ipv6.sysctl.seg6_flowlabel,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "fib_notify_on_flag_change",
@@ -222,7 +222,7 @@ static struct ctl_table ipv6_rotable[] = {
 		.data		= &sysctl_mld_max_msf,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "mld_qrv",
@@ -238,14 +238,14 @@ static struct ctl_table ipv6_rotable[] = {
 		.data		= &calipso_cache_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "calipso_cache_bucket_size",
 		.data		= &calipso_cache_bucketsize,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif /* CONFIG_NETLABEL */
 	{ }
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 42fb6996b077..3d29a12b5fc1 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -182,7 +182,7 @@ static struct ctl_table xfrm6_policy_table[] = {
 		.data		= &init_net.xfrm.xfrm6_dst_ops.gc_thresh,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..b832d55c7d0c 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2077,13 +2077,13 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "amemthresh",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "am_droprate",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "drop_entry",
@@ -2102,7 +2102,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "conntrack",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler_new	= &proc_dointvec,
 	},
 #endif
 	{
@@ -2115,7 +2115,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "snat_reroute",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler_new	= &proc_dointvec,
 	},
 	{
 		.procname	= "sync_version",
@@ -2135,7 +2135,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "sync_persist_mode",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "sync_qlen_max",
@@ -2147,37 +2147,37 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "sync_sock_size",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cache_bypass",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "expire_nodest_conn",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "sloppy_tcp",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "sloppy_sctp",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "expire_quiescent_template",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "sync_threshold",
@@ -2204,37 +2204,37 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "nat_icmp_send",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "pmtu_disc",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "backup_only",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "conn_reuse_mode",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "schedule_icmp",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ignore_tunneled",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "run_estimation",
@@ -2260,7 +2260,7 @@ static struct ctl_table vs_vars[] = {
 		.data		= &sysctl_ip_vs_debug_level,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 #endif
 	{ }
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 0ee98ce5b816..d6779acd2693 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -627,13 +627,13 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	[NF_SYSCTL_CT_COUNT] = {
 		.procname	= "nf_conntrack_count",
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	[NF_SYSCTL_CT_BUCKETS] = {
 		.procname       = "nf_conntrack_buckets",
@@ -663,7 +663,7 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_ct_expect_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	[NF_SYSCTL_CT_ACCT] = {
 		.procname	= "nf_conntrack_acct",
@@ -966,7 +966,7 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 8cc52d2bd31b..5c296f91a74d 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -398,7 +398,7 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 		.data		= &sysctl_nf_log_all_netns,
 		.maxlen		= sizeof(sysctl_nf_log_all_netns),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index e4e41b3afce7..e90a5ecabc7c 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -101,7 +101,7 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.data		= &rds_ib_sysctl_flow_control,
 		.maxlen		= sizeof(rds_ib_sysctl_flow_control),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index e381bbcd9cc1..958b0465fed3 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -73,21 +73,21 @@ static struct ctl_table rds_sysctl_rds_table[] = {
 		.data		= &rds_sysctl_max_unacked_packets,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{
 		.procname	= "max_unacked_bytes",
 		.data		= &rds_sysctl_max_unacked_bytes,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{
 		.procname	= "ping_enable",
 		.data		= &rds_sysctl_ping_enable,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler_new   = proc_dointvec,
 	},
 	{ }
 };
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index f65d6f92afcb..b94ef7a34bce 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -71,14 +71,14 @@ static struct ctl_table sctp_table[] = {
 		.data		= &sysctl_sctp_rmem,
 		.maxlen		= sizeof(sysctl_sctp_rmem),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "sctp_wmem",
 		.data		= &sysctl_sctp_wmem,
 		.maxlen		= sizeof(sysctl_sctp_wmem),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 
 	{ /* sentinel */ }
@@ -172,7 +172,7 @@ static struct ctl_table sctp_net_table[] = {
 		.data		= &init_net.sctp.cookie_preserve_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "cookie_hmac_alg",
@@ -240,49 +240,49 @@ static struct ctl_table sctp_net_table[] = {
 		.data		= &init_net.sctp.sndbuf_policy,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "rcvbuf_policy",
 		.data		= &init_net.sctp.rcvbuf_policy,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "default_auto_asconf",
 		.data		= &init_net.sctp.default_auto_asconf,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "addip_enable",
 		.data		= &init_net.sctp.addip_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "addip_noauth_enable",
 		.data		= &init_net.sctp.addip_noauth,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "prsctp_enable",
 		.data		= &init_net.sctp.prsctp_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "reconf_enable",
 		.data		= &init_net.sctp.reconf_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "auth_enable",
@@ -296,14 +296,14 @@ static struct ctl_table sctp_net_table[] = {
 		.data		= &init_net.sctp.intl_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "ecn_enable",
 		.data		= &init_net.sctp.ecn_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "plpmtud_probe_interval",
@@ -373,7 +373,7 @@ static struct ctl_table sctp_net_table[] = {
 		.data		= &init_net.sctp.pf_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{
 		.procname	= "pf_expose",
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 29b0562d62e7..db7a9b2aa8ba 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -135,7 +135,7 @@ static struct ctl_table xr_tunables_table[] = {
 		.data		= &xprt_rdma_pad_optimize,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler_new	= proc_dointvec,
 	},
 	{ },
 };
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 3e84b31c355a..4ddc9d9d2d30 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -17,7 +17,7 @@ static struct ctl_table unix_table[] = {
 		.data		= &init_net.unx.sysctl_max_dgram_qlen,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{ }
 };
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index e9802afa43d0..97a44b455221 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -69,7 +69,7 @@ static struct ctl_table x25_table[] = {
 		.data = 	&sysctl_x25_forward,
 		.maxlen = 	sizeof(int),
 		.mode = 	0644,
-		.proc_handler = proc_dointvec,
+		.proc_handler_new = proc_dointvec,
 	},
 	{ },
 };
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 7fdeafc838a7..3190fb65e13d 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -30,13 +30,13 @@ static struct ctl_table xfrm_table[] = {
 		.procname	= "xfrm_larval_drop",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{
 		.procname	= "xfrm_acq_expires",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec
+		.proc_handler_new	= proc_dointvec
 	},
 	{}
 };

-- 
2.43.0


