Return-Path: <linux-fsdevel+bounces-36014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C209DAABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043F1B2164B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B9B20010E;
	Wed, 27 Nov 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqMjro8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845291E51D;
	Wed, 27 Nov 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721300; cv=none; b=tyHWa8vd3YEyskSbDpyv/dSxFefrbPB/Kw3V8tB8/KlNSupn24TeFUVt7/9WPViP0UIdHe7HuMqhnX8iJwNSIEGO1mNe+W4zY07m8U4I/0lAR4WwBU6w2iGFFNmTtsWKtwDH3LEPqb26/1BqT+NB/yfG7jJlA8ZK81c2Y7dXmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721300; c=relaxed/simple;
	bh=NPVXYksZkbK7cP6WTdZWPp256P2B4FMiN2imk2oaSkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlZ/HsNM9HVVncJTIGKN6U5FaduFYRP8DlbV7mzsfxprd8urER1qWMTFCt7DUUdcEwMo3Y4ZP6465HjqcepkyBg+guucqg1LjLB5RbHe9MhsSPF0vvlYGGiQy110MpAQcWxIM1iQlFH8iUMZxso6YVWbl2Ed394yZb+YBTSB43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqMjro8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A4EC4CED4;
	Wed, 27 Nov 2024 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721300;
	bh=NPVXYksZkbK7cP6WTdZWPp256P2B4FMiN2imk2oaSkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqMjro8ojkY1tLpJcZlcUCbWHypMHq37p4mKe4wKeV9ANga4aylCBQE5UXv9iYKgk
	 H1l1QixsymlDu3V1hiAXlqQ+p7QdbeKFcSDKwZLfBJkqKPEtAZbS/0zJ1A5o+Ud9qh
	 u7JN52eMlk8g6rwlpELRbm82tdppU3TV3hpeD9TlLb3IYDi8RMJ7YE8OmDX2u0aEvf
	 Niovao4OIXLG6o/hSiAPHrpsys5AJQjzRXjcxcosIpPWYpk2lyS7FAz/VE13TvCiwz
	 vIVmGM4GwB0ZQ/IklvvUcFWv2pqPyGzdYlEZ9xUf4Ze0PrIz9bToqLxo+7KqJpD+I4
	 EWbJYlUQFuyzQ==
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
Subject: [RFC PATCH v3 1/5] libfs: Return ENOSPC when the directory offset range is exhausted
Date: Wed, 27 Nov 2024 10:28:11 -0500
Message-ID: <20241127152815.151781-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127152815.151781-1-cel@kernel.org>
References: <20241127152815.151781-1-cel@kernel.org>
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


