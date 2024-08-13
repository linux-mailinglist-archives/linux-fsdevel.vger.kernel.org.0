Return-Path: <linux-fsdevel+bounces-25831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B1951029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB4B1C22E08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61091ABED0;
	Tue, 13 Aug 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH8/LvNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D716DEA9;
	Tue, 13 Aug 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590199; cv=none; b=nIunNmcbcIzaYXkrQylJY9A3IIhNay1EyLhtYTrhQPjGTDqOn15bf7OtZ9u0XgYGWQ4kp076IkpVnn4IaBYUpsXyc6Y4JeaBBCoI6A0mcdX7JSV+3S8t97JQ66xiEf1BB4s92I7s508tEaUujDK4tu3wHfjVJaLnMNxeSRcmTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590199; c=relaxed/simple;
	bh=jBacy3t2SemLe/iWHcLPvNfBjPA8E3+Du9oyNnED44c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz8saice3hHLhCX9Mr6p9QR7k2PJTRBO/iHX1pJIGi9vX6DgCFs+R3gXkeCoGmZu7pGPHsKLbE1cuwdRABnWuDz8Z33m8YCTnsHSEwhza+/nUTkDKA3GkIIhegabBpseQthL/zLy9/Bgn3R/SuhOsU5+zO0YKS2U44sXU6aQ7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH8/LvNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC83C32782;
	Tue, 13 Aug 2024 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590198;
	bh=jBacy3t2SemLe/iWHcLPvNfBjPA8E3+Du9oyNnED44c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YH8/LvNU/SopVIHrK5yNdWErpSNBfAcnMxH/gw22QTVTKo6la0H9x6n8iGoJMuxRx
	 rXqbz90Zu2vUcrp3nVQZ5kGLZCgC6BzYkxx++/eZ+G5N0DIHmR2jrb+BMAZBXiYy48
	 SsXUHLbuc5AgZnfGzcZ+uojes8+X3GQ3t2w1bgQ/iJAp4HOr3XfxffS+bhNYWeYVfT
	 CkWPtzKd7WCs5EDcoiAGd0SPllOUnkZaS+Z7WH40VnQgRsGReY9czFuK5qw2RoufQo
	 U1NfjuwSynF9TwN5oMVAsRYKa7PRjnCn+4czlXm5wCC1J0uQ3fOp/cjG9AHzqJVxHZ
	 5wMjd5vrRri5g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH bpf-next 1/8] bpf: convert __bpf_prog_get() to CLASS(fd, ...)
Date: Tue, 13 Aug 2024 16:02:53 -0700
Message-ID: <20240813230300.915127-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
References: <20240813230300.915127-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Irregularity here is fdput() not in the same scope as fdget();
just fold ____bpf_prog_get() into its (only) caller and that's
it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3093bf2cc266..4909e3f23065 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2407,18 +2407,6 @@ int bpf_prog_new_fd(struct bpf_prog *prog)
 				O_RDWR | O_CLOEXEC);
 }
 
-static struct bpf_prog *____bpf_prog_get(struct fd f)
-{
-	if (!fd_file(f))
-		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_prog_fops) {
-		fdput(f);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return fd_file(f)->private_data;
-}
-
 void bpf_prog_add(struct bpf_prog *prog, int i)
 {
 	atomic64_add(i, &prog->aux->refcnt);
@@ -2474,20 +2462,19 @@ bool bpf_prog_get_ok(struct bpf_prog *prog,
 static struct bpf_prog *__bpf_prog_get(u32 ufd, enum bpf_prog_type *attach_type,
 				       bool attach_drv)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_prog *prog;
 
-	prog = ____bpf_prog_get(f);
-	if (IS_ERR(prog))
-		return prog;
-	if (!bpf_prog_get_ok(prog, attach_type, attach_drv)) {
-		prog = ERR_PTR(-EINVAL);
-		goto out;
-	}
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (fd_file(f)->f_op != &bpf_prog_fops)
+		return ERR_PTR(-EINVAL);
+
+	prog = fd_file(f)->private_data;
+	if (!bpf_prog_get_ok(prog, attach_type, attach_drv))
+		return ERR_PTR(-EINVAL);
 
 	bpf_prog_inc(prog);
-out:
-	fdput(f);
 	return prog;
 }
 
-- 
2.43.5


