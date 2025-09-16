Return-Path: <linux-fsdevel+bounces-61515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1492B5897B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF3B7ACE17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540241C3BE0;
	Tue, 16 Sep 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWgWgehp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D91AA7BF;
	Tue, 16 Sep 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982604; cv=none; b=HIinZ6owKkYZhqlI24QVoKY07ntB78KK/DaSaL7BD/Ixav7XcjcVO1yPs2OKZATZd7fGP4/1Wj1MivouSA+ip0nwRCgf8GtZrd6LGtAuTJzDrvNeCHZ0clNa6Be2sC7wdKpLrXty02P6LmFNigk8CD7bzfFrn0nL6+xzbQTwBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982604; c=relaxed/simple;
	bh=bjvNl1wEHzzbTV1mbIwlvWzWq+3YN/97QdLGWiUgpUk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGmWORrtDvkEfHqb50fYmK9L7mIt25ADWynKIdt8+KEclHz5+azlodMNBsdRCWhx3yvLh9fW3s/4D2hDeL7lnU9Bd21G5HF3HfCdlmcDPORiptdWY+2Gs0xilkBd6LPSV6juZU7B0wQZfjSkktA1/JqUZij4IF+4Ao4HV4/enHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWgWgehp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F9C4CEF1;
	Tue, 16 Sep 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982604;
	bh=bjvNl1wEHzzbTV1mbIwlvWzWq+3YN/97QdLGWiUgpUk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EWgWgehp0Ymkgi6YDoVKehIJkitIYATcb91/KP7DASxLm5oOad+oRk6mv/4RaVTLh
	 jChLAvyTWTSK1LaLZ3BbvbkMEg1dGBmTItziHcLuuL4HLTPlhcAWim4YyOTKl2qvi/
	 qjbzFeUCgotGse8uV33ltjWcYNE5jNkc80jXz1RhJLBs9rVvs7MDJj4KRvUjNevR0y
	 etFv19If59l04g+392vmK5H+/+4OD4umbVxMuFpxHJwsZC2Eu144p6RxzLlSH9Hnvu
	 GyBqFkZKvtbTAOFA/8nfG8hIjwyZ76Mo/tMq0ZExptxddsHxaMEyZHQR3mQxtsFDO2
	 y8T9KpWL2ATTw==
Date: Mon, 15 Sep 2025 17:30:03 -0700
Subject: [PATCH 08/28] fuse_trace: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151438.382724.1862852565361070721.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    4 ++++
 2 files changed, 46 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index d39029b30e0198..cdedaf2b2a0ad5 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,23 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -488,6 +505,31 @@ TRACE_EVENT(fuse_iomap_dev_add,
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
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 6ffa5710a92ad5..0759704847598b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -658,10 +658,14 @@ void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
 
 	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
 		fuse_inode_set_iomap(inode);
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_evict_inode(struct inode *inode)
 {
+	trace_fuse_iomap_evict_inode(inode);
+
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
 }


