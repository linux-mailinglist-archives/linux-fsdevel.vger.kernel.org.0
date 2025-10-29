Return-Path: <linux-fsdevel+bounces-66049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FFC17B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4904035F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E42D6E55;
	Wed, 29 Oct 2025 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKpPrgho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833851EEA55;
	Wed, 29 Oct 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699435; cv=none; b=Dtf43Frip6iWHES9yS5wMaPfoWM/TX+BxbVo1GLyAnP+uYCZopeJYB+nuuJeBh81tSn3XL+2IfdOdYPs1WL8T4WeqQv6MZ8FHV/5imh3eganrAb8NPK+oXbkcIoy5+9GpQ2RobllZfseWDPUtsa3wrZG0JvOOTmiuC4GdpStD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699435; c=relaxed/simple;
	bh=xL0yR/OvyqoosPvfH7BClhkkyjK0W81ax20sY/CS470=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k43LJFQR7jcOYSjEa1tWCJJSZ3/ZdYHBqdj3DyMb3T+X5ORLh4X+iL7qCWk6nwktD0BiV992sR1ZCyDH8turmXse+qIiISWDnTKblD0qzCiOjLzBLOAQJMyISw/+mqxf/l0uMfpYNxQuMpU6JJwrwGS5U7OoEs65MA0wBGq/nEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKpPrgho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF39CC4CEE7;
	Wed, 29 Oct 2025 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699434;
	bh=xL0yR/OvyqoosPvfH7BClhkkyjK0W81ax20sY/CS470=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DKpPrghoFHCI9oKsS6tA1LIPPA4JDMcLBRqjEK8Wu1saJV9ASYHn5Swxg4ZH3dE/u
	 jgEVxdwbv60gqixIjKI8BbIJFyOjSne2CrjLtQpYhC7ioUJB4jcMkFqTNGGsWJQ5zt
	 tzQAIKG2qkzXf1sbQhIexfBIeqYsUdfUTGLfnMKU4W7MdSSHARxhj4ZN8bgG9kAzH4
	 Q+Q/T7eUZ1IiIGXoXh/cxHAWbsWYvQ7gqxIaS33V9JkDb/gncm55PLLAetblQEJmEf
	 HkRKfn7R+D05IGFC44nRnQaJNjaAAil6r99NxiBk4gwSao36qutzZk8J7RQ5vjPFqE
	 8Mda91PnZduKw==
Date: Tue, 28 Oct 2025 17:57:13 -0700
Subject: [PATCH 04/10] fuse_trace: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812163.1426649.18234833679814805780.stgit@frogsfrogsfrogs>
In-Reply-To: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
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
index f6c0ff37e7d570..8f06a43fd2d69a 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -401,6 +401,7 @@ struct fuse_iomap_lookup;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1474,6 +1475,39 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
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
index 42cb131e1ee36a..ed7e07795679a6 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1575,7 +1575,12 @@ static bool fuse_iomap_revalidate(struct inode *inode,
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


