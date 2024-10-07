Return-Path: <linux-fsdevel+bounces-31228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E499353A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A3284938
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72DD1DDA28;
	Mon,  7 Oct 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tHs98kmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60321DDA10
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323042; cv=none; b=iftxD7by/z3zRjyc5OCRtOZcCYUv7UWB+18Xjfq8qQ/L5ayy4OOD3iWqRSJlhydSoYv967SuGCkzaPze8V7VOqNttz5aia2NRPnXnlswmfdKr0XDvpZ5GpWFBQTWgeiJ774CPDBQcMZKSh5iiWYmpix31YxMEQ/YPp3jPwJVe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323042; c=relaxed/simple;
	bh=wnJ1LerM6OzPvLG1Xt8NhbQxIJT+hDtcLGCyD1A81Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbvLy6uKuRMLKD25dsIhM0tSw3z/W1MgFA4lfi5Uz3Hf25E398k29erYcFz69w5asDd3nk3k8Hpzvhg6/ebyrFYJ/x5zHTZ5kluRWni9xeZN4DPMBSv9ZdKaoiFVYI3NAPGSDJpMZb6/k9r4YQzE1nOYDeKmPaAGD1jLRMD0zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tHs98kmX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i9r67qFr9ByX1Zer0IbWv7UHx8b7XKV17uQ+vKA0iGQ=; b=tHs98kmX1NR7H4KpCqOkLLMAzd
	ql/tOQRNetVr42KnDaWdUFr3Zof11DlmZHXQYa3yHQUW/8mnCh0agWLDUWoB7ghsGyxtscJ99qpzL
	HZ+6WnbErJE37526GD1u6ac61nHvjvXBY5ezGIsbOorJPBgMandBiFZlnrK5eteVQRuUSUmNBxook
	Y18PLwOL47elQJG+4Plo2JVjWVCACUjd01d5FW5YzZr5obInPVqA4XJlqt52B5QCEUqlFaLmP1Nt8
	yYninlyHSwzwDVhHuTrnftRJNQUMXrin1M8aQ05Dq0FGSr55pT0IY++X9i2UPH4u1NCds0Zj/SGeo
	N7cpcV0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3P-1KMG;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 06/11] fs/file.c: conditionally clear full_fds
Date: Mon,  7 Oct 2024 18:43:53 +0100
Message-ID: <20241007174358.396114-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Ma <yu.ma@intel.com>

64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
likely that a bit in full_fds_bits has been cleared before in
__clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
("vfs: conditionally clear close-on-exec flag") for a similar optimization.
take stock kernel with patch 1 as baseline, it improves pts/blogbench-1.1.0
read for 13%, and write for 5% on Intel ICX 160 cores configuration with
v6.10-rc7.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
Link: https://lore.kernel.org/r/20240717145018.3972922-3-yu.ma@intel.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 90b8aa2378cc..36c5089812f5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -264,7 +264,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__clear_bit(fd, fdt->open_fds);
-	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
+	fd /= BITS_PER_LONG;
+	if (test_bit(fd, fdt->full_fds_bits))
+		__clear_bit(fd, fdt->full_fds_bits);
 }
 
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
-- 
2.39.5


