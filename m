Return-Path: <linux-fsdevel+bounces-40069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C25A1BCC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8522016DBFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234D2253F1;
	Fri, 24 Jan 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUQULhBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6A2248B2;
	Fri, 24 Jan 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746400; cv=none; b=Ew0cDwiAuUzriOXiVPtfb0np7DZHc7IyUJI853xf8FNhtW8BrMTMRxVMLQrkFMQ//JFOKOn5UfnC/fV3bY/R3zewb392nf4xdHybwtC5JRefPcsLAxwk+VnzkXU7yapk8jFSyJAPPwVqywEAAEIONAXM3b06zHKhchRgIFIK+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746400; c=relaxed/simple;
	bh=+MlNwIFBadfJD8EMoOx2TqTDKMIrB7l68m+npdFSw20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nprlxv6ZeFBKEP1dFyQLVDMad4TlhFIUZ33rYKfzBmzlkIuScj+SGC9WB65KCbTquy0hw3/3RKstuF93/OOtYDJVvQyTw/ssPFeEJyFq2PhrIFxU4tviAakXcV/rdCChZxWn0fYKMNT6f+OB7sKwOjYoAvZGjcBtjmAMPBOmDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUQULhBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423B6C4CEE0;
	Fri, 24 Jan 2025 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746399;
	bh=+MlNwIFBadfJD8EMoOx2TqTDKMIrB7l68m+npdFSw20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUQULhBPqFOT/WhqvnY3sV0lAtBbbNP/wiyOPU3EEo9WSLCOAzMoLbGTftvUmLQ2Z
	 olyO1ZMSyx1YOFhYOC2eOXp8d4oFAVYf78UT4oPTKwI/6olDxREnW2Xb2BNyMngNS1
	 8O13HK60trrGWcOzqhAv8yz5htOozX5ENWUczZaN1d8xzR55sFG0CBUFzI5gV+Vl6S
	 0rY/vX/heKu7yIJcmj9kWXV30qy7N1/tNV5cz4bRRp0MxxNWVxETCnW/R55Ob7TJsS
	 2Fij7yqZtieFohKbzUMBN6EpvjRpg75WykhEzrNDMUYir8bWF++XqIZIiacoikLoEO
	 8e8Xq3gMXpJoA==
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
	Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH v6.6 07/10] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Fri, 24 Jan 2025 14:19:42 -0500
Message-ID: <20250124191946.22308-8-cel@kernel.org>
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

[ Upstream commit 903dc9c43a155e0893280c7472d4a9a3a83d75a6 ]

Testing shows that the EBUSY error return from mtree_alloc_cyclic()
leaks into user space. The ERRORS section of "man creat(2)" says:

>	EBUSY	O_EXCL was specified in flags and pathname refers
>		to a block device that is in use by the system
>		(e.g., it is mounted).

ENOSPC is closer to what applications expect in this situation.

Note that the normal range of simple directory offset values is
2..2^63, so hitting this error is going to be rare to impossible.

Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
Cc: stable@vger.kernel.org # v6.9+
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20241228175522.1854234-2-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ab9fc182fd22..200bcfc2ac34 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -287,8 +287,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 
 	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
 			      &octx->next_offset, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
+	if (unlikely(ret < 0))
+		return ret == -EBUSY ? -ENOSPC : ret;
 
 	offset_set(dentry, offset);
 	return 0;
-- 
2.47.0


