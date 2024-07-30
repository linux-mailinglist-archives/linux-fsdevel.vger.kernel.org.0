Return-Path: <linux-fsdevel+bounces-24547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D306C940712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D773B21CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C20194150;
	Tue, 30 Jul 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjgnJCtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1C194131;
	Tue, 30 Jul 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316501; cv=none; b=rHMr5YSUeLk2C8ahfHKVhnR1602XDnKgpcRBMREmeCB1ZZdhTqbtnDLATp6EVDgysTv+E8H8oOwF+NTHJLpRR4u31coxsYwMyo+2h/6izIObvpZ1zmmM1Za/cV9zCDyzA+Y2ip8ynhMY3lX9D2RB5+/InrGnhK1j/9/ed6pdnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316501; c=relaxed/simple;
	bh=z/tnTx9kAZkNBwGV4/ONtuYCC3Oia9nrQ3k7KSmMWLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXA8ExsLo8pZFVEMGFSlfmOwyGP0lp/Hc8ZM1fUlFOHChxlFDe/NKPrFNLX/f/f5Mtgoww9+aTro8GarqWvSE/DA+gA7shDZ/choogXWSZW3R4/igatATShc22ibhOnXYWf2BHkQX75fLrzFovt7zlZJVHFO1jjlwtERUr3P++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjgnJCtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217E1C32782;
	Tue, 30 Jul 2024 05:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316500;
	bh=z/tnTx9kAZkNBwGV4/ONtuYCC3Oia9nrQ3k7KSmMWLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjgnJCtfFpiR+aggtT22NGb/IzzXS8o04RcS84vg1BIXVXKzN58NOzqSL6zmlJrN+
	 TyjhImM/Hf85K38bA8wNMMw2LxU4kbs6NDJdrM3vzOqnouxxaGJr5fWP8jM5Uv3Ryh
	 /PtgIt97OBkS0FWTkYUuq5a3HaHVKswfHPZ8TB5ZHcymYs10GNF2uvy9BnDbmjD7V0
	 h4HkbiM4ZTUTR7O2egk5mNDk1n234d68Zl+UAy+j10S8HB88PTOoUWiwtG8v30d/tf
	 6a9Co5c49zede6TXafQt5XQc8upKp9/9W6ABSOm85cSfUGPDg0c9Wh5zLtaongMKyz
	 slPZgDD4z0WGQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 15/39] convert vmsplice() to CLASS(fd, ...)
Date: Tue, 30 Jul 2024 01:16:01 -0400
Message-Id: <20240730051625.14349-15-viro@kernel.org>
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

Irregularity here is fdput() not in the same scope as fdget(); we could
just lift it out vmsplice_type() in vmsplice(2), but there's no much
point keeping vmsplice_type() separate after that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/splice.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 06232d7e505f..29cd39d7f4a0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1564,21 +1564,6 @@ static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	return ret;
 }
 
-static int vmsplice_type(struct fd f, int *type)
-{
-	if (!fd_file(f))
-		return -EBADF;
-	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		*type = ITER_SOURCE;
-	} else if (fd_file(f)->f_mode & FMODE_READ) {
-		*type = ITER_DEST;
-	} else {
-		fdput(f);
-		return -EBADF;
-	}
-	return 0;
-}
-
 /*
  * Note that vmsplice only really supports true splicing _from_ user memory
  * to a pipe, not the other way around. Splicing from user memory is a simple
@@ -1602,21 +1587,25 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
 	ssize_t error;
-	struct fd f;
 	int type;
 
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
-	f = fdget(fd);
-	error = vmsplice_type(f, &type);
-	if (error)
-		return error;
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	if (fd_file(f)->f_mode & FMODE_WRITE)
+		type = ITER_SOURCE;
+	else if (fd_file(f)->f_mode & FMODE_READ)
+		type = ITER_DEST;
+	else
+		return -EBADF;
 
 	error = import_iovec(type, uiov, nr_segs,
 			     ARRAY_SIZE(iovstack), &iov, &iter);
 	if (error < 0)
-		goto out_fdput;
+		return error;
 
 	if (!iov_iter_count(&iter))
 		error = 0;
@@ -1626,8 +1615,6 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 		error = vmsplice_to_user(fd_file(f), &iter, flags);
 
 	kfree(iov);
-out_fdput:
-	fdput(f);
 	return error;
 }
 
-- 
2.39.2


