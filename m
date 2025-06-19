Return-Path: <linux-fsdevel+bounces-52145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA9ADFAB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 03:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F791894DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDC191F98;
	Thu, 19 Jun 2025 01:34:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384D522A;
	Thu, 19 Jun 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296885; cv=none; b=S1He/9oHHG8/xLahHguBJFsqZmriE4rcG86WO6fauYBUA5khiIEBA/Tye727VyDp6o4FM+Hf3x3fRRPHXbnQkNRGQvYoANY8VkQZHqW9WNBycKTftnz2VLOmfiT0c4SaCY20/vJOrU7Jn8NrDnR8FKHkP4/isoXSIBngyTUutEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296885; c=relaxed/simple;
	bh=//Joiet/g7/oftnpPdU2ZxGyf8S2qcX7qLMqv22tn4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfbSc01GEAqEyqo4a9D4euyz7yiK7x/mVNCRB9AW+KfujlGUc5/1IUza3A9RHwlKIidyIUXLEnmpZsn9FZDVojHt8NWmVNLCjyPlvFaderi3QeNzDL0cT+ljvOPjk+eHtjPhZ1uuw9dJZwGUTam2IyreTq7f/rWsHEhcCDZpJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 55J1Xmu8038626;
	Thu, 19 Jun 2025 09:33:48 +0800 (+08)
	(envelope-from Zhengxu.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bN32T4wHJz2NZbXl;
	Thu, 19 Jun 2025 09:30:25 +0800 (CST)
Received: from tj06287pcu.spreadtrum.com (10.5.32.43) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 19 Jun 2025 09:33:45 +0800
From: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
To: <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>, <Yuezhang.Mo@sony.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cixi.geng@linux.dev>, <hao_hao.wang@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <zhengxu.zhang@unisoc.com>
Subject: [PATCH V2] exfat: fdatasync flag should be same like generic_write_sync()
Date: Thu, 19 Jun 2025 09:33:31 +0800
Message-ID: <20250619013331.664521-1-zhengxu.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 55J1Xmu8038626

Test: androbench by default setting, use 64GB sdcard.
 the random write speed:
	without this patch 3.5MB/s
	with this patch 7MB/s

After patch "11a347fb6cef", the random write speed decreased significantly.
the .write_iter() interface had been modified, and check the differences with
generic_file_write_iter(), when calling generic_write_sync() and
exfat_file_write_iter() to call vfs_fsync_range(), the fdatasync flag is wrong,
and make not use the fdatasync mode, and make random write speed decreased.

So use generic_write_sync() instead of vfs_fsync_range().

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")

Signed-off-by: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
---
 fs/exfat/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 841a5b18e3df..7ac5126aa4f1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -623,9 +623,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (pos > valid_size)
 		pos = valid_size;
 
-	if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {
-		ssize_t err = vfs_fsync_range(file, pos, iocb->ki_pos - 1,
-				iocb->ki_flags & IOCB_SYNC);
+	if (iocb->ki_pos > pos) {
+		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 		if (err < 0)
 			return err;
 	}
-- 
2.25.1


