Return-Path: <linux-fsdevel+bounces-18256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797F8B68BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78C2283421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481310A01;
	Tue, 30 Apr 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl+PTkEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA52FC02;
	Tue, 30 Apr 2024 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447854; cv=none; b=qMNTeCQLz/nIFKi+DlLn0CwxTMAdIegMsvq34lrIJF/oyTzGIg+feUzRvEmDMeH8hEkQOOxfJRNTHjQXPbn0MCT7A3xckpttLMRLPN4jTP3Omy99oL69LEa43gfHN8wJBiQ5ZG0VrIq7x+aBIveKqd+KJZa4PGIVE6psKOyqV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447854; c=relaxed/simple;
	bh=M8AM9IxxGqoCgTZ0iQiBDvLoNrgbrCBLplb4gk4CjyE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PneQnk52RTKJZD0yhheYALCjTRfTIoK30GldhBm+RoIITCgTf8IzCAPvbswqyT9+a9+50g12+O4IMidWibxfpz9lvFpIcrnuVhtB3u0NMBfj1zgd1L58TJEoXDM7g8KSWFnemSj9+aMW1t1pdRjKDHWLTeOdAGx6iN+3rhyck6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl+PTkEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82419C116B1;
	Tue, 30 Apr 2024 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447853;
	bh=M8AM9IxxGqoCgTZ0iQiBDvLoNrgbrCBLplb4gk4CjyE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zl+PTkEajqFUYD3rIMbX71oO2k/U3wc+u4Zr0Hp9nVdwJAL2jKYuF/i5yGoF6SVns
	 PWCRV1nn5LltywKCH6WfCYo+wz54AOrFDFQOKWYj70nm1tSGdLSFKnVLGQf4QDSnfA
	 ET4FFiOQBOXHlSpgsDFo8zvRplelOlLwIyDuwn/ee9p15KPSc9+mqTQe72x6SicIU3
	 ZbPlvGaZPf4i/uxGNfSdAg2quvPa/XY4kJmBvZayTJQGcVY8U4VESMb6NcXQYfkwv/
	 MxrRgyIyf+Qn7c4RIrnLUBVW9a19XPOXY4qRWb4kr0AMPOiDrfQS/Wa7SWcAUZJIay
	 enM9kMrf2kcRA==
Date: Mon, 29 Apr 2024 20:30:53 -0700
Subject: [PATCH 26/26] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680811.957659.5776113562801329570.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add spaces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 810f2556762b0..78a12705a88da 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -389,10 +389,11 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
-		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
-		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		(XFS_SB_FEAT_RO_COMPAT_FINOBT   | \
+		 XFS_SB_FEAT_RO_COMPAT_RMAPBT   | \
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK  | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(


