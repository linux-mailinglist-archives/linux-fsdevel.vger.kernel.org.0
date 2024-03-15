Return-Path: <linux-fsdevel+bounces-14418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE087C797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B57A1C20AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 02:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3E8801;
	Fri, 15 Mar 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPHRd6hW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CF6FA9;
	Fri, 15 Mar 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470196; cv=none; b=tCCt6JQrwbioUjcNE1Xc7vln7fgSoG2ROKEfWN8ybRTq+GKyLTwPiTc5SsSYywqgc9nT0IyOVHHlf0lyQNtxdomnww7ifpJatACiv8keT8IbFsBEMnjO0IbIDr76P11hmbacEi2NjBTCMdYSw6xQImR3p4WKg4w24nz6VxLNDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470196; c=relaxed/simple;
	bh=IDHZnC8DRlGzREfmab5dkL11UA+OXeGg6l0o1zRoQ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKGgA2IOsL/7TBdexV89/Y/kNV29+d56maUGsaIYQWTYbZ7tsrUYAUoZ9J/BZ/BZCcL/ukFKkoLNq80onhtRgcyFPr0m0UI1G07QYDcoS8Ko7zDHJtKLwwY/KzjutjPF41ijedDKrgsdbrIF96ABXooUH+b/FCgjp0w9x6q6DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPHRd6hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C71C433F1;
	Fri, 15 Mar 2024 02:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470195;
	bh=IDHZnC8DRlGzREfmab5dkL11UA+OXeGg6l0o1zRoQ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPHRd6hW4TLqldoASq97l9h+BSFDg8lphaGFOZv1cXzrQ6qEO4BhTIULZ+wg72nlD
	 Ujb+uQ1cOnnxwGEi3MelUyFCFIsYGOPvKXODfl1XaPJt3KcYByfiSxhn4NTJ7c6uoj
	 8mdrOyWV1m4MgrhmJYq/v9Eui42RV6+ATITPAAAJuAeH/HmNv4JO2S8MLPbxzerf9s
	 NWy/Rr4RKMwdZ/P9HJYG/sfWYLwencwz+H0psIl0KOkDcfX4YvFzwXNbitvLhWFUwH
	 rCQX6w9jKjGv0cVLW266Qv02YwDQ0LKc6QuixByi4MiKEYlmDapPH+jaml2j7DKZcJ
	 K77qvv/RS0bfg==
Date: Thu, 14 Mar 2024 19:36:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, akiyks@gmail.com,
	cmaiolino@redhat.com, corbet@lwn.net, dan.carpenter@linaro.org,
	dchinner@redhat.com, hch@lst.de, hsiangkao@linux.alibaba.com,
	hughd@google.com, kch@nvidia.com, kent.overstreet@linux.dev,
	leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, longman@redhat.com, mchehab@kernel.org,
	peterz@infradead.org, sfr@canb.auug.org.au, sshegde@linux.ibm.com,
	willy@infradead.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 75bcffbb9e75
Message-ID: <20240315023635.GZ1927156@frogsfrogsfrogs>
References: <87r0gmz82t.fsf@debian-BULLSEYE-live-builder-AMD64>
 <ZepcRgdO39xIrXG2@dread.disaster.area>
 <87o7bihb66.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7bihb66.fsf@debian-BULLSEYE-live-builder-AMD64>

On Wed, Mar 13, 2024 at 12:23:17PM +0530, Chandan Babu R wrote:
> On Fri, Mar 08, 2024 at 11:31:02 AM +1100, Dave Chinner wrote:
> > On Thu, Mar 07, 2024 at 03:16:56PM +0530, Chandan Babu R wrote:
> > Hi Chandan,
> >
> > I'm finding it difficult to determine what has changed from one
> > for-next update to the next because there's only a handful of new
> > commits being added to this list.
> >
> > In this case, I think there's only 1 new commit in this update:
> >
> >>       [75bcffbb9e75] xfs: shrink failure needs to hold AGI buffer
> >
> > And I only found that out when rebasing my local tree and that patch
> > did not apply.
> >
> > When I was doing these for-next tree updates, I tried to only send
> > out the list of commits that changed since the last for-next tree
> > update rather than the whole lot since the base kernel it was
> > started from. That made it easy for everyone to see what I'd just
> > committed, as opposed to trying to find whether their outstanding
> > patches were in a big list already committed patches...
> >
> > Up to you, but I'm bringing it up because I am finding it difficult
> > to track when one of my patches has been committed to for-next right
> > now...
> >
> 
> You are right. I didn't realize this problem. I will limit for-next
> announcements to include only new patches that were added/removed to/from the
> existing pile.

Or tell us what changed since the last push in the first paragraph.

"Hi folks,

"The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

"has just been updated.  New since the last push are some bug fixes to
insulate us from small mammals infiltrating the inode cache and wreaking
havoc on Riker's trombone.  I also merged the Y2500 support patchset to
make Geordi happy."

--D

> -- 
> Chandan
> 

