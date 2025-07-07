Return-Path: <linux-fsdevel+bounces-54171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE1AFBC42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848BA561256
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A7215F48;
	Mon,  7 Jul 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stoffel.org header.i=@stoffel.org header.b="AznUfHLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB782E370C;
	Mon,  7 Jul 2025 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918618; cv=none; b=pYDYWjdBk4ssggABkcpBSB/VexNjHggTDMgxNynFUADkDYfAphlHhhMzOz3OJSJ0V9drPOdOS6LbR1R2zSiqe05poC9jWl9f6uD8ehYf14chB/u8h9vFt6s4GVfx0Q/Q3VoweTnq6fEETwJzoDp7fA+odIn5cWSaz7sU4BygwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918618; c=relaxed/simple;
	bh=EAXmXEFSkhR5sMR6WzduIUePEVRsXKmpJc3JYJWh77Q=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=l5t8JwWmvAk7LHQ69HmvL27yIcbIBAmYDPy7xeaoKtMjJ9cU5yaKRwJ30xJmtBSKYKzKnRjwngfzXzG83OR2gmMIpd6Xr6cTb/gNMeeAhYtftZjjcb67ZP2jzk0nCdC2Kfj7tAaAzLyY89WXKx7XMYTV0PRqrcDCufPwS1s7hHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; dkim=pass (2048-bit key) header.d=stoffel.org header.i=@stoffel.org header.b=AznUfHLc; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stoffel.org;
 i=@stoffel.org; q=dns/txt; s=20250308; t=1751918608; h=mime-version :
 content-type : content-transfer-encoding : message-id : date : from :
 to : cc : subject : in-reply-to : references : from;
 bh=EAXmXEFSkhR5sMR6WzduIUePEVRsXKmpJc3JYJWh77Q=;
 b=AznUfHLcsVUnKLS0BR7Alh9y9jFccTu07ovVWeYadzPerpnjsN/t4Hp0OyGSkPttTQ2Df
 qENZWKUsWrkWxndcl3yNyj343eW7cecBBOiAavFmG8SZzM8UbxIDh07nH+q3kLLg/L6v2Sq
 VBcomRXpSP5wGLl4J2q4qU503GnCZ5OYzNQ4be0PkOVe5zn63Fd8pvwzr5ti9sp8GuxpNfj
 Zyx9IoPjc4BKZshhhruOLfA1jixPZC2RZRRuPopuZCUhAq4xb2MSNJW/8M86cZVxxxs/APW
 qRoOQKf/3HWYllxm7AtHsg33MsnDxcLm7Myvw8XsSdC2gXRafEJr6FbaMypg==
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 0C0821E1D8;
	Mon,  7 Jul 2025 16:03:28 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 6CFADA1111; Mon,  7 Jul 2025 16:03:27 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26732.10255.420410.321937@quad.stoffel.home>
Date: Mon, 7 Jul 2025 16:03:27 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: John Stoffel <john@stoffel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org,
    linux-kerenl@vger.kernel.org
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
In-Reply-To: <gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
	<CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
	<xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
	<26723.62463.967566.748222@quad.stoffel.home>
	<gq2c4qlivewr2j5tp6cubfouvr42jww4ilhx3l55cxmbeotejk@emoy2z2ztmi2>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> On Tue, Jul 01, 2025 at 10:43:11AM -0400, John Stoffel wrote:
>> >>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:
>> 
>> I wasn't sure if I wanted to chime in here, or even if it would be
>> worth it.  But whatever.
>> 
>> > On Thu, Jun 26, 2025 at 08:21:23PM -0700, Linus Torvalds wrote:
>> >> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>> >> >
>> >> > per the maintainer thread discussion and precedent in xfs and btrfs
>> >> > for repair code in RCs, journal_rewind is again included
>> >> 
>> >> I have pulled this, but also as per that discussion, I think we'll be
>> >> parting ways in the 6.17 merge window.
>> >> 
>> >> You made it very clear that I can't even question any bug-fixes and I
>> >> should just pull anything and everything.
>> 
>> > Linus, I'm not trying to say you can't have any say in bcachefs. Not at
>> > all.
>> 
>> > I positively enjoy working with you - when you're not being a dick,
>> > but you can be genuinely impossible sometimes. A lot of times...
>> 
>> Kent, you can be a dick too.  Prime example, the lines above.  And
>> how you've treated me and others who gave feedback on bcachefs in the
>> past.  I'm not a programmer, I'm in IT and follow this because it's
>> interesting, and I've been doing data management all my career.  So
>> new filesystems are interesting.  

> Oh yes, I can be. I apologize if I've been a dick to you personally, I
> try to be nice to my users and build good working relationships. But
> kernel development is a high stakes, high pressure, stressful job, as I
> often remind people. I don't ever take it personally, although sometimes
> we do need to cool off before we drive each other completely mad :)

I appreciate this, but honestly I'll withhold judgement until I see
how it goes more long term.  But I'm also NOT a kernel developer, I'm
an IT professional who does storage and backups and managing data.  So
my perspective is very definitely one of your users, or users-to-be.
But I've also got a CS degree and understand programming issues and
such.  

> If there was something that was unresolved, and you'd like me to
> look at it again, I'd be more than happy to. If you want to share
> what you were hitting here, I'll tell you what I know - and if it
> was from a year or more ago it's most likely been fixed.

Nope, it was over a year ago and it's behind me.  I was trying to
build the tools on Debian distro when the bcachefs-tools were a real
pain to build.  It's better now.  

>> Slow down.  

> This is the most critical phase in the 10+ year process of shipping a
> new filesystem.

Sure, but that's not what I'm trying to say here.  The kernel has, as
you most certainly know, a standard process for quickly deploying new
versions.  Linus's entire problem is that you dropped in a big chunk
of code into the late release process.  

And none of that is critical, because if you have people running 100tb
of bcachefs right now, they certainly understand that they can lose
data at any time.  Or at least they should if they have any sort of
understanding of reliable data.  bcachefs isn't there yet.  It's
getting close, but Linux has an amazingly complicated VFS and supports
all kinds of wierd edge cases.  Which sucks from the filesystem
perspective.

But you know this.  

So when you run into a major bug in the code, or potential data loss
when -rc2 or later is coming out, just revert.  Pull that code out
because it's obviously not ready.  So you wait a few months, big deal!
IT gives you and the code time to stabilize.  

If someone is losing data and you want to give them a patch to try and
fix it, great, but they can take a patch from you directly.  And post
it to your mailing list.  Put it on a git branch somewhere.  

But revery from the main linus tree.  For now.  In two months, you'll
be back with better code.  bcachefs is still listed as experimental,
so don't feel like you have to keep pushing the absolutely latest code
into the kernel.  Just slow it down a little to make sure you push
good code.  

> We're seeing continually increasing usage (hopefully by users who are
> prepared to accept that risk, but not always!), but we're not yet ready
> for true widespread deployment.

If those users are not prepared to accept the risk of an experimental
filesystem, then screw them!  They're idiots and should be treated as
such.  

I would expect to be fired from my job if I bet my company's data on
bcachefs currently.  Sure, play around and test it if you like, but if
it breaks, you get to keep both pieces.  

Same with bleeding edge kernel developement!  I might run pretty
bleeding edge kernels at home, but only for my own data that I realize
I might lose.  But I also do backups, have the data on XFS and ext4
filesystems, which are stable, and I'm not trying to do crazy things
with it.  

Do I have some test bcachefs volumes?  Sure do.  And I treat them like
lepers, if they break, I either toss them away, or I file a report,
but I certainly don't keep ANY data on there I don't want to lose.  

I'm being blunt here.  

> Shipping a project as large and complex as a filesystem must be done
> incrementally, in stages where we're deploying to gradually increasing
> numbers of users, fixing everything they find and assessing where we're
> at before opening it up to more users.

Yes!  But that process also has to include rollbacks, which git has
made so so so easy.  Just accept that _if_ 6.x-rc[12345] is buggy,
then it needs to be rolled back and subbmitted to 6.x+1-rc1 for the
next cycle after it's been baked.

Anyone running such a bleeding edge kernel and finding problems isn't
going to care about having to hand apply patches, they're already
doing crazy things!  *grin*

> Working with users, supporting with them, checking in on how it's doing,
> and getting them the fixes for what they find is how we iterate and
> improve. The job is not done until it's working well for everyone.

Yes, I agree 100% with all this. 

> Right now, everyone is concerned because this is a hotly anticipated
> project, and everyone wants to see it done right.

So which is more important?  Ship super fast and break things?  Or be
willing to revert and ship just a bit slower?  

> And in 6.16, we had two massive pull requests (30+ patches in a
> week, twice in a row); that also generates concern when people are
> wondering "is this thing stabilizing?".

Correct!

> 6.16 was largely a case of a few particularly interesting bug
> reports generating a bunch of fixes (and relatively simple and
> localized fixes, which is what we like to see) for repair corner
> cases, the biggest culprit (again) being snapshots.

Sure, fixes are great.  But why did you have to drop them into -rc2 in
a big bundle?  Why not just roll back what you had submitted and say
"it's not baked enough, it needs to wait a release"?  

> If you look at the bug tracker, especially rate of incoming bugs and the
> severity of bug reports (and also other sources of bug reports, like
> reddit and IRC) - yes, we are stabilizing fast.

Sure, and I'm happy for this.  And so are a bunch of other people!  

> There is still a lot of work to be done, but we're on the right track.

No arguement there.

> "Slowing down" is not something you do without a concrete
> reason.

And this is where you and Linus are butting heads in my opinion.  You
want to release big patches at any time.  Linus wants to stabilize
releases and development for the entire kernel.  You're concentrating
on your small area which is vitally important to you.  But not
everyone is as invested.  Others want the latest DRM drivers.  Or the
latest i2c code, or some other subsystem which they care about.  Linus
(and the process) is about the entire kernel.  

> Right now we need to be getting those fixes out to users so
> they can keep testing and finding the next bug. When someone has
> invested time and effort learning how the system works and how to
> report bugs, we don't watn them getting frustrated and leaving - we
> want to work with them, so they can keep testing and finding new
> bugs.

So post patches on your own tree that they can use, nothing stops you! 

> The signals that would tell me it's time to slow down are:

> - Regressions getting through (quantity, severity, time spent on fixing
>   them)
> - Bugs getting through that show that show that something fundamental is
>   missing (testing, hardening), or broken in our our design.
> - Frequency of bug reports going up to where I can't keep up (it's been
>   in steady, gradual decline)

> We actually do not want this to be 100% perfect before it sees users.
> That would result in a filesystem that's brittle - a glass cannon. We
> might get it to the point where it works 99% of the time, but then when
> it breaks we'd be in a panic - and if you discover it then, when it's in
> the wild, it's too late.

> The processes for how we debug and recover from failures, in the wild,
> is a huge part (perhaps the majority) of what we're working on now. That
> stuff has to be baked into the design on a deep level, and like all
> other complex design it requires continual iteration.

> That is how we'll get the reliability and robustness we hope to achieve.

