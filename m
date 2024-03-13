Return-Path: <linux-fsdevel+bounces-14342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B187B0A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4921F29E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9649145356;
	Wed, 13 Mar 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjkpcVej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAD42AA7;
	Wed, 13 Mar 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352668; cv=none; b=D+K8t0eQ8IpWsJoVY9Q7z7uKIEauEDcVAaT5T9yHlWCxocgPtlCFhjZZpHPyClwIi/FCZU/4kNt1wbkY4t7vaARUb0GZQWladOCXx3oOzFtTR2h5/sFe4TQ6tvtqMIHXUmnfNjiloyNqnTcKlHZya7uGzPtjZPuTfUeNj7EUaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352668; c=relaxed/simple;
	bh=el7fu9wQ+wCYZSmj8Df/MzRCK0qEMwnhbP3oOjYhriU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsdDzX4uFFxEN8K77amgZ+0Aqt7bt6MxpYdx44z7UIQWk0hL4d5xtF4ixzWXH1zuVmj0swUOnt2mq49FTqDCDIWoCm/tjNS8MpePkYzk67YYrm5SAZ1PW9Do/vHG7D9jxWsLnB4Ho4kakyikP5DLLhODxXuTfpG21bCUNO0n490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjkpcVej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A71C433C7;
	Wed, 13 Mar 2024 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352667;
	bh=el7fu9wQ+wCYZSmj8Df/MzRCK0qEMwnhbP3oOjYhriU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UjkpcVejTHtGyFY63tJeroN/SvzunTZcg3gO9gqcUVE3jIQ3ivMRwI+sxEysUNU95
	 7WCxli0N2QgYHcXE0XnyYiq4P0SMkQwDQKl1ACY9rVmLxpuVrEjLt+F0FV8LIAo/0p
	 1tBQS/eX6EGHXVfGK2uPKasu+6nbOqM6DClmNFQb3SgVGPKUAg+vPh/fE/0XbLGK4T
	 4lBkC6tnV8y3Dz/OZZrR1ymicsetvLFYCqf22hXzzsoK7jLqZ74mGe8MrYvM6KofzE
	 WQHNtlsDxLcOGKBtnTihtFp5LooUdXxm5y3Kq0a+kKoqXq7OI8DEYD99CpGG3dNXsP
	 EoVNonj07Wq7A==
Date: Wed, 13 Mar 2024 10:57:47 -0700
Subject: [PATCH 20/29] xfs: widen flags argument to the xfs_iflags_* helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223678.2613863.14018255073725223372.stgit@frogsfrogsfrogs>
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
 


