Return-Path: <linux-fsdevel+bounces-35961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210D9DA25F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2955167816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8351494A6;
	Wed, 27 Nov 2024 06:37:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37189F9DD;
	Wed, 27 Nov 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689442; cv=none; b=CrcaG6RX5in4r7rKvXtEpEHGFbBnUaU9Mm6QgeQToPvqY4YgAKQPoLfQY2jAdoVpoi6vr5hSaLimhcbzG7kkA2GJzNaoaV50su3dPPnHw6nzeHzEqUYCGemBX1hPZZH+6Abyjwjzw1tJW4hyq6qYAxbXqyJMXcEtewuYWVVlmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689442; c=relaxed/simple;
	bh=TT/WNujaOyvgQ56M/Aflaf0a8DMtPiv0MQYAKuAavnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnfia8paPkpWMcHU2b4zR9XWbWH6iowxsAQcObb7as++QvAcvyT+xKDE3VjAgDUlkYcL27EWrRj1qR2JD0NeL0S008jFkgQ3k0cfol1vYSBfrowZh8pzKPGD5eh6IxKJwRBXUNDR14IE0t7sAJ918G8v3rt3wNbuSfqukc263nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XyqSs2R0VzRhnr;
	Wed, 27 Nov 2024 14:35:41 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 202CC1402C7;
	Wed, 27 Nov 2024 14:37:11 +0800 (CST)
Received: from localhost.huawei.com (10.175.112.188) by
 dggpemf500017.china.huawei.com (7.185.36.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Nov 2024 14:37:10 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v5 2/2] xfs: clean up xfs_end_ioend() to reuse local variables
Date: Wed, 27 Nov 2024 14:35:03 +0800
Message-ID: <20241127063503.2200005-2-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241127063503.2200005-1-leo.lilong@huawei.com>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

Use already initialized local variables 'offset' and 'size' instead
of accessing ioend members directly in xfs_setfilesize() call.

This is just a code cleanup with no functional changes.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4->v5: No changes
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


