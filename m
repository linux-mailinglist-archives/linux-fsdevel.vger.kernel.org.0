Return-Path: <linux-fsdevel+bounces-5043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A4807970
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158F11F2167F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A784B13C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNiL0HtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EF6EB64;
	Wed,  6 Dec 2023 18:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C18C433C7;
	Wed,  6 Dec 2023 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701888479;
	bh=+ti42Uy3LaDObl3C2cNA/it91T+eOi0j2YArak6KYyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNiL0HtDbCMJEgtw6xQk/Iypp0j8e/QsroWuZHB12LyrOYGCAc9pCPh2PJdmYILhu
	 Jc7b/ryZmrcof+TPY9lq9kWqOePGpieR3X4xcLY+O24MVM124XkfUychzNL+OHq9NW
	 uAyGYylocxT802Io2AMScXSvWcxH9V5GdouI4Qj0xY9cvsTRC+/YSQKxadYdBIxyOC
	 xjZrM98Y7KPh8QL5Tm2XDxdKiwwYtA/wVI0VhWLPV1jNABLQJdu6/6Zo1iMjLASyoW
	 gp2V90qAOmtvyUWWX0mSeo7p9Pl9Al8NIcYahHmJ7f7EJhstjwlnV31qT38eXvDiWc
	 hStumjTX/XYHg==
Date: Wed, 6 Dec 2023 10:47:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: fstests@vger.kernel.org, samba-technical@lists.samba.org,
	linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Dave Chinner <david@fromorbit.com>,
	Filipe Manana <fdmanana@suse.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Issues with FIEMAP, xfstests, Samba, ksmbd and CIFS
Message-ID: <20231206184759.GA3964019@frogsfrogsfrogs>
References: <447324.1701860432@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447324.1701860432@warthog.procyon.org.uk>

On Wed, Dec 06, 2023 at 11:00:32AM +0000, David Howells wrote:
> Hi,
> 
> I've been debugging apparent cifs failures with xfstests, in particular
> generic/009, and I'm finding that the tests are failing because FIEMAP is not
> returning exactly the expected extent map.
> 
> The problem is that the FSCTL_QUERY_ALLOCATED_RANGES smb RPC op can only
> return a list of ranges that are allocated and does not return any other
> information about those allocations or the gaps between them - and thus FIEMAP
> cannot express this information to the extent that the test expects.

<shrug> Perhaps that simply makes FSCTL_QUERY_ALLOCATED_RANGES -> FIEMAP
translation a poor choice?  FIEMAP doesn't have a way to say "written
status unknown".

> Further, as Steve also observed, the expectation that the individual subtests
> should return exactly those ranges is flawed.  The filesystem is at liberty to
> split extents, round up extents, bridge extents and automatically punch out
> blocks of zeros.  xfstests/common/punch allows for some of this, but I wonder
> if it needs to be more fuzzy.
> 
> I wonder if the best xfstests can be expected to check is that the data we
> have written is within the allocated regions.

I think the only expectation that generic/shared tests can have is that
file ranges they've written must not be reported as SEEK_HOLE.  The
ranges reported by SEEK_DATA must include the file ranges written by
application software, but the data ranges can be encompass more range
than that.

> Which brings me on to FALLOC_FL_ZERO_RANGE - is this guaranteed to result in
> an allocated region (if successful)?

Yes, that's the distinction between ZERO and PUNCH.

> Samba is translating FSCTL_SET_ZERO_DATA
> to FALLOC_FL_PUNCH_HOLE, as is ksmbd, and then there is no allocated range to

What does the FSCTL_SET_ZERO_DATA documentation say about the state of
the file range after a successful operation?

Oh.  Heh.  According to:
https://learn.microsoft.com/en-us/windows/win32/api/winioctl/ni-winioctl-fsctl_set_zero_data

"If you use the FSCTL_SET_ZERO_DATA control code to write zeros (0) to a
sparse file and the zero (0) region is large enough, the file system may
not allocate disk space.

"If you use the FSCTL_SET_ZERO_DATA control code to write zeros (0) to a
non-sparse file, zeros (0) are written to the file. The system allocates
disk storage for all of the zero (0) range, which is equivalent to using
the WriteFile function to write zeros (0) to a file.

> report back (Samba and ksmbd use SEEK_HOLE/SEEK_DATA rather than FIEMAP -
> would a ZERO_RANGE even show up with that?).

That depends on the local disk's implementation of lseek and ZERO_RANGE.

XFS, for example, implements ZERO_RANGE by unmapping the entire range
and then reallocating it with an unwritten extent.  There's no reason
why it couldn't also issue a WRITE_SAME to storage and change the
mapping state to written.  The user-visible behavior would be the same
(reads return zeroes, space is allocated).

However.  XFS' SEEK_DATA implementation (aka iomap's) skips over parts
of unwritten extents if there isn't a folio in the page cache.  If some
day the implementation were adjusted to do that WRITE_SAME thing I
mentioned, then SEEK_DATA would return the entire range as data
regardless of pagecache state.

This difference between SEEK_DATA and FIEMAP has led to data corruption
problems in the past, because unwritten extents as reported by FIEMAP
can have dirty page cache sitting around.  SEEK_DATA reports the dirty
pages as data; FIEMAP is silent.

> Finally, should the Linux cifs filesystem translate gaps in the result of
> FSCTL_QUERY_ALLOCATED_RANGES into 'unwritten' extents rather than leaving them
> as gaps in the list (to be reported as holes by xfs_io)?  This smacks a bit of
> adjusting things for the sake of making the testsuite work when the testsuite
> isn't quite compatible with the thing being tested.

That doesn't make sense to me.

> So:
> 
>  - Should Samba and ksmbd be using FALLOC_FL_ZERO_RANGE rather than
>    PUNCH_HOLE?

Probably depends on whether or not they present unix files as sparse or
non-sparse to Windows?

>  - Should Samba and ksmbd be using FIEMAP rather than SEEK_DATA/HOLE?

No.

>  - Should xfstests be less exacting in its FIEMAP analysis - or should this be
>    skipped for cifs?  I don't want to skip generic/009 as it checks some
>    corner cases that need testing, but it may not be possible to make the
>    exact extent matching work.

It's a big lift but I think the generic fstests need to be reworked to
FIEMAP-check only the file ranges that it actually wrote.  Those can't
be SEEK_HOLEs.

--D

> 
> Thanks,
> David
> 
> 
> 

