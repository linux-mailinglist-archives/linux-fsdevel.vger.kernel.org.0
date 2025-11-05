Return-Path: <linux-fsdevel+bounces-67048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B5C338CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB8C18854DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FD623EAA5;
	Wed,  5 Nov 2025 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfJOKDVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FB184540;
	Wed,  5 Nov 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304096; cv=none; b=TuNcPZOXnN8BpN7WQyR1mJ7fDCWXbndzAC6y91J5VOaucjd9z3c0GqiZ8DSchjBscrzco5/dvqPkS/9HE9JAgsKReBvj7mo0v3qZ4AY6eIbvV2565rxb+JiP+/yzrKzRcN7kP3FuAvFYPzqY84VTMPX4N0qZ3RtTjiJxvajP4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304096; c=relaxed/simple;
	bh=4AbJOl73ScYswtvriE7+d7q+09nIwh5qxCgqYHJOvXc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baRfiPx4+bTNm4RzuPJleevldtllfvkWsRunwJOGufIg5cfmdvS3hAtdk/GJE1C/iAvqv5brdHy11QgS7eQ1gTPyYuyJam5lhD0r7MCz5Uh45f49ztxilG9GDqafrNgUo3Ep92IX/cLuvl8RX88AoQA6koVIsWW4Ed4PDubuiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfJOKDVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80257C4CEF7;
	Wed,  5 Nov 2025 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304096;
	bh=4AbJOl73ScYswtvriE7+d7q+09nIwh5qxCgqYHJOvXc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dfJOKDVr/uOLyw3QgKzzvERFQIcVJEZrL4y4KDTpYlDQTQh9p5HvbSyjGJMemhMBm
	 nEAVQghpE7nRQyMuozZWu51o/t7kKT2qby9QfHdyjcCVs7reN6OK7L4qKYU91E37KZ
	 n8+ga/tXuqr/W3Ol1J/r957QySggGWVDq9l3Re8IKmBlQWpjjfs3lIBQiegihS6yzY
	 qUlFjxL3YgwM0uRwFl7MEVmQKSIFaxvW08Httq2i10ZRtkTGEeeln4ZKL0YewoqzBe
	 aKgT/+Qnv74JsmiyxCgIt3HzB2ZB1uYKoJs9wE3dh9JJmOLJAy7bW+zWyvetYErJFl
	 geWTrrHkPutvw==
Date: Tue, 04 Nov 2025 16:54:56 -0800
Subject: [PATCH 3/6] xfs: port notify-failure to use the new vfs io error
 reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366497.1647991.11938828755519357221.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Port the media error notification code to use the new generic reporting
code.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_notify_failure.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index bf6e1865d5c3a5..20f040a35537f6 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -178,9 +178,10 @@ xfs_dax_failure_fn(
 		invalidate_inode_pages2_range(mapping, pgoff,
 					      pgoff + pgcnt - 1);
 
-	xfs_inode_media_error(ip,
+	inode_error(VFS_I(ip), FSERR_DATA_LOST,
 			XFS_FSB_TO_B(mp, (u64)pgoff << PAGE_SHIFT),
-			XFS_FSB_TO_B(mp, (u64)pgcnt << PAGE_SHIFT));
+			XFS_FSB_TO_B(mp, (u64)pgcnt << PAGE_SHIFT),
+			-EIO);
 
 	xfs_irele(ip);
 	return error;
@@ -496,8 +497,8 @@ xfs_report_one_data_lost(
 	if (rmap_end > lost_end)
 		blocks -= rmap_end - lost_end;
 
-	xfs_inode_media_error(ip, XFS_FSB_TO_B(mp, fileoff),
-			XFS_FSB_TO_B(mp, blocks));
+	inode_error(VFS_I(ip), FSERR_DATA_LOST, XFS_FSB_TO_B(mp, fileoff),
+			XFS_FSB_TO_B(mp, blocks), -EIO);
 
 	xfs_irele(ip);
 	return 0;


