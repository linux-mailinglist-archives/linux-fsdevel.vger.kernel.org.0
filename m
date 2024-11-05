Return-Path: <linux-fsdevel+bounces-33675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85B9BD0CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27351F23465
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D613BC0C;
	Tue,  5 Nov 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj9SDxMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E871F95A;
	Tue,  5 Nov 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821245; cv=none; b=UBTN8UJiiog8hz4zIUm3zcfICBTXDfPWp9m8S7zmfIaNdlGMC8TS4DkzbCV/A8UVW4zr76HtFDcd0oHSFYYDv+pgCggP/RPzXXEIN7YvGctNC3roZyyafAuNY7ImZqKdGTSGVNOPZE64phg4+pqRgkpTCZyp5KQ24h0UNkfaV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821245; c=relaxed/simple;
	bh=7OjgiT/5KWhncWMPQtywWtXOowrxvsv0GUnpAW8McSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz1m+Ho6YUSD49iHWG0yGRmV/G371/JNWgqbSbffVjcoyTsmERgUWdzWQrTXSHZtYYDsV1lyHS+ka3eN17R4r2dTE2e0gmlqOaorGXmVCmE96wwchB0tdFdurS47qilIiidv5YlrFlfzwndblKXAAaQuBi9KkIryIcu5eqCrYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj9SDxMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DA4C4CECF;
	Tue,  5 Nov 2024 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730821244;
	bh=7OjgiT/5KWhncWMPQtywWtXOowrxvsv0GUnpAW8McSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj9SDxMnK4fc6zGZT9isKG9j2IsblpkNDrCw38KDbP9872nfekYt4Kws5j6coR2KG
	 ysrCJM+ofqsuFT7rA9inPLdrEul1/oAfQqcPpFoKe/RWsQf8vqZ4tiPTHTX3vk27hE
	 UsWe36ZAgLma+9BkBTYKSS1zApvqDsQhIIUCz7RAo5wLniXkRhoTlqsEg8WxCvPBQe
	 +C/ZjxdGtTh6dGKStu25ZxY9pYEGp+rosATiBwKqsWAGTog5nGdTvgpIaDLwEFNnJh
	 ucymuYH18YU+tutd+q+cG0Yo9rEHgIPMlqvJo86kHs6h9ef358MSynueqJVG53ySTB
	 4JVTuYl8jvbew==
Date: Tue, 5 Nov 2024 07:40:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <20241105154044.GD2578692@frogsfrogsfrogs>
References: <20241105004341.GO21836@frogsfrogsfrogs>
 <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
 <72515c41-4313-4287-97cc-040ec143b3c5@kernel.dk>
 <20241105150812.GA227621@mit.edu>
 <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5557bb8e-0ab8-4346-907e-a6cfea1dabf8@kernel.dk>

On Tue, Nov 05, 2024 at 08:11:52AM -0700, Jens Axboe wrote:
> On 11/5/24 8:08 AM, Theodore Ts'o wrote:
> > On Tue, Nov 05, 2024 at 05:52:05AM -0700, Jens Axboe wrote:
> >>
> >> Why is this so difficult to grasp? It's a pretty common method for
> >> cross subsystem work - it avoids introducing conflicts when later
> >> work goes into each subsystem, and freedom of either side to send a
> >> PR before the other.
> >>
> >> So please don't start committing the patches again, it'll just cause
> >> duplicate (and empty) commits in Linus's tree.
> > 
> > Jens, what's going on is that in order to test untorn (aka "atomic"
> > although that's a bit of a misnomer) writes, changes are needed in the
> > block, vfs, and ext4 or xfs git trees.  So we are aware that you had
> > taken the block-related patches into the block tree.  What Darrick has
> > done is to apply the the vfs patches on top of the block commits, and
> > then applied the ext4 and xfs patches on top of that.
> 
> And what I'm saying is that is _wrong_. Darrick should be pulling the
> branch that you cut from my email:
> 
> for-6.13/block-atomic
> 
> rather than re-applying patches. At least if the intent is to send that
> branch to Linus. But even if it's just for testing, pretty silly to have
> branches with duplicate commits out there when the originally applied
> patches can just be pulled in.

I *did* start my branch at the end of your block-atomic branch.

Notice how the commits I added yesterday have a parent commitid of
1eadb157947163ca72ba8963b915fdc099ce6cca, which is the head of your
for-6.13/block-atomic branch?

But, it's my fault for not explicitly stating that I did that.  One of
the lessons I apparently keep needing to learn is that senior developers
here don't actually pull and examine the branches I link to in my emails
before hitting Reply All to scold.  You obviously didn't.

Maybe the lesson I really need to learn here is that none of this
constant pointless aggravation in my life is worth it.

--D

> > I'm willing to allow the ext4 patches to flow to Linus's tree without
> > it personally going through the ext4 tree.  If all Maintainers
> > required that patches which touched their trees had to go through
> > their respective trees, it would require multiple (strictly ordered)
> > pull requests during the merge window, or multiple merge windows, to
> 
> That is simply not true. There's ZERO ordering required here. Like I
> also mentioned in my reply, and that you also snipped out, is that no
> ordering is implied here - either tree can send their PR at any time.
> 
> > land these series.  Since you insisted on the block changes had to go
> > through the block tree, we're trying to accomodate you; and also (a)
> > we don't want to have duplicate commits in Linus's tree; and at the
> > same time, (b) but these patches have been waiting to land for almost
> > two years, and we're also trying to make things land a bit more
> > expeditiously.
> 
> Just pull the branch that was created for it... There's zero other
> things in there outside of the 3 commits.
> 
> -- 
> Jens Axboe

