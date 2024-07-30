Return-Path: <linux-fsdevel+bounces-24559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A0C94074F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D0F1F21B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF019B3F9;
	Tue, 30 Jul 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvIYbBe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C400199236;
	Tue, 30 Jul 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316512; cv=none; b=FyjP+/5rN+VsI9gLRHQkkG5mgTmQus4ex0AVEyc/GPYjldR48hyJtnsnsQrC/z+uvti/IGLWA3xxXO2wQqtzprVcmj4lcoQfsl4y7eT4SlQ3lZySqvAkE4SOJEL/eXmCuwfhHwfns/LNVklKk51rHmJQF8w3H6/T6D9u8YuvH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316512; c=relaxed/simple;
	bh=QsYOPz2mkBJNeRG4dajS51spOp9Fy2XtuLiHdn9tfWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwCovS7+Ltq1byMoeUH2U0aAGdvT+UmJtRPoQdpPnnWlfOXrbG8F0x/vOTaMYQkoek7zmzX4MZgGYhJFlrk4cEHvBYuq6Sz0rNRnT2BG1X22Pc39R8SHb+9Ef66+xPDzworlyBiid4nw/xbJdU/DKNpb9sg4RpeqDXn5jDAIA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvIYbBe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77632C4AF0C;
	Tue, 30 Jul 2024 05:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316512;
	bh=QsYOPz2mkBJNeRG4dajS51spOp9Fy2XtuLiHdn9tfWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvIYbBe1whEUnaEfNvQm/ZZl3HwUOYs5KUEgnrLTgDEH5zXJVFOp8KKRFnE4DtnzM
	 YWWQU5gqqMin4ann1b4CGx1/uIIotBGrWG4KguGLSL02BudgjzRQ0PBPPbS4TaB2lL
	 gqkxwq5k7MPUV+EO8To1KRic4zLMI5C2NdZGSXnNVPtFZr83OnxPfxoHNfWwO46xCe
	 5+6pakz84LkyyFtIdrbctg1pHkveQmQH1kCB+TN53t28WF9FXZWoZ3wHqfHQFS8Crq
	 jzdgUtNKgbqecE+wgVTOWodKECf0sAe9+idx8X3PMpXTU/9K7n+6WTcQRFyrcT00Ue
	 zVyaccwZWuIxw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 27/39] switch spufs_calls_{get,put}() to CLASS() use
Date: Tue, 30 Jul 2024 01:16:13 -0400
Message-Id: <20240730051625.14349-27-viro@kernel.org>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spu_syscalls.c | 52 +++++++---------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index da4fad7fc8bf..64a4c9eac6e0 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -36,6 +36,9 @@ static inline struct spufs_calls *spufs_calls_get(void)
 
 static inline void spufs_calls_put(struct spufs_calls *calls)
 {
+	if (!calls)
+		return;
+
 	BUG_ON(calls != spufs_calls);
 
 	/* we don't need to rcu this, as we hold a reference to the module */
@@ -53,35 +56,30 @@ static inline void spufs_calls_put(struct spufs_calls *calls) { }
 
 #endif /* CONFIG_SPU_FS_MODULE */
 
+DEFINE_CLASS(spufs_calls, struct spufs_calls *, spufs_calls_put(_T), spufs_calls_get(), void)
+
 SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 	umode_t, mode, int, neighbor_fd)
 {
-	long ret;
-	struct spufs_calls *calls;
-
-	calls = spufs_calls_get();
+	CLASS(spufs_calls, calls)();
 	if (!calls)
 		return -ENOSYS;
 
 	if (flags & SPU_CREATE_AFFINITY_SPU) {
 		CLASS(fd, neighbor)(neighbor_fd);
-		ret = -EBADF;
-		if (!fd_empty(neighbor))
-			ret = calls->create_thread(name, flags, mode, fd_file(neighbor));
-	} else
-		ret = calls->create_thread(name, flags, mode, NULL);
-
-	spufs_calls_put(calls);
-	return ret;
+		if (fd_empty(neighbor))
+			return -EBADF;
+		return calls->create_thread(name, flags, mode, fd_file(neighbor));
+	} else {
+		return calls->create_thread(name, flags, mode, NULL);
+	}
 }
 
 SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 {
 	long ret;
 	struct fd arg;
-	struct spufs_calls *calls;
-
-	calls = spufs_calls_get();
+	CLASS(spufs_calls, calls)();
 	if (!calls)
 		return -ENOSYS;
 
@@ -91,42 +89,26 @@ SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 		ret = calls->spu_run(fd_file(arg), unpc, ustatus);
 		fdput(arg);
 	}
-
-	spufs_calls_put(calls);
 	return ret;
 }
 
 #ifdef CONFIG_COREDUMP
 int elf_coredump_extra_notes_size(void)
 {
-	struct spufs_calls *calls;
-	int ret;
-
-	calls = spufs_calls_get();
+	CLASS(spufs_calls, calls)();
 	if (!calls)
 		return 0;
 
-	ret = calls->coredump_extra_notes_size();
-
-	spufs_calls_put(calls);
-
-	return ret;
+	return calls->coredump_extra_notes_size();
 }
 
 int elf_coredump_extra_notes_write(struct coredump_params *cprm)
 {
-	struct spufs_calls *calls;
-	int ret;
-
-	calls = spufs_calls_get();
+	CLASS(spufs_calls, calls)();
 	if (!calls)
 		return 0;
 
-	ret = calls->coredump_extra_notes_write(cprm);
-
-	spufs_calls_put(calls);
-
-	return ret;
+	return calls->coredump_extra_notes_write(cprm);
 }
 #endif
 
-- 
2.39.2


