Return-Path: <linux-fsdevel+bounces-38204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67139FDBCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2864D3A1443
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF74197556;
	Sat, 28 Dec 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uma4kQ2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EA194ACC;
	Sat, 28 Dec 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408529; cv=none; b=CqdVBIhM5SX0Fnw/dgO2DLnlIdu7V3ALS+HJ6SKRXV9Y+vMx63wB4gMOOy6CWcdSTiNXK1IObKmr0tv3SldOh/CA8S1aHV3cctBXx4iC9SK0k2vesOwC3OQ5jJMoik+IPa5F7Rei6sQre3EENiz8rfNPQYw2TeZub/WbAlgKvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408529; c=relaxed/simple;
	bh=EECtu5EOQPP9WpkyAeyEzP3b+8wuy+Niq71T6d9EZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH8/bKV/WGZELIKfOSElj16aHhC6Arsb7QALTFrynF8PhxolvCyQ22YNyYeFu1HH3CILHq3huwe+KI/5zFzE6Dhc4FldTySwpdzggDr4hz05vh1Zv8UWv1E+fIVR/GbMSLASQVnZzgXCDAI5DjxrQV5+x6j6owZZtiKPHk0mZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uma4kQ2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B35BC4CED3;
	Sat, 28 Dec 2024 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735408529;
	bh=EECtu5EOQPP9WpkyAeyEzP3b+8wuy+Niq71T6d9EZWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uma4kQ2kNj/TOCp8GofUQATKtCXg9pKPiiaPxerbHBR1J1MtjzVlVou7vExRGYGtA
	 65BSwylOREkYANw6gZKPDWebHMXN4k54oQ/kIWEaY/Tgi6t6zOjpKC/K5hq/JaKl8G
	 WJ3Fq5btLxjxUIm9QXgeg6JEOg3z1AHfae9l+B9RTK2SGB3zJQUQNpb0OZQsq/iQ3r
	 BjoMXzIKW60jDKbAY5trHgHFPHh6VVByIH3v5JCNoZrhwJDCuOnSTjBmT3hCC1c16T
	 AhH8e3ewz2IJ54b5YjFJ1RfSnphPqXvPxHQkWYWOq9A4kLiOB/+TecXx07wZl7E7Fb
	 FasZ5Fxn2KSyg==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Yang Erkun <yangerkun@huawei.com>
Subject: [PATCH v7 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Sat, 28 Dec 2024 12:55:17 -0500
Message-ID: <20241228175522.1854234-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241228175522.1854234-1-cel@kernel.org>
References: <20241228175522.1854234-1-cel@kernel.org>
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


