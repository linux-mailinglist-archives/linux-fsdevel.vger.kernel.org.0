Return-Path: <linux-fsdevel+bounces-78108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IitNPnhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9E17F561
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C36B03015EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DD37F759;
	Mon, 23 Feb 2026 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhLR3rKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1632749CF;
	Mon, 23 Feb 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889075; cv=none; b=ZFv4nMbr0MzA06G7zpIE85ytqZitrbkJgn8Y5TiJgbvc3Kk4MEL+OWzn4ktHvd0ZlCw+JRL20xqSrADf+w/5Rg8XBeweup71gspr3u5WklfBcTeRQG6SFlw6bFM3fWyLCYYX2BoyuSk9xmVPPraMJuRR0zLP6iudu82IhbNSu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889075; c=relaxed/simple;
	bh=n4Ahuk7YQJLP9FvpczXy314WpUSU9qwZiozHl0F2OL4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFOD76zzNc7VxB2G85YvEJuOGe4ldgsI8WxWXsqW2d9sIDAAI0NbPmZp1FL7B6WD68wZ0Lr6MHjuXB0n6SXdOv0dPKiG5h5VqrZ6WroMJEu/yRCSb1dhyhL6W32LB6J6HVwQxCwNKfZzhDrN5kZJoZSCEpynoFE3xLGh7bxhEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhLR3rKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51235C116C6;
	Mon, 23 Feb 2026 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889075;
	bh=n4Ahuk7YQJLP9FvpczXy314WpUSU9qwZiozHl0F2OL4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DhLR3rKt57+g8VJZPiE89+xV/Z3TjSUX7yvzXdeTWi9v6RsNMr4Iem5a/a9aVd4bL
	 hlQOgR92WWOWNSHuK1vKgqQKpuRD18v2aX+O1N+NYaKhSeYTfwHq52aofp2xy+vIsf
	 COdPtpvg8JLLqvF3IhHc8GpNjpir+J2WktMpgjZA4nVEvBhZ2zWT6TyHTh/URYN9W8
	 GNdco4WxWOuiym4utHapbol4d5bXaF31GR+BGUgY3DFdRWk0KO7YmTlgJyZyFREolG
	 E+hGcqph9Mp3sgo5q2Xbt9lp9kLQqo7CAvO9yHpIEE8Gk05kfyNN091fzTLpsJINFk
	 J7ZUqUDLNQ2tg==
Date: Mon, 23 Feb 2026 15:24:34 -0800
Subject: [PATCH 2/5] fuse_trace: enable fuse servers to upload BPF programs to
 handle iomap requests
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, john@groves.net,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188736838.3938194.1897307269192490384.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
References: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,groves.net,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78108-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06F9E17F561
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints to the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h     |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap_bpf.c |   10 +++++++++
 fs/fuse/trace.c          |    1 +
 3 files changed, 64 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index aa2d5ca88c9d40..956881dada5252 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1657,6 +1657,59 @@ TRACE_EVENT(fuse_iomap_inval_mappings,
 		  FUSE_FILE_RANGE_PRINTK_ARGS(read),
 		  FUSE_FILE_RANGE_PRINTK_ARGS(write))
 );
+
+#ifdef CONFIG_BPF_SYSCALL
+DECLARE_EVENT_CLASS(fuse_iomap_bpf_ops_class,
+	TP_PROTO(const struct fuse_conn *fc, struct fuse_iomap_bpf_ops *ops),
+
+	TP_ARGS(fc, ops),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__string(name,			ops->name)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__assign_str(name);
+	),
+
+	TP_printk("connection %u iomap_ops %s",
+		  __entry->connection,
+		  __get_str(name))
+);
+#define DEFINE_FUSE_IOMAP_BPF_OPS_EVENT(name) \
+DEFINE_EVENT(fuse_iomap_bpf_ops_class, name, \
+	TP_PROTO(const struct fuse_conn *fc, struct fuse_iomap_bpf_ops *ops), \
+	TP_ARGS(fc, ops))
+DEFINE_FUSE_IOMAP_BPF_OPS_EVENT(fuse_iomap_attach_bpf);
+DEFINE_FUSE_IOMAP_BPF_OPS_EVENT(fuse_iomap_detach_bpf);
+
+DECLARE_EVENT_CLASS(fuse_iomap_bpf_class,
+	TP_PROTO(const struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+	),
+
+	TP_printk(FUSE_INODE_FMT,
+		  FUSE_INODE_PRINTK_ARGS)
+);
+#define DEFINE_FUSE_IOMAP_BPF_EVENT(name) \
+DEFINE_EVENT(fuse_iomap_bpf_class, name, \
+	TP_PROTO(const struct inode *inode), \
+	TP_ARGS(inode))
+DEFINE_FUSE_IOMAP_BPF_EVENT(fuse_iomap_begin_bpf);
+DEFINE_FUSE_IOMAP_BPF_EVENT(fuse_iomap_end_bpf);
+DEFINE_FUSE_IOMAP_BPF_EVENT(fuse_iomap_ioend_bpf);
+
+#endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap_bpf.c b/fs/fuse/fuse_iomap_bpf.c
index b104f3961721b2..d4b826e4440ca7 100644
--- a/fs/fuse/fuse_iomap_bpf.c
+++ b/fs/fuse/fuse_iomap_bpf.c
@@ -115,6 +115,8 @@ static int fuse_iomap_bpf_reg(void *kdata, struct bpf_link *link)
 		return -EBUSY;
 	}
 
+	trace_fuse_iomap_attach_bpf(fc, ops);
+
 	/*
 	 * The initial ops user count bias is transferred to fc so that we only
 	 * initiate wakeup events when someone tries to unregister the BPF.
@@ -155,6 +157,8 @@ DEFINE_CLASS(iomap_bpf_ops, struct fuse_iomap_bpf_ops *,
 static void __fuse_iomap_detach_bpf(struct fuse_conn *fc,
 				    struct fuse_iomap_bpf_ops *ops)
 {
+	trace_fuse_iomap_detach_bpf(fc, ops);
+
 	ops->fc = NULL;
 	rcu_assign_pointer(fc->iomap_conn.bpf_ops, NULL);
 	fuse_iomap_put_bpf_ops(ops);
@@ -269,6 +273,8 @@ int fuse_iomap_begin_bpf(struct inode *inode,
 	if (!bpf_ops || !bpf_ops->iomap_begin)
 		return -ENOSYS;
 
+	trace_fuse_iomap_begin_bpf(inode);
+
 	ret = bpf_ops->iomap_begin(fi, inarg->pos, inarg->count,
 				   inarg->opflags, outarg);
 	return bpf_to_errno(ret);
@@ -285,6 +291,8 @@ int fuse_iomap_end_bpf(struct inode *inode,
 	if (!bpf_ops || !bpf_ops->iomap_end)
 		return -ENOSYS;
 
+	trace_fuse_iomap_end_bpf(inode);
+
 	ret = bpf_ops->iomap_end(fi, inarg->pos, inarg->count,
 				 inarg->written, inarg->opflags);
 	return bpf_to_errno(ret);
@@ -302,6 +310,8 @@ int fuse_iomap_ioend_bpf(struct inode *inode,
 	if (!bpf_ops || !bpf_ops->iomap_ioend)
 		return -ENOSYS;
 
+	trace_fuse_iomap_ioend_bpf(inode);
+
 	ret = bpf_ops->iomap_ioend(fi, inarg->pos, inarg->written,
 				   inarg->flags, inarg->error, inarg->dev,
 				   inarg->new_addr, outarg);
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 69310d6f773ffa..7d65ccdc2be609 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -9,6 +9,7 @@
 #include "fuse_iomap.h"
 #include "fuse_iomap_i.h"
 #include "fuse_iomap_cache.h"
+#include "fuse_iomap_bpf.h"
 
 #include <linux/pagemap.h>
 #include <linux/iomap.h>


