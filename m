Return-Path: <linux-fsdevel+bounces-18292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA38B691C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8079B21A5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D11429A;
	Tue, 30 Apr 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyXxFNSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566013FEE;
	Tue, 30 Apr 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448417; cv=none; b=Wix9ZRCkDZTMtB/3K9mraYZpPgxozNTd5Yq0i0lQaHTINMaNdMoW48JlVl1Objhzn9S/8JXi690vlNkZksOqexsYXA0Z9nwFJ2JyYH8sGhiZg0hjqMw0p10wV3Qrk2Nhj3vAj+ZhsXPDJELWWFx8NS0zEif+m/Ysn4awwWvyosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448417; c=relaxed/simple;
	bh=BW4AA+hEuHNfXzS8ZpR/m4RoUoXCRJ3Bv/44PzEyqDY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM8swoLo38u/srUJcV9GZMBB3n1JgBxDUc2EfuAgqcjMq0uYHnFjl0EB2zHrnuwYRzfQv54QO2+0o68/S6jSO2PRJ9ssIWXbzbZrWJeMD5LmuoToIhS7Cy5UFNZCufRr5g6RBgIWbx7MauVHA1DnkbmCO5NEWO10aWeU3nQM93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyXxFNSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A326C116B1;
	Tue, 30 Apr 2024 03:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448417;
	bh=BW4AA+hEuHNfXzS8ZpR/m4RoUoXCRJ3Bv/44PzEyqDY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nyXxFNSdnxrES7ZkfxT7+GJt4UdLNNv0uxW6RnAgfl9DCRTo9wqwX16g2Sf8/8N/b
	 tI2Z5uaeUdv78cXmMPVV04yLbttDn8WwUkDFxmutJiikVNwtws+4zWh7ZKNL/9ygQk
	 Jrh68MyqYXFNal0viHIxgX4Kg7K9LAx61zI2jchcvTVYCoq04RlQn7CzBn+yUi2iBj
	 RIvwCbEBJQBknego/eF9WMfcXkEk6uje01PHn6HQj+gOG2RB15/SWFcXpY0dwABAdt
	 H0qNWK7xydv68ZcEyMJgHbemx5dmPUhWS0bG4jd46zCjG88G5lh7L9Y8q01LIu+5iQ
	 mm6GTYl2qJ4Sw==
Date: Mon, 29 Apr 2024 20:40:16 -0700
Subject: [PATCH 36/38] xfs_io: report fsverity status via statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683660.960383.9649245519206526450.stgit@frogsfrogsfrogs>
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

Report if a file has verity enable.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 io/attr.c                       |    2 ++
 man/man2/ioctl_xfs_fsgetxattr.2 |    3 +++
 man/man8/xfs_io.8               |    4 ++++
 3 files changed, 9 insertions(+)


diff --git a/io/attr.c b/io/attr.c
index fd82a2e73801..5df4edbbbb41 100644
--- a/io/attr.c
+++ b/io/attr.c
@@ -37,6 +37,7 @@ static struct xflags {
 	{ FS_XFLAG_FILESTREAM,		"S", "filestream"	},
 	{ FS_XFLAG_DAX,			"x", "dax"		},
 	{ FS_XFLAG_COWEXTSIZE,		"C", "cowextsize"	},
+	{ FS_XFLAG_VERITY,		"v", "verity"		},
 	{ FS_XFLAG_HASATTR,		"X", "has-xattr"	},
 	{ 0, NULL, NULL }
 };
@@ -66,6 +67,7 @@ lsattr_help(void)
 " S -- enable filestreams allocator for this directory\n"
 " x -- Use direct access (DAX) for data in this file\n"
 " C -- for files with shared blocks, observe the inode CoW extent size value\n"
+" v -- file has fsverity metadata to validate data contents\n"
 " X -- file has extended attributes (cannot be changed using chattr)\n"
 "\n"
 " Options:\n"
diff --git a/man/man2/ioctl_xfs_fsgetxattr.2 b/man/man2/ioctl_xfs_fsgetxattr.2
index 2c626a7e3742..ffcdedc1fb13 100644
--- a/man/man2/ioctl_xfs_fsgetxattr.2
+++ b/man/man2/ioctl_xfs_fsgetxattr.2
@@ -200,6 +200,9 @@ below).
 If set on a directory, new files and subdirectories created in the directory
 will have both the flag and the CoW extent size value set.
 .TP
+.B XFS_XFLAG_VERITY
+The file has fsverity metadata to verify the file contents.
+.TP
 .B XFS_XFLAG_HASATTR
 The file has extended attributes associated with it.
 
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index cd6e953d8223..4991ad471bd7 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -934,6 +934,10 @@ direct access persistent memory (XFS_XFLAG_DAX)
 .B C
 copy on write extent hint (XFS_XFLAG_COWEXTSIZE)
 
+.TP
+.B v
+fsverity enabled (XFS_XFLAG_VERITY)
+
 .TP
 .B X
 has extended attributes (XFS_XFLAG_HASATTR)


