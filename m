Return-Path: <linux-fsdevel+bounces-24537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF749406DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD23D282DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EC418FDDD;
	Tue, 30 Jul 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbbiZVGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C418FDA3;
	Tue, 30 Jul 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316491; cv=none; b=nrD+d3TRzHRgZ4/VjJPuD+9ocSHCd+ET76RvF+H6imem85iIsjLTSapW/QY1QfUDT0odW3x7owfObqAIydpO4I3YqP8hagpC/NH6+DPX9r12ejUqX7eI6HmvpwXpP6VqIkHt9eEZ80k1QB9LJ8Ot+rCgMfrd+x2zraVRbfeMgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316491; c=relaxed/simple;
	bh=gyYPJlwcTiMKgx2IWUbZvrIVeCUMhxednWG0WZER4H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJDzoJ0uoXGu4h4qAtxfcGwnP9MHnEBXIDFx2sKyJGdbJAaTaSgsq3xFn5Nl4cKJG7KbJeLeqXllkYQ27N+qSFw/x7yuouAwnRTSGKUnHXV6aij0g/R80ZRRVlgQmwuTDBfo1/R7Q92uLFOygvME9Nt0lQsVM5k83VpgLuMHTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbbiZVGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90189C4AF15;
	Tue, 30 Jul 2024 05:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316491;
	bh=gyYPJlwcTiMKgx2IWUbZvrIVeCUMhxednWG0WZER4H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbbiZVGZygql1SHE6JcfGUGL6P2FKQtgj/ca97/Oy9N6UBKK8agYmmutHEv4mSIZd
	 TJ0RREMr1jgdkX0jsSowe5pE1S5urFYcuqp5WjBzS4pCsmTAzI0YN58Hw8xwxmfEAR
	 XF/PCd8xxmJZaJGKN/4LGGuH/alp+y3fcl10CIBk9SDQFmSKg5eFpbQbpnnBQaDKL+
	 j5Xoa04wmRWLK/VQlaAg2Ua34TdUu8dvCHgZCDjCJlYdWcJXf4wp/SxbxCgvlGQzVf
	 EGhpm0mT6R4OXP2htPosD2MhABdpFwWyakabJgZwTVSnTHhFXxiQEEvz8PNK12bYYt
	 TCYxGyMunYqig==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 05/39] regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()
Date: Tue, 30 Jul 2024 01:15:51 -0400
Message-Id: <20240730051625.14349-5-viro@kernel.org>
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

Currently all emptiness checks are done as fd_file(...) in boolean
context (usually something like if (!fd_file(f))...); those will be
taken care of later.

However, there's a couple of places where we do those checks as
'store fd_file(...) into a variable, then check if this variable is
NULL' and those are harder to spot.

Get rid of those now.

use fd_empty() instead of extracting file and then checking it for NULL.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/remap_range.c     | 5 ++---
 kernel/module/main.c | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 4403d5c68fcb..017d0d1ea6c9 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -537,9 +537,8 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
 		struct fd dst_fd = fdget(info->dest_fd);
-		struct file *dst_file = fd_file(dst_fd);
 
-		if (!dst_file) {
+		if (fd_empty(dst_fd)) {
 			info->status = -EBADF;
 			goto next_loop;
 		}
@@ -549,7 +548,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			goto next_fdput;
 		}
 
-		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
 						    info->dest_offset, len,
 						    REMAP_FILE_CAN_SHORTEN);
 		if (deduped == -EBADE)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6ed334eecc14..93cc9fea9d9d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3180,7 +3180,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 {
 	struct idempotent idem;
 
-	if (!f || !(f->f_mode & FMODE_READ))
+	if (!(f->f_mode & FMODE_READ))
 		return -EBADF;
 
 	/* See if somebody else is doing the operation? */
@@ -3211,6 +3211,8 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		return -EINVAL;
 
 	f = fdget(fd);
+	if (fd_empty(f))
+		return -EBADF;
 	err = idempotent_init_module(fd_file(f), uargs, flags);
 	fdput(f);
 	return err;
-- 
2.39.2


