Return-Path: <linux-fsdevel+bounces-44667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07FDA6B321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 04:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BA218906B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 03:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42F1E0E0C;
	Fri, 21 Mar 2025 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syXon8Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8433F6;
	Fri, 21 Mar 2025 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742526327; cv=none; b=WB6Z88sHrN26xdWUwFBMZc2emT0g0+J6gqiOmYvdxqMa6T9EhZqtmv3N9h0igsDVoOMkFa3wHCo79V3ymTvLr0ELCb8i/eEOL8UF5/kBxp/xPi/qcPoVKUlR7Rc13bguVj1bRmW5MvQo163aOzMxs+5ECGJzK3DRiPcw9UCIcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742526327; c=relaxed/simple;
	bh=eSNizQvwTtixUL1Hx9p4KwZhPdnWQFaJAuDisKJWEDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3lUO9Jy6Miepl1XxbdZwBj9uAd839QqDt15Zp6zZGj0RMc+QIN2LkSL4qYNodTbVmB3t8ZxB9Y1KKuxd+kbcSabJxVbq0YIcb3LB1HURpPELVjxwFFM5dfgqdKFKki4ZwsDH8qCzkszwGAnyc5F3YUyLf0PFdiD72Zf9zfRMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syXon8Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C788FC4CEDD;
	Fri, 21 Mar 2025 03:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742526326;
	bh=eSNizQvwTtixUL1Hx9p4KwZhPdnWQFaJAuDisKJWEDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syXon8Ls2j9bn40xp2X6juSK6lv9GOm/aQxwH/SQoVRyaV7IF3jd6s+dTL3T9lWdU
	 9xp2GGFQPhMMBNQOYdEc22zmq5Dekq029JeOrwtZmONPE+zdyooS7t6vczvqUif/Ka
	 MkYodVo9Wrr15yflut/Z72lbHyRslr5/M8m6hF2Tk+IvH0gpaf4hHpKnGaRummT2Xu
	 USyvfhyi1pBFW4GzDIRZFM0b4fzDgp98vXKjKOGqA2fERiAqB97HNdy0CezvfuIhOa
	 4MXVHxkza69miim95JF4illwQX8uti+xpDmObBp6a6Oau7/deBcNMWuRzXxLsbGKi2
	 e+Z7bfP2wEMoA==
Date: Thu, 20 Mar 2025 20:05:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
	gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250321030526.GW89034@frogsfrogsfrogs>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
 <20250320213034.GG2803730@frogsfrogsfrogs>
 <87jz8jrv0q.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz8jrv0q.fsf@gmail.com>

On Fri, Mar 21, 2025 at 07:43:09AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Fri, Mar 21, 2025 at 12:16:28AM +0530, Ritesh Harjani wrote:
> >> Luis Chamberlain <mcgrof@kernel.org> writes:
> >> 
> >> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> >> > This is due to the number of DMA segments and the segment size. With LBS the
> >> > segments can be much bigger without using huge pages, and so on a 64 KiB
> >> > block size filesystem you can now see 2 MiB IOs when using buffered IO.
> >> > But direct IO is still crippled, because allocations are from anonymous
> >> > memory, and unless you are using mTHP you won't get large folios. mTHP
> >> > is also non-deterministic, and so you end up in a worse situation for
> >> > direct IO if you want to rely on large folios, as you may *sometimes*
> >> > end up with large folios and sometimes you might not. IO patterns can
> >> > therefore be erratic.
> >> >
> >> > As I just posted in a simple RFC [0], I believe the two step DMA API
> >> > helps resolve this.  Provided we move the block integrity stuff to the
> >> > new DMA API as well, the only patches really needed to support larger
> >> > IOs for direct IO for NVMe are:
> >> >
> >> >   iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
> >> >   blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
> >> 
> >> Maybe some naive questions, however I would like some help from people
> >> who could confirm if my understanding here is correct or not.
> >> 
> >> Given that we now support large folios in buffered I/O directly on raw
> >> block devices, applications must carefully serialize direct I/O and
> >> buffered I/O operations on these devices, right?
> >> 
> >> IIUC. until now, mixing buffered I/O and direct I/O (for doing I/O on
> >> /dev/xxx) on separate boundaries (blocksize == pagesize) worked fine,
> >> since direct I/O would only invalidate its corresponding page in the
> >> page cache. This assumes that both direct I/O and buffered I/O use the
> >> same blocksize and pagesize (e.g. both using 4K or both using 64K).
> >> However with large folios now introduced in the buffered I/O path for
> >> block devices, direct I/O may end up invalidating an entire large folio,
> >> which could span across a region where an ongoing direct I/O operation
> >
> > I don't understand the question.  Should this read  ^^^ "buffered"?
> 
> oops, yes.
> 
> > As in, directio submits its write bio, meanwhile another thread
> > initiates a buffered write nearby, the write gets a 2MB folio, and
> > then the post-write invalidation knocks down the entire large folio?
> > Even though the two ranges written are (say) 256k apart?
> >
> 
> Yes, Darrick. That is my question. 
> 
> i.e. w/o large folios in block devices one could do direct-io &
> buffered-io in parallel even just next to each other (assuming 4k pagesize). 
> 
>            |4k-direct-io | 4k-buffered-io | 
> 
> 
> However with large folios now supported in buffered-io path for block
> devices, the application cannot submit such direct-io + buffered-io
> pattern in parallel. Since direct-io can end up invalidating the folio
> spanning over it's 4k range, on which buffered-io is in progress.
> 
> So now applications need to be careful to not submit any direct-io &
> buffered-io in parallel with such above patterns on a raw block device,
> correct? That is what I would like to confirm.

I think that's correct, and kind of horrifying if true.  I wonder if
->invalidate_folio might be a reasonable way to clear the uptodate bits
on the relevant parts of a large folio without having to split or remove
it?

--D

> > --D
> >
> >> is taking place. That means, with large folio support in block devices,
> >> application developers must now ensure that direct I/O and buffered I/O
> >> operations on block devices are properly serialized, correct?
> >> 
> >> I was looking at posix page [1] and I don't think posix standard defines
> >> the semantics for operations on block devices. So it is really upto the
> >> individual OS implementation, correct? 
> >> 
> >> And IIUC, what Linux recommends is to never mix any kind of direct-io
> >> and buffered-io when doing I/O on raw block devices, but I cannot find
> >> this recommendation in any Documentation? So can someone please point me
> >> one where we recommend this?
> 
> And this ^^^ 
> 
> 
> -ritesh
> 
> >> 
> >> [1]: https://pubs.opengroup.org/onlinepubs/9799919799/
> >> 
> >> 
> >> -ritesh
> >> 
> >> >
> >> > The other two nvme-pci patches in that series are to just help with
> >> > experimentation now and they can be ignored.
> >> >
> >> > It does beg a few questions:
> >> >
> >> >  - How are we computing the new max single IO anyway? Are we really
> >> >    bounded only by what devices support?
> >> >  - Do we believe this is the step in the right direction?
> >> >  - Is 2 MiB a sensible max block sector size limit for the next few years?
> >> >  - What other considerations should we have?
> >> >  - Do we want something more deterministic for large folios for direct IO?
> >> >
> >> > [0] https://lkml.kernel.org/r/20250320111328.2841690-1-mcgrof@kernel.org
> >> >
> >> >   Luis
> >> 

