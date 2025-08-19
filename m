Return-Path: <linux-fsdevel+bounces-58303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184BB2C5F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51225A6305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5433EAFA;
	Tue, 19 Aug 2025 13:39:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F267262F;
	Tue, 19 Aug 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610779; cv=none; b=Km6qeqxdzjdtdegedYkKQCQ68RU6fhSGDV6DA+nr7MWA5vyB8Q/QdoeMzxk8jvxViU585Xdp5V4qDBmqLBUlaKbEUG6mKWG7l6kss9rZL9VPUDcWiHfqWxMvixBCsnGxYxslvTkDr6d89fnUGJRGAjipCBnO8ywEdHNOAw5ODcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610779; c=relaxed/simple;
	bh=1/4cIOt+U4/hlR420fqjfHC6lNwfpZSERDpwpJmgoEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU2ygLPRS5sOVpN7auUKim/X+sHdhLagHNseuyMHax+UYDdnRTgPM1rAQFiZLDXJXmMzS5I+E15bXRF+i6CqmWswpn3BSqeCGnYe1olHf7Cwu6DxDwNVo1Ztt7j3qiglll52c60ZMM1LFPGtjvPi3wGz9AkI7kPdkWZbYw5JUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6963E227A88; Tue, 19 Aug 2025 15:39:32 +0200 (CEST)
Date: Tue, 19 Aug 2025 15:39:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250819133932.GA16857@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com> <20250715090357.GA21818@lst.de> <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
> nothing has been happening on this thread for a while. I figure that it is 
> because we have no good or obvious options.
>
> I think that it's better deal with the NVMe driver handling of AWUPF first, 
> as this applies to block fops as well.
>
> As for the suggestion to have an opt-in to use AWUPF, you wrote above that 
> users may not know when to enable this opt-in or not.
>
> It seems to me that we can give the option, but clearly label that it is 
> potentially dangerous. Hopefully the $RANDOMUSER with the $CHEAPO SSD will 
> be wise and steer clear.
>
> If we always ignore AWUPF, I fear that lots of sound NVMe implementations 
> will be excluded from HW atomics.

I think ignoring AWUPF is a good idea, but I've also hard some folks
not liking that.

The reason why I prefer a mount option is because we add that to fstab
and the kernel command line easily.  For block layer or driver options
we'd either need a sysfs file which is always annoying to apply at boot
time, or a module option which has the downside of applying to all
devices.

