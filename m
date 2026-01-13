Return-Path: <linux-fsdevel+bounces-73342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28159D160D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2712D302CF92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF0244186;
	Tue, 13 Jan 2026 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkyqh+lT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A701AE877;
	Tue, 13 Jan 2026 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264348; cv=none; b=FU6e9vnceHkqNiA2l9+GYKxYpx+Vyb3nFUvu61BKdPqTnu9dla1bWa9MVTjwo+xB+kEkaDXY0CS5ola+Q0Bj5pTaMeHMCuWTxXPe9lV17d6w8lSPicS+AdjdFlFx28d0B5RRfJKO4uC5MdHNNoF8OImeBAVGBIA8oLwqNqX3yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264348; c=relaxed/simple;
	bh=WYOnaGpCt1H8IZt48yiPXpp+nB3dDNC8788fdfVLmV4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga3GKJY+Q5G8w1H2a2+aNNrX5FhOB4ExXey6eBvFDnTWwfyvUSvKkr5jgUEexMWXll0tEQCzFd6/PCqE0atyvi7iWr4LEkaRbO+n+obPLMoZIDejrAVbIF+yox6zGPiIihjL/770Wpf2Ke0rZcLroR9rWeIHS86aWbv0mhJwtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkyqh+lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68913C116D0;
	Tue, 13 Jan 2026 00:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264348;
	bh=WYOnaGpCt1H8IZt48yiPXpp+nB3dDNC8788fdfVLmV4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Hkyqh+lTl7dJOR1VbOpHOlyS+ZK2SJl18EFQ0f7PnSpyWV4gFqKnMjaIaOmsMG39E
	 Mn2JdJ6beytwq4BqPopwSfaXVe+8l9jM8L8ZkTYNVjJo6HF+4Q7VcfsDicQxi2m4o4
	 1uSTTnfW/vgMBVwsORS5PHtPERRoUwqPd9zb8E7pXIwKS2rgV/UCZ4+M492ndmyLcP
	 cxKmnX/fjHY8r1y2Nu3O9H5m8CIWlEZmiHoj/SeQe/hWQFXDdy37L0Qtgih122oSOj
	 4VxutWK2Qa/ahRCbQWyNNs2gW9vgrmjBbCd20ev0KxlNfNAqhp1t/8Kd7XUpOXLmu9
	 w3zqA+y87MNGw==
Date: Mon, 12 Jan 2026 16:32:27 -0800
Subject: [PATCH 6/6] ext4: convert to new fserror helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>
In-Reply-To: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
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


