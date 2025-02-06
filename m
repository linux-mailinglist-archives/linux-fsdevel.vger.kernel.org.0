Return-Path: <linux-fsdevel+bounces-41028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C7A2A112
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33311167794
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FB224B06;
	Thu,  6 Feb 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqW9H5EV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C302248BE;
	Thu,  6 Feb 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824046; cv=none; b=ff+XBdgmiBu9+9A6NMC2G1T1qySZqOvl6Mq3dZ7HMwgdw6ELHHhye8RL6mWcmzjfjsTr5QSZk/Dupw9nUpWcwlWLJR4e5GkUthIN5qhIfXvERAmElPkGvVMQwIbA+waHlRZABkh7dHrgi4D5pAWi6FJ2P9yDtdT7XMonpI7Z0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824046; c=relaxed/simple;
	bh=CPOm8eUsTykFn4BcdiPCfb7vq/w/ZOmEAhP2q5KGmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjBLaZ82P5S81Uc0zwWQ6hjgNxlOR/wTuoOYIEjwQ/dT2t+/dqUf2dNKfUARy8llwmOmw8XDt9A896cCEyErHad+buEgpRnudu6WL07ataGuolwGCj7NJAuHGfg5fhu2QkrRuTRywW43dcJ7YMqr8vJnz1Io9PBYLvibzxOc3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqW9H5EV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O3AzH7rOqIy5AMh1rQtFarwZR5Wke2KEtsmX/03zzGg=; b=qqW9H5EVlnxmSPrjAy38olqICW
	MvX48IVd5Qx/ptegtGJUfwkJWFkUGeOZKLKQ+HTr5uO7Apc7Zaudm9/ulUWS0mWpq/GEV6x5EhJ51
	669Q70W/Sz2riH7l8LH/xhSgXhbXqbjPvFOGmUE6CB1MbK2kGwF2sD64oshDJXITqwt3+hQvnmSLt
	xfnrA+k698XZX0D/hcQ3gunUBZa+7OSwg45KMAZS5XmGvBI5r+TSXcK8l/CiNYo7WE2bmIVmvf6jF
	0jTRl6CLbmtYWLO9blXLtC1bOUiVGZrH6VazgIqNwykhqGPMl/oMrwlTElzHzDTwndb10lY2Czk+r
	hybgqmKA==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZ6-00000005PRx-0XV8;
	Thu, 06 Feb 2025 06:40:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] iomap: add a IOMAP_F_ANON_WRITE flag
Date: Thu,  6 Feb 2025 07:40:01 +0100
Message-ID: <20250206064035.2323428-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a IOMAP_F_ANON_WRITE flag that indicates that the write I/O does not
have a target block assigned to it yet at iomap time and the file system
will do that in the bio submission handler, splitting the I/O as needed.

This is used to implement Zone Append based I/O for zoned XFS, where
splitting writes to the hardware limits and assigning a zone to them
happens just before sending the I/O off to the block layer, but could
also be useful for other things like compressed I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 Documentation/filesystems/iomap/design.rst |  4 ++++
 fs/iomap/buffered-io.c                     | 13 +++++++++----
 fs/iomap/direct-io.c                       |  6 ++++--
 include/linux/iomap.h                      |  7 +++++++
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index b0d0188a095e..28ab3758c474 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -246,6 +246,10 @@ The fields are as follows:
    * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
      be set by the filesystem for its own purposes.
 
+   * **IOMAP_F_ANON_WRITE**: Indicates that (write) I/O does not have a target
+     block assigned to it yet and the file system will do that in the bio
+     submission handler, splitting the I/O as needed.
+
    These flags can be set by iomap itself during file operations.
    The filesystem should supply an ``->iomap_end`` function if it needs
    to observe these flags:
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d8d271107e60..ba795d72e546 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1691,10 +1691,14 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 	 * failure happened so that the file system end I/O handler gets called
 	 * to clean up.
 	 */
-	if (wpc->ops->submit_ioend)
+	if (wpc->ops->submit_ioend) {
 		error = wpc->ops->submit_ioend(wpc, error);
-	else if (!error)
-		submit_bio(&wpc->ioend->io_bio);
+	} else {
+		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+			error = -EIO;
+		if (!error)
+			submit_bio(&wpc->ioend->io_bio);
+	}
 
 	if (error) {
 		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
@@ -1744,7 +1748,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 		return false;
 	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
 		return false;
-	if (iomap_sector(&wpc->iomap, pos) !=
+	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
+	    iomap_sector(&wpc->iomap, pos) !=
 	    bio_end_sector(&wpc->ioend->io_bio))
 		return false;
 	/*
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b521eb15759e..641649a04614 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -81,10 +81,12 @@ static void iomap_dio_submit_bio(const struct iomap_iter *iter,
 		WRITE_ONCE(iocb->private, bio);
 	}
 
-	if (dio->dops && dio->dops->submit_io)
+	if (dio->dops && dio->dops->submit_io) {
 		dio->dops->submit_io(iter, bio, pos);
-	else
+	} else {
+		WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_ANON_WRITE);
 		submit_bio(bio);
+	}
 }
 
 ssize_t iomap_dio_complete(struct iomap_dio *dio)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9583f6456165..eb0764945b42 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -56,6 +56,10 @@ struct vm_fault;
  *
  * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
  * never be merged with the mapping before it.
+ *
+ * IOMAP_F_ANON_WRITE indicates that (write) I/O does not have a target block
+ * assigned to it yet and the file system will do that in the bio submission
+ * handler, splitting the I/O as needed.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -68,6 +72,7 @@ struct vm_fault;
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
 #define IOMAP_F_BOUNDARY	(1U << 6)
+#define IOMAP_F_ANON_WRITE	(1U << 7)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -111,6 +116,8 @@ struct iomap {
 
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
+	if (iomap->flags & IOMAP_F_ANON_WRITE)
+		return U64_MAX; /* invalid */
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
-- 
2.45.2


