Return-Path: <linux-fsdevel+bounces-1274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578B7D8C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 02:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446F628225C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF761FC6;
	Fri, 27 Oct 2023 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn4HZWXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B21FA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 00:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F1C433C7;
	Fri, 27 Oct 2023 00:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698367390;
	bh=YHl6A6nYFt/HwJClw2voRRbSORwcF5afuZ372Ntv4U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn4HZWXXpyXOWmr/hIvBJH/yvCwFOvzwTkwOYhxdHaHvFfFqQWeKA/qpLNDfh8E0d
	 eqa52uU1SlMY9D0UOQjJvxiKn8DAiFR8syWqeAn77COJjSkhKX2m09gb/s+MkG7fKY
	 Zpu4I59kLOH3p//XPVnOxeKXq+s59m1PvUyQEThUMT5wBtLyz7nG8469x7fz3RstJs
	 K8klTEhS+D7RLCuXIwuk/4xQkS69jfBf3xyuV6q4j4cbENYNB6fTB1Fz61esBAV3w8
	 IFRdDeZLIpOJdPfwQpQdz0K0zqC0XFhh8nT76PvGmYQtDltCdjuQlr0GAeXV4nu9FD
	 rsYKJ7tz8Lflg==
Date: Thu, 26 Oct 2023 17:43:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <20231027004309.GK3195650@frogsfrogsfrogs>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs>
 <20231024-flora-gerodet-8ec178f87fe9@brauner>
 <20231026031325.GH3195650@frogsfrogsfrogs>
 <20231026-gehofft-vorfreude-a5079bff7373@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-gehofft-vorfreude-a5079bff7373@brauner>

On Thu, Oct 26, 2023 at 01:54:29PM +0200, Christian Brauner wrote:
> On Wed, Oct 25, 2023 at 08:13:25PM -0700, Darrick J. Wong wrote:
> > On Tue, Oct 24, 2023 at 01:47:17PM +0200, Christian Brauner wrote:
> > > On Mon, Oct 23, 2023 at 03:38:10PM -0700, Darrick J. Wong wrote:
> > > > On Sat, Oct 21, 2023 at 09:46:35AM -0700, Linus Torvalds wrote:
> > > > > On Fri, 20 Oct 2023 at 23:27, Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > Please pull this branch with changes for iomap for 6.6-rc7.
> > > > > >
> > > > > > As usual, I did a test-merge with the main upstream branch as of a few
> > > > > > minutes ago, and didn't see any conflicts.  Please let me know if you
> > > > > > encounter any problems.
> > > > > 
> > > > > .. and as usual, the branch you point to does not actually exist.
> > > > > 
> > > > > Because you *again* pointed to the wrong tree.
> > > > > 
> > > > > This time I remembered what the mistake was last time, and picked out
> > > > > the right tree by hand, but *please* just fix your completely broken
> > > > > scripts or workflow.
> > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5
> > > > > 
> > > > > No.
> > > > > 
> > > > > It's pub/scm/fs/xfs/xfs-linux, once again.
> > > > 
> > > > Sorry about that.  After reviewing the output of git request-pull, I
> > > > have learned that if you provide a $url argument that does not point to
> > > > a repo containing $start, it will print a warning to stderr and emit a
> > > > garbage pull request to stdout anyway.  No --force required or anything.
> > > > Piping stdout to mutt without checking the return code is therefore a
> > > > bad idea.
> > > > 
> > > > I have now updated my wrapper script to buffer the entire pull request
> > > > contents and check the return value before proceeding.
> > > > 
> > > > It is a poor workman who blames his tools, so I declare publicly that
> > > > you have an idiot for a maintainer.
> > > > 
> > > > Christian: Do you have the bandwidth to take over fs/iomap/?
> > > 
> > > If this helps you I will take iomap over but only if you and Christoph
> > > stay around as main reviewers.
> > 
> > I can't speak for Christoph, but I am very much willing to continue
> > developing patches for fs/iomap, running the QA farm to make sure it's
> > working properly, and reviewing everyone else's patches.  Same as I do
> > now.
> > 
> > What I would like to concentrate on in the future are:
> > 
> > (a) improving documentation and cleanups that other fs maintainers have
> >     been asking for and I haven't had time to work on
> > 
> > (b) helping interested fs maintainers port their fs to iomap for better
> >     performance
> > 
> > (c) figuring out how to integrate smoothly with things like fsverity and
> >     fscrypt
> > 
> > (d) not stepping on *your* toes every time you want to change something
> >     in the vfs only to have it collide with iomap changes that you
> >     didn't see
> > 
> > Similar to what we just did with XFS, I propose breaking up the iomap
> > Maintainer role into pieces that are more manageable by a single person.
> 
> Sounds good.
> 
> > As RM, all you'd have to do is integrate reviewed patches and pull
> > requests into one of your work branches.  That gives you final say over
> > what goes in and how it goes in, instead of letting branches collide in
> > for-next without warning.
> > 
> > You can still forward on the review requests and bug reports to me.
> 
> Ok, cool.
> 
> > That part isn't changing.  I've enjoyed working with you and hope
> > that'll continue well into the future. :)
> 
> Thanks. That's good to hear and right back at you.

Thank you!  I enjoyed reading that! :)

> > 
> > > There's not much point in me pretending I
> > > can meaningfully review fs/iomap/ and I don't have the bandwith even if
> > > I could. So not without clear reviewers.
> > 
> > I hope the above assuades your concerns/fears!
> 
> Yes.
> 
> > 
> > > But, - and I'm sorry if I may overstep bounds a little bit - I think
> > > this self-castigation is really unwarranted. And we all very much know
> > > that you definitely aren't an idiot. And personally I think we shouldn't
> > > give the impression that we expect this sort of repentance when we make
> > > mistakes.
> > > 
> > > In other words, if the sole reason you're proposing this is an
> > > objectively false belief then I would suggest to reconsider.
> > 
> > Quite the opposite, these are changes that I've been wanting to make for
> > months. :)
> 
> In that case I would propose you send a patch to Linus for MAINTAINERS
> updating the tree and the entries for iomap. I believe it's customary
> for the current maintainer to do this.

Will do.  I'll change the M: entry to you, and add myself as an R:.

--D

> 
> Thanks!
> Christian

