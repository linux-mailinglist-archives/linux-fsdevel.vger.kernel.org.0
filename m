Return-Path: <linux-fsdevel+bounces-49276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6AAB9F9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7557A04A8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A41AF0AE;
	Fri, 16 May 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIoHDZ1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82871186E2D;
	Fri, 16 May 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408207; cv=none; b=uAsfiUDPSQYsUu2l8bvim20Ko1RcKm4gZA6K7Oiv+9KiPLFs+xYoNp1cvvUGo70lvQR2M9t38oR06VDGhdABdDGwKJcDlvrPNv3HijjTzXCI4GQlYUIFvKKJ0tMRD+lIUlyTtr1B//RAK6RFFoD+Aau5Ji7U+IAWGLe2uLR00tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408207; c=relaxed/simple;
	bh=rUI+53mv47UZHzh2OFlAo7D9jBl6iIgjgYtXDi44/9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogeKBYtw86fgpyP/UmH8fwa6+6FpFxMgpsyM4ckVzrrYyLMF5MVQQUdByziQHJJTiejMv+btcDvbZm1mTvtXneBy6NSghm1r8Ikspt/JZPSK+NbrTFNAGx20agBTcMkyAQSosva5mvUHSZcxS0HBU6hItxqJc1JYmRFTX6Nj0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIoHDZ1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEAEC4CEE4;
	Fri, 16 May 2025 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408205;
	bh=rUI+53mv47UZHzh2OFlAo7D9jBl6iIgjgYtXDi44/9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIoHDZ1q5J73FgSFuKv6WTLI3UhTrpNh+mzNY4xs4ObDEp94e79HU03uB1kkMT1sV
	 5tr4buKiTdsfhAUHlTafBlOuyjVyIwIW7XrzmKMeTZkBjoZE7x95r/eKVszxxawErj
	 v7Muc/CSBpYmKGrbM5BKsZCbxXLT1UYKC2u3GpR3Zwx0LSGab7fvi2l64KtYE/g0ez
	 xmhYizsxP/VTTdfsN/q9WtmesmOa+hxlcfxKHtun11tVG9yioSDoP7do+Uw+ZTqMIc
	 Zrtsmdm/v/zlxi0sl0kIbb5FY922lgu2iMUitiJ0BaYFHJ+MihJ8LRcxk2dIm42wI/
	 +Zv2lfcwYdXKA==
Date: Fri, 16 May 2025 08:10:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Carlos Maiolino <cem@kernel.org>, John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
Message-ID: <20250516151005.GS25655@frogsfrogsfrogs>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
 <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com>
 <20250516121938.GA7158@mit.edu>
 <6zGxoHeq5U6Wkycb78Lf1YqD2UZ_6HbHKjIylyTu1s2iRplyxIkQL9FOimJbx_qlfo2fer1wwGQ-5r8i9M91ng==@protonmail.internalid>
 <920cd126-7cee-4fe5-a4ab-b2c826eb8b8c@oracle.com>
 <cuyujo64iykwa2axim2jj5fisqnc4xhphasxm5n6nsim5qxvkg@rvtkxg6fj6ni>
 <20250516144817.GB21503@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516144817.GB21503@mit.edu>

On Fri, May 16, 2025 at 10:48:17AM -0400, Theodore Ts'o wrote:
> On Fri, May 16, 2025 at 03:31:17PM +0200, Carlos Maiolino wrote:
> > 
> > This is likely the final state for XFS merge-window and I hope to
> > send it to Linus as soon as the merge window opens.
> 
> Very cool!
> 
> I've taken a quick peek, and it looks like the only XFS-specific
> atomic writes is an XFS mount option.  Am I missing anything?
> 
> I want to keep merging the ext4 and xfs atomic write patchsets simple,
> so I'd prefer not to have any git-level dependencies on the branches.
> If we're confident that the xfs changes are going to land at the next
> merge window,

/I/ for one hope that the xfs changes land this time around.

> given that the ext4 patch set is pretty much ready to
> land in the ext4 tree, how about updating the documentation in a
> follow-up patch.
> 
> I can either append the commit which generalizes the documentation to
> the ext4 tree, or if it turns out that there is a v6 needed of the
> ext4 atomic write patchset, we can fold the documentation update into
> the "ext4: add atomic block write documentation" commit and rename it
> to "Documentation: add atomic write block documentation."
> 
> Does that seem reasonable?

I think it's ok to combine them after the merge.  It would be useful to
have a single programmer's guide that takes a person through the whole
process of determining the block device's atomic write capabilities,
formatting either an XFS or ext4 filesystem appropriately, and then
presents a toy program to discover the atomic write limits on an open
file and uses that to queue a single IO.

--D

> 
> Cheers,
> 
> 					- Ted
> 

