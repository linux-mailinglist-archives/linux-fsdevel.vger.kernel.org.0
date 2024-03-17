Return-Path: <linux-fsdevel+bounces-14600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C287DE93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A361E280F8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0ED1CFB9;
	Sun, 17 Mar 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKg+Z+BA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4E1CFB2;
	Sun, 17 Mar 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692965; cv=none; b=IpFrRRYkVUcHssP8s9zfsZbtSpQL3ReFESQR0yCok6EK9WuR2SNtcq1AdOlUjGxE874nMpjCPOqSD+IYCkpc3JO2uNhEJLIK7yB6/fXnxUCi8MBe9Tgo7g5i9gL2t85Q82IhBq98UTuRA7GQ/2+uVd4nCNHA8kY5eydM/vlwooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692965; c=relaxed/simple;
	bh=mB3EmY4L8UVv1yUNzGfufjLv8z0elMsZvlto+EA/uYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gApfakrtUAMt/CUl3LpBE4SXeZUAp1tGhx8+NQvr3hABbg61u+wrAGehVRnStgQd7ZI0megXbs/sYz3kDVUjrDydQXX+89FRh4Dd5GK/9/s+X9sHPNL22+V+o+XBNVTginx8WQkcDtsz7g+KNaSnC3BVs0/IE7VM++Dj9w8pfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKg+Z+BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25849C433C7;
	Sun, 17 Mar 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692964;
	bh=mB3EmY4L8UVv1yUNzGfufjLv8z0elMsZvlto+EA/uYI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tKg+Z+BAyfPF19piV2ReYcZmFcRZHbNdLfDEutk5aWKqZaAdfNCZxV3+EYLw5P7Va
	 WVUZ7B8AHdo1U+dzZGDaOetTEdhCPfis/B5BGiFJ58TKU05k0rgQpwh4ra1MBbJ4yX
	 1MXH94takYTYt6FJ/KjI7F82JxXSx9Czj+bYJB2PL2gzySFGyvu4OoqpMIxGNiXTaJ
	 oQQPY+IKGxoRRixKV25MF/62VDuwgAgowPu4Q2k+vxJ5I8bH3bAfWkJDb/pY7Euea1
	 YCRU7OWpdY2CmHNBP/B5kLbry0T/Qb6Xev9qezkaBUiYK1ZTp7BV26pbedjttwemz0
	 eSsWV+/c3Qn6A==
Date: Sun, 17 Mar 2024 09:29:23 -0700
Subject: [PATCH 23/40] xfs: don't allow to enable DAX on fs-verity sealed
 inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246281.2684506.9599077093147119528.stgit@frogsfrogsfrogs>
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

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix typo in subject]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 0e5cdb82b231..6f97d777f702 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1213,6 +1213,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)


