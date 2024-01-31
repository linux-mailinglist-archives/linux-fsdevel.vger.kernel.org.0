Return-Path: <linux-fsdevel+bounces-9733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453E844BCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8892CB2CFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C03CF54;
	Wed, 31 Jan 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/m3EcAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7813C6BC;
	Wed, 31 Jan 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742148; cv=none; b=ZuMNAQzmmXfUADw9l+C81f0tYjZDTkJg7fTey1V4lyBt8fIoH1ANJp0BpAh96ra9sdaFLBUwBxbRABv/EEnFwYEH5uZ8Roh3OpO70LXunjGUdkdzqwfey/kvS9gbLIez26EAIsxH79BGjcp/t/sR+OgNd1daTJ5ikDHHjoRrhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742148; c=relaxed/simple;
	bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdmqHbLDe1MqyHo4wSLsYDN1TatoyX5vfO/pnJvD/tRxtFEcs0R1d3XCdgStbwzqoO3SyvPG5PdSnye98xCEkjvs56gwNVqwwau295ur2Xx8LRuNngRBEczFPE/6TvGVdlPT67IUcjynPzjIcC4NlA4xVmoO0x6icIsTLCJ+1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/m3EcAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A176C433F1;
	Wed, 31 Jan 2024 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742148;
	bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R/m3EcAuDcf5QXKkwD+MevGbjPtPC3i16HDBtdkqpPmDuhGOuQDP3ifh3DJMNpNm7
	 i1Oy8J8A5EDX5op2wJJwBmpZB+dmk98/NsDmBeQyelGIm0eyV6Uyi+e7PmoGPdwbtm
	 o/wUsJJ09SLdimnoJmD8iizeR9E0rtoIOHbfWoA35kRyeyHDtM1vCppUs/xwM/WJWR
	 Ne1yhZ8xXq6mbGXAbCBK666Aw3dGMdetPPLe5iG4Ukc9sXGJORU9fclgl5GWCrf3A6
	 3joJTSvctveyY27aEKzgW0aB9A4jM31lEumNR7GCqB8IKE7RNzlhxYPTqfFh3r9mky
	 GNAkI3uEceUIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:44 -0500
Subject: [PATCH v3 03/47] filelock: rename fl_pid variable in
 lock_get_status
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-3-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFu61Z5WT8kuDNwU06HgxdPXzSA8/qE2Cj1D
 CG6IWS+MAeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbgAKCRAADmhBGVaC
 FVsAD/91v196/WZutgy8iR+odquUSnynSbS8L4egjxN8AMrfF5febHAe3Y5JABVbmobrabNtWlz
 5EIPoBL4JJlC2xplBQ8N1dJQ3ep1q/G9Q6VmOzY7RKXtf4djuW1Izyr/pePhuieYEiEWwLjd5B2
 f7KM7FllMPSTAv/fJaEiqYElJ0/3jB4JPA8GWBI3pkmC+j2uFkYKtHd1GR+sBrkhgSkW1niGTI5
 OstchGjyK7h2wxHU4zU4OT+f1mPCN3OiPp0sz1Lenrr2e3C5v1OkTYEDI7mPZuPStssWeqoEFxS
 GZQ8GW64SaES1fbOmTBLol3tma8c+27adTqLnb2qCz6Wu5myK9lFZUkLEQSXYbk+H+OFnLfkb4a
 AgpQu81MI6am6IY7oBCL4/Mdh5PkagkcRchQ2JRjMBNB5BDNwfMp5rLCq9psTAQ1A0lxLFmRxTu
 9/BvxWooQGO5qVQWWQZvu9GIwf5sbfLOaJTfY/UcCymgIaaZ3mlcxUh8tR69mejTe0OEygaB5Ng
 4T7Hr7aCpcV9AvGbJBd9K6LWmwO38I91xaSnI+eXBjGbzz/0vLfmPUz5/Fso+/PJlFp26FCDG2A
 Po9N6MzCAZ8OVyJcfRSztM8IKMsV0WPpR7n5VaI5dkkJl1rFqRIR6us3RLvKyiFNMayW3lkaw1R
 OGMK2HNQqqxeLKQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some macros that will clash
with the variable name here. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index cc7c117ee192..1eceaa56e47f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2695,11 +2695,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
-	unsigned int fl_pid;
+	unsigned int pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int type;
 
-	fl_pid = locks_translate_pid(fl, proc_pidns);
+	pid = locks_translate_pid(fl, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
@@ -2747,11 +2747,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
+		seq_printf(f, "%d %02x:%02x:%lu ", pid,
 				MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino);
 	} else {
-		seq_printf(f, "%d <none>:0 ", fl_pid);
+		seq_printf(f, "%d <none>:0 ", pid);
 	}
 	if (IS_POSIX(fl)) {
 		if (fl->fl_end == OFFSET_MAX)

-- 
2.43.0


