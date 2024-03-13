Return-Path: <linux-fsdevel+bounces-14351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2187B0B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021B71C220FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1945B5C5;
	Wed, 13 Mar 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/sJp5pD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE55A4EF;
	Wed, 13 Mar 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352808; cv=none; b=eBlRFJnsVwl99KX2fXd1sSpCOzJ1XeaFAQELsBJ70PEQsQ2A2sKLq9vgxmaXguX2jDU+5lri520oFmP9v7ysmqr0lJNofqrQOhd4tPMGIJRwOl+5m3UpJQDM5GhJDajUkVvbJjLIOHcAgHwMLeTCeEuxzi97UyfqQNCTLMbQyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352808; c=relaxed/simple;
	bh=gyY/eII/mzWjplxkissoGLEmgFRPREJ2adLdk/vMBuU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrtbfWiMhkrGWcl5ZteUF1t6v+iGw9v6Of740V9lCHi2ddgdC6K8mTJ+GEX2nCqYTpoIcvIdN52EyA20kk+GsxGK2gJM+5/vrzrWwdtgVXJjiicEcPCdgPM70CxNAfy5bcJpQGcpFxD6yjR+BraJRBne2fgOeMiDj55IAzcY8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/sJp5pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56646C433C7;
	Wed, 13 Mar 2024 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352808;
	bh=gyY/eII/mzWjplxkissoGLEmgFRPREJ2adLdk/vMBuU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s/sJp5pDwOwOAvK8aUNmsjpJmMf7KOZAS2PQHVuw84hfqkvIbJ0x+gI+hlpEDoeiA
	 CRIIKYC7a3rbSTg8wEChY/9RYIkomjoiuBbbedXt3w4MQeD0NqSaJj7GTdrWMU1Qw1
	 gSIY/N/zZwX7m5uqX2Oye17Pxu8GF1LLPU2/VAbP1/WAzj4/CGPQErOT9pcGyBpqya
	 3c5MD/OiTaLOItWgMnVmB/lIheGrscd3xntB45vUThxf8q/NdW+MrmiLBHHmqQiE90
	 UlF256YbwWFhAl7JsNEsrI4ksFVr7UCg9Td/GGTArv8ANfEyPLW2I7ItMjKk+inBlJ
	 GXiilD29e9WqQ==
Date: Wed, 13 Mar 2024 11:00:07 -0700
Subject: [PATCH 29/29] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223820.2613863.11590371205606569859.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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


