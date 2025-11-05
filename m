Return-Path: <linux-fsdevel+bounces-67050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8816C338EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EDFE34E80E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3523EAB9;
	Wed,  5 Nov 2025 00:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CygjpLBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01723D29F;
	Wed,  5 Nov 2025 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304128; cv=none; b=Om90SbHorCEs/1hu8t5y87w/vkLz3P7X7vDWrF5h3urlBr3YhDo+zJYVRGZrvH4KxEQ7ynrLyGI+kJa4EItwOrlEJ8KauQbg/1XfxZ9hkTIinrHgUcWUs0rwhvypSIrVJ9LvrZrKHCJFHQ+FU1O7rmHP0XyTKo0WchN5+d7HQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304128; c=relaxed/simple;
	bh=9bNmRfPhWNicPKXx2JVhesKKa1/d7j9UP2sdlMJAHXY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHJC0q8YTZzWGMOvaXaLzbNITfngEM5mzvzH3Usa7qhyHqg66NZ/QAX/30n+7dRC/NGBq3s0qhwtofvz3vQIMmPZXKG8GMBNbdTYWsOtptVA/6l4HkbYIVzhLU7l55zLw9O7mSbCPuB6DHvuKT9LJqCihTQSmp+xwTSt2UcpVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CygjpLBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8781C116B1;
	Wed,  5 Nov 2025 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304127;
	bh=9bNmRfPhWNicPKXx2JVhesKKa1/d7j9UP2sdlMJAHXY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CygjpLBGv5u7F3H7JkY0jKY/kpGEX+/S9zVfXIN7FTFApYYPhig1eWJeMi0z+9gRY
	 o8TNYPdTg0B3BqR4uqYshwZxlk12QtaOvICp9LVbyGkLs5/CQYFs/srqjvXln1Q/37
	 2VuwP2s8Q4zHW8886ih5tiH+wD7a0ONXuhCDUQ86GwTrT+rIyvAwHqghWHJ0PoGW/Z
	 +gTo9dnkREDgEUcKGwmvGNRgNXBN+WhLOqRA+cc1WldSs0FZjYj1qn/a4H0Lc/1GP3
	 IHxP4Nicfl1+Dh0hFvJfor2crGOrYAS4n7Fpccca6GnhwDdgE9I0H1W5ZFfhxJ2ahQ
	 GEopjlahIydtA==
Date: Tue, 04 Nov 2025 16:55:27 -0800
Subject: [PATCH 5/6] iomap: remove I/O error hooks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366541.1647991.782691764802400138.stgit@frogsfrogsfrogs>
In-Reply-To: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
References: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the I/O error hooks from struct address_space and iomap_dio_ops
because there are no more callers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/linux/fs.h                |    4 ----
 include/linux/iomap.h             |    2 --
 Documentation/filesystems/vfs.rst |    7 -------
 fs/iomap/buffered-io.c            |    4 ----
 fs/iomap/direct-io.c              |    4 ----
 5 files changed, 21 deletions(-)


diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb3965db3275c..6e3a7cbefbca8a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -478,10 +478,6 @@ struct address_space_operations {
 				sector_t *span);
 	void (*swap_deactivate)(struct file *file);
 	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
-
-	/* Callback for dealing with IO errors during readahead or writeback */
-	void (*ioerror)(struct address_space *mapping, int direction,
-			loff_t pos, u64 len, int error);
 };
 
 extern const struct address_space_operations empty_aops;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index ca1590e5002342..73dceabc21c8c7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -486,8 +486,6 @@ struct iomap_dio_ops {
 		      unsigned flags);
 	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
 		          loff_t file_offset);
-	void (*ioerror)(struct inode *inode, int direction, loff_t pos,
-			u64 len, int error);
 
 	/*
 	 * Filesystems wishing to attach private information to a direct io bio
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 9e70006bf99a63..4f13b01e42eb5e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -822,8 +822,6 @@ cache in your filesystem.  The following members are defined:
 		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
 		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
-		void (*ioerror)(struct address_space *mapping, int direction,
-				loff_t pos, u64 len, int error);
 	};
 
 ``read_folio``
@@ -1034,11 +1032,6 @@ cache in your filesystem.  The following members are defined:
 ``swap_rw``
 	Called to read or write swap pages when SWP_FS_OPS is set.
 
-``ioerror``
-        Called to deal with IO errors during readahead or writeback.
-        This may be called from interrupt context, and without any
-        locks necessarily being held.
-
 The File Object
 ===============
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dc19311fe1c6c0..32628550093f65 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -296,10 +296,6 @@ inline void iomap_mapping_ioerror(struct address_space *mapping, int direction,
 	inode_error(inode,
 		    direction == READ ? FSERR_READAHEAD : FSERR_WRITEBACK,
 		    pos, len, error);
-
-	if (mapping && mapping->a_ops->ioerror)
-		mapping->a_ops->ioerror(mapping, direction, pos, len,
-				error);
 }
 
 /**
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9f6ce0d9c531bb..1f140031416a0c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -100,10 +100,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 			    (dio->flags & IOMAP_DIO_WRITE) ? FSERR_DIO_WRITE :
 							     FSERR_DIO_READ,
 			    offset, dio->size, dio->error);
-	if (dio->error && dops && dops->ioerror)
-		dops->ioerror(file_inode(iocb->ki_filp),
-				(dio->flags & IOMAP_DIO_WRITE) ? WRITE : READ,
-				offset, dio->size, dio->error);
 
 	if (likely(!ret)) {
 		ret = dio->size;


