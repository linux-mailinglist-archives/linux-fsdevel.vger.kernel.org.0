Return-Path: <linux-fsdevel+bounces-71595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118FCCA0C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC3130552FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07F12773F9;
	Thu, 18 Dec 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtvLsPcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8631D5CD4;
	Thu, 18 Dec 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023439; cv=none; b=vGkva7krq5UJXvpktFV0CsDWToUAOcDahEKcwarGEpB2ZsQKpcum87M/EscHrynCz531jOrhZv4RYVJ6zsywjfLYK1Jp0gkYq0J9tDEgdnOyTyvUsT4ljBm/H5mo0j8WbiHzZenYIhNPAiu9KLkrof9q5L6WylrJnDzDo8mTMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023439; c=relaxed/simple;
	bh=8i4/fDyBOTS6CZAy5pIfNiONnEHvSniPDYONrCe3GQ4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK5ltJZgA8WmTl9eR067xqbzBpiptaZ2SnkZRKLZpCDdYOg5gbRBSQfup4tLXBBO1b7qHdZqwHcxyWDHOFOJdG9lbHCqWWvinyuDpx1a0d2hbi+WPR63jCgWwPutDnsz4qoBr12MrRL1hFZs9lm3387lZNDU0Afik47lXyKEeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtvLsPcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255ADC4CEF5;
	Thu, 18 Dec 2025 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023439;
	bh=8i4/fDyBOTS6CZAy5pIfNiONnEHvSniPDYONrCe3GQ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DtvLsPcvRCohza54oLPxrqqKvxJEvJWITWjIQlATCjumtrEloyKtYnp8HjFX1+YzG
	 xSZqQSPdNFC9d9Sagzo7j8wISFYmFnjME8BVxZS3dOZB9c3VPOCIbBWSaHoim9Nw2n
	 yxPq/iC3+FL+qFEgOmqjgj2ivtVBWZleL0iOeiJcPyeNfjIHHrn+gixlnOqe9gJmhW
	 BsZj1d/PdCGHki4UXm1bTHwe9V0YD1aOkV6XnvifG4F8Cjv+9p5dnOHUnv5OPlnuhd
	 s7YGuB/YfBB+6b+cGvBPvxRWTJyIgm0AcE+xRTvYP36McbfYKQKrigx/zQqN4Ju1nD
	 LgryuIKU2WvBw==
Date: Wed, 17 Dec 2025 18:03:58 -0800
Subject: [PATCH 5/6] xfs: translate fsdax media errors into file "data lost"
 errors when convenient
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de,
 amir73il@gmail.com
Message-ID: <176602332235.686273.16829192636161125674.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Translate fsdax persistent failure notifications into file data loss
events when it's convenient, aka when the inode is already incore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_notify_failure.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index b1767288994206..6d5002413c2cb4 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/fserror.h>
 
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
@@ -116,6 +117,9 @@ xfs_dax_failure_fn(
 		invalidate_inode_pages2_range(mapping, pgoff,
 					      pgoff + pgcnt - 1);
 
+	fserror_report_data_lost(VFS_I(ip), (u64)pgoff << PAGE_SHIFT,
+			(u64)pgcnt << PAGE_SHIFT, GFP_NOFS);
+
 	xfs_irele(ip);
 	return error;
 }


