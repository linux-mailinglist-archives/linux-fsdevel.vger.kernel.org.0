Return-Path: <linux-fsdevel+bounces-37945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C39F957D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1929E167E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6A218AD3;
	Fri, 20 Dec 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ZRPhRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDF207A1D;
	Fri, 20 Dec 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708798; cv=none; b=TdNnbmtxe8GRLgx3/3fgtZcgUY2oRFP37JevFDymwQ2q9Qj/TKHqIyUQL3JfYM3qBObc5cc2KzYlUBxiAKmFNJ5BU6mMRJg8R/OAUlOxtMOyNkn0YFIJK1sg5kIaZAAOpBR66qOb1s8A0aNtfBTMcUguQMPaEE4fJabDdBTg0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708798; c=relaxed/simple;
	bh=EECtu5EOQPP9WpkyAeyEzP3b+8wuy+Niq71T6d9EZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzFh4Uq+xOLtKc2o/wtb/CaOGNSZO+WGKXu69evDY9ClEczOOBtszwTMkwolaoeenYUjrKvHEhs5vDWCZy1aJB5vOvKHnW33nIXAp/TIDBj9E/Pmh003X0PAkQaxtCrzFfow+4N+x1f693zAoKBNaLdfRNWdEP7GjDOaqO/Svjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ZRPhRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35AC4CECD;
	Fri, 20 Dec 2024 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734708798;
	bh=EECtu5EOQPP9WpkyAeyEzP3b+8wuy+Niq71T6d9EZWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2ZRPhRiASStEU5s/qWXh04LDWsiGjNPKUEulej0MWKn/cJxk5FsBJ+q9c+2xnrp+
	 iEXCDgelMCJMK66KZI+qiZDL+LgrM1fWELgH9owlLAaDFlotlcNi2y41Gm5vEbW4YC
	 hycvZzYjXnPVLrDq3FfkrcVJ8uUhtyzAbOZqE+x52eZY1zPGP/nQV5nnxOc/g9kUnJ
	 bHItBtmY2eBLwNO63tPWFmfKSgX8z2nVUzjnFrwD7a5KopNGDN5K5pM46WX6nrIN9i
	 KRp7CxTH5sembrL3X3Dcy3mFD0DQ8clz5c9abI6gYfbv4gA9jj8pO+wHpMpJiQQMDM
	 G+SvL/EzaYILw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Yang Erkun <yangerkun@huawei.com>
Subject: [PATCH v6 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Fri, 20 Dec 2024 10:33:10 -0500
Message-ID: <20241220153314.5237-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220153314.5237-1-cel@kernel.org>
References: <20241220153314.5237-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Testing shows that the EBUSY error return from mtree_alloc_cyclic()
leaks into user space. The ERRORS section of "man creat(2)" says:

>	EBUSY	O_EXCL was specified in flags and pathname refers
>		to a block device that is in use by the system
>		(e.g., it is mounted).

ENOSPC is closer to what applications expect in this situation.

Note that the normal range of simple directory offset values is
2..2^63, so hitting this error is going to be rare to impossible.

Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
Cc: <stable@vger.kernel.org> # v6.9+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 748ac5923154..3da58a92f48f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -292,8 +292,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 
 	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
 				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
+	if (unlikely(ret < 0))
+		return ret == -EBUSY ? -ENOSPC : ret;
 
 	offset_set(dentry, offset);
 	return 0;
-- 
2.47.0


