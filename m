Return-Path: <linux-fsdevel+bounces-38967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43FBA0A794
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A7F7A3C9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FFF192B76;
	Sun, 12 Jan 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ae0Oc891"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35016C850
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669230; cv=none; b=niQov2jLCkLY5St/hnZLat5h+bo/cVGsH31sNNd2DXSnpD+RpYyPWrSsOoa/A6CJRr97t2eIOqTu3XKDyEK/QB8Q1DSvdtU1TiSA2zuYyozwkchX7u0bITvKaYwj+wm/DVeknub4iwF0JH7GY7Mt9SYciUZdThDyWuxmLQd1/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669230; c=relaxed/simple;
	bh=9f7G1b3GDUKJvfppkYg3lIbojQn7iGh3x/hE+vqyHFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNXECLP1gYgzR11b26hC92rVp6f+5PCkxvGal3somJtDWwm/GSXS8+7Z6tdzKfie5IYiAfnsxT9EomQ4chuEBO2cnQ3R7z5pCCprH7KDqhSCgjgiZWRpXleaT++yAgq8QjxziF1rhDWc52Z9K5sEcHLrWTjiV2G5nSFk/jldMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ae0Oc891; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Scf1r2N8FYPEmgxPnddLoDkgMGy3au/GggjO+iAp1gw=; b=ae0Oc891AkzG7SwdwZLoS8LgOh
	ARJd9Onke1Y8jRViK6QbnlpZMTToEzeTk22hDEwxGf2shRpMTw+Y8SiysXEIVs0VCNARPDUtIKUFF
	Jce+7tx7NiLkM3C8bC+nh+pN+fF2/XFjHpaaKhdib1sdbc+OH9wY2CtNkFDOT9U8V5kBvJ+/3cHqq
	/k/NKYApLtz/tdKT291VSCBkZy+p4AE1qNqYjdS1d970EH/x7Weit7bwn+trJejwzl95q7tWTeGGg
	BDu6BYhSDWE4JWr8M+5LhQ1tCQket1kcVxs0NyvIuQtF40dZSnoJ+W4OO3EYt+w0LnJq9C1JiUGCi
	H21BxoZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajo-3Tyl;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 12/21] [not even compile-tested] greybus/camera - stop messing with ->d_iname
Date: Sun, 12 Jan 2025 08:06:56 +0000
Message-ID: <20250112080705.141166-12-viro@zeniv.linux.org.uk>
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


