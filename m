Return-Path: <linux-fsdevel+bounces-7721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88E829DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8321C22691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02914C3C6;
	Wed, 10 Jan 2024 15:51:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C24CB20;
	Wed, 10 Jan 2024 15:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF0C433C7;
	Wed, 10 Jan 2024 15:51:50 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:52:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240110105251.48334598@gandalf.local.home>
In-Reply-To: <20240110080746.50f7767d@gandalf.local.home>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 08:07:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Or are you saying that I don't need the ".permission" callback, because
> eventfs does it when it creates the inodes? But for eventfs to know what
> the permissions changes are, it uses .getattr and .setattr.

OK, if your main argument is that we do not need .permission, I agree with
you. But that's a trivial change and doesn't affect the complexity that
eventfs is doing. In fact, removing the "permission" check is simply this
patch:

--
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..f2af07a857e2 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -192,18 +192,10 @@ static int eventfs_get_attr(struct mnt_idmap *idmap,
 	return 0;
 }
 
-static int eventfs_permission(struct mnt_idmap *idmap,
-			      struct inode *inode, int mask)
-{
-	set_top_events_ownership(inode);
-	return generic_permission(idmap, inode, mask);
-}
-
 static const struct inode_operations eventfs_root_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
 	.getattr	= eventfs_get_attr,
-	.permission	= eventfs_permission,
 };
 
 static const struct inode_operations eventfs_file_inode_operations = {
--

I only did that because Linus mentioned it, and I thought it was needed.
I'll apply this patch too, as it appears to work with this code.

Thanks!

-- Steve

