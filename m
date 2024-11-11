Return-Path: <linux-fsdevel+bounces-34169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8F9C3599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89441F223BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0A374D1;
	Mon, 11 Nov 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUp9e8+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC021364;
	Mon, 11 Nov 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286386; cv=none; b=pcn3+hSkApTbpK1ssHeumuv42UOdOYOrz0wnQu1cucTRYvFjUIZUTlmxOOnQdZfSg9GPqQV1WqYt2I6L2FQsLaieLIYMAG7nHue/Aj20d6we+9BGYEagLdC+qfB6P0JkheZeQoW77WxYORJNogUvTUJTHd2S1t7Pe/NglBedl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286386; c=relaxed/simple;
	bh=MS0L+/cj/qetOL2B467nUPcahNS75vbYcTKvMHCfQKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv5SLcm2FTTR98oWZl7DXZ6cJHpostUvgDkCOwjJWSsvOfUm3rw0WBLZt+Hl+AMP8mRw2k5AC484ZhPvzDX7xC7IXbSGohO/RDfSrWHrNZRl3lXyI0dPYdWA2x7AuNtg5MCSx3MqUSFYogKY2TdwWQiytW+zSEOC2kviUhbOT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUp9e8+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F118C4CED7;
	Mon, 11 Nov 2024 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286386;
	bh=MS0L+/cj/qetOL2B467nUPcahNS75vbYcTKvMHCfQKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUp9e8+0TpoPzUlfgwTw5E6GgnI/ZpYgc1q76uXOC/+G/BieWoMPdjZEB9lyIDrgW
	 QXnLpnLmlQr9H3pU3uuH6bLkqEMMVOzHhdcMtSSAL9OpMLf+1hUWeWgQj8DDTUrsi4
	 HPlMJt1byI0ysarlcYcYt43gIZmtHoAEgpzJNUNIjlag6m8EPrbqQPCcjGC4n4l4w2
	 acEdEsqQ12dH+mxNQZwEssa6U3KD3BDs3TcnGaplZbXr6RuqnTPuBDN0JgoZRBikUj
	 McYBLgOQhdkImalQc+aABZ2RlO+V6EjfcIX2x8OD/WW8qej8jqF0AvLODayl32j4Dz
	 IQXG8dMnfIgqA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: yukuai1@huaweicloud.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	<linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 1/6 6.6] libfs: Define a minimum directory offset
Date: Sun, 10 Nov 2024 19:52:37 -0500
Message-ID: <20241111005242.34654-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111005242.34654-1-cel@kernel.org>
References: <20241111005242.34654-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 7beea725a8ca412c6190090ce7c3a13b169592a1 ]

This value is used in several places, so make it a symbolic
constant.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820142741.6328.12428356024575347885.stgit@91.116.238.104.host.secureserver.net
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: ecba88a3b32d ("libfs: Add simple_offset_empty()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index dc0f7519045f..4a2205afcc88 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,6 +239,11 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+enum {
+	DIR_OFFSET_MIN	= 2,
+};
+
 static void offset_set(struct dentry *dentry, u32 offset)
 {
 	dentry->d_fsdata = (void *)((uintptr_t)(offset));
@@ -260,9 +265,7 @@ void simple_offset_init(struct offset_ctx *octx)
 {
 	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
 	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
-
-	/* 0 is '.', 1 is '..', so always start with offset 2 */
-	octx->next_offset = 2;
+	octx->next_offset = DIR_OFFSET_MIN;
 }
 
 /**
@@ -275,7 +278,7 @@ void simple_offset_init(struct offset_ctx *octx)
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
 	u32 offset;
 	int ret;
 
@@ -480,7 +483,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == 2)
+	if (ctx->pos == DIR_OFFSET_MIN)
 		file->private_data = NULL;
 	else if (file->private_data == ERR_PTR(-ENOENT))
 		return 0;
-- 
2.47.0


