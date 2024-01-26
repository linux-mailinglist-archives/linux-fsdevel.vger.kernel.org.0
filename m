Return-Path: <linux-fsdevel+bounces-9032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136683D2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCBF290813
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1CAD49;
	Fri, 26 Jan 2024 02:40:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44781AD21
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236810; cv=none; b=lXVX/w/dn/LvlUGMmw96GZrxWi0MZkdX1PlyntTiP7obG4lkAhbb5x40otYB4pRl2A6P8Gv/+EuGlLVhRiusRQNFyl/eyztXg8VzGnS59Fd1Ac/oe8RBZbV9xn8q8LSiSDee/uP8zLbL4k1x5ZTnobeJgsuIw8NVt3cR9H10IT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236810; c=relaxed/simple;
	bh=v7wC8a4+mQjQAtY8RtTEFjG/D/c7rO2GJaaWLllfBIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ueeu0Gosoc2wniKIpLaob3XTxhYsGz8he/4j4FD38OpyqLb4PS71rop7tqUU27NHa7NYGpOadyTHL2m2ujwUijhx0P9R2pUDWWRsRcxXNj/pSsauVwtZ/1GZT+w6Td+dP6vmKEt6TOfQW445uIsTgjU5mEoFbSyKGNd5jKlOrLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0CDC433F1;
	Fri, 26 Jan 2024 02:40:08 +0000 (UTC)
Date: Thu, 25 Jan 2024 21:40:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <20240125214007.67d45fcf@rorschach.local.home>
In-Reply-To: <2024012528-caviar-gumming-a14b@gregkh>
References: <20240125104822.04a5ad44@gandalf.local.home>
	<2024012522-shorten-deviator-9f45@gregkh>
	<20240125205055.2752ac1c@rorschach.local.home>
	<2024012528-caviar-gumming-a14b@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 17:59:40 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > I tried to use kernfs when doing a lot of this and I had issues. I
> > don't remember what those were, but I can revisit it.  
> 
> You might, as kernfs makes it so that the filesystem structures are
> created on demand, when accessed, and then removed when memory pressure
> happens.  That's what sysfs and configfs and cgroups use quite
> successfully.

kernfs doesn't look trivial and I can't find any documentation on how
to use it.

Should there be work to move debugfs over to kernfs?

I could look at it too, but as tracefs, and more specifically eventfs,
has 10s of thousands of files, I'm very concerned about meta data size.

Currently eventfs keeps a data structure for every directory, but for
the files, it only keeps an array of names and callbacks. When a
directory is registered, it lists the files it needs. eventfs is
specific that the number of files a directory has is always constant,
and files will not be removed or added once a directory is created.

This way, the information on how a file is created is done via a
callback that was registered when the directory was created.

For this use case, I don't think kernfs could be used. But I would
still like to talk about what I'm trying to accomplish, and perhaps see
if there's work that can be done to consolidate what is out there.

-- Steve

