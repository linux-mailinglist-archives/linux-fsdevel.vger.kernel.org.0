Return-Path: <linux-fsdevel+bounces-23439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFE92C438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 21:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8D4B2185E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250C185602;
	Tue,  9 Jul 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLDIVhO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A1836DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555127; cv=none; b=Q+wByERrTJMdfrO/pF9svSfkTdnInF7M6a9jHwnA9X293ckRL7ylw+m6mUyhCqIqFMag6sLkJcEUqaKb4KThRGkrALfmk/8K7GfQjFrEWpQZmMiBDZ2YEiNGw87yt0j3pBrlo5oLTotQ25qTEJiwlsC14hr2Il8cGJBNf86QUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555127; c=relaxed/simple;
	bh=JdiF0b2qNZr6oCCHv4dtZWd1RrwtrY8klfFxrCj2AnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pz8BKdrftnwrdAq8SlhyPaeJe+Jc5GhiZ1ir7cWSEYww2Vtjd9mRrDKbWYvZJMHHrRkLzbUWiVwSFxG7g5Ky+Y5uitndl5ya2bnFNzUOa7KyZhpCS0LY71gtfg1D+82JL4FhKb1+qYOiAkD1RutdgrBkot/0joQannau+1lAzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VLDIVhO+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Kbk5m+VT77yEh0+DMehg5746u1N6a95h6jPKJsOL0EA=; b=VLDIVhO+/PM8qL8gSEES0fa1qY
	qTbf1MNGGinlBy1JAUdBRJ6QxcWIehEuEqtg4l/nfvyq7lU0VkI3ZFU1PFg190c7M//bk8ko/Sb19
	/YJQwK4fmO/SPcwlfWl4zz6jWDVOnioQSrxj0f5BgbElMXT70ynmdXggqOMcc6/SH9d0+ODH/lJ/p
	/Tkx/4aaSPvJIJfCqf1hB4j6fBYg14jGfQauml14CGaRm3vYElg4bLNIHnWIpRUqzCXHe8DizCghI
	VXe05LWAtqk8lrPA4/PW9W4Jg2gxn3Ichpd496d7BL6x6WzhFiFqh1WVaW0Q0GELcegSAr3sHN+vd
	yL1fJVuA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRGz4-00000008Kl1-3JCS;
	Tue, 09 Jul 2024 19:58:42 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	"Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: [PATCH] minixfs: Fix minixfs_rename with HIGHMEM
Date: Tue,  9 Jul 2024 20:58:39 +0100
Message-ID: <20240709195841.1986374-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

minixfs now uses kmap_local_page(), so we can't call kunmap() to
undo it.  This one call was missed as part of the commit this fixes.

Fixes: 6628f69ee66a (minixfs: Use dir_put_page() in minix_unlink() and minix_rename())
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index d6031acc34f0..a944a0f17b53 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -213,8 +213,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 		if (!new_de)
 			goto out_dir;
 		err = minix_set_link(new_de, new_page, old_inode);
-		kunmap(new_page);
-		put_page(new_page);
+		unmap_and_put_page(new_page, new_de);
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
-- 
2.43.0


