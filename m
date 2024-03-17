Return-Path: <linux-fsdevel+bounces-14613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B987DEB0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5283B1C203DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD61CAAE;
	Sun, 17 Mar 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReuGvlM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA21CF8B;
	Sun, 17 Mar 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693168; cv=none; b=mUbXB1yrrVxbf3PtRkXbCvUbJyZXeX6a/H7duhq1T1oXqiNnA0nBlFcP5EiY4cL2p9wPzUK6TtqdyigL8r5sToruSIIX6fM8AnZSR5yOMKoYkzmrtbRkn/hKFh/qSToHj7xD6KSt48whDkHU3mdGg7PXtWmOaH84HOalifUxAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693168; c=relaxed/simple;
	bh=RE8M70WosxhZ52NRC8S48jNL1RwKrCGZVvwHMDsK9xc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S17aTehJ4v4RwW1L1/vvSASt+mTBQYTE6RZYHdYHsw11zJoxxm27oLVf7T+S836W0rDIUIQeE0wgIygsQzfVPkCtWM+LZZ9hI1SceW4jeCBXGcm1H/QUcmOpUi+SwyNhixtgUgzqem3x/4645tp70vRuVBWmGiZf/ooB8HcLmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReuGvlM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51BC433C7;
	Sun, 17 Mar 2024 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693167;
	bh=RE8M70WosxhZ52NRC8S48jNL1RwKrCGZVvwHMDsK9xc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ReuGvlM3B6qdIFUknKyE97BscQ4zBmwVEEWUqzX+co9C/YSXAVOagwn0Hkit2KHP0
	 2a5B0QgrYL0vGaALKYUUabjPTYlp7o9zgKDGclGAtLnsv3iXIC7fGZK7dFZx9pokYc
	 BFvEChI/phlXV6sQCi6gTHBZi8I2SGdYD43Oe0DjPRLJXfbS6lFHauzvPyCVxnA5nx
	 2SJrPhvGtycuTrfhv6bCTPHXBwuqufRCbcN/Jgk8gtEN/PXX22QDABZxGUgGbzSRki
	 WqDV6sn1jL7sRmhVQHGDVG98Dkz9cwgKVulNcb6hOp7/FaS+rASVaOYBcUIG0p5i6J
	 p41mqUcPZWbOw==
Date: Sun, 17 Mar 2024 09:32:47 -0700
Subject: [PATCH 36/40] xfs: don't store trailing zeroes of merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246485.2684506.6805355726574585050.stgit@frogsfrogsfrogs>
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

As a minor space optimization, don't store trailing zeroes of merkle
tree blocks to reduce space consumption and copying overhead.  This
really only affects the rightmost blocks at each level of the tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_verity.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index 32891ae42c47..abd95bc1ba6e 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -622,11 +622,6 @@ xfs_verity_read_merkle(
 	if (error)
 		goto out_new_mk;
 
-	if (!args.valuelen) {
-		error = -ENODATA;
-		goto out_new_mk;
-	}
-
 	mk = xfs_verity_cache_store(ip, key, new_mk);
 	if (mk != new_mk) {
 		/*
@@ -681,6 +676,12 @@ xfs_verity_write_merkle(
 		.value			= (void *)buf,
 		.valuelen		= size,
 	};
+	const char			*p = buf + size - 1;
+
+	/* Don't store trailing zeroes. */
+	while (p >= (const char *)buf && *p == 0)
+		p--;
+	args.valuelen = p - (const char *)buf + 1;
 
 	xfs_verity_merkle_key_to_disk(&name, pos);
 	return xfs_attr_set(&args);


