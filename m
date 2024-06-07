Return-Path: <linux-fsdevel+bounces-21177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C3900332
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC61B22483
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35885194128;
	Fri,  7 Jun 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="CIoVlQ5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87A19308B;
	Fri,  7 Jun 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762577; cv=none; b=JFj63ht9wmt98L35DUY/KokyRpJJoADSKVTJZ/oPx5VcXP1dBzQVd67yMSTzH63DFG15UBnwEfyMirtIqpiGMv2s1hkvzZxuL4jZj5/f4qLgcJwlPSSvFQBOwLSVU7wIj0FIXWnWteKjRTr+cce+mbRKL0iBK4YVyNlGn/YAAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762577; c=relaxed/simple;
	bh=lv2mztteK+Og30mLyHgcvpRF65hdo9t8lchl0OiTG0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUts1vDjs7tsmtXvOeQbj9m/ZhB5X0PmFj5iAPFMZAUoKISp41MqeH8e5MmOY7atO5ZZNGKzZuSJkkreV0biJIgKI+KDzO60o56U8vbvLJiTo518+ackKxfYYER95BGycbYdf1gz6Lo3vxsO/V/kWHHSwjje8uw5ivV4ZU/yy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=CIoVlQ5S; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 594F52119;
	Fri,  7 Jun 2024 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762100;
	bh=ELH+G0Zm1pE88bJbUOfJO5YDVH2GIcvzQWiyltb4lKk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CIoVlQ5SWv62BE94OkmrDIbLfXCdcbiJI9TEf+/hfPr0wUZcYgpBKUed03WbSe7uY
	 jFeGpdlcLZWIFfW13lmnWkQBPZNlQNm6Jg5ift76cCmcG94WJo/K31hqPw80sAyR3Y
	 7SBkBiyByXbDFIXlSEyRuWV9fyO4dmYY7ejV6C1M=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:13 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 08/18] fs/ntfs3: Fix attr_insert_range at end of file
Date: Fri, 7 Jun 2024 15:15:38 +0300
Message-ID: <20240607121548.18818-9-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

If the offset is equal to or greater than the end of
file, an error is returned. For such operations (i.e., inserting
a hole at the end of file), ftruncate(2) should be used.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0d13da5523b1..68d1c61fe3b5 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2373,8 +2373,13 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		mask = (sbi->cluster_size << attr_b->nres.c_unit) - 1;
 	}
 
-	if (vbo > data_size) {
-		/* Insert range after the file size is not allowed. */
+	if (vbo >= data_size) {
+		/*
+		 * Insert range after the file size is not allowed.
+		 * If the offset is equal to or greater than the end of
+		 * file, an error is returned.  For such operations (i.e., inserting
+		 * a hole at the end of file), ftruncate(2) should be used.
+		 */
 		return -EINVAL;
 	}
 
-- 
2.34.1


