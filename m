Return-Path: <linux-fsdevel+bounces-9759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C622844C47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5911C2156B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CAF14461E;
	Wed, 31 Jan 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo39O7QM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80041420DD;
	Wed, 31 Jan 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742251; cv=none; b=gHFhEhTKe3ZksAZXSoMNHdOU0wYzySLt13unr34xFmo41YZhqlcR919RJRSU0e2L9rDmXk7cIpylRcxmg8KmW1a2BrcJjfF2Aw+fo+2CrXrEe0U4aJq4fJnk9eigbeRdT4O5FisVOnQyeeNjLxwyd/XCyP7kBHLBDnOppDzNi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742251; c=relaxed/simple;
	bh=FAQxHdV1+8yfMKT7VO4N3syoGgU+YBY/HWjJUz0wdUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XO9T0xTN/6Kzc2PHR1wc63Z5dOpdjWgC/ObebVellMnCef9k+LFVfZSiWU1ZdDMkkQV+WWX+BVFB+BcYAy3RL50i9zShH66Gb92myl24SOIZnxi3ZuxTR2AJP+vFMIJeU4Ab/uumjLMXvoSRzIF+QOVPzOPBtyQrVEl89Xldab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo39O7QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C234AC433C7;
	Wed, 31 Jan 2024 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742251;
	bh=FAQxHdV1+8yfMKT7VO4N3syoGgU+YBY/HWjJUz0wdUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bo39O7QMEzMLWtvIFToHmul4LRH9khxR0VI53DJsD/BjRNEUYbtj/PkM54GRUXhs9
	 F99vQsM84BZWn0rRZXSg0cwHLy/SXbziPstA+lT57hYFe+4irz57vYAQfVHX8enPQo
	 h10U2GTJMzj/mMgV6Vy+QDdQJyMRy9je8VpjpXwK6S70aeYJc0xJckUkDPjjSqmCpW
	 aTn7b0sTpNINIby+DNGVhXtX8S0JUNVGATW3tZY/clQuCP9SjprLFyvAVvow1QQsoS
	 2zL0oQXquzZg6+tKvNeN1zgEGeNB1TYsO8s0F5G6R1WhNOxI4Lm6umdrBD+67+2hm7
	 DD68k3sZPH1AQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:10 -0500
Subject: [PATCH v3 29/47] filelock: make assign_type helper take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-29-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FAQxHdV1+8yfMKT7VO4N3syoGgU+YBY/HWjJUz0wdUA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxf1cnuwYroAwFYo2+KfzrTvVzYQc5Fr1N5
 krCEWo0jNOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 Fb7bD/9VC2nnAzFcTcehbut8DHNauWiIU2fl0sOM+qOVaJCMVZRSnuNs3nps0oeNvXiWKOj0nRW
 RKqO7ghoU1qGCsGe4gtk8WtO/saWLcEKPf/2HzTUctSpB5L51DJiPjQ6oT3fXCRm8Aicguf+WSK
 RtuVqeut2yt9Bsl4UqpsJrierRVSXUaJtvc7yGyaf06VJUvPPg/eBjY7Y78C1of+N1SnR1kLGmz
 i+jhtIPiT0W9gMdcJ5EB6nsTq8Hz0Iv8yySlHJlNWzX0RJVTlUNYPKFEbWhiMn4Rpd+G8OoQDjy
 rJQS36sO9gxdLKEpdh8Iril8xhlyawffnG1peq/jfbSLUo4cTcysKZlc2AhOmtQ6lF8x3QsXg9p
 x1yscVmwaceDVXbn/ztEoA/0Q86+PqVdx2Y1Jr+xynVZ6JQakAo4JBBKFLc5eTmzNhCxoGjGpoo
 wVtdOD1SaLoJCptqPHd5e63zdASzvxIxjARki/ZhtaHZ08H7LNOwl12wpCTJv45IYoRlflRBvR2
 2mAXiSyQwg9j6TmNLpBKI90Ws2Lz00AXWhNk0jtry4qNqxkNpbJcNYafavngTYFBxh1wiwVszi+
 QKKyKed6XR0zbbMtEwXdDc42qu5+IlGOmnA86tK1IUHF+7y5QaZQtvzDONycBdKlXNoRAiB8lZ/
 e+uN3ahVzjwYn4Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have assign_type take struct file_lock_core instead of file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index c8fd2964dd98..6892511ed89b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -439,13 +439,13 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 	fl->fl_end = OFFSET_MAX;
 }
 
-static int assign_type(struct file_lock *fl, int type)
+static int assign_type(struct file_lock_core *flc, int type)
 {
 	switch (type) {
 	case F_RDLCK:
 	case F_WRLCK:
 	case F_UNLCK:
-		fl->c.flc_type = type;
+		flc->flc_type = type;
 		break;
 	default:
 		return -EINVAL;
@@ -497,7 +497,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
-	return assign_type(fl, l->l_type);
+	return assign_type(&fl->c, l->l_type);
 }
 
 /* Verify a "struct flock" and copy it to a "struct file_lock" as a POSIX
@@ -552,7 +552,7 @@ static const struct lock_manager_operations lease_manager_ops = {
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
 {
-	if (assign_type(fl, type) != 0)
+	if (assign_type(&fl->c, type) != 0)
 		return -EINVAL;
 
 	fl->c.flc_owner = filp;
@@ -1409,7 +1409,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 /* We already had a lease on this file; just change its type */
 int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 {
-	int error = assign_type(fl, arg);
+	int error = assign_type(&fl->c, arg);
 
 	if (error)
 		return error;

-- 
2.43.0


