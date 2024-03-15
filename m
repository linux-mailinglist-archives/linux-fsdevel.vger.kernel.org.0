Return-Path: <linux-fsdevel+bounces-14539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DB87D5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A51C23A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FB5F872;
	Fri, 15 Mar 2024 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U4bUcES3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277354FB5;
	Fri, 15 Mar 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535772; cv=none; b=upaCErzMZ+FIKtLCbIKCwE3e+jXBieXgalaE0eW+ySjlTvZDIjamNLBBbDYwynFHVWvZNyFnPJ/iKJsaJuvuS/BgUrBuMGVQBgZUfsXM76PZSXy1b3+1KBmmTPm+pYRS8Bto3w6jZziRiYxRJ9bYrXp/ZmJn9Ubs1RnK4qejLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535772; c=relaxed/simple;
	bh=ioYxjFgUhmgN64D7EqS9neBKa6VPb6OHx0+I2+vtq58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+Z4awS540WiHsJziYQ4+I+tNZOqCTgrT4y5PSIWNwEMuMYtdzzcUMomZ7ppSeb+Oe9BNhUHMCR0NSfFyVbNSZSjH8IjRwDbW3d8mAsa6b8m6KQ8L0mdgN+CozzprIk/hfKXSwiksUsyx9emMe4N0lNnF5Pzws1AdAME4aqNYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U4bUcES3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535767;
	bh=ioYxjFgUhmgN64D7EqS9neBKa6VPb6OHx0+I2+vtq58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U4bUcES3s2tjQfaJWa5kyV07tIaEq54seuKRZncSMfN3xTCOuGrLDMLybcDmwJiHY
	 ATXaHOHgLnm1H38G00+7D2Qr6StGQ2gP0zruWtCyTLYxFxe885rD9AfLaJyLIS6zx1
	 NmZbFZqMIU/KmrUeGsPfH36Qh5k2WHCdEy49ynD0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:48:08 +0100
Subject: [PATCH 10/11] sysctl: constify ctl_table arguments of utility
 function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-sysctl-const-handler-v1-10-1322ac7cb03d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=4555;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ioYxjFgUhmgN64D7EqS9neBKa6VPb6OHx0+I2+vtq58=;
 b=3ezsimD4t+3/T0cNPSQ4+FYpRTQhNYyohAK+Rbgx8HlPQ+xGzze+WEFqLcmmpL3mfNQxqYUX7
 1t4oHVoJb7wAVyGZrGoUFlfOOhXQ+0lakf0I5Pzjxrct2orfuAx6LgW
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
index ee7d33b89e9e..99ea26b16c0d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -238,7 +238,7 @@ extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
 bool sysctl_is_alias(char *param);
-int do_proc_douintvec(struct ctl_table *table, int write,
+int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
 				  unsigned int *valp,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..93824d8a3636 100644
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


