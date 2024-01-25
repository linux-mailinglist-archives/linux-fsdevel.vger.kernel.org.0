Return-Path: <linux-fsdevel+bounces-8896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585FD83BFC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106481F211FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081DF3D98E;
	Thu, 25 Jan 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVuLBRKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11403629FD;
	Thu, 25 Jan 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179488; cv=none; b=DNoTgzt6i/tzoBLA5L052M4KY5CrZvxtbhWj7tYOvD28PA4JlcohKUb8fj6D2jCeob/oScRxtJnyNqqPsY1q0JVDIzO5NPZNERPo48OQcKzGZMmxG9JKwJCho/Xf8qn6cByZol68YRMmgvO6qLlr7gpFvHO9w+pAnsyOlYsGLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179488; c=relaxed/simple;
	bh=UMvPutQXS5toWdSHJyPcQjd0YCQSfybE9uJAyTV4Fho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFRSEzD8ZYtWv2kwfAoAIueiZ6oUyRpqIEfkb6XRbr4vpKU+0XfhWJkvYU1XJOhGaRqQTWz5cuedGAJrnb8F+SRx1gvzFWU4u9ZfxeP8E3pOD545Xxr6d+2qHB+inlxp/U5wp0bV5xFlm+wenlKqgqIL6k/ETh2ETCXcFQ14cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVuLBRKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7892CC43601;
	Thu, 25 Jan 2024 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179487;
	bh=UMvPutQXS5toWdSHJyPcQjd0YCQSfybE9uJAyTV4Fho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cVuLBRKTi3pnplzI7jkBI0QoTC4Bwh5nWN29kjBmwvql9dnYDu5JK2x1M6qH9W2RL
	 5M7U/xdUNvbbI5OVnEnlQuCd9hF9SP5fxHnc3sM1r4+rStNP5OZf92EEPXMqgOICRN
	 H36r/CUa1oTNExBkuC/udVKzc7ipKdpwX25zSfa0euL3u5d3bBvciQCBWLc09JkHQY
	 IYWyjLESKefvlhxX8NUk4C6Sa9yyI2j9f0B/xaRZg7aHf1ICuGNuvXJGvAKAWpP0Zi
	 6XwA9Wzc+FG7wYK3aQwIMjqkUA2PITis67l5+0u47YQPDaetsmQw/rablLOn4eAxgJ
	 VHfyAOQBkxIxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:05 -0500
Subject: [PATCH v2 24/41] filelock: make assign_type helper take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-24-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UMvPutQXS5toWdSHJyPcQjd0YCQSfybE9uJAyTV4Fho=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8CTZjesvGL/Yhy8NNQAq9uxnf8+NvcPePv
 4YwkYGtKtOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FXNlD/9SThl/gdXsnL4Z6KQ6TlneRG6k1A5Bo7nXzEB6eSjp4r2SmSh2FBgJL/X97bmwwJaP14k
 FYy9/d0fzV+So2xqxXeOT5lcU2/gQDF3857wdb8KHa3lqvsm0hIMY3XuXgm9j8UD0DD7fIPW7Pu
 xtpaIks8dpKcOJn9QqIK/h4jDxdqOL0161r4boFNifcPotv3l8rSF30rne7JVkyZtcqTP4qyaem
 jmo2+AXs9MOqD7TrQSy/BUaNVknX0C5ulCSlYgFs5Xy+i2o17z4NWE3UE4mmrBsvK6hGP6XiWK0
 lCFrg+owYGkjDdZhQBOCknTczz2fsdeeUmp3rybS2kLNjst6nILCwyum7OjXSt5PnFW4aUIdvnT
 bfDnf/H11f4GcEeNMeyj/RI8CxHEOhT8e62aeqd8inlX8kK1p+Zh7r26Qd5bVLG7SfjCIwJ4qb+
 xfwLb8q+vZUg7dhRTO1BTueV2q86Nz+RvhZeLg2qqcyYWlDRfFCMbx+F7GfpCUWvHRqri4wzEG+
 FJGdV7H5NCcAmx0jMpgfJ2wtGgD6g8/4lw2B4UHM71b/CmorHq9kBEGVijjuKDzQoOOkVb5qDAg
 jbKk3LCn9ddguXAaLVrA2gKEAmbML+kyE7pOQodcvm9dr2UgECpX4Iy9KWxJM5Wti7o462dmDly
 nRtwaXNcZrNd4YA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have assign_type take struct file_lock_core instead of file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 647a778d2c85..6182f5c5e7b4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -439,13 +439,13 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 	fl->fl_end = OFFSET_MAX;
 }
 
-static int assign_type(struct file_lock *fl, int type)
+static int assign_type(struct file_lock_core *flc, int type)
 {
 	switch (type) {
 	case F_RDLCK:
 	case F_WRLCK:
 	case F_UNLCK:
-		fl->fl_core.flc_type = type;
+		flc->flc_type = type;
 		break;
 	default:
 		return -EINVAL;
@@ -497,7 +497,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
-	return assign_type(fl, l->l_type);
+	return assign_type(&fl->fl_core, l->l_type);
 }
 
 /* Verify a "struct flock" and copy it to a "struct file_lock" as a POSIX
@@ -552,7 +552,7 @@ static const struct lock_manager_operations lease_manager_ops = {
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
 {
-	if (assign_type(fl, type) != 0)
+	if (assign_type(&fl->fl_core, type) != 0)
 		return -EINVAL;
 
 	fl->fl_core.flc_owner = filp;
@@ -1409,7 +1409,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 /* We already had a lease on this file; just change its type */
 int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 {
-	int error = assign_type(fl, arg);
+	int error = assign_type(&fl->fl_core, arg);
 
 	if (error)
 		return error;

-- 
2.43.0


