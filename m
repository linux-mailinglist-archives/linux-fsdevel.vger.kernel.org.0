Return-Path: <linux-fsdevel+bounces-9762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C974844C57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426021C20A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3E1468E9;
	Wed, 31 Jan 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnTGGgDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301B145B2C;
	Wed, 31 Jan 2024 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742263; cv=none; b=Q4QwSi2JdHRUHzsIu4PYws9HWHir3uyRghz5QA3G1totR1RyHy9iyJHskpncor77R0LBE55epWv/j4Ft8hf6ARQ3G631KacWS3f8rNRyMGuTLcCMuUS0sn7FHTZS9aFjckk9bCcpUqdlpzJr9zHUAt+4cXn3S/XPSXfh+0Up1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742263; c=relaxed/simple;
	bh=LrTuC12tZ/QtQEScYVhE54GLHT5AD/GwOclA9PHGmT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dlq87BvzxUC+gb4+H4HulORYG9sVcyptxmNp/zvDTOxSIXDIcEj8HtiR77W63lIWBWcPKXuQADkJbd4PlAcptMBekH7/sVVAePOpM02rJkSrdziQ6I9ZYQVBrFGyNTvCuXOF3zGByzo4FYbE2lxJ+c2mv/infzuvJw5yve5Mvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnTGGgDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB1AC433F1;
	Wed, 31 Jan 2024 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742263;
	bh=LrTuC12tZ/QtQEScYVhE54GLHT5AD/GwOclA9PHGmT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JnTGGgDonD3liJE6IVRh/+68rvq3zAqBE5NugHrbPiNeqfTvmNv2WOFRKldxMCmUg
	 dRySg7FJzd6rNhP5bpYfvY2HMCGM7Dsme9wh6CnWvWcEFnYOaCiKJjfNPjwGrCcRZO
	 iNS6ys6mA7pIDyAZxc0qRXSIwJkN1yPCPt0AL8Fmk4xMVlPa2B+OXdogWWVvyHiy1L
	 olccnqlZjpKwwYJ3TTEAHxY+HD8DZLzec0BYH3wZhhuNb2tY5QxRk1gqLqNeQkV6Y1
	 H7CgvifCwTa5f0HDvvgGvWX+Gl4qPAWGn1Cd35h3PuafYfbzyM7hm2d71iC7rsJ4HO
	 M3cslZXqCvuMA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:13 -0500
Subject: [PATCH v3 32/47] filelock: convert locks_translate_pid to take
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-32-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LrTuC12tZ/QtQEScYVhE54GLHT5AD/GwOclA9PHGmT8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFyjJ6e5wDFqFR/4d4Cd4muX6vg/Y08ASqVS
 9l0rPUgHVGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FUnJD/kBte7SHPfni6wANeCfXgKgNZdSACRHZ/YPayRBpDjCsGePqI5p9iO2j0UDC8WKmw3WbIt
 Fhuiwls6PztamS9oYT3Hvf3bwRdwv5MNF9TpJJJoKVIYA+TeZQlONgb9cmAA0MJdIdrq3wxIV0+
 ox1suYoalWPCoTXWcB/FWLHlN1yzeDv93DMIxmUKKoZX56mHC05RYzsMHfQZPk2cQEC/Y41Jtbx
 2fdgS6Od8Mr3Xm8y5xebKyuZ7lu2XI31qm5j9q5N2SILwPuuIuUrHcUyl1AExJHfNyn+tYMapio
 GjuQL+xWtzHpAfkUIMUb28IL53SRA25Kq83KUb8Q+fJKH5/XQc00+cWUIMvqj902HuXF/kI3pV6
 PROH6H25wSYIn1kLiw2ya+ccMLWlPDrheu5QuKziXXV3eqXWnMdSvLT5jQgOfflGmwDWwED3D55
 0p4UXkHlJrkwGfv8awZuZ7bWz5EI0N53ino15xM/WnENxjWibqmtckaXwrGjVGal2UI3FsyBJON
 48xLe3o7znzTT0LFn6K3H6/SqxUEyfyhp3IHbjpAkFLBrooQoaQRDz3MhemR3E5z2ABL/GtgTUn
 JaZoaAmtR5WYJlwmKlQgoK6+pkOGgMn2WX9AQex9LNm6Eer7NQaPWayxnZVmYlBNn7j2n+JqnZi
 4NIkVFNvo4VMbgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

locks_translate_pid is used on both locks and leases, so have that take
struct file_lock_core.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 50d02a53ca75..97f6e9163130 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2169,17 +2169,17 @@ EXPORT_SYMBOL_GPL(vfs_test_lock);
  *
  * Used to translate a fl_pid into a namespace virtual pid number
  */
-static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
+static pid_t locks_translate_pid(struct file_lock_core *fl, struct pid_namespace *ns)
 {
 	pid_t vnr;
 	struct pid *pid;
 
-	if (fl->c.flc_flags & FL_OFDLCK)
+	if (fl->flc_flags & FL_OFDLCK)
 		return -1;
 
 	/* Remote locks report a negative pid value */
-	if (fl->c.flc_pid <= 0)
-		return fl->c.flc_pid;
+	if (fl->flc_pid <= 0)
+		return fl->flc_pid;
 
 	/*
 	 * If the flock owner process is dead and its pid has been already
@@ -2187,10 +2187,10 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	 * flock owner pid number in init pidns.
 	 */
 	if (ns == &init_pid_ns)
-		return (pid_t) fl->c.flc_pid;
+		return (pid_t) fl->flc_pid;
 
 	rcu_read_lock();
-	pid = find_pid_ns(fl->c.flc_pid, &init_pid_ns);
+	pid = find_pid_ns(fl->flc_pid, &init_pid_ns);
 	vnr = pid_nr_ns(pid, ns);
 	rcu_read_unlock();
 	return vnr;
@@ -2198,7 +2198,7 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 
 static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 {
-	flock->l_pid = locks_translate_pid(fl, task_active_pid_ns(current));
+	flock->l_pid = locks_translate_pid(&fl->c, task_active_pid_ns(current));
 #if BITS_PER_LONG == 32
 	/*
 	 * Make sure we can represent the posix lock via
@@ -2220,7 +2220,7 @@ static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 #if BITS_PER_LONG == 32
 static void posix_lock_to_flock64(struct flock64 *flock, struct file_lock *fl)
 {
-	flock->l_pid = locks_translate_pid(fl, task_active_pid_ns(current));
+	flock->l_pid = locks_translate_pid(&fl->c, task_active_pid_ns(current));
 	flock->l_start = fl->fl_start;
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
@@ -2726,7 +2726,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int type = fl->c.flc_type;
 
-	pid = locks_translate_pid(fl, proc_pidns);
+	pid = locks_translate_pid(&fl->c, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
@@ -2819,7 +2819,7 @@ static int locks_show(struct seq_file *f, void *v)
 
 	cur = hlist_entry(v, struct file_lock, c.flc_link);
 
-	if (locks_translate_pid(cur, proc_pidns) == 0)
+	if (locks_translate_pid(&cur->c, proc_pidns) == 0)
 		return 0;
 
 	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests

-- 
2.43.0


