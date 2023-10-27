Return-Path: <linux-fsdevel+bounces-1450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912777DA0D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3F1C20F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910523B790;
	Fri, 27 Oct 2023 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XESBeEDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96BC38FAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3952AC433C7;
	Fri, 27 Oct 2023 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698432371;
	bh=cTVhvKwFv7f70NItbRYb8qf7N9BSevmPLGCbpfnoi5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XESBeEDOyBvXP89LvNCJztLsCMP4GqyewspPvIEW9YDiSCyeTcX8whnhYiXX3N0+4
	 6ImRtZrFTKFqYZOTIIncTR/PLhdNmUqF5jNuvMp8+xAb/7Kc42fpL4sv0UBE9F1fAa
	 Ufd3SO2RvLbpJmFjNuZSimPXUH5wb5mLgMtADsU8gtAqc00zqWdxTrR/oAy9S+5J2Y
	 Gefh5JscaA+g39geoO6/0Fqiy3nznTFFjbE65k69G63PG8ayBiOytxdhScXOIRq4Ew
	 oW4WPMtSprZrhrSUYio+kHXcFGD4PZPl+0Q7ZVthAsDL0HTU4KEwOShEgUfeixrp6r
	 3SziP216wvLKQ==
Date: Fri, 27 Oct 2023 20:46:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <20231027-gestiegen-saftig-2e636d251efa@brauner>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs>
 <20231024-flora-gerodet-8ec178f87fe9@brauner>
 <20231026031325.GH3195650@frogsfrogsfrogs>
 <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>

On Thu, Oct 26, 2023 at 08:10:01AM -1000, Linus Torvalds wrote:
> On Wed, 25 Oct 2023 at 17:13, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Similar to what we just did with XFS, I propose breaking up the iomap
> > Maintainer role into pieces that are more manageable by a single person.
> > As RM, all you'd have to do is integrate reviewed patches and pull
> > requests into one of your work branches.  That gives you final say over
> > what goes in and how it goes in, instead of letting branches collide in
> > for-next without warning.
> 
> I _think_ what you are saying is that you'd like to avoid being both a
> maintainer and a developer.
> 
> Now, I'm probably hugely biased and going by personal experience, but
> I do think that doing double duty is the worst of both worlds, and
> pointlessly stressful.
> 
> As a maintainer, you have to worry about the big picture (things like
> release timing, even if it's just a "is this a fix for this release,
> or should it get queued for the next one") but also code-related
> things like "we have two different things going on, let's sort them
> out separately". Christian had that kind of issue just a couple of
> days ago with the btrfs tree.
> 
> But then, as a developer, those are distractions and just add stress
> and worry, and distract from whatever you're working on. As a
> developer, the last thing you want to worry about is something else
> than the actual technical issue you're trying to solve.
> 
> And obviously, there's a lot of overlap. A maintainer needs to be
> _able_ to be a developer just to make good choices. And the whole
> "maintainer vs developer" doesn't have to be two different people,
> somebody might shift from one to the other simply because maybe they
> enjoy both roles. Just not at the same time, all the time, having both
> things putting different stress on you.
> 
> You can *kind* of see the difference in our git tree if you do
> 
>     git rev-list --count --author=XYZ --no-merges --since=1.year HEAD
> 
> to see "code authorship" (aka developer), vs
> 
>     git rev-list --count --committer=XYZ --since=1.year HEAD
> 
> which shows some kind of approximation of "maintainership". Obviously
> there is overlap (potentially a lot of it) and the above isn't some
> absolute thing, but you can see some patterns.
> 
> I personally wish we had more people who are maintainers _without_
> having to worry too much about developing new code.  One of the issues
> that keeps coming up is that companies don't always seem to appreciate
> maintainership (which is a bit strange - the same companies may then
> _love_ appreciateing managers, which is something very different but
> has some of the same flavour to it).
> 
> And btw, I don't want to make that "I wish we had more maintainers" be
> a value judgement. It's not that maintainers are somehow more
> important than developers. I just think they are two fairly different
> roles, and I think one person doing both puts unnecessary stress on
> that person.

I think most of us enjoy both. Personally, I always try to carve out
time where I can work on stuff that I find interesting. It helps to stay
sane and it helps with providing good reviews. It also helps being
reminded how easy it is to code up bugs.

When there's an interesting series that morphes into larger subsystem
massaging that's always great because that's a chance to collaborate and
different people can take on different parts. And it usually means one
does get a few patches in as well.

In a smaller subsystem it's probably ok to be main developer, reviewer,
and developer at the same time. But in a busy subsystem that trias isn't
sustainable. Let alone scaling that to multiple subsystems. 

One of the critical parts is review. Good reviews are often insanely
expensive and they are very much a factor in burning people out. If one
only ever reviews and the load never ends that's going to fsck with you
in the long run.

A reviewer must be technically great, have design, context,
maintainability, and wider context and future of the subsystem in mind,
and not be afraid to have code changed or removed that they wrote (That
last part really matters.), and also be ok with being publicly wrong in
front of a whole bunch of smart people (Which I want to stress is
absolutely fine and almost unavoidable.).

But once you have a couple of good reviewers in a subsystem that you can
really rely on that if they give an ack/rvb it's solid enough (not
necessarily bug free even) that's really good. It not just takes away
pressure it also means that it's possible for other
reviewers/maintainers to go develop stuff themselves.

