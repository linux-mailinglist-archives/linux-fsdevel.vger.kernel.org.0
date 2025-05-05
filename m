Return-Path: <linux-fsdevel+bounces-48138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD4AA9EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E17AE1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D127A470;
	Mon,  5 May 2025 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSuDkLJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984327A44C;
	Mon,  5 May 2025 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483277; cv=none; b=qZskLgAFyPnU4+CLP8XY1ZzAxI5NR8ecSKLsexw1G/aAVpfF5Npi9Jjdxf+2VwkLDu/8qoewGrZpW8XQTc4zR/vqg/9MpTZ/OLgcSqnhSb/0vEZ1C4+A58G+uogs7AvaQ7Ff7wHUfHmRjCFi5u1m6F2NUMk68v3OQR9dN7OsLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483277; c=relaxed/simple;
	bh=AI0Dkhe56+tEE37NFaKLCgWb9dGrOfL/v0iZ+vvAFL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrHOXnfc8S2BwC9H+Nh5y/6/Jjyv0twvn+0pZOeIKGoZf7eqmfPcFxiDRdlfE53M/8+9KjnNPUvBNrPokmCZX7tSMKQ1LmzBwSqpbxp/+1A4voQ3XDgQQtECYfVWQduvV1Bp/OA+i6OE0Ue0anfWziT3xmCtybfNDsK/D5c6E2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSuDkLJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2EFC4CEED;
	Mon,  5 May 2025 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483276;
	bh=AI0Dkhe56+tEE37NFaKLCgWb9dGrOfL/v0iZ+vvAFL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSuDkLJyy7SkNxwA1Is/f5MnWeivwZf5V4d53GK1hBSxxhYkXvVM0I/UnLdxoZqTc
	 GyNK8NROgUBQj6aYPR+ws4lZS64mOG5TLWQYmyRREuky46thWcB7n3d44mwxOXFOWN
	 +RC8RQsTWGFMDNT9HpqLhrf73Ch6otQjvzYcyD/qpLGQ7BuMbQH9CGMfN4rhLpQh4d
	 s8JD3cAMQZd9vHEpVbYfY3S0vZKv/ixq6D8K18l+qvGf1UV8/2wWElGYC4zGnpfDHg
	 vHxdo5KDiVMYnPEplmPE02+fc9SGg2Aei0S3sZ9GixMQcVGkO0o5UwvC48Zg10gIQE
	 N6GOxther2OjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 009/642] fuse: Return EPERM rather than ENOSYS from link()
Date: Mon,  5 May 2025 18:03:45 -0400
Message-Id: <20250505221419.2672473-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Matt Johnston <matt@codeconstruct.com.au>

[ Upstream commit 8344213571b2ac8caf013cfd3b37bc3467c3a893 ]

link() is documented to return EPERM when a filesystem doesn't support
the operation, return that instead.

Link: https://github.com/libfuse/libfuse/issues/925
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3b031d24d3691..8f699c67561fa 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1137,6 +1137,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 
-- 
2.39.5


