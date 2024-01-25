Return-Path: <linux-fsdevel+bounces-8878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5383BF58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE6828B8A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90D50A89;
	Thu, 25 Jan 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYWf9zkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8305025F;
	Thu, 25 Jan 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179418; cv=none; b=SCgOvOYsnAkAYeWcanOBfacHQO0GWS1iwM6mp45IhiFCBYvtLwH33FCSS19m7rnmgpCmBUsxsOAXXkn3wggTAwl4B6AqAWwt74Zr7255+4bRbQADHXX5pTfrWnalOgyhleC7vLNx3f8R8z9+qohq+MdPFhVVCw08dkq2aO4/0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179418; c=relaxed/simple;
	bh=q27027myRVkpNVR/a+Mk2O/wAZWZl39KGvcBhSvyM0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLi5yC/6bvL9A+pwo/Z1UxlxGRItljKAngalIbs54jjPQNZX63qdN3jeKsf9rh+zLF8y8qEnLd2PRlJINe+GssdqWvP1S4f47Qst9W5iy8Ma8AcDf4m9Ll8gk4CDwe69s2WPo5qXShZkMq8UF7QW31orssub0sGfeQcyF1hviqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYWf9zkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669CFC433F1;
	Thu, 25 Jan 2024 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179418;
	bh=q27027myRVkpNVR/a+Mk2O/wAZWZl39KGvcBhSvyM0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eYWf9zkwYvSSiAV8EKsO4FX+HZAIG5KeyMdF0jfKnbV/ES1Fpf2S6K6LUOieZptrV
	 6qVtnDAxJ/tJXjG92GPYBeQKX5MmyoyqNtPykHJsKveNcTWXiXmmNcHFktjL5kogXv
	 Ys5tH3ad8jy0r1wM1hultEjBT2T9EchYj+oTr+jAipLo4m65yIfXtg9cABR8aq9Ywk
	 BcCiX1gDQyFS/x7ZflM+falsmM0ANXC4dJVRhCLQm3QGDOQSYFD59ZuiyFkiZLFMVG
	 v3NywzPk0seAYPO/da73APkK+9FD0VuSRPKUIUEFJQ2n5eO6bL9HsZFWNI9Enp7HM9
	 J0KMDZ6Q3uLUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:47 -0500
Subject: [PATCH v2 06/41] lockd: rename fl_flags and fl_type variables in
 nlmclnt_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-6-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q27027myRVkpNVR/a+Mk2O/wAZWZl39KGvcBhSvyM0c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs6IY/xKoaZCIsCIIocRPR//KntXHoKf+wCI
 b1LwtAu07mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OgAKCRAADmhBGVaC
 FYToEACR/8vGQrrZ0lllbG6e4HRNzBryZ/LiacTXgBh7Plnr74CLPAiD5fmgJoaNnj7CkwLMS/D
 tjMqiNaSiLCE0Du7bk9z+WEXhdZx/TIWy5OuVWR+iozxrIuA74EX5qcbFwx5ZJbddlf9N/olweO
 UE0u75RxRxWA+SxBGti0lbnB3oAK4MCBhuBvk1T7E83Oo/kRkag9jRRKBj5l+cPqdwyP8aA0pCs
 dm0H7jvseU0SSPyJDd1fS9oMy4vOxooL/gPjsSmCAkLkrl3OSwRWYJff7O+T3ofoB7eBrTqLIFz
 uQWEYS2Atyt0II9dz2JSijvfYsm82dQX+W+l3VxVgwOWWg8RrODPqB3DUCJB3xIUmt2zM5QMsc5
 6BkAeNK13w3QXDi37xYythT5xy40t0ipkPUPftea+oJ+W4c9Jwq657oZZzNsu7f5nCr0ZkyTKE5
 3vOpI9/Dd5YmxKKcBv/Yl1LQlK6mrAK/Q3KxmiYCn2oCwQF/SgjhS6mgpWSwFNQsu29u1Nm9yuN
 Ch32gUzTJnrIlOtICY/lQCgKFrfecu0X7o64R4MTmJ87Kei/rE2a0CdTXvHyI1xHvvNTRGceV/g
 ZItaH4axvzklM1c9n2WfOuT9khNDfkBZiWPKA/O+ijeDJzFzJHbLs2fgwQigPzVdVoOE/WMla4t
 Qr9guaEBP5cioEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In later patches we're going to introduce some macros with names that
clash with the variable names here. Rename them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clntproc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index fba6c7fa7474..cc596748e359 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -522,8 +522,8 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait block;
-	unsigned char fl_flags = fl->fl_flags;
-	unsigned char fl_type;
+	unsigned char flags = fl->fl_flags;
+	unsigned char type;
 	__be32 b_status;
 	int status = -ENOLCK;
 
@@ -533,7 +533,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 
 	fl->fl_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = flags;
 	if (status < 0)
 		goto out;
 
@@ -595,7 +595,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-		fl->fl_flags = fl_flags;
+		fl->fl_flags = flags;
 		status = 0;
 	}
 	if (status < 0)
@@ -605,7 +605,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	 * cases NLM_LCK_DENIED is returned for a permanent error.  So
 	 * turn it into an ENOLCK.
 	 */
-	if (resp->status == nlm_lck_denied && (fl_flags & FL_SLEEP))
+	if (resp->status == nlm_lck_denied && (flags & FL_SLEEP))
 		status = -ENOLCK;
 	else
 		status = nlm_stat_to_errno(resp->status);
@@ -622,13 +622,13 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	fl_type = fl->fl_type;
+	type = fl->fl_type;
 	fl->fl_type = F_UNLCK;
 	down_read(&host->h_rwsem);
 	do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_type = fl_type;
-	fl->fl_flags = fl_flags;
+	fl->fl_type = type;
+	fl->fl_flags = flags;
 	nlmclnt_async_call(cred, req, NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	return status;
 }
@@ -683,7 +683,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	int status;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char flags = fl->fl_flags;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
@@ -694,7 +694,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	down_read(&host->h_rwsem);
 	status = do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = flags;
 	if (status == -ENOENT) {
 		status = 0;
 		goto out;

-- 
2.43.0


