Return-Path: <linux-fsdevel+bounces-38231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD09FDDFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDF71882751
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BA14A60F;
	Sun, 29 Dec 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IfAnh+hL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C85674D
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459949; cv=none; b=HpK7Va1aNAlI7d9CMHNVylT9i7HmzGM2f2Yju3W86M+sUoCTBO9ezFtDFH0txMhwbb7Elbfq4gPxsaXS/dCx9kD6vr6QK2RSuFHm3ap1Q283Jc0xhaNy9maC3YUDfNbAYnKs0uIMmMrKWwsPOgHv2tH2GAbwWtdHyN1f2xpnJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459949; c=relaxed/simple;
	bh=0ir4IMnWCsMN4lYkM8N2IHFT6A62V7rx+lso6Z2bObg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaIGC/q8fFUG0+LQb6rzgolYCLdNttzSrKClue537qIqxShrZxqm9poeCOPqol6K+IVxVa1U5zf/1Pz7ENFcjy9W2cB1YDnKUra1XKNcpnzxm/AJhTQJj4yZqro2XYobVeJx39F53Z65mChVnUsv8MI/re08m7jgbq6lfzDnwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IfAnh+hL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G9ukzfpCE150CcVUCbc04iOJl0I8o/jYsdfs7Zf+ai4=; b=IfAnh+hL32dD090tezpSz0VWgd
	Fx77SWYanWelPflnsPv0/etbsWkxGpaNXp00QgPAHaKYI3ykthxOonIs3ZxmUTcHRr+/D/SfAzQVC
	WHkm7FPF9zcHWNZ+mCu5TnGg1bUwAH3jH56H9LiZcGTBreUVJhfeF4CWwDnn/6mcLPOVA1z3D1v/l
	dDWV9t0306OK9VS4JQ6GE6UAdj8S52JXM2Wf+eUmMbb6GlnWs7ocE2wD3XPqFYLdozCeATFH7Q1Wu
	CC/WNVRchOOCI7I7AJlCgBlsviTmh8bt3AZlKhtWl/WMMmgBC9vASUMDFglkCA1U/dj4snqJfLmkg
	wIoHIo3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPR-0000000DOjE-3655;
	Sun, 29 Dec 2024 08:12:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 18/20] arm_scmi: don't mess with ->d_parent->d_name
Date: Sun, 29 Dec 2024 08:12:21 +0000
Message-ID: <20241229081223.3193228-18-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/firmware/arm_scmi/raw_mode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 9e89a6a763da..7cc0d616b8de 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -886,10 +886,8 @@ static __poll_t scmi_dbg_raw_mode_message_poll(struct file *filp,
 
 static int scmi_dbg_raw_mode_open(struct inode *inode, struct file *filp)
 {
-	u8 id;
 	struct scmi_raw_mode_info *raw;
 	struct scmi_dbg_raw_data *rd;
-	const char *id_str = filp->f_path.dentry->d_parent->d_name.name;
 
 	if (!inode->i_private)
 		return -ENODEV;
@@ -915,8 +913,8 @@ static int scmi_dbg_raw_mode_open(struct inode *inode, struct file *filp)
 	}
 
 	/* Grab channel ID from debugfs entry naming if any */
-	if (!kstrtou8(id_str, 16, &id))
-		rd->chan_id = id;
+	/* not set - reassing 0 we already had after kzalloc() */
+	rd->chan_id = debugfs_get_aux_num(filp);
 
 	rd->raw = raw;
 	filp->private_data = rd;
@@ -1225,10 +1223,12 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			snprintf(cdir, 8, "0x%02X", channels[i]);
 			chd = debugfs_create_dir(cdir, top_chans);
 
-			debugfs_create_file("message", 0600, chd, raw,
+			debugfs_create_file_aux_num("message", 0600, chd,
+					    raw, channels[i],
 					    &scmi_dbg_raw_mode_message_fops);
 
-			debugfs_create_file("message_async", 0600, chd, raw,
+			debugfs_create_file_aux_num("message_async", 0600, chd,
+					    raw, channels[i],
 					    &scmi_dbg_raw_mode_message_async_fops);
 		}
 	}
-- 
2.39.5


