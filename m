Return-Path: <linux-fsdevel+bounces-57187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A5B1F82E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA0318979C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 02:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E197017AE11;
	Sun, 10 Aug 2025 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="a3qzAjph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968A2E403
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754792724; cv=none; b=av5y7GkIwVTwqNs6k0F9ymFl7Xzv6537ibyNPoX6cxZDUn8SFtltzJXrOaunKSpuersp0uZAyf80G1ReTiN2sx1RdILzfdWkp/YiuS+6Ijo7dA/blBIcdyc1+uAsQWLASJ0edHx7Ty+6HFYHmL32ETGze0XRGKjXdkJCetVEv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754792724; c=relaxed/simple;
	bh=lcDmeBzy9nP5wZihJdA9h09fgJ8nlD7B/NawEffdeeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPwAdS4Ohnm0jPlTAP4QuvIbTh4ih13QWjIk2v0B+VtoI9Ly3P/+dQB/tSnAy/x107Zi/3bYKXRJ/+mar0czeBZaXCuywhNw64FtC3i3GAsMDeaIzD2dlM/8z62FMNwUia1LiACvpFYqUOqcrn6nmNxiwhV8XtkBRx3VS2tQbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=a3qzAjph; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-110.bstnma.fios.verizon.net [173.48.102.110])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57A2Oack003150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Aug 2025 22:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754792683; bh=EuCczcoy6lfa/ts/992fZBYJ3SCYziTSz4v3L/UPbP8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=a3qzAjph2f+l3VpYNFfKLdhCSmponX2JHJadWcHW7XhglBlx4Zx/9x7csdveo6/hn
	 +aNJ8IoXCGgE3QW5vw911maFuf2doQSsRopMEdNKTLLwRGRL3fVB4RFosfp0sAOw8Q
	 QnX7h7eQxfbyn8jrUPHcma8oxLAm16Nk1VB5zKSpJroXbMJMyh4BP1K07R5shSmZbU
	 On8QJbJYu4uTqHbBOXDzZuDE9wBRueYdPpsRJgTYbZRm9WIwrBDQbltOv1+ByG8Vjh
	 BxFrn96wq0G9ufJt8nDRpi3+rkqYr8zM8Sh2+OssPmW+k/qkZlhLrmWL4Lxa/O9ipO
	 fTdoTqtHIBnag==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 51E1C2E00D6; Sat, 09 Aug 2025 22:24:36 -0400 (EDT)
Date: Sat, 9 Aug 2025 22:24:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, Aquinas Admin <admin@aquinas.su>,
        Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <20250810022436.GA966107@mit.edu>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>

On Sat, Aug 09, 2025 at 04:37:51PM -0400, Kent Overstreet wrote:
> showed that it was possible, but the common consensus in the user
> community, among people with the data (i.e. quite a few of the distros)
> is that btrfs dropped the ball, and regressed on reliability from
> ext4/xfs.

Kent, you eeem to have ignored the primary point of Josef's message,
and instead, prceeded to prove *exactly* what he was pointing out.
Let me quote the most relevant parts of his e-mail, in case you missed
it:

> Btrfs doesn't need me or anybody else wandering around screaming
> about how everybody else sucks to gain users. The proof is in the
> pudding. If you read anything that I've wrote in my commentary about
> other file systems you will find nothing but praise and respect,
> because this is hard and we all make our tradeoffs.
>
> That courtesy has been extended to you in the past, and still
> extends to your file system. Because I don't need to tear you down
> or your work down to make myself feel good. And because I truly
> beleive you've done some great things with bcachefs, things I wish
> we had had the foresight to do with btrfs.
>
> I'm yet again having to respond to this silly childishness because
> people on the outside do not have the context or historical
> knowledge to understand that they should ignore every word that
> comes out of your mouth. If there are articles written about these
> claims I want to make sure that they are not unchallenged and thus
> viewed as if they are true or valid.
> 
> ...
> Emails like this are why nobody wants to work with you. Emails like
> this are why I've been on literally dozens of email threads, side
> conversations, chat threads, and in person discussions about what to
> do when we have exceedingly toxic developers in our community.
> 
> Emails like this are why a majority of the community filters your emails to
> /dev/null.
> 
> You alone with your toxic behavior have wasted a fair amount of mine
> and other peoples time trying to figure out how do we exist in our
> place of work with somebody who is bent on tearing down the
> community and the people who work in it.

And how did you respond?  By criticizing another file system, and
talking about how wonderful you believe bcachefs to be, all of which
is beside the point.  In fact, you once again demonstrated exactly why
a very large number of kernel deevlopers have decided you are
extremely toxic, and have been clamoring that your code be ejected
from the kernel.  Not because of the code, but because your behavior.

In general, file system developers have been the ones that have been
arguing that you should be shone more grace, because we respect the
work that you have done.  However, don't mistake respect for your code
with respect for your behavior.  There are *many* developers in
adjcaent subsystems (for example, block and mm) who have lost all
patience with you.  This is not just one or two people; so please
don't blame this on the people who have been trying to reach out and
help you see what you have been doing.  Quite frankly, it is
astonishing to me how *many* people who have been arguing for "git rm
-r fs/bcachefs" as soon as the merge window opened and effectively
asking why Linus has been extending as much grace as he has up until
now.

Programming is a team sport, and you have pissed off a very large
number of people on the team.  It doesn't matter how talented a
particular indiviual might be; if they can't work with the other
people on the team; if they are toxic to the community, it doesn't
matter whether or not they might be technically correct on a
particular point or not.

Many decades ago, when I was working group chair for ipsec, there was
a particular individual who was super-smart; and who was often
technically on point..  Unfortunately, he had the habit of appending
phrases such as, "as any idiot could see" at to the end of what might
otherwise be a very insightful comment.  It didn't matter that the
point that he raised was one that was (a) correct, and (b) missed by
other people in the working group.  The way that he phrased it meant
that no one wanted to listen to what he had to say.  Because I wanted
the ipsec standardization to succeed, I acted as that person's
intermediary, rephrasing his arguments and technical points in a way
that was easier to understand, and more importantly, stripping out all
of the adhominem asides.  It took a huge amount of work, and psychic
toil, and it isn't something I would ask someone else to do.

All of this being said, unless you can find someone willing to be your
intermediary, and hopefully your coach in how to better work with
other people, I fear that the only thing we can do is to find the most
graceful way for you to leave the community.  And fortunately, I'm
very glad that at the end of the day, it's not up to me.

						- Ted

