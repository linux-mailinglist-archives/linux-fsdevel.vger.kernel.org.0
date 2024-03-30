Return-Path: <linux-fsdevel+bounces-15752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9489288E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CC21C21135
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9F1366;
	Sat, 30 Mar 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCNsxMX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1D7E2;
	Sat, 30 Mar 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760326; cv=none; b=A60+r0fNL3t/klXCIeDtZ25vqQ2fDTvXuealZ15xMpmwzbDMWQbHBjmh2IY4R/zG+ApT2cEsLHrNb2ItJZ45WSKqaxjmHDMfMi4OhvwotnAgLqtGSqeOpgbVjZkLLl7uOASWt4IuafMLy2RZlx4IaQJRPltNfOwHOhy/9KDS5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760326; c=relaxed/simple;
	bh=d7ZQztzhv8NHZqQ9G3o53cTsLXEWNmxHYQP58H/0zu0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clPGoWm3Gz8E4wpAEMxLSuXr0LaxmQ59i/hm1SQ/oD5BTf6mXCTiZucjdLS4UBUwyv+CMfxGzeIWX5on/ibb9VLTuX5KCDCOXEhyX+dLIGeJmA98CVOKk671ZEo0ngjsD5WSIfBZ9HNxuNFVOX4/G615Z9RWl5uX9hCpeqzzdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCNsxMX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA128C433C7;
	Sat, 30 Mar 2024 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760325;
	bh=d7ZQztzhv8NHZqQ9G3o53cTsLXEWNmxHYQP58H/0zu0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rCNsxMX6JdVJNcd/sV4+bzy5VVT0tE6rf3ja03dZqJ6/qhNVNBmwHyCjQAS0H/hhj
	 N+heksIgAbs0leWGStVMUOaDIWgw0mznKsTodDrLzou8ePyX4N/YEEzdI4/QbL4IK5
	 lvClKhpJ+LduJ2DipQzYlIoEFsaSJNeqgVdPgUpHNvh43c1SOIykAQw7KtNp82SRzY
	 ylIVPq6UyoB9ank9cKo8QgT8D13VTkpmuAwlb7jH7AzXY1Fy6ulmEHJNyJIYO0TrrG
	 fi3+CbbSlNa1ONdCOVxJhapsvZlmAa93QNo1Lbz9kPZQa6axM/88eTT37p7e9vHBgY
	 f+0nfMNM0JQFw==
Date: Fri, 29 Mar 2024 17:58:45 -0700
Subject: [PATCH 07/14] xfs: add error injection to test file mapping exchange
 recovery
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171176018793.2014991.1691062056697188061.stgit@frogsfrogsfrogs>
In-Reply-To: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
References: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
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
index df53103b98785..7b51771f81968 100644
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


