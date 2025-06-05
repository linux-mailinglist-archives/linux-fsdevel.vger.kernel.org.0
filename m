Return-Path: <linux-fsdevel+bounces-50709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34AACEA79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDF33A7E37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E01F8AC8;
	Thu,  5 Jun 2025 06:53:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191872114
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106386; cv=none; b=KbY0NKjaWiMkX7SgJ5S4m+EI2AM7Gjc4jOMjfgSYX6OY2G8kWueSfMrVB/iuS/eI3Ynv+qdhudjIXHDZumZi8Uf+NchTxrc5K1O9ZuOWUWxiKiiEGK3gE0M11sNuUny0Qw5NBl7LuLtmeyDclEEp55Faa7aMmh/ITOc+lAxIDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106386; c=relaxed/simple;
	bh=/TcQ2ZRDvXNICd1uUMyuhFPbvdR0fo8sycCRgvQIwyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lxdNN1UuH3yRozkfx2dz5nW3PIbl3mc0D7TGKgmrwEpW+cQWu/0/7xqYY4Mnff6Tb7iSK/6ZhXTGUYmDjT70Drsp+Rd0B2FvsPHA/5RfXCNO0i19g5o8qGrXD9Qxt8KPgZpbqcSrj9x8knTUAAz5R0/2/XxrpKeui2HbeYlAK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bCZpN3V1bzYls2r;
	Thu,  5 Jun 2025 14:50:36 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Jun
 2025 14:52:54 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Jun
 2025 14:52:54 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>, <rick.p.edgecombe@intel.com>,
	<ast@kernel.org>, <adobriyan@gmail.com>, <kirill.shutemov@linux.intel.com>,
	<linux-fsdevel@vger.kernel.org>
CC: wangzijie <wangzijie1@honor.com>
Subject: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Date: Thu, 5 Jun 2025 14:52:52 +0800
Message-ID: <20250605065252.900317-1-wangzijie1@honor.com>
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

Clearing FMODE_LSEEK flag should not rely on whether proc_open ops exists, fix it.

Fixed: ad7f4ea6e36e ("proc: avoid use-after-free in proc_reg_open()")
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
Based on mm-nonmm-unstable
---
 fs/proc/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8de0af8c3..10a8481cc 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -474,12 +474,11 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	struct pde_opener *pdeo;
 
 	if (pde_is_permanent(pde)) {
+		if (!pde->proc_ops->proc_lseek)
+			file->f_mode &= ~FMODE_LSEEK;
 		open = pde->proc_ops->proc_open;
-		if (open) {
-			if (!pde->proc_ops->proc_lseek)
-				file->f_mode &= ~FMODE_LSEEK;
+		if (open)
 			rv = open(inode, file);
-		}
 		return rv;
 	}
 
-- 
2.25.1


