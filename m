Return-Path: <linux-fsdevel+bounces-38223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EB9FDDF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C017A11A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8D86355;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PjHV5Eg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAF3FB1B
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=GvLA2yLySvqsB3vgVKWfKj9L5BE0K3Ey8G4+o85O6ekTwEAJO3QWtlnDAW0VU9KuKiMiUuWnfesvvrLfEAnUiWQZNKCF+yA6K9zHcUJLk+e9EjO4U4iDjYiT1caHiy6ZVT/SClCmtY0ChcP1VHmG5d9yR9gW+M7Z8zHl6BWg3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=9f7G1b3GDUKJvfppkYg3lIbojQn7iGh3x/hE+vqyHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLRHdwwXmGiiKR4DWPV621WKBFv49a3hrXgB7kaZrLqiD9H2Z0DRUsTB067u5FuVN+hpjT0ysjfXN5pEn0pYlcNTPUOvVZSEdT1TJAchF20NI5ZdIbcf2moOsWw4U9117PWFz8rnUJ0hPRF8RVfZWOYY4QtuKHaLenl9w1FQYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PjHV5Eg7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Scf1r2N8FYPEmgxPnddLoDkgMGy3au/GggjO+iAp1gw=; b=PjHV5Eg71kWiFmIx4BEngPprZf
	bJuxHutpCN+hCHvawKj6tOYfkLEfFcnyNqbOHVI/mEzNuw+S0FTL5bdBk7h0G2x+y6VzvB79Halxu
	DrU5QJ7Z4OJ53RgcRYOU2sxTiFxQVcRLzSmsihoxbBYCZq37onBZkwR5d59/meYZaw9hSTIM5dR1T
	g7XqrO6thkwI1nMfqpxy+upP/Qe9mx6yzc6ORpBqklPZdInIUO1M2vxBH68bmmBTaMm74V6XWK0uF
	M9k8e4CTplW/FA6Drq+5O1EtztWsjH20L+M9gKFPzLEDL4b/AMrPjDcTh1ETvBbhDiV+m9w1A9+6E
	xKLgOrUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPQ-0000000DOig-2zLR;
	Sun, 29 Dec 2024 08:12:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 12/20] [not even compile-tested] greybus/camera - stop messing with ->d_iname
Date: Sun, 29 Dec 2024 08:12:15 +0000
Message-ID: <20241229081223.3193228-12-viro@zeniv.linux.org.uk>
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
 drivers/staging/greybus/camera.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index ca71023df447..5d80ace41d8e 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1128,18 +1128,7 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
 
 static int gb_camera_debugfs_open(struct inode *inode, struct file *file)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(gb_camera_debugfs_entries); ++i) {
-		const struct gb_camera_debugfs_entry *entry =
-			&gb_camera_debugfs_entries[i];
-
-		if (!strcmp(file->f_path.dentry->d_iname, entry->name)) {
-			file->private_data = (void *)entry;
-			break;
-		}
-	}
-
+	file->private_data = (void *)debugfs_get_aux(file);
 	return 0;
 }
 
@@ -1175,8 +1164,8 @@ static int gb_camera_debugfs_init(struct gb_camera *gcam)
 
 		gcam->debugfs.buffers[i].length = 0;
 
-		debugfs_create_file(entry->name, entry->mask,
-				    gcam->debugfs.root, gcam,
+		debugfs_create_file_aux(entry->name, entry->mask,
+				    gcam->debugfs.root, gcam, entry,
 				    &gb_camera_debugfs_ops);
 	}
 
-- 
2.39.5


