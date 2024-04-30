Return-Path: <linux-fsdevel+bounces-18271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC38B68E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95109B23E87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A410A1E;
	Tue, 30 Apr 2024 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT6flQ6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82E10A0C;
	Tue, 30 Apr 2024 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448088; cv=none; b=opb2vhfr4ZyUZxkJw2CFdXsfR2p4oJ8KdumL1tICHYrbAQ/uiwKYJE1AZnKC8m8y6prfb1JBz5UVAF+pW27tC468e2AS6FcuM0HctwOXtFBxhdD5/Vb7RzDrO30Z6vCJK23cJJKF0UvURj2vByFeRs4TnKY3cxBi4wx6cT5/IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448088; c=relaxed/simple;
	bh=hmJOMOwk41JRVTWfJoBKJMwWmQsbOLdZ56PzB9yGz5k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=locCnVhztHm3oYnmMhD+HXjIVenxk1Gy2vw8OcyGwFPieGzCtO0+ELZqLyQnanSw+cKghcbRZux/E6dtQ8X5ouFZXJdOJxkaBFT+TW8GKiL1LH+oe+B2QszHzTUWtG3qClUpOLriP+1oDgHmSwOmqyr9jpwOD21qHVfnyz2jbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT6flQ6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F9EC116B1;
	Tue, 30 Apr 2024 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448088;
	bh=hmJOMOwk41JRVTWfJoBKJMwWmQsbOLdZ56PzB9yGz5k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QT6flQ6FWk+EgfQpVKr6YcHRXLDXlKsIttv9414hYFax/CMu3vD6W7JgU9iCR1SGk
	 GGQtzikJAS2UHGrUieqBFnfm3CKQBEDHVNJFM4xqz0cgRekcmLjsMYRjDsIIy6pmSK
	 +sgp+YcsVxhimDQiBGbXPYJJL7iL+/stfRCNAPhU7hB1CsYTbseC6Plszy1fnjEkEp
	 pE+l8OlIDEkWm8jpGQb0ApPJHHhSHMzAAhiInPcX61IDUvfNhT60Z5t4elxZXgvPgE
	 5gp+puUiosJCtSb41aiEwIOjg0aCG3IbsxaGmpildVjx8uS4j3TO4A2EfefMbW1Fk8
	 jNNFcVqqqc9dA==
Date: Mon, 29 Apr 2024 20:34:47 -0700
Subject: [PATCH 15/38] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683343.960383.9838479985541357618.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add spaces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_format.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


diff --git a/libxfs/xfs_format.h b/libxfs/xfs_format.h
index 810f2556762b..78a12705a88d 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
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


