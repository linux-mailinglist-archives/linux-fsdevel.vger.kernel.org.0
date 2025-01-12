Return-Path: <linux-fsdevel+bounces-38961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE2A0A78E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CECD7A35A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3FC188917;
	Sun, 12 Jan 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gPVBXs47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EB158D80
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669229; cv=none; b=LXEmjJfsEDeYLh3AIFynnv/XwG6a9dF3chQyeaKxGkIDtCp1aXMO3aoDDBGDqvvGigudm19Fyd4sRehhalujEGdHCtnFK9JAjkPyh+Su/4FNINKHww+dRGJ/Pf176d4WTjUNUf7qMwhy+tor+DuUAK2I5TB6aVxOYfjs2kQtmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669229; c=relaxed/simple;
	bh=JK156BYprlzTfk/VWFQT4xiTNeJaohRm87LmWEiEYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcmiJz8Z0er1krNmHnSTOaSohpb/YScQrUlFGK8h/T89BFSwZRSTqtObsQrrqSezgx99KkCS4NGsZbnRnfDYKZEZmO0Jeo6YPHMiuQoQtoGZH1s/49SGafJFZWqrMn+ajKLFsQHWeuGrQbPeCyEZMRFsY3OJDWm9fhRK50TMXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gPVBXs47; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r0ywoI2ffthnvDA2Ug/G++WYs0XQw5soU2IayVLcHb0=; b=gPVBXs476Hf8QqDU6Y6hX5ujiP
	if3QH6OdC93TbEBQEOaqCURKx332LLz2x1/gptrpGhvVWi0vHT8Mez/5TEMBUwRHITrh+isqwjUCO
	9EFv3rBfEHPagoCY1gxUpndOBQIQ3zH3Ru/1Bs1auHwOib+Oqzl3xovnnWUVxuxAnSNaGxiGUKSGk
	6mqASXM7fPjLBRPm0BPRaiM/tOiO+VeiotUnQSJ6bNRh3J/M/VWdl4Nk/Jn2EcEV33LEDPGDFvHLp
	vEIc502ASjqxghv2Sy4Kbz65x4GOEUtH+1y5C8w5ndiAZ3McsHjcoKqmYrtHJs7w3LZWbb1P+OPaA
	i3Xcf6Hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajT-1EJj;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 08/21] b43: stop embedding struct file_operations into their objects
Date: Sun, 12 Jan 2025 08:06:52 +0000
Message-ID: <20250112080705.141166-8-viro@zeniv.linux.org.uk>
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

Use debugfs_get_aux() instead.  And switch to debugfs_short_fops, while we
are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/wireless/broadcom/b43/debugfs.c | 27 +++++++++------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/debugfs.c b/drivers/net/wireless/broadcom/b43/debugfs.c
index efa98444e3fb..5a49970afc8c 100644
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -30,7 +30,6 @@ static struct dentry *rootdir;
 struct b43_debugfs_fops {
 	ssize_t (*read)(struct b43_wldev *dev, char *buf, size_t bufsize);
 	int (*write)(struct b43_wldev *dev, const char *buf, size_t count);
-	struct file_operations fops;
 	/* Offset of struct b43_dfs_file in struct b43_dfsentry */
 	size_t file_struct_offset;
 };
@@ -491,7 +490,7 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 				size_t count, loff_t *ppos)
 {
 	struct b43_wldev *dev;
-	struct b43_debugfs_fops *dfops;
+	const struct b43_debugfs_fops *dfops;
 	struct b43_dfs_file *dfile;
 	ssize_t ret;
 	char *buf;
@@ -511,8 +510,7 @@ static ssize_t b43_debugfs_read(struct file *file, char __user *userbuf,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
-			     struct b43_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 	if (!dfops->read) {
 		err = -ENOSYS;
 		goto out_unlock;
@@ -555,7 +553,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 				 size_t count, loff_t *ppos)
 {
 	struct b43_wldev *dev;
-	struct b43_debugfs_fops *dfops;
+	const struct b43_debugfs_fops *dfops;
 	char *buf;
 	int err = 0;
 
@@ -573,8 +571,7 @@ static ssize_t b43_debugfs_write(struct file *file,
 		goto out_unlock;
 	}
 
-	dfops = container_of(debugfs_real_fops(file),
-			     struct b43_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 	if (!dfops->write) {
 		err = -ENOSYS;
 		goto out_unlock;
@@ -602,16 +599,16 @@ static ssize_t b43_debugfs_write(struct file *file,
 }
 
 
+static struct debugfs_short_fops debugfs_ops = {
+	.read	= b43_debugfs_read,
+	.write	= b43_debugfs_write,
+	.llseek = generic_file_llseek,
+};
+
 #define B43_DEBUGFS_FOPS(name, _read, _write)			\
 	static struct b43_debugfs_fops fops_##name = {		\
 		.read	= _read,				\
 		.write	= _write,				\
-		.fops	= {					\
-			.open	= simple_open,			\
-			.read	= b43_debugfs_read,		\
-			.write	= b43_debugfs_write,		\
-			.llseek = generic_file_llseek,		\
-		},						\
 		.file_struct_offset = offsetof(struct b43_dfsentry, \
 					       file_##name),	\
 	}
@@ -703,9 +700,9 @@ void b43_debugfs_add_device(struct b43_wldev *dev)
 
 #define ADD_FILE(name, mode)	\
 	do {							\
-		debugfs_create_file(__stringify(name),		\
+		debugfs_create_file_aux(__stringify(name),	\
 				mode, e->subdir, dev,		\
-				&fops_##name.fops);		\
+				&fops_##name, &debugfs_ops);	\
 	} while (0)
 
 
-- 
2.39.5


