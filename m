Return-Path: <linux-fsdevel+bounces-1484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FEE7DA826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5EB6B20C39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD701171BC;
	Sat, 28 Oct 2023 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4NDCBpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083A390
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 16:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4325EC433C7;
	Sat, 28 Oct 2023 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698512204;
	bh=BDwsYISfrL7tcyHbaI4k0MK+bB0Ei/xK8mDp2+qxeVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4NDCBpdnGLPECAQa3hBijmWMQAh0Denrs5mjee9OHnPw/ffp1pCJEYlEQpETsrp1
	 kNuQl0Aske9dsIy336F6FhbAFvEazx4vzlXA352TZyV+d7yeBfbTyFYRoDAc+skyET
	 zx9IUQdr1UbzZ4cUXxs3/OqRmxl2YJZieqjKUb0T8a5JimxTfYCatpW0M3KJjIe1oV
	 w8Cz2KYaT+1/I/u/XOXEenTvuP7E1RXEfWaWqyfPUtzwWuvrF0Ze5BhMNzQVCeiUjV
	 Cdxwi+ATTzFNVpPg1Ra9FGYp7yUJzrGB7uMldMilRh1vZD54dOHjtQkJJtzn3J/86U
	 zwfAyre/JStag==
Date: Sat, 28 Oct 2023 18:56:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <20231028-zollfrei-abbrechen-50065dfed265@brauner>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs>
 <20231024-flora-gerodet-8ec178f87fe9@brauner>
 <20231026031325.GH3195650@frogsfrogsfrogs>
 <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
 <20231027-gestiegen-saftig-2e636d251efa@brauner>
 <CAHk-=wivwYfw0DHn3HowHJPg0rkt2fVSdLwjbsX6dTPNoMWXNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wivwYfw0DHn3HowHJPg0rkt2fVSdLwjbsX6dTPNoMWXNA@mail.gmail.com>

On Fri, Oct 27, 2023 at 01:30:00PM -1000, Linus Torvalds wrote:
> On Fri, 27 Oct 2023 at 08:46, Christian Brauner <brauner@kernel.org> wrote:
> >
> > One of the critical parts is review. Good reviews are often insanely
> > expensive and they are very much a factor in burning people out. If one
> > only ever reviews and the load never ends that's going to fsck with you
> > in the long run.
> 
> I absolutely despise the review requirement that several companies
> have. I very much understand why it happens, but I think it's actively
> detrimental to the workflow.
> 
> It's not just that reviewing is hard, the review requirement tends to
> be a serialization point where now you as a developer are waiting for
> others to review it, and those others are not nearly as motivated to
> do so or are easily going to be nitpicking about the non-critical
> things.
> 
> So it's not just the reviewers that get burned out, I think the
> process ends up being horrific for developers too, and easily leads to
> the "let's send out version 17 of this patch based on previous
> review". At which point everybody is completely fed up with the whole
> process.
> 
> And if it doesn't get to version 17, it's because the reviewers too
> have gotten so fed up that by version three they go "whatever, I've
> seen this before, they fixed the obvious thing I noticed, I'll mark it
> reviewed".

You're talking about companies having review requirements for their
internal project stuff, right? I haven't heard that there's any sort of
review requirement with respect to the upstream kernel from companies.

Sure, if you make it a requirement then it sucks because it's just
another chore.

I think we lack more reviewers for a multitude of reasons but to me one
of the biggest is that we don't encourage the people to do it and
there's no inherent reward to it. Sure, you get that RVB or ACK in the
changelog but whatever. That neither gets you a job nor does it get you
on LWN. So why bother.

So often our reviewers are the people who have some sort of sense of
ownership with respect to the subsystem. That's mostly the maintainers.

You occassionally get the author of a patch series that sticks around
and reviews stuff that they wrote. But that's not enough and then we're
back to the problem that you can't effectively be maintainer, reviewer,
and main developer.

And yes, nitpicky review isn't really helpful and the goal shouldn't be
to push a series to pointless version numbers before it can be merged.

> 
> The other dynamic with reviews is that you end up getting
> review-cliques, either due to company pressure or just a very natural
> "you review mine, I review yours" back-scratching.
> 
> Don't get me wrong - it can work, and it can even work well, but I
> think the times it works really well is when people have gotten so
> used to each others, and know each other's quirks and workflows and
> they just work well together. But that also means that some people are
> having a much easier time getting reviews, because they are part of
> that "this group works well together" crowd.

Yes, we certainly see that happening. And I really think that's overall
a good thing. It shouldn't become an in-group out-group thing obviously
so that needs to be carefully handled. But long-term trust between core
developers and maintainers is key to subsystem health imho. And such
quick review bounces are a sign of that. I don't think we actively see
useless reviews that are just "scratch my back". The people who review
often do it with sufficient fervor (for better or worse sometimes).

That said, yes, it needs to be fair. But it's just natural that you feel
more likely to throw a ACK or RVB to something someone did you know
usually does good work and you know will come back to help you put out
the fire they started.

> 
> Maybe it's a necessary evil. I certainly do *not* think the "lone

I think it's just a natural development and it's on use to make sure it
doesn't become some sort of group thing where it's five people from the
same company that push their stuff upstream.

> developer goes his own way" model works all that well. But the reason

Yeah, so I do think that this is actually the bigger problem long term.
Lone-wolf models are terrible. But I didn't grow up with lone-wolf
projects so I have no strong attachment to such models in the first
place. Maybe I judge that more harshly simply because of that.

> I said that I wish we had more maintainers, is that I think we would
> often be better off with not a "review process" back-and-forth. but a
> _pipeline_ through a few levels of maintainers.  Not the "hold things
> up and send it back to the developer" kind of thing, but "Oh, this
> looks fine, I'll just send it on - possibly with the fixes I think are
> needed".
> 
> So I think a pipeline of "Signed-off-by" (or just merges) might be
> something to strive for as at least a partial replacement for reviews.
> 
> Sure, you might get Acked-by's or Reviewed-by's or Tested-by's along
> the way *too*, or - when people are just merging directly through git
> - you'd just get a merge commit with commentary and perhaps extra
> stuff on top.

And we kinda do that in some subsystems rather consequently. Networking
does it at least and BPF does it with their subtrees and then BPF and
its subtrees bubble up into networking and then into mainline.

And that model seems to work well, yes. And it takes pressure of because
it formalizes the whole maintenance thing a lot more.

Idk if you've seen that but what we do for new stuff that gets added to
vfs is that we have maintainership entries ala BPF so e.g.,
FILESYSTEMS [EXPORTFS] - that patch is still in -next and the PR for
that won't get sent before next week and then it lists the maintainers.
But it's all part of vfs.git and they just bubble up the patches. We
could just do that via sub merges even.

> 
> Back when we started doing the whole "Signed-off-by" - for legal
> reasons, not development reasons - the big requirement for me was that
> "it needs to work as a pipeline, not as some kind of back-and-forth
> that holds up development". And I think the whole sign-off chain has
> worked really well, and we've never needed to use it for the original
> legal purposes (and hopefully just by virtue of it existing, we never
> will), but it has been a huge success from a development standpoint.
> When something goes wrong, I think it's been great to have that whole
> chain of how it got merged, and in fact one of my least favorite parts
> of git ended up being how we never made it easy to see the merge chain
> after it's been committed (you can technically get it with "git
> name-rev", but it sure is not obvious).
> 
> I dunno. Maybe I'm just dreaming. But the complaints about reviews -
> or lack of them - do tend to come up a lot, and I feel like the whole
> review process is a very big part of the problem.

Yeah, certainly.

