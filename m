Return-Path: <linux-fsdevel+bounces-51600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA9AD93E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C271E2AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4ED226D1E;
	Fri, 13 Jun 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrfUAKZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763215573F;
	Fri, 13 Jun 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836654; cv=none; b=LBYwsIXFpy5aCuy52xl3DXroKNd1b+/BzwpdsEZt+i7XUkObnEGyiPsVJAqHpV2zL4V5NX4hOxVpUTx3UNCYt1vCNJBfRSzjC+5B/jCPbopC1aFZ+0BC1jPnPtukXeQ7MzEASIUIZ9v+pTLrGbRwioP+y3ssCFcax9gJ5hESdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836654; c=relaxed/simple;
	bh=/cTBfbaR8bH+EoNRjEFWGhAIkzbykHXhL7UVSQ2mmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmCRSNzleL3zRc5OK7uW/w9/JKCWdMpZ3fxEKK0faHHV01eJfTfy8HYcduT+cSjW/oLzgU00g7GcWlDw4PFOvjtht8qXZsbLcTfZISwgr0OsGozAlUq+qHTjTYHrLrdBK9LCJKFbICW+wxOPMphpi9JkHsXuD8VkitdEoWbQdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrfUAKZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1745DC4CEE3;
	Fri, 13 Jun 2025 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749836654;
	bh=/cTBfbaR8bH+EoNRjEFWGhAIkzbykHXhL7UVSQ2mmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrfUAKZySJfLmw7mNRruI/ho23uolNdOOnn4h/3jeo4I0qybncA6G5mWGJLclAvxl
	 9d2f5/57ElO4MawnDTbPRi14a3R3zFzFlK+/bWyyagb6edgE2u6AQpcWuGAhdl6sSS
	 j0d1/qIzXXVMfRd0+Dq4f6FzNQwR0/v0VqqhYHr085j/ReRZ1LbcZT8qqfjENkKcsa
	 LViiBlgyWpzirNcAlHgsubeEzGk5fizBczau9lDgnFGLesAKajW804IuXHGnL6m1ww
	 BdewWC44r5xxKQVkAXSespn2DyzGMUfjEhjEH02cX9+vrnibFYOJV2mfCHlRImhzHw
	 hjEZsF13PNXvg==
Date: Fri, 13 Jun 2025 10:44:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250613174413.GM6138@frogsfrogsfrogs>
References: <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
 <CAOQ4uxj4G_7E-Yba0hP2kpdeX17Fma0H-dB6Z8=BkbOWsF9NUg@mail.gmail.com>
 <20250611060040.GC6138@frogsfrogsfrogs>
 <CAOQ4uxg-HT9ZA4UdQsD40z4THp9wBJw=MPHBSnWUCbOA+Mc0hA@mail.gmail.com>
 <CAJfpegs_An=3Ghgz5fyo=A_e--gbG5sS1-cDoOJwhfWBx0DBLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs_An=3Ghgz5fyo=A_e--gbG5sS1-cDoOJwhfWBx0DBLg@mail.gmail.com>

On Thu, Jun 12, 2025 at 07:54:12AM +0200, Miklos Szeredi wrote:
> On Wed, 11 Jun 2025 at 10:54, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > There is already a mount option 'rootmode' for st_mode of root inode
> > so I suppose we could add the rootino mount option.
> >
> > Note that currently fuse_fill_super_common() instantiates the root inode
> > before negotiating FUSE_INIT with the server.
> 
> I'd prefer not to add more mount options like this.
> 
> It would be nice to move away from async FUSE_INIT.  It's one of those
> things I wish I'd done differently.
> 
> Unfortunately I don't think adding FUSE_INIT_SYNC would be sufficient,
> as servers might expect the first request to be always FUSE_INIT and
> break if it isn't.   Libfuse seems to be okay, but...
> 
> One idea is to add an ioctl that the server would call before
> mounting, that explicitly allows FUSE_INIT_SYNC.  It's somewhat ugly,
> but I can't think of a better solution.

Hmm, well for iomap the fuse server kinda wants to know if the kernel is
going to accept iomap prior to initializing the filesystem, so it
wouldn't be that weird to have it set a "send INIT_SYNC" flag.

If one were to add an INIT_SYNC upcall, where would the callsite be?
Somewhere just prior to where we need to open the root file?  And would
you want to add more fields to it?  Or just use the same struct and
flags as the existing INIT call?

--D

> 
> Thanks,
> Miklos
> 

