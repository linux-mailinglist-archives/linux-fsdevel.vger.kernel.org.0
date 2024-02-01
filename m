Return-Path: <linux-fsdevel+bounces-9895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB46845CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F2D1C24EFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEB5E211;
	Thu,  1 Feb 2024 16:16:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5865160894;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=GDVjlxYkZtc+HS4w0BAJNhXQa3XTlLft+OApsQLoAfYs2pX4OPGY2DhFWGK696fE8ix0OnLujqS3W3KnAUEgAmQLUPT7k7Ko3wQStPXBFBkqTk0swp2Pto6B9gy+e3PCNdpyg+s9SatOv3DWv6Kqt1dQlKKhU8nfZANOvvxpbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=aYQmR4grRcJrLfjdmABWmdW24Zibr5d0HrWyIDxBXt8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=L+4y6w0Y2Ydtbi02X7/i10xoUKaeoj3ZxuXjzsvUnS8d1Bndiek7CWxdsZY3TGeLZOaPndXuh3HbGePzk0GwqSpS8DXx/CLWDbQaGjPE5ZVMsjjibROye0fC7h11ZCDn+r2YfUbEpVnm93sSGeos+B874kqFimQlXLwujkstqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56772C43141;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjd-00000005TkC-20gX;
	Thu, 01 Feb 2024 11:16:17 -0500
Message-ID: <20240201161617.339968298@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:50 -0500
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
 stable@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] eventfs: Keep all directory links at 1
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The directory link count in eventfs was somewhat bogus. It was only being
updated when a directory child was being looked up and not on creation.

One solution would be to update in get_attr() the link count by iterating
the ei->children list and then adding 2. But that could slow down simple
stat() calls, especially if it's done on all directories in eventfs.

Another solution would be to add a parent pointer to the eventfs_inode
and keep track of the number of sub directories it has on creation. But
this adds overhead for something not really worthwhile.

The solution decided upon is to keep all directory links in eventfs as 1.
This tells user space not to rely on the hard links of directories. Which
in this case it shouldn't.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/

Cc: stable@vger.kernel.org
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9e031e5a2713..110e8a272189 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -404,9 +404,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	dentry->d_fsdata = get_ei(ei);
 
-	inc_nlink(inode);
 	d_add(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
 	return NULL;
 }
 
@@ -769,9 +767,17 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 
 	dentry->d_fsdata = get_ei(ei);
 
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
+	/*
+	 * Keep all eventfs directories with i_nlink == 1.
+	 * Due to the dynamic nature of the dentry creations and not
+	 * wanting to add a pointer to the parent eventfs_inode in the
+	 * eventfs_inode structure, keeping the i_nlink in sync with the
+	 * number of directories would cause too much complexity for
+	 * something not worth much. Keeping directory links at 1
+	 * tells userspace not to trust the link number.
+	 */
 	d_instantiate(dentry, inode);
+	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
-- 
2.43.0



