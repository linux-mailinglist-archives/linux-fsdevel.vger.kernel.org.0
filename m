Return-Path: <linux-fsdevel+bounces-8874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C083BF3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7921B1F2519F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15913D99E;
	Thu, 25 Jan 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT14TLUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073153A27E;
	Thu, 25 Jan 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179403; cv=none; b=cZj5TebKN/N63W5w8l/bwyh85ispMEN3nMD49+dd0SgFAF/sie4aB9oKcZzH/dfMGiJmlGZnjSR/ADPqlIZ3Wk+gSW+XeOFQ6ygkc4B3votpXunx9vp8+3EquVZLG+FXbDva4F6ItR5pO3sxeq77gnlAfmVE2xylUvlu53zvv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179403; c=relaxed/simple;
	bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCdQTKkxqa507eE/x8LTIlFkdOWZhXyxJ5KzI1/YKeDzTt0JCw40pvYfPaAE1LSmu+wrjJYEMNtOH0XfKNDhg3Rt6jiny0RcLvGNpq7z4VfYdTK9wTiZC+adEVktSgDMv7INIofK4usMQ6D0Ekwy+UdiRY4yOyMBhF5G5d2V+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT14TLUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD5C433F1;
	Thu, 25 Jan 2024 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179402;
	bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hT14TLUpQtKrKkB7OwsSU3gG0qzFgWueg67vejEkAWGLmsL7B7FRu7VJudxNvO793
	 7L/siql+TeZQE1jIgg5J1CiAPX8IBovHpQvq3hHiUUCeMyWpHS0+hPxrygGXUjle22
	 rJlWhS35Mp4cWNP0pDeTOyq4h/N5GE3w3r+yy0Mj1ZLxB9xu8EPI0MxZCSHAILNV1Q
	 dQTZQnG7r0t7zyoqLuYTkNIFohuA1yuyqDbsOi/m2JyabSbajxQW/tn7PUW41kv5uM
	 mqfUV3H0ijLeQkRiNJ0pJUMw4sDY5vpiQeyN+LhWDr2fBmKCIEr/prDdOY/sSi/Ong
	 GX87xypCKYwJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:43 -0500
Subject: [PATCH v2 02/41] filelock: rename fl_pid variable in
 lock_get_status
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-2-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2YbMDNw3c2UqWUFblyqOLLtcJSL33noaMk1Mbj6+9/U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6UJz7Yk3f7jnrR3Z5VKA7kWg/eqwTsVvjA
 GUkQztmrSqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 Fd3AD/0YUIGFNN1h2gzmR6UUCs0oVlw7FOBgzKU5zY4ZLd2QF8BYCfAWfeIjBKUzJ4UcsegwreG
 bTfHmg1lQGhnqcGzvt20Jh8ns4dHk/jIf2D6UVVZl3Egx8bBe15Hfg+TDaUgTNaXNfrPYkiA3It
 83zoO/00BeLzzpYqHvyriEDi8d8tzrShEPZG3vmGnljv6MAmIxitsgUt+9RhDNir0Bf5uj0Ig0f
 RXQNsxNvY321TAeFz+0R5cT19zzBEgxIFdeqLV+NQTsvkViHZqMirv8du0thWReiP8BGAybJvXO
 UtdIQ5JdS93NRNhmAwm++jZEgxNhpiLEvnh/pozZvvHpROOJ8vDplGjjNZvDPBoimyQTzE0fazj
 9b+C9//pzq4xfal5i0N2TpcK3sbx2T2g0qCANbTSZOeAPV4myr2eVe1W7eSlcvmFJg1CCs1tyzQ
 qcLGFi2m5g02B/4jioM06OQULjpRl3X6Qi5FxPGTjARaLdG0tGwWhpArCglhghCuiC1NAT1qmVP
 NZEu1dte6ojZfxYNFa4NteVmxH0BbNAZvrjvHmrMbRYB7oNFWqJMCw1/UlYdL2ldV5HR6zka8/0
 nX2g3/X6xMKiMUQHanVmHsVW4yD4SnkR/V7qq0gJ8jSN3uf2pYeaw0UwVpHrMIqcPAPgwLCachk
 GsLCd9zdCcG4S5A==
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


