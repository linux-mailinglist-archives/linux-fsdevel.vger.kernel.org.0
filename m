Return-Path: <linux-fsdevel+bounces-16255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171E89A8EF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE45282835
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B21BC46;
	Sat,  6 Apr 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gRELLE2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E45139F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379719; cv=none; b=TTm1jQZD3wKLm7UiznjSErEVtIQnYZsXZ+OtPsA14eeyl/UovYi/h+IpPdbOQoNHQk1WHmUGzRsgpLlSM9pT7/eBwKztOQ8HdH1CMF7rAHLnxnjGqOE+YxtuBQXy0KioH94/Qctw4DYrf9dwGeSeg31FpF0VjSyMM5ME1ggf2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379719; c=relaxed/simple;
	bh=xE83wQdFVgq9sPMbiOB+6Je2NyTHrE6D43OP1ArODg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YflQTHVSPbbUZAZqV1JVyJGicWpc2fx2EqVNDTn4Hrzyp+Q6Low34yETR4i/Mu2AiCXhKuODnwVjF3EoCj30k3cBWDWv7rLuS95ougGAv0JtLbH5igJTOtPyFq7aySxlFA9aT0WcaHUorLPL/pUbwJOnAOMuWq1vYetc1RFyjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gRELLE2V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CGxOdWcJAfP1o/TTxzwLgfFNxhw5fH1U5bP9qm1vJ+I=; b=gRELLE2V4PU4ZTz7PDnPiFiE43
	wkyPKXNUdYRZ98W+38AMsdHVm+SWr3mFEg6MasKN2/4kXNIH6sgbf4+AsrPfevWy3KHzBveb8w+fg
	7UIOfej2h8MAhHfRgUiiAEgW0f8kc0OAKUGdS3SJgajsbMyG2OsVoGD2qFRl1HugCZ75n+oKYY5RR
	1U7xNinAC+qB8Jgx29vFfxBrMlfnHtilRBsz06N77xXP7GJKJd/YKVBLwu3/sK6NCLebBgzrsX8jz
	RGBWdaVlGLhe1xcXZH6JoH8byGmRx6kq0eiA4bJj5QbgArbEoCx0gfV02YOXUsmRRovDjD4xHpdYF
	UCwHmubQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsyBg-006qyA-2J;
	Sat, 06 Apr 2024 05:01:56 +0000
Date: Sat, 6 Apr 2024 06:01:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 5/6] do_dentry_open(): kill inode argument
Message-ID: <20240406050156.GE1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

should've been done as soon as overlayfs stopped messing with fake
paths...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index ec287ac67e7f..89cafb572061 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -902,10 +902,10 @@ static inline int file_get_write_access(struct file *f)
 }
 
 static int do_dentry_open(struct file *f,
-			  struct inode *inode,
 			  int (*open)(struct inode *, struct file *))
 {
 	static const struct file_operations empty_fops = {};
+	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
 	path_get(&f->f_path);
@@ -1047,7 +1047,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	return do_dentry_open(file, d_backing_inode(dentry), open);
+	return do_dentry_open(file, open);
 }
 EXPORT_SYMBOL(finish_open);
 
@@ -1086,7 +1086,7 @@ EXPORT_SYMBOL(file_path);
 int vfs_open(const struct path *path, struct file *file)
 {
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(path->dentry), NULL);
+	return do_dentry_open(file, NULL);
 }
 
 struct file *dentry_open(const struct path *path, int flags,
@@ -1174,7 +1174,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 		return f;
 
 	f->f_path = *path;
-	error = do_dentry_open(f, d_inode(path->dentry), NULL);
+	error = do_dentry_open(f, NULL);
 	if (error) {
 		fput(f);
 		f = ERR_PTR(error);
-- 
2.39.2


