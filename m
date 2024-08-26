Return-Path: <linux-fsdevel+bounces-27102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8095E9D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82D41F22ABC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0B139D07;
	Mon, 26 Aug 2024 07:02:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F857CBA;
	Mon, 26 Aug 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655768; cv=none; b=FDJTRVD7Ll/7oYrrBxgaQV2gcYRQ/CAoLPJWiftr6BJw6p9PBSiuzny4bADBYtgKz16xZMgjg5Tyc4w4vb1iL/qW8jBlJmUki74IWDq7qVcEj90/pXAqpdEtmnnRg+8gTzCZndAbfpPhaPMred4o5Ukck5cc0iIQgx+RUZFRdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655768; c=relaxed/simple;
	bh=WFHhsIkRmkdGK2QWMeAh5kJ20knoPvV2uJ+PkYCQu1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHokE/xPxG/fQc80dqA0IZr3m5dhIitzRv7YWB4/LVExb/IaB/zapi+KfROc1EVkvRTT50MO3fJMDklDa8O5DMxRkoj7R/PLrU3I0Cmoim6e/GgbBvLjCn0Gp4AHnqfbiCnWJqnh1NGBUZozqtk6Db9JV6hwxYe34+uFSS9rYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WshS52JC7z14G6b;
	Mon, 26 Aug 2024 15:01:57 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id A0B5F1401F0;
	Mon, 26 Aug 2024 15:02:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 15:02:42 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>
CC: <lizetao1@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH -next 3/3] splice: Using scope-based resource instead of folio_lock/unlock
Date: Mon, 26 Aug 2024 15:10:36 +0800
Message-ID: <20240826071036.2445717-4-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826071036.2445717-1-lizetao1@huawei.com>
References: <20240826071036.2445717-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Use guard() to manage locking and unlocking a folio, thus avoiding the
use of goto unlock code. Remove the out_unlock and error label, and
return directly when an error occurs, allowing the compiler to release
the folio's lock.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/splice.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 06232d7e505f..bf976f2edfc1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -120,36 +120,25 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 				       struct pipe_buffer *buf)
 {
 	struct folio *folio = page_folio(buf->page);
-	int err;
 
 	if (!folio_test_uptodate(folio)) {
-		folio_lock(folio);
+		guard(folio)(folio);
 
 		/*
 		 * Folio got truncated/unhashed. This will cause a 0-byte
 		 * splice, if this is the first page.
 		 */
-		if (!folio->mapping) {
-			err = -ENODATA;
-			goto error;
-		}
+		if (!folio->mapping)
+			return -ENODATA;
 
 		/*
 		 * Uh oh, read-error from disk.
 		 */
-		if (!folio_test_uptodate(folio)) {
-			err = -EIO;
-			goto error;
-		}
-
-		/* Folio is ok after all, we are done */
-		folio_unlock(folio);
+		if (!folio_test_uptodate(folio))
+			return -EIO;
 	}
 
 	return 0;
-error:
-	folio_unlock(folio);
-	return err;
 }
 
 const struct pipe_buf_operations page_cache_pipe_buf_ops = {
-- 
2.34.1


