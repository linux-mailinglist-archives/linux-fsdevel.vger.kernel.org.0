Return-Path: <linux-fsdevel+bounces-33737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB99BE474
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE1D1C21710
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7871DE3B9;
	Wed,  6 Nov 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEogLUqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325D1D1753;
	Wed,  6 Nov 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889606; cv=none; b=R9sBY5/iMG6MW+NJJdJshqLXgm4lnjwGYXHcUqB7jrTE/DpZwWF+Py0ggAYto4696X1lycl/qVuvwSKmeKO4Bk0p+yu7Kb1mYVEeZNq3QPivLY/XANEYK61DmiXuTsWH1DO6uta6CU80/pbsAUVtwDCpP6YjADM+PGlYfiWTWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889606; c=relaxed/simple;
	bh=II1Cw9WyiI/NLZcAELD6NgMA0DFZpwlqXmvxCdhqAD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofBJcQBYfjPQIS2TsnAw8u2G2bxNIVzhQFhXJ/nQscB22Zl5NR0ooX9DF4utwknClf8y2l0Jtsw2HJfAubxwyaWjGCqWcYfKUlwxvq1nBc+xrGKJqZ9ddprCQgFNT6kJjqt8UmqDOuq6+ElInGwOXoWqCR/W6/LJuwsRG6V3ocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEogLUqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B67C4CECD;
	Wed,  6 Nov 2024 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730889606;
	bh=II1Cw9WyiI/NLZcAELD6NgMA0DFZpwlqXmvxCdhqAD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEogLUqiMmuObMNMeSY8FcHdvgDogMK+QyjinwG/XNCnQ8SNYK4LRpLkaXxrfVwRm
	 JM+RDFqx7L4ZhBnQ6Bj3w7vL6rRqVGzGGeulgi36v+cLzgO9AEUbPIP7+v7LVH6YZ7
	 mGEAJ9fWWObcIAhHO7KCMtJfqSiBobCeUJz1lZzcwN9B4OEA55NK1I8GINTYrwaoz5
	 6uOOzMREbwAt4umCxFlpEU4r3TQN0ZcuenROmPKcZBPUzdOHpFxzMegP4Ns2Szgfav
	 WdQzvVjVMBItJlcgwYC6JB5MhK3TowyO93eJGL90932WnvqFXVbY5uhzDx2v/23Xb+
	 ZFZ2E9786oFIg==
Date: Wed, 6 Nov 2024 11:40:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Carlos Maiolino <cem@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, Catherine Hoang <catherine.hoang@oracle.com>, 
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <20241106-hupen-phosphor-f4e126535131@brauner>
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
 <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
 <20241105150812.GA227621@mit.edu>
 <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>
 <20241105154044.GD2578692@frogsfrogsfrogs>
 <00618fda-985d-4d6b-ada1-2d93a5380492@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00618fda-985d-4d6b-ada1-2d93a5380492@kernel.dk>

On Tue, Nov 05, 2024 at 08:54:40AM -0700, Jens Axboe wrote:
> On 11/5/24 8:40 AM, Darrick J. Wong wrote:
> > On Tue, Nov 05, 2024 at 08:11:52AM -0700, Jens Axboe wrote:
> >> On 11/5/24 8:08 AM, Theodore Ts'o wrote:
> >>> On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
> >>>>
> >>>> Why is this so difficult to grasp? It's a pretty common method for
> >>>> cross subsystem work - it avoids introducing conflicts when later
> >>>> work goes into each subsystem, and freedom of either side to send a
> >>>> PR before the other.
> >>>>
> >>>> So please don't start committing the patches again, it'll just cause
> >>>> duplicate (and empty) commits in Linus's tree.
> >>>
> >>> Jens, what's going on is that in order to test untorn (aka "atomic"
> >>> although that's a bit of a misnomer) writes, changes are needed in the
> >>> block, vfs, and ext4 or xfs git trees.  So we are aware that you had
> >>> taken the block-related patches into the block tree.  What Darrick has
> >>> done is to apply the the vfs patches on top of the block commits, and
> >>> then applied the ext4 and xfs patches on top of that.
> >>
> >> And what I'm saying is that is _wrong_. Darrick should be pulling the
> >> branch that you cut from my email:
> >>
> >> for-6.13/block-atomic
> >>
> >> rather than re-applying patches. At least if the intent is to send that
> >> branch to Linus. But even if it's just for testing, pretty silly to have
> >> branches with duplicate commits out there when the originally applied
> >> patches can just be pulled in.
> > 
> > I *did* start my branch at the end of your block-atomic branch.
> > 
> > Notice how the commits I added yesterday have a parent commitid of
> > 1eadb157947163ca72ba8963b915fdc099ce6cca, which is the head of your
> > for-6.13/block-atomic branch?
> 
> Ah that's my bad, I didn't see a merge commit, so assumed it was just
> applied on top. Checking now, yeah it does look like it's done right!
> Would've been nicer on top of current -rc and with a proper merge
> commit, but that's really more of a style preference. Though -rc1 is
> pretty early...
> 
> > But, it's my fault for not explicitly stating that I did that.  One of
> > the lessons I apparently keep needing to learn is that senior developers
> > here don't actually pull and examine the branches I link to in my emails
> > before hitting Reply All to scold.  You obviously didn't.
> 
> I did click the link, in my defense it was on the phone this morning.
> And this wasn't meant as a scolding, nor do I think my wording really
> implies any scolding. My frustration was that I had explained this
> previously, and this seemed like another time to do the exact same. So
> my apologies if it came off like that, was not the intent.

Fwiw, I pulled the branch that Darrick provided into vfs.untorn.writes
and it all looks sane to me.

