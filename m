Return-Path: <linux-fsdevel+bounces-51553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DAAD8335
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 08:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BBB3B5D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E4257459;
	Fri, 13 Jun 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg2qBBx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B8253958
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795842; cv=none; b=tdwrs7Dr6jhZlHHuAzqcsJTTadIOzWGL+Bfr2UCxEbj7i+3hdvKZYaOlwdsxFs3AvUCjYYS3o+T6Vbni1Rzh1MJ5V/85d1NEVNXeDrie8u05Y2KVg32fa8Z04hv1vKxMCRvNk9wC/LPxHTF8RfXSmvpqJDF4mU3LULYFCsdpOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795842; c=relaxed/simple;
	bh=ZwLyMbFgl7i2Kx2DXmciCKeqLlae832p1KK6uaUwtCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBL0ldsr+pPNuzlydLGXl1ol7DPhzzo4AlnYh8g/hl8CGfieM+A1c2vNSPWeecVJZV1vk1przYmhUJh5sc++7N5iYrZoAyEJaA4xGIyb7CJI5FePauq/sxghJT320uok+V5rP9rHB5al9yj8w2SiDhVkym6mqHO5VQ61e8R91Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg2qBBx1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749795837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0aYlKxSANiSaLWP3mh2iKPUZWQAYGC8F8HQLXkO62Pw=;
	b=hg2qBBx1ypTJXAcCs5Ymywztcg7ASaejVJZvyZZNeSWfKzOkrAfffILMCkcOHmMlOzHhx2
	skPQtJXItjDUnMBJHOI6TQ0hbYaIJFUS3DZQjKCmdPlaVd/DuEtoTgXamIkwb/zwP1RF7Q
	6/6gMKDa/EJHaarhVE0Vtf+7YHSwpI8=
From: Cixi Geng <cixi.geng@linux.dev>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhengxu.zhang@unisoc.com
Subject: [PATCH] exfat: fdatasync flag should be same like generic_write_sync()
Date: Fri, 13 Jun 2025 14:23:39 +0800
Message-ID: <20250613062339.27763-1-cixi.geng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Zhengxu Zhang <zhengxu.zhang@unisoc.com>

Test: androbench by default setting, use 64GB sdcard.
 the random write speed:
	without this patch 3.5MB/s
	with this patch 7MB/s

After patch "11a347fb6cef", the random write speed decreased significantly.
the .write_iter() interface had been modified, and check the differences with
generic_file_write_iter(), when calling generic_rite_sync() and
exfat_file_write_iter() to call vfs_fsync_range(), the fdatasync flag is wrong,
and make not use the fdatasync mode, and make random write speed decreased.

so make the fdatasync flag like generic_write_sync().

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")

Signed-off-by: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
---
 fs/exfat/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 841a5b18e3df..01d983fa7f55 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -625,7 +625,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {
 		ssize_t err = vfs_fsync_range(file, pos, iocb->ki_pos - 1,
-				iocb->ki_flags & IOCB_SYNC);
+				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
 		if (err < 0)
 			return err;
 	}
-- 
2.25.1


