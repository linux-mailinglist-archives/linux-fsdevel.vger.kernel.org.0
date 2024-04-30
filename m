Return-Path: <linux-fsdevel+bounces-18232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BE8B687F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E94284DA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568410799;
	Tue, 30 Apr 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaH1dqOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D185F4EB;
	Tue, 30 Apr 2024 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447494; cv=none; b=OrVVEidvYHg//Ae/BhOw6SyCs0F8YBnCI9Z9RE/tdkGRh6+N4WwkPyERCIHqMHZq//pMdjFajK1pr8e8rjJcVGV6f6rd4jaPJzsL3co6chRLGWiOookoH3P709qGVgIQfjFOUnT2u8q3TxTxBOq0/2lx2suVhA6erhlA0WvGfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447494; c=relaxed/simple;
	bh=nQvR2NC0oMiC1TE6HS5a8tmotUVgAu9APpycusF1joM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc/lc/tHptLKODg1z88ELg/g5jKt2vDvLxOercMCvxUMCnEg9Us7KPQepnWcZupAX480goZhMVsxq3pQ8005R4MTK73tjUGW3Og2ruBpfLusniwi2v9P/WYoKaeEPMivhnnHOweeheYsa7ao+ESvyu3i23e5qxbEsOrirKZfZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaH1dqOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC727C116B1;
	Tue, 30 Apr 2024 03:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447493;
	bh=nQvR2NC0oMiC1TE6HS5a8tmotUVgAu9APpycusF1joM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IaH1dqOzIHM+JMvsHs5wUbU2eWnZDcdYiF+nO9Kqpsf5Qx4UE5JBQyLioJ2YvXZb0
	 lu3nN4AY+gcHttWr01ZnFRNA694+D0Q7sj9TDH7hUvFYzn0ASJ5e2iLPVrNsZP8tkM
	 CurLa6zGRGIYOd2dyu6f8rYpqRj8ntG3XLLPaw6pV0i2MSS0UcqXBRAcXaBRYGV6Js
	 6Xlk3mYWSN8k4+dlCQpee/9sYy9c2SRtjJT41RBC3mtE9du1/qf57cBY2V0BLRZyK5
	 C2KEZADNj5YsmFrfwiiwGof4LWlHDLHgX3WIDnEGfSGOnHXF5Xd5pKAfTrQXVeg/AX
	 dv/jRKxnFSokQ==
Date: Mon, 29 Apr 2024 20:24:53 -0700
Subject: [PATCH 03/26] xfs: create a helper to compute the blockcount of a max
 sized remote value
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680412.957659.427175724115662103.stgit@frogsfrogsfrogs>
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

Create a helper function to compute the number of fsblocks needed to
store a maximally-sized extended attribute value.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr.c        |    2 +-
 fs/xfs/libxfs/xfs_attr_remote.h |    6 ++++++
 fs/xfs/scrub/reap.c             |    4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 867fe409f0027..b841096947acb 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -1039,7 +1039,7 @@ xfs_attr_set(
 		break;
 	case XFS_ATTRUPDATE_REMOVE:
 		XFS_STATS_INC(mp, xs_attr_remove);
-		rmt_blks = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+		rmt_blks = xfs_attr3_max_rmt_blocks(mp);
 		break;
 	}
 
diff --git a/fs/xfs/libxfs/xfs_attr_remote.h b/fs/xfs/libxfs/xfs_attr_remote.h
index c64b04f91cafd..e3c6c7d774bf9 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.h
+++ b/fs/xfs/libxfs/xfs_attr_remote.h
@@ -8,6 +8,12 @@
 
 unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrlen);
 
+/* Number of rmt blocks needed to store the maximally sized attr value */
+static inline unsigned int xfs_attr3_max_rmt_blocks(struct xfs_mount *mp)
+{
+	return xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+}
+
 int xfs_attr_rmtval_get(struct xfs_da_args *args);
 int xfs_attr_rmtval_stale(struct xfs_inode *ip, struct xfs_bmbt_irec *map,
 		xfs_buf_flags_t incore_flags);
diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index b8166e19726a4..fbf4d248f0060 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -227,7 +227,7 @@ xrep_bufscan_max_sectors(
 	int			max_fsbs;
 
 	/* Remote xattr values are the largest buffers that we support. */
-	max_fsbs = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+	max_fsbs = xfs_attr3_max_rmt_blocks(mp);
 
 	return XFS_FSB_TO_BB(mp, min_t(xfs_extlen_t, fsblocks, max_fsbs));
 }
@@ -1070,7 +1070,7 @@ xreap_bmapi_binval(
 	 * of the next hole.
 	 */
 	off = imap->br_startoff + imap->br_blockcount;
-	max_off = off + xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+	max_off = off + xfs_attr3_max_rmt_blocks(mp);
 	while (off < max_off) {
 		struct xfs_bmbt_irec	hmap;
 		int			nhmaps = 1;


