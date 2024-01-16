Return-Path: <linux-fsdevel+bounces-8114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9382F78F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2DD1C20ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C782D86;
	Tue, 16 Jan 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTC5ufjj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059682D66;
	Tue, 16 Jan 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434482; cv=none; b=arPw67AywXCa4NkKQYb/SMnjO8R7uWRYkedX8OPCpKGYf3P8tKZgj5E46BDTFpHb1sw8dWVTUPi5D/nxsGbwkmyR7Rf1OiZwrLPHH5Z7sON/7/g8DG7fZI01Bbdg5wVB2+RaJQKAioAG1nY2FFNBqAvMESRKQ96CdmDPF+ft6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434482; c=relaxed/simple;
	bh=D+ddUFLduMUtoR3H6uRS8KrhCxNq0OONqJND5QMi4fg=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=tItFlqfY/twuJwJPDcwgyCF/1EiptCSUpmqolesJPCxVBq215beRvkifhFa2SWP/9YDJ+zTACuFhxgzu+6WGhiewrhVAnTLT7uSnmak7sjvfd6nVIsztCHtNv8mujSf28eTexIYkI4Ch/dzb/AV800e+Cp+KkqlJTRyDk/bbER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTC5ufjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3038C43330;
	Tue, 16 Jan 2024 19:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434481;
	bh=D+ddUFLduMUtoR3H6uRS8KrhCxNq0OONqJND5QMi4fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sTC5ufjj0Mc666R2y5KyCLFPtD20KG9nYgjmgbKCBuDBPdpqauox9nHrJiifar+YI
	 SxQVqXV1gVeLk3HrazU3qwp1uavYce0Kk49R/uwF4JAQg/Fhp0ba15DZmb0txz+RU3
	 4B/2Q+ZmMgT4T2ihOBeVeDWUCzG+Kkdl0YVVUAxoLg9udsSN13duYWIyl/4JcEbmRs
	 GBx7lRJwj+g9uHUtkr6J0vLkFqcUhHBNVINeVCHaX2hj2ifQSFsEesuqnuyUYdOr4U
	 2X0bwToYcWJ5frEEQXwVNZLwAqprKDWrn2OTpDKgrwEGkXv5s3bBD2uBgCBNAA12T2
	 iekJuuLT/msHA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:15 -0500
Subject: [PATCH 19/20] filelock: convert locks_insert_lock_ctx and
 locks_delete_lock_ctx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-19-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5364; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D+ddUFLduMUtoR3H6uRS8KrhCxNq0OONqJND5QMi4fg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0iAOTSqzyEvswjyEJ+QZM7pJ+eGv1g/Av5x
 XUh1X6QyeaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FYqQEADVZYP89CCK/zSJeNpFTmTeeF6KQbmYj4Vw1eRi0yq/ji5gBnAUbpXIWmap7bF5wzaNy54
 ZbFhdN1MOWO8EjIg67wiBJSoinfW6xWDmtpbpZSs93FRzz4yS/yvVVv6MFheg4ygNVAaCzc/6tV
 vWcavcOB6TTQMVuG+NZYssu5GD+5i/gxSYhkfkLwpfeh9soB+RFMsB7gOcteloxd7/B1hg6mLIV
 4bjPu+CnJUqZRSOG2skqaXvmDg9YGN+7ey6bIwBkEqKrsKKfZoqAjxF7ri9E1Ff9JBrbKWsAPII
 QkBQrh/J7U2X4qAiNxqX3DGKPR3o7UMnmiif4TshXb1EAmP7ylvRS6KwVE72YkxHitQxj2yG8L0
 VNYNVEWWWKUSVAVSRFc3yMwR6Xu9BQmEh9kO0UTsuFWwBKPrRmMQmVp0PLo1mrLUMIY40vaUc+j
 iqx4yKyzhtT8AsSIvqn4OHQk1KDdVLmu8OEC1r2gAibK4edj0lKMgvIXBZjIwRCxmLfuYwFKSep
 q/MtuIlCSMN3B7Gc8g0o343qHmDQKZK7PEyr4q24pnPOgI1NLWykLDmXbBjdYYsXw9VyWU3lJau
 Bf+S1aLHAnrocxE6YEjzoWEBR5bk1WK+MBsE+hgmD4LDfYUR2T2ufSFDNK8X+SgXNzE3cSuZtU4
 6OBW1sKhyVqwqKQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have these functions take a file_lock_core pointer instead of a
file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 88c72eb4672e..6d24cf2525ec 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -847,28 +847,28 @@ static void locks_wake_up_blocks(struct file_lock_core *blocker)
 }
 
 static void
-locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
+locks_insert_lock_ctx(struct file_lock_core *fl, struct list_head *before)
 {
-	list_add_tail(&fl->fl_core.fl_list, before);
-	locks_insert_global_locks(&fl->fl_core);
+	list_add_tail(&fl->fl_list, before);
+	locks_insert_global_locks(fl);
 }
 
 static void
-locks_unlink_lock_ctx(struct file_lock *fl)
+locks_unlink_lock_ctx(struct file_lock_core *fl)
 {
-	locks_delete_global_locks(&fl->fl_core);
-	list_del_init(&fl->fl_core.fl_list);
-	locks_wake_up_blocks(&fl->fl_core);
+	locks_delete_global_locks(fl);
+	list_del_init(&fl->fl_list);
+	locks_wake_up_blocks(fl);
 }
 
 static void
-locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
+locks_delete_lock_ctx(struct file_lock_core *fl, struct list_head *dispose)
 {
 	locks_unlink_lock_ctx(fl);
 	if (dispose)
-		list_add(&fl->fl_core.fl_list, dispose);
+		list_add(&fl->fl_list, dispose);
 	else
-		locks_free_lock(fl);
+		locks_free_lock(file_lock(fl));
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -1095,7 +1095,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (request->fl_core.fl_type == fl->fl_core.fl_type)
 			goto out;
 		found = true;
-		locks_delete_lock_ctx(fl, &dispose);
+		locks_delete_lock_ctx(&fl->fl_core, &dispose);
 		break;
 	}
 
@@ -1120,7 +1120,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_move_blocks(new_fl, request);
-	locks_insert_lock_ctx(new_fl, &ctx->flc_flock);
+	locks_insert_lock_ctx(&new_fl->fl_core, &ctx->flc_flock);
 	new_fl = NULL;
 	error = 0;
 
@@ -1259,7 +1259,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			else
 				request->fl_end = fl->fl_end;
 			if (added) {
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->fl_core, &dispose);
 				continue;
 			}
 			request = fl;
@@ -1288,7 +1288,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				 * one (This may happen several times).
 				 */
 				if (added) {
-					locks_delete_lock_ctx(fl, &dispose);
+					locks_delete_lock_ctx(&fl->fl_core, &dispose);
 					continue;
 				}
 				/*
@@ -1305,9 +1305,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
-				locks_insert_lock_ctx(request,
+				locks_insert_lock_ctx(&request->fl_core,
 						      &fl->fl_core.fl_list);
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->fl_core, &dispose);
 				added = true;
 			}
 		}
@@ -1336,7 +1336,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		}
 		locks_copy_lock(new_fl, request);
 		locks_move_blocks(new_fl, request);
-		locks_insert_lock_ctx(new_fl, &fl->fl_core.fl_list);
+		locks_insert_lock_ctx(&new_fl->fl_core, &fl->fl_core.fl_list);
 		fl = new_fl;
 		new_fl = NULL;
 	}
@@ -1348,7 +1348,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock_ctx(left, &fl->fl_core.fl_list);
+			locks_insert_lock_ctx(&left->fl_core, &fl->fl_core.fl_list);
 		}
 		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(&right->fl_core);
@@ -1448,7 +1448,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 			fl->fl_fasync = NULL;
 		}
-		locks_delete_lock_ctx(fl, dispose);
+		locks_delete_lock_ctx(&fl->fl_core, dispose);
 	}
 	return 0;
 }
@@ -1581,7 +1581,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			fl->fl_downgrade_time = break_time;
 		}
 		if (fl->fl_lmops->lm_break(fl))
-			locks_delete_lock_ctx(fl, &dispose);
+			locks_delete_lock_ctx(&fl->fl_core, &dispose);
 	}
 
 	if (list_empty(&ctx->flc_lease))
@@ -1839,7 +1839,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	if (!leases_enable)
 		goto out;
 
-	locks_insert_lock_ctx(lease, &ctx->flc_lease);
+	locks_insert_lock_ctx(&lease->fl_core, &ctx->flc_lease);
 	/*
 	 * The check in break_lease() is lockless. It's possible for another
 	 * open to race in after we did the earlier check for a conflicting
@@ -1852,7 +1852,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	smp_mb();
 	error = check_conflicting_open(filp, arg, lease->fl_core.fl_flags);
 	if (error) {
-		locks_unlink_lock_ctx(lease);
+		locks_unlink_lock_ctx(&lease->fl_core);
 		goto out;
 	}
 

-- 
2.43.0


