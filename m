Return-Path: <linux-fsdevel+bounces-14616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847687DEB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04DE2810EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CF61B949;
	Sun, 17 Mar 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH9NWG7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223E17EF;
	Sun, 17 Mar 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693214; cv=none; b=LRwnwESWisD3MEpDIH3i/45N9OflsHM4yWro0ozTVAt1QXacIqMdO3wC6fXzdG1lMKuvFX7cCM/ffGY/PaVTt56xZlLahJ8xIbE1QqQlZKuB7zTrd4CpwYBdwE+Y/pMtaJyDz6gTJyPSCkMGATkT/jiSgQbuCYvMxIbmYppmd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693214; c=relaxed/simple;
	bh=ONACup+laAfDNq7cx/v5Ol/o/ikJ0Zhm3Rp1DJWL5uc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtvEai76COnwOOXixJxfPEd1C8HdduXDqtepmLFbeLpsasxemFitRZanLmBtsJ3Zn390t2+BHhU4YpLS1twbQlJ04Xh1v9Y9iRWd0DmcmnAt1X4bYBZbQiEYESxSsqXnmzBvHN1ioH/rS0CqALKOWzMKyvZw6leSIItDErhHUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH9NWG7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DBEC433C7;
	Sun, 17 Mar 2024 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693214;
	bh=ONACup+laAfDNq7cx/v5Ol/o/ikJ0Zhm3Rp1DJWL5uc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hH9NWG7tsGU4g3x8pHr+OCkTFcuf+CwH8cqFZZDuoywHr0pJp4heTbptBkgdVe0d9
	 c8zJOExyfNbEOPkNsAwfp6NwAhPJW9xOBC0ByNvSbmSqu9Erl8t3nFbP+TS68MIsJA
	 42yXrnYK8YeyS5ukfDGDtGvHxdgSGO+Kv18AaC8pAAAKXUCSAx3mpM1y/F4CKZiSPr
	 QkLtBKQ6+1xfx5aMIxPWibzz+OxXnINyMBpSr1IPQNlTogrMC6w8fJTgYeoCqXy/6w
	 Qko8ETdIlNGGYR6QHJnXcVP/ZCatkxk1eNHccIOswmZ9jo4yiZmR3Y/nI04ajOQ+L6
	 ghDMF+D9964hg==
Date: Sun, 17 Mar 2024 09:33:34 -0700
Subject: [PATCH 39/40] xfs: don't bother storing merkle tree blocks for zeroed
 data blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246533.2684506.10607368938981182877.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Now that fsverity tells our merkle tree io functions about what a hash
of a data block full of zeroes looks like, we can use this information
to avoid writing out merkle tree blocks for sparse regions of the file.
For verified gold master images this can save quite a bit of overhead.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_verity.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index abd95bc1ba6e..ba96e7049f61 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -619,6 +619,20 @@ xfs_verity_read_merkle(
 	xfs_verity_merkle_key_to_disk(&name, block->offset);
 
 	error = xfs_attr_get(&args);
+	if (error == -ENOATTR) {
+		u8		*p;
+		unsigned int	i;
+
+		/*
+		 * No attribute found.  Synthesize a buffer full of the zero
+		 * digests on the assumption that we elided them at write time.
+		 */
+		for (i = 0, p = new_mk->data;
+		     i < block->size;
+		     i += req->digest_size, p += req->digest_size)
+			memcpy(p, req->zero_digest, req->digest_size);
+		error = 0;
+	}
 	if (error)
 		goto out_new_mk;
 
@@ -676,12 +690,29 @@ xfs_verity_write_merkle(
 		.value			= (void *)buf,
 		.valuelen		= size,
 	};
-	const char			*p = buf + size - 1;
+	const char			*p;
+	unsigned int			i;
 
-	/* Don't store trailing zeroes. */
+	/*
+	 * If this is a block full of hashes of zeroed blocks, don't bother
+	 * storing the block.  We can synthesize them later.
+	 */
+	for (i = 0, p = buf;
+	     i < size;
+	     i += req->digest_size, p += req->digest_size)
+		if (memcmp(p, req->zero_digest, req->digest_size))
+			break;
+	if (i == size)
+		return 0;
+
+	/*
+	 * Don't store trailing zeroes.  Store at least one byte so that the
+	 * block cannot be mistaken for an elided one.
+	 */
+	p = buf + size - 1;
 	while (p >= (const char *)buf && *p == 0)
 		p--;
-	args.valuelen = p - (const char *)buf + 1;
+	args.valuelen = max(1, p - (const char *)buf + 1);
 
 	xfs_verity_merkle_key_to_disk(&name, pos);
 	return xfs_attr_set(&args);


