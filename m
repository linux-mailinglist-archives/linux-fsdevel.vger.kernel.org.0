Return-Path: <linux-fsdevel+bounces-12282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E685E3CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F19283387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BF839F6;
	Wed, 21 Feb 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Bb5jCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E880613;
	Wed, 21 Feb 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534577; cv=none; b=A7fhrLpDgE72D+7Yjm+FdmQH0jEJVDvddxzqeNc3I6+TNqYbZpcWjCZtNEs0+P3MmScB35gHVVsXMYpDozqC3EbMugMYy5N4kWHuLgD5Bz/QfckNvK/zAWeNrnLCuVDp5fqT1GL5Iq7gHVEGVOuFDFg2PRO7An4oswrCksQUBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534577; c=relaxed/simple;
	bh=JvU0tQfghs9ivP7wwVrY8yM2tvT8Ba8a984fQlx+zQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcI74BSxkG0JVhQlmFNPR5fRlDBu76gv/OvbSlXgxX0n3eW9U97oSjdRqAQtUx7NymbDZ3cfwZdh6OcuxARxFL+ePmLpgTsZa3DgQop0ZV89uY3xPjs/5S/5QZIwRo23c0s0fbPxxww6CpKp0MFRb8Ns4jk5QUcmwj/MIwcC2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Bb5jCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B36DC433C7;
	Wed, 21 Feb 2024 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708534576;
	bh=JvU0tQfghs9ivP7wwVrY8yM2tvT8Ba8a984fQlx+zQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4Bb5jCPAd5fYX0Ux3wZTHtsK2kKfPBlut+e/Wp4xxv0kaaK+cCnVb7B/qLuWUNl0
	 2QfxdpL1/Ly4+rvEiITOSeHCqFjGFfo8pMrDfoMV5q668EMKxh7ngwyuwVvVUq2aZU
	 /m8+R9RBffGExL2ZOUed+Du/qUyExN9aFhHwYxBs+qOCyYDwFz94QI/lfi6RK7EQTq
	 QLv9gnThvx3eIOvV0HKLO9e8G25xK6IsPHmJn+lJs8lJrubqwdVdX8kVY6Yeog6rJ8
	 fAFMbdmxkKM2hFw8+YKnQsy8tu8qQbegZvgIwAYDoE8dJD+89nGN/enhTUwASyUBQ7
	 afIzc5RzN9Fwg==
Date: Wed, 21 Feb 2024 08:56:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <20240221165615.GH6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240213072237.GA24218@lst.de>
 <20240213175549.GU616564@frogsfrogsfrogs>
 <20240214074559.GB10006@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214074559.GB10006@lst.de>

On Wed, Feb 14, 2024 at 08:45:59AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 13, 2024 at 09:55:49AM -0800, Darrick J. Wong wrote:
> > On Tue, Feb 13, 2024 at 08:22:37AM +0100, Christoph Hellwig wrote:
> > > From reading the series and the discussions with Darrick and Dave
> > > I'm coming more and more back to my initial position that tying this
> > > user visible feature to hardware limits is wrong and will just keep
> > > on creating ever more painpoints in the future.
> > > 
> > > Based on that I suspect that doing proper software only atomic writes
> > > using the swapext log item and selective always COW mode
> > 
> > Er, what are you thinking w.r.t. swapext and sometimescow?
> 
> What do you mean with sometimescow?  Just normal reflinked inodes?
> 
> > swapext
> > doesn't currently handle COW forks at all, and it can only exchange
> > between two of the same type of fork (e.g. both data forks or both attr
> > forks, no mixing).
> > 
> > Or will that be your next suggestion whenever I get back to fiddling
> > with the online fsck patches? ;)
> 
> Let's take a step back.  If we want atomic write semantics without
> hardware offload, what we need is to allocate new blocks and atomically
> swap them into the data fork.  Basicall an atomic version of
> xfs_reflink_end_cow.  But yes, the details of the current swapext
> item might not be an exact fit, maybe it's just shared infrastructure
> and concepts.

Hmm.  For rt reflink (whenever I get back to that, ha) I've been
starting to think that yes, we actually /do/ want to have a log item
that tracks the progress of remap and cow operations.  That would solve
the problem of someone wanting to reflink a semi-written rtx.

That said, it might complicate the reflink code quite a bit since right
now it writes zeroes to the unwritten parts of an rt file's rtx so that
there's only one mapping record for the whole rtx, and then it remaps
them.  That's most of why I haven't bothered to implement that solution.

> I'm not planning to make you do it, because such a log item would
> generally be pretty useful for always COW mode.

One other thing -- while I was refactoring the swapext code into
exch{range,maps}, it occurred to me that doing an exchange between the
cow and data forks isn't possible because log recovery won't be able to
do anything.  There's no ondisk metadata to map a cow staging extent
back to the file it came from, which means we can't generally resume an
exchange operation.

However for a small write I guess you could simply queue all the log
intent items for all the changes needed and commit that.

> > > and making that
> > > work should be the first step.  We can then avoid that overhead for
> > > properly aligned writs if the hardware supports it.  For your Oracle
> > > DB loads you'll set the alignment hints and maybe even check with
> > > fiemap that everything is fine and will get the offload, but we also
> > > provide a nice and useful API for less performance critical applications
> > > that don't have to care about all these details.
> > 
> > I suspect they might want to fail-fast (back to standard WAL mode or
> > whatever) if the hardware support isn't available.
> 
> Maybe for your particular DB use case.  But there's plenty of
> applications that just want atomic writes without building their
> own infrastruture, including some that want pretty large chunks.
> 
> Also if a file system supports logging data (which I have an
> XFS early prototype for that I plan to finish), we can even do
> the small double writes more efficiently than the application,
> all through the same interface.

Heh.  Ted's been trying to kill data=journal.  Now we've found a use for
it after all. :)

--D

