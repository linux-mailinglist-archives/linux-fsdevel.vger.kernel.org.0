Return-Path: <linux-fsdevel+bounces-35042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601199D0652
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA076B220F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B53D551;
	Sun, 17 Nov 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwLmSCsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FD1DDA2D;
	Sun, 17 Nov 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879144; cv=none; b=NvhcYjulBbQjZ1yqYAEA3xOE8/urNGbGiH6e0YBqIBa9gb56eKpf06KkiMXCODfmwUDY9bj6CVq7Qet/abP6tz0JYCIiGISU9V7nOEjlP8qNU8KQ6vEzzZbK+w4uqUQY2dZHGmUqxpMP2N/CFVSfq/1CZv2DnujgsnS6rKIoCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879144; c=relaxed/simple;
	bh=uhgh93plhiFV1pHFjFAu6nt5SYYT8N+YCq9mpcqsLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItpIu73t2OlXpHpOpVIKnsP38XQ4kYVnx0nr9hL2EOSGLf7j+UkYdUKL3OmlTKeTXLt1SiUph8CKyQbWzKgjAhYR2NMWRlPXpaSd103u2A5xKEX4XbfUAL2LiOvF/gB1aq1W5zjinogB0yAQc0wMZUi6b3DMje6xzm5qoezlTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwLmSCsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14632C4CED8;
	Sun, 17 Nov 2024 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731879143;
	bh=uhgh93plhiFV1pHFjFAu6nt5SYYT8N+YCq9mpcqsLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwLmSCshoiCMBHQ8SdisMNZY5nlg2cAQVDgmOSPyURaXMQ4aCumx3TQV0KV/+aF0d
	 nY4VP9HmKvlqTs/RX9o2Z1gCH0tU7BiqNXsFXj5+AnT546vfGt5QpnRiK29A8edJoB
	 GwoKdrdVbhYnlwkXxdzVH3PDZ3CIOFJxcLxZhjtoqOVrmnCBWJqV47cbz23wZ8Fhjt
	 4+Y/fD9zKUvNuY4hTnlGY+ssNQ5Bp0O0X00VooV2Hr7/PAuer8xTbU1F32iEz5F4+x
	 q6Y+uvCsWTU5LKrqqnCg9dgroyUS3FYb8wZG0msfJ4XmRLA9qWnZHFzGFhRfR9kgtV
	 NK7InFdZjg3lg==
From: cel@kernel.org
To: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Hugh Dickens <hughd@google.com>
Cc: yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/2] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Sun, 17 Nov 2024 16:32:05 -0500
Message-ID: <20241117213206.1636438-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117213206.1636438-1-cel@kernel.org>
References: <20241117213206.1636438-1-cel@kernel.org>
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


