Return-Path: <linux-fsdevel+bounces-53528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9489AEFD09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C47ACD54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9376277C9F;
	Tue,  1 Jul 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stoffel.org header.i=@stoffel.org header.b="Ocx1PyaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4052777E1;
	Tue,  1 Jul 2025 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381349; cv=none; b=HY/Fhr5/xzG45AdFXk0/pklLzPl97R7z+0fW37gmSGjnNbcjKopzQJhj2FhtXodxnfHCXbI+2XxiK498H6bunw/EP37Y9jMK6f1mh8Y2s1uDeD7y1K6UpqDzPgPHsH5fYWUthqGJSNueNIQVQmevAcrqba6AB8sMsTop97kyf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381349; c=relaxed/simple;
	bh=lRxGPfMELh7HzrgS15Q3ejhCWOxjdsNt9Sn5cFB1kZw=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=EbpPjBcE8CB9WHOXTtiOgcr/1a5SKwmp9DJ5SvxLEvlZzwn058HWkOncyiNJliBcB+EH5iVtHCq1/4fcHv0XVPl/m3jTPnqf6LbW1qHzjibII/C1voO+Xn9PF7O5bHwGPcNaaWFcB6YxtQCrqHghfoHfBzX7HJvsXS1Nb4RNuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; dkim=pass (2048-bit key) header.d=stoffel.org header.i=@stoffel.org header.b=Ocx1PyaO; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stoffel.org;
 i=@stoffel.org; q=dns/txt; s=20250308; t=1751380992; h=mime-version :
 content-type : content-transfer-encoding : message-id : date : from :
 to : cc : subject : in-reply-to : references : from;
 bh=lRxGPfMELh7HzrgS15Q3ejhCWOxjdsNt9Sn5cFB1kZw=;
 b=Ocx1PyaOH8aHynt34mUsXr9UJzfH/4C68EC8KU/vfepsuiTkKzJ14SA/Fq2UE8s+5haMf
 MDC+iMXs60FTao2S1vUDzH7EsiJXfiId8FpqfqB4FEoVoMxl6zsHLkIu2d97/ldGGBwo45s
 9sfsy7OfYf/m/H7Wvk6KgPNrmZrfM88KJox3rnZHAlDUPKlVR+WNXcpLvmkf31RcuaeHfMQ
 qmkhsLITA21K44pc9XDXQL4TiqUHwreoEDbpfWC+sR8XssaoHhbTlIOiMBP1/adMlTVy0N3
 eheR64UVRhcZLJPmKnV01XYyVp9raM/6HYaAL4PfQNCoqRzqUilrjewn2DZg==
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 87AD71E2CE;
	Tue,  1 Jul 2025 10:43:12 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id F2196A10F5; Tue,  1 Jul 2025 10:43:11 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26723.62463.967566.748222@quad.stoffel.home>
Date: Tue, 1 Jul 2025 10:43:11 -0400
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
    linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org,
    linux-kerenl@vger.kernel.org
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
In-Reply-To: <xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
	<CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
	<xl2fyyjk4kjcszcgypirhoyflxojzeyxkzoevvxsmo26mklq7i@jw2ou76lh2py>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

I wasn't sure if I wanted to chime in here, or even if it would be
worth it.  But whatever.

> On Thu, Jun 26, 2025 at 08:21:23PM -0700, Linus Torvalds wrote:
>> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>> >
>> > per the maintainer thread discussion and precedent in xfs and btrfs
>> > for repair code in RCs, journal_rewind is again included
>> 
>> I have pulled this, but also as per that discussion, I think we'll be
>> parting ways in the 6.17 merge window.
>> 
>> You made it very clear that I can't even question any bug-fixes and I
>> should just pull anything and everything.

> Linus, I'm not trying to say you can't have any say in bcachefs. Not at
> all.

> I positively enjoy working with you - when you're not being a dick,
> but you can be genuinely impossible sometimes. A lot of times...

Kent, you can be a dick too.  Prime example, the lines above.  And
how you've treated me and others who gave feedback on bcachefs in the
past.  I'm not a programmer, I'm in IT and follow this because it's
interesting, and I've been doing data management all my career.  So
new filesystems are interesting.  

But I've also been bitten by data loss, so I'd never ever trust my
production data to something labeled "experimental".  It's wonderful
that you have stepped up and managed to get back people's data when
bugs in the code have caused them to lose data.  

But for god's sake, just because you can find and fix this type of bug
during the -rc series, doesn't mean you need to try and patch it NOW.
Queue it up for the next release.  Tell people how they can pull the
patch early if they want, but don't push it late in the release
cycle.  

I've been watching this list since the early 2.x days, and I've seen
how the workflow has evolved over time.  I've watched people burn out
and leave, flame wars and all kinds of crap.  And the people who have
stayed around are generally the nice people.  The flexible people.
The people who know when to back the f*ck off and take their time.  

> When bcachefs was getting merged, I got comments from another
> filesystem maintainer that were pretty much "great! we finally have
> a filesystem maintainer who can stand up to Linus!".

Is that in terms of being dicks, or in terms of technical ability?  Or
in terms of being super productive and focussed and able to get work
done.  Standing up doesn't mean you're right.  Or wrong.  

> And having been on the receiving end of a lot of venting from them
> about what was going on... And more that I won't get into...

> I don't want to be in that position.

So don't!  Just step back a second.  Go back and read and re-read all
the comments Linus had made about the workflow and release process
over the years, much less decades of the kernel development.  I'm not
sure you realize how much work it is to have people blasting patches
at you all day long, 365 days a year, and who think their patches are
the most important thing in the entire world bar none.   

Just reflect on this for a second.  Take your hands off your keyboard,
and don't type anything.  And think about how many other people also
think their patches are the most important.  

And about the users who _need_ _that_ _patch_ _right_ _now_ to fix a
problem.  Why doesn't Linus see that I'm important and my part of the
kernel is the most important!  

Just let that sink in a bit.  

Then think about how many people do not care about bcachefs at all,
who don't even know it exists.  And haven't used it or want to use
it.  Are they less important?  What about the graphics driver they
need to get _their_ work done right now?  Is that more or less
important?

> I'm just not going to have any sense of humour where user data integrity
> is concerned or making sure users have the bugfixes they need.

So release your own patches in your own tree!  No one is stopping you!
Have your '6.17-next' branch with the big re-working to fix this
horrible issue.  But send in just the minimal patch _now_.  The
absolutely the smallest patch.  

Or just send in a revert for all you have done in the current series
which is breaking people, because it wasn't quite baked enough for
stability.  Fall back, re-group, re-submit it all on the next release.

Slow down.  

> Like I said - all I've been wanting is for you to tone it down and stop
> holding pull requests over my head as THE place to have that discussion. 

And you need to stop thinking you are the most important thing and
only you can decide when bcachefs needs to be updated or not in the
kernel tree.  

> You have genuinely good ideas, and you're bloody sharp. It is FUN
> getting shit done with you when we're not battling.

I'm honestly amazed at your abilities here Kent, even though you can
be an abrassive person too.  

> But you have to understand the constraints people are under. Not
> just myself.

Dude, you need to listed to Linus saying this exact same line back to
you.

John

