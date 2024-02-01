Return-Path: <linux-fsdevel+bounces-9897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D724A845D03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AAB1F235FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB65E226;
	Thu,  1 Feb 2024 16:16:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885D161B59;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=Mno0Fl39F0v3qA8PQ9EBSz1pJw9vulVwqRLlYPBEfEmGeVOBIzX42mIraN4Vh9MrLmcnFLo3WJetwMiKRTsLVTgO6rXJsLm/mPB+bXW5YQns5Z/b4GDp4bAIwkaJ4mHxKP2xqswZnQfDuR/sRiS+FM6NAEp7c2at0tlv7c96yCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=3+ZSFsB8n+3f4GqZyRsq0vWj2Y9oAbKeKdikbNmaVQ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FHYgZ6NObH+udnYmPxfXvRnGMvRHvdJ/LZOlNWuXCQkzCJ3e2MMVtAqGGC7cuC7XLAmfJOdlbAYBJ22m8b4w3oiOEqrkS0aI8q72omPmI8Hqq4UdwGtRFuhoS4W15anb80Cv2DAfHfvm5wowTZTkSgm9sw355qkdneWopfzyobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DE6C43330;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjd-00000005Tkg-2gF8;
	Thu, 01 Feb 2024 11:16:17 -0500
Message-ID: <20240201161617.499712009@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:51 -0500
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
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/6] eventfs: Add WARN_ON_ONCE() to checks in eventfs_root_lookup()
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's a couple of if statements in eventfs_root_lookup() that should
never be true. Instead of removing them, add WARN_ON_ONCE() around them.

  One is a tracefs_inode not being for eventfs.

  The other is a child being freed but still on the parent's children
  list. When a child is freed, it is removed from the list under the
  same mutex that is held during the iteration.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 110e8a272189..1a831ba1042b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -483,7 +483,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct dentry *result = NULL;
 
 	ti = get_tracefs(dir);
-	if (!(ti->flags & TRACEFS_EVENT_INODE))
+	if (WARN_ON_ONCE!(ti->flags & TRACEFS_EVENT_INODE)))
 		return ERR_PTR(-EIO);
 
 	mutex_lock(&eventfs_mutex);
@@ -495,7 +495,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
-		if (ei_child->is_freed)
+		/* A child is freed and removed from the list at the same time */
+		if (WARN_ON_ONCE(ei_child->is_freed))
 			goto out;
 		result = lookup_dir_entry(dentry, ei, ei_child);
 		goto out;
-- 
2.43.0



