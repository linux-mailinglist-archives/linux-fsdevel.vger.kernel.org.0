Return-Path: <linux-fsdevel+bounces-1267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB67D89A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381521C20F19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4503CD02;
	Thu, 26 Oct 2023 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8kYNmZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55842381DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31BEC433C8;
	Thu, 26 Oct 2023 20:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698351641;
	bh=zOdtDCBSmQ6ZQaOBoH3IJv9cabODLDqmm/UfYkqbgc0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c8kYNmZmN6zlXBPZRWaAAHIuZXxu735QcBB/KS6l3uPQBFke4BBIvEdmSZrroPdBK
	 wjV601x84/YvZXnCGShdUEPyEfIHt+dgliReMFd9BcwBYikfTFERrNe9Th1Y4yIyZm
	 xH5Z42UKjY+P9sSFgNzqOJ6KtSKcH9vBRmTW3IMlemzeM3U4zJcKk4Dvvo2d3UQGrZ
	 XOGrxla+aMbv6AJakIZSqTJgUw6+GkSlMirp7u//hEdsB0PuK1GP84HxFFXNCoU+7S
	 b/71PnGn8a/oWhzDGqO/NvmzJhN4H+YpMv8efJoAvzTm/DTNUu+axND4L/lv1Nivr5
	 h70KQL827V88g==
Message-ID: <f8145c661e18cd6a74095cc8ee952855cbfe65b9.camel@kernel.org>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Darrick J. Wong"
	 <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, 
 jstancek@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Date: Thu, 26 Oct 2023 16:20:39 -0400
In-Reply-To: <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
References: 
	<169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
	 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
	 <20231023223810.GW3195650@frogsfrogsfrogs>
	 <20231024-flora-gerodet-8ec178f87fe9@brauner>
	 <20231026031325.GH3195650@frogsfrogsfrogs>
	 <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 08:10 -1000, Linus Torvalds wrote:
> On Wed, 25 Oct 2023 at 17:13, Darrick J. Wong <djwong@kernel.org> wrote:
> >=20
> > Similar to what we just did with XFS, I propose breaking up the iomap
> > Maintainer role into pieces that are more manageable by a single person=
.
> > As RM, all you'd have to do is integrate reviewed patches and pull
> > requests into one of your work branches.  That gives you final say over
> > what goes in and how it goes in, instead of letting branches collide in
> > for-next without warning.
>=20
> I _think_ what you are saying is that you'd like to avoid being both a
> maintainer and a developer.
>=20
> Now, I'm probably hugely biased and going by personal experience, but
> I do think that doing double duty is the worst of both worlds, and
> pointlessly stressful.
>=20
> As a maintainer, you have to worry about the big picture (things like
> release timing, even if it's just a "is this a fix for this release,
> or should it get queued for the next one") but also code-related
> things like "we have two different things going on, let's sort them
> out separately". Christian had that kind of issue just a couple of
> days ago with the btrfs tree.
>=20
> But then, as a developer, those are distractions and just add stress
> and worry, and distract from whatever you're working on. As a
> developer, the last thing you want to worry about is something else
> than the actual technical issue you're trying to solve.
>=20
> And obviously, there's a lot of overlap. A maintainer needs to be
> _able_ to be a developer just to make good choices. And the whole
> "maintainer vs developer" doesn't have to be two different people,
> somebody might shift from one to the other simply because maybe they
> enjoy both roles. Just not at the same time, all the time, having both
> things putting different stress on you.
>=20
> You can *kind* of see the difference in our git tree if you do
>=20
>     git rev-list --count --author=3DXYZ --no-merges --since=3D1.year HEAD
>=20
> to see "code authorship" (aka developer), vs
>=20
>     git rev-list --count --committer=3DXYZ --since=3D1.year HEAD
>=20
> which shows some kind of approximation of "maintainership". Obviously
> there is overlap (potentially a lot of it) and the above isn't some
> absolute thing, but you can see some patterns.
>=20
> I personally wish we had more people who are maintainers _without_
> having to worry too much about developing new code.  One of the issues
> that keeps coming up is that companies don't always seem to appreciate
> maintainership (which is a bit strange - the same companies may then
> _love_ appreciateing managers, which is something very different but
> has some of the same flavour to it).
>=20
> And btw, I don't want to make that "I wish we had more maintainers" be
> a value judgement. It's not that maintainers are somehow more
> important than developers. I just think they are two fairly different
> roles, and I think one person doing both puts unnecessary stress on
> that person.
>=20

Personally, I wouldn't want to give up doing development work
altogether.=A0I don't mind doing some maintainership duties, and helping
out other maintainers where I can, but maintainership takes a lot more
time than most people realize. You're sort of obligated to review
everything that comes across your plate.

I know Trond and Anna have been successful alternating the handling of
pull requests and linux-next. I think it makes a lot of sense to have
maintainership teams, at least for larger subsystems. We sort of have
them informally now, but maybe we should be aiming to have a group of
people who are all nominally maintainers on larger subsystems. They can
then rotate between themselves on some schedule (every year? or every 5
releases? Whatever works...).

That provides some extra incentive for other team members to help out
with reviews, and it may make it simpler for someone else to step in
when the current maintainer needs to step away.

It does rely on a high degree of trust between team members, but most of
us seem to get along.
--=20
Jeff Layton <jlayton@kernel.org>

