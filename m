Return-Path: <linux-fsdevel+bounces-43857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703CA5EA8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 05:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D24D1896980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 04:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46356142E83;
	Thu, 13 Mar 2025 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pBTHsjpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48ED78F37
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840100; cv=none; b=dfUckBBi/UiY6Zyz8TUj61IENnvfc1K3wRClgAcbAdu8xj5S/PtS2gjnPCqgzHext3YbooTlvmwalcuCgScHnuUFj0DvA2Cz8ICx9iffwwtigd9vybz1hHQGdV2hz2Dq48DD2EbzQj/pV9F6l20rzlspgcwU7yyfJI6ptq6dCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840100; c=relaxed/simple;
	bh=GhjSUtfxoH0sMGxYX1SmTttv++we8SpGyOxtQzhsW9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIn7rXx9OY3/yLqxFKc3L0BEY0VOjd/XOqTQ+Paytj7RuHdQsIOSp9us7vb0n3UGwWvH2DxHHVX0mhE9FoXyUE0ARnsx3M4FjpdR2LCNAcGyWHZQhmHLnsIK4NfMyQVtUTT4tzzIBwCTq64kJbQ/EVVv8D0GkTSGxL/IZcPNM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pBTHsjpL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BP8MfTLuj9N3cb4tR84hglIRqD5ctl8ZjP83WvUF9U=; b=pBTHsjpL1jvToEEn5hmZzajt2u
	umPZBo0JNyohTPH51UgCJPPsfaaWlChpDgzaqSzdA67dH/ZAk7ZQmPq68EqzBK0fELPHJ6CK8+fu2
	1PNa6nCDCQHY3m3P36WrpcozAV2eWK0co7zHe+IHr+U0QfJzaHkKcoeGcmoqQKIAi30sjHVUt5kYY
	Iogo0vEVNfmhoLNCt+rGrtVr8l4LAf4OOvmhPTPKjb/KaKNgsYXkKWfcQK3k7QZ/IW7IYsSSWaefD
	/5+UE+JcU7hiNO/j7Lym29TYRu+qNYMZe16CoQYLMzfo8pBwRE5Dowd1Zw879/uHMKdEy32g5TGhh
	C6n+TzBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tsaB5-00000008udD-2yth;
	Thu, 13 Mar 2025 04:28:15 +0000
Date: Thu, 13 Mar 2025 04:28:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] spufs: fix a leak on spufs_new_file() failure
Message-ID: <20250313042815.GA2123707@ZenIV>
References: <20250313042702.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313042702.GU2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

It's called from spufs_fill_dir(), and caller of that will do
spufs_rmdir() in case of failure.  That does remove everything
we'd managed to create, but... the problem dentry is still
negative.  IOW, it needs to be explicitly dropped.

Fixes: 3f51dd91c807 "[PATCH] spufs: fix spufs_fill_dir error path"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 70236d1df3d3..793c005607cf 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -192,8 +192,10 @@ static int spufs_fill_dir(struct dentry *dir,
 			return -ENOMEM;
 		ret = spufs_new_file(dir->d_sb, dentry, files->ops,
 					files->mode & mode, files->size, ctx);
-		if (ret)
+		if (ret) {
+			dput(dentry);
 			return ret;
+		}
 		files++;
 	}
 	return 0;
-- 
2.39.5


