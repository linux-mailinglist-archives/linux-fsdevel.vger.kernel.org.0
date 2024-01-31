Return-Path: <linux-fsdevel+bounces-9745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE36844BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73006292B9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF944CE19;
	Wed, 31 Jan 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW/eQ+05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538824CE05;
	Wed, 31 Jan 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742196; cv=none; b=uwEMFRzN9rqV27gBpytS0WUto5M1pp3FEoYRhIHNeFKaerwaZasBgWM8LByWx08YCzEwPAdtTfSg4pGHTOa/2JTaJqfmvNOchIzZLwtn2G1zUOY4xyM2SgjhFo7uaThgvXvZkkqFDMa+msoRw8vwIRE+tHpitf9JoDvOfRh25L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742196; c=relaxed/simple;
	bh=smZQaBDSUcgQtmSdbU7VQqlPNCQff4UZV2EFHrxh+PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLdrrA7BYexnx2QSCDTtoMk8YXAa0+UGZINjcClDHG2jXY2IeEf66gpMAwGLgF8oFjcQ5gzNkW7NAnfdxnCGrNm5Gz8dVnm7ePuf0GEvHcK4LAkWRuPRHLY5pz9TXvSysTec1WBNqTcJYMcn+5SAltgTHWB4y5h8eAooewRmZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW/eQ+05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F16CC43394;
	Wed, 31 Jan 2024 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742195;
	bh=smZQaBDSUcgQtmSdbU7VQqlPNCQff4UZV2EFHrxh+PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eW/eQ+05Jy31+4vFP9Y2H3barwbkQ7dU1UT6xgKmNqj9N4m+Ez8PIf6Mwf6XTU0yy
	 vvnSIGBGuXGWRzHBB3l8//EREAUNqa+UBlQ3M17OMAKXz1nqdlEkI3LKON40xLMFT1
	 ldcNg0F7u69dpz0m3kCQ0PIFMbK3a13Kt5VQf8U6XlXxFZCLPJ6DtgIP3gEMeP1skO
	 0X8SAGuz52XRmZ6XyLvLMxs959yXnkdRFrqGJsKdQdzA1me4eu4SqgkvpQlxtZfGJV
	 EgfqFL6d7g19IVWaapgcMXyM1+71+j2N8sQBU3lhKPnd5/UamFYxQrqodug+DSCPOK
	 q6EyY+z7MztvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:56 -0500
Subject: [PATCH v3 15/47] smb/server: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-15-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=smZQaBDSUcgQtmSdbU7VQqlPNCQff4UZV2EFHrxh+PI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwb5a0RccmT0DQoZb2DAf8k05FkzYuXWMB3
 mHjswRhgliJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FWxzD/0W7IJGr38uQCEjrXS+6oc15ULuQMyaEWcQtwqH0/D1/m8iNFpwQs+YsWg0aM/eWlDMToP
 CrOBXIj4hP/UufnnQb4jUz/4OARetq40aJHnqY0Lmejy4MMfSozDfq0QB3wrDYsMHTW8hY+CKeN
 wvGI9TQ9Ld+3yiJ/Did0CJJuPFjZhS2r/eMUXkrYf3b1IvmMkt5DnfoT3a/ALv4nKgs80uSBaNC
 IAyAMT3maglVaGWII2WFqpjZYQVbrGl91sPXT0Z2x5O/DyOGZS/L+qGohx9gTl9+F3flxvWar9E
 XYjXRbTzuUDkoefOfLbfGCkW1WEifOk0rEIL5ady2W6WCombE6X/EhTr79XraNwihmZoX4bU5Oo
 ovzpWEDRIfnEFJWzK/1SVzefiZKkQ8mAS96A1+ttkBVRqhuOgSCgpJ4mBtbOLspirN07ePhFm4+
 tIntvazavdLwHOuwCLbUkTz02Nw/opCL4+U+5AFJEsV68JLiPm+DpppBOIJU1JiQdhw6B1f6uuc
 5pn0QHTHqwa0imsUE23451cYdUdmtO7WjeRimDBwb5Bly+sIpycXXH5S6XkvUDsR/3T1i4mR9Fb
 IXQdsKZ8nI7ktdGiAF5QhbR/YMoILar5enwGAOHbj7HDVgQdUKcsffCKrn/MGIl6C0Etah8vqCw
 MeW/C+PmUnMKLPA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/server/smb2pdu.c | 6 +++---
 fs/smb/server/vfs.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ba7a72a6a4f4..e170b96d5ac0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6841,7 +6841,7 @@ static void smb2_remove_blocked_lock(void **argv)
 	struct file_lock *flock = (struct file_lock *)argv[0];
 
 	ksmbd_vfs_posix_lock_unblock(flock);
-	wake_up(&flock->fl_wait);
+	locks_wake_up(flock);
 }
 
 static inline bool lock_defer_pending(struct file_lock *fl)
@@ -6991,7 +6991,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    file_inode(smb_lock->fl->fl_file))
 					continue;
 
-				if (smb_lock->fl->fl_type == F_UNLCK) {
+				if (lock_is_unlock(smb_lock->fl)) {
 					if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file &&
 					    cmp_lock->start == smb_lock->start &&
 					    cmp_lock->end == smb_lock->end &&
@@ -7051,7 +7051,7 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 		up_read(&conn_list_lock);
 out_check_cl:
-		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
+		if (lock_is_unlock(smb_lock->fl) && nolock) {
 			pr_err("Try to unlock nolocked range\n");
 			rsp->hdr.Status = STATUS_RANGE_NOT_LOCKED;
 			goto out;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a6961bfe3e13..449cfa9ed31c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -337,16 +337,16 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 		return 0;
 
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
+	for_each_file_lock(flock, &ctx->flc_posix) {
 		/* check conflict locks */
 		if (flock->fl_end >= start && end >= flock->fl_start) {
-			if (flock->fl_type == F_RDLCK) {
+			if (lock_is_read(flock)) {
 				if (type == WRITE) {
 					pr_err("not allow write by shared lock\n");
 					error = 1;
 					goto out;
 				}
-			} else if (flock->fl_type == F_WRLCK) {
+			} else if (lock_is_write(flock)) {
 				/* check owner in lock */
 				if (flock->fl_file != filp) {
 					error = 1;

-- 
2.43.0


