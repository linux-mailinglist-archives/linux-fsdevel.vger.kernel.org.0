Return-Path: <linux-fsdevel+bounces-6551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DC819803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C832E1F25C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F10EF9FB;
	Wed, 20 Dec 2023 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O3R39gDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A621C8E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c+p6aeVDu8lejuTIQ09vWacuxO4n/pJOAHqwSaX86ps=; b=O3R39gDX7X0FbsJWhz92iworaF
	0Ex9Gnbq4Nhy3rxxV5doX8yiW8+PhBlUTIghHFa86KibqZ5M+So5klanhAkRlnEVUb6bJKuK6Wcfi
	om4Va40OivYe/3Ajze2w6jNHMKOABYOTXdfecNXQCF5wymQvjD/hna5+kZZf4tnkzWMmlqS4nKGsN
	dTrrIb9yhbyjNkcqwpeocy81O1FRtFEztKh6JFFGzaf14SxOTO5uJ9osurfG1r89+QwtKeEcKPLCJ
	6s/6R795BxYkgRD+QotsVycezjiQ4YbknzV26+m7wfj+OCuiNNJ7/VsadZZGIXlOg4WRWB/dm4G/G
	C0gCLuAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFoyS-00HIdl-1Y;
	Wed, 20 Dec 2023 05:18:28 +0000
Date: Wed, 20 Dec 2023 05:18:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Subject: [PATCH 04/22] udf: d_splice_alias() will do the right thing on
 ERR_PTR() inode
Message-ID: <20231220051828.GC1674809@ZenIV>
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
 fs/udf/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 3508ac484da3..92f25e540430 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -125,8 +125,6 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 		udf_fiiter_release(&iter);
 
 		inode = udf_iget(dir->i_sb, &loc);
-		if (IS_ERR(inode))
-			return ERR_CAST(inode);
 	}
 
 	return d_splice_alias(inode, dentry);
-- 
2.39.2


