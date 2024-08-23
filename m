Return-Path: <linux-fsdevel+bounces-26855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F405995C24D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49FE2854C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FC18B14;
	Fri, 23 Aug 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTV9n7jR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4917577;
	Fri, 23 Aug 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372470; cv=none; b=QTClAxU8+yRfE8TdlNvrYi2dp9zJKRWlIRtlOKPQtWhp8A1FDe4TpHtxB2BWkjRcFLJO+g73x9Sw4VIUSqFKpaDK0nD2osFr19cUo8XngNOGzoZifPs0UWGWWH4eRQquHcS5nk1RwlTyXX5qGcjyeIaS2551nhrZV1RNtHggNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372470; c=relaxed/simple;
	bh=IEOKzSVBqCnzFNKIr409rCL72nw7WFCZm4ZVpZQKRcA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOilfRVPtcwFGHCLEyoDakV7WSuZ1UomVzteexXkFsGgj9pNlTzU6QbDmMvbdbxAXnOusQJiq38KIbyQ3fC9Zj8mKmbK0ltTa1+fEXbrwPPxjpp2yaylkOzD5X7ukX0bF+wvGhsIaEH/16ad7CWwYgMJ/hXpdREywRyKFMs7HGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTV9n7jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A7DC32782;
	Fri, 23 Aug 2024 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724372470;
	bh=IEOKzSVBqCnzFNKIr409rCL72nw7WFCZm4ZVpZQKRcA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XTV9n7jR0U8sxlTmR+M18Jor7o3DOrMrBBWUTtEVmwX6i9XikPhMoyHKS5miOKu6I
	 FYeigY1Mvc5PIqlZf29sc6ick7bw8mnxSKaN9Vkl5MPES8EhnDmdHXhcuaBc7xnbBj
	 5LXc3DT+MGnBxFQbaf8OqmnKVgmTA4JsuC6uZoaqY+nx4ziqU0MePYkZdsE/SMbGQr
	 nvIill5iYaQHelmg3fY0V+yCra3suUimmtqlXYcVZjLsyC/o0STqGwSwqybbJKbyHq
	 mbTkihpK9R9BUobIcI/HIUfK54dYElXUFzA/kPWOI2R3Agq5fmmakgYAHdoqlRQVA6
	 vAdTPdap8WM0Q==
Date: Thu, 22 Aug 2024 17:21:10 -0700
Subject: [PATCH 1/1] iomap: add a merge boundary flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <172437088024.60482.6799565820302861531.stgit@frogsfrogsfrogs>
In-Reply-To: <172437088004.60482.1804382935786067855.stgit@frogsfrogsfrogs>
References: <172437088004.60482.1804382935786067855.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

File systems might have boundaries over which merges aren't possible.
In fact these are very common, although most of the time some kind of
header at the beginning of this region (e.g. XFS alloation groups, ext4
block groups) automatically create a merge barrier.  But if that is
not present, say for a device purely used for data we need to manually
communicate that to iomap.

Add a IOMAP_F_BOUNDARY flag to never merge I/O into a previous mapping.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    6 ++++++
 include/linux/iomap.h  |    4 ++++
 2 files changed, 10 insertions(+)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86acc..685136a57cbf7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1603,6 +1603,8 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
+	if (next->io_flags & IOMAP_F_BOUNDARY)
+		return false;
 	if ((ioend->io_flags & IOMAP_F_SHARED) ^
 	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
@@ -1722,6 +1724,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	INIT_LIST_HEAD(&ioend->io_list);
 	ioend->io_type = wpc->iomap.type;
 	ioend->io_flags = wpc->iomap.flags;
+	if (pos > wpc->iomap.offset)
+		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = pos;
@@ -1733,6 +1737,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 {
+	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		return false;
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
 		return false;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d1..ba3c9e5124637 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -53,6 +53,9 @@ struct vm_fault;
  *
  * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
  * rather than a file data extent.
+ *
+ * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
+ * never be merged with the mapping before it.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -64,6 +67,7 @@ struct vm_fault;
 #define IOMAP_F_BUFFER_HEAD	0
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
+#define IOMAP_F_BOUNDARY	(1U << 6)
 
 /*
  * Flags set by the core iomap code during operations:


