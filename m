Return-Path: <linux-fsdevel+bounces-38974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B3A0A79A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10F81886B23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70618C018;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="heMyb3AB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF7183CBB
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669231; cv=none; b=k5e2i+vABF7GrruUZCrpr2du9vothU4uESO5SrWy9LlduVFu28OHtNCw71ooneyGY038IkSXSjKOQNvWcEU5hLqV4o9jT0APU8Rp8mUjFWxlx4orr1z5pFxpADFZot+v1jbyPScw+Lzmhd/3mwKj9ya6dwMMi+DOHVDeuiQuIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669231; c=relaxed/simple;
	bh=O+8WPrkfFoSnTviqVrzh1eAD7CIvRV4hMaQy/uzlAEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkYk0BNN1Ctb8UMsaA96YRUetYG3JWo9Ydc0i4M9ISszw1gPQJsSFEYHfroLG6F0dhdhB5qOSVegVQWqoejXIuth5iJG3gpTya26CPtyMbbtjJMJ2d11JD/hoTfz5ORR4CijAKOLcmy+gyB6E6gPze0abN4Hyw/Ctb1lB6HSmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=heMyb3AB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tEN/Qf8ajQ3USfUv3eyeDI3cmE8P8L3gWC47sma/Bzs=; b=heMyb3ABvaQsh2vvXN6PNDJfvK
	ZWV9eMdOFef1axeNLakQHCYV9kI4WVxrREO2AXzs/geZYzEeqhRkQMTtQQi2L+VNOvZXFZOTQEYq8
	lcWwjm0JwKaC+bnV/WVinqIf0BeI0+aDk40u9xRrRhqgwtvhR8Mh46f0402CcING84n+CSk4iKZKP
	aiYzDQ+eOr1Z9fpfBARCMSTAPyJrQGam+SuseOF0ZNKRRSch46IyWGQMlvpDHVvSS2q/oc9DwIvGv
	Ocq3S5HgZYX8nJmnJQ0l8VYSvShQsJo3z/0zJbYJ0tYM8NF3ftZgY+POAI1xeu+BKTxpn5WA5gn41
	68B+NF+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000akT-3Hbh;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 20/21] orangefs-debugfs: don't mess with ->d_name
Date: Sun, 12 Jan 2025 08:07:04 +0000
Message-ID: <20250112080705.141166-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/orangefs/orangefs-debugfs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..9729f071c5aa 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -206,8 +206,8 @@ static void orangefs_kernel_debug_init(void)
 		pr_info("%s: overflow 1!\n", __func__);
 	}
 
-	debugfs_create_file(ORANGEFS_KMOD_DEBUG_FILE, 0444, debug_dir, k_buffer,
-			    &kernel_debug_fops);
+	debugfs_create_file_aux_num(ORANGEFS_KMOD_DEBUG_FILE, 0444, debug_dir, k_buffer,
+			    0, &kernel_debug_fops);
 }
 
 
@@ -306,11 +306,10 @@ static void orangefs_client_debug_init(void)
 		pr_info("%s: overflow! 2\n", __func__);
 	}
 
-	client_debug_dentry = debugfs_create_file(ORANGEFS_CLIENT_DEBUG_FILE,
-						  0444,
-						  debug_dir,
-						  c_buffer,
-						  &kernel_debug_fops);
+	client_debug_dentry = debugfs_create_file_aux_num(
+					  ORANGEFS_CLIENT_DEBUG_FILE,
+					  0444, debug_dir, c_buffer, 1,
+					  &kernel_debug_fops);
 }
 
 /* open ORANGEFS_KMOD_DEBUG_FILE or ORANGEFS_CLIENT_DEBUG_FILE.*/
@@ -418,8 +417,7 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * A service operation is required to set a new client-side
 	 * debug mask.
 	 */
-	if (!strcmp(file->f_path.dentry->d_name.name,
-		    ORANGEFS_KMOD_DEBUG_FILE)) {
+	if (!debugfs_get_aux_num(file)) {	// kernel-debug
 		debug_string_to_mask(buf, &orangefs_gossip_debug_mask, 0);
 		debug_mask_to_string(&orangefs_gossip_debug_mask, 0);
 		debug_string = kernel_debug_string;
-- 
2.39.5


