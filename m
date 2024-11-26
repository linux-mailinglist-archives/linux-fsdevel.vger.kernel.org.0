Return-Path: <linux-fsdevel+bounces-35866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0259D907E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 03:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BC216749C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346183B7A8;
	Tue, 26 Nov 2024 02:54:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4519D26D;
	Tue, 26 Nov 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589651; cv=none; b=iHWmU0kv4O/0kTVL2Fohu+NYpZgUqquwa9PRUYRPm3raqQX+i3kbE7K0f9/eBtLwHKGIfax0WLFx/dX7tyjdinOrGPc94x7wXcF+587S3DJxXjUdk5mw+7Fr+oTLuy4W1IPn76ZztPqpIESb9SbcxlPXGNReTTgM+MDChOUMXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589651; c=relaxed/simple;
	bh=XGo044VhXgUmO3tjubguzk60LcgtF5i9X7oZHx/tNNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5/sT15li68qxgdfxoavUmNzzNR0q7sHFwIqxhJFMLynmlp13Q5UmmWBf9xh5s/Kb0YLUOTr9m9KHfZa5hcBgtpk/RaNbYwoQWnC+0/CYvB2SeSCLrCbglSdD7uFc87+XOyS23U7R0VJK0zvJWKIlXYQsVOTMzwpbA0jBTYrrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xy6XS2Y2lz1V4l2;
	Tue, 26 Nov 2024 10:51:20 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 05F231401F4;
	Tue, 26 Nov 2024 10:54:06 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 10:54:05 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liaochang1@huawei.com>, <chris.zjh@huawei.com>
Subject: [PATCH v2] x86: fix missing declaration of init_fs
Date: Tue, 26 Nov 2024 02:45:32 +0000
Message-ID: <20241126024532.3465039-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100007.china.huawei.com (7.202.181.92)

fs/fs_struct.c should include include/linux/init_task.h
 for declaration of init_fs. This fixes the sparse warning:

fs/fs_struct.c:163:18: warning: symbol 'init_fs' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
v2:
- fix some typos
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


