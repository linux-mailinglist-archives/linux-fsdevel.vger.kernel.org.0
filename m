Return-Path: <linux-fsdevel+bounces-9749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D5844C11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9149296AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7FC137C3E;
	Wed, 31 Jan 2024 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJNXNX01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912D135417;
	Wed, 31 Jan 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742212; cv=none; b=lom9mkuH7PfbvXz5PeJpZCm3OQlPJ370lygJIiFF6OwUh5zkIPM/Lqgh4c6mYAYJV1Q6Qoqn6unQm77KnJy/hJBxHvx2hEuKjlHUEPJCoyt48eLXL900Isjr3T5bn3stWvcLqd3U2AIKpUxC5qnjP1jjFJSs7yTn1V6/I19xHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742212; c=relaxed/simple;
	bh=LUlgnzIHGDxpa01sAUBPp32VTGKZhkSS047Y1RIGETo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keMEV1qhr0mfxv0Mhjudj4BfoisMcOEoC5lh7tz8XnAwjMhTeT3NIunV8O8xhOSRYlJw9bUYS2ffoBYiy682QxsfyE7Hm2CmEdFUQ1nXLubfUogyV6elaFCzA8/ZokYL7aZWtVqzICS283dLnyiflFjjc9Du6tlv2dmz/a/SZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJNXNX01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AC6C43330;
	Wed, 31 Jan 2024 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742211;
	bh=LUlgnzIHGDxpa01sAUBPp32VTGKZhkSS047Y1RIGETo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KJNXNX01BLpgzKf91gG/vhyMAQGVESz05jXQ2KoSaHa9t/6MhGX1YcfYRP5+gcpio
	 +KM0zSeXPYXQOzE+eRfEyEUxh2fgLSsA/10EXvN2r+vmJnhZQGZvQzJUPN5BHJ1+q4
	 S3ZsEFGjYVBErlAdc29LtqjYRaa0kT6wHV0Dq884orS+GoKjfnR8zvLA3vsSEB2VPF
	 GZW9ZxcOD9ol+9Tem0Ovme5wgeMNZuFaLLW1drpbkJ977vN7bIctCewSBzR7hfWHMw
	 N1rQiGCWlKXLxPLZLw/Wm21VKSENzzyQxaMoBoufw204xWte8WYK9xf//bthEvhIgw
	 w/d/alwv7ySSw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:00 -0500
Subject: [PATCH v3 19/47] filelock: convert more internal functions to use
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-19-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3884; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LUlgnzIHGDxpa01sAUBPp32VTGKZhkSS047Y1RIGETo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwJtCLZeIU9Lne+277W5PEf/mS3Kjpo1GEk
 ySyODO0GJSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FeRgD/95NN3RAaP0Ip5JW93hdcuQegLRnznNkdlNtbRZPJAHI/W8imUm1teXtkdGUG1WT+QQoqX
 LwNaKJDkKVBQ9W6K8Ud212keBFEu0zHlAt+panPMG55SNQpwa+/OpP7lYgIYf30JdPE8Ff601Vs
 CpKyFGNuS0fhyGTs9koNnQ4U32v0z8smiBgd5nrKPxdIyUG8wAxobAl9fYDg6J11wFc7a85crty
 1Kk99aN7ySeiG4xj+CE4a3KmuPh6hHHmBnjivAiSiwOBanRMfGsGXYR3YrMldFxsUpUKLCcVTtz
 +iTSTNnKwc75KpSQFRPenm36rgsbbKBSt0/f48jPKXzDIGhDg3Md8UJos4+ENSz1MdK4TvFbrjq
 MINQ77teT0K7VLjKCMSXo4oaqn7POF/nI2NpAseiDkP5SiIzidRV6vL2cGyW2ipUrBGVZt0YlPi
 gtNr8wPVt3GegSOpfE1VnvutylmDKf15XWIP1rvwE50i4jy/nxt8RzMyXSs016kBhq13eMSs3bm
 wqeEGZvq9pe1Z+HDtQ2kWorerPe1J8Cuz6p4maAcm37yT0QKuBYrCNNN5gWLOOIxRCCMT7dI3rf
 721v7yruqbqe2VvED6qvnFDkxgQwW9cPXhS6Lu28DTsUjGfy+0NhezzPOKZY0iNTsptmq+4i8AX
 5cAJnMokmeRcbcw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert more internal fs/locks.c functions to take and deal with struct
file_lock_core instead of struct file_lock:

- locks_dump_ctx_list
- locks_check_ctx_file_list
- locks_release_private
- locks_owner_has_blockers

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index f418c6e31219..5d25a3f53c9d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -197,13 +197,12 @@ locks_get_lock_context(struct inode *inode, int type)
 static void
 locks_dump_ctx_list(struct list_head *list, char *list_type)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
-	list_for_each_entry(fl, list, c.flc_list) {
-		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
-			fl->c.flc_owner, fl->c.flc_flags,
-			fl->c.flc_type, fl->c.flc_pid);
-	}
+	list_for_each_entry(flc, list, flc_list)
+		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
+			list_type, flc->flc_owner, flc->flc_flags,
+			flc->flc_type, flc->flc_pid);
 }
 
 static void
@@ -224,20 +223,19 @@ locks_check_ctx_lists(struct inode *inode)
 }
 
 static void
-locks_check_ctx_file_list(struct file *filp, struct list_head *list,
-				char *list_type)
+locks_check_ctx_file_list(struct file *filp, struct list_head *list, char *list_type)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 	struct inode *inode = file_inode(filp);
 
-	list_for_each_entry(fl, list, c.flc_list)
-		if (fl->c.flc_file == filp)
+	list_for_each_entry(flc, list, flc_list)
+		if (flc->flc_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
-				fl->c.flc_owner, fl->c.flc_flags,
-				fl->c.flc_type, fl->c.flc_pid);
+				flc->flc_owner, flc->flc_flags,
+				flc->flc_type, flc->flc_pid);
 }
 
 void
@@ -274,11 +272,13 @@ EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
 void locks_release_private(struct file_lock *fl)
 {
-	BUG_ON(waitqueue_active(&fl->c.flc_wait));
-	BUG_ON(!list_empty(&fl->c.flc_list));
-	BUG_ON(!list_empty(&fl->c.flc_blocked_requests));
-	BUG_ON(!list_empty(&fl->c.flc_blocked_member));
-	BUG_ON(!hlist_unhashed(&fl->c.flc_link));
+	struct file_lock_core *flc = &fl->c;
+
+	BUG_ON(waitqueue_active(&flc->flc_wait));
+	BUG_ON(!list_empty(&flc->flc_list));
+	BUG_ON(!list_empty(&flc->flc_blocked_requests));
+	BUG_ON(!list_empty(&flc->flc_blocked_member));
+	BUG_ON(!hlist_unhashed(&flc->flc_link));
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
@@ -288,8 +288,8 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
-			fl->fl_lmops->lm_put_owner(fl->c.flc_owner);
-			fl->c.flc_owner = NULL;
+			fl->fl_lmops->lm_put_owner(flc->flc_owner);
+			flc->flc_owner = NULL;
 		}
 		fl->fl_lmops = NULL;
 	}
@@ -305,16 +305,15 @@ EXPORT_SYMBOL_GPL(locks_release_private);
  *   %true: @owner has at least one blocker
  *   %false: @owner has no blockers
  */
-bool locks_owner_has_blockers(struct file_lock_context *flctx,
-		fl_owner_t owner)
+bool locks_owner_has_blockers(struct file_lock_context *flctx, fl_owner_t owner)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, c.flc_list) {
-		if (fl->c.flc_owner != owner)
+	list_for_each_entry(flc, &flctx->flc_posix, flc_list) {
+		if (flc->flc_owner != owner)
 			continue;
-		if (!list_empty(&fl->c.flc_blocked_requests)) {
+		if (!list_empty(&flc->flc_blocked_requests)) {
 			spin_unlock(&flctx->flc_lock);
 			return true;
 		}

-- 
2.43.0


