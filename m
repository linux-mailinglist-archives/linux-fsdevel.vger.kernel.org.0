Return-Path: <linux-fsdevel+bounces-14630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8187DED8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33227B212A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B11B949;
	Sun, 17 Mar 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlajFgf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C81CD11;
	Sun, 17 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693434; cv=none; b=jKyK6OLpwE3F5oYjyUXROBrnkkbgO5/Op9JgxVKpjFKpLdRJzDp/zpfS4qd2Wz0zVBICjX//6jkjVj9+wsS5sYeMoehSLw9il52WQxUzcdDkda4kxaFqNrI3q1nk03pyy0h6G45m/64/vmI0xgCDZhh+uStXSCXOv72gYfVWx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693434; c=relaxed/simple;
	bh=IvIadUcLpBYOM/jjLq7NerajEG6TfC/KMPfSJnKLroo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoHg8E7OjAGTOxwsLs/H9K8/hdMo+69VEtlDUZyZ0QEYoHXSxB60Dk7+gp1KM+8w+cwh5SuyeXvK0D9SemdHBLJHoDnF/5OFDp4QFQyrX8Bblsb005vl8FS/VgAMmFHSjws2KMxUP0Zm/dPeLDRxdyg/7OAc4Osx+jKkio+zwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlajFgf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8477BC433C7;
	Sun, 17 Mar 2024 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693433;
	bh=IvIadUcLpBYOM/jjLq7NerajEG6TfC/KMPfSJnKLroo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FlajFgf+KfWk0PYkGtAcOwxK/bcTbF+NUYOfO5FHprORq76MY7FQTeqnOaIsMx+eF
	 1/FyNAwasSwpquIvu5NLtteNSc4Qi57ca/Ai0QigLfdYpEDtoOQ12M7afFawFMAgnM
	 wBPqiJa3+mr4pjB6aYlO0tk7LHETRa5cKrDqQbKb5OURs5XtjwFIXOnarIOEonY46V
	 5FBiR3yMGOhATjXSJkyYT0KCwwQcs1yE6DmtwOmrp8aYs3btRiA7rEtcP/SjXuzsqm
	 TPzzhvG0ER4JCSpjEtlsOuI2RRx0AQmpBMONKkherFBbmI+0dMp1/iECH3BDw9skb7
	 hXDIyvpYVin+g==
Date: Sun, 17 Mar 2024 09:37:13 -0700
Subject: [PATCH 13/20] libfrog: add fsverity to xfs_report_geom output
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247855.2685643.2767239263618962002.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Announce the presence of fsverity on a filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libfrog/fsgeom.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/libfrog/fsgeom.c b/libfrog/fsgeom.c
index 3e7f0797..502553bc 100644
--- a/libfrog/fsgeom.c
+++ b/libfrog/fsgeom.c
@@ -31,6 +31,7 @@ xfs_report_geom(
 	int			bigtime_enabled;
 	int			inobtcount;
 	int			nrext64;
+	int			verity;
 
 	isint = geo->logstart > 0;
 	lazycount = geo->flags & XFS_FSOP_GEOM_FLAGS_LAZYSB ? 1 : 0;
@@ -49,12 +50,14 @@ xfs_report_geom(
 	bigtime_enabled = geo->flags & XFS_FSOP_GEOM_FLAGS_BIGTIME ? 1 : 0;
 	inobtcount = geo->flags & XFS_FSOP_GEOM_FLAGS_INOBTCNT ? 1 : 0;
 	nrext64 = geo->flags & XFS_FSOP_GEOM_FLAGS_NREXT64 ? 1 : 0;
+	verity = geo->flags & XFS_FSOP_GEOM_FLAGS_VERITY ? 1 : 0;
 
 	printf(_(
 "meta-data=%-22s isize=%-6d agcount=%u, agsize=%u blks\n"
 "         =%-22s sectsz=%-5u attr=%u, projid32bit=%u\n"
 "         =%-22s crc=%-8u finobt=%u, sparse=%u, rmapbt=%u\n"
 "         =%-22s reflink=%-4u bigtime=%u inobtcount=%u nrext64=%u\n"
+"         =%-22s verity=%u\n"
 "data     =%-22s bsize=%-6u blocks=%llu, imaxpct=%u\n"
 "         =%-22s sunit=%-6u swidth=%u blks\n"
 "naming   =version %-14u bsize=%-6u ascii-ci=%d, ftype=%d\n"
@@ -65,6 +68,7 @@ xfs_report_geom(
 		"", geo->sectsize, attrversion, projid32bit,
 		"", crcs_enabled, finobt_enabled, spinodes, rmapbt_enabled,
 		"", reflink_enabled, bigtime_enabled, inobtcount, nrext64,
+		"", verity,
 		"", geo->blocksize, (unsigned long long)geo->datablocks,
 			geo->imaxpct,
 		"", geo->sunit, geo->swidth,


