Return-Path: <linux-fsdevel+bounces-50357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B4ACB148
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6A11942AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A65223DC1;
	Mon,  2 Jun 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRL8vvk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3F23F271;
	Mon,  2 Jun 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873000; cv=none; b=hm4LbCoHFdtbxEFxGYadZZRK+9BblLTeEUfOAZm1Wdy25XxrO/sGg08XlyTnwAxHXOpGvFnw9fN3qWLS+WXGYQaboC0gR2fDX3A3gIKS/51ZIzP8haQwY28Lw8O+/dJCnNcrVAzARaw04e/m0KuVQjUgVvzXyrW/rw41nGdnAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873000; c=relaxed/simple;
	bh=9e+P0L/QsD4juhtFT+7NMVrWkPdeOAQ/vSzBn2kNXLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFC8HFwn6874wtUQ7ZVJGhcA9Zl0BeQwDy/TAahaia0W3LaAei5vmwW78LWH6VnfrkUIvkmNFd2S8J2KcFzSG5ke7lDQ/WOZB6d1y4AgMGH3aLG/PKg6wBAplVIx8ykHi+h3hnOXk5RBa+dWo0xykM8CT8k4EhaU5lKqpYM7lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRL8vvk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6946CC4CEF0;
	Mon,  2 Jun 2025 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872997;
	bh=9e+P0L/QsD4juhtFT+7NMVrWkPdeOAQ/vSzBn2kNXLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LRL8vvk2DQjer13Ucxib56Lne1A87J4uDDdrOMGl/0mZoqlGrxQL8JRi0AhloJKrU
	 lrim3qTrlgdyPxvErVvl2k43i2TkC6BID+FEappT9SJyU7NFChl79yxJKb0xZfGpm1
	 IyFmSMCjSMTMDb/SP5HXPNu8/bPbD0fSOKRZ6lh0xc2SwOaOCphi+VJFQf49m9z2IK
	 TgsNTIPGk7Fe+tg6xSogGI8n+sgI93OV5Ti1F+mqm08nVLgjwjnzhQZyJ+vaeR9/Ej
	 EQuzVGEep1XZ0TpdBvJWuFEvEv2tDm81SVXC3adJxfdXuWkAXTNv0ucETRhhFwRG+1
	 YMTwQ5bwcdMYA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:09 -0400
Subject: [PATCH RFC v2 26/28] nfsd: add a tracepoint for
 nfsd_file_fsnotify_handle_dir_event()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-26-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9e+P0L/QsD4juhtFT+7NMVrWkPdeOAQ/vSzBn2kNXLM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7qGCN/tyFSnu4EEdOIYj4brEKvdCzRvMcHJ
 /gm023Cew+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6gAKCRAADmhBGVaC
 FUt3D/4gPw1XPr/4jvmQgwN2G714b3xAZZh9r/Ysn8hIVq66LlW1U5l5tKa9lpUiIMscuC54Tn0
 ctxBK9a15TQaJANvZ/fo6swDSRwj37PYN/2SByvWWWnD8Mj8zqIxW3gBnIQxOyt1P+Yvh7UpvAS
 n5T2ARMVtzOJ+9PiAw1cPaeXsvUTDpfARqUt2iYcwxc2XCpO9c1/tWneLqLvHH01fJGhP8ObMGB
 IN5MPejhq5qhrQc9L87/B2tO10mRC0AXozfcgXJkAI0Iljcpcwa9cxokSuSqgBkNleoW+fLr9P+
 vanhIqH/0QRxp4ZRnA46V4uMyQbIiGaCYxDWr6DzefTvme2Cs60KEkCWUfZwzifyc/wDe9FGJ9k
 RFnvVhB2WICiu3/7EAC0S2Uo1SpM0idc+zAG91lw9kRAdGoyYw5yVwpw04MjxrcR0QdmCgOmlNH
 UUtXgu9yfoEtx//3bphe6ntaIlVl8ofmnsIl2w/5HJzYP8YdxWiXS3kM2/b7dOSoexq0bUJ09/O
 dn73a+i1X2w6b7HxwsCBCL7v7kIVjp/2qEZgBSiH6lcbE5y3A89b3epF1/IewkbK+vz1Okvt1wI
 xIDej8HsUsDDKuHIymkWQnQ7+XLhdF87M1uucjyaqiSaSMrpdpGriqb1f+/AICNYlFxFv4RYbSc
 fuQsIoH0DJF2N0A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Repurpose the existing nfsd_file_fsnotify_handle_event tracepoint() as a
class and call it from the dir notificaiton codepath. Add info about the
dir to it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c |  2 +-
 fs/nfsd/nfs4state.c |  3 +++
 fs/nfsd/trace.h     | 25 ++++++++++++++++++-------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6cd4cfa0b46bf33c4134987a12e42c8455fc4879..ba72470b870cd0e266ba7fac8174a1a249a840e8 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -743,7 +743,7 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 	if (WARN_ON_ONCE(!inode))
 		return 0;
 
-	trace_nfsd_file_fsnotify_handle_event(inode, mask);
+	trace_nfsd_file_fsnotify_handle_event(inode, dir, mask);
 
 	/* Should be no marks on non-regular files */
 	if (!S_ISREG(inode->i_mode)) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a75179ffa6006868bae3931263830d7b7e1a8882..a610a90d119a771771cdb60ce3ee4ab3604cb8a3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9640,9 +9640,12 @@ int
 nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 		      int data_type, const struct qstr *name)
 {
+	struct inode *inode = fsnotify_data_inode(data, data_type);
 	struct file_lock_context *ctx;
 	struct file_lock_core *flc;
 
+	trace_nfsd_file_fsnotify_handle_dir_event(inode, dir, mask);
+
 	ctx = locks_inode_context(dir);
 	if (!ctx || list_empty(&ctx->flc_lease))
 		return 0;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0c68df50eae248c7c9afe0437dfcf29837e09275..968e13a721942c051448f21af2f13849511b7c6a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1293,25 +1293,36 @@ TRACE_EVENT(nfsd_file_is_cached,
 	)
 );
 
-TRACE_EVENT(nfsd_file_fsnotify_handle_event,
-	TP_PROTO(struct inode *inode, u32 mask),
-	TP_ARGS(inode, mask),
+DECLARE_EVENT_CLASS(nfsd_file_fsnotify_handle_event_class,
+	TP_PROTO(const struct inode *inode, const struct inode *dir, u32 mask),
+	TP_ARGS(inode, dir, mask),
 	TP_STRUCT__entry(
-		__field(struct inode *, inode)
+		__field(ino_t, ino)
+		__field(ino_t, dir)
 		__field(unsigned int, nlink)
 		__field(umode_t, mode)
 		__field(u32, mask)
 	),
 	TP_fast_assign(
-		__entry->inode = inode;
+		__entry->ino = inode->i_ino;
+		__entry->dir = dir ? dir->i_ino : 0;
 		__entry->nlink = inode->i_nlink;
 		__entry->mode = inode->i_mode;
 		__entry->mask = mask;
 	),
-	TP_printk("inode=%p nlink=%u mode=0%ho mask=0x%x", __entry->inode,
-			__entry->nlink, __entry->mode, __entry->mask)
+	TP_printk("dir=%lu inode=%lu nlink=%u mode=0%ho mask=0x%x",
+		  __entry->dir, __entry->ino, __entry->nlink,
+		  __entry->mode, __entry->mask)
 );
 
+#define DEFINE_NFSD_FSNOTIFY_HANDLE_EVENT(name)					\
+DEFINE_EVENT(nfsd_file_fsnotify_handle_event_class, name,			\
+	TP_PROTO(const struct inode *inode, const struct inode *dir, u32 mask),	\
+	TP_ARGS(inode, dir, mask))
+
+DEFINE_NFSD_FSNOTIFY_HANDLE_EVENT(nfsd_file_fsnotify_handle_event);
+DEFINE_NFSD_FSNOTIFY_HANDLE_EVENT(nfsd_file_fsnotify_handle_dir_event);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf

-- 
2.49.0


