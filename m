Return-Path: <linux-fsdevel+bounces-18291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F398B6915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5335E1C21B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F3E10A3F;
	Tue, 30 Apr 2024 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqCJVLmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9BDDA6;
	Tue, 30 Apr 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448402; cv=none; b=ennhubCFtC+SNKxaFzEuufomhpDufLJXXnD8Ch4Hl7eM+5GMCs1YmDK5hckRULxwL8rxS5K99wnl/ZThbdEyiKp4SrVIPxowlE/kBEastzqT+Dv4Eiz5aRELpeCD3NWWvEnt5YB2/fPK87AEG6qwCjpsJi++8O8ySWRMGHMtspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448402; c=relaxed/simple;
	bh=xH0DWV/35WlzevtdF4gdlLyNIpYJZ1Jc70mrD1ARhAw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhlxS7ppMlSdEJmdrZHi9SQ8CGpEVF7Ks+7MXa+gIpYf2KFqGQtcyiZIHS6VvKuIRDoI4cfTD6LvkE65QDxavScIM65yJkQ1BsWptmgJwlIkpzB6xvRExpoDgUaJDi9jsb/gJN+1H9prBSobBwWWelmGdV0atlFSOxm93ONWpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqCJVLmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64161C116B1;
	Tue, 30 Apr 2024 03:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448401;
	bh=xH0DWV/35WlzevtdF4gdlLyNIpYJZ1Jc70mrD1ARhAw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DqCJVLmhJKTKHQtmc8e6MpyLO57ggcslvmYdpALTDiIEbP8N7QebRWvgctLYx9wOM
	 djs2GqTuAZumBsyYDenJ8QcirQmmbi0S8apxNxh3OoQXEuWcxvtJ2BqnGN4o+gc5UY
	 wBszJlWXNaj521LjUVbh8KmMZt4R1RK4BLv3ldciyPwCURd/ECnkCG6mC5uspxcVj7
	 xdx2NO6kTqX8LTNEmQJTGfHomUzw4tZ9fEjXTy9dhO4QNkP7iev06FN3fk6LfbWlju
	 aV2ZApxny+63VGlkVcGc6sFzki9IoGVzo/aLwWEfiUZnfRRDAIPyjBi3QscD6q39VR
	 lKccOzzqkrxxw==
Date: Mon, 29 Apr 2024 20:40:00 -0700
Subject: [PATCH 35/38] xfs_spaceman: report data corruption
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683644.960383.9038296844797024404.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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

Report data corruption to userspace.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 man/man2/ioctl_xfs_bulkstat.2 |    3 +++
 spaceman/health.c             |    4 ++++
 2 files changed, 7 insertions(+)


diff --git a/man/man2/ioctl_xfs_bulkstat.2 b/man/man2/ioctl_xfs_bulkstat.2
index b6d51aa43811..0afa8177ebb3 100644
--- a/man/man2/ioctl_xfs_bulkstat.2
+++ b/man/man2/ioctl_xfs_bulkstat.2
@@ -329,6 +329,9 @@ Parent pointers.
 .TP
 .B XFS_BS_SICK_DIRTREE
 Directory is the source of corruption in the directory tree.
+.TP
+.B XFS_BS_SICK_DATA
+File data is corrupt.
 .RE
 .SH ERRORS
 Error codes can be one of, but are not limited to, the following:
diff --git a/spaceman/health.c b/spaceman/health.c
index ee0e108d5b2d..43270209b6a9 100644
--- a/spaceman/health.c
+++ b/spaceman/health.c
@@ -201,6 +201,10 @@ static const struct flag_map inode_flags[] = {
 		.mask = XFS_BS_SICK_DIRTREE,
 		.descr = "directory tree structure",
 	},
+	{
+		.mask = XFS_BS_SICK_DATA,
+		.descr = "file data",
+	},
 	{0},
 };
 


