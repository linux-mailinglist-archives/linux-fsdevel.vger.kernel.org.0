Return-Path: <linux-fsdevel+bounces-35748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A79D7A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 03:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D30281FAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F914293;
	Mon, 25 Nov 2024 02:36:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5647FD;
	Mon, 25 Nov 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502184; cv=none; b=QrSvvoyuJ6nAXF9LtnlTUNcM8pUof7Ew6UxOqIC8kKDTVRFE5VMyGI53enNvrNwC9j8u6qvh3mroUf63JJS4ObH4R+P8QjNuyVCtCgYigJ1mqW7Oyta4XWDRCGeX4KuR5t/T6GD9JsdtMZPxa2L8ItDsddxnObngLbQ2RkREi4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502184; c=relaxed/simple;
	bh=ln2xQbsDgxry7xvsk4Jkh2KiNDjup73L+4tEY9llPmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luGDVGoH3v/Dd4bWWGM3l9MvBJ/2LA3RxNXwaQcNCb8e3DlFauasXAEk2QVVVNmB1pyzwTyCWc4+lW+MsTnd1b6xJCfM+fJK3ow2fEKqzeCp+oXkKiiNc+qDyVYODCgArVknySQYJJhCigJmZGVLczt14aVDDGSfqzmxAUjqIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XxVC51j3Hz2GbhP;
	Mon, 25 Nov 2024 10:34:09 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 32430180042;
	Mon, 25 Nov 2024 10:36:14 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 10:36:13 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v4 2/2] xfs: clean up xfs_end_ioend() to reuse local variables
Date: Mon, 25 Nov 2024 10:33:41 +0800
Message-ID: <20241125023341.2816630-2-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241125023341.2816630-1-leo.lilong@huawei.com>
References: <20241125023341.2816630-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500017.china.huawei.com (7.185.36.126)

Use already initialized local variables 'offset' and 'size' instead
of accessing ioend members directly in xfs_setfilesize() call.

This is just a code cleanup with no functional changes.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v3->v4: No changes.

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


