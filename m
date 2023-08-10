Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E927783B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHJWjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHJWjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717252D40;
        Thu, 10 Aug 2023 15:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA7706649C;
        Thu, 10 Aug 2023 22:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4E6C433C8;
        Thu, 10 Aug 2023 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691707183;
        bh=NnXo9REQIU66FvtojWNWXBLeayDjhDjK23BWn55SNbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRrGoK9nbi/pSR5pkoZcY6Ju3cLYmqqxCi6Q241aEjoN8sHm4gCHkZPh0A3CMS603
         A8lT+r5EjnsNkwjwmiMx3wCkMAmq2AQo32vkP5LTry2QGSGwUFXJ5RbMpzdVblxbZ5
         NYg4BZ7ZtxwDaw6zq6VjjmE9ArfscGI6X1EexdAFZoMFOfhSmp2doSjEOhwXCyYlfa
         Loct16TN3J1HJSmZdBWaZ/a5opgPn8UIEsXLUv3f7fwrR2ecE5UyLXf04AwJTN0bA/
         oKD4MAmDaxe5TVM3zLj/vTmBmIhLG8YHu8etr+F9y8vx4tW7VWhB7AdDT6k4czGV2s
         Xtnb81tt91XdA==
Date:   Thu, 10 Aug 2023 15:39:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230810223942.GG11336@frogsfrogsfrogs>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:54:53AM -0400, Kent Overstreet wrote:
> Adding Jens to the CC:

<snip to the parts I care most about>

> > and the whole crazy discussion about fput being delayed. It
> > is what it is, and the patches I saw in this thread to not delay them
> > were bad.
> 
> Jens claimed AIO was broken in the same way as io_uring, but it turned
> out that it's not - the test he posted was broken.
> 
> And io_uring really is broken here. Look, the tests that are breaking
> because of this are important ones (generic/388 in particular), and
> those tests are no good to us if they're failing because of io_uring
> crap and Jens is throwing up his hands and saying "trainwreck!" when we
> try to get it fixed.

FWIW I recently fixed all my stupid debian package dependencies so that
I could actually install liburing again, and rebuilt fstests.  The very
next morning I noticed a number of new test failures in /exactly/ the
way that Kent said to expect:

fsstress -d /mnt & <sleep then simulate fs crash>; \
	umount /mnt; mount /dev/sda /mnt

Here, umount exits before the filesystem is really torn down, and then
mount fails because it can't get an exclusive lock on the device.  As a
result, I can't test crash recovery or corrupted metadata shutdowns
because of this delayed fput thing or whatever.  It all worked before
(even with libaio in use) I turned on io_uring.

Obviously, I "fixed" this by modifying fsstress to require explicit
enabling of io_uring operations; everything went back to green after
that.

I'm not familiar enough with the kernel side of io_uring to know what
the solution here is; I'm merely here to provide a second data point.

<snip again>

> > The thing that actually bothers me most about this all is the personal
> > arguments I saw.  That I don't know what to do about. I don't actually
> > want to merge this over the objections of Christian, now that we have
> > a responsible vfs maintainer.
> 
> I don't want to do that to Christian either, I think highly of the work
> he's been doing and I don't want to be adding to his frustration. So I
> apologize for loosing my cool earlier; a lot of that was frustration
> from other threads spilling over.
> 
> But: if he's going to be raising objections, I need to know what his
> concerns are if we're going to get anywhere. Raising objections without
> saying what the concerns are shuts down discussion; I don't think it's
> unreasonable to ask people not to do that, and to try and stay focused
> on the code.

Yeah, I'm also really happy that we have a new/second VFS maintainer.  I
figure it's going to take us a while to help Christian to get past his
fear and horror at the things lurking in fs/ but that's something worth
doing.

(I'm not presuming to know what Christian feels about the VFS; 'fear and
horror' is what *I* feel every time I have to go digging down there.
I'm extrapolating about what I would need, were I a new maintainer, to
get myself to the point where I would have an open enough mind to engage
with new or unfamiliar concepts so that a review cycle for something as
big as bcachefs/online fsck/whatever would be productive.)

> He's got an open invite to the bcachefs meeting, and we were scheduled
> to talk Tuesday but he was out sick - anyways, I'm looking forward to
> hearing what he has to say.
>
> More broadly, it would make me really happy if we could get certain
> people to take a more constructive, "what do we really care about here
> and how do we move forward" attitude

...and "what are all the supporting structures that we need to have in
place to maximize the chances that we'll accomplish those goals"?

> instead of turning every
> interaction into an opportunity to dig their heels in on process and
> throw up barriers.
>
> That burns people out, fast. And it's getting to be a problem in
> -fsdevel land;

Past-participle, not present. :/

I've said this previously, and I'll say it again: we're severely
under-resourced.  Not just XFS, the whole fsdevel community.  As a
developer and later a maintainer, I've learnt the hard way that there is
a very large amount of non-coding work is necessary to build a good
filesystem.  There's enough not-really-coding work for several people.
Instead, we lean hard on maintainers to do all that work.  That might've
worked acceptably for the first 20 years, but it doesn't now.

Nowadays we have all these people running bots and AIs throwing a steady
stream of bug reports and CVE reports at Dave [Chinner] and I.  Most of
these people *do not* help fix the problems they report.  Once in a
while there's an actual *user* report about data loss, but those
(thankfully) aren't the majority of the reports.

However, every one of these reports has to be triaged, analyzed, and
dealt with.  As soon as we clear one, at least one more rolls in.  You
know what that means?  Dave and I are both in a permanent state of
heightened alert, fear, and stress.  We never get to settle back down to
calm.  Every time someone brings up syzbot, CVEs, or security?  I feel
my own stress response ramping up.  I can no longer have "rational"
conversations about syzbot because those discussions push my buttons.

This is not healthy!

Add to that the many demands to backport this and that to dozens of LTS
kernels and distro kernels.  Why do the participation modes for that
seem to be (a) take on an immense amount of backporting work that you
didn't ask for; or (b) let a non-public ML thing pick patches and get
yelled at when it does the wrong thing?  Nobody ever asked me if I
thought the XFS community could support such-and-such LTS kernel.

As the final insult, other people pile on by offering useless opinions
about the maintainers being far behind and unhelpful suggestions that we
engage in a major codebase rewrite.  None of this is helpful.

Dave and I are both burned out.  I'm not sure Dave ever got past the
2017 burnout that lead to his resignation.  Remarkably, he's still
around.  Is this (extended burnout) where I want to be in 2024?  2030?
Hell no.

I still have enough left that I want to help ourselves adapt our culture
to solve these problems.  I tried to get the conversation started with
the maintainer entry profile for XFS that I recently submitted, but that
alone cannot be the final product:
https://lore.kernel.org/linux-xfs/169116629797.3243794.7024231508559123519.stgit@frogsfrogsfrogs/T/#m74bac05414cfba214f5cfa24a0b1e940135e0bed

Being maintainer feels like a punishment, and that cannot stand.
We need help.

People see the kinds of interpersonal interactions going on here and
decide pursue any other career path.  I know so, some have told me
themselves.

You know what's really sad?  Most of my friends work for small
companies, nonprofits, and local governments.  They report the same
problems with overwork, pervasive fear and anger, and struggle to
understand and adapt to new ideas that I observe here.  They see the
direct connection between their org's lack of revenue and the under
resourcedness.

They /don't/ understand why the hell the same happens to me and my
workplace proximity associates, when we all work for companies that
each clear hundreds of billions of dollars in revenue per year.

(Well, they do understand: GREED.  They don't get why we put up with
this situation, or why we don't advocate louder for making things
better.)

> I've lost count of the times I've heard Eric Sandeen
> complain about how impossible it is to get things merge,

A group dynamic that I keep observing around here is that someone tries
to introduce some unfamiliar (or even slightly new) concept, because
they want the kernel to do something it didn't do before.  The author
sends out patches for review, and some of the reviewers who show up
sound like they're so afraid of ... something ... that they throw out
vague arguments that something might break.

[I have had people tell me in private that while they don't have any
specific complaints about online fsck, "something" is wrong and I need
to stop and consider more thoroughly.  Consider /what/?]

Or, worse, no reviewers show up.  The author merges it, and a month
later there's a freakout because something somewhere else broke.  Angry
threads spread around fsdevel because now there's pressure to get it
fixed before -rc8 (in the good case) or ASAP (because now it's
released).  Did the author have an incomplete understanding of the code?
Were there potential reviewers who might've said something but bailed?
Yes and yes.

What do we need to reduce the amount of fear and anger around here,
anyway?  20 years ago when I started my career in Linux I found the work
to be challenging and enjoyable.  Now I see a lot more anger, and I am
sad, because there /are/ still enjoyable challenges to be undertaken.
Can we please have that conversation?

People and groups do not do well when they feel like they're under
constant attack, like they have to brace themselves for whatever
bullshit is coming next.  That is how I feel most weeks, and I choose
not to do that anymore.

> and I _really_
> hope people are taking notice about Darrick stepping away from XFS and
> asking themselves what needs to be sorted out.

Me too.  Ted expressed similar laments about ext4 after I announced my
intention to reduce my own commitments to XFS.

> Darrick writes
> meticulous, well documented code; when I think of people who slip by
> hacks other people are going to regret later, he's not one of them.

I appreciate the compliment. ;)

From what I can tell (because I lolquit and finally had time to start
scanning the bcachefs code) I really like the thought that you've put
into indexing and record iteration in the filesystem.  I appreciate the
amount of work you've put into making it easy and fast to run QA on
bcachefs, even if we don't quite agree on whether or not I should rip
and replace my 20yo Debian crazyquilt.

> And yet, online fsck for XFS has been pushed back repeatedly because
> of petty bullshit.

A broader dynamic here is that I ask people to review the code so that I
can merge it; they say they will do it; and then an entire cycle goes by
without any visible progress.

When I ask these people why they didn't follow through on their
commitments, the responses I hear are pretty uniform -- they got buried
in root cause analysis of a real bug report but lol there were no other
senior people available; their time ended up being spent on backports or
arguing about backports; or they got caught up in that whole freakout
thing I described above.

> Scaling laws being what they are, that's a feature we're going to need,
> and more importantly XFS cannot afford to lose more people - especially
> Darrick.

While I was maintainer I lobbied managers at Oracle and Google and RH to
hire new people to grow the size of the XFS community, and they did.
That was awesome!  It's not so hard to help managers come up with
business justifications for headcount for critical pieces of their
products*.

But.

For 2023 XFS is already down 2 people + whatever the hell I was doing
that isn't "trying to get online fsck merged".  We're still at +1, but
still who's going to replace us oldtimers?

--D

* But f*** impossible to get that done when it's someone's 20% project
  causing a lot of friction on the mailing lists.

> To speak a bit to what's been driving _me_ a bit nuts in these
> discussions, top of my list is that the guy who's been the most
> obstinate and argumentative _to this day_ refuses to CC me when touching
> code I wrote - and as a result we've had some really nasty bugs (memory
> corruption, _silent data corruption_).
> 
> So that really needs to change. Let's just please have a little more
> focus on not eating people's data, and being more responsible about
> bugs.
> 
> Anyways, I just want to write the best code I can. That's all I care
> about, and I'm always happy to interact with people who share that goal.
> 
> Cheers,
> Kent
