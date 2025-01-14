Return-Path: <linux-fsdevel+bounces-39201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B6A11555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3FC7A3E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAB32144DB;
	Tue, 14 Jan 2025 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW6BFujW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44A2139D2;
	Tue, 14 Jan 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897036; cv=none; b=n8qUgmZZCD4NOQhp3f9SOu4QYRSwRMgGj7ia8eFyw32x2yD8bMbj/be2yvrRNe7ktW0XAdNqbI0WvGhBvbHs37JzKZjgK1M1e4NcDNWaMu3444WGAhWyputsbB1UaLQ0IK+sjVL7+FZy9GdzGd6j4hlLExStIIhpo3Z7veqymIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897036; c=relaxed/simple;
	bh=yVIwxMpYst29LKOdvumA7yCPlPn/rRofWv+Jpgd5UBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b22y3z6yRWJXHYSn7LbIzFBU1Y4w+bRSliz7j5saIJxxqw6fhMgbnxERYWYS91ydL6slE6MGfiCzGubmM494W06Wdd6FiyMal+ly/r0vHurKRgktVqGkRic7rmIACEuKnm/Hl9MHwhIe+OjVV/evteJKzbCw9RFxmP4ATsEMBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW6BFujW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E03DC4CEDD;
	Tue, 14 Jan 2025 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736897036;
	bh=yVIwxMpYst29LKOdvumA7yCPlPn/rRofWv+Jpgd5UBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DW6BFujWYNWbks38ZERDXFwbHacLktBywY8XIE13wWi9sZCg2WhOKcSfvOjyNVWBA
	 nMGOZ8P/6fsEShtywQhUuJOe65XO2ErXrjwlGI9NifrTqBwUySTFL7J3wzxN9rTCpp
	 Ob0nEykBTZOKD189z6T0fpJ3dsBR2/ZjB24kMzG8NYIVPg5QdBAY84ugcPWIyF0oED
	 tizib2458FcIjeHL1EZ/gqUX1Bo9/XHpKabvBKWQBnzsX3AXOFw+4hkyb7r+dVn5dy
	 PN8uVnHh250s4Tumrlij1snuqvDToaYDv0uLEOO5PNqJEbjgiej92FhDb2U6vijgdc
	 WJwx/OiqU6ERQ==
Date: Tue, 14 Jan 2025 15:23:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>, Kun Hu <huk23@m.fudan.edu.cn>,
	jlayton@redhat.com, adilger.kernel@dilger.ca, bfields@redhat.com,
	viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, linux-bcachefs@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250114232355.GB3561231@frogsfrogsfrogs>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <20250114135751.GB1997324@mit.edu>
 <Z4bVQEKdj4ouAGI4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4bVQEKdj4ouAGI4@dread.disaster.area>

On Wed, Jan 15, 2025 at 08:21:04AM +1100, Dave Chinner wrote:
> On Tue, Jan 14, 2025 at 08:57:51AM -0500, Theodore Ts'o wrote:
> > P.S.  If you want to push back on this nonsense, Usenix program
> > committee chairs are very much looking for open source professionals
> > to participate on the program committees for Usenix ATC (Annual
> > Technical Conference) and FAST (File System and Storage Technologies)
> > conference.
> 
> The problem is that the Usenix/FAST paper committees will not reach
> out to OSS subject matter experts to review papers that they have
> been asked to review for the conference.
> 
> Let me give you a recent example of a clear failure of the FAST
> paper committee w.r.t. plagarism.
> 
> The core of this paper from FAST 2022:
> 
> https://www.usenix.org/conference/fast22/presentation/kim-dohyun
> 
> "ScaleXFS: Getting scalability of XFS back on the ring"
> 
> is based on the per-CPU CIL logging work I prototyped and posted an
> RFC for early in 2021:
> 
> https://lore.kernel.org/linux-xfs/20200512092811.1846252-1-david@fromorbit.com/
> 
> The main core of the improvements described in the ScaleXFS paper
> are the exact per-cpu CIL algorithm in that was contained in the
> above RFC patchset.
> 
> That algorithm had serious problems that meant it was unworkable in
> practice - these didn't show up until journal recovery was tested
> and it resulted in random filesystem corruptions. I didn't
> understand the root cause of the problem until months later.
> 
> These problems were all based on failures to correctly order the
> per-CPU log items in the journal due to the per-CPU CIL being
> inherently racy.  The algorithm I proposed 6 months later (and
> eventually got merged in July 2022) had significant changes to the
> way the per-CPU CIL ordered operations to address these problems.
> 
> IOWs, object ordering on the CIL is the single most important
> critical correctness citeria for the entire journalling algorithm
> and hence a fundamental algorithmic constraint for the per-CPU CIL
> implementation.
> 
> However, the ScaleXFS paper does not make any mention of this
> fundamental algorithmic constraint - I did not publish anything
> about this constraint until the November 2022 patch set....
> 
> There were more clear tell-tales in the paper that indicate
> that the "research" was based on that early per-CPU CIL RFC I
> posted, but I won't go into details.
> 
> I brought this to the FAST committee almost immediately after I was
> able to review the paper (a couple of days after the FAST conference
> itself). I provided them with all the links to public postings of
> the algorithm, detailed analysis of the paper and publicly posted
> code, etc. In response, they basically did nothing and brushed my
> concerns off. It would take weeks to get any response from the paper
> committee, and the overall response really felt like the Usenix
> people simply didn't care at all about what was obviously plagarised
> work.
> 
> IOWs, the Usenix/FAST peer review process for OSS related papers is
> broken, and they don't seem to care when experts from the OSS
> community actually bring clear cases of academic malpractice to
> them...

Heh, I had some pretty strong suspicions of that when I saw the paper.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

