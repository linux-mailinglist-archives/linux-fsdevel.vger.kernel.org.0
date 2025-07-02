Return-Path: <linux-fsdevel+bounces-53715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC70AF61BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B61B4E401A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3972F7CF4;
	Wed,  2 Jul 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp9QE6jK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A12F7CE0;
	Wed,  2 Jul 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481793; cv=none; b=Sl6FaDd7DkNWFEhMdcHxXB2PRjW1/+6t9lX7yCWDNCf5rFapvcStwXw0VjuBqD6Cjf0Q/TXHylNexGXUpeyRVEME5bCNps+1IPsUccXRfdKforhoWDHxvQNwKGTVqC6IGcFThvz08ATFrgS5VGO7CDfwl4fmy0apqiq0ni8XAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481793; c=relaxed/simple;
	bh=vpOtYH6IkCc3Tvi53eKq06iBzA4VwoEL2AhoYmgnNLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSXyykV3JqOztuAMmb1t40AxCm/arimBW/GENDQS33eag5BgCXZ8v6dVw5rpTsbZ/6UHs7GFBwzyvj2001HUlp+qYkYIlmyGZ8J/NSsriken6t/dRMIIUPF9swjMGkGK5PGSqe6mBRnyz3A/cFtRgzi5SDhiAhCD8VGQfU+xdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp9QE6jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD3C4CEE7;
	Wed,  2 Jul 2025 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481793;
	bh=vpOtYH6IkCc3Tvi53eKq06iBzA4VwoEL2AhoYmgnNLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp9QE6jKoqnYehysrCVztxiyxSSHiGRnDH2Qhtx4fs8y0HsxQX6vvecQV5NOGuHd4
	 dN2C6Jg3iGlANnZCYd4TlAb9AWyMUFxItiOlq14SkSb91ODq8+5/1l1z2B1I3OgjYW
	 F0wVh5fyeadMA5Q1lsag3eS/QqfUasaa5xBk5yWNbHmtJKsxYOJKT2d2dv28g5FNoo
	 WZ1cAUj7G/l+tnyaZvpQoZ6hGpnmRaPA9IGCEEQlaIW44anDrsRjt8iNgxeXLUpnQX
	 3pwwQRHFlotk675GVhzntEDmVsQcndnhIRwdVp8CN2Kh9DCG3T+y4FCBorxXXeIfML
	 gMcEnPfgASDQA==
Date: Wed, 2 Jul 2025 11:43:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, willy@infradead.org,
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250702184312.GC9991@frogsfrogsfrogs>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com>
 <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
 <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>

On Wed, Jun 25, 2025 at 09:14:51PM +0530, Kundan Kumar wrote:
> >
> > Makes sense.  It would be good to test this on a non-SMP machine, if
> > you can find one ;)
> >
> 
> Tested with kernel cmdline with maxcpus=1. The parallel writeback falls
> back to 1 thread behavior, showing nochange in BW.
> 
>   - On PMEM:
>     Base XFS        : 70.7 MiB/s
>     Parallel Writeback XFS    : 70.5 MiB/s
>     Base EXT4        : 137 MiB/s
>     Parallel Writeback EXT4    : 138 MiB/s
> 
>   - On NVMe:
>     Base XFS        : 45.2 MiB/s
>     Parallel Writeback XFS    : 44.5 MiB/s
>     Base EXT4        : 81.2 MiB/s
>     Parallel Writeback EXT4    : 80.1 MiB/s
> 
> >
> > Please test the performance on spinning disks, and with more filesystems?
> >
> 
> On a spinning disk, random IO bandwidth remains unchanged, while sequential
> IO performance declines. However, setting nr_wb_ctx = 1 via configurable
> writeback(planned in next version) eliminates the decline.
> 
> echo 1 > /sys/class/bdi/8:16/nwritebacks
> 
> We can fetch the device queue's rotational property and allocate BDI with
> nr_wb_ctx = 1 for rotational disks. Hope this is a viable solution for
> spinning disks?

Sounds good to me, spinning rust isn't known for iops.

Though: What about a raid0 of spinning rust?  Do you see the same
declines for sequential IO?

--D

>   - Random IO
>     Base XFS        : 22.6 MiB/s
>     Parallel Writeback XFS    : 22.9 MiB/s
>     Base EXT4        : 22.5 MiB/s
>     Parallel Writeback EXT4    : 20.9 MiB/s
> 
>   - Sequential IO
>     Base XFS        : 156 MiB/s
>     Parallel Writeback XFS    : 133 MiB/s (-14.7%)
>     Base EXT4        : 147 MiB/s
>     Parallel Writeback EXT4    : 124 MiB/s (-15.6%)
> 
> -Kundan
> 

