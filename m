Return-Path: <linux-fsdevel+bounces-17963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FAA8B4435
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 07:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E255B283B50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117D3F8ED;
	Sat, 27 Apr 2024 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/3L/32v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B7358A7;
	Sat, 27 Apr 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194319; cv=none; b=Lq75qs3UmgjMGCpWg/jXYR+6154Kt/dOZqrlcNSNmApA4W9nif/RbdcOn+to+b4+QK5Bb5NY7v1KMMwxyEtilJSTFyWO5k7SjDiFxLAJbQ8firgk0NOw8o+k0LSEDvtPdwPOrwb7+29aM9Lo79akRVgDiPFWCIg4B3suYFnMF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194319; c=relaxed/simple;
	bh=Pn09BqCdvGBpv9oyzNDTerZgLB2/sM1Oc/sK0a/sceA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0QFFh1RSLq2shJHxwpc6ZK7tfWmhZsXQSvopKxYj3vweUlX5E3Mqf0saPvNnHxObE7OLMMFKb6VvRZ3arkHib3x1kJD+0Tm6FlNb58wKom8+ghnb+1bv8L9lcUz915mlBZAlAjHAJwESZgFRIR92lZaj77VuZ/nClLY1V1UqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/3L/32v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B20C113CE;
	Sat, 27 Apr 2024 05:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714194318;
	bh=Pn09BqCdvGBpv9oyzNDTerZgLB2/sM1Oc/sK0a/sceA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/3L/32vgCHnYYhzIyzQIsZUl9VXAwaHmX1BhU5Z4GpgyHvNrONVpPJ5aNxAyKq3A
	 R1JcQ++zUGoYG4SQDRxm6YvNjksF8eQsqSaNebe4BzrGHsoFVawC/qDPyr7I49tX44
	 yK9OvxPjsAMH6xP1sNe8+c9rBNm3GwO8UzJ/aLFCXL9xTrJ7sZPT8tkeN4+h1T7FHf
	 2+NZnL+0qxtAT36Lk8YakS+Y8kphqBxNjpOXX4OyyiNjUSij9oQ0W3pVVCi2J578QC
	 G0MdmASHwjKW0NHMfABrcuSFByPhmFlrMUmTBUfJHQl/UmgzcSoYJ2tSJoRkdYOYQQ
	 iULwLzWScBHcw==
Date: Fri, 26 Apr 2024 22:05:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 00/11] enable bs > ps in XFS
Message-ID: <20240427050517.GC360898@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <87y18zxvpd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y18zxvpd.fsf@gmail.com>

On Sat, Apr 27, 2024 at 10:12:38AM +0530, Ritesh Harjani wrote:
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > This is the fourth version of the series that enables block size > page size
> > (Large Block Size) in XFS. The context and motivation can be seen in cover
> > letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
> > if someone would like more context on this effort.
> >
> > This series does not split a folio during truncation even though we have
> > an API to do so due to some issues with writeback. While it is not a
> > blocker, this feature can be added as a future improvement once we
> > get the base patches upstream (See patch 7).
> >
> > A lot of emphasis has been put on testing using kdevops. The testing has
> > been split into regression and progression.
> >
> > Regression testing:
> > In regression testing, we ran the whole test suite to check for
> > *regression on existing profiles due to the page cache changes.
> >
> > No regression was found with the patches added on top.
> >
> > Progression testing:
> > For progression testing, we tested for 8k, 16k, 32k and 64k block sizes.
> > To compare it with existing support, an ARM VM with 64k base page system
> > (without our patches) was used as a reference to check for actual failures
> > due to LBS support in a 4k base page size system.
> >
> > There are some tests that assumes block size < page size that needs to
> > be fixed. I have a tree with fixes for xfstests here [6], which I will be
> > sending soon to the list. Already a part of this has been upstreamed to
> > fstest.
> >
> > No new failures were found with the LBS support.
> 
> I just did portability testing by creating XFS with 16k bs on x86 VM (4k
> pagesize), created some files + checksums. I then moved the disk to
> Power VM with 64k pagesize and mounted this. I was able to mount and
> all the file checksums passed.
> 
> Then I did the vice versa, created a filesystem on Power VM with 64k
> blocksize and created 10 files with random data of 10MB each. I then
> hotplugged this device out from Power and plugged it into x86 VM and
> mounted it.
> 
> <Logs of the 2nd operation>
> ~# mount /dev/vdk /mnt1/
> [   35.145350] XFS (vdk): EXPERIMENTAL: Filesystem with Large Block Size (65536 bytes) enabled.
> [   35.149858] XFS (vdk): Mounting V5 Filesystem 91933a8b-1370-4931-97d1-c21213f31f8f
> [   35.227459] XFS (vdk): Ending clean mount
> [   35.235090] xfs filesystem being mounted at /mnt1 supports timestamps until 2038-01-19 (0x7fffffff)
> ~# cd /mnt1/
> ~# sha256sum -c checksums 
> file-1.img: OK
> file-2.img: OK
> file-3.img: OK
> file-4.img: OK
> file-5.img: OK
> file-6.img: OK
> file-7.img: OK
> file-8.img: OK
> file-9.img: OK
> file-10.img: OK
> 
> So thanks for this nice portability which this series offers :) 

Yessss this is awesome to see this coming together after many years!

--D

> -ritesh
> 
> 

