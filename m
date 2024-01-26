Return-Path: <linux-fsdevel+bounces-9062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A375983DB95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B471C231D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE71C28F;
	Fri, 26 Jan 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tJGxvR8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE41B599
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278599; cv=none; b=Is/sORcY8jD4eAWZEWy8erABaQccgMsEoBjw8dBIYqmBjJE+29yThbPovJ/KnhCC30SQCj8LSe5ugAadonqediEsE+HdY9GhFA8w6O/ijySauvQToKG9qwn60CiZCu6fg1EJto5j2Hlb6OEuFx1m64sWZfXhGJsqPl7aW3hbw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278599; c=relaxed/simple;
	bh=UTvndD8gsD+zqm4ZX9/GghH1PWJ0G0e8T5kRquh5wW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd19xbHzjPU2xqhWHUomwFM9duzGkOnwhmEeIho0Wnbsakgy66dHd2zdLBcsYrzf/lSXyk5X8K2sOJj4U2TrfZgEQ7NvgYqueCJ3z17nGnzOyW+/l9OntrpiofxmTxrDegiQ/JfGdp6SBZZs9/JVnIcBVsUMk4AlyJf4mW4tSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tJGxvR8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218ACC433C7;
	Fri, 26 Jan 2024 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706278599;
	bh=UTvndD8gsD+zqm4ZX9/GghH1PWJ0G0e8T5kRquh5wW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJGxvR8oma7uNXWe0Z9VxtxQNjLU+fGvWcDxDVo13j/zUwOaR10OgqCT+uHEc0qpC
	 uJMdLXgawSyIXk040fVGxbLlC3v2G20/O8HGt2doYeg9+WZVaedotoDr3rJmpoQYmA
	 O4D2vvx9wjtHLBr6NKi2QI6MvJHuNlY8JNJCgVmM=
Date: Fri, 26 Jan 2024 06:16:38 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <2024012634-rotten-conjoined-0a98@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
 <2024012522-shorten-deviator-9f45@gregkh>
 <20240125205055.2752ac1c@rorschach.local.home>
 <2024012528-caviar-gumming-a14b@gregkh>
 <20240125214007.67d45fcf@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125214007.67d45fcf@rorschach.local.home>

On Thu, Jan 25, 2024 at 09:40:07PM -0500, Steven Rostedt wrote:
> On Thu, 25 Jan 2024 17:59:40 -0800
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > > I tried to use kernfs when doing a lot of this and I had issues. I
> > > don't remember what those were, but I can revisit it.  
> > 
> > You might, as kernfs makes it so that the filesystem structures are
> > created on demand, when accessed, and then removed when memory pressure
> > happens.  That's what sysfs and configfs and cgroups use quite
> > successfully.
> 
> kernfs doesn't look trivial and I can't find any documentation on how
> to use it.

You have the code :)

> Should there be work to move debugfs over to kernfs?

Why?  Are you seeing real actual memory use with debugfs that is causing
problems?  That is why we made kernfs, because people were seeing this
in sysfs.

Don't change stuff unless you need to, right?

> I could look at it too, but as tracefs, and more specifically eventfs,
> has 10s of thousands of files, I'm very concerned about meta data size.

Do you have real numbers?  If not, then don't worry about it :)

> Currently eventfs keeps a data structure for every directory, but for
> the files, it only keeps an array of names and callbacks. When a
> directory is registered, it lists the files it needs. eventfs is
> specific that the number of files a directory has is always constant,
> and files will not be removed or added once a directory is created.
> 
> This way, the information on how a file is created is done via a
> callback that was registered when the directory was created.

That's fine, and shouldn't matter.

> For this use case, I don't think kernfs could be used. But I would
> still like to talk about what I'm trying to accomplish, and perhaps see
> if there's work that can be done to consolidate what is out there.

Again, look at kernfs if you care about the memory usage of your virtual
filesystem, that's what it is there for, you shouldn't have to reinvent
the wheel.

And the best part is, when people find issues with scaling or other
stuff with kernfs, your filesystem will then benifit (lots of tweaks
have gone into kernfs for this over the past few kernel releases.)

thanks,

greg k-h

