Return-Path: <linux-fsdevel+bounces-43221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA50A4FB3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA81892DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6C205E2F;
	Wed,  5 Mar 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMTAFGih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75863205AD4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169309; cv=none; b=k9j0MJrIrfBatG+aPrTB443xK+9QIJY0MUBMkZWJj28C66VKvcBHayc1UuFA5Cwjy1N9BwURNcgthmC+proLSXuMAkRpKPclrQC9jK/8osW6gmHM27jOZGhfGV5Rc4nvaDiqZm/N0TNlhsD7gzFlqEVqW2MVeHm/qxY4RKdVdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169309; c=relaxed/simple;
	bh=b725dJ/yqm73AWK8ThtlveRgfYPp20MRnIG4wVPw2Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkJdfEMNwCs+MeCR8aUHLeG4TVnZUFiQhsCKUk+T2GSyIPSqhpHj8EpanVvXhl8/T7kn1w4SPfY6jN0YDtKqXSk2UaJ5fSrmJIGzZ5zHUioqLW6o/RiBQsZxM9JXH4eB1nW6tg43pjrxeiwQ2Mh5Rh9xKieHnSINLe9DnfS6DSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMTAFGih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB9EC4CEEB;
	Wed,  5 Mar 2025 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169308;
	bh=b725dJ/yqm73AWK8ThtlveRgfYPp20MRnIG4wVPw2Cg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMTAFGihyUBAgkUKffpeFvVriueueHM8HoWQhDsAMMHc8SArkITIVipGeZsCFso81
	 +bJNGq87lf2fxd2ARY9mozVcXmfXIiWdRESa4PPXX0hrHrCpo+BLmVXEIJMzfe0RlT
	 5fSrIsWzPL6XCxaHGPYjj4vFvbA0q9iW3iMcirLQzlKAEzqW190BCOBgs7kjc7xI3x
	 VIMBdW6ymC+hetPgz8IYXDSzAo6wYsgC/3jMjywOdgAu89Rl/4QrPZsP1QbyH1MNAC
	 Wn3TUuuEvaEqvg7lTvmdo/rYTP6eR4ZBs9ZqWG4GPzAbitrVbUhw3oTQsr2k44sWFG
	 udOOkxqiCmylw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:11 +0100
Subject: [PATCH v3 01/16] pidfs: switch to copy_struct_to_user()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-1-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b725dJ/yqm73AWK8ThtlveRgfYPp20MRnIG4wVPw2Cg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqhJsF+NETXK2ZedMjzPeEWhS823bxzbq8Ea5CT9
 7UfT7L1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSYMjI8Ed1MxMv2/2pi69/
 lLzgvzti9p2QZQHM/7TfdiXy9rFIyDD8lS649bcoVcVL7tH04JrVD2Pta+5tlJZu2sceV2qWGHa
 ICwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have a helper that deals with all the required logic.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-1-44fdacfaa7b7@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 049352f973de..aa8c8bda8c8f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -276,10 +276,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	 * userspace knows about will be copied. If userspace provides a new
 	 * struct, only the bits that the kernel knows about will be copied.
 	 */
-	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
-		return -EFAULT;
-
-	return 0;
+	return copy_struct_to_user(uinfo, usize, &kinfo, sizeof(kinfo), NULL);
 }
 
 static bool pidfs_ioctl_valid(unsigned int cmd)

-- 
2.47.2


