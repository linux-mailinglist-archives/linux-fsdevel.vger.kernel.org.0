Return-Path: <linux-fsdevel+bounces-51949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109DADDA9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48F51944AF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B32192F9;
	Tue, 17 Jun 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK1F6rLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56232FA639;
	Tue, 17 Jun 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180953; cv=none; b=lfpaUvRa5HzDXFewp1NzS6jPxwMqGSPBQ+GbFuNRvs2j8nfb+wxxNgRH5fthpwWuexlDYbTo5CshOlzcUplk7Uf4wylDTZOekFYrDRIihsL9y5e1i24ycWE8Gff3kamWi57E/XalIx5SF1c/ybOPpHrZV9nnUw6+qygT4a80mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180953; c=relaxed/simple;
	bh=ptptaPlm9YuIkQoCqJBz5PO9tK5IRtrYyFaQLRYOE/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvz/9MZ9HryRIa9HucXM5uVrz+JQn5Nis9C7j7aKPAlPO/Zs2rxn+evGp+0+BglEcpa0JVzmzMnCroCk8H6MbxFNfjj6386BSXmHUc/bX+RW7D387r343E7rzzBIzvvqRz7gPF2V3A2GjhO2/3WTFCTRdHjuOUNN0wgRNILBYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK1F6rLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098DC4CEE3;
	Tue, 17 Jun 2025 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750180953;
	bh=ptptaPlm9YuIkQoCqJBz5PO9tK5IRtrYyFaQLRYOE/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK1F6rLYvKIbdxnZsLRvLfF5SzlxD4MFy5Itr40W0vZYCzg/Nj9tujZEFa9dBvwxb
	 Gngxuz+7XyG3QOsT1OgBbQqy5YC0LseOEu48e/i4PdaIW3XjAq/EEwDS1UGhBreJh4
	 jWeuMBsi3Qc3EwDtZ6nV6RMDYlxwNB/ox3O6MNApbbMqv/qwS38AJZKUB59vAWI9sZ
	 KK0UPp39Tdmo1b1E6XrJasBpssBa/HUEGf4qpSFshpBHY/tQTTtzzSY+R7JPK3O+6B
	 LJb1Af7roOp3A/kYzmEFqIW6uO3pzuf4LML5rOdWkbTpkotPcUAmygWO43vQYZArhE
	 rzY0QspyeuupA==
Date: Tue, 17 Jun 2025 13:22:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	keith.mannthey@hammerspace.com
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aFGkV1ILAlmtpGVJ@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBB_txzX19E-96H@kernel.org>

On Mon, Jun 16, 2025 at 12:10:38PM -0400, Mike Snitzer wrote:
> On Mon, Jun 16, 2025 at 09:32:16AM -0400, Chuck Lever wrote:
> > On 6/12/25 12:00 PM, Mike Snitzer wrote:
> > > On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
> > >> On 6/11/25 3:18 PM, Mike Snitzer wrote:
> > >>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> > >>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > >>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> > >>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> > >>>>> or will be removed from the page cache upon completion (DONTCACHE).
> > >>>>
> > >>>> I thought we were going to do two switches: One for reads and one for
> > >>>> writes? I could be misremembering.
> > >>>
> > >>> We did discuss the possibility of doing that.  Still can-do if that's
> > >>> what you'd prefer.
> > >>
> > >> For our experimental interface, I think having read and write enablement
> > >> as separate settings is wise, so please do that.
> > >>
> > >> One quibble, though: The name "enable_dontcache" might be directly
> > >> meaningful to you, but I think others might find "enable_dont" to be
> > >> oxymoronic. And, it ties the setting to a specific kernel technology:
> > >> RWF_DONTCACHE.
> > >>
> > >> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
> > >>
> > >> They could each carry multiple settings:
> > >>
> > >> 0: Use page cache
> > >> 1: Use RWF_DONTCACHE
> > >> 2: Use O_DIRECT
> > >>
> > >> You can choose to implement any or all of the above three mechanisms.
> > > 
> > > I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.
> > 
> > For io_cache_read, either settings 1 and 2 need to set
> > disable_splice_read, or the io_cache_read setting has to be considered
> > by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
> > splice read.
> 
> Yes, I understand.
>  
> > However, it would be slightly nicer if we could decide whether splice
> > read can be removed /before/ this series is merged. Can you get NFSD
> > tested with IOR with disable_splice_read both enabled and disabled (no
> > direct I/O)? Then we can compare the results to ensure that there is no
> > negative performance impact for removing the splice read code.
> 
> I can ask if we have a small window of opportunity to get this tested,
> will let you know if so.
> 

I was able to enlist the help of Keith (cc'd) to get some runs in to
compare splice_read vs vectored read.  A picture is worth 1000 words:
https://original.art/NFSD_splice_vs_buffered_read_IOR_EASY.jpg

Left side is with splice_read running IOR_EASY with 48, 64, 96 PPN
(Processes Per Node on each client) respectively.  Then the same
IOR_EASY workload progression for buffered IO on the right side.

6x servers with 1TB memory and 48 cpus, each configured with 32 NFSD
threads, with CPU pinning and 4M Read Ahead. 6x clients running IOR_EASY. 

This was Keith's take on splice_read's benefits:
- Is overall faster than buffered at any PPN.
- Is able to scale higher with PPN (whereas buffered is flat).
- Safe to say splice_read allows NFSD to do more IO then standard
  buffered.

(These results came _after_ I did the patch to remove all the
splice_read related code from NFSD and SUNRPC.. while cathartic, alas
it seems it isn't meant to be at this point.  I'll let you do the
honors in the future if/when you deem splice_read worthy of removal.)

Mike

