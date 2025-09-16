Return-Path: <linux-fsdevel+bounces-61551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20690B589D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D07A6FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5DB1A9B58;
	Tue, 16 Sep 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u958aWOh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A87D528;
	Tue, 16 Sep 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983167; cv=none; b=Sl/3b+55X2DnA4UDiqf4vkskYi17EkuDvvMn5E0UBKIDqIlnlzLHBeTXKNGKO0FsRQXV7GPP1fH8dB6uIon1nnbX8V5Z2ktiZO664kTb1SAoM2lUski1AixSp15KwBa+XjoGHHsrqxZOg1BfYdonZEsc5CEUu/LqVgAv39qgEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983167; c=relaxed/simple;
	bh=IGBtSChaVixxyXhXbf+TwFNxdv8ZLFojbe/In6WT150=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQruFKrzNsjmtrLTmNxkIUhwbuj/hrqJ+X8VPqtESVdcKTj0NaSS9+ZzA6qIIKs4zsIjzG10SfQSGlelGvXyzfvx71y6mafRVyHXod9KrSFi3nxcc6Bwm4jHkjCH0k7u06URiL+LbwxLzFMoPQxN2EYLfISi+mFsdL4wBr+cLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u958aWOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F000EC4CEF1;
	Tue, 16 Sep 2025 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983167;
	bh=IGBtSChaVixxyXhXbf+TwFNxdv8ZLFojbe/In6WT150=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=u958aWOhGUPtHlZREB3xvrW5raPCFLUS8zQS5SPQeqR0RSMXWpQkCQj8zUHnYvssg
	 1i8ax/8ngtnMeOoBe/1DUHiGq/RqjVRIM43GUgXh1vxzm468qn4kDaEpMetMZ/+uHY
	 n2VR3N9xZEo8w89Aw4gHh+psEwlxaPbycQlIo2Bs0GlmoBZ6jzjAQi0crPzLaeKa4q
	 +4/69q4gh0R662TezIDfn/A3VsQ2KWFxYQmMm+IXBRYnVEQFIwzfNxwulSc6Zs4K/f
	 mpQtcEK1XIw8a2Ee9d7mxSyub2nFKrmo/0W5oK2d+v397qSdVzvekwbT3fXpZp+b4J
	 eZ21tMZxkAqww==
Date: Mon, 15 Sep 2025 17:39:26 -0700
Subject: [PATCH 04/10] fuse_trace: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153011.384360.8657977373603127911.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   34 ++++++++++++++++++++++++++++++++++
 fs/fuse/file_iomap.c |    7 ++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 6072ef187f9215..5f399b1604a2ac 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -400,6 +400,7 @@ struct fuse_iomap_lookup;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1471,6 +1472,39 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
 		  FUSE_IOMAP_MAP_PRINTK_ARGS(got),
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_invalid,
+	TP_PROTO(const struct inode *inode, const struct iomap *map,
+		 uint64_t validity_cookie),
+	TP_ARGS(inode, map, validity_cookie),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(uint64_t,		old_validity_cookie)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+
+		__entry->old_validity_cookie=	map->validity_cookie;
+		__entry->validity_cookie=	validity_cookie;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT() " old_cookie 0x%llx new_cookie 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->old_validity_cookie,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 47c82ec29238e3..b568a862f120ff 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1540,7 +1540,12 @@ static bool fuse_iomap_revalidate(struct inode *inode,
 		return true;
 
 	validity_cookie = fuse_iext_read_seq(&fi->cache);
-	return iomap->validity_cookie == validity_cookie;
+	if (unlikely(iomap->validity_cookie != validity_cookie)) {
+		trace_fuse_iomap_invalid(inode, iomap, validity_cookie);
+		return false;
+	}
+
+	return true;
 }
 
 static const struct iomap_write_ops fuse_iomap_write_ops = {


