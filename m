Return-Path: <linux-fsdevel+bounces-11920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB5D8592A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184F61C22107
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799F7F7C3;
	Sat, 17 Feb 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+UucdZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F357E776;
	Sat, 17 Feb 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201429; cv=none; b=N2hfDNVF5RhwyRG2EtaSQfWRnXJyzcY/Y5kq/rasw9MZ0xqZ23wRS3jkXzJ0lc3fHRAPUJkaIAcbeF1RRmJRDnQfeRz5UPQ9C6TD2ivjnrun4hW1Wz6PMMx+Tf4QT7DN6N/CaTdBRiFFnTLPHMr7jk9R0fLvD0+9K0IUXsNbwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201429; c=relaxed/simple;
	bh=zZF7EKK8ftmerUGGzBqiAHI4dgUgyTG9wsRPzQOCpuw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZMjk8QNYGFJwRTufvO4v5a/X/o0OL+g3E8VbO7FOZG+71bV/tXp18pAis1r8zC6OQEGC4LK/YVBtWAxCtrHU+ZKBso54NyisTUi6AL0yGxSVfQiVI4QwSgsAyrR+tQgDpqtq9ZNAXwE7GXGyJDIn9rtI5smdq0DuZNftzFGg/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+UucdZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67695C433F1;
	Sat, 17 Feb 2024 20:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201429;
	bh=zZF7EKK8ftmerUGGzBqiAHI4dgUgyTG9wsRPzQOCpuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u+UucdZptl0WKrqPf/GzRK/R6NMFecqwM1YYAZqGuTX8Ybt6NeHmaEbfcq4uMU3U9
	 Ecw2UXrIEBHT8fRD9InGawCnpOxNmcCwZ3ahX2kS2mH4tgddN77dJbqWyCVNT0bMA0
	 uCsmWi90+2ZSjAPCwOFrlaJNnxcvMf1DHC0MSm/5B9QZw7+aAvDn42p2lZ+yy+GcIn
	 qhcNCJFzcAb5Jnw3TT63+A5NFCXaOpx52dL57L05xf7l8y9xkTdOKKrbztYnBt3Vns
	 pWl/My0Gwa3PLUcjSsCc6gbFPHphzxIOwKUeNRyGz/+J92oHuycuFbRbeF/gWsHo+A
	 Yq/c76UNcJfgQ==
Subject: [PATCH v2 2/6] libfs: Define a minimum directory offset
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:23:47 -0500
Message-ID: 
 <170820142741.6328.12428356024575347885.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

This value is used in several places, so make it a symbolic
constant.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 752e24c669d9..f0045db739df 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -240,6 +240,11 @@ const struct inode_operations simple_dir_inode_operations = {
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
@@ -261,9 +266,7 @@ void simple_offset_init(struct offset_ctx *octx)
 {
 	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
 	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
-
-	/* 0 is '.', 1 is '..', so always start with offset 2 */
-	octx->next_offset = 2;
+	octx->next_offset = DIR_OFFSET_MIN;
 }
 
 /**
@@ -276,7 +279,7 @@ void simple_offset_init(struct offset_ctx *octx)
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
 	u32 offset;
 	int ret;
 
@@ -481,7 +484,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == 2)
+	if (ctx->pos == DIR_OFFSET_MIN)
 		file->private_data = NULL;
 	else if (file->private_data == ERR_PTR(-ENOENT))
 		return 0;



