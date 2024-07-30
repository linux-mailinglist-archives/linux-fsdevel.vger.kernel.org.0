Return-Path: <linux-fsdevel+bounces-24554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E8940735
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8024C1F21748
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1EB195F3A;
	Tue, 30 Jul 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWLaH5WP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFD19580A;
	Tue, 30 Jul 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316508; cv=none; b=HL/nkhCaFCPHm4MHMVPkCu68hQ0OwldgT/l6HNClhjD8it8e/81sRuJDqJOCdrfVz7CcffqJGLi4ruprkDNUbsmg94RPzYa5Qd7qKLw5156pu/uHWYS5b815U6e38BxSgiRIahViY0f4XVz/OtrbOYp0QwSOEFlM/GPUx2tcmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316508; c=relaxed/simple;
	bh=azPKcLvM9oxlZRoUtdX7L0qFd3/GgExLiBn/bSf3R2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iw38zbmuxGuzMzfmgj8FthkbW180xBq4vAaXrjBnd+cQGC29tRquLJTW5ciCcIus04J+Ar4+722k6CMsD1HrwA6R2skm51105v8GnMaPpZtzTn4ty4Tkg/+e/EMEfn/9Rv479XKPOvepGmyI3OVjuO2EMjV7fiXZIIRUuga0Dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWLaH5WP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC304C32782;
	Tue, 30 Jul 2024 05:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316507;
	bh=azPKcLvM9oxlZRoUtdX7L0qFd3/GgExLiBn/bSf3R2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWLaH5WP/t61wQHqy9igqAIQka+oVGRcO2nn6hwwaC2kUFE61EQe7rdLrtnEb9BmP
	 OuQYdzoNTq0AwnjDXGNvg9zgVG0M+21NtWOIIEnxp4MI6MlJ9BVtzNaXuJjT5Rr9kX
	 z+5EpkX80tEouQJDh9uYb9Rp/Zo7x/FGvyEBG/ClOvzsEJJdUoi6evMzV+JAAehM4b
	 vJY01BdbUFSebtTwAxRQT4IzUKOvbIEoD0XValVekUDMJRAUUqzB9q8/z5wCrhuGAD
	 tLABYzUzH05lSgwYoREIhVRemr1eqNGYgjW3sFVQO4kUY+2N//BQWd7eWO8ch1KRtj
	 oZqpLtpiGQRBw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 22/39] privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()
Date: Tue, 30 Jul 2024 01:16:08 -0400
Message-Id: <20240730051625.14349-22-viro@kernel.org>
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

just call it, same as privcmd_ioeventfd_deassign() does...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/privcmd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 54e4f285c0f4..ba02b732fa49 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1324,7 +1324,6 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
 	struct privcmd_kernel_ioeventfd *kioeventfd;
 	struct privcmd_kernel_ioreq *kioreq;
 	unsigned long flags;
-	struct fd f;
 	int ret;
 
 	/* Check for range overflow */
@@ -1344,15 +1343,7 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
 	if (!kioeventfd)
 		return -ENOMEM;
 
-	f = fdget(ioeventfd->event_fd);
-	if (!fd_file(f)) {
-		ret = -EBADF;
-		goto error_kfree;
-	}
-
-	kioeventfd->eventfd = eventfd_ctx_fileget(fd_file(f));
-	fdput(f);
-
+	kioeventfd->eventfd = eventfd_ctx_fdget(ioeventfd->event_fd);
 	if (IS_ERR(kioeventfd->eventfd)) {
 		ret = PTR_ERR(kioeventfd->eventfd);
 		goto error_kfree;
-- 
2.39.2


