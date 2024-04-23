Return-Path: <linux-fsdevel+bounces-17476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79B8ADEE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F80285543
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C855B5D6;
	Tue, 23 Apr 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BuKkQ4wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CA4F895;
	Tue, 23 Apr 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858977; cv=none; b=mrzhNbH08K4gp9vm+nBX+rQf3tQuXq7bJvYdUd07Y5iRexQ5k2L/SzBTdVoAi3ePSqKeUcs/wyJbopz/X64T5hGSc2dceZhanh9Wa5XfZPzCeFwLPd9ea/GGdkAy41GSWnI3nDFtTdoHjyFbuZCY1pqWv7Kj7cFzp5/ZXts2JDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858977; c=relaxed/simple;
	bh=ydR7obNBKRDnMbLpYk0O5xU1+ChzUePuE2B1VMOxcXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsKT0ePGafmGikh9K4bEuZwjyC0ugih6tXr9R9wXH6KTReEgSzRVwvlVNEZRqIfXC3o50OmmHxiIWvZQ/0Ad946et1ubAQ4DWR3Y4PcWxRPVCYdHjOKc7dzwLOW8AvX1+Waq/0mQ/0r55de4847ykbt7HPvdKFm3YrDkKHgE8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BuKkQ4wn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=ydR7obNBKRDnMbLpYk0O5xU1+ChzUePuE2B1VMOxcXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BuKkQ4wnru53tO4VImE+RBd94hQrxsXOmY7rg+ASOS2vW15touD/aAGtiLNa1kC+7
	 kC2YollDK7PTHGVEIYC9k1hBEXljd/ZFrzfP4ao96J9I20cbjm5KtPCpR+HwBCFr96
	 ZKhP+40sphF/eXyhl8i7U8pbsuJQSpZMyZvpLjxI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:45 +0200
Subject: [PATCH v3 10/11] sysctl: constify ctl_table arguments of utility
 function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-10-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=4555;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ydR7obNBKRDnMbLpYk0O5xU1+ChzUePuE2B1VMOxcXg=;
 b=ILR4Nd0n0ptnfip2BSMBBu8wiCN5WTML70FZKdOlvCmeFL1Tz1zsPatlYuvHdEeskE5uykhWp
 ovqoAP1o0dGDhLLLePYQ0dpqqOG2g0I2Y7dJoidleRvVpkT/QbYbHhD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysctl.h |  2 +-
 kernel/sysctl.c        | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 09db2f2e6488..54fbec062772 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -237,7 +237,7 @@ extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
 bool sysctl_is_alias(char *param);
-int do_proc_douintvec(struct ctl_table *table, int write,
+int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
 				  unsigned int *valp,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e0b917328cf9..62dd27752960 100644
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
@@ -1023,8 +1023,9 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif
 
-static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos,
+static int __do_proc_doulongvec_minmax(void *data,
+		const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
 	unsigned long *i, *min, *max;
@@ -1096,7 +1097,7 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 	return err;
 }
 
-static int do_proc_doulongvec_minmax(struct ctl_table *table, int write,
+static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos, unsigned long convmul,
 		unsigned long convdiv)
 {

-- 
2.44.0


