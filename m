Return-Path: <linux-fsdevel+bounces-38224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486369FDDF4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11933A171B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9796813A265;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZfDtUQ43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6F45C18
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=F6kuvC/ef/lzUMIBFQ2M0K1Un+UlGthDv5EESqgqNf6iPl6pU3BXfOxLzy13jdl6t/YTCOpDCpTFC7gUT/OS13s9Qs8ksB+Xc7Phr63dp9nKkX+uRpBgatCfgbgyj3IwKbLzxV+AzjR75DY2RikgVWRlZqZqCScSe53n/0y0LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=Bg8tWCJbATZAlNIMtJ1ZFSPHhryE384DVSKD4KLGcLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhHlBOZS0Sa7qhsDAVpr1QVZGalJ7D8Q7ZLuuPytrwYkBX5ANxBN5V3LClZkoRmFkEBLDK6/5l3oG4RBnQduGGJGcC1vL7hNf1FQwmdSAHQejFdgunkTA2hzpnfABr5idhGJAW5yF4W0wdpLPRC2ra2Mv7J7J/CSTSExyS/Ksgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZfDtUQ43; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FAA16ISYI8PslXT5GRwjXegVL1NI4FFGq34vgIacXDo=; b=ZfDtUQ431b8Y6bUQiBQAp8bIBT
	X6ob7SNqyyK68mMoq3oYPv3Xt0RYWM9VOta4kS8YWOU6zK3pbZnB4K5LOzO+D+rnJJ3woFDP1Tacc
	CJ1ITnqULDxe5iuIawDCnDNsDcjqnbEAcYBmpe3x6pS0HVzSi6wo/A7HLTDQxF2T2y1Nrb9b9hWWz
	8UCTt5nJtQGc6ua3u1aHwO1FsZ8Y2QA5bUI30/s9kl9qngSV2yXfl707qXsKLtefhJAleSygHiKEx
	CBCcqaD6R+7BUoIPN5mXWcH9nTLKXu0Hs3ZnWOe5BUW8EZ2wDnrWJLwQjin6eRpD7OHbFbembwLlp
	HcHdvq3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPQ-0000000DOis-47TC;
	Sun, 29 Dec 2024 08:12:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 14/20] xhci: don't mess with ->d_iname
Date: Sun, 29 Dec 2024 08:12:17 +0000
Message-ID: <20241229081223.3193228-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

use debugs_{creat_file,get}_aux() instead

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/host/xhci-debugfs.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 4f0c1b96e208..1f5ef174abea 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -232,16 +232,7 @@ static struct xhci_file_map ring_files[] = {
 
 static int xhci_ring_open(struct inode *inode, struct file *file)
 {
-	int			i;
-	struct xhci_file_map	*f_map;
-	const char		*file_name = file_dentry(file)->d_iname;
-
-	for (i = 0; i < ARRAY_SIZE(ring_files); i++) {
-		f_map = &ring_files[i];
-
-		if (strcmp(f_map->name, file_name) == 0)
-			break;
-	}
+	const struct xhci_file_map *f_map = debugfs_get_aux(file);
 
 	return single_open(file, f_map->show, inode->i_private);
 }
@@ -318,16 +309,7 @@ static struct xhci_file_map context_files[] = {
 
 static int xhci_context_open(struct inode *inode, struct file *file)
 {
-	int			i;
-	struct xhci_file_map	*f_map;
-	const char		*file_name = file_dentry(file)->d_iname;
-
-	for (i = 0; i < ARRAY_SIZE(context_files); i++) {
-		f_map = &context_files[i];
-
-		if (strcmp(f_map->name, file_name) == 0)
-			break;
-	}
+	const struct xhci_file_map *f_map = debugfs_get_aux(file);
 
 	return single_open(file, f_map->show, inode->i_private);
 }
@@ -410,7 +392,8 @@ static void xhci_debugfs_create_files(struct xhci_hcd *xhci,
 	int			i;
 
 	for (i = 0; i < nentries; i++)
-		debugfs_create_file(files[i].name, 0444, parent, data, fops);
+		debugfs_create_file_aux(files[i].name, 0444, parent,
+					data, &files[i], fops);
 }
 
 static struct dentry *xhci_debugfs_create_ring_dir(struct xhci_hcd *xhci,
-- 
2.39.5


