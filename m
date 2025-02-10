Return-Path: <linux-fsdevel+bounces-41417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4AA2F450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907AA1630A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B811256C74;
	Mon, 10 Feb 2025 16:53:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39431256C66;
	Mon, 10 Feb 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206392; cv=none; b=OekD8S0yvt1GBNoo77PzbiSsmG+2M8Jdmbv9MBWympjuF0B3lseoF3ZPlGyWUS3VfwjLMTeWjyVlEl7qpGthu1lzHcE0f77mQyaWgbPTuDh4Hw5vbr9DPApTYpXb+Q+gVHNavBdr5TqLZSiuD1RrSF9RQBUfXaM4dipr0GelROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206392; c=relaxed/simple;
	bh=Q//plCetu74vtgrezSGZhTsyWcdKX2EfYkrS7/YBYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LODeWXYJAYpTjt01oLH7quGiE7OXiXN3THwFXRVhEgYQS8/h+yKbbqR873MLOF+8mzzAjwYFBpBF4lYpNZHBmxM7pCHGCwXPkyIXHUjAn/o3uue5FpgFZeIlaZ05WaSB3FNAZzraATFIkZ6/lhsBEcGz26+mPpVRrppUOeA9NO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBBDC4CED1;
	Mon, 10 Feb 2025 16:53:10 +0000 (UTC)
Date: Mon, 10 Feb 2025 11:53:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle
 in debugfs API
Message-ID: <20250210115313.69299472@gandalf.local.home>
In-Reply-To: <86ldud3hqe.fsf@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 08:08:25 -0800
David Reaver <me@davidreaver.com> wrote:

> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >
> > First off, many thanks for attempting this, I didn't think it was ready
> > to even be attempted, so it's very nice to see this.
> >  
> 
> No problem, and thank you for taking a look!
> 
> > That being said, I agree with Al, we can't embed a dentry in a structure
> > like that as the lifecycles are going to get messy fast.
> >  
> 
> Ack, I'll do something different in v2.
> 
> For my own education: what goes wrong with lifecycles with this embed?
> Feel free to point me at a doc or something.
> 
> Also, Al and Greg, would wrapping a pointer be fine?
> 
> 	struct debugfs_node {
> 		struct dentry *dentry;
> 	};

No it will not be fine. You should not be using dentry at all. I thought
this was going to convert debugfs over to kernfs. The debugfs_node should
be using kernfs and completely eliminate the use of dentry.


> 
> I was trying to do the simplest thing possible so the bulk of the change
> was mechanical. Wrapping a pointer is slightly more complicated because
> we have to deal with memory allocation, but it is still totally doable.
> 
> > Also, your replacement of many of the dentry functions with wrappers
> > seems at bit odd, ideally you would just return a dentry from a call
> > like "debugfs_node_to_dentry()" and then let the caller do with it what
> > it wants to, that way you don't need to wrap everything.

What caller should ever touch a dentry? What I got from my "conversation"
with Linus, is that dentry is an internal caching descriptor of the VFS
layer, and should only be used by the VFS layer. Nothing outside of VFS
should ever need a dentry.

-- Steve

