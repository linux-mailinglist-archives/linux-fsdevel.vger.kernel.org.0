Return-Path: <linux-fsdevel+bounces-15743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC88892876
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342EFB22C29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3B15A5;
	Sat, 30 Mar 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sahgHTqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7A7F8;
	Sat, 30 Mar 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759403; cv=none; b=Fu0AyKoHSsAB708qm9Xj4H7Q7uOCffItZy90vIWI+Jp2WB/AvwMiCwc74Gd7KZMs7jsM7uLwH6NV/JSSU36BGIS/RP+WndhQKgxw9KEjKf+SGzXbP7z7Ztq/HiT3bp5u1rMbvCZOo1QjfNXWIDaLJlTucemak/TG3pRWpD8H+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759403; c=relaxed/simple;
	bh=IeNrlhcNkOwaqIOtr82LPcKDi10R7TrEkQRywtS6IZ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN1xSdkt9JzV4MiHRI4NA8PUPf+G6h3033YsHg0JBr1h/oDcD0bk1H99XhyfZg9tYO84X8a8FbWN+c6HTHqBXUHEKq4hk+FXWxU3/lZwtswICCUs8Y+ep9uRMHoNB5RAiyEj+dulgmKKfz5QsUoKH50JSWHKPIFDVxH0zProZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sahgHTqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51EC43390;
	Sat, 30 Mar 2024 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759402;
	bh=IeNrlhcNkOwaqIOtr82LPcKDi10R7TrEkQRywtS6IZ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sahgHTqje9Bao5C9XBxkwRuKtkHvkPIAsmq6kADgSgDtTVINDdOkKTjAyQfpWc6a7
	 xZgqvaajWFN5VxD8ttTvKvFtu/8n7WkJ0wPmJFg0AYXo4X/Y8mOv9acgr53OyWxp2q
	 62fSuRXFK4nT2rKqNjT/+vfTlcX4odnLGXnqLum1+oA60ddv5heVr/+q5JJMQVBl/y
	 UKSaGgTp7z7eSAVPOb6O1f4yNiuNP/l3zoib9uUKnOVrqyn2tUal9SnAQmCmMaaWZB
	 PXhY0Ikpjrx4LNuuScM/ksMcphTfx3rufxBzHmvx63O/fsu4kBVCJfsV24YIqsNYol
	 uW4KUp2FlxbWQ==
Date: Fri, 29 Mar 2024 17:43:22 -0700
Subject: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
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

There are more things that one can do with an open file descriptor on
XFS -- query extended attributes, scan for metadata damage, repair
metadata, etc.  None of this is possible if the fsverity metadata are
damaged, because that prevents the file from being opened.

Ignore a selective set of error codes that we know fsverity_file_open to
return if the verity descriptor is nonsense.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    8 ++++++++
 fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f9d929dfeebc..e68a15b72dbdd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	size_t poff, plen;
 	sector_t sector;
 
+	/*
+	 * If this verity file hasn't been activated, fail read attempts.  This
+	 * can happen if the calling filesystem allows files to be opened even
+	 * with damaged verity metadata.
+	 */
+	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
+		return -EIO;
+
 	if (iomap->type == IOMAP_INLINE)
 		return iomap_read_inline_data(iter, folio);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c0b3e8146b753..36034eaefbf55 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1431,8 +1431,25 @@ xfs_file_open(
 			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
 
 	error = fsverity_file_open(inode, file);
-	if (error)
+	switch (error) {
+	case -EFBIG:
+	case -EINVAL:
+	case -EMSGSIZE:
+	case -EFSCORRUPTED:
+		/*
+		 * Be selective about which fsverity errors we propagate to
+		 * userspace; we still want to be able to open this file even
+		 * if reads don't work.  Someone might want to perform an
+		 * online repair.
+		 */
+		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
+			break;
 		return error;
+	case 0:
+		break;
+	default:
+		return error;
+	}
 
 	return generic_file_open(inode, file);
 }


