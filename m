Return-Path: <linux-fsdevel+bounces-26800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B595BB3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53104285563
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42311CCEF0;
	Thu, 22 Aug 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="j/7vvXwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026A1CCB32;
	Thu, 22 Aug 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342491; cv=none; b=dJUwiPXhMGjus0mYjD9hcDucSwygr5mfJdWd3UGAfX5tR8wzhdzYQg+KglcmQJvMJidgbSRys0FLl36Gc4hNHElqv3MUWq9oBZoOrhJoVp94fLJdY4nE6VPldXaYbBxQQ/EfioqMZyvAATKPxDoTJY5IXUoZu3ez0Mm3ZNElrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342491; c=relaxed/simple;
	bh=jhGgSWlsOINinW6OKYvkHOYamahf8RJY1u03LuhU/Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwUmfmfK71qE4GlN3/wVE53HIoMsm8xz4B5aMgB2Nzp6DeUEPb3lJ/n4/c7DoJKwYGcO0NneIpdLQE9H0wwnqswUklyTAu5TDz/Qr8a5Pr/xwjmWm98SDMIYuW1FNuAS4WYNrUeqUd8LdaovvK/UUQIbnIj/50rAsimtK7geBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=j/7vvXwq; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0DF6D21D5;
	Thu, 22 Aug 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341463;
	bh=Rar5YH7T22or8MvvrNAu6mQ2DarHjRaTR7Yesq9p70Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=j/7vvXwqiq33nLlbgpM6RVLC2eoadbPEc+JIGbf1OSzUhj/a1/LFzysQOCwOTHZpS
	 xbHtPGuy3b8y+WzWt8UGVqJ3tC2SCPsz77w7rgBuTye0S3hSrHXNmHC9l7EkiYM2mS
	 +Se7kxxN2zSJ7EiPEP1NWrr918FHIJN5xc2paDUE=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:18 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 01/14] fs/ntfs3: Do not call file_modified if collapse range failed
Date: Thu, 22 Aug 2024 18:51:54 +0300
Message-ID: <20240822155207.600355-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
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

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index ca1ddc46bd86..cddc51f9a93b 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -484,7 +484,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 }
 
 /*
- * ntfs_fallocate
+ * ntfs_fallocate - file_operations::ntfs_fallocate
  *
  * Preallocate space for a file. This implements ntfs's fallocate file
  * operation, which gets called from sys_fallocate system call. User
@@ -619,6 +619,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_collapse_range(ni, vbo, len);
 		ni_unlock(ni);
+		if (err)
+			goto out;
 	} else if (mode & FALLOC_FL_INSERT_RANGE) {
 		/* Check new size. */
 		err = inode_newsize_ok(inode, new_size);
-- 
2.34.1


