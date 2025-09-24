Return-Path: <linux-fsdevel+bounces-62642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E7B9B4FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72DA2E2349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B832A837;
	Wed, 24 Sep 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjMCNtJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED432A81E;
	Wed, 24 Sep 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737258; cv=none; b=U/kAzBj3wOzmxD9lcOFLys5ePQ58yWO84RLkenmT4D3GuQIPZY1DJfU0h85UujnW8takwD9cFFo/pcfvK6Pffa83txCmb9bh43gwxWCpjVGmiYrCkmGrNZ2QOliJVAUQRF3XZVVZgsSdjJy7H7xGOEw+iXu55cWlCEwQ1HQYxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737258; c=relaxed/simple;
	bh=1odaBibxs9donD/ZYgRoiXQBnmar+fA8c0Ve1yi4eFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OB7cf4j9tUnUEl8cT7ZHzQSkOplXWoTo/cpjT2LZbEmtR6z6ZqybLfTZ8j7ksDnvBtw4DInKbCkiDODgdw4rIvcjTAQsBRFrydUrIIm4eUiauA4yzPNlQjq/vHrknz5rjqK6s3U3YfJurvBTI0x4OFu2ojFroGcOhFZuz/H/X+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjMCNtJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F88C4CEF8;
	Wed, 24 Sep 2025 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737258;
	bh=1odaBibxs9donD/ZYgRoiXQBnmar+fA8c0Ve1yi4eFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sjMCNtJoKCLQdlnd36AOFj+6Q5pPLFjJPXKQvAf/9LC1++GajIw/s2g0fmczVEaJ3
	 XLIIQgacUYPJe8OwZgdyiKoRgzrqfI0VNcnuZAAVYBbmEqjEkMD7HwiZebmCtMbd65
	 OpYjHHogMzCE4GnQS2qu4bQDkarJ4zC4tFD9P60rTqF4t7g5TqXRxoPYyW2dxDfumh
	 2M0JOefmNSQjeXWp/Kq02LdLOfOoEbN6Q58MICdmIntKioz8DYOQNYatZvXDYwWPGW
	 sF/sgAyUlL5/a+C2yWH7KQVxjyEzUuVa1HF+WROy3yAwGuc0SyCtpfBAoIIOLuR5ua
	 UhffxH4VoRBHw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:10 -0400
Subject: [PATCH v3 24/38] nfsd: make nfsd4_callback_ops->prepare operation
 bool return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-24-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1odaBibxs9donD/ZYgRoiXQBnmar+fA8c0Ve1yi4eFw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMPcr8fp0S/qd2/TwubU115qF5UsLjq+yUFh
 LvQ83oZxsuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDwAKCRAADmhBGVaC
 FS49D/0Yx49SS2uIXg/Rr9d4rLQK+IOMVTR/rt8Ul4nZ3RmYHZ2i/YuptYic9oJbnzgI8kV9OoC
 +8EV0syHOwGalsudgT1jLzA+uWNA9V+UUYLXf/C8z4c2VFk0qVCtQeaa29FZ29kLBaY24kTsLb4
 loc2Fa/BPKvSRqLBugzm2Y466Q/4SZKTTieYMmq6C/cFEXsscAexA5iWFxN264K07cV0TcwoLfd
 7+CCxBMEcousfTbVdUe7hKlW5LY27piQqo052B+V6c6vQjVQx7l/q+8XjTcbx/nOf5fuZ5plIWI
 6m51WsVRN/+DnWAYbLyUDe5u5MbmPmsyK5L4+Xl0C3nsQMOYekpCmU4QxWBNd3TfV1DW/cMQ7ra
 9rTOBeBU9S+D/cfX7n/l5rDUQqtIvTBrytAdEj1btij29u9iI/HaWCzEEfWjcPAQ798qLWHHcN4
 auAD6mm+3InD85T1KYss23uf0S23/kfjmc/FDNFNX+fuSP9L8N3kqZUgwPYelL3WuZ6IrmwrXgS
 m4b496RY/6HGmBkeDlbMUmJn2jZXBPEPGWIQRaYtM2+w/3gX4NDveNYqWjF5GBuJUPTz7qM9h3f
 POgKaSm9WJtDDh1r06aIek1AvNA+uq9vtWHyS3DWk/PDz+OtQUf7IZ8OLpzlSCPlfY2yIjpb9na
 /vLqqZD8UAnexLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

For a CB_NOTIFY operation, we need to stop processing the callback
if an allocation fails. Change the ->prepare callback operation to
return true if processing should continue, and false otherwise.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 ++++-
 fs/nfsd/nfs4layouts.c  | 3 ++-
 fs/nfsd/nfs4state.c    | 6 ++++--
 fs/nfsd/state.h        | 6 +++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e00b2aea8da2b93f366d88888f404734953f1942..d13a4819d764269338f2b05a05f975c037e589af 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1739,7 +1739,10 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	if (!test_and_clear_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
-			cb->cb_ops->prepare(cb);
+			if (!cb->cb_ops->prepare(cb)) {
+				nfsd41_destroy_cb(cb);
+				return;
+			}
 	}
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe298f9df774684192c89f68102b72..1916e5541153126edc357cfeeff9ce30461b69c0 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -652,7 +652,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_layout_stateid *ls =
@@ -661,6 +661,7 @@ nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 	mutex_lock(&ls->ls_mutex);
 	nfs4_inc_and_copy_stateid(&ls->ls_recall_sid, &ls->ls_stid);
 	mutex_unlock(&ls->ls_mutex);
+	return true;
 }
 
 static int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eac9e9360e568caf1f615d230cff39e022107f12..517ba5595da3be5e130e1978ba30235496efbe01 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -361,12 +361,13 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 {
 	struct nfsd4_blocked_lock	*nbl = container_of(cb,
 						struct nfsd4_blocked_lock, nbl_cb);
 	locks_delete_block(&nbl->nbl_lock);
+	return true;
 }
 
 static int
@@ -5450,7 +5451,7 @@ bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode)
 	return timeo > 0;
 }
 
-static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
+static bool nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
@@ -5471,6 +5472,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
 	spin_unlock(&state_lock);
+	return true;
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b052c1effdc5356487c610db9728df8ecfe851d4..bacb9f9eff3aaf7076d53f06826026569a567bd9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -98,9 +98,9 @@ struct nfsd4_callback {
 };
 
 struct nfsd4_callback_ops {
-	void (*prepare)(struct nfsd4_callback *);
-	int (*done)(struct nfsd4_callback *, struct rpc_task *);
-	void (*release)(struct nfsd4_callback *);
+	bool (*prepare)(struct nfsd4_callback *cb);
+	int (*done)(struct nfsd4_callback *cb, struct rpc_task *task);
+	void (*release)(struct nfsd4_callback *cb);
 	uint32_t opcode;
 };
 

-- 
2.51.0


