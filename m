Return-Path: <linux-fsdevel+bounces-9896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BA845CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534941C22D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305385E215;
	Thu,  1 Feb 2024 16:16:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F29160895;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804160; cv=none; b=S0JyU8S9o6z6tPLawayfje7KS9T8ZDoEekuyrq1mlON/7bmTUdT59N7Xvda+IkbcMFaq0H3UwbbzWRwZm1pQxRRrP6GShoDLEQnUqMYeqdf9k/Uc6qx+ZVBlKsN8rpcRIoQmDftff2xOZhkBE5v1IaQz935c2Ed1VZtyWQ4mm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804160; c=relaxed/simple;
	bh=lNtIhhFDOlXg3opQxPWZoYHwa0F4HyqlbB3ETO/rgP4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aBEJMUw4SW44XD7MVs2b6xj4GJUq4mL+NiGGs6jimyT1mJBEXwTLCNmwj2jm+SbbqX4wuBXbY4mWAiF2jENI2l5ekdKYenxSck7bwCTNQpwGqZcQEYtupiwKF5FcuGWWbt51y4LvXNTqpWkg7Xtz8IGBHzC9J34/kq5M3HvnhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B97EC43390;
	Thu,  1 Feb 2024 16:16:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVZjd-00000005Tji-1JJ6;
	Thu, 01 Feb 2024 11:16:17 -0500
Message-ID: <20240201161617.166973329@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 10:34:49 -0500
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
Subject: [PATCH 3/6] eventfs: Remove fsnotify*() functions from lookup()
References: <20240201153446.138990674@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dentries and inodes are created when referenced in the lookup code.
There's no reason to call fsnotify_*() functions when they are created by
a reference. It doesn't make any sense.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/

Cc: stable@vger.kernel.org
Fixes: a376007917776 ("eventfs: Implement functions to create files and dirs when accessed");
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ca7daee7c811..9e031e5a2713 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -366,7 +366,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	dentry->d_fsdata = get_ei(parent_ei);
 
 	d_add(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return NULL;
 };
 
@@ -408,7 +407,6 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	inc_nlink(inode);
 	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	return NULL;
 }
 
-- 
2.43.0



