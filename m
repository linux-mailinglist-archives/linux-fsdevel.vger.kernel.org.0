Return-Path: <linux-fsdevel+bounces-3809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8A7F8AED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD5D1C20CB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724C171B8;
	Sat, 25 Nov 2023 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LCxbmOZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7924F1;
	Sat, 25 Nov 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700916777;
	bh=/WDUZvLgmtwowWFhyebf3z+zbs9nn84yIhkNiH/7ee8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LCxbmOZa+J2IB5NpBPuk5h9rpgszGW9op4qjV0ZOMtxAwe4EaNPUqbNDvKm+7xhvw
	 5QlZCNb5JZa/TCg/R/LWpYbwDAJrQkepoqYK3PVfnwvCVcEX4V7BXkTjdmVkN0IZkq
	 OaZsJdN9+8pPvJRmHplvCujK2uCdHaZQQGSNNcDg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 25 Nov 2023 13:52:54 +0100
Subject: [PATCH RFC 5/7] treewide: sysctl: migrate proc_dostring to
 proc_handler_new
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-5-5e881b0e0290@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=7147;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/WDUZvLgmtwowWFhyebf3z+zbs9nn84yIhkNiH/7ee8=;
 b=DmSJ+xNUOj11T8ibIOsvVWhy3jQCb+NdW2g1Rvh/7e+65Qg2kihR0SY+RUCAOyp0HeM7V9RoB
 jd6+ffiORq7CD9TSDFe5ON88TwAGgiqLyss1ay+y+LnTcBA5P54R+pD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

proc_handler_new() prevents the handler function from modifying the
ctl_table which then can be put into .rodata.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 crypto/fips.c          |  4 ++--
 fs/coredump.c          |  2 +-
 fs/ocfs2/stackglue.c   |  2 +-
 fs/proc/proc_sysctl.c  |  2 +-
 include/linux/sysctl.h |  2 +-
 kernel/reboot.c        |  2 +-
 kernel/seccomp.c       |  2 +-
 kernel/sysctl.c        | 14 +++++++-------
 lib/test_sysctl.c      |  2 +-
 net/mptcp/ctrl.c       |  2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/crypto/fips.c b/crypto/fips.c
index 92fd506abb21..d492f23bf53b 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -54,14 +54,14 @@ static struct ctl_table crypto_sysctl_table[] = {
 		.data		= &fips_name,
 		.maxlen		= 64,
 		.mode		= 0444,
-		.proc_handler	= proc_dostring
+		.proc_handler_new	= proc_dostring
 	},
 	{
 		.procname	= "fips_version",
 		.data		= &fips_version,
 		.maxlen		= 64,
 		.mode		= 0444,
-		.proc_handler	= proc_dostring
+		.proc_handler_new	= proc_dostring
 	},
 	{}
 };
diff --git a/fs/coredump.c b/fs/coredump.c
index 9d235fa14ab9..733cb795f678 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -972,7 +972,7 @@ static struct ctl_table coredump_sysctls[] = {
 		.data		= core_pattern,
 		.maxlen		= CORENAME_MAX_SIZE,
 		.mode		= 0644,
-		.proc_handler	= proc_dostring_coredump,
+		.proc_handler_new	= proc_dostring_coredump,
 	},
 	{
 		.procname	= "core_pipe_limit",
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index a8d5ca98fa57..e4eedd1d6b7d 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -656,7 +656,7 @@ static struct ctl_table ocfs2_nm_table[] = {
 		.data		= ocfs2_hb_ctl_path,
 		.maxlen		= OCFS2_MAX_HB_CTL_PATH,
 		.mode		= 0644,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 	{ }
 };
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 810ecdd3b84c..0817d315fa36 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1132,7 +1132,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 	struct ctl_table *entry;
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
-		if ((entry->proc_handler == proc_dostring) ||
+		if ((entry->proc_handler_new == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
 		    (entry->proc_handler == proc_douintvec) ||
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index de1a5a714070..2699605c5da5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -66,7 +66,7 @@ typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 typedef int proc_handler_new(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 
-int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..69681100d884 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1267,7 +1267,7 @@ static struct ctl_table kern_reboot_table[] = {
 		.data           = &poweroff_cmd,
 		.maxlen         = POWEROFF_CMD_PATH_LEN,
 		.mode           = 0644,
-		.proc_handler   = proc_dostring,
+		.proc_handler_new   = proc_dostring,
 	},
 	{
 		.procname       = "ctrl-alt-del",
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..29e9663cf220 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2438,7 +2438,7 @@ static struct ctl_table seccomp_sysctl_table[] = {
 		.data		= (void *) &seccomp_actions_avail,
 		.maxlen		= sizeof(seccomp_actions_avail),
 		.mode		= 0444,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 	{
 		.procname	= "actions_logged",
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..7acd1cde0a5c 100644
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
@@ -1498,7 +1498,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 
 #else /* CONFIG_PROC_SYSCTL */
 
-int proc_dostring(struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -1653,7 +1653,7 @@ static struct ctl_table kern_table[] = {
 		.data		= reboot_command,
 		.maxlen		= 256,
 		.mode		= 0644,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 	{
 		.procname	= "stop-a",
@@ -1735,7 +1735,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &modprobe_path,
 		.maxlen		= KMOD_PATH_LEN,
 		.mode		= 0644,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 	{
 		.procname	= "modules_disabled",
@@ -1754,7 +1754,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &uevent_helper,
 		.maxlen		= UEVENT_HELPER_PATH_LEN,
 		.mode		= 0644,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 8036aa91a1cb..de42e3d99912 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -121,7 +121,7 @@ static struct ctl_table test_table[] = {
 		.data		= &test_data.string_0001,
 		.maxlen		= sizeof(test_data.string_0001),
 		.mode		= 0644,
-		.proc_handler	= proc_dostring,
+		.proc_handler_new	= proc_dostring,
 	},
 	{
 		.procname	= "bitmap_0001",
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 13fe0748dde8..6de3178b81b4 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -148,7 +148,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.procname = "scheduler",
 		.maxlen	= MPTCP_SCHED_NAME_MAX,
 		.mode = 0644,
-		.proc_handler = proc_dostring,
+		.proc_handler_new = proc_dostring,
 	},
 	{
 		.procname = "close_timeout",

-- 
2.43.0


