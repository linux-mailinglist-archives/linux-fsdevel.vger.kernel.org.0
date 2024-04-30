Return-Path: <linux-fsdevel+bounces-18240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658D78B6891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967CC1C21A38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CB31078F;
	Tue, 30 Apr 2024 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlM4gPEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5610A0C;
	Tue, 30 Apr 2024 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447619; cv=none; b=HIuvDs8JaFad7rM8EIDXKR7BOYCdaU1TtfmcVfW32dbKukr94KsxqUdTUryYJJy6Dey+2b3eBXzqp/rEonjW/VQBl88MkJ9lYT7DpuHLtKonfArwAvImDs5F0Zd6etiqTHpfySCoViZa0JqreFF2CB7003H1wAzJtjV0/aAQ6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447619; c=relaxed/simple;
	bh=seoaZ1nac92316SJ3djjvoeiJ4rp9GsDmlSXJ+4gOkQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMIKwey9aY4hrPuYtUTT5iA4djW/kpmaxITeHlzBUYTlgCyoJAT9XJIC0Fv92AqrZeegMB8F+4v7ZnM+tKzDvC6mrWELe00DJuusOFFFs27H0M5VzH2tOvVrZevytn4SHxe/T6PalueBHtvZ0aEWug7Xekm0puvZaDA6zpz5qck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlM4gPEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8894C116B1;
	Tue, 30 Apr 2024 03:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447618;
	bh=seoaZ1nac92316SJ3djjvoeiJ4rp9GsDmlSXJ+4gOkQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rlM4gPEkp1gB6BFtWh3f+9x9RLgZgkxEjnFyVS5aVuqNUuHiGCW5nB5xlo8QtHj3O
	 B6f22UOAkwrqkBmBwBrwgZnTooWqVqvX2Qr3yHLxGCVIln6Q9vb0/HZogdiBW+Tld3
	 qXYFGeyGHiVyIy4Ahe+4eBWBMs8VGcrI1MtcNepbztfROsLUFRpU1LegfzTT/Fe1xS
	 htgG+uyRFDTxu53/3xDPeZzU9p7+JXteXqV32DTaYVWH/hu9SAVngDjiUjLgY+wbFE
	 K1CMoFdiELgWhbHw0OXFeDR+edBsIt41mOCf0lAaH3ZloYVdxX/5SU18THeMXM8UiP
	 lzvZa/lWpFLMg==
Date: Mon, 29 Apr 2024 20:26:58 -0700
Subject: [PATCH 11/26] xfs: don't allow to enable DAX on fs-verity sealed
 inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680550.957659.8847933354597056187.stgit@frogsfrogsfrogs>
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
index 80e3c2a3c6dbf..2d65da94631c5 100644
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


