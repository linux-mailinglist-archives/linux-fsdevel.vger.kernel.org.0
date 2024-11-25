Return-Path: <linux-fsdevel+bounces-35789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6429D85F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA9B3365D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0F1A0721;
	Mon, 25 Nov 2024 12:40:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CF1552E3;
	Mon, 25 Nov 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538402; cv=none; b=Tc8bkdP7HtlQHxrbMTtR5mCiGk9fFrsmkVocqRitz1UdE5FjsfGe9ukggF4LYTn/7IusP/vN19QhHAjp6qNWnCbzYqLeaU2Cb4NWMLfGqieZEh2i1r6/30JANBMCBxe2wBqLEBi26eLdZ9QbaX6NmCXavTolufiHGhMxdu35wNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538402; c=relaxed/simple;
	bh=xy97535/RdsSRXyaObPiLFIZayngr7F/JyF8wU1TQd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mkr99HM33UG8uRUniJhNu8cYRCJ77SqYy5WsCBBDgNAC5I8SFLAHi860LxbDh3IyycvR0HuVS1YOJ1uqrJsuVQXiWBiYKctVobEXO4HXzETPo2O8G7MzK9V26VwwWXkKt1tBqAstUpV3R0o3sCPrNy9VskhtVtLP44Lfacq5tNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XxlZt1M3mzWfQJ;
	Mon, 25 Nov 2024 20:37:10 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id E26F61800A7;
	Mon, 25 Nov 2024 20:39:55 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 20:39:55 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liaochang1@huawei.com>, <chris.zjh@huawei.com>
Subject: [PATCH] x86: fix missing declartion of init_fs
Date: Mon, 25 Nov 2024 12:30:55 +0000
Message-ID: <20241125123055.3306313-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100007.china.huawei.com (7.202.181.92)

fs/fs_struct.c should include include/linux/init_task.h
 for declaration of init_fs. This fix the sparse warning:

fs/fs_struct.c:163:18: warning: symbol 'init_fs' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 fs/fs_struct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..100bd3474476 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -6,6 +6,7 @@
 #include <linux/path.h>
 #include <linux/slab.h>
 #include <linux/fs_struct.h>
+#include <linux/init_task.h>
 #include "internal.h"
 
 /*
-- 
2.34.1


