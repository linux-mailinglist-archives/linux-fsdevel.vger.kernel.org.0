Return-Path: <linux-fsdevel+bounces-44649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4CA6AFD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F401897240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9D22170A;
	Thu, 20 Mar 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzV8meK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA574BED;
	Thu, 20 Mar 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506235; cv=none; b=mWFXkmPBTyHjHMOn/qHdEghsE8+9gyPd/ZVgAu5e3CnLSCg9oE6DWD3QWH5IP6yLo+hn4dGzHidSCRleK2nrbhkbknt9LHOX50xusylL7NTXAc5eog3/A6NHRKj8/pJNFc5/X+Uw0YtwGj37OeFuO0oqcOgW0NDZKX830G/wPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506235; c=relaxed/simple;
	bh=CgP4k9ANcDRlennigDXlxcwKnu1yZe66xO2hywmqiCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0nyzlPqJPqCeCnzLFcUn9Lvj85iBKVevzEEkihXeBiEemkDtSrD7xPJxPfYif+UV2e2VD73rLVXhK9xHx83706M1cLn2YNRRmR4VlWP9U+wdS4VD2GF9AbPr+pEDmFLffO2HLgyZ0rT2BJU7tycsLjZNLfibs20nUmDWU6nRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzV8meK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB52C4CEDD;
	Thu, 20 Mar 2025 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506234;
	bh=CgP4k9ANcDRlennigDXlxcwKnu1yZe66xO2hywmqiCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzV8meK9/w+yYwh3ZBWM8Gffl7+cYsZkDptGBNJtxYtbcsK3/i5Dl5EyWG+TzDlIg
	 tJiMr3QwOx03nB7BN41036DgwHAgN+ZzX7x58hu6US40VQkjWuLw3yXoOAW4K8+EOw
	 XUJP8YrxETf3DYBnPR1Ew6s42+VSEG0svtfui2gWYicr/SQ7g+zVfF+BM+KLlI7sTP
	 C2jdAVaoCv4y83XHvlq2+YO9Mmd1IZsfB5Y58iB/iQSu+8006NOXV5VLJUfNyHimyh
	 sej5PtejGRksl0YRmHSUQIuygNw1DsYYDneN35uwXk0leAae0ejqZFddwSKkWTXOsD
	 sqbgLXqiFBfhA==
Date: Thu, 20 Mar 2025 14:30:34 -0700
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
Message-ID: <20250320213034.GG2803730@frogsfrogsfrogs>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6xvsfp7.fsf@gmail.com>

On Fri, Mar 21, 2025 at 12:16:28AM +0530, Ritesh Harjani wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> > This is due to the number of DMA segments and the segment size. With LBS the
> > segments can be much bigger without using huge pages, and so on a 64 KiB
> > block size filesystem you can now see 2 MiB IOs when using buffered IO.
> > But direct IO is still crippled, because allocations are from anonymous
> > memory, and unless you are using mTHP you won't get large folios. mTHP
> > is also non-deterministic, and so you end up in a worse situation for
> > direct IO if you want to rely on large folios, as you may *sometimes*
> > end up with large folios and sometimes you might not. IO patterns can
> > therefore be erratic.
> >
> > As I just posted in a simple RFC [0], I believe the two step DMA API
> > helps resolve this.  Provided we move the block integrity stuff to the
> > new DMA API as well, the only patches really needed to support larger
> > IOs for direct IO for NVMe are:
> >
> >   iomap: use BLK_MAX_BLOCK_SIZE for the iomap zero page
> >   blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
> 
> Maybe some naive questions, however I would like some help from people
> who could confirm if my understanding here is correct or not.
> 
> Given that we now support large folios in buffered I/O directly on raw
> block devices, applications must carefully serialize direct I/O and
> buffered I/O operations on these devices, right?
> 
> IIUC. until now, mixing buffered I/O and direct I/O (for doing I/O on
> /dev/xxx) on separate boundaries (blocksize == pagesize) worked fine,
> since direct I/O would only invalidate its corresponding page in the
> page cache. This assumes that both direct I/O and buffered I/O use the
> same blocksize and pagesize (e.g. both using 4K or both using 64K).
> However with large folios now introduced in the buffered I/O path for
> block devices, direct I/O may end up invalidating an entire large folio,
> which could span across a region where an ongoing direct I/O operation

I don't understand the question.  Should this read  ^^^ "buffered"?
As in, directio submits its write bio, meanwhile another thread
initiates a buffered write nearby, the write gets a 2MB folio, and
then the post-write invalidation knocks down the entire large folio?
Even though the two ranges written are (say) 256k apart?

--D

> is taking place. That means, with large folio support in block devices,
> application developers must now ensure that direct I/O and buffered I/O
> operations on block devices are properly serialized, correct?
> 
> I was looking at posix page [1] and I don't think posix standard defines
> the semantics for operations on block devices. So it is really upto the
> individual OS implementation, correct? 
> 
> And IIUC, what Linux recommends is to never mix any kind of direct-io
> and buffered-io when doing I/O on raw block devices, but I cannot find
> this recommendation in any Documentation? So can someone please point me
> one where we recommend this?
> 
> [1]: https://pubs.opengroup.org/onlinepubs/9799919799/
> 
> 
> -ritesh
> 
> >
> > The other two nvme-pci patches in that series are to just help with
> > experimentation now and they can be ignored.
> >
> > It does beg a few questions:
> >
> >  - How are we computing the new max single IO anyway? Are we really
> >    bounded only by what devices support?
> >  - Do we believe this is the step in the right direction?
> >  - Is 2 MiB a sensible max block sector size limit for the next few years?
> >  - What other considerations should we have?
> >  - Do we want something more deterministic for large folios for direct IO?
> >
> > [0] https://lkml.kernel.org/r/20250320111328.2841690-1-mcgrof@kernel.org
> >
> >   Luis
> 

