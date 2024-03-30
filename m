Return-Path: <linux-fsdevel+bounces-15725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EC892850
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23AB1F21DE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7B1366;
	Sat, 30 Mar 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgeIUqh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B67E2;
	Sat, 30 Mar 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759121; cv=none; b=QNoSDSNhB13lTq/TjOO0CXGiNhzn+EYy4Mqe+G4+To+Xim0vbkRPhBps+fGh/Xm+B68yfEjHv4TNhHptyL+ZhJ/rdvgdj9Z0f3rfCm9N9Gfhn/FstRs3fHYLR+2ckmHEsxpA74QKIscHbeOjSA7cT8aRJSZF7uxVg7CF9sb3CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759121; c=relaxed/simple;
	bh=XO4h+cNXR4C8NObK/4WrmY1y3/y5g2qagPkEhdwIPIQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndFCRo/6wRl83l89fEcFeGDKH4BIoqHAHRvI99vPWrYl9TTeu/baMP/tvKKm93J0rdAKsr1W8qnJC5+llDSArcSFnFRMjSmVM3AxWiQ8vwC1tpdhOa7YhcjLarm+sv1AFdQd6zZyoh6MR2Etnk48sLtpfRB5uJRYFHc3zq9vWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgeIUqh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA55AC433F1;
	Sat, 30 Mar 2024 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759120;
	bh=XO4h+cNXR4C8NObK/4WrmY1y3/y5g2qagPkEhdwIPIQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IgeIUqh0+mV+47CqK+UqMAcyJQHEHvMOAFmSR0c4BwtYZwxqn9maXUCXlZM8FP2fJ
	 aPFcM+BEKplx/gjCg8USfTQPEXVcX7hNUp23jQFYIWQBt+AkIkk8JtQm2QDb8f4Ai8
	 KncTYutkSm9ji0DlRyc+K63tnFykd1Jrip++qSptsPLEjokySiYU4j62iQanRbGolw
	 1S0k+P9Hzvf6+cDuFdhlJtygNAQa+kw9bPFJSxsxgtd7NV3Q1gM8CENSi+SQW77KIW
	 OpLR0X/yjgT8bjvLdx88uwKMJVN7ubrsHA+cRDLvjeqhyBz9ErtLTpeZSpenpq/7wp
	 6ZhhrYysCZufA==
Date: Fri, 29 Mar 2024 17:38:40 -0700
Subject: [PATCH 10/29] xfs: don't allow to enable DAX on fs-verity sealed
 inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868726.1988170.5012461956800480243.stgit@frogsfrogsfrogs>
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
index b0672af049043..bc8528457a95e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1263,6 +1263,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)


