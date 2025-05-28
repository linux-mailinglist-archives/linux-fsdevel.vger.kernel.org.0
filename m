Return-Path: <linux-fsdevel+bounces-49943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF0AC603D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 05:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4619E6D67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B51F1537;
	Wed, 28 May 2025 03:48:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7B1EB1AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404090; cv=none; b=llNfecJgmomxMVqD6Hvvg4uB4nxeTxyB9Ld9TKGEPsSoZSaPBEUAzedA7xAR5u/LzHjhDh5mQZHK9gc+8SQK1Z5BHr0ILzi/kXT+mBswAL6o+5Tj7RWkhulkoAB5MhB5Y2AFL05rqyV2bqCicRBU3m1h9qjWv682Gi+DvS2fGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404090; c=relaxed/simple;
	bh=4vZ/Q3yu/XrBigA6HkCbRgzcclWEsYKNV//bajsYs5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nIcnNKCDFF6Cq1lKC1JKwXsauB2LN8pQ2t1KC7fuQUZ0SR7O0Ssml/ftb/C3neqRq1ebSy/cyivCQu3LaEpgpCtQN92uiFkRpKAXpTkJ0zBLElwLnn4/78jVUz1bBWVDm9Qn9Krh4i1sCToWuMCGhQHzWu2Cs8RtaS2rUoV/IMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4b6b4p4tKVzYlCqc;
	Wed, 28 May 2025 11:45:46 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 May
 2025 11:47:59 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 May
 2025 11:47:58 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>, <rick.p.edgecombe@intel.com>,
	<ast@kernel.org>, <adobriyan@gmail.com>, <kirill.shutemov@linux.intel.com>,
	<linux-fsdevel@vger.kernel.org>
CC: <yebin@huaweicloud.com>, <zuofenghua@honor.com>, <bintian.wang@honor.com>,
	<tao.wangtao@honor.com>, wangzijie <wangzijie1@honor.com>
Subject: [PATCH] proc: avoid use-after-free in proc_reg_open()
Date: Wed, 28 May 2025 11:47:56 +0800
Message-ID: <20250528034756.4069180-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

Like the rmmod scenario mentioned by Ye Bin in proc: fix use-after-free in proc_get_inode()[1],
we should get pde->proc_ops after use_pde for non-permanent pde to avoid UAF in proc_reg_open().

[1] https://lore.kernel.org/all/20250301034024.277290-1-yebin@huaweicloud.com/

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/proc/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740..8de0af8c3 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -473,13 +473,13 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_open) open;
 	struct pde_opener *pdeo;
 
-	if (!pde->proc_ops->proc_lseek)
-		file->f_mode &= ~FMODE_LSEEK;
-
 	if (pde_is_permanent(pde)) {
 		open = pde->proc_ops->proc_open;
-		if (open)
+		if (open) {
+			if (!pde->proc_ops->proc_lseek)
+				file->f_mode &= ~FMODE_LSEEK;
 			rv = open(inode, file);
+		}
 		return rv;
 	}
 
@@ -506,6 +506,9 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 		}
 	}
 
+	if (!pde->proc_ops->proc_lseek)
+		file->f_mode &= ~FMODE_LSEEK;
+
 	open = pde->proc_ops->proc_open;
 	if (open)
 		rv = open(inode, file);
-- 
2.25.1


