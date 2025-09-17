Return-Path: <linux-fsdevel+bounces-62047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCEB824AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823902A7B41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA3313D50;
	Wed, 17 Sep 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CFE2DqPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C377313540;
	Wed, 17 Sep 2025 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151667; cv=none; b=HoXYCuT6qWjLaDhkLyHtu3JjY9T3wHYz2kVEFEyvCuz+Cew8wKZ11YLy9+3tfFUJS2rrTgWNOHT2jiZBhcfjCTgAGyGld3cBAtmxq5l4zUc9tQjdQLdUlIMQEy6Lcjsgik66GUxOROlq0QimsF9yOyePDYhjaO9YXzz0FzDIy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151667; c=relaxed/simple;
	bh=v0ORbOYTQuPC+Lk1UcrMbyUyyP2Sj8S5nGAxGAeua5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cajHey4BdrlELpsyPofS5ZWjNqfewVLYNpMCan3i0Eug9WzW2+U4KE76u/z62XUAMFshpO0ErjyBdMK7XrWUlJ0kpAvMtlS7J2eqeF9U4VpthoxW4h7E/9DXiG3DXnnLF/d1fSHfl1+HNhcWTCE5bjtosj4OpZFl6XYdESu8EWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CFE2DqPY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9wTihei3CR8ifsWFMqxwRfG92M/T58JiLp+ifoDanQg=; b=CFE2DqPYNYofWjgsFkrcOJ9vtl
	YHav2Ad84icp91CnKsx+bpo6ZVIxn0ysCgaFhBiF4cxTkZ5cWj6YTZBYadGP7k4WGQ+W5QjkiNZlg
	o/2bV/GJy6vzVWX9gyUXpvkfwWajCppQkEJpEOf1weGiainW/DNaMZOy2XfKZJoVyNjrTtHRLk/wD
	mCaNHzkBBebGFfgt2w8GxBbcwuQUGCN6x7AinAU4vQLAPN4ab+wT1A39N5yIGNbXq1aWVOrigMyxF
	z1fIxRle670fy3oac1iYOxuWXqfM5DXHZRjxO0wCnRImd9zwZ6Hcvfr9Js3+kZ8sAoWFlcc3ajc0f
	UToNWqZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj6r-3gti;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 9/9] slightly simplify nfs_atomic_open()
Date: Thu, 18 Sep 2025 00:27:36 +0100
Message-ID: <20250917232736.2556586-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c8dd1d0b8d85..5f7d9be6f022 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2198,8 +2198,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		else
 			dput(dentry);
 	}
-	if (IS_ERR(res))
-		return PTR_ERR(res);
 	return finish_no_open(file, res);
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
-- 
2.47.3


