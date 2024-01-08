Return-Path: <linux-fsdevel+bounces-7528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A20B826CDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D51C22027
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B014A93;
	Mon,  8 Jan 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7+dT7qS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244D14AA9;
	Mon,  8 Jan 2024 11:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB358C433C7;
	Mon,  8 Jan 2024 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704713572;
	bh=tSNAM6JWF8XX8kU8+fujI2z/wVl8zHOZzyBlqT0PMT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7+dT7qSsTrSZcf4S4rg3BbBihyZXeEZLgDC6as7ZNAnlSdCkB3I1uDP/4bZ7qvY9
	 uZamI5gH3Vn2yxh37F3tyWtp+MJaXeqh4uNnX09qF5i2uYBGifc6yvg0w0Ig0Q9ohy
	 ZaRlgN71Yre21iEKv4Xmc5OdW1um4woGoP9B5+7IbHT3UqW3cSFN3O0pQ2r1HZ6EE0
	 7xPZ5r5QFFgpHhv1wV5rQfE8rJkYecMmyupBTUKTabnufzAaKCqKxMOAW/XkJY2ub8
	 d3F0PoQomSYR4TPEGGzEOt++rhJIWo2s8O8vntrzxsTB7sq/4+KYwHGYlRBVBHPKK5
	 jDZxsll9sYImQ==
Date: Mon, 8 Jan 2024 12:32:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240108-natur-geophysik-f4c6fdaf6901@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107132912.71b109d8@rorschach.local.home>
 <20240107133228.05b0f485@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240107133228.05b0f485@rorschach.local.home>

On Sun, Jan 07, 2024 at 01:32:28PM -0500, Steven Rostedt wrote:
> On Sun, 7 Jan 2024 13:29:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > 
> > > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > > redundant and just wrong.  
> > 
> > I don't think so.
> 
> Just to make it clear. eventfs has nothing to do with mkdir instance/foo.
> It exists without that. Although one rationale to do eventfs was so

Every instance/foo/ tracefs instances also contains an events directory
and thus a eventfs portion. Eventfs is just a subtree of tracefs. It's
not a separate filesystem. Both eventfs and tracefs are on the same
single, system wide superblock.

> that the instance directories wouldn't recreate the same 10thousands
> event inodes and dentries for every mkdir done.

I know but that's irrelevant to what I'm trying to tell you.

A mkdir /sys/kernel/tracing/instances/foo creates a new tracefs
instance. With or without the on-demand dentry and inode creation for
the eventfs portion that tracefs "instance" has now been created in its
entirety including all the required information for someone to later
come along and perform a lookup on /sys/kernel/tracing/instances/foo/events.

All you've done is to defer the addition of the dentries and inodes when
someone does actually look at the events directory of the tracefs
instance.

Whether you choose to splice in the dentries and inodes for the eventfs
portion during lookup and readdir or if you had chosen to not do the
on-demand thing at all and the entries were created at the same time as
the mkdir call are equivalent from the perspective of permission
checking.

If you have the required permissions to look at the events directory
then there's no reason why listing the directory entries in there should
fail. This can't even happen right now.

