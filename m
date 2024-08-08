Return-Path: <linux-fsdevel+bounces-25406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CB94B966
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2DD1C20A0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E7189BA0;
	Thu,  8 Aug 2024 08:56:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34D146019;
	Thu,  8 Aug 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107393; cv=none; b=hfC1U5WmrHnRm9/u/wHsPf0iTHGSin4rBot+v5i1zp+xpCv2Qx6i53qcJvHADnH9eeTmIMBuKP0imfibfh/UWkfOvffsT1jVmcIymyzRJbc7YJcf+h3GhYQPQWqW5RTxv2Mej6hHuoZajQcWWzBNdGrkY/BBNi2CKK3v3BITJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107393; c=relaxed/simple;
	bh=X484/zw2wte9ISNoB4Kl62bgvYodOt1gYiyakp9v7K8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fkn6gMGrcF5ikzTL8VFeII/VCwfanSJLeCcYkWtU6ZKDynYjaGwpctNwgMu8OcNWvfRAeI8JopDiyf/OeFeZRHqj/xe8ut0YdLTJYqOy5sAy0u/KVulUuvgFjVyEBi+eyoKmhdMqFKKnI1NTqs0QW1kb5UqUomIcYVtFTuYl28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wfgr55WCjzyP0H;
	Thu,  8 Aug 2024 16:56:05 +0800 (CST)
Received: from kwepemf500010.china.huawei.com (unknown [7.202.181.248])
	by mail.maildlp.com (Postfix) with ESMTPS id C250F1401E0;
	Thu,  8 Aug 2024 16:56:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemf500010.china.huawei.com
 (7.202.181.248) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 16:56:26 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <krisman@kernel.org>, <linux-fsdevel@vger.kernel.org>, <hch@lst.de>
CC: <linux-kernel@vger.kernel.org>, <guoxuenan@huawei.com>,
	<guoxuenan@huaweicloud.com>, <jack.qiu@huawei.com>, <ganjie5@huawei.com>
Subject: [PATCH] unicode: get rid of obsolete 'utf8data.h'
Date: Thu, 8 Aug 2024 16:56:19 +0800
Message-ID: <20240808085619.3234977-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500010.china.huawei.com (7.202.181.248)

From: ganjie <ganjie5@huawei.com>

Commit 2b3d04787012 ("unicode: Add utf8-data module") changed
the database file from 'utf8data.h' to 'utf8data.c' to build
separate module, but it seems forgot to update README.utf8data
, which may causes confusion. Update the README.utf8data and
the default 'UTF8_NAME' in 'mkutf8data.c'

Signed-off-by: ganjie <ganjie5@huawei.com>
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 fs/unicode/README.utf8data | 8 ++++----
 fs/unicode/mkutf8data.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/unicode/README.utf8data b/fs/unicode/README.utf8data
index c73786807d3b..f75567e28138 100644
--- a/fs/unicode/README.utf8data
+++ b/fs/unicode/README.utf8data
@@ -1,4 +1,4 @@
-The utf8data.h file in this directory is generated from the Unicode
+The utf8data.c file in this directory is generated from the Unicode
 Character Database for version 12.1.0 of the Unicode standard.
 
 The full set of files can be found here:
@@ -45,13 +45,13 @@ Then, build under fs/unicode/ with REGENERATE_UTF8DATA=1:
 
 	make REGENERATE_UTF8DATA=1 fs/unicode/
 
-After sanity checking the newly generated utf8data.h file (the
+After sanity checking the newly generated utf8data.c file (the
 version generated from the 12.1.0 UCD should be 4,109 lines long, and
 have a total size of 324k) and/or comparing it with the older version
-of utf8data.h_shipped, rename it to utf8data.h_shipped.
+of utf8data.c_shipped, rename it to utf8data.c_shipped.
 
 If you are a kernel developer updating to a newer version of the
 Unicode Character Database, please update this README.utf8data file
 with the version of the UCD that was used, the md5sum and sha1sums of
-the *.txt files, before checking in the new versions of the utf8data.h
+the *.txt files, before checking in the new versions of the utf8data.c
 and README.utf8data files.
diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index 77b685db8275..fbcd97fe68b7 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -36,7 +36,7 @@
 #define FOLD_NAME	"CaseFolding.txt"
 #define NORM_NAME	"NormalizationCorrections.txt"
 #define TEST_NAME	"NormalizationTest.txt"
-#define UTF8_NAME	"utf8data.h"
+#define UTF8_NAME	"utf8data.c"
 
 const char	*age_name  = AGE_NAME;
 const char	*ccc_name  = CCC_NAME;
-- 
2.34.3


