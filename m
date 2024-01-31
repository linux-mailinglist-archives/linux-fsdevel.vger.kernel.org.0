Return-Path: <linux-fsdevel+bounces-9704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED204844792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A989A2845A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B73FB16;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126083A8FE;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727298; cv=none; b=QNyL46sDnBnrpgal219thiF4Hw4JOvSzIMwBjGrnEAmA2VHnjHQe05JrqA6druQj6Eh/YRbOmkZhUvhZcw8r34DGokCsQ/rAdveXpbAkzSasqOJdfb0CdM0CB/RCfyFMXVElS7rJH6PjLOFEYQScxJUn2C40TdoKb3ywpanh9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727298; c=relaxed/simple;
	bh=7Rdww8PD/OZDuJxNvZnG5j/I+jvbRavpqIHcKsYavJQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O8KbXwxcDuDNVuzyThFh293AFGLq0ovmBcfZ1iFkezRYTECvHntNpB//rASDyXktw+I//quNIEFhjG1fzLTeXvupAIZOsoulwnPPJ/yjmw5mIFtP+wa9gG5XZLJEe/yi5WjjHO9teI0/tzszT0iCOIp9DilZtnFeTtzQJtEFRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D7AC433A6;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjs-000000055QM-2apb;
	Wed, 31 Jan 2024 13:55:12 -0500
Message-ID: <20240131185512.478449628@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:20 -0500
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
Subject: [PATCH v2 2/7] eventfs: Initialize the tracefs inode properly
References: <20240131184918.945345370@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The tracefs-specific fields in the inode were not initialized before the
inode was exposed to others through the dentry with 'd_instantiate()'.

Move the field initializations up to before the d_instantiate.

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-2-torvalds@linux-foundation.org

-  Since another patch zeroed out the entire tracefs_inode, there's no need
   to initialize any of its fields to NULL.

 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1c3dd0ad4660..824b1811e342 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -370,6 +370,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
+	/* Only directories have ti->private set to an ei, not files */
+	ti->private = ei;
 
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
@@ -515,7 +517,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 static void eventfs_post_create_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *ei_child;
-	struct tracefs_inode *ti;
 
 	lockdep_assert_held(&eventfs_mutex);
 
@@ -525,9 +526,6 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		ei_child->d_parent = ei->dentry;
 	}
-
-	ti = get_tracefs(ei->dentry->d_inode);
-	ti->private = ei;
 }
 
 /**
-- 
2.43.0



