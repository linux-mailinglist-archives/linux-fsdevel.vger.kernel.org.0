Return-Path: <linux-fsdevel+bounces-6548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B591C8197FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F961C24A82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B8134C9;
	Wed, 20 Dec 2023 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VfndUN7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190D11CBA
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EgM2mQaY0aQjWB70iwIkzzbiktHBx51K37kw/owBbgg=; b=VfndUN7CzBZVi+0uZwVX2Q31ck
	GL6yQq1gyS9vYrLB04ZZZ1fRzYBsuabY/WlhhhLLVFOYZhX6pezGjFCe/F918/T+twkCxAOvfCG1D
	1WVFpdU9vMtxUm9yJLKYZoNDVzRYoGMSG+0aW05UhlT0hzEMdMoLLSJZSsxJAGi4Iz5udJ4E0swfA
	UNm2wXIsl24TmNCZKZO7Ze+ejRquRWVtBCIjk/2VxHYgKrGdoTgxZNkjaOjU2a2zJswJQdaYoyspE
	MUDkWRPnms7gVwkUUtUFf3KH6CwcTpDUSMyselUNmt6Iz9evL1BmVHY6C0LSXEtOBpeyB0psPTJrJ
	/zTdI8pw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFovb-00HISt-32;
	Wed, 20 Dec 2023 05:15:32 +0000
Date: Wed, 20 Dec 2023 05:15:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Subject: PATCH 01/22] hostfs: use d_splice_alias() calling conventions to
 simplify failure exits
Message-ID: <20231220051531.GZ1674809@ZenIV>
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
 fs/hostfs/hostfs_kern.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index ea87f24c6c3f..a73d27c4dd58 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -637,12 +637,8 @@ static struct dentry *hostfs_lookup(struct inode *ino, struct dentry *dentry,
 
 	inode = hostfs_iget(ino->i_sb, name);
 	__putname(name);
-	if (IS_ERR(inode)) {
-		if (PTR_ERR(inode) == -ENOENT)
-			inode = NULL;
-		else
-			return ERR_CAST(inode);
-	}
+	if (inode == ERR_PTR(-ENOENT))
+		inode = NULL;
 
 	return d_splice_alias(inode, dentry);
 }
-- 
2.39.2


