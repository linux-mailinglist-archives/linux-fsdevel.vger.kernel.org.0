Return-Path: <linux-fsdevel+bounces-33522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE759B9CFE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6760C1F22920
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3F175D47;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kgqTXCf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8714A4CC;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524113; cv=none; b=nmQYk7fEyHRK6G47Y0TySADY+sl7LG2pAy3KmxMZA50ncsfCivK6/yCuVBlGahZeIodksbP4uQFV/NpRkfjV9tj2pnuOobMmbXDHVJ1jMv4twPt74/nqTRk/hLWm9lbwdc7qCN67on79Lfj8hLDtdxvZOiWjY+cJ5H9zYDRO65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524113; c=relaxed/simple;
	bh=VjMuRl8jH0BsCDJit/URN/Su1DcBaZgchcMWnxZS9IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7+seS3NHfN0s9Qvx3NuEY+oocasROSUPJ6PaYRQqnX2cW+OmGDwkgzSZkLpq3jvBCBsl/x5RPhfM0EEdr8GHg6UxCxy3yvYfuX3rzHUn6nJqzVf6Ty2nwZJPmTeCYQPf1CRWzE1lvVct9qoDSYJ7qrBj9DqvqVpJaHKsJXovGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kgqTXCf4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FAqTEvs4QORKFNFL942YuG6DNM7M7CQ0nHgpxyFsKNM=; b=kgqTXCf4naEOBJ/DPsUP1Q4Mu8
	9KxSVRFq8S8XBLcwIXK4Y6Q4op+QZi9vQGnBlORp8eLdss3gnqzWmSXZ8p/bImMwQ2mRbvjRbbQj7
	WgocaTGnbXpyWAQvCdgsU0qZe6vkxt1Vtbup6DKQvdVcYcSTuON7r7VyyuhbAYMP5hacUY43V0Bnr
	I6Fva/ikvBOLvzzx2/4EgIMHbPovSbrrJRJmzaBG6QyMqc0T6D39zk+kXkrtE3slILaQ19IhobSij
	nPuI9MZoNeCca7YbpIpl0w1lqct5WAsZpt47JxK1HN9+nVaguJdUIpwfdZ3jOiO0Do0Z9JWj+7bwf
	cAoQrxHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NB-0000000AHnf-3TEo;
	Sat, 02 Nov 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 19/28] convert spu_run(2)
Date: Sat,  2 Nov 2024 05:08:17 +0000
Message-ID: <20241102050827.2451599-19-viro@zeniv.linux.org.uk>
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

all failure exits prior to fdget() are returns, fdput() is immediately
followed by return.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spu_syscalls.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 64a4c9eac6e0..000894e07b02 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -77,19 +77,15 @@ SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
 
 SYSCALL_DEFINE3(spu_run,int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 {
-	long ret;
-	struct fd arg;
 	CLASS(spufs_calls, calls)();
 	if (!calls)
 		return -ENOSYS;
 
-	ret = -EBADF;
-	arg = fdget(fd);
-	if (fd_file(arg)) {
-		ret = calls->spu_run(fd_file(arg), unpc, ustatus);
-		fdput(arg);
-	}
-	return ret;
+	CLASS(fd, arg)(fd);
+	if (fd_empty(arg))
+		return -EBADF;
+
+	return calls->spu_run(fd_file(arg), unpc, ustatus);
 }
 
 #ifdef CONFIG_COREDUMP
-- 
2.39.5


