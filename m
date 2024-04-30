Return-Path: <linux-fsdevel+bounces-18242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367B8B6897
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BFB1F24370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B4134BD;
	Tue, 30 Apr 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jONeYsFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368B12E5D;
	Tue, 30 Apr 2024 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447650; cv=none; b=ukruIjnmpGZu/ZyrbL1RAPwSV97IZ8cipsXoieg8HwRaaCR0ASiC4za7I1AA86rkpqW+wYVa3qJ/OjMV+HiEZw9B9pc2Md/6iDUqfZUePiKEHvTtGzg8YQ8XX2id8PJOJkvJ2VBj2zOH+gvLpYBNCzp6ItYGnlBz4v4h9lbqLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447650; c=relaxed/simple;
	bh=gSLulVXNnyNGx0XjiKeEWbdo+YJGiirTP4/MvGeQrbc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysy5fbp6pVs5rLMxwmLUnZV8b1gWO6fTVmU/9fXdZgo1CatNr4RYuARTepiIb/F2MdalzW0K7257vdyaTKDJMXleCHpQkKWTyNfdr7wuoXXQYd6MBt54nL25pWU4Ykj2vWoO/10Gjm0AnHPY7i8cZFoT5PL32WyZBwZEuucEz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jONeYsFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C438C4AF19;
	Tue, 30 Apr 2024 03:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447650;
	bh=gSLulVXNnyNGx0XjiKeEWbdo+YJGiirTP4/MvGeQrbc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jONeYsFUiajSdhqKSPEdG9T9Rw3NQMlsOQwQASKUpXNGnPf4FnlKICTZWgjd63fY+
	 n1O3Fq007NxpmaIGKQQm+CSedRRmYgVglCXGcCtwmOMTpKBOzcVk+E0qGkwPsHVbwG
	 gNrB2q2datzbHHYUt1JX1zkA8x+jvQloCzMarLO8SWcOgi40SroYw5PA+B4uTVhRGm
	 K7FQpW1L7s69wVyFVSU42SmRxTlRXL7nXx3tZLBL8q5tO/svB+6hi+U/i0ejir+458
	 HAkDkRMuaTLqcXlTbX973vBQzpXjEgSjJSdvRbm5bZnjH6gehLw0J73S8qIlwIH2gC
	 weap1eRWjr+Qg==
Date: Mon, 29 Apr 2024 20:27:29 -0700
Subject: [PATCH 13/26] xfs: widen flags argument to the xfs_iflags_* helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680584.957659.3744585033664433370.stgit@frogsfrogsfrogs>
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

xfs_inode.i_flags is an unsigned long, so make these helpers take that
as the flags argument instead of unsigned short.  This is needed for the
next patch.

While we're at it, remove the iflags variable from xfs_iget_cache_miss
because we no longer need it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_icache.c |    4 +---
 fs/xfs/xfs_inode.h  |   14 +++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ad93df7a47c1c..f05c6510e94f4 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -616,7 +616,6 @@ xfs_iget_cache_miss(
 	struct xfs_inode	*ip;
 	int			error;
 	xfs_agino_t		agino = XFS_INO_TO_AGINO(mp, ino);
-	int			iflags;
 
 	ip = xfs_inode_alloc(mp, ino);
 	if (!ip)
@@ -696,13 +695,12 @@ xfs_iget_cache_miss(
 	 * memory barrier that ensures this detection works correctly at lookup
 	 * time.
 	 */
-	iflags = XFS_INEW;
 	if (flags & XFS_IGET_DONTCACHE)
 		d_mark_dontcache(VFS_I(ip));
 	ip->i_udquot = NULL;
 	ip->i_gdquot = NULL;
 	ip->i_pdquot = NULL;
-	xfs_iflags_set(ip, iflags);
+	xfs_iflags_set(ip, XFS_INEW);
 
 	/* insert the new inode */
 	spin_lock(&pag->pag_ici_lock);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 247cff3d75fd7..503ea082dfac4 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -211,13 +211,13 @@ xfs_new_eof(struct xfs_inode *ip, xfs_fsize_t new_size)
  * i_flags helper functions
  */
 static inline void
-__xfs_iflags_set(xfs_inode_t *ip, unsigned short flags)
+__xfs_iflags_set(xfs_inode_t *ip, unsigned long flags)
 {
 	ip->i_flags |= flags;
 }
 
 static inline void
-xfs_iflags_set(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_set(xfs_inode_t *ip, unsigned long flags)
 {
 	spin_lock(&ip->i_flags_lock);
 	__xfs_iflags_set(ip, flags);
@@ -225,7 +225,7 @@ xfs_iflags_set(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline void
-xfs_iflags_clear(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_clear(xfs_inode_t *ip, unsigned long flags)
 {
 	spin_lock(&ip->i_flags_lock);
 	ip->i_flags &= ~flags;
@@ -233,13 +233,13 @@ xfs_iflags_clear(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline int
-__xfs_iflags_test(xfs_inode_t *ip, unsigned short flags)
+__xfs_iflags_test(xfs_inode_t *ip, unsigned long flags)
 {
 	return (ip->i_flags & flags);
 }
 
 static inline int
-xfs_iflags_test(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_test(xfs_inode_t *ip, unsigned long flags)
 {
 	int ret;
 	spin_lock(&ip->i_flags_lock);
@@ -249,7 +249,7 @@ xfs_iflags_test(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline int
-xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned long flags)
 {
 	int ret;
 
@@ -262,7 +262,7 @@ xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline int
-xfs_iflags_test_and_set(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_test_and_set(xfs_inode_t *ip, unsigned long flags)
 {
 	int ret;
 


