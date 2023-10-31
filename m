Return-Path: <linux-fsdevel+bounces-1642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464607DCE48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730E01C20C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B01DDCF;
	Tue, 31 Oct 2023 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlTYxX8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2B1DDC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 13:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C6C433C8;
	Tue, 31 Oct 2023 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698760512;
	bh=qIx7b2aoxjsw7TSGPFkMkmmuPqzNI4IGu1YwuirwcKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BlTYxX8bg/TyNm9k1G7hqu+6cgvScqLMmrYdwjXbvP2dLhoZwu81/Hd86RFZNrRU0
	 1xr5Y7vFw1ElqKWf1uTmJEmuJvF5L9j3yFfh7ymcf50H/LGvdULGaZ9r81Rim15VMH
	 4BUULsumVrnHeBwimSaTDD/NGbj2ueM3Eg/nxhkdFB1V+ajGM0vsdulmLTlFZNgwMn
	 vt13jgmtUQuW2BcVFTQDAsGHT0Gmcoujtaha2sh9SXpVB++uDD9vrm6H7Cx6inillP
	 sk1nXdn297tkqDQqx2pR+3iapmU6fN1aVLAWEUbQ/flcaA2j5xZmgzrdZMzAsb7osR
	 s91m60OYKHeag==
Message-ID: <b0cd1f921c2c9d9e76cb324c6fa7c48747eafaed.camel@kernel.org>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Chandan
 Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, David Howells
 <dhowells@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org
Date: Tue, 31 Oct 2023 09:55:09 -0400
In-Reply-To: <20231031-stark-klar-0bab5f9ab4dc@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
	 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
	 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
	 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
	 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
	 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
	 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
	 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
	 <20231031-stark-klar-0bab5f9ab4dc@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 11:26 +0100, Christian Brauner wrote:
> On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> > On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > > Back to your earlier point though:
> > > >=20
> > > > Is a global offset really a non-starter? I can see about doing some=
thing
> > > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as c=
heap
> > > > as ktime_get_coarse_ts64. I don't see the downside there for the no=
n-
> > > > multigrain filesystems to call that.
> > >=20
> > > I have to say that this doesn't excite me. This whole thing feels a b=
it
> > > hackish. I think that a change version is the way more sane way to go=
.
> > >=20
> >=20
> > What is it about this set that feels so much more hackish to you? Most
> > of this set is pretty similar to what we had to revert. Is it just the
> > timekeeper changes? Why do you feel those are a problem?
>=20
> So I think that the multi-grain timestamp work was well intended but it
> was ultimately a mistake. Because we added code that complicated
> timestamp timestamp handling in the vfs to a point where the costs
> clearly outweighed the benefits.
>=20
> And I don't think that this direction is worth going into. This whole
> thread ultimately boils down to complicating generic infrastructure
> quite extensively for nfs to handle exposing xfs without forcing an
> on-disk format change. That's even fine.
>=20
> That's not a problem but in the same way I don't think the solution is
> just stuffing this complexity into the vfs. IOW, if we make this a vfs
> problem then at the lowest possible cost and not by changing how
> timestamps work for everyone even if it's just internal.

I'll point out that this last posting I did was an RFC. It was invasive
to the timekeeping code, but I don't think that's a hard requirement for
doing this.

I do appreciate the feedback on this version of the series (particularly
from Thomas who gave a great technical reason why this approach was
wrong), but I don't think we necessarily have to give up on the whole
idea because this particular implementation was too costly.

The core idea for fixing the problem with the original series is sane,
IMO. There is nothing wrong with simply making it that when we stamp a
file with a fine-grained timestamp that we consider that a floor for all
later timestamp updates. The only real question is how to keep that
(global) fine-grained floor offset at a low cost. I think that's a
solvable problem.

I also believe that real, measurable fine-grained timestamp differences
are worthwhile for other use cases beyond NFS. Everyone was pointing out
the problems with lagging timestamps vs. make and rsync, but that's a
double-edged sword. With the current always coarse-grained timestamps,
the ordering of files written within the same jiffy can't be determined
since their timestamps will be identical. We could conceivably change
that with this series.

That said, if this has no chance of ever being merged, then I won't
bother working on it further, and we can try to pursue something that is
(maybe) XFS-specific.

Let me know, either way.
--
Jeff Layton <jlayton@kernel.org>

