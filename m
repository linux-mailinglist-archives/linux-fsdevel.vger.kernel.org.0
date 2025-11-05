Return-Path: <linux-fsdevel+bounces-67047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4D8C338C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0315F1895C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B923EAB9;
	Wed,  5 Nov 2025 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH8e3Wyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934C2248A4;
	Wed,  5 Nov 2025 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304081; cv=none; b=hNpoQjr1lAhHhFTNOma5M/J/s4dBCcu+Igtl0FcCnopjeXytVWaIr07Ookz2k538hgZ+40Ommv+osg/UQCZR4BnYMcnkM0hYsipdB+k9k/eyEBDB45Kt0EV5uEo1/4FaeHsr9+piBNYTm8fwouZ2nadslszRASaeWYPacW10u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304081; c=relaxed/simple;
	bh=aTLPr6y1+Gn1fd/FAm+rdKV15SUqdxgq5r2RMBTgDuU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC8vRDtY/BwhIwi/giafxjy7rFENnVJBBUadWmcLA2oW/cnm0idRVordYAfgk788IIchkxKwcXOkifLW8SXXNccsmyGTd1hgYP5p1caERIrtAJlq+51niW7YXc5YORjzZJRhCdImrX7Ao0169+x0SKkhZDCJeoOHwII45tI2T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH8e3Wyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E169CC4CEF7;
	Wed,  5 Nov 2025 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304080;
	bh=aTLPr6y1+Gn1fd/FAm+rdKV15SUqdxgq5r2RMBTgDuU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MH8e3Wyv7BJvFiukOE6jEXbJLDv8kSQl5IIsVUsh+jYOpOQpj26+YmIYwlony6y83
	 OKpfJ7uxfUP4Bt6ajhsz5KnjpmcznLlKdPn+N1/YX5DVJr212Rhm9d9HvpV4s7qOtH
	 aYIOXjAK8LswziBYwG9m3OwINuSnvKPFW03P6zpuHjPAqToJQVSHDPOheQMbccjjJa
	 aYxnleUSw2iPImUqWN7jNpUqo3GmrVSUpZO6aMNF3Id9HbI6dJZ9m+RWRMl1RfZupB
	 bncBMA+qObwkTjgv2O4f0JDeN/Du6Umn4yFu5ogfjBB776Gn/+TfU43k3yAm+hGGz0
	 4EiVdNroNbKeg==
Date: Tue, 04 Nov 2025 16:54:40 -0800
Subject: [PATCH 2/6] xfs: switch healthmon to use the iomap I/O error
 reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366476.1647991.12278483112599930010.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the new generic I/O error reporting paths so that we can remove the
xfs-specific hooks.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_trace.h     |   35 ++++++++++++++++++---------------
 fs/xfs/xfs_healthmon.c |   51 +++++++++++++++++++++++++-----------------------
 2 files changed, 46 insertions(+), 40 deletions(-)


diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 520526ef9cd11c..bb7335b56a53e4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6262,24 +6262,25 @@ TRACE_EVENT(xfs_healthmon_media_error_hook,
 		  __entry->lost_prev)
 );
 
-#define XFS_FILE_IOERROR_STRINGS \
-	{ XFS_FILE_IOERROR_BUFFERED_READ,	"readahead" }, \
-	{ XFS_FILE_IOERROR_BUFFERED_WRITE,	"writeback" }, \
-	{ XFS_FILE_IOERROR_DIRECT_READ,		"directio_read" }, \
-	{ XFS_FILE_IOERROR_DIRECT_WRITE,	"directio_write" }, \
-	{ XFS_FILE_IOERROR_DATA_LOST,		"datalost" }
+#define FS_ERROR_STRINGS \
+	{ FSERR_READAHEAD,	"readahead" }, \
+	{ FSERR_WRITEBACK,	"writeback" }, \
+	{ FSERR_DIO_READ,	"directio_read" }, \
+	{ FSERR_DIO_WRITE,	"directio_write" }, \
+	{ FSERR_DATA_LOST,	"datalost" }, \
+	{ FSERR_METADATA,	"metadata" }
 
-
-TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_READ);
-TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_BUFFERED_WRITE);
-TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_READ);
-TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DIRECT_WRITE);
-TRACE_DEFINE_ENUM(XFS_FILE_IOERROR_DATA_LOST);
+TRACE_DEFINE_ENUM(FSERR_READAHEAD);
+TRACE_DEFINE_ENUM(FSERR_WRITEBACK);
+TRACE_DEFINE_ENUM(FSERR_DIO_READ);
+TRACE_DEFINE_ENUM(FSERR_DIO_WRITE);
+TRACE_DEFINE_ENUM(FSERR_DATA_LOST);
+TRACE_DEFINE_ENUM(FSERR_METADATA);
 
 TRACE_EVENT(xfs_healthmon_file_ioerror_hook,
 	TP_PROTO(const struct xfs_mount *mp,
 		 unsigned long action,
-		 const struct xfs_file_ioerror_params *p,
+		 const struct fs_error *p,
 		 unsigned int events, unsigned long long lost_prev),
 	TP_ARGS(mp, action, p, events, lost_prev),
 	TP_STRUCT__entry(
@@ -6294,10 +6295,12 @@ TRACE_EVENT(xfs_healthmon_file_ioerror_hook,
 		__field(unsigned long long, lost_prev)
 	),
 	TP_fast_assign(
+		struct xfs_inode *ip = XFS_I(p->inode);
+
 		__entry->dev = mp ? mp->m_super->s_dev : 0;
 		__entry->action = action;
-		__entry->ino = p->ino;
-		__entry->gen = p->gen;
+		__entry->ino = ip->i_ino;
+		__entry->gen = p->inode->i_generation;
 		__entry->pos = p->pos;
 		__entry->len = p->len;
 		__entry->events = events;
@@ -6307,7 +6310,7 @@ TRACE_EVENT(xfs_healthmon_file_ioerror_hook,
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  __entry->gen,
-		  __print_symbolic(__entry->action, XFS_FILE_IOERROR_STRINGS),
+		  __print_symbolic(__entry->action, FS_ERROR_STRINGS),
 		  __entry->pos,
 		  __entry->len,
 		  __entry->events,
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index def4de5f6bc543..3796c7335bb58d 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -74,7 +74,7 @@ struct xfs_healthmon {
 	struct xfs_shutdown_hook	shook;
 	struct xfs_health_hook		hhook;
 	struct xfs_media_error_hook	mhook;
-	struct xfs_file_ioerror_hook	fhook;
+	struct fs_error_hook		fhook;
 
 	/* filesystem mount, or NULL if we've unmounted */
 	struct xfs_mount		*mp;
@@ -702,22 +702,23 @@ xfs_healthmon_file_ioerror_hook(
 {
 	struct xfs_healthmon		*hm;
 	struct xfs_healthmon_event	*event;
-	struct xfs_file_ioerror_params	*p = data;
+	struct fs_error			*p = data;
 	struct mem_cgroup		*old_memcg;
+	struct xfs_inode		*ip;
 	enum xfs_healthmon_type		type = 0;
 	int				error;
 
-	hm = container_of(nb, struct xfs_healthmon, fhook.ioerror_hook.nb);
+	hm = container_of(nb, struct xfs_healthmon, fhook.nb);
 
-	switch (action) {
-	case XFS_FILE_IOERROR_BUFFERED_READ:
-	case XFS_FILE_IOERROR_BUFFERED_WRITE:
-	case XFS_FILE_IOERROR_DIRECT_READ:
-	case XFS_FILE_IOERROR_DIRECT_WRITE:
-	case XFS_FILE_IOERROR_DATA_LOST:
+	switch (p->type) {
+	case FSERR_READAHEAD:
+	case FSERR_WRITEBACK:
+	case FSERR_DIO_READ:
+	case FSERR_DIO_WRITE:
+	case FSERR_DATA_LOST:
 		break;
-	default:
-		ASSERT(0);
+	case FSERR_METADATA:
+		/* already handled by xfs_health */
 		return NOTIFY_DONE;
 	}
 
@@ -731,30 +732,33 @@ xfs_healthmon_file_ioerror_hook(
 	if (error)
 		goto out_unlock;
 
-	switch (action) {
-	case XFS_FILE_IOERROR_BUFFERED_READ:
+	switch (p->type) {
+	case FSERR_READAHEAD:
 		type = XFS_HEALTHMON_BUFREAD;
 		break;
-	case XFS_FILE_IOERROR_BUFFERED_WRITE:
+	case FSERR_WRITEBACK:
 		type = XFS_HEALTHMON_BUFWRITE;
 		break;
-	case XFS_FILE_IOERROR_DIRECT_READ:
+	case FSERR_DIO_READ:
 		type = XFS_HEALTHMON_DIOREAD;
 		break;
-	case XFS_FILE_IOERROR_DIRECT_WRITE:
+	case FSERR_DIO_WRITE:
 		type = XFS_HEALTHMON_DIOWRITE;
 		break;
-	case XFS_FILE_IOERROR_DATA_LOST:
+	case FSERR_DATA_LOST:
 		type = XFS_HEALTHMON_DATALOST;
 		break;
+	default:
+		break;
 	}
 
 	event = xfs_healthmon_alloc(hm, type, XFS_HEALTHMON_FILERANGE);
 	if (!event)
 		goto out_unlock;
 
-	event->fino = p->ino;
-	event->fgen = p->gen;
+	ip = XFS_I(p->inode);
+	event->fino = ip->i_ino;
+	event->fgen = p->inode->i_generation;
 	event->fpos = p->pos;
 	event->flen = p->len;
 	error = xfs_healthmon_push(hm, event);
@@ -1174,7 +1178,7 @@ xfs_healthmon_detach_hooks(
 	 * through the health monitoring subsystem from xfs_fs_put_super, so
 	 * it is now time to detach the hooks.
 	 */
-	xfs_file_ioerror_hook_del(hm->mp, &hm->fhook);
+	sb_unhook_error(hm->mp->m_super, &hm->fhook);
 	xfs_media_error_hook_del(hm->mp, &hm->mhook);
 	xfs_shutdown_hook_del(hm->mp, &hm->shook);
 	xfs_health_hook_del(hm->mp, &hm->hhook);
@@ -1418,9 +1422,8 @@ xfs_ioc_health_monitor(
 	if (ret)
 		goto out_shutdownhook;
 
-	xfs_file_ioerror_hook_setup(&hm->fhook,
-			xfs_healthmon_file_ioerror_hook);
-	ret = xfs_file_ioerror_hook_add(mp, &hm->fhook);
+	sb_init_error_hook(&hm->fhook, xfs_healthmon_file_ioerror_hook);
+	ret = sb_hook_error(mp->m_super, &hm->fhook);
 	if (ret)
 		goto out_mediahook;
 
@@ -1449,7 +1452,7 @@ xfs_ioc_health_monitor(
 	return fd;
 
 out_ioerrhook:
-	xfs_file_ioerror_hook_del(mp, &hm->fhook);
+	sb_unhook_error(mp->m_super, &hm->fhook);
 out_mediahook:
 	xfs_media_error_hook_del(mp, &hm->mhook);
 out_shutdownhook:


