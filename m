Return-Path: <linux-fsdevel+bounces-53732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6BAF63F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E71C44798
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8D23C50F;
	Wed,  2 Jul 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nwTpW0DE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0D230268
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491579; cv=none; b=FAtqiHOdxlOXnIT6Gc1NbiuIInXtHaourGzq967Qa7h/Y5jwTTn+02kwRIAKPMvBeipLl/6SVdcsuxO8hxaFhPnYVsEKOvOsVEEH3UTfW8BQIh+GFqpvmyDITsY/KCxIcPntY1i3FTQcoWLJ/hGRMfH6OXwI+OJy0qezPLGHlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491579; c=relaxed/simple;
	bh=nnwl8LwaDXnCcdfj5tlLevD0OVUgssNqTtlLhbnnr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeCFZ9DHGGlg0AKSEi0ropyHqd99945LzzyXd3odhSd/B9OvnatdHHa/Jy4it1KHanqd2B+dVu7s/BmDYJfNoDBbMVT8C70iVfpWraawbsvznWefZxWbih22gUUyO0tjaci3LQSgaJ+HpRmmAFy8UsPR3E1k3Og+WLc9SnSqoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nwTpW0DE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z6ubDD8gTwN9kZsIwtiFHEKAmsRRJCaJuDE/i05tWcY=; b=nwTpW0DEJtUz3mTNIHEHPZO5O0
	HNzKZxNnqmWMb9be79lt7r3083j26zAPWtNup34D2sOYtbhiUDiwPLbiaDXUiP0GpYQZrVb++46vf
	xjQSAoOrl2c8bCqRjT+eY01N+jEhLqIFIES/GUlPm1RCbVzds4wqYOr4Hg56y0N8G+0P5tFVMrL4d
	Wh0FdIGo4no86wCdYje/sWE/wEiSlvBwftIk+AA4zOiClqIW014U1Qas6KJEAqgtkdyertan4CJgX
	nA8d9H0S8xWHq8lIdpxb7gceVASQQTBX3Nomj9G+OZZjcIy5UaXruF56ne/8mxrYwqlCozNLfmDuA
	y2qXjTGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4y8-0000000EOeM-1uNx;
	Wed, 02 Jul 2025 21:26:16 +0000
Date: Wed, 2 Jul 2025 22:26:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] debugfs_get_aux(): allow storing non-const void *
Message-ID: <20250702212616.GI3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

typechecking is up to users, anyway...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/greybus/camera.c | 2 +-
 fs/debugfs/file.c                | 2 +-
 fs/debugfs/inode.c               | 2 +-
 fs/debugfs/internal.h            | 2 +-
 include/linux/debugfs.h          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index ec9fddfc0b14..5ac19c0055d9 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1128,7 +1128,7 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
 
 static int gb_camera_debugfs_open(struct inode *inode, struct file *file)
 {
-	file->private_data = (void *)debugfs_get_aux(file);
+	file->private_data = debugfs_get_aux(file);
 	return 0;
 }
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 77784091a10f..3ec3324c2060 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -47,7 +47,7 @@ const struct file_operations debugfs_noop_file_operations = {
 
 #define F_DENTRY(filp) ((filp)->f_path.dentry)
 
-const void *debugfs_get_aux(const struct file *file)
+void *debugfs_get_aux(const struct file *file)
 {
 	return DEBUGFS_I(file_inode(file))->aux;
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 30c4944e1862..43e5d1bf1f32 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -459,7 +459,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 		proxy_fops = &debugfs_noop_file_operations;
 	inode->i_fop = proxy_fops;
 	DEBUGFS_I(inode)->raw = real_fops;
-	DEBUGFS_I(inode)->aux = aux;
+	DEBUGFS_I(inode)->aux = (void *)aux;
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 93483fe84425..427987f81571 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -19,7 +19,7 @@ struct debugfs_inode_info {
 		const struct debugfs_short_fops *short_fops;
 		debugfs_automount_t automount;
 	};
-	const void *aux;
+	void *aux;
 };
 
 static inline struct debugfs_inode_info *DEBUGFS_I(struct inode *inode)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index a420152105d0..7cecda29447e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -162,7 +162,7 @@ void debugfs_remove(struct dentry *dentry);
 
 void debugfs_lookup_and_remove(const char *name, struct dentry *parent);
 
-const void *debugfs_get_aux(const struct file *file);
+void *debugfs_get_aux(const struct file *file);
 
 int debugfs_file_get(struct dentry *dentry);
 void debugfs_file_put(struct dentry *dentry);
-- 
2.39.5


