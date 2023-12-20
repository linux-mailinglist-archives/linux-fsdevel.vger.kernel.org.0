Return-Path: <linux-fsdevel+bounces-6550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE2D819802
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71543285765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1F1173D;
	Wed, 20 Dec 2023 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Y2vTe1tD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6F11715
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MsN7mdifMIkNNxSN2uZM3fK+ue2whEnwIYaU5Z/NpkE=; b=Y2vTe1tDcRH940KeCZOJdUm2YJ
	uITizmgdZ04+eBpe762yofA9kfaD14q/Iy5lbqVIVaLbCb0VZqUIII8Hi+wl1CoTtrvGJOxDqVZcY
	E5KDI8U+bDE81obrINM++EqVUKRi4ZzBgN04gdp9fw2L//MLI6a/VMtKqsdvFnQX6ejVNJb4HE1g6
	5y+y8f5VcafkPeNQCjXpWWpO1EC8xv+6UiSIwRU7/8IJ6StcblvZhswzrguMBN22NE6388YE3ubgo
	alAsNxh5Tr1/yBX2I8N+TwHoanpxkKODhxgo3terjhPPsE2DXvxYc7UmVIVjn7NMgQQlbD6GU7rBI
	ditUdm6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFoxc-00HIaX-2Y;
	Wed, 20 Dec 2023 05:17:37 +0000
Date: Wed, 20 Dec 2023 05:17:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 03/22] zonefs: d_splice_alias() will do the right thing on
 ERR_PTR() inode
Message-ID: <20231220051736.GB1674809@ZenIV>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/zonefs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e6a75401677d..93971742613a 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -747,8 +747,6 @@ static struct dentry *zonefs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = zonefs_get_dir_inode(dir, dentry);
 	else
 		inode = zonefs_get_file_inode(dir, dentry);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
 
 	return d_splice_alias(inode, dentry);
 }
-- 
2.39.2


