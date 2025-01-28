Return-Path: <linux-fsdevel+bounces-40236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C1A20CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6B3A7366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA51B425C;
	Tue, 28 Jan 2025 15:27:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D018DF86
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078047; cv=none; b=Zj5eLb1RSH0rbhbEEx3RYnbRnMbmHhz7w0hfqRmiaBXIQOtxmACMWEsxlO3VhCMNgQpyXHXshg9z6k8FCbWo3Oty4gmplF9XdB8wBpgsjtHLRJYMcTc4UKrZrv55f69wzyCsFkYbghuHu3wUdrE+59vGwWDn4B8157VHKRG+Pzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078047; c=relaxed/simple;
	bh=Q1Q9Gz0LT7x+RF1KQyyPxkUT3tnpClkUs7zr95+Rxyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpLY2zIDTmjOfhC/kGMByVYejzaTSstOLBylCcs8r8el1tn1i5b2/+mR1hLQHd6Sj8EZ3cCba0bjnTJd2PS/11ZhNW6gNk12rjagwIETSXkfOU0M1lLdLTQyju50N1nsc+/ZVYY1xpieBjDkSUplmvXiVOkjCD96/c3lHNdRDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CFAC4CED3;
	Tue, 28 Jan 2025 15:27:25 +0000 (UTC)
Date: Tue, 28 Jan 2025 10:27:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet
 <corbet@lwn.net>, James Bottomley <James.Bottomley@hansenpartnership.com>,
 Krister Johansen <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <20250128102744.1b94a789@gandalf.local.home>
In-Reply-To: <Z5h0Xf-6s_7AH8tf@infradead.org>
References: <20250121153646.37895-1-me@davidreaver.com>
	<Z5h0Xf-6s_7AH8tf@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 22:08:29 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 21, 2025 at 07:36:34AM -0800, David Reaver wrote:
> > This patch series creates a toy pseudo-filesystem built on top of kernfs in
> > samples/kernfs/.  
> 
> Is that a good idea?  kernfs and the interactions with the users of it
> is a pretty convoluted mess.  I'd much prefer people writing their
> pseudo file systems to the VFS APIs over spreading kernfs usage further.

I have to disagree with this. As someone that uses a pseudo file system to
interact with my subsystem, I really don't want to have to know the
intrinsics of the virtual file system layer just so I can interact via the
file system. Not knowing how to do that properly was what got me in trouble
with Linus is the first place.

The VFS layer is best for developing file systems that are for storage.
Like XFS, ext4, bcachefs, etc. And yes, if you are developing a new layout
of storage, then you should know the VFS APIs.

But pseudo file systems are a completely different beast. The files are not
for storage, but for control of the kernel. They map to control objects.
For tracefs, there's a "current_tracer". If you write "function" to it, it
starts the function tracer. It has to maintain state, but only for the life
of the boot, and not across boots. All of debugfs is the same way, and
unfortunately, the kernel API for debugfs is wrong. It uses dentries as the
handle to the files, which it should not be doing. dentry is a complex
internal cache element within VFS, and I assumed that because debugfs used
it, it was OK to use it as well, and that's where my arguments with Linus
stemmed from.

For people like myself that only need a way to have a control interface via
the file system, kernfs appears to cover that. Maybe kernfs isn't
implemented the way you like? If that's the case, we should fix that. But
from my point of view, it would be really great if I can create a file
system control interface without having to know anything about how VFS is
implemented.

BTW, I was going to work on converting debugfs over to kernfs if I ever got
the chance (or mentor someone else to do it). Whether it's kernfs or
something else, it would be really great to have a kernel abstraction layer
that creates a pseudo file system without having to create a pseudo file
system. debugfs was that, and became very popular, but it was done incorrectly.

-- Steve

