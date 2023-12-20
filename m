Return-Path: <linux-fsdevel+bounces-6565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D738819821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92103288739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4215AD8;
	Wed, 20 Dec 2023 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MduyeqHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BC156DD;
	Wed, 20 Dec 2023 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8+pSMi90iMJbp8SNVldNRXoVmhwt4bobR2N1xwtpgos=; b=MduyeqHDXdk4CAFlDgc+yfIntB
	nYG6P715r5ZP0SI04laBhd1qm8IjbJvwsMAnbkgEcl60cobnMDMkjWDXKfST2hgXBAAWijYZYQ0Zg
	VAvuf880456lb5qkXBSlKItfQIW+h7MhkzZdjSKcau2LqrxOt+PBZG4zQVG+ruFdKMmo5R/vpscwN
	RXm95elbaDgnLQHFaXl7OnX5wQGUFTpJ3mhsgJgaAysU1/MYjX10JWxHuSU0rn/4zh/OK5L1Wr3lg
	kr9nJ/RZDC8/biOPNQThFQL6c5A7VceVIaSC1YKSTLUvQhvyarxHY0GPWsKpJSoNTXyHdq1IJHBfg
	wQvXVlPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp9p-00HJWS-14;
	Wed, 20 Dec 2023 05:30:13 +0000
Date: Wed, 20 Dec 2023 05:30:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 18/22] nfsd: kill stale comment about simple_fill_super()
 requirements
Message-ID: <20231220053013.GQ1674809@ZenIV>
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

That went into the tree back in 2005; the comment used to be true for
predecessor of simple_fill_super() that happened to live in nfsd; that one
didn't take care to skip the array entries with NULL ->name, so it could
not tolerate any gaps.  That had been fixed in 2003 when nfsd_fill_super()
had been abstracted into simple_fill_super(); if Neil's patch lived out
of tree during that time, he probably replaced the name of function when
rebasing it and didn't notice that restriction in question was no longer
there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3e15b72f421d..26a25e40c451 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,10 +48,6 @@ enum {
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
 	NFSD_Filecache,
-	/*
-	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
-	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
-	 */
 #ifdef CONFIG_NFSD_V4
 	NFSD_Leasetime,
 	NFSD_Gracetime,
-- 
2.39.2


