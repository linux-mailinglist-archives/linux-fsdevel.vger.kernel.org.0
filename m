Return-Path: <linux-fsdevel+bounces-14617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B786987DEB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7571C2035A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310B63B3;
	Sun, 17 Mar 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKK210F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D81CAAE;
	Sun, 17 Mar 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693230; cv=none; b=q9Ia+tvjrMmtdlP5V8ZKSTkL+LhP3lT+rK2xMm/CjOVAn00xAx2DU6IKAbHhmZdSD7p3bVSQyTUxkvEbfdUpQ1u9WICCQ5MuyG1t/ak1DiQfGF4CZxHIJhg26NFjKEYVX4FIwI/JPUpoOsL5RfzeOr9/UHnxbR8YKXyVYt7K/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693230; c=relaxed/simple;
	bh=gyY/eII/mzWjplxkissoGLEmgFRPREJ2adLdk/vMBuU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddO3ZUbu6yc4PZGoyt+ezsj/pRBpR4913YitKHBOQBGbjPl506ivMKHfCB0i6xgEbOnHQIlP7ofRtAZoefT9csQwIcPZ5NT2NQR+Zp92EYblaMFW4l92Kcfk9GcBmxjERgmE5F7YYEmR7ss1PWjE8dLed5C138dmkJ7/tXvflQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKK210F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B75C433F1;
	Sun, 17 Mar 2024 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693230;
	bh=gyY/eII/mzWjplxkissoGLEmgFRPREJ2adLdk/vMBuU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ElKK210FGIyjuocmHG1Cw3Gwh40Mzn83HesvO+H+xq04luaWNqrr3C03ecKzuWyBl
	 HlDCEcf8JKem10qw3NjYMDSsstIHIGh2HjJ406dq745MSOdBQgpM5bxRJqko7LR55B
	 uwVlhChqwz6PrtY0xoUiv9GRitatiqzisoerkDarh9Ov6ZQZ/P1xYip7U0HDyZj2az
	 WbQbk2gx1DKkAfJ0sdGA2blRV4oz5+iK2FejOWZo8NPfpBHIEIaAq9ZKfTI/0QjpvS
	 ZsGF+Zxw4odxhC1lfFBMvPOV3/NBcuTxH5OLbJvM3lCFxsK6+1GISc1zwIOlBiYQfb
	 9Y6biv75v/OOA==
Date: Sun, 17 Mar 2024 09:33:49 -0700
Subject: [PATCH 40/40] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246548.2684506.17460791341103657493.stgit@frogsfrogsfrogs>
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
index 3ce2902101bc..c3f586d6bf7a 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -355,10 +355,11 @@ xfs_sb_has_compat_feature(
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


