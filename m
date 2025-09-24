Return-Path: <linux-fsdevel+bounces-62639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C1B9B4EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE64E629F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531D31353E;
	Wed, 24 Sep 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbwacgYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB4329511;
	Wed, 24 Sep 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737248; cv=none; b=rbAwkD+IQyZbv7ENO9kioqDckZd3dJUyRbm6hAH3iP1bU9C8yZUmuQs5NXB5OlrZmv94E69uaGDMNEyLkJY6+1yLqZ8JuHruG7hrgaRNtR+mnKdQL5e7rwIeLRmg4vvqosyTMyMPEa+aEH9bYdRck4vHQbq00BAoIG35bTA8Puw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737248; c=relaxed/simple;
	bh=qEI2qG6B94ryuzfyU9tWgRMgSSWABwtmqXuABHuQPck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZ06wmYq0t0i9bXr9xuWZS5a88qB4rkLeUQWmOEUUx8AkQHA3hWE7B/RTW9XLRicdvW9usbe2E2XfphAwHI9vZs2XCjokFM4IAyF3opuZ0D0/jBbEiyIWwCq9w2JVGnI648lktM0DPJLyrpW/0Wh2X7IZiMVtVcWeo/lHKfHG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbwacgYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B409C4CEE7;
	Wed, 24 Sep 2025 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737247;
	bh=qEI2qG6B94ryuzfyU9tWgRMgSSWABwtmqXuABHuQPck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qbwacgYA82Vs+rxINnhl799D+Dsm92hDcuwB4pmB8Ngov6MqW9LuBO8h0UIjKd5bI
	 NCwoU/SOPog1cs1qCgLise4zOIduzMDmkMfb4hYVwqpyuNSxx2+QrheYQi4iL5AibJ
	 7XtwQS2o1V7hPywCNRwjYPbwAsr9ySfDIQIbdECA8yJTNxHAvPGWDqMGWK/DDWAJ2w
	 b/im62fXgtSVLU0mN0altWojvoD7waOMlo9bjqJJ5XL0cMeuo9r8rNvKvAo3pN13hH
	 9eF5nUygtcSwOtUROtMtLl3QWc+B90mmUquFgTMuZcMTedNmqBG+GypnjKNZIAxuBa
	 57STgFvf1VPRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:07 -0400
Subject: [PATCH v3 21/38] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-21-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qEI2qG6B94ryuzfyU9tWgRMgSSWABwtmqXuABHuQPck=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMPvzaFVMcmP8JG8qGXV74JlsqhlgfupiImc
 H5gwQinmaOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDwAKCRAADmhBGVaC
 FYFyEAC947Rkeb1RkjSUjRgeUL7acwPrr4hGNluZJT8kbf0YJGH1+HclwDoXjJcRTyL+xmoEDYN
 uQITRHqwAM2eYx2eg/0IxFcuSjP20zARM6Sa++8qpkevecxcxRvlLu3fF0WOZa9WsDkzt+yyIDR
 L8FCKuu9EBilht79LvV2CCjRNjzdXGYrfnD3rAcfKjWSh7WVcXcaLZIWBc5VeQ3nXeLTj767UiA
 8RYQkHCBPRRX3FIgXbrDh82XZInG+5IQ3y12wIrp9MqR7Anr0Z7/CV+IhzGZyeJ3MOhpaqXTsNz
 yXytqLESWgUHD1llpKZZw96bswByl6zEL/1a3z1o6rxqanS+/LgMam4hDmGwtWn2zmFsn8N/IZE
 goKRgiDR0MtOkI342672fJP00ehfrLwYep4e+9XA7fboMkmoLndeNhdYmEYNutgayJS0ltdsxTH
 Tr8JmHEulTEk7eIVXJcqlmK8Kdv+lUHR/XUezzw6zsU6wSwUbMyiEZUyyEF3OIrxjz6h+vugu0n
 Dx1PxTZOVmlp1eIzxvBQx0jBFs+PG3WscvQnPdv2IfEMJ2nx49nBJKGIo9lr8TJldqUoWzqiPwo
 Kd79SqSCWUbs8PUjNKMOji6SQymA3anpN/2RD0XWPkd4Z4M/CxIF2D/18uIcArw+LlUoehWQmQj
 +MueBGkQwdN7lEw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d1d586ec0e4e2bef908dc0671c34edab9cad5ba2..e219556e0959dbf0a8147d5edbb725da125a978f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5937,14 +5937,30 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
+static unsigned int
+nfsd_notify_to_ignore(u32 notify)
+{
+	unsigned int mask = 0;
+
+	if (notify & BIT(NOTIFY4_REMOVE_ENTRY))
+		mask |= FL_IGN_DIR_DELETE;
+	if (notify & BIT(NOTIFY4_ADD_ENTRY))
+		mask |= FL_IGN_DIR_CREATE;
+	if (notify & BIT(NOTIFY4_RENAME_ENTRY))
+		mask |= FL_IGN_DIR_RENAME;
+
+	return mask;
+}
+
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32 notify)
 {
 	struct file_lease *fl;
 
 	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
-	fl->c.flc_flags = FL_DELEG;
+
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6161,7 +6177,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9468,12 +9484,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
 
-	status = kernel_setlease(nf->nf_file,
-				 fl->c.flc_type, &fl, NULL);
+	status = kernel_setlease(nf->nf_file, fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
 	if (status)

-- 
2.51.0


