Return-Path: <linux-fsdevel+bounces-7426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FCD824A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23022B216A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E82C69A;
	Thu,  4 Jan 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p7YAaLYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4F2C69C;
	Thu,  4 Jan 2024 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VpiHI2Kr32mnTEJdDdX1NMESeAPZ+0Ox204pDtleoeY=; b=p7YAaLYdkiCGU8IWeBN7IrFyoa
	WrYiuZsm0J2ltUQTu5X/8H0IVewGPaA+hSm/ydSGxKfAVhVz4FXA+ee1cZc2Em0ixJ5CgQ3nl8PQy
	5caZlCUwRLYTG1D1N66pCTNZrFbEj3lj29JrIRt8Nwp3J8SHDRa7tBjiEmqEQ2LEGXwVTCuYzcfvP
	NxYRYRJKnjqG6xLqnVHGfpiP3r/QlFttiBdKho0ZNkRRFPTnAiLK9rW+sD8puwdHtuUMUGQsJuaKb
	LlLZBeOYehxLVBdOmgK2vzAtHDs6iGp7GpVuTtiqx+/BwujaiUtLbT0vZAx8ZzMUtutHOZSu4+/FI
	s4xvYz4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rLVGf-002Mut-2j;
	Thu, 04 Jan 2024 21:28:45 +0000
Date: Thu, 4 Jan 2024 21:28:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240104212845.GS1674809@ZenIV>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home>
 <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home>
 <20240104182502.GR1674809@ZenIV>
 <20240104141517.0657b9d1@gandalf.local.home>
 <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 04, 2024 at 11:35:37AM -0800, Linus Torvalds wrote:

> > "file description" - is how the file is accessed (position in the file and
> >                         flags associated to how it was opened)
> 
> That's a horrible term that shouldn't be used at all. Apparently some
> people use it for what is our 'struct file *", also known as a "file
> table entry".  Avoid it.

Worse, really.  As far as I can reconstruct what happened it was something
along the lines of "colloquial expression is 'opened file', but that is
confusing - sounds like a property+noun, so it might be misparsed as
a member of subset of files satisfying the property of 'being opened';
can't have that in a standard, let's come up with something else".
Except that what they did come up with had been much worse, for obvious
linguistic reasons.

The *ONLY* uses for that expression I can think of are
	1.  When reading POSIX texts, watch out for that one - if you
see them talking about a file descriptor in context where it really
should be about an opened file, check the wording.  If it really says
"file descriptOR", it's probably a bug in standard or a codified
bullshit practice.  If it says "file descriptION" instead, replace with
"opened file" and move on.
	2.  An outstanding example of the taste of that bunch.

IO channel would be a saner variant, but it's far too late for that.

The 3-way distinction between descriptor/opened file/file as collection of data
needs to be explained in UNIX 101; it is userland-visible and it has to be
understood.  Unfortunately, it's often done in a way that leaves students
seriously confused ;-/

