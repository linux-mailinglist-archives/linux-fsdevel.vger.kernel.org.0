Return-Path: <linux-fsdevel+bounces-50353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E6ACB0D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B497AE739
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084C23C4EE;
	Mon,  2 Jun 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6klgPwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB0237717;
	Mon,  2 Jun 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872991; cv=none; b=M8z0bpemRzloi0a+cxMlSxC/ubEJYwr3EX5Gz7SwJkzCITQqz8HHyfEoSsmTfQb0hIyZNR17dC32pBgVaZv65jHbXcd255px3x5lJgT3f7WrLpnNzQA+5AybBe5mR2QGoKtlv4cP1fkf7OCneTfc0XlXctEbK9nFkCikIEm2dYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872991; c=relaxed/simple;
	bh=cybvGGUeAdvyfxQog3LULK6UI3fwBr3sT2axjjTf/Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+OiOblQOI0v1lq0TmN6OWYz0ene+f4bKatHFh2s/WtV5ZX9HhOz+uPYgWdLCOdQI5+k6861zDgLD1Kzu462SX4mQDdB2zcnC8/6J2KeTi0ouZLcT65cJ+C7TUbpCCWezvaph5fNnOwSc5fqeJcYRcEzlCh/bAu9/vW2xrNBonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6klgPwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE0EC4CEF7;
	Mon,  2 Jun 2025 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872990;
	bh=cybvGGUeAdvyfxQog3LULK6UI3fwBr3sT2axjjTf/Yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B6klgPwRCov7N1ZUxaPpVh18TRGWAL8UqrTq+i999/NzSFRz0ih1cjMiyIJMjRrrm
	 W3ZzvokpSl0ADAgjMaI1EBunveBlAl+ui00hcm4SCHBXPqy9DVzMoiXmWc2RWrN12y
	 sPcuG1I3AVOR2gunrPtSBU65FngU4ZOrRHfrIZRQvggaoEHClsg2u3ToZePU98WrcV
	 DfX+lm3nQp0SQYIxsYDsCChmRpeNeia/Z7RRLhs7fHMwVLNoTGW8YZuuuoZ2Aa5EJA
	 9ZatQMXrPwJTSPsmLIt715w2IMMR1Ip78Clg7BlLH0BZzVERHJ3x2INcTAgxvCsq00
	 zLbtYFQcTVsVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:06 -0400
Subject: [PATCH RFC v2 23/28] nfsd: make nfsd4_callback_ops->prepare
 operation bool return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-23-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cybvGGUeAdvyfxQog3LULK6UI3fwBr3sT2axjjTf/Yw=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGg9rumjMKHFOs+0Usc+IR8lmqecPTHS+/WoxEzzFmFfP83Jk
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoPa7pAAoJEAAOaEEZVoIVl00QAIlR
 xab8NbOD+LeXrDxrvbcM/SDRvKMW+B+d7Z+Hwf3PkExUF5YxozRo/aFSVn7Oj7Gd2spUdPiN1vG
 9G1VKUl0nZhY17+HEjPeYSYjq/NojNXvwaAn/pdnRCnL1tu00fVxDLzZyJz3w5WUJwbrC52yrFb
 iHx8I4hmYzXvdbOx5IHI5uaK+1XEmFw7WujAS+Re2HadlzuNdLUrQKLBC5k9reTxVWDi4MvT/Pe
 SAAp56U2XE7ow3+QHsrMrfEbv6SnvyHGAlQHIFfHoi/F4qR7pDPGExctJFSm3GrCKUlWFXZw9NP
 sB25ETYry/+tdV741x4HR6fNnAT3kyR9dUTu4humtftfinJErg+Gf5gQtMDW3ZT5k0DJpDBXbmy
 NlmPMLDuwqD2LR8j+usj7hz0cxJruRgCTALImPu9Q3GgflPPvj5Iwh2YeqdU7xLcKEIKEFQbBje
 Iy7A09DBy2r85vPUoIa5+BbOwTuQFgaVBJQadA1vHXUhmED0jY2wyJi64afraUhajHlkDGMx0pI
 ySHLIXXhhEU19zS0QRP1GAJW/vyVMmeGoQMV8SU5l98gBVNNdB85UW4mcrRWsnlXDGFITtbyTcQ
 9yTopdjvl+lye7CFFHXIAsXcNCpFm6d6U36aFwELSvLSsfHOv7hY81BKg9jGKyTDo3R1B1tdhue
 tQYAz
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
index 2dca686d67fc0f0fcf7997a252b4f5988b9de6c7..fe7b20b94d76efd309e27c1a3ef359e7101dac80 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1785,7 +1785,10 @@ nfsd4_run_cb_work(struct work_struct *work)
 
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
index 290271ac424540e4405a5fd0eacc8db9f47603cd..f23699998e4c978b4af0c87cc0a959851ef5ac4b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -653,7 +653,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_layout_stateid *ls =
@@ -662,6 +662,7 @@ nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 	mutex_lock(&ls->ls_mutex);
 	nfs4_inc_and_copy_stateid(&ls->ls_recall_sid, &ls->ls_stid);
 	mutex_unlock(&ls->ls_mutex);
+	return true;
 }
 
 static int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 164020a01b737f76d2780b30274e75dcc3def819..5860d44fea0a4f854d65c87bcacb8eea19ce82e4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -362,12 +362,13 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
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
@@ -5482,7 +5483,7 @@ bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode)
 	return timeo > 0;
 }
 
-static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
+static bool nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
@@ -5503,6 +5504,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
 	spin_unlock(&state_lock);
+	return true;
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 706bbc7076a4f1d0be3ea7067d193683821d74eb..98f87fa724ee242f3a855faa205223b0e09a16ed 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -97,9 +97,9 @@ struct nfsd4_callback {
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
2.49.0


