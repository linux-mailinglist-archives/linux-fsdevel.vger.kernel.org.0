Return-Path: <linux-fsdevel+bounces-9737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B2844C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5EAB2D98D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715EA41764;
	Wed, 31 Jan 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feePs9zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079141215;
	Wed, 31 Jan 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742164; cv=none; b=D5Qapzf/0YhencCfATmTjLusiLI2IdNf2nX4sgUNcb0RQ3ZbQUd2pputnPUjuus/LRLdhYucBVLjUGoSWOqG5bOLQX9JrnbfiTkP9PfUzGiAvaj2/hKO7riyJPaJoRhDfNFBai1VEl94gp5+rkR+uZQvEGeFek1KDZPUaqrOrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742164; c=relaxed/simple;
	bh=jUsklV0M5ZShEslcSzKmuGytzj4BAvtswz7tp/C3yVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6joR4OiAfn1kmw+fxhpSTa+jJxr3ttOwDIGb7TUbVCQ7e88HiM3C8LRgwquih4Rerir/pk0KRpReju91svKIrjFgf5/TXXO1qxB+TbhSoGhgNGHmlL84FnILqWG/on1fG8mx8sHFzVP6K7PLcVpfZLPl1DDqz6eCOtebuuX428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feePs9zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697F4C43601;
	Wed, 31 Jan 2024 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742164;
	bh=jUsklV0M5ZShEslcSzKmuGytzj4BAvtswz7tp/C3yVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=feePs9zyV01D+VTp+yo6a2mr1Bauz0ZluxMrEXDL3BexsjWjDecYRYOmckdjMgF2d
	 f1sDa/frrrKne2X5XgPdKuOqmrPl5VSSK+1htXz6RECNCoqw2Eq4N7ArMV7QjhYicw
	 X5x2b2UY3LkaCBDhCsT7jDH/RhOGiZ6q5rHG0HGcV5t1C0vJm2onG95W24X6y1UGEM
	 WMt0XH2oAn3kXUyiU8a5ZviDAIhujR038AhCM2sNeDs7g9hZzf7vLQc0NNMTBvOOVk
	 cYAKjrzVWKBy4NyMc8EWwQvPubM16NsOTT+j/geLuNIjMFIcK6Aovg42T3ZYh+3qF6
	 ohiwp7/rwcMlw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:48 -0500
Subject: [PATCH v3 07/47] ceph: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-7-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jUsklV0M5ZShEslcSzKmuGytzj4BAvtswz7tp/C3yVQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvtGyTzSzaKQa548I+QZYrq4tsyYSSi27eN
 qH3OdZSsmeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FbLcEACBeyzNZcBkoXWWJ72IFHNoR6FdBBeTqxaKJFUsGzzgpP6tC5J5IUD030fKZEOyIbOKkJX
 2rs0TUm7yZ8m2WN+s7lCJ0XILiLk+TC3/GuRNfMNSzhg8ACBnWFX1jmG5lMXwbZTgAXXHL6znSq
 LvkM691cYzJIune95niudSHKZ3KlnM2AimEqR7ayLyzylvrOa88zOSlz7VtrdNNx+/5prkw32oY
 wL4v9LXEkrUtTRqqd8vnPY68O2JfbB3WSUt9VlV7ZzOJqzSJoXBW54JNTuK11GjMxzxhWm1eoUp
 jLQUlMwnXbycwdegWCAEx6jfEm55FFuCawbjgmRhWI1JBLxY0R5M7N5aKtsSPj10QLJI2FzwKhx
 0MnMtvI4akmLdbaugUx8LVDzekOcEz3q5VtAGbS7KY3VCfpYWyRATPm+rLm+iiXVeB7+SFENLlB
 cud2hrGHfIbY45UGj2GknCJa++Wzt7eUf+9oFmgFT+gqW9mHP7tuo+ZBBM44cU4NTzDf4LiEK2X
 aih79bdvX2tYM8rETaIrQJa5kmkMx9u5fCxbaceJzGfiU9dmegQCIPum/bVB1RKbBcFOvLFZ7kw
 nxEEifhq3YP9+ttF+0j7XXJ8RM2yKc3A3wxj6X6iSpslJMUb6XcgF5QJkl79Y/HPeu6APQs8EoN
 li0gL83Hwubq6oA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/locks.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index e07ad29ff8b9..80ebe1d6c67d 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -273,19 +273,19 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type)
+		if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl))
 			posix_lock_file(file, fl, NULL);
 		return err;
 	}
 
-	if (F_RDLCK == fl->fl_type)
+	if (lock_is_read(fl))
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (lock_is_write(fl))
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type) {
+	if (op == CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(fl)) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -333,7 +333,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (F_UNLCK == fl->fl_type)
+		if (lock_is_unlock(fl))
 			locks_lock_file_wait(file, fl);
 		return err;
 	}
@@ -341,14 +341,14 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
-	if (F_RDLCK == fl->fl_type)
+	if (lock_is_read(fl))
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (lock_is_write(fl))
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (F_UNLCK == fl->fl_type) {
+	if (lock_is_unlock(fl)) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -385,9 +385,9 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 	ctx = locks_inode_context(inode);
 	if (ctx) {
 		spin_lock(&ctx->flc_lock);
-		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
+		for_each_file_lock(lock, &ctx->flc_posix)
 			++(*fcntl_count);
-		list_for_each_entry(lock, &ctx->flc_flock, fl_list)
+		for_each_file_lock(lock, &ctx->flc_flock)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
@@ -453,7 +453,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(lock, &ctx->flc_posix, fl_list) {
+	for_each_file_lock(lock, &ctx->flc_posix) {
 		++seen_fcntl;
 		if (seen_fcntl > num_fcntl_locks) {
 			err = -ENOSPC;
@@ -464,7 +464,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 			goto fail;
 		++l;
 	}
-	list_for_each_entry(lock, &ctx->flc_flock, fl_list) {
+	for_each_file_lock(lock, &ctx->flc_flock) {
 		++seen_flock;
 		if (seen_flock > num_flock_locks) {
 			err = -ENOSPC;

-- 
2.43.0


