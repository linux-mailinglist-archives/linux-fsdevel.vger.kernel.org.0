Return-Path: <linux-fsdevel+bounces-8873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A552483BF37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DED1F2442E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B432C96;
	Thu, 25 Jan 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvqsGw5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB42D792;
	Thu, 25 Jan 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179399; cv=none; b=AHz0DRXoIAYdDiv7pjXM4cUl1OUEzTp6HZzSgAjXeZawZwQFotX++nX6v0Hc+9XSDKFkW6o6mKu/+wA6wdsyYgmwogEPKVFnf6aII7wJ7bZ4x7b+nr02csi2O/c5nxopBwlmHHDSB0A1eCTn5e/l2/cuZFLXWqm73f45EE/7BxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179399; c=relaxed/simple;
	bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnrAkX5FptWtnX+ndx136KabmKynPFACIYacUNTQE6+sbfhVTj++kjFXI7cZCRjz6xBQku9T9763XDBOpH2501SI1o29KXokiIRZx7dfx2Qhr7OyKT6FMnTTOw7G7tHGJuCAwhAZiioX7S0Bls+XKeJbFtkoMSv8gPzzzPYjP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvqsGw5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41897C43394;
	Thu, 25 Jan 2024 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179398;
	bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MvqsGw5zJ894QqIIk4pm+FehsIBYb/p/Rb5DFLSy1ZKMUIL43M1sEi+sBU8DGvlaM
	 912bL3hRwT/NtawX9Z7RSlY/29n9MDOXOjiPX4BeTjcRkh0e3RnzDIIyAXbJVsHju4
	 RBQ+xfBBAEivp1dWFkPrYx6a8cF5RL88s0cf0Eu+8F1xJ+QsBJA10iGuo9kQID+Pif
	 6nJnOqBtf2ui5oEFFfZfwjec2YN08n+9mk5G9tf489n38ogvnGa5SpH9hPdqw93p2j
	 SRTwMWtN07AN7v7Op/XiGdTnggz+5zEDw61pqef5/mJcVuormJvFQq651UuYSKpCEP
	 V0pgrM718t0qg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:42 -0500
Subject: [PATCH v2 01/41] filelock: rename some fields in tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-1-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5841; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs5/+EvoJY5GCGaZRNNm0pErQ+lIQOC2Ind8
 IDAVttpXaOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OQAKCRAADmhBGVaC
 FaJgEAC+vyFljJYQuK/ziZp65NJav+1wi+tIc05uWqcTqS8bCs8gbwKgrUxCiVHcNUfVhn6vz4f
 EZ40wWk3JToTPBBi4fKZ+2kHod0dKfDf7nOlDShfY8w70NLKPOfOOhkJseVh3DOD7p63iukce46
 sflH/j80JZR2Ne7BiF9je/sWfEWHNCC1lXYwr+kR/XwW4zk0p0LCuCOUIMRqQJk5G6qQYYqrXN2
 sj2F8Tif2uWKTSxfVaVDNokvw82HBi1rh2DHY+WkqGix+L0umhGervF8hafMbfePMhTbVuS0cg6
 ePA/pT56eBUi1QU6LhwJ07IT4ofG2b69NQl50obzkG2HiVYpvt0V4H9S3iZQgz7B151qMbBqgeT
 2rxedevo64aKs5LcMP/4bj/oLSh8x+cIfmpAaplr+HYyR84Xh9Rtp0UeZvVPDVBUaxBTqgeuW9t
 vHDFV8AHjoY7y+6+2RuF1I6OSu11n7QuwNQC9eXSbM0zabYq53Re0AwipJZJbDzSer6kj9iOv0M
 FMVJoKDz5G2ULkrgbW+V1NA4Jt0YjMQJ0dBXzYsIr1/5YU2XvMTKvwQxB12Xm8GgMsLosq/5sO9
 yv8QHhQiMBEts4BqRDBQglflB+xUwAM6BwYRhVuDwtXztloBgvBIOme8TSzbBqTdDomGrItxv0w
 iZ0Ans9voeZ3cgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some macros with names that
clash with fields here. To prevent problems building, just rename the
fields in the trace entry structures.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/filelock.h | 76 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 1646dadd7f37..8fb1d41b1c67 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -68,11 +68,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_pid)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
+		__field(struct file_lock *, blocker)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, pid)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 		__field(loff_t, fl_start)
 		__field(loff_t, fl_end)
 		__field(int, ret)
@@ -82,11 +82,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_pid = fl ? fl->fl_pid : 0;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
+		__entry->blocker = fl ? fl->fl_blocker : NULL;
+		__entry->owner = fl ? fl->fl_owner : NULL;
+		__entry->pid = fl ? fl->fl_pid : 0;
+		__entry->flags = fl ? fl->fl_flags : 0;
+		__entry->type = fl ? fl->fl_type : 0;
 		__entry->fl_start = fl ? fl->fl_start : 0;
 		__entry->fl_end = fl ? fl->fl_end : 0;
 		__entry->ret = ret;
@@ -94,9 +94,9 @@ DECLARE_EVENT_CLASS(filelock_lock,
 
 	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
-		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type),
+		__entry->i_ino, __entry->blocker, __entry->owner,
+		__entry->pid, show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type),
 		__entry->fl_start, __entry->fl_end, __entry->ret)
 );
 
@@ -125,32 +125,32 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
-		__field(unsigned long, fl_break_time)
-		__field(unsigned long, fl_downgrade_time)
+		__field(struct file_lock *, blocker)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
+		__field(unsigned long, break_time)
+		__field(unsigned long, downgrade_time)
 	),
 
 	TP_fast_assign(
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
-		__entry->fl_owner = fl ? fl->fl_owner : NULL;
-		__entry->fl_flags = fl ? fl->fl_flags : 0;
-		__entry->fl_type = fl ? fl->fl_type : 0;
-		__entry->fl_break_time = fl ? fl->fl_break_time : 0;
-		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
+		__entry->blocker = fl ? fl->fl_blocker : NULL;
+		__entry->owner = fl ? fl->fl_owner : NULL;
+		__entry->flags = fl ? fl->fl_flags : 0;
+		__entry->type = fl ? fl->fl_type : 0;
+		__entry->break_time = fl ? fl->fl_break_time : 0;
+		__entry->downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
 
 	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
-		show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type),
-		__entry->fl_break_time, __entry->fl_downgrade_time)
+		__entry->i_ino, __entry->blocker, __entry->owner,
+		show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type),
+		__entry->break_time, __entry->downgrade_time)
 );
 
 DEFINE_EVENT(filelock_lease, break_lease_noblock, TP_PROTO(struct inode *inode, struct file_lock *fl),
@@ -179,9 +179,9 @@ TRACE_EVENT(generic_add_lease,
 		__field(int, rcount)
 		__field(int, icount)
 		__field(dev_t, s_dev)
-		__field(fl_owner_t, fl_owner)
-		__field(unsigned int, fl_flags)
-		__field(unsigned char, fl_type)
+		__field(fl_owner_t, owner)
+		__field(unsigned int, flags)
+		__field(unsigned char, type)
 	),
 
 	TP_fast_assign(
@@ -190,17 +190,17 @@ TRACE_EVENT(generic_add_lease,
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
 		__entry->icount = atomic_read(&inode->i_count);
-		__entry->fl_owner = fl->fl_owner;
-		__entry->fl_flags = fl->fl_flags;
-		__entry->fl_type = fl->fl_type;
+		__entry->owner = fl->fl_owner;
+		__entry->flags = fl->fl_flags;
+		__entry->type = fl->fl_type;
 	),
 
 	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
 		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
 		__entry->i_ino, __entry->wcount, __entry->rcount,
-		__entry->icount, __entry->fl_owner,
-		show_fl_flags(__entry->fl_flags),
-		show_fl_type(__entry->fl_type))
+		__entry->icount, __entry->owner,
+		show_fl_flags(__entry->flags),
+		show_fl_type(__entry->type))
 );
 
 TRACE_EVENT(leases_conflict,

-- 
2.43.0


