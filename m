Return-Path: <linux-fsdevel+bounces-18248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C58B68A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339261C21A17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5D10979;
	Tue, 30 Apr 2024 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB3EjsJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5310A0C;
	Tue, 30 Apr 2024 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447744; cv=none; b=CBdT1JGbOM0bLaFu/eTlgXzAYFrtBM7wtBOZSkmdQgBReIr9gY/cn+1WsC2Hx0l1BNOplIx45FDTG12n5YOIwVFWy7+XC7lriUqcHUgYy0gqoPHUSKPePeuagZ294lc+8kcbBZ1ceicH23EgWUULrHRyY1o8HYwQ01Zi7vycwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447744; c=relaxed/simple;
	bh=4KBdNO0mizM8qRP9SvBUyE2+zGjCsaNSA4raIvuvohM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaJQquZEDtYY/vn1i8SGZUYdwrXDd/+o32gWoQdrptNAJndxR1XfR9DaIxWLP6jsD49peoA51kPW6k1oD8NGL3gFbnVGUc2pO3MenHMfUOJtMeesfS2ZzT4IaoRFlEz6riz+C/yWO8DxJq75y6TKGzu3a3H9yTxbp0x0DKJfeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB3EjsJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC6C116B1;
	Tue, 30 Apr 2024 03:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447744;
	bh=4KBdNO0mizM8qRP9SvBUyE2+zGjCsaNSA4raIvuvohM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AB3EjsJfJGPpzZXw0c36vgWVRdCR/QBqEVnDpNXU6ts03crOZjcEIXfEYCPall7C/
	 /LA6Tst9w8Ofq/bwRRNWUPGminFVnWWig/1NhVtm4rnPlw7Bg5l5YxoTh5Eig3VNhk
	 hifyQIad3tMURLCOb8R6QftjAJk3TKLFz+WG1Z0RFgVjH5gF9TT52WtDGfNSk9BKaY
	 jzqrlDFYBNKyzloZVMeYggucMHYwPE8g5+XlyKTflYtNAL723PymVd/ljJsK6MXFZj
	 yZqpmuV+o+AUwe3yV3X5DLg0t6tvGuxMQ0HkoPENE7Y9mvf8Ko6ZhHChl8M8adhbXR
	 wBWvnyS1RW8Yg==
Date: Mon, 29 Apr 2024 20:29:03 -0700
Subject: [PATCH 19/26] xfs: don't bother storing merkle tree blocks for zeroed
 data blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_fsverity.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index f6c650e81cb26..e2de99272b7da 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -824,6 +824,20 @@ xfs_fsverity_read_merkle(
 	/* Read the block in from disk and try to store it in the cache. */
 	xfs_fsverity_init_merkle_args(ip, &name, block->pos, &args);
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
 
@@ -875,10 +889,23 @@ xfs_fsverity_write_merkle(
 		.valuelen		= size,
 	};
 	const char			*p;
+	unsigned int			i;
+
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
 
 	/*
 	 * Don't store trailing zeroes, except for the first byte, which we
-	 * need to avoid ENODATA errors in the merkle read path.
+	 * need to avoid confusion with elided blocks.
 	 */
 	p = buf + size - 1;
 	while (p >= (const char *)buf && *p == 0)


