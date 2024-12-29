Return-Path: <linux-fsdevel+bounces-38226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39799FDDF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1811B3A1700
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7213AA35;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N1b/df19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8835948
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=MT+hlrjhFvY3iKO2VaHoTMo7nF5drqlPjlviueWpUmqAyrAKH12UFkT+O/0LZTmw1JmvVFMG9RnPwYJEaavUqbZKjeOY9/H09C34MPuCvOknFwKzA/SVp932d3lU23/7rnHOx4GiuyJRIB4+p8nDD4ZdCJcb0kXbsURAralDy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=egLJDU+W5tnzsIhx0qTIWbyZCPUvMHIkYidP5U8SnRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1Oxf3fXzvkMJYLHbH36vvw7V4yYHlHld+x/74gqq/sftGVxIOg7h2Mmic7jvmX2NympC4S4bD8gdN+8oaSzNL/R81qc4J2I6CrbAtESpSsgz/6IXzaPAGSl143NlPOhQzO8QgamcocJ/sXpY4Do7Pa46f32PruhnG7JPNS4gqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N1b/df19; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EB1sCu4u+fHUikvXsHZPwN9g8QetZDIS6tgtAQGc4mA=; b=N1b/df19AHTP2OCHx0iE+xnnmV
	2bnRxHKABlUQLdhfQjgQlFFZKwhGStO9sWzZBCC77MD53eDzMWUZz+5SRXt4cOZxaN/sfggFCrVxm
	UJ/GrK+j+s7nFbQEkKjoDlUCaYoR25SQvRzSqgjOG4tLvvlpgzL5BRxJf2YlgiNHjAFCvTc3YxQ1b
	Dg6msYTBc5DIQFNkmPJRXl8uc1tgG7W++3XtPB/XANKciB5fph0KXPraRnag5J6oxUcBhSPOCaLcD
	AYPCIchy2HYduSgbVf2r+awLw/SPAjp+pWizHH8v25xnDvIck7rvdIzFW6PC6KUoGw724PysP2EnG
	MhgCUWHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPQ-0000000DOiG-0d1A;
	Sun, 29 Dec 2024 08:12:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 07/20] carl9170: stop embedding file_operations into their objects
Date: Sun, 29 Dec 2024 08:12:10 +0000
Message-ID: <20241229081223.3193228-7-viro@zeniv.linux.org.uk>
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


