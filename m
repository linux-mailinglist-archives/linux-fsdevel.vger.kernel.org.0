Return-Path: <linux-fsdevel+bounces-16999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20F8A5EB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2911A1C214E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE815957B;
	Mon, 15 Apr 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCvwVho3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5C158A23;
	Mon, 15 Apr 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224683; cv=none; b=eXXA18lEKSez3CNLF65xFYtr/ix1j1gN8EEgO4EpoWa5Vu2qMX8DD7Gr7BhngLK7XpspKpTfbnfAnvy2yeFaR3TCeO2JVTOqRo+JRnaexuJhiAS48M5nRoQTvCULCnAzshOpyMmXgdCbKebXwHL1xXEnIzDEtF1LPOD2Ge6XrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224683; c=relaxed/simple;
	bh=WAI73Uu7nO9tQigS0kmBsLraPFqsatNV7Smfb0EW+qQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy7NcgBSX4lviKq2864k+E2xfU7PPjKG/VhwFceiTlPJ9+0nMOTFYeISi0TEojbbrenc6Dv1HxwHPSSmgS11jsXaexhULoUO3V2sFdBHFhlOaA9Oq9Ej3NhsOp4wS7HMA3jrYNZ0ZYm8cSirb97BhoBmIL7N/Wcuv8Fbs+TnaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCvwVho3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A929C113CC;
	Mon, 15 Apr 2024 23:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224683;
	bh=WAI73Uu7nO9tQigS0kmBsLraPFqsatNV7Smfb0EW+qQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KCvwVho3T596FT3QUJEUplGMQCHFjBwhCN9gBfv8qJ/iWBFizKtZjIhZ7gn0x7NI+
	 rE+feJtM4TlvMPQIKncjtYH9m2axWh/Ne7B9Efqaxb/hLoL6QhwYH7sINMGkUIzs90
	 YqvNHiZ5d+oq9VjSWZQ+vY4SSVRuUVyQ/ISVf42raftThZh8Bm7sLSbK3Z4jRjZ09P
	 Iz1iMkaioJ3r03v0nbzC/7vG/tgnhABfgplr520oTyG/Yx3Q04UWYMU20wuLbGhYs1
	 Ko9oWCaJGlY5ai7HHT7VatR/l50UwW/dn0ZDFnBXlkVupFwwWXBDYw8C+yOMoClDV/
	 rsy1oV+iSIr8g==
Date: Mon, 15 Apr 2024 16:44:42 -0700
Subject: [PATCH 15/15] xfs: enable logged file mapping exchange feature
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381474.87355.16799970750666517534.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
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

Add the XFS_SB_FEAT_INCOMPAT_EXCHRANGE feature to the set of features
that we will permit when mounting a filesystem.  This turns on support
for the file range exchange feature.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_format.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index ff1e28316e1b..10153ce116d4 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -380,7 +380,8 @@ xfs_sb_has_ro_compat_feature(
 		 XFS_SB_FEAT_INCOMPAT_META_UUID | \
 		 XFS_SB_FEAT_INCOMPAT_BIGTIME | \
 		 XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR | \
-		 XFS_SB_FEAT_INCOMPAT_NREXT64)
+		 XFS_SB_FEAT_INCOMPAT_NREXT64 | \
+		 XFS_SB_FEAT_INCOMPAT_EXCHRANGE)
 
 #define XFS_SB_FEAT_INCOMPAT_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_ALL
 static inline bool


