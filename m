Return-Path: <linux-fsdevel+bounces-15719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C4892843
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A31282679
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C507482;
	Sat, 30 Mar 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYHUENm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94A6AAD;
	Sat, 30 Mar 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759027; cv=none; b=L0vGnkmpav1kvT4fIbYtojwC+0pkkZZd9diTPshMm5yjptjTLqnGXnH5yeDFp9l9U6SI1N4sJf8v++WO59jFhyt2lVSS5uj8h7qCBkpykiwypQWTz7hqFrKJdC7SwPAmsWA+lq1VVw+CrNEYC8QlYrs+k9loV0G8FhRgrud827E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759027; c=relaxed/simple;
	bh=qMOZz7PKATP2ctlAit52AUj3S1AYSPeGkRR4ViHGWKU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiqAA2BFS9XO3GnEk37jJsh+NtP2uUg0yu77dAWbDqsGm/VzdKI2GqNI/eA9J5RwrOU8xx50mDroYHKzFAypYbIVog8Xtg5DE/wdhJl28GqvXM2oQeY8t3KdFlHsUK0rCxbLcfvLk691uQaESFrGm1qRCfyRUTA2xr2NdrgeTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYHUENm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23804C433F1;
	Sat, 30 Mar 2024 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759027;
	bh=qMOZz7PKATP2ctlAit52AUj3S1AYSPeGkRR4ViHGWKU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qYHUENm6EeaMVnc33DQqJo6AeeO8uHA3epRP+EJ4kBowcajgsRT5curJC8bAZyPf2
	 ifYnE3BE6bdXurikBz27PyfBsdtJiPqYuGypZh0SSkTF0/BakVYcwEIxiiDyPKjYKw
	 RxVxZpGGpLVb6xF5HYZyJjWhHeWZZFMZ3C4F3T5QLjD2FGMe+fLzD6Aefk9COxHINS
	 4TWnFTec4WODUZeHlyDo8lMoRomk8xfU7jx3m6T/O/snpcuPdC1DlnxXxsqq8HPgqn
	 UwHA1Yqh6oLdXDrzygrIXqoT1b1NzsGv2Q5bN9vMuPbhMEDG37Xl2jcmCqe/pe3l9n
	 q2oh7zDvxnwEg==
Date: Fri, 29 Mar 2024 17:37:06 -0700
Subject: [PATCH 04/29] xfs: minor cleanups of xfs_attr3_rmt_blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868626.1988170.3178382336043313130.stgit@frogsfrogsfrogs>
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

Clean up the type signature of this function since we don't have
negative attr lengths or block counts.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_remote.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index efecebc20ec46..d5add11d0200e 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -56,19 +56,19 @@ xfs_attr3_rmt_buf_space(
 	return blocksize;
 }
 
-/*
- * Each contiguous block has a header, so it is not just a simple attribute
- * length to FSB conversion.
- */
+/* Compute number of fsblocks needed to store a remote attr value */
 unsigned int
 xfs_attr3_rmt_blocks(
 	struct xfs_mount	*mp,
 	unsigned int		attrlen)
 {
-	if (xfs_has_crc(mp)) {
-		unsigned int buflen = xfs_attr3_rmt_buf_space(mp);
-		return (attrlen + buflen - 1) / buflen;
-	}
+	/*
+	 * Each contiguous block has a header, so it is not just a simple
+	 * attribute length to FSB conversion.
+	 */
+	if (xfs_has_crc(mp))
+		return howmany(attrlen, xfs_attr3_rmt_buf_space(mp));
+
 	return XFS_B_TO_FSB(mp, attrlen);
 }
 


