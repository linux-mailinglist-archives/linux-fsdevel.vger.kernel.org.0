Return-Path: <linux-fsdevel+bounces-9732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A7844BC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9451F22689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCD3BB4C;
	Wed, 31 Jan 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFi6af1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C93BB41;
	Wed, 31 Jan 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742145; cv=none; b=jiqgUuLLMddO6zDy84cT6eT1zuFW6ZCW+Z3ypvWDz9XQtJjT6YraiIIKTZdL1Wo4eOm/H6K73cU4SNNFNvCr8bMgnlcwG+mgsl/wOvhsUDB6pFx7+QY8lhsBhuFUCpiSEc432wnfIvwaePsMCar9TiA5d/tRO1Av2LOaSK+CGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742145; c=relaxed/simple;
	bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suq0KDyh0u1sx/pZ8END18UO21IB3a09zASOiZOCQVK4/rIVvL9ad0yQK+T0JQmeTEdDDW90VQ+hzEaTw0ax0OIJ2P3o4d1qUGAxfBIdnL3cK0HuDULKsSkLL1qFkYE4+HoKoRwqAXn2qwTn2Qgx2csATN0rll2Osg6hK4q31Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFi6af1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DE6C43390;
	Wed, 31 Jan 2024 23:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742144;
	bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LFi6af1YytnN7opBUJgwjt7ugVYMCXGVw9A0t/RBZpLlWcy2/OhDNVcRShOBNI/35
	 9bHCsISvqPqviqyEsMONvetqYJoV6LSxw83EvF7Z4Nc/PM4o4WIFspfWE8hlD3cv6N
	 GTGdaBjby2/MIUepOfWLTnQBEEg7QAIAhNFCp2dqjIedEchVdnkEcfOoeHlIHeZ3R+
	 gJviNDEQAO13qGfyURWuTW4BoRZgiXbWLEsjrPaYrapZuw0rcpROxBZ1oBISyXFdSr
	 tTLiLw80K4ZX4jp7FzaVAXwP4ZTLBbBjX05SfZnSm4HDqJkgGv1f7mSdzm5AFOSX5o
	 ALzADMJuOE7SQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:43 -0500
Subject: [PATCH v3 02/47] filelock: rename some fields in tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-2-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5841; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KKWqpeEjZJwVDa3yEQ2DNXVtpjOqYRLGgfpS4PiOo04=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFujIsQIjNiz3uqjJC8wcRTOIuNqoQDPhB6L
 kLvOHpJtvKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbgAKCRAADmhBGVaC
 FeYrD/9x8UIT7eXHwJrckEzY2O7WTa9GLKAOrzBWKkQcN6WD07ftBdEii3/9FV4bNh7HdVtA+QT
 eWwcrZ1XKAEs3NpiATsLdCLx9KX6fKpYgfZ1lFDhU6VS5Px62ywyyUNoLUpcUNOA0ThK7Qva3LJ
 DdHzWaEQ/URYXwX/5nYIO79Cj8qJF4Iuibex0iupzu9SGFUO3C8Hmiw9BLcjNBerCG0n8B5ywJ1
 2wT0ye6e8Rnge+fBdsuxoLeWP46188RVH1WXapWlRF3A5j3zsW/0ILvYwkokBXFR1ryq4SwKGP6
 X2wG9jaElUgvx+/PFhy8o1wPNUrB6Y3DPebbFOqhBl8MLcwrosfNP5zP8VqXZH327qyWH367g5s
 gWDyK9o9ArLElXGybjk3jXqYsObGe+j7Ozgbus5IhjbBJMw/wAZxApkJCuVzuyZMeKe3reIt02Q
 ALOGIE/J5gBhV/IeUZEML4KqcbOW/1kxJnNPKy8yIAgJ6R0coaXsRWwdGrw7kU62hc19ujWAs4o
 rkFiVonha46LxWhkGvVmSCrEawrCRdeigoe72bNhFKWFBvadJkl9I5vOQbi/AaLpgKwukf+05Lj
 ZXAULAuTtP7bLh7dTi5iLv8/OkT9qG2kO2Oqx+U9TIeRdllZ10wx6lJZ0sFqSTuIQvQqLOWT83e
 OfceXo4rvpY9yPg==
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


