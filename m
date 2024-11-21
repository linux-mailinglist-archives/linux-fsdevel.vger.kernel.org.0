Return-Path: <linux-fsdevel+bounces-35386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B495F9D47A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 07:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4677DB21545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E31C4A24;
	Thu, 21 Nov 2024 06:37:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210A13C3D6;
	Thu, 21 Nov 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732171052; cv=none; b=GCBVBbAbY5yYUo3jpWBx4NHFIqDfU7fc5APno28HXDrq2VrGijDF8U7mEKK00G6qTAT0sLs5lyAdVNd4iUfo4q0aWKCYAK78Q4ssVN9dx60X3uIK5YTi7ra1z5KnoXCHUsrHcMAGU52VcxCLq3UBSy5omxNkgxpebJVN8SS5NKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732171052; c=relaxed/simple;
	bh=nM5frX6UFJiHs42GcgIOCN53OIHQX6k31xo4sr3tnRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh4Wzo9abG8DHx8jvjHQe7/RaHzCzprEa9ohVzCXDTjAbNTqVovJDxCVThKSu0AHfwMC6DJa/sfWE7/zOaJhcGftXMSjTpxUTPrwomE6P6s588MC6dPn3DmG6R48MptXDkPc7qdx7okcTkm6ddldAXOCtHdXoFvNk4ZbtWqpNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xv7kS6k74z18N8X;
	Thu, 21 Nov 2024 14:34:40 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B8BF18005F;
	Thu, 21 Nov 2024 14:37:20 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Nov
 2024 14:37:19 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v3 2/2] xfs: clean up xfs_end_ioend() to reuse local variables
Date: Thu, 21 Nov 2024 14:34:30 +0800
Message-ID: <20241121063430.3304895-2-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241121063430.3304895-1-leo.lilong@huawei.com>
References: <20241121063430.3304895-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

Use already initialized local variables 'offset' and 'size' instead
of accessing ioend members directly in xfs_setfilesize() call.

This is just a code cleanup with no functional changes.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2->v3: Collect reviewed-by tag

 fs/xfs/xfs_aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..67877c36ed11 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -131,7 +131,7 @@ xfs_end_ioend(
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 
 	if (!error && xfs_ioend_is_append(ioend))
-		error = xfs_setfilesize(ip, ioend->io_offset, ioend->io_size);
+		error = xfs_setfilesize(ip, offset, size);
 done:
 	iomap_finish_ioends(ioend, error);
 	memalloc_nofs_restore(nofs_flag);
-- 
2.39.2


