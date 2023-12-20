Return-Path: <linux-fsdevel+bounces-6567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDD819829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0057DB22558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D42FBE3;
	Wed, 20 Dec 2023 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IADMORZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E9FBE0;
	Wed, 20 Dec 2023 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XdcwRFuxJFKq99IE3tvSnvlBhdDly6BThkl5nosSsP4=; b=IADMORZI+3lPwbJ29d1FsZ6Hzy
	8H62qO0PEl4st+u+VG4QfRfPe301F+2UnxunF7WdKlxdBxvBc5dp4aUs3Wk9SRko9QxbHSa1heIWU
	oAJlt31VOn6lgJrHutdTuDx6eJ5zy8qdCkr3fiCEIuzwB1GlatOj6bRoBvGdN5pvEwokTE/8Mf1t7
	UyF5OFwBEEMxh4Gak6n505r8MxeidZVf9GRG8bZ4qpkpGJKDrJ17N4LSLJIfbnbBF6M2YXGIXsMu6
	aQZSNBJr/xeUcBUNiqCCqKfd2xOXL72hyJ6QoE3HtPU0wTcpsnFtKYXFNEjoz3xZTh+x/8m4ibkF3
	dyjKem5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpBV-00HJfX-0X;
	Wed, 20 Dec 2023 05:31:57 +0000
Date: Wed, 20 Dec 2023 05:31:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gfs2@lists.linux.dev
Subject: [PATCH 20/22] gfs2: use is_subdir()
Message-ID: <20231220053157.GS1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... instead of reimplementing it with misguiding name (is_ancestor(x, y)
would normally imply "x is an ancestor of y", not the other way round).
With races, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/super.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index d21c04a22d73..b5c75c8a8d62 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1065,16 +1065,6 @@ static int gfs2_drop_inode(struct inode *inode)
 	return generic_drop_inode(inode);
 }
 
-static int is_ancestor(const struct dentry *d1, const struct dentry *d2)
-{
-	do {
-		if (d1 == d2)
-			return 1;
-		d1 = d1->d_parent;
-	} while (!IS_ROOT(d1));
-	return 0;
-}
-
 /**
  * gfs2_show_options - Show mount options for /proc/mounts
  * @s: seq_file structure
@@ -1096,7 +1086,7 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	statfs_slow = sdp->sd_tune.gt_statfs_slow;
 	spin_unlock(&sdp->sd_tune.gt_spin);
 
-	if (is_ancestor(root, sdp->sd_master_dir))
+	if (is_subdir(root, sdp->sd_master_dir))
 		seq_puts(s, ",meta");
 	if (args->ar_lockproto[0])
 		seq_show_option(s, "lockproto", args->ar_lockproto);
-- 
2.39.2


