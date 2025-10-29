Return-Path: <linux-fsdevel+bounces-66022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA0C17A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114CC1C825BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE312D593E;
	Wed, 29 Oct 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlP8sNLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744D2C3768;
	Wed, 29 Oct 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699011; cv=none; b=ssiwkrwQXT0i3/foa8XZwmXAvdBjM7gkvUjYtDuXqiDv4zuipn3JqdzugF337DKlOhQ+bstFNm8jD1JOr+9NjMjJD+v8/IejwVelVpCpF94GiOZ5bn1Y40DBUqDYK0hi/UOi3jXST1LYllSKM2kIyTW1jD9Rm0DeVza3JX/oKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699011; c=relaxed/simple;
	bh=zrBPDr1AdZyTgydVM18dm0Y6fHh9mbveZNiJa0XdWKE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZNZtl1fuccHzDRn+2ZEDWPxiIsTL0PDpXQtD63JLWHTnc8ljJ6y72sfB5M21RyDh19dohiWUEAQJ0lamNIQtYOP06bPdJy9qd30KIsjCQtPkLOgYHwV2nPiPEYa+VINvINOE4jdWNvhGoW00UsvqBBFReV82+rPkzSA/DictP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlP8sNLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D36C4CEE7;
	Wed, 29 Oct 2025 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699010;
	bh=zrBPDr1AdZyTgydVM18dm0Y6fHh9mbveZNiJa0XdWKE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RlP8sNLLwnTnAH3zjYLBD1rNDlE2U0iOyyzmp7jrQFlhH4mT6jPdM6A97EoU+7Uzx
	 xVn2U3SoJE1Bx/yujOn+2f+uVqbvpF3mteCHEkU6m/UpNxcAmef2aJEPLEbkTHb2BD
	 VpF+QI2E3en4U4EfaqCdbiqMkZwxi3BQa67KGbm1aEP3YRjGtwATnA5FRdADan8cxK
	 S7UzAD7aZ5FL+2WuCvuHX41jK1DORYxi4QRsWgFmJYyAYIIzya+m4j2OMC3xMDZBK0
	 2sDcv0MVHri/QmiifH8Jd0XCklb9eaa/iVVvDLmT+3YvuIr9CFg3QoDgjOrJBB/jTt
	 +gpTpVgP/C7BA==
Date: Tue, 28 Oct 2025 17:50:10 -0700
Subject: [PATCH 20/31] fuse_trace: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810787.1424854.17957051286430684887.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    3 +++
 2 files changed, 51 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index a9ccb6a7491fc1..6f973149ca72f0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -58,6 +58,7 @@
 	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
 	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
 	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EM( FUSE_IOMAP_CONFIG,		"FUSE_IOMAP_CONFIG")	\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
 	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
@@ -342,6 +343,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
 	{ IOMAP_IOEND_DIRECT,			"direct" }
 
+#define FUSE_IOMAP_CONFIG_STRINGS \
+	{ FUSE_IOMAP_CONFIG_SID,		"sid" }, \
+	{ FUSE_IOMAP_CONFIG_UUID,		"uuid" }, \
+	{ FUSE_IOMAP_CONFIG_BLOCKSIZE,		"blocksize" }, \
+	{ FUSE_IOMAP_CONFIG_MAX_LINKS,		"max_links" }, \
+	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
+	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -970,6 +979,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
 		  __entry->mode,
 		  __entry->newsize)
 );
+
+TRACE_EVENT(fuse_iomap_config,
+	TP_PROTO(const struct fuse_mount *fm,
+		 const struct fuse_iomap_config_out *outarg),
+	TP_ARGS(fm, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+
+		__field(uint32_t,		flags)
+		__field(uint32_t,		blocksize)
+		__field(uint32_t,		max_links)
+		__field(uint32_t,		time_gran)
+
+		__field(int64_t,		time_min)
+		__field(int64_t,		time_max)
+		__field(int64_t,		maxbytes)
+		__field(uint8_t,		uuid_len)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fm->fc->dev;
+		__entry->flags		=	outarg->flags;
+		__entry->blocksize	=	outarg->s_blocksize;
+		__entry->max_links	=	outarg->s_max_links;
+		__entry->time_gran	=	outarg->s_time_gran;
+		__entry->time_min	=	outarg->s_time_min;
+		__entry->time_max	=	outarg->s_time_max;
+		__entry->maxbytes	=	outarg->s_maxbytes;
+		__entry->uuid_len	=	outarg->s_uuid_len;
+	),
+
+	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection,
+		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
+		  __entry->blocksize, __entry->max_links, __entry->time_gran,
+		  __entry->time_min, __entry->time_max, __entry->maxbytes,
+		  __entry->uuid_len)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ebc01a73aac6de..ff61f7880b3332 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -737,6 +737,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 		return error;
 	}
 
+	trace_fuse_iomap_config(fm, outarg);
+
 	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
 		return -EINVAL;
 
@@ -762,6 +764,7 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 			sb->s_blocksize = outarg->s_blocksize;
 			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
 		}
+		fm->fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)


