Return-Path: <linux-fsdevel+bounces-18261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019C8B68D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F541B23727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C817589;
	Tue, 30 Apr 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBwplYul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6A10A1F;
	Tue, 30 Apr 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447932; cv=none; b=CrJBfHnaHOOntXkxwk4wI7ENFvsYTm/rxm15MAfXKt6UFtCEdBnM91zVXc7C8rNWX10+DMypHCjfTn6g0Tcjbxsw0pt7qmubQs/zXZXj8oXbnZVn3PmKtimxcwxnwB4R/dgC6e5JHoC59LNlpEv5ESqrrfbZ6Oc3C7guop4eMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447932; c=relaxed/simple;
	bh=zzOIEgE+CHVA+ZNtgRAVQMTsqe8hg2dE5Clj17eW2sE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=px83ywE5Wqo+UES8FE/spBmakjH1xDp6TFaB4msy0GXPF438PuFIAhTjTlTAoIgb7+M9xTfJ4auKdItI13L3JSJ/93AjoVSbKynLFt9iAyTy+XpeRIRDabyLwvh1Nwprtf1YSSZf81zJQ7fO1j6EMQj24hrS1A/iRqyd06Iwpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBwplYul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A26C116B1;
	Tue, 30 Apr 2024 03:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447931;
	bh=zzOIEgE+CHVA+ZNtgRAVQMTsqe8hg2dE5Clj17eW2sE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fBwplYulUtARIbRlOx1gUCSccdonty/2IsE2JpYj3XmhytWctvO+MgZhDdhp8aWCD
	 7t5N4L2ncoYdalkMIF87TrI31CkJYVqDVXD6yFfmk747gU9GCfj+QPUDtKXKRgBKmm
	 sH8N1CIF78kf5U+i4Rq4oXT2bBuwWElAGTm1hSnMQyTESPxCoGonvyCqyivb4k47h+
	 tEM6oO5/5UKZvRW9ZtYLYl9IR9sZ0SIYhSW3XwRFgDhqLAwYv2l9o0npy7IUQbwQ9e
	 RZkQi8iPxqtrteTxQnynJako2JgzUaRLU6JwoiAPE8f47U853YKU6K8LxfwSuAMsHW
	 VzUFDVtKnK1VQ==
Date: Mon, 29 Apr 2024 20:32:11 -0700
Subject: [PATCH 05/38] xfs: minor cleanups of xfs_attr3_rmt_blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683188.960383.715192327245703651.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_attr_remote.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


diff --git a/libxfs/xfs_attr_remote.c b/libxfs/xfs_attr_remote.c
index b98805bb5926..f9c0da51a8fa 100644
--- a/libxfs/xfs_attr_remote.c
+++ b/libxfs/xfs_attr_remote.c
@@ -55,19 +55,19 @@ xfs_attr3_rmt_buf_space(
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
 


