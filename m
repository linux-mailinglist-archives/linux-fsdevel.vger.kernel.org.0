Return-Path: <linux-fsdevel+bounces-24562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958994075E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313791F20DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8319E7EC;
	Tue, 30 Jul 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH17HRdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCD19DFA6;
	Tue, 30 Jul 2024 05:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316515; cv=none; b=miOs1jbk4nqUncl8lKMEaror32j+XjbVtGpNQmWdBhA48RMCS2ghAbX+it9lqFdtQCvBDbY3Ka/8FQyKAiDuTHov/mUdrwPKEelsH0DVXvTnkdpwRqY4MLdLZOnUPElzEH6CiO8bRiTTFpBavDBb91kK7GNicF+CnaAIWBll45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316515; c=relaxed/simple;
	bh=5Bzf73UnNx2DxWKpAfCxVR75hckX8NR8HOxkTYPr+A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkF1cS1abqbrKY7FGp99/9g/dAiUszdM6ed+jEc7PCngKa2DmqtlpFFysm8g0QNEOY34azPyfVEEpw8mpnDUi7lGtYdIO1rOepjyE1Ckwq9wP9l+TvF3kEsWkCbroinhPUdJIWhRruvmejz2e2ZUxDDC0HvrPyEw8+1FOwbfCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH17HRdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABD2C4AF0E;
	Tue, 30 Jul 2024 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316515;
	bh=5Bzf73UnNx2DxWKpAfCxVR75hckX8NR8HOxkTYPr+A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH17HRdZPgC3Z/Mx+QlCQBUqlLXlPFIXRcVOYwVqjtaaVPmxhnnX5Z6BjJ/MdDGfI
	 gUNsJokmc/YSsmGE7uXb0tdmNlxKK3oOVFPw3oihA/hGzzl/T0LCFdJlUAbIc+JLL5
	 qMohLRoJ2Met2iykQ0yWxnfenAFj84SDICTp+iL0JID5REO91A9m/ivEeCk1PzP4z0
	 m0ZscW0jJ+aGUAzsgs2qlRDg6f2/gTzehUG5Gm67e884mnEQ8ocfbZtInlhnqfgFrU
	 q9AFr4NhTI0dWM8p3hWb23i2OR3WRmnM8fHHuXj8gEewLt4ZvJk4uJ+EfwQCsJ//As
	 VLDntBk/m2gbw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 30/39] convert coda_parse_fd()
Date: Tue, 30 Jul 2024 01:16:16 -0400
Message-Id: <20240730051625.14349-30-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

fdput() is followed by invalf(), which is transposable with it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/inode.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 7d56b6d1e4c3..293cf5e6dfeb 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -122,22 +122,17 @@ static const struct fs_parameter_spec coda_param_specs[] = {
 static int coda_parse_fd(struct fs_context *fc, int fd)
 {
 	struct coda_fs_context *ctx = fc->fs_private;
-	struct fd f;
+	CLASS(fd, f)(fd);
 	struct inode *inode;
 	int idx;
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 	inode = file_inode(fd_file(f));
-	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
-		fdput(f);
+	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR)
 		return invalf(fc, "code: Not coda psdev");
-	}
 
 	idx = iminor(inode);
-	fdput(f);
-
 	if (idx < 0 || idx >= MAX_CODADEVS)
 		return invalf(fc, "coda: Bad minor number");
 	ctx->idx = idx;
-- 
2.39.2


