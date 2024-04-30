Return-Path: <linux-fsdevel+bounces-18251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB198B68AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F82B232B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB511733;
	Tue, 30 Apr 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtMYgKiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3615AF1;
	Tue, 30 Apr 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447776; cv=none; b=lFbPq9DboblG6CjI+zDyTuPOrcsIR6cWuXYxu1TEZzLV0nzENeHFoHSSrRuPUI3AgJz+YzewhZ2SSCBWfrKUEfWXzlWTAKAjx2I/S4bkZtkxG4Vo5096Am3izU3cxQR+v/a7grJPoYp1Ig9jaWISCY4On/8Dhu/TmUwAPQL67vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447776; c=relaxed/simple;
	bh=6UfOOkmIzgs/PBoh1s47ueLRjZlq3bISirs+72M5N3M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPC3KUvi63EK0m9aXmGer+Wiew+41/lrgQiA344V96cFPXzxNIH6D0SigeBzl2SrsvQBCXg3j07+6S0lIfdEt5Y1uZGWH7Ja9PWmMZ+bC+dicjRwi0i0GwvsJfLOQ+fLqCS3g61ZOqImPhGgtqvS2HpwOjpOfbRFl4SIIusXil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtMYgKiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6317AC116B1;
	Tue, 30 Apr 2024 03:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447775;
	bh=6UfOOkmIzgs/PBoh1s47ueLRjZlq3bISirs+72M5N3M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TtMYgKiFXyBjOl2rY6WWRfrl2S3nj7crO9MExddmJGF2fokpKZEYLIfNXR7be8L7F
	 X/UXsbIWMJXTrMnvJtHXkWELsBG5NpHtbvbmzFCQrEEY3PA2dcbE+mdOSFZqfC8pyO
	 rc8wKDOEwAIB2dFxrirbh+A3uyNKW9psYL6wdHmnYYnhTEih7nuKXXBUqIT/tdfvyR
	 SunYdONtjIJiHbo0g0D6/aAKG6ydknVtkELJSzU+jTOHwPja9VxJ0svxKbC+ObRrT5
	 n8MM87jJnDmJnpjH4tVaHWzXEjTw/M39kPadg3v3achDCuum+CbDcozfkCEz6to08J
	 SfbBAz62xi3Lg==
Date: Mon, 29 Apr 2024 20:29:34 -0700
Subject: [PATCH 21/26] xfs: advertise fs-verity being available on filesystem
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680723.957659.14764559681515919831.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_fs.h |    1 +
 fs/xfs/libxfs/xfs_sb.c |    2 ++
 2 files changed, 3 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index f9a6a678f1b45..edc019d89702d 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -246,6 +246,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE (1 << 24) /* exchange range */
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1 << 25) /* linux parent pointers */
 
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1U << 29) /* fs-verity */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1U << 30) /* metadata directories */
 
 /*
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 0bf5b4007afd8..29fcbe24f33fd 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1437,6 +1437,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE;
 	if (xfs_has_metadir(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 


