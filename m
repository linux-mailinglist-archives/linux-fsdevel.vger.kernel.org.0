Return-Path: <linux-fsdevel+bounces-35490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5882E9D5615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 00:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CDBB241AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588141DE3A6;
	Thu, 21 Nov 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWvmZpuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF981DE2BE;
	Thu, 21 Nov 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230683; cv=none; b=jI01EqOKeTRCHL9IJbaZ44XSz/1S2gC4R/esE5mO5LcAbV2okiTS94JVxD2QjjSttN5S8AtkboFo2BHGGIwCQcRpqOh/SVyVCZTVl8FDqq1nCtAED2CbDURClvRWEujgo9Uly1Mzm1ePu0gwtKB+2HlmQ6oUt3h0C07Wzi7jRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230683; c=relaxed/simple;
	bh=G9Bz8tOnOEohCsDxnfCcjtd93YjrNlQ6mHDYYxDioIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPWG10BT1fGYLJ0+UcI0sptv8HMWUqVPGxo1idBZRaJllTix/PBfaBltbsZPTvVM5cmFAIcJk2NHKO19Xo5dJBYtF3Wqh7lTG3UzA4xX5DwW50nxuIc3XZ2k2UaAtpiCL/KSIKu9zQT6GED0arIqAjsTXggKJGf/7ikS2Kb+BGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWvmZpuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150C6C4CECC;
	Thu, 21 Nov 2024 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732230683;
	bh=G9Bz8tOnOEohCsDxnfCcjtd93YjrNlQ6mHDYYxDioIY=;
	h=From:To:Cc:Subject:Date:From;
	b=LWvmZpuKjIy/alM8rlYfbbiCPG2LVbb41ol0kgj8f0bSGzXD5QBmOu8dTRA+SbR6x
	 bvqVp3mRUmzLQffaD+kB+WXqRYmKApYVlscjDJy7ennAdTwpydosnHgOynQtVs4run
	 mpLest+mnFeZ9m8bbtSdrETQWqg9S2lZeTapFswsMvJiLTgQM/pkIh36r7/j5Z8Omm
	 aXj3/ibNoaJiPKvHAH0NrrTAIDRywFlz97MxpbV4DroQtn+SP1gJnPTQMQqesFwwEK
	 crkoaAvxn6d1FCPX9FXTLBKhoAue91XzGpbFF+ZwWk/JYzrn4QUErl+NqQDare7UJF
	 l3iFyp/BJuuRg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero
Date: Fri, 22 Nov 2024 00:11:18 +0100
Message-ID: <20241121231118.3212000-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iov_iter_zero succeeds after failed copy_from_kernel_nofault,
we need to reset the ret value to zero otherwise it will be returned
as final return value of read_kcore_iter.

This fixes objdump -d dump over /proc/kcore for me.

Cc: stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Fixes: 3d5854d75e31 ("fs/proc/kcore.c: allow translation of physical memory addresses")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/proc/kcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 51446c59388f..c82c408e573e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -600,6 +600,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 					ret = -EFAULT;
 					goto out;
 				}
+				ret = 0;
 			/*
 			 * We know the bounce buffer is safe to copy from, so
 			 * use _copy_to_iter() directly.
-- 
2.47.0


