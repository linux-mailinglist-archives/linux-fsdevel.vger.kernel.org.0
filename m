Return-Path: <linux-fsdevel+bounces-4731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA232802D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D50B20405
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DAFBE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YZPlhHxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D46FF;
	Sun,  3 Dec 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676351;
	bh=jiUoP9EILBqjXJdhjCd6wCOIBwbA+1GPrmYgkgR4m/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YZPlhHxEX6oI7g8G2LKXf/0qWZsZyCVOccYQzag5Ib0JfOmdslPSqC02Lm5IVfa3V
	 NfYWDXaB1wpUtcwFKNl/iui8AG1y0biZQzCEo/kstXkAPmgY865s0R0m17Uq6kJPoA
	 5Hhw+R4gLkxRIE/ks80cNBL7k4qMXjau4nE8joP4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:14 +0100
Subject: [PATCH v2 01/18] watchdog/core: remove sysctl handlers from public
 header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-1-7a5060b11447@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=3077;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jiUoP9EILBqjXJdhjCd6wCOIBwbA+1GPrmYgkgR4m/M=;
 b=N668jhYnDq/m98yRu3KJUDGYvbbTXjPausZ1wtJee7HDZsf73TfhAf+uRsaSar7Bl1MjM4b1f
 y4xDB12U1prASWAMR2lxo2BG40azT17eSnNK1xvNxwTk7wvRe1prpvc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The functions are only used in the file where they are defined.
Remove them from the header and make them static.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/nmi.h |  7 -------
 kernel/watchdog.c   | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e92e378df000..f53438eae815 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -216,13 +216,6 @@ void watchdog_update_hrtimer_threshold(u64 period);
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
 #endif
 
-struct ctl_table;
-int proc_watchdog(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_nmi_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_soft_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_watchdog_thresh(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_watchdog_cpumask(struct ctl_table *, int, void *, size_t *, loff_t *);
-
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
 #endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5cd6d4e26915..0fe72e89627d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -772,7 +772,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-int proc_watchdog(struct ctl_table *table, int write,
+static int proc_watchdog(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
@@ -783,7 +783,7 @@ int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-int proc_nmi_watchdog(struct ctl_table *table, int write,
+static int proc_nmi_watchdog(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
@@ -795,7 +795,7 @@ int proc_nmi_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-int proc_soft_watchdog(struct ctl_table *table, int write,
+static int proc_soft_watchdog(struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
@@ -805,7 +805,7 @@ int proc_soft_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-int proc_watchdog_thresh(struct ctl_table *table, int write,
+static int proc_watchdog_thresh(struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
@@ -828,7 +828,7 @@ int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-int proc_watchdog_cpumask(struct ctl_table *table, int write,
+static int proc_watchdog_cpumask(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;

-- 
2.43.0


