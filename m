Return-Path: <linux-fsdevel+bounces-24548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC675940717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978D71F23365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F621946A1;
	Tue, 30 Jul 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTEJAHK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F6194159;
	Tue, 30 Jul 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316502; cv=none; b=fKNBCUnO2qNG3GDEcP+xmnHGvHKdqSKc4+rKU1EqsV/ppZmo92NF3lrt11dHBGX8b2Ne8cN+s19sehVb8QvV6f9X+jkC8j8g3Mc8etumIXF8TLLesBHaKVbkgiOv9n+sQG5rxPEQP9snrPQURHsaKnmTiuNO653z/t0N0/fBkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316502; c=relaxed/simple;
	bh=I4qGtsSQCr4gMO+L0VQNf7QaDOcEL0iAl5N9IWh3gkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqk7/HVCvnZ0H6nO07REy0Z2fQOvfk4E7HcYu763H/Y1kbLlJ4erm4meTqcgv7gHxmjD/MN5O7HVt8HsNYzVbaZhCCNphvG2kYLOxyDDbRF9lMZSMIt1H7qjTG5pf6XVMa8TRkkgGTiEoiHLZAKY+JBeDBuMvD052psk675NH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTEJAHK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161DDC4AF0C;
	Tue, 30 Jul 2024 05:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316501;
	bh=I4qGtsSQCr4gMO+L0VQNf7QaDOcEL0iAl5N9IWh3gkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTEJAHK0Yv4mFRHyEFxFwDdU1MLY7ObE3uJ3/Yztjh44Ve4nA86TuyBvRI196pe2r
	 c+iaeep8gBKvHDxL/2P8BA3gDKGqo1dqp6BuvwtO6k+FLmlHvl9m/ud2kTN8XPpNgZ
	 36WOnX5tctlC+q/zBvqNlr5IsIgKwio0oMXn9j2C9xTJuybAYPNDiVgDGNeVN+Tamj
	 ryXGHkRy9JUDjmNniQC8ZLk7HD8iyeisvT8me3UF9gcDva5s0OQCVyf5u1bXYOTbLP
	 5Pj9TuEMP63mcjGN+ML5HGkH64sQ7NhuRBVvnHvDSTYeK8+inGAIfojH4WBSRTH6ZK
	 miyIT7OFUQizw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 16/39] convert __bpf_prog_get() to CLASS(fd, ...)
Date: Tue, 30 Jul 2024 01:16:02 -0400
Message-Id: <20240730051625.14349-16-viro@kernel.org>
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

Irregularity here is fdput() not in the same scope as fdget();
just fold ____bpf_prog_get() into its (only) caller and that's
it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/syscall.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3093bf2cc266..c5b252c0faa8 100644
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
@@ -2474,20 +2462,22 @@ bool bpf_prog_get_ok(struct bpf_prog *prog,
 static struct bpf_prog *__bpf_prog_get(u32 ufd, enum bpf_prog_type *attach_type,
 				       bool attach_drv)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_prog *prog;
 
-	prog = ____bpf_prog_get(f);
-	if (IS_ERR(prog))
+	if (fd_empty(f))
+		return ERR_PTR(-EBADF);
+	if (fd_file(f)->f_op != &bpf_prog_fops)
+		return ERR_PTR(-EINVAL);
+
+	prog = fd_file(f)->private_data;
+	if (IS_ERR(prog))	// can that actually happen?
 		return prog;
-	if (!bpf_prog_get_ok(prog, attach_type, attach_drv)) {
-		prog = ERR_PTR(-EINVAL);
-		goto out;
-	}
+
+	if (!bpf_prog_get_ok(prog, attach_type, attach_drv))
+		return ERR_PTR(-EINVAL);
 
 	bpf_prog_inc(prog);
-out:
-	fdput(f);
 	return prog;
 }
 
-- 
2.39.2


