Return-Path: <linux-fsdevel+bounces-40666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE08A2656D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B16E188553A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7841FE473;
	Mon,  3 Feb 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KWNLRoY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538C1C5F39
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617464; cv=none; b=EfXO5pOHHG5hgF5+/AWMg1c944q/ViR8z+FvaIO5tVcFA3k8peBJ8upVrHxJHIWffVfXK/2DViK82qychA2XbkUhiNVDwRQM8Yyeb5u4KohIdvukPOIP8cZJ01kk/mcSHJafV/E31gYqP25kjFUhnVwmbTvU/SnVYnsGP2HtfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617464; c=relaxed/simple;
	bh=LddQt2MP2PEi0hx0Z9z5oBAptQuLJciGOujnDrexNgA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZsAeJJIj1MW4ilvczF/H/hnjWPfgJ4D6DRYpIB90687W8w5uLXs/bamEMthl6Mj0XIzsO+qetp7LZysr+NKKJlsS8vYzCukqCOMjs2odAq7XFPmWl5HhXOuddNmPqTsX6Q5f4JDygWwmnl+DXrJks7cjgRpxVGOC4HjlbJFMoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KWNLRoY5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RoMco4oQQwXWMUCZIEAN0Yk20YmlY4rjqc+2w37UKto=; b=KWNLRoY5rCYqYQDjQprz4lKWYN
	pWj3/M/cPI0kMuZO8D6O8lavyErxMq2H7Dh8F6s/O7hwiOjzVBzmDh57t5zu30YQJQee1cg//S0pX
	tQe7FbaViODeZ6x4NyEchfcFz/n8RmNRacUNHYWDC8X8RaBYN/xiRrnRkN+7O9tSU72eIt1+0a5vE
	m85h5KMOqsxWSMTBZ1hmHq+09OMTdXghskxDSYgjSrRz8Ox2Uwya7txSyqwtwro4gD6aWTfHcdSye
	D9e9arkRW/z+K3YxoDm+8mReTN2Lf0+uK1q48UpYCaaYX+zTaQVfy+Xl4CtE1vah1UyV9LTjLSumG
	ctvYhIIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tf3p5-00000002Hg1-40QK
	for linux-fsdevel@vger.kernel.org;
	Mon, 03 Feb 2025 21:17:40 +0000
Date: Mon, 3 Feb 2025 21:17:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH] fix braino in "9p: fix ->rename_sem exclusion"
Message-ID: <20250203211739.GB1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_op can bloody well be NULL
    
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 30d61efe118c "9p: fix ->rename_sem exclusion"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/dcache.c b/fs/dcache.c
index 903142b324e9..8a605681b26f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2967,11 +2967,11 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		goto out_err;
 	m2 = &alias->d_parent->d_inode->i_rwsem;
 out_unalias:
-	if (alias->d_op->d_unalias_trylock &&
+	if (alias->d_op && alias->d_op->d_unalias_trylock &&
 	    !alias->d_op->d_unalias_trylock(alias))
 		goto out_err;
 	__d_move(alias, dentry, false);
-	if (alias->d_op->d_unalias_unlock)
+	if (alias->d_op && alias->d_op->d_unalias_unlock)
 		alias->d_op->d_unalias_unlock(alias);
 	ret = 0;
 out_err:

