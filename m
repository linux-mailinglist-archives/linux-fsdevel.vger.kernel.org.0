Return-Path: <linux-fsdevel+bounces-71596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABCCCA0CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18ABF303D69A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF72773F9;
	Thu, 18 Dec 2025 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRItCi/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A979274B55;
	Thu, 18 Dec 2025 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023455; cv=none; b=Z+UvrIw2r/gmA9jnJiTqHOhnQC2U4YrIzHdEyBHokrYvfKsBpHnjgkB+aVPiGobfcATo2P+0HZAJb8hqG0QQWvWEkk6BwNone/0xRo1hGoozbz84IFXSMy37k8NwTMqIBVUBEciMo0+IDzjTx6nvQ8TDjEu/I64fU0cGOYkPyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023455; c=relaxed/simple;
	bh=o2IkMNn8AX+iH7gHlGjXIrQiY6QiLaQKmV+tSuHki58=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGHOz0Fifcswkk/rsaGnvcks8NuFeEjaM8s4XfBwSUzMWLFEAHButEgvOiUygNEilqJZe+9/PYb2ibespcFNz/SPJnzj/lcLw7CcquJt4+Gbab4VfVTLhgHeI6I8aeFtqXpM5VdLVU0M6XDdSUW4hCw02+Rs3yJB2vNHuGxvAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRItCi/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC111C4CEF5;
	Thu, 18 Dec 2025 02:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023454;
	bh=o2IkMNn8AX+iH7gHlGjXIrQiY6QiLaQKmV+tSuHki58=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jRItCi/tef0oGiITHDkoTpmFOQvCcWOHxCZBW5wPkm29dN9K//KpuMK1reDlXAiiN
	 6JrNMzS+Rn0BKs2TcW3X/68WqzIdZlKkaPyu1ZZH5CCH8YAjCtHiAt6GZzszEfFd5C
	 e+bKxjHZjYOu3gnr46x+teljo9xaA9G9TiLI9OjDAjdiPE8jaecDL6wRc1RlRd1tT4
	 7l1zuTCrrmr0Z6bm7UeDIsm2zrsj1cMFufR+0gLfMBOKWveNuWt5iRNp86DHdJxuFp
	 CxO5ieo9BoEBY3qXe9IeiN7zFbkw2DVVuj0Sm/wpujaEoKiLWEOyoVKvmlppYrYMdO
	 /6qM2zwqyEY3g==
Date: Wed, 17 Dec 2025 18:04:14 -0800
Subject: [PATCH 6/6] ext4: convert to new fserror helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gabriel@krisman.be, hch@lst.de,
 amir73il@gmail.com
Message-ID: <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the new fserror functions to report metadata errors to fsnotify.
Note that ext4 inconsistently passes around negative and positive error
numbers all over the codebase, so we force them all to negative for
consistency in what we report to fserror, and fserror ensures that only
positive error numbers are passed to fanotify, per the fanotify(7)
manpage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/ioctl.c |    2 ++
 fs/ext4/super.c |   13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2fb..ea26cd03d3ce28 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/fsmap.h>
 #include "fsmap.h"
 #include <trace/events/ext4.h>
+#include <linux/fserror.h>
 
 typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
 				     struct ext4_super_block *es,
@@ -844,6 +845,7 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
 		return -EINVAL;
 	}
 	clear_opt(sb, DISCARD);
+	fserror_report_shutdown(sb, GFP_KERNEL);
 	return 0;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d026..a6241ffb8639c3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -48,6 +48,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fserror.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -824,7 +825,8 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
-	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
+	fserror_report_metadata(sb, error ? -abs(error) : -EFSCORRUPTED,
+				GFP_ATOMIC);
 
 	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
 }
@@ -856,7 +858,9 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
-	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
+	fserror_report_file_metadata(inode,
+				     error ? -abs(error) : -EFSCORRUPTED,
+				     GFP_ATOMIC);
 
 	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
 			  function, line);
@@ -896,7 +900,7 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
-	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
+	fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_ATOMIC);
 
 	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
 			  function, line);
@@ -965,7 +969,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
 		       sb->s_id, function, line, errstr);
 	}
-	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
+	fserror_report_metadata(sb, errno ? -abs(errno) : -EFSCORRUPTED,
+				GFP_ATOMIC);
 
 	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
 }


