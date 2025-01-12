Return-Path: <linux-fsdevel+bounces-38968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E699A0A795
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B747A3E2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32633192B86;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VLyikuIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997571714B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=kYExSeyFwa2ZbBNRs1miGx6uVPiv3kGLsrxhZ6Rff0lTkUYy09MHXxzW4awSHmnPng1mJBfoyMd3hH1Xvy8Baue7EPTQJKJRcPsW/LLJZMh0kxI/2P5MepcX7LWqkt3SDDPRhMIF0w1i0nxS0SxjDO2EPZbDlzHUoP+0Ok4b3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=Bg8tWCJbATZAlNIMtJ1ZFSPHhryE384DVSKD4KLGcLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHrjOgIWR1ROWpiW5fYB28DhO8MmCKbshYzCk+steRqDJ9nMZ0PJt9oUtOvYXm9eHyBWho9TBAkSLgntisegQz4drdMn2DnQYeUR53h/sha7XVGPjvYVw01j6tEfr4BPBK1tE2jbNTgoNnstK0Awg47RjG7HRo8SWPPMq1f8cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VLyikuIv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FAA16ISYI8PslXT5GRwjXegVL1NI4FFGq34vgIacXDo=; b=VLyikuIvMAG6njgMqin8DwjmM7
	SFHzJRZO3q0Zh45qLHidnvDJm68HIyul257LmY1AmRLPZptmetXkI8xYKpcZmq0+eF3sf7UXxpgIg
	XL02mDx8sl9svldt0yEETvQa2OypYxzRPjofHjUpw1rLMNDedECCY1LPzYAoUb8u2bASIyaiSkhb+
	K0KQtXMbiw/fbMi1/C7ZlTXhufH33Uvo8nGspDVK5+7Fv3gjY08JmQA2unXsDkzZeSshhyxAOLqiL
	fCeM8cg8OiovaEbBC0gmU49cGMnqH6Y98VpuUu28eM++8JG3yOZtZzf3Muo1gNbjMyE5+y+TR0LLD
	iX9z/1QA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszz-00000000ajy-0FLh;
	Sun, 12 Jan 2025 08:07:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 14/21] xhci: don't mess with ->d_iname
Date: Sun, 12 Jan 2025 08:06:58 +0000
Message-ID: <20250112080705.141166-14-viro@zeniv.linux.org.uk>
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


