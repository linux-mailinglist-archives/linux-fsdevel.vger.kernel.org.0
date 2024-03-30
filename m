Return-Path: <linux-fsdevel+bounces-15735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD650892865
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD8B1C20F70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7E46B8;
	Sat, 30 Mar 2024 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fruj0iP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC371FC8;
	Sat, 30 Mar 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759277; cv=none; b=sJ6FOojoxiOxVdpx7ZIhlj7qnhnKfms5lSjH4F747JsFXqfGOYKxEKoUKqMWGUzQsU3pXARmvr8RvEfU93LK6PThTC0JxycACA/V4Rnj3o6ULpdocS2RvmcHFjBC7jwJNLlyG0TRM0IqXW7EqQHaWCpt9/GHIMsxxAi2bjfoShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759277; c=relaxed/simple;
	bh=HmDgCwmA/LtgRnKAplWAZkXg9chDdfRHWAUT/r7Sw5U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xf4LnLuX+rz8lCdYjUkfzax54TTNtFx4Xpvu6Y+KHB42Te4PdZBpuuH0QEH2QvlIJVzLWlJ/2TJK40kFgXW8JUriFfoIxfhA3Qp9L+YvTMucUZ1W3paF3EOIbujsaCjhpm+gpZADWPSotZOpj95QfkL8vLmsN46RHMash/F2D5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fruj0iP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91649C433F1;
	Sat, 30 Mar 2024 00:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759277;
	bh=HmDgCwmA/LtgRnKAplWAZkXg9chDdfRHWAUT/r7Sw5U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Fruj0iP4b0d/gqox/a4/ZbKXgmlrP+jATr1QmG79DWXzshf/vQriq5kVqr0zVv++P
	 aCLbwoc1le66xyIaoptZz2qyUxpl6mfAJ2Y3ZPsVqtfyhjHpgQho/OhnmM2tQg3EV1
	 ap0Gbgw+q1GaHH3PkA+CjO+K33JQjK35BkgjJHlMa7MDSefVLTv14WZaq8PKMabsbY
	 dohBKhW2sjNqk6bAMIhJ2jF5kWgNU+ZrOp+l0OtoX3aQZ9R/xMSFVhJE1ko20nG7hv
	 G3FZrx3X+2+RMwlkW6IEGukk6wRivu9n6MRnxWj8/VQ1bVW29tGamag7bMwSuDcS1i
	 yM46EBeO3hmIQ==
Date: Fri, 29 Mar 2024 17:41:17 -0700
Subject: [PATCH 20/29] xfs: don't bother storing merkle tree blocks for zeroed
 data blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868892.1988170.7163278176694009549.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_fsverity.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 8d87d411a9ccb..2806466ceaeab 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -664,6 +664,20 @@ xfs_fsverity_read_merkle(
 	/* Read the block in from disk and try to store it in the cache. */
 	xfs_fsverity_init_merkle_args(ip, &name, block->offset, &args);
 	error = xfs_attr_getname(&args);
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
 
@@ -717,12 +731,29 @@ xfs_fsverity_write_merkle(
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
 
 	xfs_fsverity_init_merkle_args(ip, &name, pos, &args);
 	return xfs_attr_setname(&args, false);


