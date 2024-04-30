Return-Path: <linux-fsdevel+bounces-18272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4738B68EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619FD1F21515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5910A1E;
	Tue, 30 Apr 2024 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drUQvWDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AC10A01;
	Tue, 30 Apr 2024 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448104; cv=none; b=P8OH5tjUK19ya40zv1pvA2HMBzRN0daX6XwA/YsdEo+v93H1zf+MGxfAygb081q3irUHz13740+3Cn3RblOIpBuceSedmTpqUa95vh68KGU3o5/9etX7JxsjTUO/cycEOgHPe0rxW7SyCTivTz00abwwfTusYW92NZHurqsz75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448104; c=relaxed/simple;
	bh=HOS6WdiKFJC173Z2Oe52jYwWeMqhC/Qvwq5X6huJW+o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLiUHWXS2GwTmYBd3cXbfzSDyo0VrDpBrlaafvvUsaVMc0K9w0gEz1BpcgDOJnINEQZ7aWhAlXtnGEqCAzp/SHoBq63NAeQ/ng+euHljSsV/0yuQBVRCVf2ZmEKTGPJ2r8uYkB52JL4YyRWz5ohHJUOaZtrdZ71tG+E+Gxkp2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drUQvWDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160D7C116B1;
	Tue, 30 Apr 2024 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448104;
	bh=HOS6WdiKFJC173Z2Oe52jYwWeMqhC/Qvwq5X6huJW+o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=drUQvWDE5jUmInd2XuBsrleoB83xKYUTh0+V1+gFRAMOGsAQ1chmItquDhC9Wkqip
	 iNJajO+qJMKuzYo16fdoNQatVq1fxr+Zujw4rQSQtiF53jjMh6PEgkp5jDqRlAIWHZ
	 qd5eqkw/vrsW6D+zhkf88Rksrx2An4TB8gHlkBMVNQEN35wu0nTOW7jNqAyCNUv002
	 35QoUY03QyIPdUaPBdp+kNPKrWaKGbhTGKpMVoJjtb+IyapIwGWdeLSiDsUKOfiYOm
	 MiQ9PfOldnAfV3Z5WejeXAGL1Yn4hXKTysKI0rxkZMcudgdhz35NlaRAAnYte+coI0
	 6nB1dpfE//A8A==
Date: Mon, 29 Apr 2024 20:35:03 -0700
Subject: [PATCH 16/38] libfrog: add fsverity to xfs_report_geom output
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683358.960383.16789390120394175042.stgit@frogsfrogsfrogs>
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

Announce the presence of fsverity on a filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libfrog/fsgeom.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/libfrog/fsgeom.c b/libfrog/fsgeom.c
index 41958f00ce34..99d6d98e4679 100644
--- a/libfrog/fsgeom.c
+++ b/libfrog/fsgeom.c
@@ -34,6 +34,7 @@ xfs_report_geom(
 	int			exchangerange;
 	int			parent;
 	int			metadir;
+	int			verity;
 
 	isint = geo->logstart > 0;
 	lazycount = geo->flags & XFS_FSOP_GEOM_FLAGS_LAZYSB ? 1 : 0;
@@ -55,13 +56,14 @@ xfs_report_geom(
 	exchangerange = geo->flags & XFS_FSOP_GEOM_FLAGS_EXCHANGE_RANGE ? 1 : 0;
 	parent = geo->flags & XFS_FSOP_GEOM_FLAGS_PARENT ? 1 : 0;
 	metadir = geo->flags & XFS_FSOP_GEOM_FLAGS_METADIR ? 1 : 0;
+	verity = geo->flags & XFS_FSOP_GEOM_FLAGS_VERITY ? 1 : 0;
 
 	printf(_(
 "meta-data=%-22s isize=%-6d agcount=%u, agsize=%u blks\n"
 "         =%-22s sectsz=%-5u attr=%u, projid32bit=%u\n"
 "         =%-22s crc=%-8u finobt=%u, sparse=%u, rmapbt=%u\n"
 "         =%-22s reflink=%-4u bigtime=%u inobtcount=%u nrext64=%u\n"
-"         =%-22s exchange=%-3u metadir=%u\n"
+"         =%-22s exchange=%-3u metadir=%u verity=%u\n"
 "data     =%-22s bsize=%-6u blocks=%llu, imaxpct=%u\n"
 "         =%-22s sunit=%-6u swidth=%u blks\n"
 "naming   =version %-14u bsize=%-6u ascii-ci=%d, ftype=%d, parent=%d\n"
@@ -73,7 +75,7 @@ xfs_report_geom(
 		"", geo->sectsize, attrversion, projid32bit,
 		"", crcs_enabled, finobt_enabled, spinodes, rmapbt_enabled,
 		"", reflink_enabled, bigtime_enabled, inobtcount, nrext64,
-		"", exchangerange, metadir,
+		"", exchangerange, metadir, verity,
 		"", geo->blocksize, (unsigned long long)geo->datablocks,
 			geo->imaxpct,
 		"", geo->sunit, geo->swidth,


