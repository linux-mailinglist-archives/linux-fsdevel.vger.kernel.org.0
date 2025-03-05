Return-Path: <linux-fsdevel+bounces-43227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4A9A4FB45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803813A5EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D2205E3F;
	Wed,  5 Mar 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAsgiZdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFF1FC7FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169322; cv=none; b=nHcYi3h6E7qFJDiD2sniGeGySoB+QlbI5oia3Smp1eJB//KvdsU3ApWjT89QTcofFuVjG7DYpr/+lezEXU/gs/qkZyXqIFYI4rYZ3X9VwiOjOxXzLb/vG71FrQGHDdChonUPDTe59kED/YugcDdAB2tm1/jR3k094RphfkUT1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169322; c=relaxed/simple;
	bh=IX6I3dL4hN6SFtOCJeS6XvppNTM0MxWtctr5HPHM4Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ox2PmANx8nbNvmp9xtDrJD0jU5VbP8H0KI4+7ZW2NqJVCRE0dyNzTDcEWXVd3rKt41wy9y9EF45qxcnd3Qc1/WOS8uV47F/E32BUgMNjUU+dgmMNyv+eM+s1GZw6FQXZAfnIEFrZGYcrCwsR2wFb0oz7gFOxo1Og6Cx1GJYCo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAsgiZdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D595AC4CEEA;
	Wed,  5 Mar 2025 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169321;
	bh=IX6I3dL4hN6SFtOCJeS6XvppNTM0MxWtctr5HPHM4Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tAsgiZdmyue4oTBc5b5rq3PEWs8Nl+Hk3O6kUtlHs38rq9DbuNBHMxn/aP/l/1SRH
	 1WbKH8FxyDcaDTfeOcqo2FubLeQJXdYV5aDhLXhBS2ss3PoaOmKSSzpRsWx61FjSCJ
	 cF+QvWkgMcNLdBuuGGRLb6TtZt3E0lANMGc+wb5zmz94VucGxko3qBSxbfZhpCD5RD
	 Zv9P+5HXUXaZH1VyaMYoh2izecDaUb5/kPhCInDepY0gVjorOuzh3OqBG/rzT4ktNv
	 E0mkfgRXGR4uqYGw9Agw5Kt9johfXq+3HlHeuVaDhGL5P5v4uokVhwQaokgkEYcd/j
	 kYZQVzqHlD7iA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:17 +0100
Subject: [PATCH v3 07/16] selftests/pidfd: fix header inclusion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-7-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IX6I3dL4hN6SFtOCJeS6XvppNTM0MxWtctr5HPHM4Ps=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGfIIpii24T6/xKH8yVhITj4SxbVI2Ho367yULucYMtwyWHjn
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmfIIpgACgkQkcYbwGV43KKtOgD/d899
 AD0n9Vz8cS45DWweNngQwGHiH8FcAPr3OhDFE6ABAI2rFHR8FPxhkCdtbmiwxWcz9NFMggg6WXf
 aNWgv638A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that necessary defines are present.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-7-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"

-- 
2.47.2


