Return-Path: <linux-fsdevel+bounces-6553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B10819805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58010B2559F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1411C80;
	Wed, 20 Dec 2023 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Sap3+fEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67811715
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G/t0DWJZe4VqjD2LvljtQ/eWGuVQA6pGT9VI7qEQcHk=; b=Sap3+fExL4kqUSmXlPiaSmtUiT
	L2+MrZ6Qkl3btTDwvq2Cn2B3gLcbS/RDnwiOoiKAm3PKlEdhFlPst79GFfO6ZNx9aL2R4BSYhJUTa
	hD58EOoxfjw0t+NIO844lYfiSaWXzDO9O6J5Y8jCpUJ/v5ETbc5fAtyLk6FREu13dvPQOfc8roMSj
	5QsSw9QI1b6gX6xcfPP9YZMOlQKoBc96/SaqnyTfaEHdUOKaRATtAOlcVHe1TbazCzwJcCXKrX21e
	PB5An5jne5E2LMu5xQ/pfQVoL366nif6fy6GD/ulKp/1tkQR7Srl2c2GbEojT3wyS2cj1kFoFm2Ge
	E2Zi8ZzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFozl-00HIjA-1R;
	Wed, 20 Dec 2023 05:19:49 +0000
Date: Wed, 20 Dec 2023 05:19:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH 06/22] befs: d_obtain_alias(ERR_PTR(...)) will do the right
 thing
Message-ID: <20231220051949.GE1674809@ZenIV>
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
 fs/befs/linuxvfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index a93d76df8ed8..2b4dda047450 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -671,9 +671,6 @@ static struct dentry *befs_get_parent(struct dentry *child)
 
 	parent = befs_iget(child->d_sb,
 			   (unsigned long)befs_ino->i_parent.start);
-	if (IS_ERR(parent))
-		return ERR_CAST(parent);
-
 	return d_obtain_alias(parent);
 }
 
-- 
2.39.2


