Return-Path: <linux-fsdevel+bounces-40064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9881A1BCBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3674C16DC06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B9224B03;
	Fri, 24 Jan 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcLi3zNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F51CA64;
	Fri, 24 Jan 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746393; cv=none; b=A0EikhfvuKKLkFqxj452TmMZNz+KuKhXdGhLLYS7PAac2n4dVbAuFgaQPyobFkaxb7Wl2B8VuTrs7aJAb8s3fgGKFr4YuZr12X6NH+IV1kUDgeJOeqE9jMzl3T5tyEauGJM63OzMsT81nxggFZ/7Bmo9J6Y05ICaud9EPju0JiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746393; c=relaxed/simple;
	bh=aTa/oPIRhiZqsiUQhL063GDzxrb6flC1H3iG2TVuGAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDUfD5+hJpUzNqkYjAIiZxRSTrU0omRohVxZj532QzvrRCOYTvx6Wmee0G+bKtt7S8X7FrQWkbfNAL7ErHxGJQ7QitzkkS4jN0EPwtgs5CXshN197xaHVMG0Ulwl4gP38OrMNpQv5B/uLBt3miawit7pbUOTZqobVuRz6oL3fEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcLi3zNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E7C4CEE1;
	Fri, 24 Jan 2025 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746392;
	bh=aTa/oPIRhiZqsiUQhL063GDzxrb6flC1H3iG2TVuGAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcLi3zNwUmn6+D7krNKMAsLu2+/e4oFjxsu0wxzCUBNfUbOBKRndiLIbvyh6gRVcK
	 yvusJypoKUf3J07VZh/SGZ+ayRV9WfralmbkSzFaoaksAUv1YRtX70/pM43krhTpDs
	 3LYGPKs4zAtTllP4ZJs8pYaJNDQP8XUQkefM/Gs9hoBZhAwdzz/HfOTl+HY71Wli4x
	 wsUg86mAIbqmASezLl0yPIkg+kzWr1fDNMm11d9FizatAu9iaQOefDGJj7l5qCO4+2
	 60xlPNVkfUYE2gUfVk5DkErDmcoOHDwLKFacFwmKPwyOcHcU1cz+UGzOG3sgYKKPT5
	 OiduZIrMtg68Q==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v6.6 02/10] libfs: Define a minimum directory offset
Date: Fri, 24 Jan 2025 14:19:37 -0500
Message-ID: <20250124191946.22308-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
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
index 430f7c95336c..c3dc58e776f9 100644
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


