Return-Path: <linux-fsdevel+bounces-7554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B933D8272E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690C728321A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AB4C3DC;
	Mon,  8 Jan 2024 15:22:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C44C3AD;
	Mon,  8 Jan 2024 15:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB3C433C8;
	Mon,  8 Jan 2024 15:22:35 +0000 (UTC)
Date: Mon, 8 Jan 2024 10:23:31 -0500
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
Message-ID: <20240108102331.7de98cab@gandalf.local.home>
In-Reply-To: <20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 12:04:54 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > > redundant and just wrong.  
> > 
> > I don't think so.  
> 
> I'm very well aware that the dentries and inode aren't created during
> mkdir but the completely directory layout is determined. You're just
> splicing in dentries and inodes during lookup and readdir.
> 
> If mkdir /sys/kernel/tracing/instances/foo has succeeded and you later
> do a lookup/readdir on
> 
> ls -al /sys/kernel/tracing/instances/foo/events
> 
> Why should the creation of the dentries and inodes ever fail due to a
> permission failure?

They shouldn't.

> The vfs did already verify that you had the required
> permissions to list entries in that directory. Why should filling up
> /sys/kernel/tracing/instances/foo/events ever fail then? It shouldn't
> That tracefs instance would be half-functional. And again, right now
> that inode_permission() check cannot even fail.

And it shouldn't. But without dentries and inodes, how does VFS know what
is allowed to open the files?

-- Steve

