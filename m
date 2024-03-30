Return-Path: <linux-fsdevel+bounces-15744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E40892878
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCA3B22BFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7710FF;
	Sat, 30 Mar 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5sm+oQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6593197;
	Sat, 30 Mar 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759418; cv=none; b=S7qQgNN9pO5xQ8TgM6hgQTn0VQpr63JR9FXaCRkP1mEgAt1WxnRlnwDIbavCzq7qPzpY3tGy5L83tj6JLCyY8nGXl+CihtTM46QQGHDjxOBbcxmaOsZYAv7atotpOJiWjONzK+AtB3Y1YKcYQykckBTKwHLlM1nK+I2y6eJVZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759418; c=relaxed/simple;
	bh=WvoM4bGDPAT+NRgCgUDOoN8B22Q4pofrFwdwUY33KFo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFRp2uULGJJnSvSSRfXXVpqGZs88TPAOTRRhYcP8okGu6VFiYseZCcVwMzJHEtBZoAtNOQ9Ea74fp8DhUlLjYXopA5FK4PjMYDCjfaN1AYecct1xG7tOJImuq8n6II7Ro+OapLJAs9axoh6vGKkRFQEEv7kvO3muA7nQLu0ULUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5sm+oQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52374C433C7;
	Sat, 30 Mar 2024 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759418;
	bh=WvoM4bGDPAT+NRgCgUDOoN8B22Q4pofrFwdwUY33KFo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H5sm+oQPrXroLsmuWTiN04PnCn57StUz9vox6/PUNBxzRz8u9ek5dqWQmvgeY861L
	 mU7QJLx7hoU9byJgPWVLhbdFoXNWReYLKKf3Pik1f2fK3P2ArhbQ4R2cR+Veqo84in
	 lFgSIpcBS1fKlr0N65z6xEgxgN9tp5CbGmKdLXZ4g6Atcd6Ger7tAHQ/Qj1WcJ/n0E
	 Czv8HnyAFAHc2R0t6ifP2/ItFxrfd7KSeXTIIHqdB3gNFRFymjgg3Ip/eEB9/AyN/U
	 UcFjWwPfOrUGasMM8SJL6Tc7mkrlTJP2AvhC5sF+oyiq3Eg/Cu3PydJTWybrlFRTX0
	 NeNIdLcKIVzOA==
Date: Fri, 29 Mar 2024 17:43:37 -0700
Subject: [PATCH 29/29] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175869039.1988170.10476232511468225509.stgit@frogsfrogsfrogs>
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
index e7ed55f747d01..5e2342c56d499 100644
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


