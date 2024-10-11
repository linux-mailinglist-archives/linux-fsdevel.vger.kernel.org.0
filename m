Return-Path: <linux-fsdevel+bounces-31655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38F999891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BDDB21442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62D8BE5;
	Fri, 11 Oct 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQJKdynF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911E6FB0;
	Fri, 11 Oct 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608502; cv=none; b=qjJIcAp+0ItFVYuC/LDlhrBUdOdgx+hcZTDnUVeFLoTP/Z3Mu4aXjcwq5dn4icIv7a7fapPgxEj4a05/4j2CQyIXxxwKwjPURAHLr42oMfdI1iH+zctHzEAMjN+PYxDzSni6sKd/ao0/hNoSmtQaliZ5gv38Nv4hf3/qt0KpRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608502; c=relaxed/simple;
	bh=Qt/5hlRql92AK1Nma6sI6o8MPxQ98DvyWnPnZ61x8VE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nbck3nIf0V7407JwJB7OnzR2LUMZxYB/CFC+zX9dVQOyJhPLYJJZ2b0VdfFUPC8+6bPt7cv0rmSiuS2ON3EO03FOIPP5jUXKg84JeGfcK5GOjs13HlMcBu7qMgXf5MwN9BBNFTw/EwLV+S0fohw0k1MSDa5apq5T1NxVUQB5dG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQJKdynF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB87C4CEC5;
	Fri, 11 Oct 2024 01:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728608502;
	bh=Qt/5hlRql92AK1Nma6sI6o8MPxQ98DvyWnPnZ61x8VE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TQJKdynF6CAs2BvRZgn40w3KQTaKvWeR8ndkBio1VsDskTFhRfWtzN0NM7i+QK30i
	 xnBfN+WNLGROgx7YZLBWdt0PE5yzhH1Th7sjb9uzPqf31Q4UnoULOo22jg/1cHE8H1
	 wTyapvGtmm8mf0hPpJiptVQ2P9Y4W8yhjcvuy3Rs0V/E8FgYBUpk9aMqaAZYJSbQNf
	 Do57xMrPkyUveMKpH2iLC6OUKUfs0nmRCIgvYMMWQIC37HJMHY4cDLGeuucZxEc6VK
	 At7woX7lWV9Aii/lH6cTGoNMNbfDnhDAGSKYjZ9PZzDWEP3bfTZG8sxcWHH4LuRwp2
	 1Rm19O/KJqqDw==
Date: Thu, 10 Oct 2024 18:01:40 -0700
Subject: [PATCH 2/2] iomap: add a merge boundary flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <172860643692.4178573.11895337318025367612.stgit@frogsfrogsfrogs>
In-Reply-To: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
References: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    6 ++++++
 include/linux/iomap.h  |    4 ++++
 2 files changed, 10 insertions(+)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3899169b2cf733..6f7691ef1e4164 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1657,6 +1657,8 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
+	if (next->io_flags & IOMAP_F_BOUNDARY)
+		return false;
 	if ((ioend->io_flags & IOMAP_F_SHARED) ^
 	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
@@ -1776,6 +1778,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	INIT_LIST_HEAD(&ioend->io_list);
 	ioend->io_type = wpc->iomap.type;
 	ioend->io_flags = wpc->iomap.flags;
+	if (pos > wpc->iomap.offset)
+		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = pos;
@@ -1787,6 +1791,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
 {
+	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		return false;
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
 		return false;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d8a7fc84348c4d..d44c982085a39f 100644
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


