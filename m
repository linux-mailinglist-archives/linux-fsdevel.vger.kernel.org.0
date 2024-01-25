Return-Path: <linux-fsdevel+bounces-8893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC383BFAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884192809A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B060EC1;
	Thu, 25 Jan 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLutGvm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4C60DDE;
	Thu, 25 Jan 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179476; cv=none; b=kczH6DtkvhoB4stzeLhuwWSvlYNAL7sv6UzapSX6FOvGDJSbOrJV0c34B0+tyvNhsWMTRAwcELnb8NWbFKJLnDwaERo6Ds2oTWs6wNHk9vPEdwV3nIPCSpsnTilHhYbGmt7oXiaUEwGqlAKyT3V1Kgt3tAELTbpe5a2wurNuWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179476; c=relaxed/simple;
	bh=B7266iuZ6+jiQ1YXgJ/0VnrXkglgYdR1uixZomRPk2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNDcSNpsN9fwPq1tlVin04pSIWyJtNUp9z/jW3daZsy4O0jGX9pr62WpJOoRN452Q4nvBrU1lig56oG+yN34wFhrm7Fyf+j+Mw40nhNE4aPR36m0G1H3x20/Cx1tisJuR8/DoUvdD8cY5Qsm8IDjShChhHMRKd2J1ofQpcCnhog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLutGvm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4A8C433A6;
	Thu, 25 Jan 2024 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179475;
	bh=B7266iuZ6+jiQ1YXgJ/0VnrXkglgYdR1uixZomRPk2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLutGvm9LI3t1GU/k6XYthttE9Pq60QidcfLG3kxeidlTngovN9L+g/qPNq3rtBGr
	 WxBV7uarlZor94LDlSrKBmKpqZj2+H1ckZSDWAVJYx6TYO3NAj1IF6cSjz3l15/hIc
	 Nu6FvBDWY1CAdtbi6ZWItiWOnZC0CUQaHIhy8IL4K9nYxibzz9dZHeFaqAOzdbrjuL
	 lZqOgvIMnaP4oJTLUaOn7DP5n7W0HwNthT/vL+pUoyzbWbBqlwh2Gm+OTz6V+bleXQ
	 WBHAYDnzqGdLg3tSERM/U97kYXqfjep43Z9CxjPKEgI+Ac2new7btkdTQ2HbVrgoC2
	 lQ7hk33cqFccw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:02 -0500
Subject: [PATCH v2 21/41] filelock: convert fl_blocker to file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-21-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4323; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=B7266iuZ6+jiQ1YXgJ/0VnrXkglgYdR1uixZomRPk2c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8TgeIwFdM3HQqZRf5jL3P2iWoVln/LVtLc
 Wx4KR8mYvWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FeqHEAC7hs0OVw0/Q6bUb0n5zl7WPVDh2WjgOcwm+GPh5veajkFPgKKFlCuD5cgdGhQ9iHn/Q7S
 igImP8Sodax54n/7plM4hMqcz1pJTiv+auZ2/cKv/X/gRZroEjzIGA9k8AGr6+cKBmNOGIybgIS
 JqefyxHLx1/e4P8GBvuIHPjcSkiPhysQ76Y404VnxiqZ8ZO4sxtGCVeYcYULKDChsvwG0pcdLbe
 1mR9v2i5e3ZaCIhkog7DJjTUzLcsti0po4YVCZS2f6byipymhKxHbLoZ9grkYHfgrR37kTRj9Wd
 u3P9JTS7GszZdFkYRC3a3TabCej5VO01MoEumFwdFzYZUyJVZIx6Tay/tmZZQQUGONfYcC1Cy1d
 2vUHs8IzBjo9zyAFkfj0gcgD14Y5XxXWkX2gqtqsRzyg9ga31XotzQ6514GckvblyepHvTxSzQg
 SMDG5foCHEel8JKHH9eDI0Ca0+7uA52wWSkVgzZtk/V64pfAmKd9GrcY6jts+XUF4xBc4Two+vY
 lpc7knt8HX9IINXw9g7NR39Z7l0R+UCF9Kpc+DZHlFOopTYuW2B62vP1sjv3nZCMUOeFvJjWsv8
 q151rYLtH+JaTuxpvcbnWKl1QCGvsB0USK9CZdUvW9rZknoFj8dHMd3ePubFTbu6NzWWzHMPX2C
 28qyzE5/k+4yHOA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Both locks and leases deal with fl_blocker. Switch the fl_blocker
pointer in struct file_lock_core to point to the file_lock_core of the
blocker instead of a file_lock structure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      | 16 ++++++++--------
 include/linux/filelock.h        |  2 +-
 include/trace/events/filelock.h |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index a86841fc8220..8e320c95c416 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -400,7 +400,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 
 	/*
 	 * As ctx->flc_lock is held, new requests cannot be added to
-	 * ->fl_blocked_requests, so we don't need a lock to check if it
+	 * ->flc_blocked_requests, so we don't need a lock to check if it
 	 * is empty.
 	 */
 	if (list_empty(&fl->fl_core.flc_blocked_requests))
@@ -410,7 +410,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 			 &new->fl_core.flc_blocked_requests);
 	list_for_each_entry(f, &new->fl_core.flc_blocked_requests,
 			    fl_core.flc_blocked_member)
-		f->fl_core.flc_blocker = new;
+		f->fl_core.flc_blocker = &new->fl_core;
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -773,7 +773,7 @@ static void __locks_insert_block(struct file_lock *blocker_fl,
 			blocker =  flc;
 			goto new_blocker;
 		}
-	waiter->flc_blocker = file_lock(blocker);
+	waiter->flc_blocker = blocker;
 	list_add_tail(&waiter->flc_blocked_member,
 		      &blocker->flc_blocked_requests);
 
@@ -996,7 +996,7 @@ static struct file_lock_core *what_owner_is_waiting_for(struct file_lock_core *b
 	hash_for_each_possible(blocked_hash, flc, flc_link, posix_owner_key(blocker)) {
 		if (posix_same_owner(flc, blocker)) {
 			while (flc->flc_blocker)
-				flc = &flc->flc_blocker->fl_core;
+				flc = flc->flc_blocker;
 			return flc;
 		}
 	}
@@ -2798,9 +2798,9 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 
 	/* Next member in the linked list could be itself */
 	tmp = list_next_entry(node, fl_core.flc_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_core.flc_blocker->fl_core.flc_blocked_requests,
-				fl_core.flc_blocked_member)
-	    || tmp == node) {
+	if (list_entry_is_head(tmp, &node->fl_core.flc_blocker->flc_blocked_requests,
+			       fl_core.flc_blocked_member)
+		|| tmp == node) {
 		return NULL;
 	}
 
@@ -2841,7 +2841,7 @@ static int locks_show(struct seq_file *f, void *v)
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
 			while (tmp == NULL && cur->fl_core.flc_blocker != NULL) {
-				cur = cur->fl_core.flc_blocker;
+				cur = file_lock(cur->fl_core.flc_blocker);
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 0c0db7f20ff6..9ddf27faba94 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -87,7 +87,7 @@ bool opens_in_grace(struct net *);
  */
 
 struct file_lock_core {
-	struct file_lock *flc_blocker;	/* The lock that is blocking us */
+	struct file_lock_core *flc_blocker;	/* The lock that is blocking us */
 	struct list_head flc_list;	/* link into file_lock_context */
 	struct hlist_node flc_link;	/* node in global lists */
 	struct list_head flc_blocked_requests;	/* list of requests with
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 9efd7205460c..c0b92e888d16 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, blocker)
+		__field(struct file_lock_core *, blocker)
 		__field(fl_owner_t, owner)
 		__field(unsigned int, pid)
 		__field(unsigned int, flags)
@@ -125,7 +125,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, blocker)
+		__field(struct file_lock_core *, blocker)
 		__field(fl_owner_t, owner)
 		__field(unsigned int, flags)
 		__field(unsigned char, type)

-- 
2.43.0


