Return-Path: <linux-fsdevel+bounces-55647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C7B0D2D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0117F7AE7B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551542D29C7;
	Tue, 22 Jul 2025 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxoeHQTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB62BF015;
	Tue, 22 Jul 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169079; cv=none; b=MT75Lhj/h9EskBFD6Ih3vWTIQk1Xt7ji9dCaSzEHG+DXrbK+K0eP6wvNcCi2cUXFW9EiAZVJGQq3mgvHckRIHlJ7jP3W5W93y3bemi/sFkuy/8NJwwyJdPuXifjChyy0cYfoIX29E0f2U1O+PV8/RW5zhTB52bwc1jqRUA5V+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169079; c=relaxed/simple;
	bh=+Gt5hHL8vsJF557nqKxPeraB+jDGTIGJbmdALX74w+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE7JOwjKVZfbeRYap4yHSl3xOZDug9R6mdG9/vuT8UMpc2Vvk2G19ccUM65K3BA5rPOhVVVMr3P4oU8BZt3vgbt7yMmB90V98T441kuVJOg+Uyn4RJSIEXNvk9B40Z3l3NjJGFKJgpVfgUUbCLf24NgS5GC4kFxcnwdEKyxNH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxoeHQTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD00C4CEEB;
	Tue, 22 Jul 2025 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753169079;
	bh=+Gt5hHL8vsJF557nqKxPeraB+jDGTIGJbmdALX74w+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vxoeHQTlL35niXbDoAKxUJjOUh031FdFVUqPxnrZxBQWG9rgpDPgRipAePBa/Y9NO
	 J99hZmXLd3FYktHC+ESNiZkTgaGi3Ol4CyUlod3527XwLeUbU+JznS/Z5xpAFokWCD
	 d0IwAk7rcaBsWk/EfuvrN8y2Oa+pUpJPlPKgr+Gg=
Date: Tue, 22 Jul 2025 09:24:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kernel@collabora.com, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: Excessive page cache occupies DMA32 memory
Message-ID: <2025072234-cork-unadvised-24d3@gregkh>
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
 <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
 <2025072238-unplanted-movable-7dfb@gregkh>
 <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com>

On Tue, Jul 22, 2025 at 11:05:11AM +0500, Muhammad Usama Anjum wrote:
> Adding ath/mhi and dma API developers to the discussion.
> 
> On 7/22/25 10:32 AM, Greg KH wrote:
> > On Mon, Jul 21, 2025 at 06:13:10PM +0100, Matthew Wilcox wrote:
> >> On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
> >>> Hello,
> >>>
> >>> When 10-12GB our of total 16GB RAM is being used as page cache
> >>> (active_file + inactive_file) at suspend time, the drivers fail to allocate
> >>> dma memory at resume as dma memory is either occupied by the page cache or
> >>> fragmented. Example:
> >>>
> >>> kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> >>
> >> Just to be clear, this is not a page cache problem.  The driver is asking
> >> us to do a 512kB allocation without doing I/O!  This is a ridiculous
> >> request that should be expected to fail.
> >>
> >> The solution, whatever it may be, is not related to the page cache.
> >> I reject your diagnosis.  Almost all of the page cache is clean and
> >> could be dropped (as far as I can tell from the output below).
> >>
> >> Now, I'm not too familiar with how the page allocator chooses to fail
> >> this request.  Maybe it should be trying harder to drop bits of the page
> >> cache.  Maybe it should be doing some compaction. 
> That's very thoughtful. I'll look at the page allocator why isn't it dropping
> cache or doing compaction.
> 
> >> I am not inclined to
> >> go digging on your behalf, because frankly I'm offended by the suggestion
> >> that the page cache is at fault.
> I apologize—that wasn't my intention.
> 
> >>
> >> Perhaps somebody else will help you, or you can dig into this yourself.
> > 
> > I'm with Matthew, this really looks like a driver bug somehow.  If there
> > is page cache memory that is "clean", the driver should be able to
> > access it just fine if really required.
> > 
> > What exact driver(s) is having this problem?  What is the exact error,
> > and on what lines of code?
> The issue occurs on both ath11k and mhi drivers during resume, when
> dma_alloc_coherent(GFP_KERNEL) fails and returns -ENOMEM. This failure has
> been observed at multiple points in these drivers.
> 
> For example, in the mhi driver, the failure is triggered when the
> MHI's st_worker gets scheduled-in at resume.
> 
> mhi_pm_st_worker()
> -> mhi_fw_load_handler()
>    -> mhi_load_image_bhi()
>       -> mhi_alloc_bhi_buffer()
>          -> dma_alloc_coherent(GFP_KERNEL) returns -ENOMEM

And what is the exact size you are asking for here?
What is the dma ops set to for your system?  Are you sure that is
working properly for your platform?  What platform is this exactly?

The driver isn't asking for DMA32 here, so that shouldn't be the issue,
so why do you feel it is?  Have you tried using the tracing stuff for
dma allocations to see exactly what is going on for this failure?

I think you need to do a bit more debugging :)

thanks,

greg k-h

