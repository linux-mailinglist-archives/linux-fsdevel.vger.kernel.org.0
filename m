Return-Path: <linux-fsdevel+bounces-38966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C763A0A793
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D2C7A3BDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1F1925A1;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OvhcTPfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736715F41F
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=qLWGQX0UPKvMzGDxkqf/GbNC7evO0UogcNaEaHjQSed7u7IF3/EfB4Tua1ZSeNHHDkDV0sovs2VHBpTMcgxIMbbV8aTPC+afky3SOY0CkRgm5rwxDx7eGsmpWd+y2nzRSjYYxIiVpOD+8zda4RbLFX7v9eVVDnTuHpV1j1hi/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=egLJDU+W5tnzsIhx0qTIWbyZCPUvMHIkYidP5U8SnRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR4E9rv8HjkAHUSqZnY1FYL0fYGuazQaohiLNVl3a7Mop79Iwietmhz7v7XRLF2NlbUToew3aSKrrQX5n06P9g2nN38LCC9m2oTSPXe2OoWuZ8/89uhZoqe4qLNWUadQzJIczhQuQBT2y8ECYwQauGQ+4mBNpG0scI8nJeff+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OvhcTPfK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EB1sCu4u+fHUikvXsHZPwN9g8QetZDIS6tgtAQGc4mA=; b=OvhcTPfKzlrF8oLJeIm6EOOdWr
	TWWJEYQVZL3car2k7xYeTyzfFRcnBDv5CWanWiKRTZYIDBk7UZd2ySxMge5/i2YXdJV4bW0w9dBgG
	wYx86bDNK2H+kPJGdBur80wcolBZvtlKyIfUQWASgH/DgQkF56zN2nf3+GeDQhZ/ypDgmmcLDx05t
	ydlF4ylN51tfzmM3//90wVZADaAfXxiHuTYAwoCkDUF++TLrp15qc/SADkGdTMEcfoCOieIJeRQhM
	/rsXUH2nJ/R7e3ivR+sUEkaxDnoZmW9PQ8QJcBwAPAjvefYJoq74PPPJxp+aoE2Rw8RrTTDzgIMQN
	Vmj2WRWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajN-0ahO;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 07/21] carl9170: stop embedding file_operations into their objects
Date: Sun, 12 Jan 2025 08:06:51 +0000
Message-ID: <20250112080705.141166-7-viro@zeniv.linux.org.uk>
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

use debugfs_get_aux() instead; switch to debugfs_short_ops as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/wireless/ath/carl9170/debug.c | 28 ++++++++++-------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
index bb40889d7c72..2d734567000a 100644
--- a/drivers/net/wireless/ath/carl9170/debug.c
+++ b/drivers/net/wireless/ath/carl9170/debug.c
@@ -54,7 +54,6 @@ struct carl9170_debugfs_fops {
 	char *(*read)(struct ar9170 *ar, char *buf, size_t bufsize,
 		      ssize_t *len);
 	ssize_t (*write)(struct ar9170 *aru, const char *buf, size_t size);
-	const struct file_operations fops;
 
 	enum carl9170_device_state req_dev_state;
 };
@@ -62,7 +61,7 @@ struct carl9170_debugfs_fops {
 static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 				     size_t count, loff_t *ppos)
 {
-	struct carl9170_debugfs_fops *dfops;
+	const struct carl9170_debugfs_fops *dfops;
 	struct ar9170 *ar;
 	char *buf = NULL, *res_buf = NULL;
 	ssize_t ret = 0;
@@ -75,8 +74,7 @@ static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 
 	if (!ar)
 		return -ENODEV;
-	dfops = container_of(debugfs_real_fops(file),
-			     struct carl9170_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 
 	if (!dfops->read)
 		return -ENOSYS;
@@ -113,7 +111,7 @@ static ssize_t carl9170_debugfs_read(struct file *file, char __user *userbuf,
 static ssize_t carl9170_debugfs_write(struct file *file,
 	const char __user *userbuf, size_t count, loff_t *ppos)
 {
-	struct carl9170_debugfs_fops *dfops;
+	const struct carl9170_debugfs_fops *dfops;
 	struct ar9170 *ar;
 	char *buf = NULL;
 	int err = 0;
@@ -128,8 +126,7 @@ static ssize_t carl9170_debugfs_write(struct file *file,
 
 	if (!ar)
 		return -ENODEV;
-	dfops = container_of(debugfs_real_fops(file),
-			     struct carl9170_debugfs_fops, fops);
+	dfops = debugfs_get_aux(file);
 
 	if (!dfops->write)
 		return -ENOSYS;
@@ -165,6 +162,11 @@ static ssize_t carl9170_debugfs_write(struct file *file,
 	return err;
 }
 
+static struct debugfs_short_fops debugfs_fops = {
+	.read	= carl9170_debugfs_read,
+	.write	= carl9170_debugfs_write,
+};
+
 #define __DEBUGFS_DECLARE_FILE(name, _read, _write, _read_bufsize,	\
 			       _attr, _dstate)				\
 static const struct carl9170_debugfs_fops carl_debugfs_##name ##_ops = {\
@@ -173,12 +175,6 @@ static const struct carl9170_debugfs_fops carl_debugfs_##name ##_ops = {\
 	.write = _write,						\
 	.attr = _attr,							\
 	.req_dev_state = _dstate,					\
-	.fops = {							\
-		.open	= simple_open,					\
-		.read	= carl9170_debugfs_read,			\
-		.write	= carl9170_debugfs_write,			\
-		.owner	= THIS_MODULE					\
-	},								\
 }
 
 #define DEBUGFS_DECLARE_FILE(name, _read, _write, _read_bufsize, _attr)	\
@@ -816,9 +812,9 @@ void carl9170_debugfs_register(struct ar9170 *ar)
 		ar->hw->wiphy->debugfsdir);
 
 #define DEBUGFS_ADD(name)						\
-	debugfs_create_file(#name, carl_debugfs_##name ##_ops.attr,	\
-			    ar->debug_dir, ar,				\
-			    &carl_debugfs_##name ## _ops.fops)
+	debugfs_create_file_aux(#name, carl_debugfs_##name ##_ops.attr,	\
+			    ar->debug_dir, ar, &carl_debugfs_##name ## _ops, \
+			    &debugfs_fops)
 
 	DEBUGFS_ADD(usb_tx_anch_urbs);
 	DEBUGFS_ADD(usb_rx_pool_urbs);
-- 
2.39.5


