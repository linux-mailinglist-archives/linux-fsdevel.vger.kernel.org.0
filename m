Return-Path: <linux-fsdevel+bounces-14602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA35187DE97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177781C20E5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B01CD29;
	Sun, 17 Mar 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G31A+1Gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022561CD06;
	Sun, 17 Mar 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692996; cv=none; b=ahPy93p203YF1tK20a/WATLvdKUI8gKMUccnOU8bXjuq8mE0cr2fhlVhVpN1Ztkcrgs1bxpppYk2vwrwaMKRRjmIr7uqoMYTktHwxX9CO3LgafgqZqvT8rLN4DjjLlvul3Q7uNgtc0MZEx46X+2tSfme5DZXluuVT4lsTGxVwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692996; c=relaxed/simple;
	bh=el7fu9wQ+wCYZSmj8Df/MzRCK0qEMwnhbP3oOjYhriU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF7GyDIFTZW+YmMJdZbWuUy5gLMz3zBDnVDqU0dZPREoyh0CVpviPh62Xs3adNS3Zudalor8MEbbpTdwLn929qnwJn69FsfyDUpIBgFl4VI31HvyDKuemjHloM4uzUgaSAik9wa4J7apnaiQIUXrzD6bXgICKh2tRtDfG/Kj2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G31A+1Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F233C433C7;
	Sun, 17 Mar 2024 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692995;
	bh=el7fu9wQ+wCYZSmj8Df/MzRCK0qEMwnhbP3oOjYhriU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=G31A+1GqRB5TrXVvZxZA0GCO1dwFGkhgyVYmEOHDaWb7EqkeTGTdHGXKXKVS4Q7fJ
	 iJDNQstJFimSSy6DZN2E5nT75uPv7LUhcAKNN6Rzo0ivtFvTl5m4zxnT1x0EOw6YAE
	 Vh7r7mpybIh3Bu9IQKOop4o0+PhQvYSi8cBr/85VdvEVu6ObN7+b6EQXi2WugXPqX+
	 YpvpPECo1BpNf5aS5qyB0yzsdiCSmOaH58UFFrVhJDFMYTZJvjXvnAwCjFKeW3+4J5
	 4R5fcnLMzy+Vm+AbZJySLGb1oPapekfJwaCiExq3e6RCuUz2ZsGP6+4t9XYLMyacAc
	 EDIXHo9+e95Ng==
Date: Sun, 17 Mar 2024 09:29:54 -0700
Subject: [PATCH 25/40] xfs: widen flags argument to the xfs_iflags_* helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246312.2684506.1372758293673496541.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

xfs_inode.i_flags is an unsigned long, so make these helpers take that
as the flags argument instead of unsigned short.  This is needed for the
next patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_inode.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index ab46ffb3ac19..3ea3a6f26ceb 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -207,13 +207,13 @@ xfs_new_eof(struct xfs_inode *ip, xfs_fsize_t new_size)
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
@@ -221,7 +221,7 @@ xfs_iflags_set(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline void
-xfs_iflags_clear(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_clear(xfs_inode_t *ip, unsigned long flags)
 {
 	spin_lock(&ip->i_flags_lock);
 	ip->i_flags &= ~flags;
@@ -229,13 +229,13 @@ xfs_iflags_clear(xfs_inode_t *ip, unsigned short flags)
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
@@ -245,7 +245,7 @@ xfs_iflags_test(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline int
-xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned long flags)
 {
 	int ret;
 
@@ -258,7 +258,7 @@ xfs_iflags_test_and_clear(xfs_inode_t *ip, unsigned short flags)
 }
 
 static inline int
-xfs_iflags_test_and_set(xfs_inode_t *ip, unsigned short flags)
+xfs_iflags_test_and_set(xfs_inode_t *ip, unsigned long flags)
 {
 	int ret;
 


