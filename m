Return-Path: <linux-fsdevel+bounces-9756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99983844C39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8881F2CA09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5814079A;
	Wed, 31 Jan 2024 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P41UGYqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AB140781;
	Wed, 31 Jan 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742239; cv=none; b=Xiyq2i0VCZDMsNKM1nxGkIZgIDskHQTIQVBFXkCneK1Ov8eSB6gltHlhim5PYcJ9uVnLRo1PODZx85chQaap9QmYPZZhINkc40iDJAW8hxTioa+mKUUu2j7yjp3PyRkGR3OwUHmZiIScvyYnF0LewHbE0184b/GdvM75DXUc6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742239; c=relaxed/simple;
	bh=IeTENray2gSzrhF+1zVNOLrjXqQyLU529tCaMhSpwV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyPBcPPyaC4lrkHIgbyA0Gu4oj8+Zij0AVysgjdSMJ5V9mg0PZYp7ht/1h4Rx2/PJ82seZHfuCy2RQTf0AwD21npy3jSzvZ0WO7kzY5FojcJGl8X2gJKbRZsWivqe9Cv4fslyZVlINIJu7TpuM6GNyX16Yt5bgh8jSeNO1IxXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P41UGYqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE31C43390;
	Wed, 31 Jan 2024 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742239;
	bh=IeTENray2gSzrhF+1zVNOLrjXqQyLU529tCaMhSpwV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P41UGYqauJWFVK0bmXh1aftAWWLHCiixaFfM4X6JIsW6scyLAbzv4fCIHVFjdoD00
	 P+O2Acig1P0+jXsN68gPCzMKg6Duq0FHNQvs314TIYq4YX8CjxKe0PZFatGlFGLmbg
	 r85Hl/t3cmQSDtXC+HV0j+sp+Lh9TsJLz1EOJmhZurTDjY6scZ4iovIv3OpKJ0WfL7
	 VhYVrhlYeIyMBrWnAds++9ji8OH+3otexYC51dIIEA7/zyna2LwfcDRK2AviGOLjwF
	 9svoe2IqzSauVAd8jGoMT38xO/XXKW2/9n8cJRZ/G3M62SyCLzjCWJNdWEIgDKONr1
	 cjFSHnfpDoXgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:07 -0500
Subject: [PATCH v3 26/47] filelock: convert fl_blocker to file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-26-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4221; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IeTENray2gSzrhF+1zVNOLrjXqQyLU529tCaMhSpwV0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFx2VdVwn6zbUu1eXEoq1C2FLlhrp1iCkdup
 bEzm8yJtd6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FaoGD/4rGXrnX7Zvd/LNc2r4gyI1Y2HBaNAZRb1j+KbTFXF9/sVCSnhwrMEIzkX8Npc6Y3Tuypb
 ErL/3L3JCt4InQFbaKGs6bjUOZBAJwxL2ag86WRAKShWOhdF8EItkK3mHy/6P449ULlDtI6aBbH
 qjho1v297KlMCsrogb87QkZ7frmY6IB0HU57ueZz2YQWu7Nq1oTjjRXEk7ADTLwQ7vhsw9sUQl2
 WYe90FDde2jijdXY64+xKRk5LUTZh7xFbPiseIFbXbgGIxJLxWM5v9/6W+1XuUy6lynBn8bjV5n
 FhUjQZtYLTQXrdIDBG4CTHjijUpKMyXN9wvo8D/CEeHRDXnhDxfO4ePP+F7QKiBIbSQnIg3m2MF
 DBrgBrJ4Sz+1KVlISAxVZqslhnQIHgESdkWEk5lECy19QJ/kUUe5TdE+POQB51gkjM83EvXG3q/
 l69WsLCs33tENyg6j4HLn2ewA1FjD0NCncjGNS7mF/8ho0d8DBnt1fY1QfB93qNavxnvuHCgdbO
 QuDN1ZtLtbPA4L0vFsXpv1ssH0s7R4/aT0bR791ZZ5tILHHZ1EaFSQ4NcITRfBRt74ym84P8Gna
 OvLKxYhooXzS2aFy9gqGu63RjOkf0DNG+6YaNCoU+LYF0uW+vFLOABd5i/GDDvRWGOyjiOymZ4G
 ckFU3M3PKM9D92w==
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
index 0dc1c9da858c..0aa1c94671cd 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -400,7 +400,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 
 	/*
 	 * As ctx->flc_lock is held, new requests cannot be added to
-	 * ->fl_blocked_requests, so we don't need a lock to check if it
+	 * ->flc_blocked_requests, so we don't need a lock to check if it
 	 * is empty.
 	 */
 	if (list_empty(&fl->c.flc_blocked_requests))
@@ -410,7 +410,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 			 &new->c.flc_blocked_requests);
 	list_for_each_entry(f, &new->c.flc_blocked_requests,
 			    c.flc_blocked_member)
-		f->c.flc_blocker = new;
+		f->c.flc_blocker = &new->c;
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
-				flc = &flc->flc_blocker->c;
+				flc = flc->flc_blocker;
 			return flc;
 		}
 	}
@@ -2798,9 +2798,9 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 
 	/* Next member in the linked list could be itself */
 	tmp = list_next_entry(node, c.flc_blocked_member);
-	if (list_entry_is_head(tmp, &node->c.flc_blocker->c.flc_blocked_requests,
-				c.flc_blocked_member)
-	    || tmp == node) {
+	if (list_entry_is_head(tmp, &node->c.flc_blocker->flc_blocked_requests,
+			       c.flc_blocked_member)
+		|| tmp == node) {
 		return NULL;
 	}
 
@@ -2841,7 +2841,7 @@ static int locks_show(struct seq_file *f, void *v)
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
 			while (tmp == NULL && cur->c.flc_blocker != NULL) {
-				cur = cur->c.flc_blocker;
+				cur = file_lock(cur->c.flc_blocker);
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 4dab73bb34b9..fdec838a3ca7 100644
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
index 4be341b5ead0..c778061c6249 100644
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


