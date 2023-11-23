Return-Path: <linux-fsdevel+bounces-3503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224657F5750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 05:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA81C20CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E0BBA34;
	Thu, 23 Nov 2023 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW2DeccM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17DB658;
	Thu, 23 Nov 2023 04:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C3DC433C7;
	Thu, 23 Nov 2023 04:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700712585;
	bh=Bw7Y1tSIteesdKurZaVVowFevEIWL8qOrFUxj6OO8og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UW2DeccMXA1iij26Yvi2JJnQj5PBKI4wUmc+Wo2TqjqLkSTAJoR9Xnh56yOjNDZN1
	 kXuurynouJxCJRhg94PSRMJdC5nXhEG6iJ3608NPf+AoB5ylVojn4K94dbMpMj/o0V
	 ghyjBNb6DTKFnEAzZ+bBw9tU+guIl60Kn8DtuBRX3Jdrgf43S2tJt+OzfcJBb0T7Ol
	 MTGngPb+MluhGMf7JsdUtaLqvrK75cpC/lKjxqjhTUOkqE5LjbRC3MDVcih+envSuW
	 IlmR34h9evh8tH3YDmPy+MAld+VjlmlN23EXw8yhbtdHpJOhiBepNm6hRnbyEApgRE
	 wfF6tK92eg/pg==
Date: Wed, 22 Nov 2023 20:09:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231123040944.GB36168@frogsfrogsfrogs>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV6AJHd0jJ14unJn@dread.disaster.area>

On Thu, Nov 23, 2023 at 09:26:44AM +1100, Dave Chinner wrote:
> On Wed, Nov 22, 2023 at 05:11:18AM -0800, Christoph Hellwig wrote:
> > On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> > > writeback bit set. XFS plays the revalidation sequence counter games
> > > because of this so we'd have to do something similar for ext2. Not that I'd
> > > care as much about ext2 writeback performance but it should not be that
> > > hard and we'll definitely need some similar solution for ext4 anyway. Can
> > > you give that a try (as a followup "performance improvement" patch).
> > 
> > Darrick has mentioned that he is looking into lifting more of the
> > validation sequence counter validation into iomap.
> 
> I think that was me, as part of aligning the writeback path with
> the ->iomap_valid() checks in the write path after we lock the folio
> we instantiated for the write.
> 
> It's basically the same thing - once we have a locked folio, we have
> to check that the cached iomap is still valid before we use it for
> anything.
> 
> I need to find the time to get back to that, though.

Heh, we probably both have been chatting with willy on and off about
iomap.

The particular idea I had is to add a u64 counter to address_space that
we can bump in the same places where we bump xfs_inode_fork::if_seq
right now..  ->iomap_begin would sample this address_space::i_mappingseq
counter (with locks held), and now buffered writes and writeback can
check iomap::mappingseq == address_space::i_mappingseq to decide if it's
time to revalidate.

Anyway, I'll have time to go play with that (and further purging of
function pointers) next week or whenever is "after I put out v28 of
online repair".  ATM I have a rewrite of log intent recovery cooking
too, but that's going to need at least a week or two of recoveryloop
testing before I put that on the list.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

