Return-Path: <linux-fsdevel+bounces-24560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6155940754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED871F233B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8319DF43;
	Tue, 30 Jul 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpCkHl3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B01990A6;
	Tue, 30 Jul 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316513; cv=none; b=OD9rVEYK0Rdb2lArNZdMzQcMB2Er5+ykzJ4y5vbSI3dPRAw3GwoY6tSZsizPb0BTg5eRLIq5Hy26IEYolz9c2p8qw6AJTiZLMLQzW5ZNOOpPs6nCf5242xfiwr7oD/TQtalkRT7RGbm571uP5cl6VI/w79fEzwbc26AA3xZOv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316513; c=relaxed/simple;
	bh=La6m1RJbJ/e95ihArzbVteOvAxqE1YnSb8rmAR/qpaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0xAq+nk33mSJ/0WeaTMdmIh/HRdOaqyL8sC2mjCSlZ07dKpjKbQowrH0yvOd3MJDLq6olp4ZCMdFkr5qjN0iqEy2kRfFcCt64M3PU0iJKTKbzP7MHs8eLpSbHBE25K1t+UbsDUpIpbrBOAYTDDkPLAt7N/PmcjkcslnSWGVYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpCkHl3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682FDC4AF0E;
	Tue, 30 Jul 2024 05:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316513;
	bh=La6m1RJbJ/e95ihArzbVteOvAxqE1YnSb8rmAR/qpaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpCkHl3VOH4sp8qvNurpzvQcyBjmGcjNdHWFFE86KUYTx/IgxjUgFFtss06u5EYnz
	 +Y8GhhKBGaJ5W/5h9MpUaZpay5TTE4HZ3B3kBOykZjSWgMuIne6SWXAZ5j+bBJD2zT
	 OCf1CLNkZoQFQtuYZm/qMTfK4JJH6peyA/YHa8VuXPI4ZJjld5NZimwDiQ9iXzqRQi
	 OfULtaaf4UmibtI+Idy7kiBlyiv7grbT6JAcpwqqFTuFlE1v6MsbPG5q3/53mN1KHa
	 LaBLhU2oWoEMYVi5UqZapUaLV8Dequ3qO4b028jKBp/juxEmPoh3VWW0DXqfC9yBaD
	 gGwQBiIn3jOBg==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 28/39] convert spu_run(2)
Date: Tue, 30 Jul 2024 01:16:14 -0400
Message-Id: <20240730051625.14349-28-viro@kernel.org>
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

all failure exits prior to fdget() are returns, fdput() is immediately
followed by return.

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
2.39.2


