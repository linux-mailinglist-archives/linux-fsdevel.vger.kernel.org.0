Return-Path: <linux-fsdevel+bounces-14340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EC87B0A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28F91C2647A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE2145350;
	Wed, 13 Mar 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlYt4qu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2519145333;
	Wed, 13 Mar 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352636; cv=none; b=r5jKo942YE7qkW8JLnGIzlFV2KY6EPkbu8cZH1SHbHAPx2tnz7gJmwUFxn+qvpMDqto+quLM6GRwO9AmdvMIEQwY7QS3TcqJoAgWgp87Ez/Frc6wDjmOqCns0CAWPusKq/MyGIxY3s8PFPVy6aWHdUx+6K9PqI+Rkptu+DgEbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352636; c=relaxed/simple;
	bh=mB3EmY4L8UVv1yUNzGfufjLv8z0elMsZvlto+EA/uYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDkzyP8EGwwDnFdd9h2UJvCRc8y9JPg9I4byK5Ch52zq5uLdiCRMQ/hvCItesHlZoxlc/z1vS0hTdimPeQEMa4csUiEfs6Ywh7dUSnRN+i1PBqKwnHxGQPzoga3I2Mu72qtbhPDZaX3hjVROdifoFmYQV2vW+ZDPsnxM6RRlPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlYt4qu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB257C433C7;
	Wed, 13 Mar 2024 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352636;
	bh=mB3EmY4L8UVv1yUNzGfufjLv8z0elMsZvlto+EA/uYI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rlYt4qu17Qb7Z59LtEGLwJDiEwrF1rKAkcnqciKASghPCntZ1tszqv5Ow8l6OjTAi
	 oRtB47pR4mBFp1THM6RjQ2sfcT9Ekwrj7XysfyOrJsT+pl1yPt9L8LYHoi6AzOvYfR
	 jIGNgaueJRjPtty6VPZzpj93TF4bQcHwJXjxUHdYo6Fa3KSKfjp+rjMcff4XkoHI9X
	 h7s16acBIQl9aLjBuqc7b9QreAJwMJqRmWoUqVc6IzfapvO+LasGljNQiaYoqgokG0
	 8QfgmHh9g0cKjcgf3FXwM0is4l9AWAc5EnI8N/6R9fwLJi5VBFim1KfVY1/81EDcIN
	 +sUhyF9o19cLQ==
Date: Wed, 13 Mar 2024 10:57:16 -0700
Subject: [PATCH 18/29] xfs: don't allow to enable DAX on fs-verity sealed
 inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223647.2613863.14260697427402894964.stgit@frogsfrogsfrogs>
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


