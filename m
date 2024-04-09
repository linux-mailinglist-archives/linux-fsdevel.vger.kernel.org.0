Return-Path: <linux-fsdevel+bounces-16398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9989D128
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB221282E57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164A54902;
	Tue,  9 Apr 2024 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAV5TPtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59554BCA;
	Tue,  9 Apr 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633781; cv=none; b=KOAQYnoa0nrwFiTh4zn7/gXff3WXd0Cvlwx3hrQZmumN4GTOivv2ep38RFsDFOiC5IhGNE4EOYxft22Nh/Pjb3CG9F3TCK13aR1V3bJ5SDw8IX1zmelYzvOi9dtEmpwTdPpCZNFEOfBY7YzjAPvAeIse0ulEHCdDCGgna4o1w1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633781; c=relaxed/simple;
	bh=iAGEAp51f0ypF8GK+AiSnXhDl/mSGKgYt3iunQkwwRY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR/gdD3spsY62P0lApiJiznqehvD9cL4UDWo8XOMovKOUQATeEhxHAAAqvjFQ175ArWO/YZQ9oi62UA0dkT+BLg3OMU9UbyRKkSNzYZRDM49f8qd2sP/yCI+HZ0/SXRr6b68Hx6Y9ZveuHADX7rRb5XOypMQPKZ4bUktCARb+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAV5TPtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA868C433F1;
	Tue,  9 Apr 2024 03:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633780;
	bh=iAGEAp51f0ypF8GK+AiSnXhDl/mSGKgYt3iunQkwwRY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iAV5TPtwWv2JneeUvp5UTblLwW7hlmUTxMOB1UHbYb04Joc/4prs6A+P70R6FaT5Q
	 ElwVNW2tZPHvJRmcwkMsY1zMXCWgVl24lPT650slBoTm1daXYH5txSWHMPjfrImkeA
	 z5Pgj+yGBnsiBiuWelmF2FbHRzNDNM/6ICV66DtzdFex4blXG8VSWM0Vx0vOsqHauK
	 65dWysVE1FVt27EA8Xgm7QJsq9uypiacgYZS4KiQuLw3j5h1cNGaqv64UCtaizZUF0
	 LMyLdK+lR3fr3QXGT5EbiUxrQe5tMOWfOn/BGzPSNbl8iqNlIEdez+3Ftm5UXTOP2z
	 V6DIZgo6xEQNw==
Date: Mon, 08 Apr 2024 20:36:20 -0700
Subject: [PATCH 07/14] xfs: add error injection to test file mapping exchange
 recovery
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348580.2978056.16415730475474828496.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
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

Add an errortag so that we can test recovery of exchmaps log items.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/libxfs/xfs_exchmaps.c |    3 +++
 fs/xfs/xfs_error.c           |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 01a9e86b30379..7002d7676a788 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -63,7 +63,8 @@
 #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
 #define XFS_ERRTAG_WB_DELAY_MS				42
 #define XFS_ERRTAG_WRITE_DELAY_MS			43
-#define XFS_ERRTAG_MAX					44
+#define XFS_ERRTAG_EXCHMAPS_FINISH_ONE			44
+#define XFS_ERRTAG_MAX					45
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -111,5 +112,6 @@
 #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
 #define XFS_RANDOM_WB_DELAY_MS				3000
 #define XFS_RANDOM_WRITE_DELAY_MS			3000
+#define XFS_RANDOM_EXCHMAPS_FINISH_ONE			1
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index b8e9450cc175f..3b1f29e95fea6 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -437,6 +437,9 @@ xfs_exchmaps_finish_one(
 			return error;
 	}
 
+	if (XFS_TEST_ERROR(false, tp->t_mountp, XFS_ERRTAG_EXCHMAPS_FINISH_ONE))
+		return -EIO;
+
 	/* If we still have work to do, ask for a new transaction. */
 	if (xmi_has_more_exchange_work(xmi) || xmi_has_postop_work(xmi)) {
 		trace_xfs_exchmaps_defer(tp->t_mountp, xmi);
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 7ad0e92c6b5b8..78cdc5064a8c4 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -62,6 +62,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_ATTR_LEAF_TO_NODE,
 	XFS_RANDOM_WB_DELAY_MS,
 	XFS_RANDOM_WRITE_DELAY_MS,
+	XFS_RANDOM_EXCHMAPS_FINISH_ONE,
 };
 
 struct xfs_errortag_attr {
@@ -179,6 +180,7 @@ XFS_ERRORTAG_ATTR_RW(da_leaf_split,	XFS_ERRTAG_DA_LEAF_SPLIT);
 XFS_ERRORTAG_ATTR_RW(attr_leaf_to_node,	XFS_ERRTAG_ATTR_LEAF_TO_NODE);
 XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
 XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
+XFS_ERRORTAG_ATTR_RW(exchmaps_finish_one, XFS_ERRTAG_EXCHMAPS_FINISH_ONE);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -224,6 +226,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(attr_leaf_to_node),
 	XFS_ERRORTAG_ATTR_LIST(wb_delay_ms),
 	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
+	XFS_ERRORTAG_ATTR_LIST(exchmaps_finish_one),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);


