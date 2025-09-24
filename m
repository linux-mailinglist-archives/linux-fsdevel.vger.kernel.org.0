Return-Path: <linux-fsdevel+bounces-62646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361AB9B59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0583A9BFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C632C324;
	Wed, 24 Sep 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD27wo4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6C32BF5B;
	Wed, 24 Sep 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737272; cv=none; b=lE0DsNR4JaPM5/caqcJdh901YBNrbjNUVmn/YEhRhFwA9UsWYNbgj/S/Z0p/dpf3yNleAQBEra94EX6RJrd75n8ktq7rDQUgxmew3Ob5EtXkHpkCtC/1ldmacmA/Jm5b7fRshddiuz8Ub4uzhAbFysDvx9BpC/OwbdtyRCQmi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737272; c=relaxed/simple;
	bh=GFt/XQXg2dRZWwqUa59cIFQemMF2hIJF8NPQx8IYZWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsW/cnatcn620S68xvU7UGU9h/w9AM5AkE6HFVNTqaRJXFxfFeFMJ4APsoTYBR5CrkVgixO4fdTCGobb/bkBqXebXICoanfr0o1yWGlgMZ8puSoY+I1VgdPktXT+mcaJkeoj2Syd80mIzo277Vz/T4Ch7Boc4gyM+KpfWTfViy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD27wo4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76EAC4CEE7;
	Wed, 24 Sep 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737272;
	bh=GFt/XQXg2dRZWwqUa59cIFQemMF2hIJF8NPQx8IYZWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MD27wo4py3W5JChD7JGB8qiRHh4x/mVXCy3wH8xk6VEZjZ/IDSI3a8X05j7R57Ane
	 qPyzLUa0PuT7AGKsBxF4XE41fp/qygw7ZM1OkZrFlO8sLjR1H5dAk9f1hVmytmB9Vt
	 I/hR/QXWWXB69Qm24jpi3MjaTVXODvWIawsRQg++T6qYF9bIlxVXtp4m1ulTEb/c2X
	 hzCAZuuPCHYYC1VRh5UlU1x2sewHYcQlfJDcQ/A446XmJ9ctvEMD/iJ0kzQ1RGGjtx
	 g2njlQzQnEdS0u8acPxOu3QIbOur+kHWt5j12fZlm8pHENjfAK5D1BTeq09tu7ULww
	 2K1Mwijj0AJzQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:14 -0400
Subject: [PATCH v3 28/38] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-28-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GFt/XQXg2dRZWwqUa59cIFQemMF2hIJF8NPQx8IYZWM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMQREfN8nuevFO3OObbGgLagh2K7PJ6GskFe
 /Gcrrf338OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEAAKCRAADmhBGVaC
 FQOBEADGS8aO/CcIL+9lxtnRfAYYup52yK72zEtZ3ppq24ymwhzfti0UV1tBZmzGrH8ypUm3h8M
 Hniqo/Lvq7PGmRHzCc0YYXhzBFFE18I+lOM/Z7JKKnB1mFQyWyEj/+gLWXUFGloUpm6JwtWPf0i
 rSDTn8gGHNsGIqSIAwfnz50fJWvVei87SRQ0sJeaDd347Skl2dWtgzfWRwEWekUAmBj2g2dob2u
 cLdzyBd64EeCJg/NuGorlotC7VMQ1BhWNY70ymvXKdzqrcbg2Xv5lEuNq2lQpz1Gu7oHqBsEcHL
 CdSFggmhQAYvo7wXmZW2nuwNIkdhKc+DpRI6Gf6lq9GlkrzNRUvkjRFWosguA+HjhUV7cK70Zgb
 WXmUR1+ztarUkcyyb5I62PSzdF+en9bglbvXeFhXgdljqtnTPuOnDmSarzljw+KoovKOpx/+2HI
 a/XQmA1jZ7RNwvnO+i9CyFQKVDZpc4zXSzhmKW6vkkyfpbyE4N6PSsQ5NVUQAkU/sox650GnQQV
 hs+DF4myr/rJfvZyKp4iDYtCGA3c0kpOvM9KFjspLhUy+iMxGgQy9sCisyB4u+5C37QmitqaqYu
 JBe0TWgcg5hoJvxzlXEk8W6ffqlqI2VoD/RBzHJqxab7rg2fdo/VyABHnzLZiXHsSSVeCIYgMbG
 m/CriOkV3bnEBsw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some extra visibility around the fsnotify handlers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f3d3e3faf7d5f1b2ee39abb7eabd2fa406bbac21..2147b5f80ca0e650e9dbdb63de7c9af6f4bc7bff 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9796,6 +9796,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 	struct file_lock_core *flc;
 	struct nfsd_notify_event *evt;
 
+	trace_nfsd_file_fsnotify_handle_dir_event(mask, dir, name);
+
 	ctx = locks_inode_context(dir);
 	if (!ctx || list_empty(&ctx->flc_lease))
 		return 0;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 01380425347b946bbf5a70a2ba10190ae4ec6303..d8b6d87f1ec09ca80fe4218fd79aaa803a316619 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1311,6 +1311,26 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+TRACE_EVENT(nfsd_file_fsnotify_handle_dir_event,
+	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
+	TP_ARGS(mask, dir, name),
+	TP_STRUCT__entry(
+		__field(u32, mask)
+		__field(dev_t, s_dev)
+		__field(ino_t, i_ino)
+		__string_len(name, name->name, name->len)
+	),
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->s_dev = dir->i_sb->s_dev;
+		__entry->i_ino = dir->i_ino;
+		__assign_str(name);
+	),
+	TP_printk("inode=0x%x:0x%x:0x%lx mask=0x%x name=%s",
+			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+			__entry->i_ino, __entry->mask, __get_str(name))
+);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf

-- 
2.51.0


