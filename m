Return-Path: <linux-fsdevel+bounces-33656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD19BCB7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75248B21DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E51D434F;
	Tue,  5 Nov 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6yl9Oeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36021D31B5;
	Tue,  5 Nov 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805553; cv=none; b=ZWKNL1G66DpKobLBg+XCloB85x6c8nhFa10RzCGwqd3z4Y8d7zlY2vp8esfwnojr/m5hJ+GmVsq0v9Sn+K1vvBnRsfVK+YVWyIVk72j29QVoqVQ4yz77i9bEEEhnBAv4iMOjrcvWiGGJR2SC8yRdBUkMhFXf3ld8A7BAj1NrSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805553; c=relaxed/simple;
	bh=0P/4LXaYYS8+VaEJEHeR1hBpRu520J/avOVUHolKaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxRxqOOiWFGX/RaPeJHO0yo72Kxt7/lz37dMiKKJBd/I7BQKk7xh4Wx/Dl4WfL9lDEvfMHspz77c9Gws2DTKzQOQHznLcrct2gqFd/4u7RQrWc10a9codXcIfxmbIItHtCEGxyoyqWPgbILF7zkT1EvYjVSPu0/wjKDeTx0gKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6yl9Oeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7EFC4CECF;
	Tue,  5 Nov 2024 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730805552;
	bh=0P/4LXaYYS8+VaEJEHeR1hBpRu520J/avOVUHolKaq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6yl9OeblARBBnmH9SCJbpxLuUkCoFi8Nz6Qv0lVFiP/JJqeOQ92A8atAcOK4vg1x
	 dsGofW0Cjw/mWaQpBrHEu0p8HlkpnmkXZfbtjjgRdYldMwlJWrWK81vPqIlXgNps4m
	 8mLJZLGy0qcSGn+/sAcb6RDBE6ue8fWKQdnt8PnB9DLfKhYx6s6pnMKvtuCAYJUf4u
	 Wo4Ho/HKsAfUmTEjAobvLh557kGGJoGOhKcK4yN39O24N0YZshp9ALWBx/Uh9aEvsQ
	 BeCmrOdmFlnGReYZkDscsqwW0x8A79NgT8kG9MsYATfDNarijX61yDu7jatzKuOt3g
	 H7iaEjgvmIo8Q==
Date: Tue, 5 Nov 2024 12:19:05 +0100
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org, Catherine Hoang <catherine.hoang@oracle.com>, 
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
Message-ID: <fegazz7mxxhrpn456xek54vtpc7p4eec3pv37f2qznpeexyrvn@iubpqvjzl36k>
References: <20241105004341.GO21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105004341.GO21836@frogsfrogsfrogs>

On Mon, Nov 04, 2024 at 04:43:41PM -0800, Darrick J. Wong wrote:
> Hi everyone,
> 
> Nobody else has stepped up to do this, so I've created a work branch for
> the fs side of untorn writes:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-04
> 
> Can you all check this to make sure that I merged it correctly?  And
> maybe go test this on your storage hardware? :)
> 
> If all goes well then I think the next step is to ask brauner very
> nicely if he'd consider adding this to the vfs trees for 6.13.  If not
> then I guess we can submit it ourselves, though we probably ought to ask
> rothwell to add the branch to for-next asap.
> 
> PS: We're now past -rc6 so please reply quickly so that this doesn't
> slip yet another cycle.
> 
> Catherine: John's on vacation all week, could you please send me the
> latest versions of the xfs_io pwrite-atomic patch and the fstest for it?

I am kind confused here now. IIRC Jens pulled the first three patches from
John's series into his tree, and John asked me to pull the other ones. I'm much
happier to see a single person pulling the whole series instead of splitting it
into different maintainers though.

Giving how spread the series is, I'd say going through vfs tree would be the
best place, but I'm not opposed to pull them myself.

Carlos

