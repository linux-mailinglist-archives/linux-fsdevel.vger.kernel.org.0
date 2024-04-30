Return-Path: <linux-fsdevel+bounces-18270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101988B68E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF3E284B8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981710A1E;
	Tue, 30 Apr 2024 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUQO1v4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E52DDA6;
	Tue, 30 Apr 2024 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448073; cv=none; b=WVnAAdMteNwN20hZ143JqBjCqFqIx+FQEXHwcTEm1p6DmtGHh3s8SoG3p5/C6bKmrsTBO+W/v7umhg9cGrRGRiU0WCP5qU13k3tWpjuzScWfd6J2lMF6zk+TZgbgW7yJvgjcOsk5OuaQ0Ao37T1DN4oaAc3KFBSzfm7hiKdjN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448073; c=relaxed/simple;
	bh=vNfZHfkPMIkgTvVvpDUyL0ktX6qq4b8te/IixIy3oUk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU8g/Ma+wEhr9Uyz1UzeJn5SEt2TZEbjxRH3BEbO+Uk/2hScN0200uxqad10QnrIQ+L71Onb4KZFsdmOGTlpcydsKUA6MCBt3Ais8wnSg6SYrPVzmSRmGZDy38vy2J0T1WlWr3/qdFRSSmkB2hKBb9ROPVOMNDXIqkCyr3Y3Pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUQO1v4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EACC116B1;
	Tue, 30 Apr 2024 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448072;
	bh=vNfZHfkPMIkgTvVvpDUyL0ktX6qq4b8te/IixIy3oUk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UUQO1v4fC1rXw05lkwaJldS7SCmRY2D+MVOuAu2vIjxWWw0GYQuClVhtVKtNG3KCn
	 l7oQFGhEnlPDG4drbQyFyVkWFU7zH0+VnkSrw8KbHq9IRa0Q/pDlG71ZQhpeaOkXw3
	 n68a1dO5XLWVWMzlKhjOOqwKa+ifk7H6TGvEWZHyRk+CQB0/lOJMgZgAyGBgYPV5QE
	 0k/4UJbZzXX1CTzNxyNvUU9lMEyHw5laN6cC5ikFxGGEo7lUWKV5vXSYOXon6mGHrI
	 K/qNjbr6+DUjOl52Ejm466C9ynLUA8Uf8ohRoX65RJyzAyoYelMn0OhiTCxL5mgLeC
	 8LbfP98tFQo8g==
Date: Mon, 29 Apr 2024 20:34:32 -0700
Subject: [PATCH 14/38] xfs: report verity failures through the health system
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683327.960383.5120437850763488436.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Record verity failures and report them through the health system.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_fs.h     |    1 +
 libxfs/xfs_health.h |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)


diff --git a/libxfs/xfs_fs.h b/libxfs/xfs_fs.h
index edc019d89702..bc529d862af7 100644
--- a/libxfs/xfs_fs.h
+++ b/libxfs/xfs_fs.h
@@ -424,6 +424,7 @@ struct xfs_bulkstat {
 #define XFS_BS_SICK_SYMLINK	(1 << 6)  /* symbolic link remote target */
 #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
 #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
+#define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
 
 /*
  * Project quota id helpers (previously projid was 16bit only
diff --git a/libxfs/xfs_health.h b/libxfs/xfs_health.h
index 89b80e957917..0f8533335e25 100644
--- a/libxfs/xfs_health.h
+++ b/libxfs/xfs_health.h
@@ -105,6 +105,7 @@ struct xfs_rtgroup;
 /* Don't propagate sick status to ag health summary during inactivation */
 #define XFS_SICK_INO_FORGET	(1 << 12)
 #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
+#define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
 
 /* Primary evidence of health problems in a given group. */
 #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
@@ -143,7 +144,8 @@ struct xfs_rtgroup;
 				 XFS_SICK_INO_XATTR | \
 				 XFS_SICK_INO_SYMLINK | \
 				 XFS_SICK_INO_PARENT | \
-				 XFS_SICK_INO_DIRTREE)
+				 XFS_SICK_INO_DIRTREE | \
+				 XFS_SICK_INO_DATA)
 
 #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
 				 XFS_SICK_INO_BMBTA_ZAPPED | \


