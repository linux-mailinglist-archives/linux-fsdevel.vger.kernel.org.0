Return-Path: <linux-fsdevel+bounces-8112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23C82F784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9791F259EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE6823A9;
	Tue, 16 Jan 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq6bvn6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5922327;
	Tue, 16 Jan 2024 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434474; cv=none; b=fbmUVWtOxNBXLNYZ47M2KQ1JiIXAAvH/gaq1HKA3zYQZm54Ccv7rWD0KDmusDjmGJwljKvJ2YQnqTJ2a00lh8d50aKHwujUBaWN/hkRwi5AZtvhXi/kKo28Il+VzmlolCeLx4SQua4MyAzlTem0oxo2Pg0MRVC1+Pt4kJqUzsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434474; c=relaxed/simple;
	bh=FTw89+pku1zuIfZRGLXcRaoU9hVI0ZuADA0Yl4doYjQ=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=umRtQDb6wtdIcjNH79vOS05cXKuVxWMZKwa9y1r0nhXqP3QZD9hnCKyrXxPpozZgPhArFHoDtnjtq+nFcPeDjgo/itSVNukx2w3KyZ/G+UvhLFQIHNgQP6DKgEkSn4w7pneQq5y0P+D3LDOjH3EOeyS35FwjPmWyWJOlHiwKn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq6bvn6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED925C43601;
	Tue, 16 Jan 2024 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434473;
	bh=FTw89+pku1zuIfZRGLXcRaoU9hVI0ZuADA0Yl4doYjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eq6bvn6m5y/X2fER86pfthua2+nw74YlF5AZhYRF2tMunagWU3E77/71gxUymWI51
	 X7B9Ns2y7ytG7+ojucRsjxXSZXA2Jhl2BZ0CfApls+1648rEVgIU8z3cjapkaGS2/w
	 Bb8cHtkCb6MfJUcHICyTqw1eEyvchT7tPUvHViuJIqpqAerR50dl8EYLJetQS7g0jS
	 WRsoOBeIdYho8AFvY36xqzI3fm5AhJpwDrwnN0ZuwpykgxhxqZgoDxfHInB0jafJ9c
	 4XpKg2b6xAu1ZlkhVlTcL/5tyGIGw53RAdxcWbwhkiNAcLb23fjlnTrgqsSXty0y2G
	 6badSofqc4tNQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:13 -0500
Subject: [PATCH 17/20] filelock: make assign_type helper take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-17-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
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
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FTw89+pku1zuIfZRGLXcRaoU9hVI0ZuADA0Yl4doYjQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0iremkDlRrQ+xc3ImeXplfQacBchpkS/H5Z
 4ClsvaxqfaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FaqmD/9QMZUfmO+u/OFjkK9hUUWeg+zNsc0ZvrcUwhsTa3jV24S1CoQZ/YG7zth6GJgqBW5XQ10
 MxwoKw1yrTOohD3h9mWVUiJ0QQbhr73HUsn226zjTv/DNU2LV2bp6PvF0ku5Tr3F37ZCwHs0K2X
 81TwcvWX4kM7u7NMBeiPOjozUbWMY43jzZM55PTlAy9zgbScT83+3nZr9ROobKALKMWdvptjSDK
 X/QwUb87/llqyFUscBQmmJ4AdNsTu0CqurHCQOZ8JGxMofjyhmmrZ481Mq0lt+sNaV6GSz29MbB
 b7chk4kg5LO5pYbapu8sxb3R8VmJUiXBUH8UbGV4bm2qUV2X3agl+EB80DjXipZhoDT4PDqqFOa
 /UNM9RMvAD3oZMEgqugs+kPQ2qV29HcgCCV7sfo/PNlPClA6MiY80mqn0yZ+I2sBC3bAve8nx7J
 Sqbzm20Hq32Zi5VR23d0MxH9ZekvkgngM9U9Q/y3W9bmbpXDgkj2zl9N1LmRxRzVIptiqR7dfUK
 kUhSo3BABF26WycsO9+KBKx9IiG4tGfT4GUZEl20fFVsSfcfgyuUXyj2Yvt6TwqmsN/TDdS5KS6
 a1TCeigv8R4L2KIeUFVQrnkP0Kn+ZzkZ07DY0mMruOu9pMl3kZfHDCGpbs6++ZFdzOHe/zbdyEW
 Wt4ZXifyIhxu3uQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have assign_type take struct file_lock_core instead of file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 27160dc65d63..4a1e9457c430 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -462,13 +462,13 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 	fl->fl_end = OFFSET_MAX;
 }
 
-static int assign_type(struct file_lock *fl, int type)
+static int assign_type(struct file_lock_core *flc, int type)
 {
 	switch (type) {
 	case F_RDLCK:
 	case F_WRLCK:
 	case F_UNLCK:
-		fl->fl_core.fl_type = type;
+		flc->fl_type = type;
 		break;
 	default:
 		return -EINVAL;
@@ -520,7 +520,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
-	return assign_type(fl, l->l_type);
+	return assign_type(&fl->fl_core, l->l_type);
 }
 
 /* Verify a "struct flock" and copy it to a "struct file_lock" as a POSIX
@@ -575,7 +575,7 @@ static const struct lock_manager_operations lease_manager_ops = {
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
 {
-	if (assign_type(fl, type) != 0)
+	if (assign_type(&fl->fl_core, type) != 0)
 		return -EINVAL;
 
 	fl->fl_core.fl_owner = filp;
@@ -1432,7 +1432,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 /* We already had a lease on this file; just change its type */
 int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 {
-	int error = assign_type(fl, arg);
+	int error = assign_type(&fl->fl_core, arg);
 
 	if (error)
 		return error;

-- 
2.43.0


