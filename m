Return-Path: <linux-fsdevel+bounces-14629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69187DED6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFBD2811BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2321C695;
	Sun, 17 Mar 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv4Q6hj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE55221;
	Sun, 17 Mar 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693418; cv=none; b=NVATsozgfVpeQIqHxUnLoJJC2zDAZeosNl34cOI/SbFwN3UtejtNzV4SkrBNBDJoelwUIKgBGluX+TBnLNSOj5D7FV1aTsUtfPMw5Pw0V45bqsilrlzqh0JNUXSYD6zZ6p7Hy3FVvgTzke0HAnqi3YtLPTXaxcBuweNYB6rZj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693418; c=relaxed/simple;
	bh=tTRp75YPB4cHJxAnvL3nPcn+3M7UemOcQwcM+jsR2Ig=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5tqYxbnTEAKxMFJon9o/YUpUZF/wnPod4sjz+nnze1TibkisTMyh7ohFXfUgkUlmaYzCTqnaeHje8HK4h/8/WBJTti4quQxNRk/8G4ZAmt3Z3Gu2YvvhdfHJGzo1NfcId6ukLjFzBmCEaHz0DfreE/akPAUqSARCpYJM6A9nA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv4Q6hj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3771C433C7;
	Sun, 17 Mar 2024 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693418;
	bh=tTRp75YPB4cHJxAnvL3nPcn+3M7UemOcQwcM+jsR2Ig=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Cv4Q6hj+6S/o9sRztdoOj9THpOaWb7VYup2mUF8BKvA4THsT+S69W/XauyeDKBYkp
	 XcD6t/C6utDtlspw0WXmmw0JxePJ/9hsn1kfzAKQWKQ7dgNlF7JgbsEkuKrug6ChuV
	 efNKhrf7ItuIlh4VCMU5GY7lzoiWPW5A3AXJNz08JnuD8vvYm+l+aNL34Whc4V8cc6
	 EdSqGMnANw7uPk52mp+R+eoVJs2j5QqHRpLWw2rQkiXZ0hlgF6kjd+V1HYkD/Lvm+T
	 omF1Agmha221RgSM7pjt0It4l9Jzwln5AMr/DlvYX6dBLmB5t/b//wRyaH4XinCr8r
	 G6BBuKK9/zBFw==
Date: Sun, 17 Mar 2024 09:36:57 -0700
Subject: [PATCH 12/20] xfs: enable ro-compat fs-verity flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247841.2685643.9656163171263399183.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
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
index 3ce29021..c3f586d6 100644
--- a/libxfs/xfs_format.h
+++ b/libxfs/xfs_format.h
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


