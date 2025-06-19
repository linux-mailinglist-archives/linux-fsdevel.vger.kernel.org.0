Return-Path: <linux-fsdevel+bounces-52259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F8AE0E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A8B1752E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AA25C83D;
	Thu, 19 Jun 2025 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci5qHial"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DD244683;
	Thu, 19 Jun 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364352; cv=none; b=YvqaXWqEMgKiPlU7Vjef1H0V03WDI5tOYd/AcWkafpiFTbyMNBIU8y3b8IOydE31r1hMd6/CqIpfycfCjlEdyJpRavWrdMRAd2BcsJE6M1X4s8REOa1NRAXaaba3rpOup/NzKZJ/u07x9k+N6ExNiNSk467XUtczOZjUQLcGOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364352; c=relaxed/simple;
	bh=huz2UMczg8KycFP6lJNwZ1nNyYb3Alqa+R1KMPTH7cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3qQpKBo9j9fpjz9ZHEMRByfQXZSNO6oK/axirSp1qvbm+4yxcRWQ5ig3YbA3v7n0vXAQC0P84R/105QI3kmi5wXHiXbQQ44/MHHb97u4ATEU2mG+VLluCXlhWENuUbKizf1keKNaYWny+RR2Rbg4HRyPC+Icb3/zc5K4JkZ7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci5qHial; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14476C4CEEA;
	Thu, 19 Jun 2025 20:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750364352;
	bh=huz2UMczg8KycFP6lJNwZ1nNyYb3Alqa+R1KMPTH7cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci5qHialCIABinU7TcPkhAA6qwXsiLD9LvTtWFk47gnufSYOH0fXohFmgsP/glhSZ
	 uSotxTyLyUv2Grr53eKnfjWanLjsn824uvtcTWeiTdacf9xgw1oUy+3j1waMGfAzFA
	 dZWgWY4QOki+YMn8rVqd/yq6arPpBM0BvrTRUIyN+NNsc0n7bmoAA5KKxjVdbpgjuY
	 dEwAtLbCXw+XtxUWTyISA7ixyksbcZAoLmpfXwp+XlqQsqdIly1r/oI7iv+EtahNMD
	 epAkG+2Zvt6hFF/vsfHIgxQuwFTmzNo/d9RZR3dru17QqfRLu6O25B/ZrP8ZccWbDY
	 RfTilqRmOGNWg==
Date: Thu, 19 Jun 2025 16:19:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	keith.mannthey@hammerspace.com
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aFRwvhM-wdQpTDin@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org>
 <aFGkV1ILAlmtpGVJ@kernel.org>
 <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>

On Tue, Jun 17, 2025 at 01:31:23PM -0400, Chuck Lever wrote:
> On 6/17/25 1:22 PM, Mike Snitzer wrote:
> > On Mon, Jun 16, 2025 at 12:10:38PM -0400, Mike Snitzer wrote:
> >> On Mon, Jun 16, 2025 at 09:32:16AM -0400, Chuck Lever wrote:
> >>> On 6/12/25 12:00 PM, Mike Snitzer wrote:
> >>>> On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
> >>>>> On 6/11/25 3:18 PM, Mike Snitzer wrote:
> >>>>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> >>>>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> >>>>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> >>>>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> >>>>>>>> or will be removed from the page cache upon completion (DONTCACHE).
> >>>>>>>
> >>>>>>> I thought we were going to do two switches: One for reads and one for
> >>>>>>> writes? I could be misremembering.
> >>>>>>
> >>>>>> We did discuss the possibility of doing that.  Still can-do if that's
> >>>>>> what you'd prefer.
> >>>>>
> >>>>> For our experimental interface, I think having read and write enablement
> >>>>> as separate settings is wise, so please do that.
> >>>>>
> >>>>> One quibble, though: The name "enable_dontcache" might be directly
> >>>>> meaningful to you, but I think others might find "enable_dont" to be
> >>>>> oxymoronic. And, it ties the setting to a specific kernel technology:
> >>>>> RWF_DONTCACHE.
> >>>>>
> >>>>> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
> >>>>>
> >>>>> They could each carry multiple settings:
> >>>>>
> >>>>> 0: Use page cache
> >>>>> 1: Use RWF_DONTCACHE
> >>>>> 2: Use O_DIRECT
> >>>>>
> >>>>> You can choose to implement any or all of the above three mechanisms.
> >>>>
> >>>> I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.
> >>>
> >>> For io_cache_read, either settings 1 and 2 need to set
> >>> disable_splice_read, or the io_cache_read setting has to be considered
> >>> by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
> >>> splice read.
> >>
> >> Yes, I understand.
> >>  
> >>> However, it would be slightly nicer if we could decide whether splice
> >>> read can be removed /before/ this series is merged. Can you get NFSD
> >>> tested with IOR with disable_splice_read both enabled and disabled (no
> >>> direct I/O)? Then we can compare the results to ensure that there is no
> >>> negative performance impact for removing the splice read code.
> >>
> >> I can ask if we have a small window of opportunity to get this tested,
> >> will let you know if so.
> >>
> > 
> > I was able to enlist the help of Keith (cc'd) to get some runs in to
> > compare splice_read vs vectored read.  A picture is worth 1000 words:
> > https://original.art/NFSD_splice_vs_buffered_read_IOR_EASY.jpg
> > 
> > Left side is with splice_read running IOR_EASY with 48, 64, 96 PPN
> > (Processes Per Node on each client) respectively.  Then the same
> > IOR_EASY workload progression for buffered IO on the right side.
> > 
> > 6x servers with 1TB memory and 48 cpus, each configured with 32 NFSD
> > threads, with CPU pinning and 4M Read Ahead. 6x clients running IOR_EASY. 
> > 
> > This was Keith's take on splice_read's benefits:
> > - Is overall faster than buffered at any PPN.
> > - Is able to scale higher with PPN (whereas buffered is flat).
> > - Safe to say splice_read allows NFSD to do more IO then standard
> >   buffered.
> 
> I thank you and Keith for the data!

You're welcome.
 
> > (These results came _after_ I did the patch to remove all the
> > splice_read related code from NFSD and SUNRPC.. while cathartic, alas
> > it seems it isn't meant to be at this point.  I'll let you do the
> > honors in the future if/when you deem splice_read worthy of removal.)
> 
> If we were to make all NFS READ operations use O_DIRECT, then of course
> NFSD's splice read should be removed at that point.

Yes, that makes sense.  I still need to try Christoph's idea (hope to
do so over next 24hrs):
https://lore.kernel.org/linux-nfs/aEu3o9imaQQF9vyg@infradead.org/

But for now, here is my latest NFSD O_DIRECT/DONTCACHE work, think of
the top 6 commits as a preview of what'll be v2 of this series:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing

