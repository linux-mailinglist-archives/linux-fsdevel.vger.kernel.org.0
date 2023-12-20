Return-Path: <linux-fsdevel+bounces-6563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119A81981C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0BF1F26528
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CE168D6;
	Wed, 20 Dec 2023 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u3UH+mNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF71168A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MP81gFD/vO0Nfz/TqR7yHb+uaoSWgIHgeqI6XASg6Go=; b=u3UH+mNf9TetfTbZKupC8TEwJP
	x+cPChEEuxW/Nkby2ac7WWnu8p3lG6L/6IyEYBEwY0jLJyrkGfeVbWq7HjRRoA35Pu09koCTrFvYZ
	wUY/btzuIntiX4m9uydO9hRfv096pMi7rdrs04xe6d4FmirB5BwMOl1Ag67T4NQBj8qK5KMORoJnC
	2ORo2u11XGk2S+cyJNhq97RLPksiIygcSEXJO7qvWZvOkKMSONe4MRZbSQ2pfZ+359lu4N+m9pugL
	Z1+A3LtzpHqzQmHqx402kF8PSSaivXrzmAzqVOdMcVwP4SsjcCBOFqSxuTRjrok9UO+sHKA2PZqln
	bPkHOwDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp8B-00HJNZ-35;
	Wed, 20 Dec 2023 05:28:32 +0000
Date: Wed, 20 Dec 2023 05:28:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Subject: [PATCH 16/22] udf_fiiter_add_entry(): check for zero ->d_name.len is
 bogus...
Message-ID: <20231220052831.GO1674809@ZenIV>
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
index a64102d63781..b1674e07d5a5 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -228,8 +228,6 @@ static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
 	char name[UDF_NAME_LEN_CS0];
 
 	if (dentry) {
-		if (!dentry->d_name.len)
-			return -EINVAL;
 		namelen = udf_put_filename(dir->i_sb, dentry->d_name.name,
 					   dentry->d_name.len,
 					   name, UDF_NAME_LEN_CS0);
-- 
2.39.2


