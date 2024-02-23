Return-Path: <linux-fsdevel+bounces-12540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E97860B04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D097B24916
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCA12E6C;
	Fri, 23 Feb 2024 06:57:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC809BA2B;
	Fri, 23 Feb 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671436; cv=none; b=F9WCW4kZOVuvEYyNrKKmRTUvWtHLYaJfzWoMXXvX1cgZLa1Hy/FtZ3FOyB6dOH0U1KkXi0+kt43x6/Xm/SFvndlp/9KT/dbiBnL9qzhybdLwFS4Q2bZpoAoq+qcOIUR3+7BoG5pW3QLY4cFKjyHR4FoBNmpyWPpK+j/D6I+jgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671436; c=relaxed/simple;
	bh=hm6XHNj+0gbJT9j6deg6BuO41RjhBehAsR7NQVvqiAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBkUlrXEUvmGbq4HsBUptSpWDTNLpTghDakVQ5ZdemkxjCbt/YMY41xw6e0wGCHQSdyllUvW/4DP8tcTkWf0kfnfU+cxGn8nU6roNNsMl5oqlmKKomaRbzpszqcXKsSdNnByl7eLHCFS0MDrGCL/NBlS5fI4n2v/itM+4Qe8gqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8131A68C7B; Fri, 23 Feb 2024 07:57:10 +0100 (CET)
Date: Fri, 23 Feb 2024 07:57:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Message-ID: <20240223065710.GB11126@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com> <20240213072237.GA24218@lst.de> <20240213175549.GU616564@frogsfrogsfrogs> <20240214074559.GB10006@lst.de> <20240221165615.GH6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221165615.GH6184@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 21, 2024 at 08:56:15AM -0800, Darrick J. Wong wrote:
> Hmm.  For rt reflink (whenever I get back to that, ha) I've been
> starting to think that yes, we actually /do/ want to have a log item
> that tracks the progress of remap and cow operations.  That would solve
> the problem of someone wanting to reflink a semi-written rtx.
> 
> That said, it might complicate the reflink code quite a bit since right
> now it writes zeroes to the unwritten parts of an rt file's rtx so that
> there's only one mapping record for the whole rtx, and then it remaps
> them.  That's most of why I haven't bothered to implement that solution.

I'm still not sure that supporting reflinks for rtextsize > 1 is a good
idea..

> > I'm not planning to make you do it, because such a log item would
> > generally be pretty useful for always COW mode.
> 
> One other thing -- while I was refactoring the swapext code into
> exch{range,maps}, it occurred to me that doing an exchange between the
> cow and data forks isn't possible because log recovery won't be able to
> do anything.  There's no ondisk metadata to map a cow staging extent
> back to the file it came from, which means we can't generally resume an
> exchange operation.

Yeah.

> > Also if a file system supports logging data (which I have an
> > XFS early prototype for that I plan to finish), we can even do
> > the small double writes more efficiently than the application,
> > all through the same interface.
> 
> Heh.  Ted's been trying to kill data=journal.  Now we've found a use for
> it after all. :)

Well..  unconditional logging of data just seems like a really bad idea.
Using it as an optimization for very small and/or synchronous writes
is a pretty common technique.  


