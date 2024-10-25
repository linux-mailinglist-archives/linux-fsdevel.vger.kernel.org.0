Return-Path: <linux-fsdevel+bounces-32908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AD9B095D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C2D280DEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158031865E7;
	Fri, 25 Oct 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbxenkET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A521A4AA;
	Fri, 25 Oct 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872692; cv=none; b=gBaYKnx8o7rI6vR5RIkFeg0jdiQunBvZ6W3wF/DFhqO1ven/dD8XadwLrvmBuqtuzwZG/wntMXkcaDnuZWBN8KDCG+39bDff5o4QOCkl1M3KIEBKrlRUTQn3riJkYVlqvujCoOj2LFUohiQffwiEJzUZCEj0JtkcHJY/Zo7glVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872692; c=relaxed/simple;
	bh=RseRiHUC42HLSCp27J/DRr2aifRRP4Q+wScoHuoDK8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q53fSOOh3lJJOmt2yE/8jkRjTNwZa0EuVy/Wg/Gkl7uzJHuyQhFq/VZ4UySJpmiVQNZiBRCROmeiD/CXq5sJ05nL+OjNdNNyElTEXFKuaKRBYwO6FIGOt2P5dT0QBhYyeIetKec5O3KI9aCHI5/SyV/AILxTDfVpSQSgrjqYqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbxenkET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F7C4CEC3;
	Fri, 25 Oct 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872691;
	bh=RseRiHUC42HLSCp27J/DRr2aifRRP4Q+wScoHuoDK8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbxenkET/CvR4cdxA1G9MWctFObj2H5JqW4fMFx0iXOFt8dHSlL8zd8icZOQ0lDB5
	 zRe60XcuULd3daQfd8X/v9Hguge8v48+GcB6zch4YRhZ5CcgFhkGTPMnjEw7tZ/a8E
	 jaUGjeeLoGDlmMtnVA1G2eCIY6w5/tLOsu2524FXp/RUhQOP7CzGzSQVqDTF4U+Uyu
	 6rP24/7dI0lK29KNMTPVI4njPaCWNa5JfNcUDmIDzZnlsQIqe8mMNeKyb4rJV/J0kj
	 mddYAzs63WTl7lEbGG+0Dg6ZH8WeZD2cdjJKvYRO5dye+VeQ3CwgGVzkHGp5wDCfNN
	 xSNmxvr3cTlvQ==
Date: Fri, 25 Oct 2024 09:11:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: Check for atomic writes support in write iter
Message-ID: <20241025161131.GK2386201@frogsfrogsfrogs>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com>
 <b6f456bb-9998-4789-830d-45767dbbfdea@oracle.com>
 <87wmhwmq01.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmhwmq01.fsf@gmail.com>

On Fri, Oct 25, 2024 at 04:03:02PM +0530, Ritesh Harjani wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
> > On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
> >> Let's validate using generic_atomic_write_valid() in
> >> ext4_file_write_iter() if the write request has IOCB_ATOMIC set.
> >> 
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>   fs/ext4/file.c | 14 ++++++++++++++
> >>   1 file changed, 14 insertions(+)
> >> 
> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> >> index f14aed14b9cf..b06c5d34bbd2 100644
> >> --- a/fs/ext4/file.c
> >> +++ b/fs/ext4/file.c
> >> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >>   	if (IS_DAX(inode))
> >>   		return ext4_dax_write_iter(iocb, from);
> >>   #endif
> >> +
> >> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> >> +		size_t len = iov_iter_count(from);
> >> +		int ret;
> >> +
> >> +		if (!IS_ALIGNED(len, EXT4_SB(inode->i_sb)->fs_awu_min) ||
> >> +			len > EXT4_SB(inode->i_sb)->fs_awu_max)
> >> +			return -EINVAL;
> >
> > this looks ok, but the IS_ALIGNED() check looks odd. I am not sure why 
> > you don't just check that fs_awu_max >= len >= fs_awu_min
> >
> 
> I guess this was just a stricter check. But we anyways have power_of_2
> and other checks in generic_atomic_write_valid(). So it does not matter. 
> 
> I can change this in v2. 

Also please fix the weird indenting in the if test:

		if (len < EXT4_SB(inode->i_sb)->fs_awu_min) ||
		    len > EXT4_SB(inode->i_sb)->fs_awu_max)
			return -EINVAL;

--D

> Thanks!
> 
> >> +
> >> +		ret = generic_atomic_write_valid(iocb, from);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >>   	if (iocb->ki_flags & IOCB_DIRECT)
> >>   		return ext4_dio_write_iter(iocb, from);
> >>   	else
> 
> -ritesh
> 

