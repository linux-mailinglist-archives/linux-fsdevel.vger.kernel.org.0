Return-Path: <linux-fsdevel+bounces-8105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8A82F75C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25FB1C24479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C77C089;
	Tue, 16 Jan 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFfTZRBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694E37719;
	Tue, 16 Jan 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434446; cv=none; b=MImqtbtvBbpoTW8ukNFTDqYxLzOARcUD2Jhg4dO/jxMaiVKvNZEgARXdyk3J/BUPu2TtkdoLueX6zy1nUnLxDaYufv8nBW/rQ3XRGTwesTAcxYtKqiBdQJeEJvFBTvQNbM+UhRWgBjNYUdZvIiTnjp8hGPOsYPlTbQrvknCH8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434446; c=relaxed/simple;
	bh=66rpBBxRF2rJb303Mt/pEYvt97DkJ3vkW26GZ/SUUu8=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=ZEpaDpvNhGz86FUCZr8mmI/PUg5hEjnR0luvLl43BtzvGab7p9OWS6QjPoySaMOMMBWZ6HP/F4V0A9SEVcg8x2E1joLvEtqzP5d1IU4q2+4uffhFvXQeLYxI9UMpiD/zcXIo+4Sj9sR8M3JZKm4btVYTxq9wE6HkRWB+eXG3mEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFfTZRBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F6C43399;
	Tue, 16 Jan 2024 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434446;
	bh=66rpBBxRF2rJb303Mt/pEYvt97DkJ3vkW26GZ/SUUu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tFfTZRBlkiCk9Eab2eEQSMGmc8OV/LJsjXpZlKXSKlldgNFXLvc7bC4usSVlvaW9i
	 Gkg6WfRCh4Olf6lZcfwtO+XwV+irXRZQ+Y6ZxIlWrG2+VLXv0aJYjPdJAXoNIpjKXn
	 dgeDVmNkhzPt282Zja4kOLVK+mylOvOUy/lLahMNq5K/YV4NU7mquEmoMeVy50mZSv
	 fK8klBfP3WI8Hphmx/ooWaS75ivWuPXCb3UTg3hFTlCOFxgRzaod9pKbtjbVsbgrM9
	 U/yi/ERcULhVKac/eILSgveCKb8IkiBAk+5CWmQi6TL0pxwSyZrSP673CqT95KZdSO
	 sGheVeaPna3EQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:06 -0500
Subject: [PATCH 10/20] filelock: convert
 locks_{insert,delete}_global_blocked
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-10-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=66rpBBxRF2rJb303Mt/pEYvt97DkJ3vkW26GZ/SUUu8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0hPQuRA/Abxngx548TLejvptzB1l9nP03DR
 GO9Nuqe4y2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FQUSD/9S5nDMSLzIoBx9vB361eiaIcOC3TmbdtceOtF+KCiAi9eWXt4DhFqbNtdbqC9rpx+3IfC
 mLhS6/Zw4mAZqZBPGcURkFfRoVmhyYCzug5fY+rVF1MyrrNkaDNSOcz05S9bmJ9wITmBnfEYZjb
 sM6jHMAaYV5xpLQBGgWvfVaZLK83fi8FqNXgW2DG7qoAvvzIFfPD5bM0aQQ0Pqj27m3W6YmvObC
 uoJbVbWj8pq/ZETS5jQiQ4zsqlNb2ZyQEgJmkrcTZ/XiXng62F03RXAay1dDJ5/8l2qN96Lo+qO
 96PGNAOfmuRcdJ+us2i4GxlR1JYpfGR2TkoTJH87evlOXL8h2GPijHylqikofsvPulBK7/N6ABi
 RjbWHWgeBNspA7JR0yTo4yYy+iChvBMbnCEGPBGNIeaR9Z4UNFOjjIpdfA/5hmp4yXksPPmAdwF
 g9qc89zKVTHrYh8NHS4MdyOVSFeSFn9HBsM79eH7BQcZSFJOMcJrBEcq8ZJZhmTD51FbhVNnqeo
 X/4w9YASaRiLmBARrAg6RvXwBjENPIg5lu0iZu/UOCokCgi+F4qDGNUXfL/uTT5Cxw4i7KsduQi
 m9ZOIiArcBNp765MHY8i4z+pdh4K1jQdLgw/lKAcYqzNUs11fbNKTSljL7FwC9SWzTUN9zzQmIg
 0W+NZaNYeCIrsZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_insert_global_blocked and locks_delete_global_blocked take a
struct file_lock_core pointer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 5fe54f48b9c1..770aaa5809ba 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -642,19 +642,18 @@ posix_owner_key(struct file_lock_core *flc)
 	return (unsigned long) flc->fl_owner;
 }
 
-static void locks_insert_global_blocked(struct file_lock *waiter)
+static void locks_insert_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_add(blocked_hash, &waiter->fl_core.fl_link,
-		 posix_owner_key(&waiter->fl_core));
+	hash_add(blocked_hash, &waiter->fl_link, posix_owner_key(waiter));
 }
 
-static void locks_delete_global_blocked(struct file_lock *waiter)
+static void locks_delete_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_del(&waiter->fl_core.fl_link);
+	hash_del(&waiter->fl_link);
 }
 
 /* Remove waiter from blocker's block list.
@@ -664,7 +663,7 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
  */
 static void __locks_delete_block(struct file_lock *waiter)
 {
-	locks_delete_global_blocked(waiter);
+	locks_delete_global_blocked(&waiter->fl_core);
 	list_del_init(&waiter->fl_core.fl_blocked_member);
 }
 
@@ -775,7 +774,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	list_add_tail(&waiter->fl_core.fl_blocked_member,
 		      &blocker->fl_core.fl_blocked_requests);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
-		locks_insert_global_blocked(waiter);
+		locks_insert_global_blocked(&waiter->fl_core);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
 	 * waiter, but might not conflict with blocker, or the requests

-- 
2.43.0


