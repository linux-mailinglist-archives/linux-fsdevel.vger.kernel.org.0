Return-Path: <linux-fsdevel+bounces-35921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FA9D9ACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE6165D7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B51DA309;
	Tue, 26 Nov 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIAh4dxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8E1D0DEC;
	Tue, 26 Nov 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636494; cv=none; b=SipUpyGtzosK1QBLCvm9xfFXcU4jIE/ND/OTvniwb/vrlDVXmXQXShCc0W4fBtgLUbCBR7C9kXrasMImFbZDtZ/V9jWakYevZDdnDgGQFpy10ZemVHBov9BQGlmn8RQyVXT+ch8SJP4QYzm4BG598Kq0lkgmf5c3jzcAPGCDVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636494; c=relaxed/simple;
	bh=uhgh93plhiFV1pHFjFAu6nt5SYYT8N+YCq9mpcqsLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuACKR/E1Hjm/mHhx/bX1tYf9Iv/VEMv3WZs0B2VFL4+zSv8BCOveH2TLiyKQ1DDoCrX/J701whnKLGiCdZ0zA/SjEyrWwLBDVqEdgeVb+wgrOU39P+LfFnPFzrxkasqMdm3fz6fKTBu/gf7HvtgAbGwsDQEGoBDuD/2jt3J8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIAh4dxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345EFC4CED0;
	Tue, 26 Nov 2024 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732636494;
	bh=uhgh93plhiFV1pHFjFAu6nt5SYYT8N+YCq9mpcqsLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIAh4dxF+U4xexzovtB/7kPFGF35L5IKVEm3YrWxmpi09Xhg+s3Q6xBHA+BEOKxM6
	 01c8Ahzm2uaKRidP1kBlNetkAHbGcVjfgSZQcMQsSVcnkzT0DMkz1+VBNapdeMsbVW
	 ggHJdbDQPhH5XARuL9TLITKoR450QibdFfJ4W/Xn+OhcLvlvPGY8eNqgc66lmwXcem
	 RlTQItF+ZF8mUqqa7lJxN0dnHSjampVwpgtBVUukrEZkV10plMr9XHU9RyWafi/DGu
	 Mmqs1R8Ie5cshvo6L+ztqqUnOPCJWlkOhaXYEp1Aaci3D1uCUKchh4g1N9J1OOlxuO
	 KmFZcPfEyEVEg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH v2 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Tue, 26 Nov 2024 10:54:40 -0500
Message-ID: <20241126155444.2556-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126155444.2556-1-cel@kernel.org>
References: <20241126155444.2556-1-cel@kernel.org>
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


