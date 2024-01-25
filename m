Return-Path: <linux-fsdevel+bounces-8898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC0083BFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF01F21F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A6633F6;
	Thu, 25 Jan 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxBLpMui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73F225A9;
	Thu, 25 Jan 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179495; cv=none; b=YO9rA1BHVvvzMxWJi05FyY/htwfPg5AAdhGYR4NuH7B2uuw6ijDskk0LOwR3QeMBtxGO+8btITiFndbEH0Q/57NvnqxmmVEmfQmv3mVt6Vw04ar4LDMlfTy1EpCOm8CJq4PJrnYeOXN+9OyhcwDJwmnemv0uVQaR6hkisR3JrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179495; c=relaxed/simple;
	bh=lUZh0KMHY+fHzKXHuqwOR7byHtaors/wicH3O0CwYoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+nYaAjV4kCZfvHa5CVEuuE/3dMSp7FlJN4oVupilZXFbbYo5ldRw9wgMh8fdfdQvNL8G6ymt0O4WTMNy65jtPkhImvS4KUzUB9gx7NLnmgJPJZTTSi7Z5330Utln1m51mRkKHZqVTF43FIHHpo+2W3hvv0OPG8BZRVPion3e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxBLpMui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EA9C43142;
	Thu, 25 Jan 2024 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179494;
	bh=lUZh0KMHY+fHzKXHuqwOR7byHtaors/wicH3O0CwYoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxBLpMuic/04TENW+E72hOyOtJQKeNHaGot7eHo5Az5qoO/upneS/jtAvDq5qvQCU
	 O028PuPaX+EK/n3QR6mj5iR/ac4C571bzwlbH1rgkRgnwQnzXF0uv3Ul7TefkPnJXi
	 LDzFctvwdBFR6QF3WWQoUh6kJeYLEja3BWlbL1PiuiEs6wNp2CRgmi0Kkr9FNu2l3c
	 s8Z7zQ3L+JjPH7bAl3V7opBxg2eAoGINy/ZH0VRx86gONhkMho7i4tB1/b9WMBmLH5
	 Qxp7toME6Y/Gia+EtBfyy7PVBH4mRb1nbRZEpwi0MnD2mfA0PdPDIson32z9obpWUx
	 nn25RmHYkipEw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:07 -0500
Subject: [PATCH v2 26/41] filelock: convert locks_insert_lock_ctx and
 locks_delete_lock_ctx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-26-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5378; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lUZh0KMHY+fHzKXHuqwOR7byHtaors/wicH3O0CwYoM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9Ex+LnXYe70JgA2IA47aBQXFR7sUgMKh0D
 cFyJ+HlPjWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 FbR2EACd7xtk6EJXp8fFP+D8YDEpgoLrIsD4JKNmOkHIhZI5nYnyePbQ4zH0XB2eiEsmu2Qameb
 36Zl2oZztStsJfMWU8qDJqrPXsfN4rEIB6+YQIw9TXYbG1M5FDbiMAVsTI1n+sjwXXgsDydZ6Pb
 yr+Op3dqS98Cga6xc0ALzuWW93Y2jD1tSzLmRFLMjdxTvl9/ajVQFuLu+p0g7PXQQa78QmflJGB
 9Py84YRsHB/9QKbcu1E86WAPH/rrRpKS9Y90l57z/Wa2Qb/6fdXorPDPWU0ujtNlARFMh6EniN/
 oX+M8HZ9V9jxejRx9T89iJd6n0Azl8BQ4ZtAs+JAhHY2RNUrWbXpJdtcZkSY+0L1tD1Nw87mmy1
 w90pFWIovmLrX8qKOP2dzaZA0aZTLh3ZadlwddnzufwpWo7ziNihLxQWT/CArcWAdaJsgZT9X0N
 najS5usCzZNYyajhGvm9QQipa6zK+Z/aP+Aj77zfGfy7ks0GFdOxbz8HAm1V8wVltmTsTqCBG/Y
 /opWJ155ExAbkCQya+BTw/3blbKAv6kR4WUc3mOqBAkuwxnQl1T+8yt9c1CzBX6vu0ZP93Yt+xd
 +Unp5dt7N/nYFXJbw6qmwqFREw2Z0cHIRkHmmvYAWOcamhOk+0csmcD/GKcgY3NF9Ygsoiaq+Tg
 yVH6TGO+fri9EKA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have these functions take a file_lock_core pointer instead of a
file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 03985cfb7eff..0491d621417d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -824,28 +824,28 @@ static void locks_wake_up_blocks(struct file_lock_core *blocker)
 }
 
 static void
-locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
+locks_insert_lock_ctx(struct file_lock_core *fl, struct list_head *before)
 {
-	list_add_tail(&fl->fl_core.flc_list, before);
-	locks_insert_global_locks(&fl->fl_core);
+	list_add_tail(&fl->flc_list, before);
+	locks_insert_global_locks(fl);
 }
 
 static void
-locks_unlink_lock_ctx(struct file_lock *fl)
+locks_unlink_lock_ctx(struct file_lock_core *fl)
 {
-	locks_delete_global_locks(&fl->fl_core);
-	list_del_init(&fl->fl_core.flc_list);
-	locks_wake_up_blocks(&fl->fl_core);
+	locks_delete_global_locks(fl);
+	list_del_init(&fl->flc_list);
+	locks_wake_up_blocks(fl);
 }
 
 static void
-locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
+locks_delete_lock_ctx(struct file_lock_core *fl, struct list_head *dispose)
 {
 	locks_unlink_lock_ctx(fl);
 	if (dispose)
-		list_add(&fl->fl_core.flc_list, dispose);
+		list_add(&fl->flc_list, dispose);
 	else
-		locks_free_lock(fl);
+		locks_free_lock(file_lock(fl));
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -1072,7 +1072,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (request->fl_core.flc_type == fl->fl_core.flc_type)
 			goto out;
 		found = true;
-		locks_delete_lock_ctx(fl, &dispose);
+		locks_delete_lock_ctx(&fl->fl_core, &dispose);
 		break;
 	}
 
@@ -1097,7 +1097,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_move_blocks(new_fl, request);
-	locks_insert_lock_ctx(new_fl, &ctx->flc_flock);
+	locks_insert_lock_ctx(&new_fl->fl_core, &ctx->flc_flock);
 	new_fl = NULL;
 	error = 0;
 
@@ -1236,7 +1236,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			else
 				request->fl_end = fl->fl_end;
 			if (added) {
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->fl_core, &dispose);
 				continue;
 			}
 			request = fl;
@@ -1265,7 +1265,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				 * one (This may happen several times).
 				 */
 				if (added) {
-					locks_delete_lock_ctx(fl, &dispose);
+					locks_delete_lock_ctx(&fl->fl_core, &dispose);
 					continue;
 				}
 				/*
@@ -1282,9 +1282,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
-				locks_insert_lock_ctx(request,
+				locks_insert_lock_ctx(&request->fl_core,
 						      &fl->fl_core.flc_list);
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->fl_core, &dispose);
 				added = true;
 			}
 		}
@@ -1313,7 +1313,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		}
 		locks_copy_lock(new_fl, request);
 		locks_move_blocks(new_fl, request);
-		locks_insert_lock_ctx(new_fl, &fl->fl_core.flc_list);
+		locks_insert_lock_ctx(&new_fl->fl_core, &fl->fl_core.flc_list);
 		fl = new_fl;
 		new_fl = NULL;
 	}
@@ -1325,7 +1325,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock_ctx(left, &fl->fl_core.flc_list);
+			locks_insert_lock_ctx(&left->fl_core, &fl->fl_core.flc_list);
 		}
 		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(&right->fl_core);
@@ -1425,7 +1425,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 			fl->fl_fasync = NULL;
 		}
-		locks_delete_lock_ctx(fl, dispose);
+		locks_delete_lock_ctx(&fl->fl_core, dispose);
 	}
 	return 0;
 }
@@ -1558,7 +1558,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			fl->fl_downgrade_time = break_time;
 		}
 		if (fl->fl_lmops->lm_break(fl))
-			locks_delete_lock_ctx(fl, &dispose);
+			locks_delete_lock_ctx(&fl->fl_core, &dispose);
 	}
 
 	if (list_empty(&ctx->flc_lease))
@@ -1816,7 +1816,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	if (!leases_enable)
 		goto out;
 
-	locks_insert_lock_ctx(lease, &ctx->flc_lease);
+	locks_insert_lock_ctx(&lease->fl_core, &ctx->flc_lease);
 	/*
 	 * The check in break_lease() is lockless. It's possible for another
 	 * open to race in after we did the earlier check for a conflicting
@@ -1829,7 +1829,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	smp_mb();
 	error = check_conflicting_open(filp, arg, lease->fl_core.flc_flags);
 	if (error) {
-		locks_unlink_lock_ctx(lease);
+		locks_unlink_lock_ctx(&lease->fl_core);
 		goto out;
 	}
 

-- 
2.43.0


