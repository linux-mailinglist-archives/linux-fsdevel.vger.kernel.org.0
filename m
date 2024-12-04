Return-Path: <linux-fsdevel+bounces-36482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC39E3EB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C95283207
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196320CCD7;
	Wed,  4 Dec 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwglIqew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741520B817;
	Wed,  4 Dec 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327584; cv=none; b=ndFtqQDEXy4EaY/j3rWFGxSOdrKCvQJ0+ce+4+kMt1E+aTH0o5dyajPt0OM6vEm0Y+06RzXn3TjxY+Bl/tVIpDxYIlx41U9FVK5yp1daYTbWSKDMV/cfNt5G4sX+YRWnf1k2vt+9lJiYKuHM0LrFoD84e33BFRbBjJQyCVF7WBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327584; c=relaxed/simple;
	bh=NPVXYksZkbK7cP6WTdZWPp256P2B4FMiN2imk2oaSkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpt4uUDYYCeedVPcdAtdVVu8SGC+twvD5Pm2l+TdoRA0RMBXe7DP/eUcVwpMhVRXvUbyrDumJPrcTy94hyKk4Q1zgClUafs2kuccPuJZvLh+/XISLN66kqZp+4q93citJUJMTCbr84dkMeLNVrDnthDrog19sQzY7FnoGKHyUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwglIqew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27D4C4CED2;
	Wed,  4 Dec 2024 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327583;
	bh=NPVXYksZkbK7cP6WTdZWPp256P2B4FMiN2imk2oaSkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwglIqew+kC64HhmNeKRZMoydHTLxQALFth57WAXtBp6byNwVy91qJItQVVVwojSA
	 OkH5/L9gFNYk/6f41QdqZVsf1I2GmIUsX/4V31OwNPFvaJMr9SwVKkROAY+FZFJze/
	 sL6tPNFlm19SV83JQXjaj+kPOEpM9/DycJQGqlRjtPJoey30zf9xUANBSL4qJbGTsm
	 ql3tCoKZMlCrvZi0a1d2Z0oYByif2FG4pmAFUVUn+0J2Sjxv7GbWrkmPErKaHMypJC
	 RFm8Yrwrio2mbZMJVEfnv8HExzhNKe4ZzOhXk3nxN7ocFTlW6sNuRZQYmSubZyHZ+h
	 xfYcWMt80NU3A==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
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
Subject: [PATCH v4 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Wed,  4 Dec 2024 10:52:52 -0500
Message-ID: <20241204155257.1110338-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
References: <20241204155257.1110338-1-cel@kernel.org>
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
index 46966fd8bcf9..bf67954b525b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -288,7 +288,9 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 
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


