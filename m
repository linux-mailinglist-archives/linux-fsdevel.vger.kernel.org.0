Return-Path: <linux-fsdevel+bounces-7335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B86823A90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 03:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB602882EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962F2103;
	Thu,  4 Jan 2024 02:16:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383E4C60;
	Thu,  4 Jan 2024 02:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E43C433C8;
	Thu,  4 Jan 2024 02:16:25 +0000 (UTC)
Date: Wed, 3 Jan 2024 21:17:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240103211729.68283e87@gandalf.local.home>
In-Reply-To: <20240104015910.GP1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240104015910.GP1674809@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 01:59:10 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 03, 2024 at 08:32:46PM -0500, Steven Rostedt wrote:
> 
> > +static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
> > +{
> > +	struct tracefs_inode *ti;
> > +	struct inode *root_inode;
> > +
> > +	root_inode = d_inode(inode->i_sb->s_root);
> > +
> > +	/* If parent is NULL then use root inode */
> > +	if (!parent)
> > +		return root_inode;
> > +
> > +	/* Find the inode that is flagged as an instance or the root inode */
> > +	do {
> > +		inode = d_inode(parent);
> > +		if (inode == root_inode)
> > +			return root_inode;
> > +
> > +		ti = get_tracefs(inode);
> > +
> > +		if (ti->flags & TRACEFS_INSTANCE_INODE)
> > +			return inode;
> > +	} while ((parent = parent->d_parent));  
> 
> *blink*
> 
> This is equivalent to
> 		...
> 		parent = parent->d_parent;
> 	} while (true);

Yeah, that loop went through a few iterations as I first thought that root
was a tracefs_inode and the get_tracefs() would work on it. No, it was not,
and it caused a cash. But I didn't rewrite the loop well after fixing that.

I was also not sure if parent could be NULL, and wanted to protect against it.

> 
> ->d_parent is *never* NULL.  And what the hell is that loop supposed to do,  
> anyway?  Find the nearest ancestor tagged with TRACEFS_INSTANCE_INODE?
> 
> If root is not marked that way, I would suggest
> 	if (!parent)
> 		parent = inode->i_sb->s_root;
> 	while (!IS_ROOT(parent)) {
> 		struct tracefs_inode *ti = get_tracefs(parent->d_inode);
> 		if (ti->flags & TRACEFS_INSTANCE_INODE)
> 			break;
> 		parent = parent->d_parent;
> 	}
> 	return parent->d_inode;

Sure, I could rewrite it that way too.

Thanks,

-- Steve

