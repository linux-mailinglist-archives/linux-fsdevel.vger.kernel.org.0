Return-Path: <linux-fsdevel+bounces-61527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75CB58998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404D616BBD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28E1A0711;
	Tue, 16 Sep 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw8TY4FW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF342A99;
	Tue, 16 Sep 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982793; cv=none; b=tBiliAdG2f6ngW+zwrko9S7jhz3xtQPuaZLAtBd4yTIX1UZyaU8km9+bPPbSSBBLU+bNR/QK/GTITVslmAyliN4BUClvztzIO2xrpkVuEH6nR/Eex2mwbU+HsWZWMEK5coB/YMcJdbUkXVqfkHltzzts9BGAvjSCv7Jsa3XYCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982793; c=relaxed/simple;
	bh=3EGlgCLSe5KyKGeMtCZGaz4ImjORPSYVCD0ko4AsZwA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZL0n6il/sfTaU5/zqOj+grNAMZPdUZC9cexPXGVh4W5RqVivOk3NS9fMLRFljgdagYopy0tpk1fJjlictKKgj7Hqd5Ze1q1ebMKFl7+/kS2xoIWk//PG90kGq9t7d8zcOdeZJUNeXFcVAs6k+umGGdEV7sVut4uXk4MwAJnddYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw8TY4FW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DCAC4CEF1;
	Tue, 16 Sep 2025 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982791;
	bh=3EGlgCLSe5KyKGeMtCZGaz4ImjORPSYVCD0ko4AsZwA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kw8TY4FW5Mc1kf91eg0lLyw50EQEv/pjkBDwAy5K2XuxWvhx75PChF9QFImtix672
	 JVC9CIm2IiV6aZfCrpoRtgOQz8o9hue+9mtcHgoSP01ks/Pb+ZlUo7+Zz4QGSAWl1E
	 UIrDlprNueOTp/imprAdc+Xf2fHb9Jw0weugG22DbtWXLkhIoSD44Fx2dg2gLhQIHQ
	 5OGWtULEZJ5Z5OlK6C41AL10U3mdDpUZuXfraF7tdKoG9dTU+0hcukgJGuS2Ly+e9L
	 IwDqZ1fatIM5aebqQNAqZWcQPVV6UQEPCr7A3Sw3q6B8GDcDW5UOddMzqyOj+euHbi
	 RvxCN3oQNsinQ==
Date: Mon, 15 Sep 2025 17:33:11 -0700
Subject: [PATCH 20/28] fuse_trace: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151695.382724.4759449707943039373.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    3 +++
 2 files changed, 51 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index e69ad48b14066b..66b564bcd25360 100644
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
@@ -340,6 +341,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
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
 
@@ -968,6 +977,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
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
index abba22107718d9..2d01828fc532b0 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -735,6 +735,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 		return error;
 	}
 
+	trace_fuse_iomap_config(fm, outarg);
+
 	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
 		return -EINVAL;
 
@@ -760,6 +762,7 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 			sb->s_blocksize = outarg->s_blocksize;
 			sb->s_blocksize_bits = blksize_bits(outarg->s_blocksize);
 		}
+		fm->fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	if (outarg->flags & FUSE_IOMAP_CONFIG_SID)


