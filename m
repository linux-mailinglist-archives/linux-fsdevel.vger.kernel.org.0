Return-Path: <linux-fsdevel+bounces-8894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0483BFB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D24F1C20B37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D126612DA;
	Thu, 25 Jan 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e90pN0CC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809060EE4;
	Thu, 25 Jan 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179479; cv=none; b=Q+4cFnU15Ueo5Q8hFrdk0XB8JtYjI69Chr6ldFicnMn/dPv0hYOER/a4v98MOZw5LCK5VhqalVsx0nyNot13eTtN0/e6lbDVDXzRKAn7SXtzHrh9cJgiLeDQKbHQG83w17SIDI1MRATOJubeLK+SuSies9C2QTHrNySyfLsyAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179479; c=relaxed/simple;
	bh=qjAY+Yc9t3KdmxLT7uCiNgjt2jj+CbSOO+1wisiSIS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppGHXJH7u6Hw+fRk+a1u4/Ty3qnATRwl3cKONLnZcU3VEWDc1uaAafBCgdx+jFPRu24cWIwJLTZ0TPq4uEw1eAz4M7rRsXI+lVVY/JfMxLborCrgGjrRivT3pqH8rNlG6eex3yxsX1f1d6iEe3F2zE6yYS28v5Qwz6WPoo0fX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e90pN0CC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FF3C43390;
	Thu, 25 Jan 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179479;
	bh=qjAY+Yc9t3KdmxLT7uCiNgjt2jj+CbSOO+1wisiSIS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e90pN0CC4IliJTH8hSXxNKTr1haQzkPddgP/rDUr3TCsEP0H27psQ8vSGvx2ikmlK
	 Eh8RdKHSBDxezQvvV8BGXbCvmllginf05KyS2KexZQfKOYgMyhhtgx/Hyd+qa5Sq05
	 P+8mB+deuYCrNN/d5z4sNwMiL8ZHBRfNDwMsKIOh/1H/kqpX8TM7iVHdwRNIlD+OgG
	 5k6afRT/Ib7kGmqYp3I+GFtRDuIHF9xCCmfNbORnKN49rlKTUdY7gWn/6exrHUyohg
	 8DubepdX+BBl/Ff48gGsedki11MuERvUmD6FWL6YuumXl6/p930RpFwnjxbbefgeKd
	 PUPb1v87kumUA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:03 -0500
Subject: [PATCH v2 22/41] filelock: clean up locks_delete_block internals
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-22-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qjAY+Yc9t3KdmxLT7uCiNgjt2jj+CbSOO+1wisiSIS4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8FH6gMpwQdYKuh8876nJJ1THPHZ05tbz5o
 tfLDTtS/CmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FVrsEACf8eiJu8e08kxG39lXtQ9EakrO9CgjzZ9eYSy4JDzN2Qgd2oqyErKMqn7W7a38VZg9uMA
 g1TS6iwH5qK0My8cBGUcA1plbeytu66VkqeIA/axkQZrldkHeNTUwQuFac6vIByH9Wwo7mTf4hu
 wRsJTXtoyj6YU8IUjpoma6qXn0ehGIn4Km6HLTCFeHEp1bkjk+iFPDTSHwKS6MjlgQMc9K/ldKa
 nRCGieXTsyaxCcpX1ZkVHvXNJiPU/+2A+8pLWjd3LkUBIdiYhoij01/TIHaKW0dZpjmFj013iPA
 BAfl2DjfBV4QzhmNWdXOkLa1XY2A9NQc1YzSVKsR5UGBgCXsF+N/ZJjkaAdQ9Qirnt6mIYTq8W0
 ktNWdJy4/ITz4FbW65C1mUWXmg/eXjJcbDa4+BQ0/XbL/Yc1yMQyMyKnfgCDu/jj2CjFP8k2hti
 pdZl6eadMjXkw/SiNz+Ro2t/TRVRLVk1B/x7a2W5e7VWt0n3WkLd/nPXSOeqbkKPVOCLLbDJY3b
 t12MPh34CeLy0eF+WpBXoFhK9/1HBhrh/xbLWDEaeCDnIwu7bI48GQTS/9WY//18HYIl91xGzIe
 ufyQCWpH3gfKQIb8fLQD7LTASISerAOFOEAgWkiyrO0eTN+e0kYm2UYP2/l7WHDw78KJ/FmHJ9S
 +Vq3/Fh7XpN0LRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Rework the internals of locks_delete_block to use struct file_lock_core
(mostly just for clarity's sake). The prototype is not changed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 8e320c95c416..739af36d98df 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -697,9 +697,10 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
  *
  *	lockd/nfsd need to disconnect the lock while working on it.
  */
-int locks_delete_block(struct file_lock *waiter)
+int locks_delete_block(struct file_lock *waiter_fl)
 {
 	int status = -ENOENT;
+	struct file_lock_core *waiter = &waiter_fl->fl_core;
 
 	/*
 	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
@@ -722,21 +723,21 @@ int locks_delete_block(struct file_lock *waiter)
 	 * no new locks can be inserted into its fl_blocked_requests list, and
 	 * can avoid doing anything further if the list is empty.
 	 */
-	if (!smp_load_acquire(&waiter->fl_core.flc_blocker) &&
-	    list_empty(&waiter->fl_core.flc_blocked_requests))
+	if (!smp_load_acquire(&waiter->flc_blocker) &&
+	    list_empty(&waiter->flc_blocked_requests))
 		return status;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_core.flc_blocker)
+	if (waiter->flc_blocker)
 		status = 0;
-	__locks_wake_up_blocks(&waiter->fl_core);
-	__locks_delete_block(&waiter->fl_core);
+	__locks_wake_up_blocks(waiter);
+	__locks_delete_block(waiter);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(&waiter->fl_core.flc_blocker, NULL);
+	smp_store_release(&waiter->flc_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }

-- 
2.43.0


