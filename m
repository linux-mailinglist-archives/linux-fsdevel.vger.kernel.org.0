Return-Path: <linux-fsdevel+bounces-5794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04F8108A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948C31F21B57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8EC8E4;
	Wed, 13 Dec 2023 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pZDhelTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FBD5
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3fE/oxeg1thLynUN0Za05MCtDcmKpfNaEwI0X2tkErY=; b=pZDhelTML+Jjel+hfkABfcAK6W
	e5UcLU9jZ13F8uai8/5DcQXiNGbakHfUi4hfNYVW8JRG1fO77CsGC+KGvkhopHG1KMqrhJLLeWrUH
	lIM+YCIg+ZzY3O2h2YhnAV1iND2I/XAnRqTYvqe10bNzLV4E+G6GcDXUBIb3BA2J3wPnAyTtGiPkV
	y4Q+fhdCUg06I6gLEq3yWKCVgP3HPgbdEFVUT5xQyUpcibZ8VURgyruV9vm1dLzJVOvHUFhp1eWWn
	bl/SdGsaZavkUrxfwaNSarfQ2AC6Iz5FwhaZuwUGjP7BCsDViumsLszlNvAYsr3mgVkS6Vzh/tZjz
	Twm9k1RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlV-00BbyH-1I;
	Wed, 13 Dec 2023 03:18:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 10/12] ufs_inode_getfrag(): remove junk comment
Date: Wed, 13 Dec 2023 03:18:25 +0000
Message-Id: <20231213031827.2767531-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
References: <20231213031639.GJ1674809@ZenIV>
 <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It used to be a stubbed out beginning of ufs2 support, which had
been implemented differently quite a while ago.  Remove the
commented-out (pseudo-)code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/inode.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index ebce93b08281..e1c736409af8 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -263,11 +263,6 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 	unsigned nfrags = uspi->s_fpb;
 	void *p;
 
-        /* TODO : to be done for write support
-        if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
-             goto ufs2;
-         */
-
 	p = ufs_get_direct_data_ptr(uspi, ufsi, index);
 	tmp = ufs_data_ptr_to_cpu(sb, p);
 	if (tmp)
@@ -302,21 +297,6 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 	mark_inode_dirty(inode);
 out:
 	return tmp + uspi->s_sbbase;
-
-     /* This part : To be implemented ....
-        Required only for writing, not required for READ-ONLY.
-ufs2:
-
-	u2_block = ufs_fragstoblks(fragment);
-	u2_blockoff = ufs_fragnum(fragment);
-	p = ufsi->i_u1.u2_i_data + block;
-	goal = 0;
-
-repeat2:
-	tmp = fs32_to_cpu(sb, *p);
-	lastfrag = ufsi->i_lastfrag;
-
-     */
 }
 
 /**
-- 
2.39.2


