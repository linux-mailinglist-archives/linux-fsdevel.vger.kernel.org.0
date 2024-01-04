Return-Path: <linux-fsdevel+bounces-7416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DE824900
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CD91C2262D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AFD2C6A0;
	Thu,  4 Jan 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CaTDRcGq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50952C1A5;
	Thu,  4 Jan 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHJdWxHao+sFhZwo/PLG5+DYdMRYk7fVp+3r2qEb254=; b=CaTDRcGqgAO+q0x5oLCqNKQ2LN
	Ag4j4XVzZ0Ji8skGNCU7Y4Qq2g1DUI+cTqsU3L8VcW/cEzI/kV6p8D0S3gM3F5ay1BPsPI78vp8o/
	AAXHrm1DI+OUD8RCfZCbxY2opXHZtaAfpiLZLA4ksMpQVwTGDh1RTsSOnvpkso1eZf7/YrbC/1ATC
	dPCHo31d5/Pr0Pih4JvYFX/cLoASEEYq3c0zCKYw6elyRZ+R6pvapnTZA+rHAeQl60KUmJmTGJTaZ
	8saqMU05m60Q6qeuYF7lF0zuIj9Ndx9NGJkJjlgVS/cUf09qQr1zl1z8pP4EXDEx11KnGXRv59df5
	ZJkxeE7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLTMp-00FqUL-44; Thu, 04 Jan 2024 19:26:59 +0000
Date: Thu, 4 Jan 2024 19:26:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <ZZcGg5/SFSOUC9PX@casper.infradead.org>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home>
 <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home>
 <20240104182502.GR1674809@ZenIV>
 <20240104141517.0657b9d1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104141517.0657b9d1@gandalf.local.home>

On Thu, Jan 04, 2024 at 02:15:17PM -0500, Steven Rostedt wrote:
> On Thu, 4 Jan 2024 18:25:02 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Unfortunately, the terms are clumsy as hell - POSIX ends up with
> > "file descriptor" (for numbers) vs. "file description" (for IO
> > channels), which is hard to distinguish when reading and just
> > as hard to distinguish when listening.  "Opened file" (as IO
> > channel) vs. "file on disc" (as collection of data that might
> > be accessed via said channels) distinction on top of that also
> > doesn't help, to put it mildly.  It's many decades too late to
> > do anything about, unfortunately.  Pity the UNIX 101 students... ;-/
> 
> Just so I understand this correctly.
> 
> "file descriptor" - is just what maps to a specific inode.

No -- file descriptor is a number in fdtable that maps to a struct file.

> "file description" - is how the file is accessed (position in the file and
> 			flags associated to how it was opened)

file description is posix's awful name for struct file.

