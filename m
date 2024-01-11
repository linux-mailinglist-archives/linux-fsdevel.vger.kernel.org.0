Return-Path: <linux-fsdevel+bounces-7818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949682B6DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7431C20D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBD58212;
	Thu, 11 Jan 2024 21:52:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7156B83;
	Thu, 11 Jan 2024 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573C2C433C7;
	Thu, 11 Jan 2024 21:52:16 +0000 (UTC)
Date: Thu, 11 Jan 2024 16:53:19 -0500
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
Message-ID: <20240111165319.4bb2af76@gandalf.local.home>
In-Reply-To: <20240111-unzahl-gefegt-433acb8a841d@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
	<20240111-unzahl-gefegt-433acb8a841d@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 22:01:32 +0100
Christian Brauner <brauner@kernel.org> wrote:

> What I'm pointing out in the current logic is that the caller is
> taxed twice:
> 
> (1) Once when the VFS has done inode_permission(MAY_EXEC, "xfs")
> (2) And again when you call lookup_one_len() in eventfs_start_creating()
>     _because_ the permission check in lookup_one_len() is the exact
>     same permission check again that the vfs has done
>     inode_permission(MAY_EXEC, "xfs").

As I described in: https://lore.kernel.org/all/20240110133154.6e18feb9@gandalf.local.home/

The eventfs files below "events" doesn't need the .permissions callback at
all. It's only there because the "events" inode uses it.

The .permissions call for eventfs has:

static int eventfs_permission(struct mnt_idmap *idmap,
			      struct inode *inode, int mask)
{
	set_top_events_ownership(inode);
	return generic_permission(idmap, inode, mask);
}

Where the "set_top_events_ownership() is a nop for everything but the
"events" directory.

I guess I could have two ops:

static const struct inode_operations eventfs_root_dir_inode_operations = {
	.lookup		= eventfs_root_lookup,
	.setattr	= eventfs_set_attr,
	.getattr	= eventfs_get_attr,
	.permission	= eventfs_permission,
};

static const struct inode_operations eventfs_dir_inode_operations = {
	.lookup		= eventfs_root_lookup,
	.setattr	= eventfs_set_attr,
	.getattr	= eventfs_get_attr,
};

And use the second one for all dentries below the root, but I figured it's
not that big of a deal if I called the permissions on all. Perhaps I should
do it with two?

Anyway, the issue is with "events" directory and remounting, because like
the tracefs system, the inode and dentry for "evnets" is created at boot
up, before the mount happens. The VFS layer is going to check the
permissions of its inode and dentry, which will be incorrect if the mount
was mounted with a "gid" option.


-- Steve

