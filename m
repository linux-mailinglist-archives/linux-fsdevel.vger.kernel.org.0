Return-Path: <linux-fsdevel+bounces-15727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDDF892854
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB315282B23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0B1878;
	Sat, 30 Mar 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdZTvs3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4C15A5;
	Sat, 30 Mar 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759152; cv=none; b=QwICeUGNEnyq1wNyJi6c54NEqe/Jp3/ztVvAV7tRVPaFGjnUkTcCKm/HcV3PMrgn2AA/llRREh138rfomUAtBO5vX4vfd+ZErGiVJl1XDaO1Q6fYHsEcxyib9/snUqwWLrqBUBViszSitS4//tx3g8ujTA7UY/qhXwrOdLXPvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759152; c=relaxed/simple;
	bh=uNwyTWZ0VffFqv3XFVoxVPMlyItXZECNkHoMgThcHxI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZz50aKVlA87CmW22v74LJ8MEzGT6xbQn4M6xvpCGJArVlTLG+rMz2yCp6+ERZmnkbDT0Ec+6nZXuIgdF08mN9WuGS1XHn2F+Kl5lvO6LZvOrQ1640iYOPNWR8KsJ4cdGrjFaand8I3sYN7vCXcpro+jKG+FgupwR580j4odg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdZTvs3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3352CC433C7;
	Sat, 30 Mar 2024 00:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759152;
	bh=uNwyTWZ0VffFqv3XFVoxVPMlyItXZECNkHoMgThcHxI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UdZTvs3nfxPO1E4mysGEWTTnqk6I3tHcQB+YC8Cd0SfFfg44D3URh5fWmjQZrZtV5
	 6zrFM26nMvCgX+hA2bFqYhebW1bQA1wa6hAfQVTeOMbHdotM7UjCWb2aRCUBOYBTB0
	 FKTsy/9KY+PDnEVBMeluNG0X119qpudGUxE79OcDXAbQ8yHQgkEXQU/QNdqyb+WVtG
	 TH/5re6lZH9XcWTKsJSUAAn4hWiezuWRD/N6VM7Yf6BHVSrSPXdOk7O9xser02UFjw
	 9PoNPKAMshVNMU1adJjIJW/3Vh3/8xJ2fUfcSwmAHrcHWKiGTOH2IZNBYxiKh9g+Vi
	 jTWmCccDyELpg==
Date: Fri, 29 Mar 2024 17:39:11 -0700
Subject: [PATCH 12/29] xfs: widen flags argument to the xfs_iflags_* helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868758.1988170.13958676356498248164.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

xfs_inode.i_flags is an unsigned long, so make these helpers take that
as the flags argument instead of unsigned short.  This is needed for the
next patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_inode.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index f6744e4fabc27..5a202706fc4a4 100644
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
 


