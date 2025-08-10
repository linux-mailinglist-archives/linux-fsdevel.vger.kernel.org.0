Return-Path: <linux-fsdevel+bounces-57201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B6B1F88F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC957ADF69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4891F0991;
	Sun, 10 Aug 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CiD4o/GZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A72E3712
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Aug 2025 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805649; cv=none; b=rVP2t/Aglrihl57kJQrN6cWP1+fqwyjcgH22COtwKt0Uc18v/mPWoZu8hgBI5k0fHgWIyhO3+r7Wgo+t0DVXIGdUTpN0i22nR779nsXtOX1bhaobmNLE5VtlfLOz5FD2lGJpfMQeeSleew5p8ChfHU5qQbOxlI7MzDnJYBW+LxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805649; c=relaxed/simple;
	bh=X1/ooEFvmO4P/PkGomwnODSES9eAvH0BCLvNX5aVK1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT/iM2hGfui+rk8W5UbDW6LemKjE/I5pqnlx5nvdJrKlx+ab160ZrmB4KyIaC1lI+5bS9oXwR7YNkx9AwnS8fRNGFLHq8CtVBDqKfY9hck3lTHoUYYWzd17+DKRyJZhhZG+aY1Gcy6Sjf7m0Ipa+SDwJNtvVEjGsEBKEBmtViDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CiD4o/GZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-110.bstnma.fios.verizon.net [173.48.102.110])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57A5xtH5010531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 01:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754805598; bh=uUHLexSEobUC4W0Zie10Dls/rbOBf/7+GetsPvrexGc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CiD4o/GZzQp+LaV/G7HQH2FbGlTTsDLmMnySWyoCf0BN0KPhZsRixTH2FF9CG+64Z
	 W/aBBHE5F4Kx2DLaYuKNQKWBB7wixCzYnBCl3knIN7ABXFRg+vtcJWxO4OFTrsHClr
	 7vTPZ0xV2kwtXFvDLYXUG+tk1Oar1+B8B1sJnT7z6FWqXJ9DORgwJQnaMCGZ7hjM9G
	 ZQ3oMq+gWWb5m2JySjCQ9u4TaMuY1NYPwAIH94FkXybXxfZlXTbUVbGk2vQxQbl+8I
	 xagBxkGLmwzfAOKcLbm8muT/V+FO4nk1W+cTJXvm1UPnvjsSGKzuuFOy9muFKDCEgQ
	 N/QmZtXAm+HOQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8D97B2E00D6; Sun, 10 Aug 2025 01:59:55 -0400 (EDT)
Date: Sun, 10 Aug 2025 01:59:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Gerald B. Cox" <gbcox@bzb.us>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Sasha Levin <sashal@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Aquinas Admin <admin@aquinas.su>,
        Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <20250810055955.GA984814@mit.edu>
References: <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora>
 <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu>
 <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy>
 <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
 <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>

On Sat, Aug 09, 2025 at 09:26:16PM -0700, Gerald B. Cox wrote:
> And really, this whole thread feels beneath what the kernel community
> should be. If there’s a serious question about bcachefs’s future, it
> ought to be a quiet, direct conversation between Kent and Linus—not a
> public spectacle.

There has been private conversations with Kent.  I will note that it
was *Kent* who started this most recent round of e-mails[1].  In his
e-mail, He slammed the Linux Kernel's "engineering standards", and
btrfs in particular.  I won't quote any of it here, because it really
is quite toxic, but please note that it was Kent who started the
discussion about btrfs.  This kind of attack is Just Not Helpful, and
this kind of behavior is, unfortunately, quite common coming from
Kent.

[1] https://lore.kernel.org/all/3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa/

And no, I don't agree that Kent's behavior is due to him being
"piled-on".  His behaviour has been going on for months, if not a year
or more.  Some of us have tried pointing this out to Kent before,
privately, but about a month ago, I gave up out of frustration.
Getting him to understand is clearly beyond my abilities.

If Kent hadn't spoken up, I would have remained quiet and waited for
Linus to do what he was going to do --- but no, he decided to take
this public, and started slamming Linux's engineering standards.  I
will point out that a good engineer has to have good people skills[2].
In fact, there are many who have claimed that engineers' soft skills
are just as important, if not more important than their technical
abilities.

[2] https://www.ijee.ie/articles/Vol13-5/ijee996.pdf

Kent has been claiming the role of victim, but [1] is a really good
example of how this is not the case.  Similar e-mails over the past
year questioning other developers' professionalism, engineering
competence, etc. is why there hasn't been any Linux developers
speaking up trying to defend Kent on various private e-mail threads in
the past month.

Kent, it's not about promising to not criticize btrfs.  It's
about assuming good faith, and other maintainers' technical
competence, and listening to their concerns, and genunely believing
that perhaps their concerns are as important as yours.  If you really
believe that we are all clowns, and that Linux's engineering standards
are cr*p, I cordially invite you to create your own OS which upholds
your high technical standards.  Maybe you will be happier, and maybe
you *will* create something which is better for all of your users.

Cheers,

					- Ted

