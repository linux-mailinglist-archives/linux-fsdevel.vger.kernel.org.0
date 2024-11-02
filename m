Return-Path: <linux-fsdevel+bounces-33528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B39B9D1F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A49D1F23B89
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898F1A704C;
	Sat,  2 Nov 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pJLvw6bX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665214A0A4;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524115; cv=none; b=gNPfsfRMHEh3dlu7K9lnJMIXULOn2ZCpsS9izcJBqyQC0kQREVdqo40j1pXlEb5/zig98AnpYd3MxV0HVtt2XNfymQHFaxkfyRmMEZ96xnHSnoQB/NCL9gLtX1seKLz+tPE6ikKhMQkCYs7Zsnu5WnUsZcml/H8aOHp8xfmBUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524115; c=relaxed/simple;
	bh=ZROOiPbuI7050Mb5nkT2JAvgRg4h/KC2SI3FrIo9sds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQAo7X6Fq1PsmnnK3W5DDWQg2iw+gIDv+2GSLcR487pp2iRn2fAXnDdjLX78FTUUrM54bfaYCLCFNr4+Q1Zzu100g6I1ADacXVUlTGcDqdzBExnneILzqvUTCrMODZdOFAkFCs1JicDHyoEOO7qa21q4RMH5+HJZds3n2Lj00mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pJLvw6bX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3NYg8JSsMKy8Frd7HbHYI7Kn84hHchr6hnGoBy37xF0=; b=pJLvw6bX7xFuB+W5I6UGax6EfR
	NFyhqv0nXhIX6DHdnYq+buezCLNlp+wdonpe9zPzWjGojmu8f0DU9tepFX9ZRQbi/e18ALL4dbSJU
	1gsJXlPUJ3Nara/Rz1aSOgPIjJOMdTr9AdAXidcv7ec/X7NAmBGSa2343XfhlL0vR/+GrU8dXXZH6
	TvyvucsKyGPEOOnobWOe1RsCJnil/eKvXfU3JRn2a051XcmTsPi3GxzLKKCDyGBX7ZHeVV7D4pq5e
	yio7bPEyYleraV5aduTIeaeO2EwnZQLK4d8Q4RpARh7l0+4MxRBPmvy18aPF1YEZfmRPqFR7XtpDd
	XhIGsI1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NB-0000000AHnY-2q30;
	Sat, 02 Nov 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 18/28] switch spufs_calls_{get,put}() to CLASS() use
Date: Sat,  2 Nov 2024 05:08:16 +0000
Message-ID: <20241102050827.2451599-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

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
2.39.5


