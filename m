Return-Path: <linux-fsdevel+bounces-33702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E19BD8B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E502821BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3966216456;
	Tue,  5 Nov 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8xMWFHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599621643F;
	Tue,  5 Nov 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845795; cv=none; b=rrrDp1jiAIIWjvLvprbpCysUnb262auKWTbdROpf5wR5yhGpL/XM8miCuHvPrNuFeqLQGZ39VOSBa58A16jCfR9U9AprSXrKvVuVdpRHwNlWZfarZXKR4JfEAFur8o6KtH2HIoUBluijnpfG0xbwssgtqeCOfzCM9lggrzN/9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845795; c=relaxed/simple;
	bh=htBv5vhtj1g1tXjsFjudpAnH24M0BwR4i74PtkzRQnU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5J1Chmr1tsVuUb1npaxzU3qsg89GDr4Mt/rMbFsV1Nz3lpH84an0bxk1wSBLBVJbWqhn60B4+uzU7b4YpUXdYWechdqgaFeFr5vpszB/kofU+BPpg0Zq5KJarlcjjV/AungA9FHdBE2jKvNTIg/uphumTd9oZTR7UBBAW3hPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8xMWFHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F5FC4CECF;
	Tue,  5 Nov 2024 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730845794;
	bh=htBv5vhtj1g1tXjsFjudpAnH24M0BwR4i74PtkzRQnU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=J8xMWFHirGWWWmnVJfALe80h79JLE+UEYy/GpcVw8kH2KXlN3BFtCgIIFbvWv1hmH
	 bpCEs+w9qa7qjvnVEfXk6b+Ra6VOWqRt1xdhhYfPfp1PEreE1iu87LAzQ74XA14Wd/
	 6r4YGwQUB3psqqluqZ1ndv4zWUsygwQkmhIN5JalvJ5oGPXf9dL6W9j/rHJJqTflsD
	 Q3S+JWZgYOeIo0+/nxQF+iXHN+on8OeqaQd7MHSrs9K2u2F2j9M9OLlAQZSS+h7fQw
	 OcekuFs+VOpMZKHKA89TB9jEXOlbEGvQlq39pLK6lv/rHx7Io0ZW8i4fsieNA4mqF7
	 nK+O6jBL3YEAQ==
Date: Tue, 05 Nov 2024 14:29:54 -0800
Subject: [PATCH 2/2] iomap: add a merge boundary flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <173084397681.1871760.17873379498000050956.stgit@frogsfrogsfrogs>
In-Reply-To: <173084397642.1871760.15713612607469138511.stgit@frogsfrogsfrogs>
References: <173084397642.1871760.15713612607469138511.stgit@frogsfrogsfrogs>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    6 ++++++
 include/linux/iomap.h  |    4 ++++
 2 files changed, 10 insertions(+)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb612..fcadd31017d138 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1601,6 +1601,8 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
+	if (next->io_flags & IOMAP_F_BOUNDARY)
+		return false;
 	if ((ioend->io_flags & IOMAP_F_SHARED) ^
 	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
@@ -1720,6 +1722,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	INIT_LIST_HEAD(&ioend->io_list);
 	ioend->io_type = wpc->iomap.type;
 	ioend->io_flags = wpc->iomap.flags;
+	if (pos > wpc->iomap.offset)
+		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = pos;
@@ -1731,6 +1735,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 {
+	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		return false;
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
 		return false;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f61407e3b12192..9ecb8ea7714cf9 100644
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


