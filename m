Return-Path: <linux-fsdevel+bounces-3804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB87F8AE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3101C20DFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE610A0C;
	Sat, 25 Nov 2023 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tbaCP1xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B4A8;
	Sat, 25 Nov 2023 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700916776;
	bh=4wlTsbEMCFaS0m7B2tSCdIXH5LNyqizp0qJ35foW3iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tbaCP1xvJLa80eoouC+sGhD61q51AcaibgzUxKmnP1gnl7/RLdCmLBSpoA42bFZQ1
	 ayR4fz3l/ASEIRRkYQeZ0/ftSegmFX4OyiqB0r5wt7cJDkKo53k3+icB85gv55bsso
	 r0V0CwF6UstVLTarMDkoy64W3fsQOL0ynQwAs140=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 25 Nov 2023 13:52:52 +0100
Subject: [PATCH RFC 3/7] sysctl: add proc_handler_new to struct ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-3-5e881b0e0290@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=4132;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4wlTsbEMCFaS0m7B2tSCdIXH5LNyqizp0qJ35foW3iw=;
 b=hmKOWy2O+FpZkCleOXKSegcXrK1adnCfG4RophWHn0w1+xCROYG2y8pEbrPPo4IeISVJ3ueeh
 pNzPhjY2ohmBKaA3pmDuj+1IkyZztsZMxuZl8jCgD+r1Crfp0mRe4jF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The existing handler function take the struct ctl_table as a mutable
parameter. This prevents the table definitions from being put into
.rodata where they would be protected from accidental or malicious
modification.

As many parts of the kernel define proc_handlers provide a gradual
transition mechanism through the introduction of a new field which takes
the table as a read-only parameter.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  |  6 ++++--
 include/linux/sysctl.h | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1bb0aa2ff501..810ecdd3b84c 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -573,7 +573,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 
 	/* if that can happen at all, it should be -EINVAL, not -EISDIR */
 	error = -EINVAL;
-	if (!table->proc_handler)
+	if (!table->proc_handler && !table->proc_handler_new)
 		goto out;
 
 	/* don't even try if the size is too large */
@@ -655,7 +655,7 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 	if (IS_ERR(head))
 		return EPOLLERR | EPOLLHUP;
 
-	if (!table->proc_handler)
+	if (!table->proc_handler && !table->proc_handler_new)
 		goto out;
 
 	if (!table->poll)
@@ -1333,6 +1333,8 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  *
  * proc_handler - the text handler routine (described below)
  *
+ * proc_handler_new - const variant of the text handler routine (described below)
+ *
  * extra1, extra2 - extra pointers usable by the proc handler routines
  * XXX: we should eventually modify these to use long min / max [0]
  * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 604aaaa1fce2..de1a5a714070 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -63,6 +63,8 @@ extern const unsigned long sysctl_long_vals[];
 
 typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+typedef int proc_handler_new(const struct ctl_table *ctl, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
 
 int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(struct ctl_table *table, int write, void *buffer,
@@ -107,10 +109,10 @@ int proc_do_static_key(struct ctl_table *table, int write, void *buffer,
  * struct enable minimal validation of the values being written to be
  * performed, and the mode field allows minimal authentication.
  * 
- * There must be a proc_handler routine for any terminal nodes
- * mirrored under /proc/sys (non-terminals are handled by a built-in
- * directory handler).  Several default handlers are available to
- * cover common cases.
+ * There must be one proc_handler/proc_handler_new routine for any terminal
+ * nodes mirrored under /proc/sys (non-terminals are handled by a built-in
+ * directory handler).
+ * Several default handlers are available to cover common cases.
  */
 
 /* Support for userspace poll() to watch for changes */
@@ -149,6 +151,7 @@ struct ctl_table {
 		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
 	} type;
 	proc_handler *proc_handler;	/* Callback for text formatting */
+	proc_handler_new *proc_handler_new;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
 	void *extra2;
@@ -301,6 +304,12 @@ int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
 static inline int sysctl_run_handler(struct ctl_table *ctl, int write,
 				     void *buffer, size_t *lenp, loff_t *ppos)
 {
+	if (ctl->proc_handler_new && ctl->proc_handler)
+		pr_warn_ratelimited("sysctl table %s has both proc_handler and proc_handler_new, this is a but\n",
+				    ctl->procname);
+
+	if (ctl->proc_handler_new)
+		return ctl->proc_handler_new(ctl, write, buffer, lenp, ppos);
 	return ctl->proc_handler(ctl, write, buffer, lenp, ppos);
 }
 

-- 
2.43.0


