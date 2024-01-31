Return-Path: <linux-fsdevel+bounces-9761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9D844C50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450A7296609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1213CF72;
	Wed, 31 Jan 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnhep5r7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFF63CF4F;
	Wed, 31 Jan 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742260; cv=none; b=SrP4by6v0z1pt7moNegx8H78ob+/3++rKE2QOOmoWeus/L1SY+9ouOslbdSaWCcybtvyzdz4WNbtfPbpfJtwoqWDlmaaLKmHgrngnRxdmg3mavUIQgY41yA+y+NDTjtThJQCpaBPCax3RY1x0nkgTzPcgLZmLoMjEt0tYAuUTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742260; c=relaxed/simple;
	bh=q0A7cujJLl1Gyractc5ZC8jqsgqBMppQlyxMtFVKiug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKAjBvl6bZG3fNNm5yYAdBcAAZqJ4G6w9lbe0mktNjo3ktYH88IipxHP/U0p7lG+uPdiFq3O7YotwSHGqwkVekGAfFRBZl+A/fvAAhf92DXsXk3sHiVX/JNWedwrNcyYNq4t8DNV2VjY59I7ShYobbrs0SSN5tKB5UyO4bpxWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnhep5r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E43C43330;
	Wed, 31 Jan 2024 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742259;
	bh=q0A7cujJLl1Gyractc5ZC8jqsgqBMppQlyxMtFVKiug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gnhep5r7NmWdUCjA8kQsflFuoDppoje9V9GymeZh+7PiqiajxLe4I+aScdHM6D9D9
	 1JDXNfDAUxHP3cVJ/4JufTBRM6VhvqO4HTsrbozMeVwjRWglRU1ixUWyoNWhYjiTdC
	 aM9jyiQyPFyQe6vIKkaC7TI45iHvh0NU8IQNMwUM9G+Z20YgJnfV9lXSAH3qGckaFk
	 GE3o3jgxrEzHqPJM1oVMiaIcLDJMkVOhqEJ8fRMnG4nMGDkcCJSeigcbXFHNLCfJwn
	 /npCCJbmNSsVNaBCdMkJvR3oJWTkIk1cfPZ9oz9pCRHONcbD+MTeVkd+FsM8/7WySW
	 iDjQL1GGd5xmg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:12 -0500
Subject: [PATCH v3 31/47] filelock: convert locks_insert_lock_ctx and
 locks_delete_lock_ctx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-31-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5216; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q0A7cujJLl1Gyractc5ZC8jqsgqBMppQlyxMtFVKiug=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFy5FeZkqEcO1KiVdzoIDoWrjNLy1E/CSUNP
 7AJdgWN/qOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FWhzD/9NrlHZ7h+wDAaOTvf3qNdt/UbAj3fGSKIl97w7Wc5DOIpgLUsx3KL3jXKDhjWfMUiHmh0
 rar+SFQhW7zPRUMF/JRD2Dr7cS8vZ/hHTRZm/jBI0qV9+ZC71i8c2sazcvRmNIwZj4ZNDwS/xYD
 MhTTJdJn5TaDu2SM36QhAM32pErNTn+Zw+Lnn2FBoGsvDAxn7NJYnh2lmOIBIX2DiwvzBzSEJZ5
 WmuVTKrW6s/Gc0sbZLn5IZa2ZTlmbF/b0rdH042N9FCKambqZtxi6pbzr6F9bMw1wf80ChEOplo
 jmv2XhVgyaiPh3sX+zCqh+bWXVPEweQPShRW+dwYhZdZv4yFtcvQ6bqrKlX+n62ttZeZferpHHo
 XPJh91h1LRwETz5VsGfDZw+Kyd1xh7QF/+8R9dIj2X+q7Y2PBDwoZ2JiolpiZm6f/oFD4L+096C
 ptYSLETs1PbaDmmlMIfmE1kzvphukKVV4jgl9jrps8og0ie4A+fr9hVdwMya+j853Bw74xNm7sN
 Vkk1lKvT/o0JLe500Tij47Dy0bZsP6+h/MMs1D2mMU9y2dzBQLmYqRhIs/sn8EWa9kOVxuMspO3
 m3pjVMHljcjk0W2eLNzZUZJCTY0qWKs50p5SJ3cga5Xj0xnjKDop5tK3D9wVnmBnkmGfYGZ77e4
 PKvGnWd40HKqj+w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have these functions take a file_lock_core pointer instead of a
file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9f3670ba0880..50d02a53ca75 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -824,28 +824,28 @@ static void locks_wake_up_blocks(struct file_lock_core *blocker)
 }
 
 static void
-locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
+locks_insert_lock_ctx(struct file_lock_core *fl, struct list_head *before)
 {
-	list_add_tail(&fl->c.flc_list, before);
-	locks_insert_global_locks(&fl->c);
+	list_add_tail(&fl->flc_list, before);
+	locks_insert_global_locks(fl);
 }
 
 static void
-locks_unlink_lock_ctx(struct file_lock *fl)
+locks_unlink_lock_ctx(struct file_lock_core *fl)
 {
-	locks_delete_global_locks(&fl->c);
-	list_del_init(&fl->c.flc_list);
-	locks_wake_up_blocks(&fl->c);
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
-		list_add(&fl->c.flc_list, dispose);
+		list_add(&fl->flc_list, dispose);
 	else
-		locks_free_lock(fl);
+		locks_free_lock(file_lock(fl));
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -1072,7 +1072,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (request->c.flc_type == fl->c.flc_type)
 			goto out;
 		found = true;
-		locks_delete_lock_ctx(fl, &dispose);
+		locks_delete_lock_ctx(&fl->c, &dispose);
 		break;
 	}
 
@@ -1097,7 +1097,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_move_blocks(new_fl, request);
-	locks_insert_lock_ctx(new_fl, &ctx->flc_flock);
+	locks_insert_lock_ctx(&new_fl->c, &ctx->flc_flock);
 	new_fl = NULL;
 	error = 0;
 
@@ -1236,7 +1236,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			else
 				request->fl_end = fl->fl_end;
 			if (added) {
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->c, &dispose);
 				continue;
 			}
 			request = fl;
@@ -1265,7 +1265,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				 * one (This may happen several times).
 				 */
 				if (added) {
-					locks_delete_lock_ctx(fl, &dispose);
+					locks_delete_lock_ctx(&fl->c, &dispose);
 					continue;
 				}
 				/*
@@ -1282,9 +1282,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
-				locks_insert_lock_ctx(request,
+				locks_insert_lock_ctx(&request->c,
 						      &fl->c.flc_list);
-				locks_delete_lock_ctx(fl, &dispose);
+				locks_delete_lock_ctx(&fl->c, &dispose);
 				added = true;
 			}
 		}
@@ -1313,7 +1313,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		}
 		locks_copy_lock(new_fl, request);
 		locks_move_blocks(new_fl, request);
-		locks_insert_lock_ctx(new_fl, &fl->c.flc_list);
+		locks_insert_lock_ctx(&new_fl->c, &fl->c.flc_list);
 		fl = new_fl;
 		new_fl = NULL;
 	}
@@ -1325,7 +1325,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock_ctx(left, &fl->c.flc_list);
+			locks_insert_lock_ctx(&left->c, &fl->c.flc_list);
 		}
 		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(&right->c);
@@ -1425,7 +1425,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 			fl->fl_fasync = NULL;
 		}
-		locks_delete_lock_ctx(fl, dispose);
+		locks_delete_lock_ctx(&fl->c, dispose);
 	}
 	return 0;
 }
@@ -1558,7 +1558,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			fl->fl_downgrade_time = break_time;
 		}
 		if (fl->fl_lmops->lm_break(fl))
-			locks_delete_lock_ctx(fl, &dispose);
+			locks_delete_lock_ctx(&fl->c, &dispose);
 	}
 
 	if (list_empty(&ctx->flc_lease))
@@ -1816,7 +1816,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	if (!leases_enable)
 		goto out;
 
-	locks_insert_lock_ctx(lease, &ctx->flc_lease);
+	locks_insert_lock_ctx(&lease->c, &ctx->flc_lease);
 	/*
 	 * The check in break_lease() is lockless. It's possible for another
 	 * open to race in after we did the earlier check for a conflicting
@@ -1829,7 +1829,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	smp_mb();
 	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
 	if (error) {
-		locks_unlink_lock_ctx(lease);
+		locks_unlink_lock_ctx(&lease->c);
 		goto out;
 	}
 

-- 
2.43.0


