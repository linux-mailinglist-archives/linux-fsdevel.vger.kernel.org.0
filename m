Return-Path: <linux-fsdevel+bounces-61553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF8B589D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B21522CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434971A9B58;
	Tue, 16 Sep 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umEocjbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AED528;
	Tue, 16 Sep 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983198; cv=none; b=OVovGmhQX/zzelVPGqtpE/V0T/dvTY68SjwOfFjswOUWsh+4LbkwP6VsLtmSqoHLHJzFMzMEFr2dWxBg6XIn9/syW4FnL38xuEek9DTFS1h4O/k969g2/k37KOw54B88khKUf+Pqk04pyh/8gP34A62XVlPKEnntw9+KaGYMl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983198; c=relaxed/simple;
	bh=vKUTRqM01fd2u9lxuDTjKpn2UpugTIoncZc+obzetZs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSvJjj5lgOhx8xfsQtTYylVF29vbhdo50HNtu3a4ql1gMN/tQjZrT2DzI7J2uEcaztiITtbx7jaccAN+ag5Oamtf++PGHq6IeRRLMDzZ7clQAmXtN7ucjSZOFHa2pg/uJL0RHp1oajuHQetgNNjhjZpd/UCi6JXJGriT79/O7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umEocjbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3833EC4CEF1;
	Tue, 16 Sep 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983198;
	bh=vKUTRqM01fd2u9lxuDTjKpn2UpugTIoncZc+obzetZs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=umEocjbNufWXDvw8aaupjoPpJPiB8z7RcTVcXmH+ZASPfJ/fWuc2B46tjm4VOxNTC
	 HMn71EeZPuspSfde6dRxQdvK5GlNwtU8k6HDhBRSKNbQuBUg/C7kRjX1jTiRvoldlZ
	 uEFB11JpGBJZyHzs2fQncleDuB5vj9lo2uZXh5SNIKGT9mWl9IQr//To+m7jno15u1
	 PaSX5/Fx/Vs+or2B8uXwwQR6lKl/WLqfvWwnIa71LpCrT1B4ILEwM7omPJdpapQ3Vu
	 5nMTHvEcw9gHr7cTJXJLeQez384TWycnFinPUkCl/ZBTab4NR+St0CXjU80kSw/aec
	 OjNXJoJM7rxdw==
Date: Mon, 15 Sep 2025 17:39:57 -0700
Subject: [PATCH 06/10] fuse_trace: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153054.384360.15179421236448893159.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
References: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h  |   37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c  |    4 ++++
 fs/fuse/iomap_cache.c |    2 ++
 3 files changed, 43 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 5f399b1604a2ac..1cfcc64de08817 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1073,6 +1073,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_fallocate,
 	TP_PROTO(const struct inode *inode, int mode, loff_t offset,
@@ -1210,6 +1211,42 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+TRACE_EVENT(fuse_iomap_open_truncate,
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
+
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	written;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
 DECLARE_EVENT_CLASS(fuse_iext_class,
 	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
 		 int state, unsigned long caller_ip),
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index b410cae0dec5dd..c7b0026bff75f3 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -2433,6 +2433,8 @@ void fuse_iomap_open_truncate(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_open_truncate(inode);
+
 	fuse_iomap_cache_invalidate(inode, 0);
 }
 
@@ -2441,5 +2443,7 @@ void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
 	fuse_iomap_cache_invalidate_range(inode, offset, written);
 }
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index f1be73da571440..a13eb5eec72415 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1422,6 +1422,8 @@ int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
 	if (!fuse_inode_caches_iomaps(inode))
 		return 0;
 
+	trace_fuse_iomap_cache_invalidate_range(inode, offset, length);
+
 	aligned_offset = round_down(offset, blocksize);
 	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
 		length += offset - aligned_offset;


