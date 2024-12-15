Return-Path: <linux-fsdevel+bounces-37441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E69F2574
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDD518829C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5081BA89C;
	Sun, 15 Dec 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dABbN62e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697251B87F6;
	Sun, 15 Dec 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289101; cv=none; b=r4mUZYsVhRqC4Jp2JK5xZP/7uq0Baso13/h5VaajKPgMfaS3OghK9RNOZqSsm1c/i7UvMT6f4eMPqvtH09teC79Z+8M3iKDaxMsZmQp7iPx0AjFhYOWqIBBL7mvEbohqnebaIQE154VYKD5xF5PWzquvprsOuCTRPaCL6t5e/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289101; c=relaxed/simple;
	bh=JO3wJ67L+bBQYON3juM3zuVAaoxUR6DOyzoX+5ATl2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djLLBdqSmUP400VddO4xC+fAsn6g7X5k6DYFrzGJk1xnouGSy3KHDBD6nP/i1pyGh7Q8jvZ2JH9qas+D2rPrREy+U4mci/l7CObShJcvKAUiOOyKX7wFP21tzhiKCSw+lMU0YzlHmgTK0bzFQn0CE/LAyUbm920pVQgkCo4DF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dABbN62e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DFFC4CEDE;
	Sun, 15 Dec 2024 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734289101;
	bh=JO3wJ67L+bBQYON3juM3zuVAaoxUR6DOyzoX+5ATl2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dABbN62e5zHRGjy3VKyLbWhYQ0+3u7z3KN/O3aLiFX/HRzHwAI/exDTn9N9DOEm3f
	 yaVrrvx5KhPcK038AiKFW3gHmMgMLEEVE56tFRDrNYrAGcbTeP3ZY+kNFXPncSPnOj
	 ntnD1GrCD+LebkyB8GGRpCcP/9ZnMjTqV85JjnVO9O2WVAAhK2b/U8lBb5sYwpEqbb
	 wUlJtremoJDGKJE9lZCC+UnPZlrlbxEAsd2pGrkXXYom27BJGYMDRheoWXMQqL6vEM
	 EOlNdo/K4AcdkhTCxGTC5tW6uhGWJ7VdAOjpMfgL6DqGG29C1+y/kDRtPsVfPrvqsK
	 YVBIWqSL4tyjw==
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
Subject: [PATCH v5 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Sun, 15 Dec 2024 13:58:12 -0500
Message-ID: <20241215185816.1826975-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241215185816.1826975-1-cel@kernel.org>
References: <20241215185816.1826975-1-cel@kernel.org>
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
 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 748ac5923154..f6d04c69f195 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -292,7 +292,9 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 
 	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
 				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
-	if (ret < 0)
+	if (unlikely(ret == -EBUSY))
+		return -ENOSPC;
+	if (unlikely(ret < 0))
 		return ret;
 
 	offset_set(dentry, offset);
-- 
2.47.0


