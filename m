Return-Path: <linux-fsdevel+bounces-16508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3089E697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 02:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332D51C215CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4864A;
	Wed, 10 Apr 2024 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9BZRkPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE97F;
	Wed, 10 Apr 2024 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707529; cv=none; b=bz2TaNPX5w9NLUFGsEkzLGUbPjRByAADpQ6pMCV434+Pp9KuEkqSANuYMUfhNUK1vhHNgqMQU28pO3iVCk5P5rOJdq/NRWWa9m4B+BHt7nQFO7eZo/UQxHv0tPBDxi68OxtUqV4Ccn0p1yI+A+oAN+pnx2cRPwTPDb4kjDGSv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707529; c=relaxed/simple;
	bh=bex30GmuVItS5K9f8UWgnHnchq8hiAHRUZt+4vOdORE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7ZK5Mw0i75LFZeqb0NSHlxxLVXXr6XXEwgYhW39CMaD+A91D3YGYbuARF7+W1yuOok3eT1lBa10ZwO8zUm7g97XlETefkjkkYTZ1JlNTi4p6oSji8gY31748ysYAEpv9MxeZYt5uMoniSUz9pj0icKp0LoS5O4DgZ095HY+sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9BZRkPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0BFC433F1;
	Wed, 10 Apr 2024 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712707528;
	bh=bex30GmuVItS5K9f8UWgnHnchq8hiAHRUZt+4vOdORE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=c9BZRkPP/nSGHb8wWmHqbhh42pF4BrK6Uvjs7aMDfKa/EPcYXyjgobTzSIT6ysuYs
	 LCDlsACvSjs6RhN4qfQC330twU0ZCh2V6DmPmuTNU4nHbzJo2TJjWYmW86jWnx/QQC
	 ZTTIunOabsVWCZseEnC6tigh1lyHp0FpWfb5Ev9CE2IX08J4Y92oP1EQ5EfGIiWmR3
	 Fp5EkaN6VuFNov67yKc+lScNwyjVO/FuXN5quVBtgo4OHmLHBlyQWENlO6sI/Evonz
	 vm2QAVhJUPq/QuBJO+9iQDkzVKsc6dobfNkNBNit3JyRpvAzjudbolykeys9VyTcpI
	 WZEcLzXYojFoQ==
Date: Tue, 9 Apr 2024 17:05:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: [PATCH 15/14] xfs: capture inode generation numbers in the ondisk
 exchmaps log item
Message-ID: <20240410000528.GR6390@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Per some very late review comments, capture the generation numbers of
both inodes involved in a file content exchange operation so that we
don't accidentally target files with have been reallocated.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
I'm throwing this one on the pile since I guess it's not so hard to add
the generation number to a brand new log item.
---
 fs/xfs/libxfs/xfs_log_format.h |    2 ++
 fs/xfs/xfs_exchmaps_item.c     |   12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 8dbe1f997dfd5..accba2acd623d 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -896,6 +896,8 @@ struct xfs_xmi_log_format {
 
 	uint64_t		xmi_inode1;	/* inumber of first file */
 	uint64_t		xmi_inode2;	/* inumber of second file */
+	uint32_t		xmi_igen1;	/* generation of first file */
+	uint32_t		xmi_igen2;	/* generation of second file */
 	uint64_t		xmi_startoff1;	/* block offset into file1 */
 	uint64_t		xmi_startoff2;	/* block offset into file2 */
 	uint64_t		xmi_blockcount;	/* number of blocks */
diff --git a/fs/xfs/xfs_exchmaps_item.c b/fs/xfs/xfs_exchmaps_item.c
index a40216f33214c..3c4bb9601c3e0 100644
--- a/fs/xfs/xfs_exchmaps_item.c
+++ b/fs/xfs/xfs_exchmaps_item.c
@@ -231,7 +231,9 @@ xfs_exchmaps_create_intent(
 	xlf = &xmi_lip->xmi_format;
 
 	xlf->xmi_inode1 = xmi->xmi_ip1->i_ino;
+	xlf->xmi_igen1 = VFS_I(xmi->xmi_ip1)->i_generation;
 	xlf->xmi_inode2 = xmi->xmi_ip2->i_ino;
+	xlf->xmi_igen2 = VFS_I(xmi->xmi_ip2)->i_generation;
 	xlf->xmi_startoff1 = xmi->xmi_startoff1;
 	xlf->xmi_startoff2 = xmi->xmi_startoff2;
 	xlf->xmi_blockcount = xmi->xmi_blockcount;
@@ -377,6 +379,14 @@ xfs_xmi_item_recover_intent(
 	if (error)
 		goto err_rele1;
 
+	if (VFS_I(ip1)->i_generation != xlf->xmi_igen1 ||
+	    VFS_I(ip2)->i_generation != xlf->xmi_igen2) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				xlf, sizeof(*xlf));
+		error = -EFSCORRUPTED;
+		goto err_rele2;
+	}
+
 	req->ip1 = ip1;
 	req->ip2 = ip2;
 	req->startoff1 = xlf->xmi_startoff1;
@@ -485,6 +495,8 @@ xfs_exchmaps_relog_intent(
 
 	new_xlf->xmi_inode1	= old_xlf->xmi_inode1;
 	new_xlf->xmi_inode2	= old_xlf->xmi_inode2;
+	new_xlf->xmi_igen1	= old_xlf->xmi_igen1;
+	new_xlf->xmi_igen2	= old_xlf->xmi_igen2;
 	new_xlf->xmi_startoff1	= old_xlf->xmi_startoff1;
 	new_xlf->xmi_startoff2	= old_xlf->xmi_startoff2;
 	new_xlf->xmi_blockcount	= old_xlf->xmi_blockcount;

