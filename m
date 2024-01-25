Return-Path: <linux-fsdevel+bounces-8886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94683BF89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945301C21658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C065C5ED;
	Thu, 25 Jan 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSKpKtae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284905BAF3;
	Thu, 25 Jan 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179449; cv=none; b=B3QXU535pKeR+75ZjE1yCygihoqBOgeTARRIdgO9oHtYcw5TYwxDN5jZk01tLEFjmzYOJMIbaehL0jWWDzz/IJ0YTZC7b3CpOYOHvEDjRijUHLnGlQO0tTCiyzLu8rVcYBtd5oJ292O97DZU9juY3FM0kU43xKOJSxe882kTctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179449; c=relaxed/simple;
	bh=SE+jYS/yZlt9ls0SIupp0FcJqUlb1fCGOHRTNcE5DEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3uDKCdLGIDgyd/66FVK0fsZiTrSttSIQFqjDQFk46lWp8kqQuAiMWq1WiYz9tdU6RyWXIBT6D6ozAuVGx1S4UILfzgC7ET1WvhRSRRrfBCWvD2/oULjo+HkA9Shh0bFguFQviEYQZaNoV+lGiFUW3siLirKV9U+QqMo/MpZNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSKpKtae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FBEC43142;
	Thu, 25 Jan 2024 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179448;
	bh=SE+jYS/yZlt9ls0SIupp0FcJqUlb1fCGOHRTNcE5DEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CSKpKtaeM1ZK2EklKrPZzbfB8uWFGiSfnTjub51zshkJZquDPvZyjVy9wKFxBkt54
	 XSDgjfv0PZWvdA0aDFCMcKJAwET/y8xugm/1yYS27cTS7SYsMFuLVWOUEQcp9mnHT0
	 /Sa/xdwtx/HiY7C8o/EQ0SrysHw4hwog0+IhhbffRLBe+9ztQy0at1+BscdX7pXyTH
	 qsSU9NDW+HKgLEFrO2GGbsN5+J+QIgV1ekUkmPozlpZ5LCW4OpNfBiriidvIMk1iA/
	 VYs89tq9CXvGAgfSuS+FtyqRI+IGNMIkt/pmdFOwm8LM4vwGpPNLB5ClxBZ1Bb8v2y
	 ptnVP6tmEzVcQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:55 -0500
Subject: [PATCH v2 14/41] filelock: convert more internal functions to use
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-14-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4016; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SE+jYS/yZlt9ls0SIupp0FcJqUlb1fCGOHRTNcE5DEc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7CyTqjRhTFya1dpSE1Jkuzb6RdPbxLgubP
 qsSiCmBW1SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FQIcD/93Zc7iwmooco6metDCV3wsSZtdwrnxmrT6ntDE5l87jDi2cPJqsbVTZaAxYz5VS57fS4t
 QygJ8hjppkpKhVtQF5xuv/qpo8pkEBNkWQIvilv0VYifByBCgp6g14OscFBfLZ+QGrruzv/WdAO
 iA2zxtZO8McI4brX/KPEL0kV6mgQ+5jn8vx7Bhw/DFnrZEE2eWHRNZo/suDrIYmWso8UwIIP5iG
 dbdDzp051GFbsi+3IujspidJrWIN89NUc3hFxCqM96bM603S36glEuzARFD8Wp+Oj2I0RCOUrQ+
 IE2BKMEAzVFuTofo4HgX/hwycZUcWK6VbBcUI+JPXyJDqllx11rmPl8cg9u/7gdACVtM+MrWbpX
 YuA9P96oQNej0ZedXeaUJLdHXYhaOwfofmimFGytflIPM4a+Q0XTM80Qgt8uYEUVrDDFYZW3yj7
 SmACVlYE/qBAaXh/jnsAso9v3toZPiGEz0V7JmeHuispGByCt7+QPNH9P4ZrTn2E3eSyhpGUgT6
 HD5OyZ71ytsMwza08qCQLQJETclWBtlz5jjWDbLiFG9oF+SMmbjzcgKlR27Z0tbxzteQVlSkqDX
 juoD/+oPWZt0WSU9gOZ65bowfq5HxC1SfwGlWV3uyIghXaKLhl2RKVpXafdcCtsmXhO8cDvKsna
 J4lHFYtATPQtuNQ==
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
index 3a91515dbccd..a0d6fc0e043a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -197,13 +197,12 @@ locks_get_lock_context(struct inode *inode, int type)
 static void
 locks_dump_ctx_list(struct list_head *list, char *list_type)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
-	list_for_each_entry(fl, list, fl_core.flc_list) {
-		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
-			fl->fl_core.flc_owner, fl->fl_core.flc_flags,
-			fl->fl_core.flc_type, fl->fl_core.flc_pid);
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
 
-	list_for_each_entry(fl, list, fl_core.flc_list)
-		if (fl->fl_core.flc_file == filp)
+	list_for_each_entry(flc, list, flc_list)
+		if (flc->flc_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
-				fl->fl_core.flc_owner, fl->fl_core.flc_flags,
-				fl->fl_core.flc_type, fl->fl_core.flc_pid);
+				flc->flc_owner, flc->flc_flags,
+				flc->flc_type, flc->flc_pid);
 }
 
 void
@@ -274,11 +272,13 @@ EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
 void locks_release_private(struct file_lock *fl)
 {
-	BUG_ON(waitqueue_active(&fl->fl_core.flc_wait));
-	BUG_ON(!list_empty(&fl->fl_core.flc_list));
-	BUG_ON(!list_empty(&fl->fl_core.flc_blocked_requests));
-	BUG_ON(!list_empty(&fl->fl_core.flc_blocked_member));
-	BUG_ON(!hlist_unhashed(&fl->fl_core.flc_link));
+	struct file_lock_core *flc = &fl->fl_core;
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
-			fl->fl_lmops->lm_put_owner(fl->fl_core.flc_owner);
-			fl->fl_core.flc_owner = NULL;
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
-	list_for_each_entry(fl, &flctx->flc_posix, fl_core.flc_list) {
-		if (fl->fl_core.flc_owner != owner)
+	list_for_each_entry(flc, &flctx->flc_posix, flc_list) {
+		if (flc->flc_owner != owner)
 			continue;
-		if (!list_empty(&fl->fl_core.flc_blocked_requests)) {
+		if (!list_empty(&flc->flc_blocked_requests)) {
 			spin_unlock(&flctx->flc_lock);
 			return true;
 		}

-- 
2.43.0


