Return-Path: <linux-fsdevel+bounces-78057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MszEFvfnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613D17F0E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B750631A16D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD537E2FF;
	Mon, 23 Feb 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwyqrgqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DC37AA97;
	Mon, 23 Feb 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888277; cv=none; b=WN+BWbmaj1iPZmVf12EjOF5HdAZ6O5JFSYUjEcY0Dle5RfXgqLx5RTLsrx7KSjlJh2CiASUmZZWMTvcrv3m7HfHnJYxeJKfXnZoRRPXF8fnXrr3DLPvuTmmppOaE8FzTqEG4CiAbKzPM/2rPI9fi8Y3HJnbbFrAhZCjOfXpw0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888277; c=relaxed/simple;
	bh=u6SUf/MaHXwnw0CUQYL+TZ39+29DAH/03QugexVKhH8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWnqDYKgimqA0+o0Qrtt3w/RWLzKF15TQDyuTBS6SCSzrlFnqnmO8daNScTuKqqi7G6u8S7ecopEZZac3GbEz10vocr+xhjfU6URf8jck6g/WYzpRqQvYgwWkQ99E5iUeT9n74c/7BWoYTZr7d8i3x9d9vyl3mdWMVqIgV1Hx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwyqrgqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3072C116C6;
	Mon, 23 Feb 2026 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888276;
	bh=u6SUf/MaHXwnw0CUQYL+TZ39+29DAH/03QugexVKhH8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GwyqrgqgsRM4YPkgMAslPHJ1njGOS0KgrJYGuutEkbNr7ZJ/V4mQPfcCO3NSw3OCL
	 GdwTdQ4Tt3Dtsgsmd9LKqyV6wr3rkHpY7atQTo+RqUOZarRBjV6Xc1oTZidK5Tfeor
	 4IAjYghNCJxEGb4ubrZHu44TgqEaE2cGRVQ4dg2ziRjn1jOAj24DFuIeJMAVtlPd7D
	 FhACZyLX0xVmSvlmv9tf7tpYbWybfDHTXtNqyCJQ2rk9hVZb8dh3Uz/LZaqrmketZh
	 JE3p+k4IPJo75hks5LqDlcrOD3KcCmKO54haqzmTcSgPwWex1+0iihQyOselTg8rAw
	 4abGnwLxXqcBw==
Date: Mon, 23 Feb 2026 15:11:16 -0800
Subject: [PATCH 10/33] fuse_trace: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734459.3935739.7221887071616053387.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78057-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9613D17F0E0
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    8 +++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index af21654d797f45..fac981e2a30df0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,25 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -488,6 +507,31 @@ TRACE_EVENT(fuse_iomap_dev_add,
 		  __entry->fd,
 		  __entry->flags)
 );
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned long,		state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->state, "|", FUSE_IFLAG_STRINGS))
+);
+#define DEFINE_FUSE_INODE_STATE_EVENT(name)	\
+DEFINE_EVENT(fuse_inode_state_class, name,	\
+	TP_PROTO(const struct inode *inode),	\
+	TP_ARGS(inode))
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 39c9239c64435a..dccfc9a2c9847c 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -651,15 +651,21 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 		return;
 	}
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode)) {
+		trace_fuse_iomap_init_inode(inode);
 		return;
+	}
 
 	fuse_inode_set_iomap(inode);
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_evict_inode(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_evict_inode(inode);
+
 	fuse_inode_clear_iomap(inode);
 }


