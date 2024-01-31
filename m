Return-Path: <linux-fsdevel+bounces-9702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDD84478B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA9F1F27609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D53E481;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D938FA1;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727297; cv=none; b=VmkwwH+MDQoSEsw7ZnFrsyp0lsfw7PKc3U0IQkmTBPDAteA8ky815gfdDfO0xie6MUbUH0PUIug14czJvIeGyK9mLaXbErtkx1rCFdtZFPluNPC3//upCW2OIruXifMpZImTe3ORMOgaIOLFPWkQlK2vm9dvGPMj1xFyoA1ntc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727297; c=relaxed/simple;
	bh=pfpMUH3tWGcM1lGwQK3NyStqZwiqHr8qawaLbZJl8tw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T6AxM+xZwbHEwWwMTbX//V46Ogcnw9Rcs58K0Ere9mGIo046PaIMN36JPk+Cxnzf9ZCCNYXZuOf9KzU4PgzSqFN/P1NVQc2xXuE2c0k4l6LK3iQW0wZ21GvAwr46TCfL+i0wnto4wal8o5/l7s8QLehvkfQkAsByVY30nbhmTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C98CC433F1;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjs-000000055Ps-1v8J;
	Wed, 31 Jan 2024 13:55:12 -0500
Message-ID: <20240131185512.315825944@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/7] tracefs: Zero out the tracefs_inode when allocating it
References: <20240131184918.945345370@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

eventfs uses the tracefs_inode and assumes that it's already initialized
to zero. That is, it doesn't set fields to zero (like ti->private) after
getting its tracefs_inode. This causes bugs due to stale values.

Just initialize the entire structure to zero on allocation so there isn't
any more surprises.

This is a partial fix to access to ti->private. The assignment still needs
to be made before the dentry is instantiated.

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since last version: https://lore.kernel.org/all/20240130230612.377a1933@gandalf.local.home/

- Moved vfs_inode to top of tracefs_inode structure so that the rest can
  be initialized with memset_after() as the vfs_inode portion is already
  cleared with a memset() itself in inode_init_once().

 fs/tracefs/inode.c    | 6 ++++--
 fs/tracefs/internal.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..888e42087847 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -38,8 +38,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
@@ -779,7 +777,11 @@ static void init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
+	/* inode_init_once() calls memset() on the vfs_inode portion */
 	inode_init_once(&ti->vfs_inode);
+
+	/* Zero out the rest */
+	memset_after(ti, 0, vfs_inode);
 }
 
 static int __init tracefs_init(void)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 91c2bf0b91d9..7d84349ade87 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -11,9 +11,10 @@ enum {
 };
 
 struct tracefs_inode {
+	struct inode            vfs_inode;
+	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	unsigned long           flags;
 	void                    *private;
-	struct inode            vfs_inode;
 };
 
 /*
-- 
2.43.0



