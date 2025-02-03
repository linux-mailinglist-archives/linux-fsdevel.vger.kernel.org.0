Return-Path: <linux-fsdevel+bounces-40620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459DA25DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E17162488
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B4208962;
	Mon,  3 Feb 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbhdVjLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE2205E32
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595121; cv=none; b=K9k3BVFHls/NfaGwyW6fyY69g8usvc32HDWgyZSOD8QCYXOpbI6XFswCswOou0/4A7S8iNbgDeea5X5VRwFd3PYC8jcgiW34b8bCdaj4P4bq6K58sWTGoTRC76Y15Q1bQKg2tNHnXqAT5BLHW53XvctUtoIWjnLXfRawSgYy3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595121; c=relaxed/simple;
	bh=y96G8i+2lpn6HM/qLoEH/mCnBd4vskBwM1j67112IVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcQJB0qXiNRzuFxTZ3UyPc9Ei9I6II989YSyj3dS2PBTmjFFQPjtBMdvh0HLceBpOLJQIYUnCOX+xoXBExkZKhDzffPmCunZjTHx2XlUW+rTnaHNrn+L/PfD/AG5VLZ54xPuDyXyX1In+Civ9jFhT30DvCq7Iax3x06Gn+EjEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbhdVjLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9111C4CEE0;
	Mon,  3 Feb 2025 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738595120;
	bh=y96G8i+2lpn6HM/qLoEH/mCnBd4vskBwM1j67112IVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbhdVjLPvNaBvLBo4WxkbXMJb25li1ZDJwCfEnotQzpGgmJ/sK5B8D19TGkxnR8lE
	 f0tPlBAfzx/+f4skcaHxAGHGLTS3jsTWxdrJ63ofdcg/KkYTkAtVgJXDEnFHeLmiIj
	 cVR+ZRmOnJCHE/JmSypgHc1SmXq+x653LGotYf00=
Date: Mon, 3 Feb 2025 16:05:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Reaver <me@davidreaver.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <2025020304-mango-preheated-1560@gregkh>
References: <20250121153646.37895-1-me@davidreaver.com>
 <Z5h0Xf-6s_7AH8tf@infradead.org>
 <20250128102744.1b94a789@gandalf.local.home>
 <CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
 <20250128174257.1e20c80f@gandalf.local.home>
 <Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
 <20250128182957.55153dfc@gandalf.local.home>
 <Z5lqguLX-XeoktBa@slm.duckdns.org>
 <20250128190224.635a9562@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128190224.635a9562@gandalf.local.home>

On Tue, Jan 28, 2025 at 07:02:24PM -0500, Steven Rostedt wrote:
> On Tue, 28 Jan 2025 13:38:42 -1000
> Tejun Heo <tj@kernel.org> wrote:
> 
> > On Tue, Jan 28, 2025 at 06:29:57PM -0500, Steven Rostedt wrote:
> > > What I did for eventfs, and what I believe kernfs does, is to create a
> > > small descriptor to represent the control data and reference them like what
> > > you would have on disk. That is, the control elements (like an trace event
> > > descriptor) is really what is on "disk". When someone does an "ls" to the
> > > pseudo file system, there needs to be a way for the VFS layer to query the
> > > control structures like how a normal file system would query that data
> > > stored on disk, and then let the VFS layer create the dentry and inodes
> > > when referenced, and more importantly, free them when they are no longer
> > > referenced and there's memory pressure.  
> > 
> > Yeap, that's exactly what kernfs does.
> 
> And eventfs goes one step further. Because there's a full directory layout
> that's identical for every event, it has a single descriptor for directory
> and not for file. As there can be over 10 files per directory/event I
> didn't want to waste even that memory. This is why I couldn't use kernfs
> for eventfs, as I was able to still save a couple of megabytes by not
> having the files have any descriptor representing them (besides a single
> array for all events).

Ok, that's fine, but the original point of "are you sure you want to use
kernfs for anything other than what we have today" remains.  It's only a
limited set of use cases that kernfs is good for, libfs is still the
best place to start out for a virtual filesystem.  The fact that the
majority of our "fake" filesystems are using libfs and not kernfs is
semi-proof of that?

Or is it proof that kernfs is just too undocumented that no one wants to
move to it?  I don't know, but adding samples like this really isn't the
answer to that, the answer would be moving an existing libfs
implementation to use kernfs and then that patch series would be the
example to follow for others.

thanks,

greg k-h

