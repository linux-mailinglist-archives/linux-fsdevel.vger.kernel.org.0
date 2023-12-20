Return-Path: <linux-fsdevel+bounces-6555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7B81980A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0741F25BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87ADD312;
	Wed, 20 Dec 2023 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FfJ7jFgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1515ACE;
	Wed, 20 Dec 2023 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=putIwnQflJjta+T2v463mXJ/hOjlgxbDyQ8RoAXbdsA=; b=FfJ7jFgvKeJf2ccStd365kiXWf
	ulj35oalD983Uys8hWFUZYCYD5OpKrwVt/ao9i66T0Ajc6Whwx1ZcvwW038KTnne5QKL6mQ/ZzW6X
	hqSotj7tROquYZW+3DMJ9gLyCarcIz6jMGcP4joNkhFu2l6OMOniYQRfWPx1elC5FyYVtBuIZBcCj
	k/oYwaRRgEv8ie+p1V4eDnvcSq3zHN9Rt/DS6ZQdVKvln9Y8pFZhQygnYT3YjW/6ZLywYEepPN6l6
	5lVTvkveNmVDAN12nnzzdfpnMOnG/Ish9XscegacQ6NvaRgC6aDwEy0ODRMAl2Jad1MaeaWnv16id
	JSey5a5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp1c-00HIqK-2E;
	Wed, 20 Dec 2023 05:21:44 +0000
Date: Wed, 20 Dec 2023 05:21:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gfs2@lists.linux.dev
Subject: [PATCH 08/22] gfs2: d_obtain_alias(ERR_PTR(...)) will do the right
 thing
Message-ID: <20231220052144.GG1674809@ZenIV>
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
 fs/gfs2/export.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index cf40895233f5..3334c394ce9c 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -138,8 +138,6 @@ static struct dentry *gfs2_get_dentry(struct super_block *sb,
 		return ERR_PTR(-ESTALE);
 	inode = gfs2_lookup_by_inum(sdp, inum->no_addr, inum->no_formal_ino,
 				    GFS2_BLKST_DINODE);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
 	return d_obtain_alias(inode);
 }
 
-- 
2.39.2


