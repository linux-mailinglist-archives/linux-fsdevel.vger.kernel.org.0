Return-Path: <linux-fsdevel+bounces-71264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F3CBB66D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 04:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F05E300441E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB92E03E3;
	Sun, 14 Dec 2025 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e9JlrV7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43C54774;
	Sun, 14 Dec 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765682982; cv=none; b=WFRXXJvzDe8juKFdk0aVrxXAZdxnwlxaK+tuTMrysJO96n9XsrbMJ//UzqY7Ac5r6pFZ6kolZj5MO1VxyrBqK3Y89pTsYALBHSC2P2Uv5NwgoC5rUCzYxO1sl7iRAChFOvVm8eaDcoHd6xpysbVUtQACu4poUUKz/QsQGSEbniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765682982; c=relaxed/simple;
	bh=4Mk5r6vp/ucwVc25Sp6S9lnMiS1nrk06LdF75/zPDpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmZeRWmxxi/+8WFvHNVAb1G2MCKtkIB2vTa2UUI8hsNjc7B6ZJ1jz3P/W8QjtiqyJqUNIuUVKIOT0D11x9bgref8FA6faQHJRnhvNjgBg2AyRh9fH1hVy0DztLztBsOODurrwDf+9vhONrotz9hdqBkxDnGjitIA4IgDhZ2nRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e9JlrV7O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nE0cZnkh09VtJ5FOhMNWibUYyxBs+jVfTjb1515cegE=; b=e9JlrV7OFkArFVQ7jktGJCTBdK
	HDNFyg1yNd6rDN47QJuD92x88JUfhqmwtRz2hEXmH28T9kwED/2zdz4pDEaPy5BHBp54uX2hDiou6
	N+b/+YrfpTKrXEkxGaOQ0d4dwutVuF4UfWC476aPYmEhZ1lc+80+GJheEHI/YvPVpE7HvN4DRmilK
	9lAzxrBOABTsarCtxvhjqvnRiig8q2R0TthUWoV5QL6giyTPQLualAwDA7q7HDfL75dy9ypix4I4L
	5iNuUil1e70OPMCiJjQhlZQBc+otV/H8qqwEhW4YD3DlsGXj16vKM7YsM37VftWlRnlUzW1MVpICn
	gDxGu2YA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUcoF-00000001xok-1DQ5;
	Sun, 14 Dec 2025 03:30:11 +0000
Date: Sun, 14 Dec 2025 03:30:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] shmem_whiteout(): fix regression from tree-in-dcache
 series
Message-ID: <20251214033011.GA460900@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214032734.GL1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

From 3010f06c52aa7da51493df59303ea733a614597b Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 13 Dec 2025 12:36:15 -0500
Subject: [PATCH 1/2] shmem_whiteout(): fix regression from tree-in-dcache
 series

Now that shmem_mknod() hashes the new dentry, d_rehash() in
shmem_whiteout() should be removed.

X-paperbag: brown
Reported-by: Hugh Dickins <hughd@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Tested-by: Hugh Dickins <hughd@google.com>
Fixes: 2313598222f9 ("convert ramfs and tmpfs")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3f194c9842a8..d3edc809e2e7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4019,22 +4019,10 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	whiteout = d_alloc(old_dentry->d_parent, &old_dentry->d_name);
 	if (!whiteout)
 		return -ENOMEM;
-
 	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 	dput(whiteout);
-	if (error)
-		return error;
-
-	/*
-	 * Cheat and hash the whiteout while the old dentry is still in
-	 * place, instead of playing games with FS_RENAME_DOES_D_MOVE.
-	 *
-	 * d_lookup() will consistently find one of them at this point,
-	 * not sure which one, but that isn't even important.
-	 */
-	d_rehash(whiteout);
-	return 0;
+	return error;
 }
 
 /*
-- 
2.47.3


