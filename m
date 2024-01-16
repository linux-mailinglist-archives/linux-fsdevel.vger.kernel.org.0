Return-Path: <linux-fsdevel+bounces-8109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FE82F773
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF3E2812A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D797E56E;
	Tue, 16 Jan 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9K/g2/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A88383AD;
	Tue, 16 Jan 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434462; cv=none; b=u6UWl9uTCrE6qL9lUoJh3+steppdPHL+kYBmxuBDX4vT13U4Hg4z9doY1kvE0xiYaRGq7hZdgYHLe9CbMJTiRLzats6gs03v1GsVUEbU+YvZ5k4xaVoVDo501sS4uxBbQXaWVtQHq4yVVgs/SIb65soqkPRZe8B0QCV/AJZ27ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434462; c=relaxed/simple;
	bh=fYY43RLFfrMis4alODV6T2k0xaAJFT9jD2ide0mIsXs=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=s7SuhagS8ELPHnHO5t2a+2iZ9alMJHzWcYSy1dHiLaXpj7dv+5DHViu5krROO9O0TSEe2s7O27TAtKRAG3YTypHtvwsnWg5f1GWWJurTvBDF4ndPiFIJRA6z+c9zmEJtG4hLFLhzy06JvLKfMGxmIZc+7W+oM9CUe7EXxLBW1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9K/g2/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC6AC43399;
	Tue, 16 Jan 2024 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434461;
	bh=fYY43RLFfrMis4alODV6T2k0xaAJFT9jD2ide0mIsXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E9K/g2/Uujn8sF4y5x9MJzMzz2PEd5Rn9wEiISpzdi/vEdTEaRvV2+345ln3I4QT6
	 S+xA63XiEaTBptaQBpePSLoub+Oa+1ALyB0yAtMhzHeAUxSeTYLgzb38dtL3y1U+ah
	 YHbYNva6TYAY4PqArADjl8q4k7mA7TLzN3y8ZlTgIbR2wcYUX5R01o0YSSpkDOYYoi
	 2S8DVhIXomHO+y3dsRGa/ZsFKCokm6sYT0X6dJAT/hRHp95zLhSHuD8WqVdQLY1gCS
	 spM1y5YNJhnM8LtEl1+7/eo9NeDjG207jeZlpLfRp9CS6D3DsgdBFn416VZKwbkUZ8
	 wj44QP8Tv17vQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:10 -0500
Subject: [PATCH 14/20] filelock: convert fl_blocker to file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-14-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fYY43RLFfrMis4alODV6T2k0xaAJFT9jD2ide0mIsXs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0ilMjBo06ufTIrd2YjGuDyXSZtTiexLCJGw
 IEuHMWfSXiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FdGmD/9/BFsdqNGxoBF3TSst8XehQYZpsJpLMeV7rWEBUb+HK/HlexsQekx1jL6VcceVvcPBrix
 wHvCFscaL6cEa7avBmrjjt4fGef95N0hD1Rrr2sHXIpO9DxEC61VpRu0iUoenjj6VpC/S/mm8/Q
 LfyJdXX7+mdgvSpQ7kTaVpOfZqF/erECj/erJEsv0ckfNpgAW4QePOxfEO3oBnR+qvr9gpMqTj1
 qUNXj2om72ihHksJVJpQNP6QX0S155pjeQyxe/Ztp/89TXBtW2LZkgvud3p67Uyi3h3PFNkF1kJ
 9FIYKqx6w5Od+yMutA8U3pIvBVsuaYLdLXlwjAIXAZvG4TpXfb9N6kPSJvYQxIVgzOqM5W/a+n1
 oWQHwUbyqOflWa7YkPu3CiSXfSGQWwrptv3kej1jJkkBf0fsV3hQ7MmL2I+Hp0EM3eZxB0yA5ZK
 uiRTzTkdDHRr8rj/q5Cpv6W1fw2vO5YEwgmgUKhIuHka1tVuz7NKUbr3uUdlFujXTl26pXlYJxG
 AqOLgRxk5lckyF21EtHYR9xkbmLWsahdhgghJ22Uk1kgPmqxREchyhjBNhotFVl9Ei7jI23RGim
 DFfnA8aUa57SuTGLOD5b8bn3Mint96LsZNi9xPDEaXA02jQxljB40wnuxtGzg95IRBQ6P9EOP7A
 ZOKHvKvPVfO9OFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Both locks and leases deal with fl_blocker. Switch the fl_blocker
pointer in struct file_lock_core to point to the file_lock_core of the
blocker instead of a file_lock structure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      | 10 +++++-----
 include/linux/filelock.h        |  2 +-
 include/trace/events/filelock.h |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 280149860d5e..1bc69a96b96d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -433,7 +433,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 			 &new->fl_core.fl_blocked_requests);
 	list_for_each_entry(f, &new->fl_core.fl_blocked_requests,
 			    fl_core.fl_blocked_member)
-		f->fl_core.fl_blocker = new;
+		f->fl_core.fl_blocker = &new->fl_core;
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -796,7 +796,7 @@ static void __locks_insert_block(struct file_lock *blocker_fl,
 			blocker =  flc;
 			goto new_blocker;
 		}
-	waiter->fl_blocker = file_lock(blocker);
+	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_blocked_member,
 		      &blocker->fl_blocked_requests);
 
@@ -1019,7 +1019,7 @@ static struct file_lock_core *what_owner_is_waiting_for(struct file_lock_core *b
 	hash_for_each_possible(blocked_hash, flc, fl_link, posix_owner_key(blocker)) {
 		if (posix_same_owner(flc, blocker)) {
 			while (flc->fl_blocker)
-				flc = &flc->fl_blocker->fl_core;
+				flc = flc->fl_blocker;
 			return flc;
 		}
 	}
@@ -2817,7 +2817,7 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 
 	/* Next member in the linked list could be itself */
 	tmp = list_next_entry(node, fl_core.fl_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_core.fl_blocked_requests,
+	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_blocked_requests,
 			       fl_core.fl_blocked_member)
 		|| tmp == node) {
 		return NULL;
@@ -2860,7 +2860,7 @@ static int locks_show(struct seq_file *f, void *v)
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
 			while (tmp == NULL && cur->fl_core.fl_blocker != NULL) {
-				cur = cur->fl_core.fl_blocker;
+				cur = file_lock(cur->fl_core.fl_blocker);
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 7825511c1c11..9cf1ee3efeda 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -87,7 +87,7 @@ bool opens_in_grace(struct net *);
  */
 
 struct file_lock_core {
-	struct file_lock *fl_blocker;	/* The lock that is blocking us */
+	struct file_lock_core *fl_blocker;	/* The lock that is blocking us */
 	struct list_head fl_list;	/* link into file_lock_context */
 	struct hlist_node fl_link;	/* node in global lists */
 	struct list_head fl_blocked_requests;	/* list of requests with
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 92ed07544f94..49263b69215e 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
+		__field(struct file_lock_core *, fl_blocker)
 		__field(fl_owner_t, fl_owner)
 		__field(unsigned int, fl_pid)
 		__field(unsigned int, fl_flags)
@@ -125,7 +125,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_blocker)
+		__field(struct file_lock_core *, fl_blocker)
 		__field(fl_owner_t, fl_owner)
 		__field(unsigned int, fl_flags)
 		__field(unsigned char, fl_type)

-- 
2.43.0


